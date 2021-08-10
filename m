Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0C3DA945
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 18:42:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DFFC4B0F4;
	Thu, 29 Jul 2021 12:42:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R79CCsjPjN-j; Thu, 29 Jul 2021 12:42:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD9DB4B0EC;
	Thu, 29 Jul 2021 12:42:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 663FF4B0E4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 12:42:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0ebtMNNKNlj for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Jul 2021 12:42:21 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 480DB4B0DF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 12:42:21 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CADD60EBD;
 Thu, 29 Jul 2021 16:42:18 +0000 (UTC)
Date: Thu, 29 Jul 2021 17:42:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Unregister HYP sections from kmemleak in
 protected mode
Message-ID: <20210729164214.GB31848@arm.com>
References: <20210729135016.3037277-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210729135016.3037277-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org, stable@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Jul 29, 2021 at 02:50:16PM +0100, Marc Zyngier wrote:
> Booting a KVM host in protected mode with kmemleak quickly results
> in a pretty bad crash, as kmemleak doesn't know that the HYP sections
> have been taken away.
> 
> Make the unregistration from kmemleak part of marking the sections
> as HYP-private. The rest of the HYP-specific data is obtained via
> the page allocator, which is not subjected to kmemleak.
> 
> Fixes: 90134ac9cabb ("KVM: arm64: Protect the .hyp sections from the host")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: stable@vger.kernel.org # 5.13
> ---
>  arch/arm64/kvm/arm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e9a2b8f27792..23f12e602878 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -15,6 +15,7 @@
>  #include <linux/fs.h>
>  #include <linux/mman.h>
>  #include <linux/sched.h>
> +#include <linux/kmemleak.h>
>  #include <linux/kvm.h>
>  #include <linux/kvm_irqfd.h>
>  #include <linux/irqbypass.h>
> @@ -1960,8 +1961,12 @@ static inline int pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
>  }
>  
>  #define pkvm_mark_hyp_section(__section)		\
> +({							\
> +	u64 sz = __section##_end - __section##_start;	\
> +	kmemleak_free_part(__section##_start, sz);	\
>  	pkvm_mark_hyp(__pa_symbol(__section##_start),	\
> -			__pa_symbol(__section##_end))
> +		      __pa_symbol(__section##_end));	\
> +})

Using kmemleak_free_part() is fine in principle as this is not a slab
object. However, the above would call the function even for ranges that
are not tracked at all by kmemleak (text, idmap). Luckily Kmemleak won't
complain, unless you #define DEBUG in the file (initially I tried to
warn all the time but I couldn't fix all the callbacks).

If it was just the BSS, I would move the kmemleak_free_part() call to
finalize_hyp_mode() but there's the __hyp_rodata section as well.

I think we have some inconsistency with .hyp.rodata which falls under
_sdata.._edata while the kernel's own .rodata goes immediately after
_etext. Should we move __hyp_rodata outside _sdata.._edata as well? It
would benefit from the RO NX marking (probably more useful without the
protected mode). If this works, we'd only need to call kmemleak once for
the BSS.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
