Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2B821454CE2
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 19:13:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 729E54B1A9;
	Wed, 17 Nov 2021 13:13:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MlchlPD88B1J; Wed, 17 Nov 2021 13:13:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BDF564B1A5;
	Wed, 17 Nov 2021 13:13:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 97FF54B187
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 13:13:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dT8-pevvIUob for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 13:13:40 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C9A2B4B133
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 13:13:40 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1DA261BC1;
 Wed, 17 Nov 2021 18:13:39 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mnPRB-0069CQ-WB; Wed, 17 Nov 2021 18:13:38 +0000
Date: Wed, 17 Nov 2021 18:13:37 +0000
Message-ID: <87pmqy7ir2.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 08/12] KVM: Propagate vcpu explicitly to
 mark_page_dirty_in_slot()
In-Reply-To: <20211117174003.297096-9-dwmw2@infradead.org>
References: <20211117174003.297096-1-dwmw2@infradead.org>
 <20211117174003.297096-9-dwmw2@infradead.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: dwmw2@infradead.org, pbonzini@redhat.com,
 kvm@vger.kernel.org, boris.ostrovsky@oracle.com, joao.m.martins@oracle.com,
 jmattson@google.com, wanpengli@tencent.com, seanjc@google.com,
 vkuznets@redhat.com, mtosatti@redhat.com, joro@8bytes.org, karahmed@amazon.com,
 james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 aleksandar.qemu.devel@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 anup.patel@wdc.com, borntraeger@de.ibm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Anup Patel <anup.patel@wdc.com>,
 "wanpengli @ tencent . com" <wanpengli@tencent.com>, kvm <kvm@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joao Martins <joao.m.martins@oracle.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, "joro @ 8bytes . org" <joro@8bytes.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, karahmed@amazon.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "jmattson @ google . com" <jmattson@google.com>,
 "mtosatti @ redhat . com" <mtosatti@redhat.com>, linux-mips@vger.kernel.org,
 kvm-riscv@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 "vkuznets @ redhat . com" <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
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

On Wed, 17 Nov 2021 17:39:59 +0000,
David Woodhouse <dwmw2@infradead.org> wrote:
> 
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The kvm_dirty_ring_get() function uses kvm_get_running_vcpu() to work out
> which dirty ring to use, but there are some use cases where that doesn't
> work.
> 
> There's one in setting the Xen shared info page, introduced in commit
> 629b5348841a ("KVM: x86/xen: update wallclock region") and reported by
> "butt3rflyh4ck" <butterflyhuangxx@gmail.com> in
> https://lore.kernel.org/kvm/CAFcO6XOmoS7EacN_n6v4Txk7xL7iqRa2gABg3F7E3Naf5uG94g@mail.gmail.com/
> 
> There's also about to be another one when the newly-reintroduced
> gfn_to_pfn_cache needs to mark a page as dirty from the MMU notifier
> which invalidates the mapping. In that case, we will *know* the vcpu
> that can be 'blamed' for dirtying the page, and we just need to be
> able to pass it in as an explicit argument when doing so.
> 
> This patch preemptively resolves the second issue, and paves the way
> for resolving the first. A complete fix for the first issue will need
> us to switch the Xen shinfo to be owned by a particular vCPU, which
> will happen in a separate patch.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/arm64/kvm/mmu.c           |  2 +-
>  arch/x86/kvm/mmu/mmu.c         |  2 +-
>  arch/x86/kvm/mmu/spte.c        |  2 +-
>  arch/x86/kvm/mmu/tdp_mmu.c     |  2 +-
>  arch/x86/kvm/x86.c             |  4 ++--
>  include/linux/kvm_dirty_ring.h |  6 ++++--
>  include/linux/kvm_host.h       |  3 ++-
>  virt/kvm/dirty_ring.c          |  8 ++++++--
>  virt/kvm/kvm_main.c            | 18 +++++++++---------
>  9 files changed, 27 insertions(+), 20 deletions(-)

What's the base for this series? This patch fails to compile for me
(at least on arm64), and the following patch doesn't apply on -rc1.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
