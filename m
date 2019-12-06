Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D329811569B
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 18:37:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 597354AF06;
	Fri,  6 Dec 2019 12:37:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id czaJI8Eimrl6; Fri,  6 Dec 2019 12:37:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B1884AEFF;
	Fri,  6 Dec 2019 12:37:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F0D114AECD
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 12:37:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AFRD3GlViha5 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 12:37:01 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB91D4A800
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 12:37:00 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A52431B;
 Fri,  6 Dec 2019 09:37:00 -0800 (PST)
Received: from [10.1.196.63] (e123195-lin.cambridge.arm.com [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E51A03F52E;
 Fri,  6 Dec 2019 09:36:58 -0800 (PST)
Subject: Re: [kvm-unit-tests RFC 01/10] arm64: Provide read/write_sysreg_s
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20191206172724.947-1-eric.auger@redhat.com>
 <20191206172724.947-2-eric.auger@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <efe2c571-1b69-5cc4-3505-24d092a9f985@arm.com>
Date: Fri, 6 Dec 2019 17:36:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191206172724.947-2-eric.auger@redhat.com>
Content-Language: en-US
Cc: andre.przywara@arm.com
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

Hi,

On 12/6/19 5:27 PM, Eric Auger wrote:
> From: Andrew Jones <drjones@redhat.com>
>
> Sometimes we need to test access to system registers which are
> missing assembler mnemonics.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  lib/arm64/asm/sysreg.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
> index a03830b..a45eebd 100644
> --- a/lib/arm64/asm/sysreg.h
> +++ b/lib/arm64/asm/sysreg.h
> @@ -38,6 +38,17 @@
>  	asm volatile("msr " xstr(r) ", %x0" : : "rZ" (__val));	\
>  } while (0)
>  
> +#define read_sysreg_s(r) ({					\
> +	u64 __val;						\
> +	asm volatile("mrs_s %0, " xstr(r) : "=r" (__val));	\
> +	__val;							\
> +})
> +
> +#define write_sysreg_s(v, r) do {				\
> +	u64 __val = (u64)v;					\
> +	asm volatile("msr_s " xstr(r) ", %x0" : : "rZ" (__val));\
> +} while (0)
> +
>  asm(
>  "	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
>  "	.equ	.L__reg_num_x\\num, \\num\n"

That's exactly the code that I wrote for my EL2 series :)

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,
Alex
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
