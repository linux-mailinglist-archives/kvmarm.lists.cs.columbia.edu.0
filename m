Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0F58D11EA2A
	for <lists+kvmarm@lfdr.de>; Fri, 13 Dec 2019 19:27:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8231B4AE8E;
	Fri, 13 Dec 2019 13:27:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YzqN3tNlDQfo; Fri, 13 Dec 2019 13:27:53 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52A974AEBB;
	Fri, 13 Dec 2019 13:27:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEE004AD09
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 13:27:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3eTRnH9-p-e for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Dec 2019 13:27:50 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C94804A535
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Dec 2019 13:27:50 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1ifpdD-0001O7-Ur; Fri, 13 Dec 2019 19:25:40 +0100
From: Marc Zyngier <maz@kernel.org>
To: 
Subject: [PATCH 0/7] KVM: arm/arm64: Help VMs dying quicker
Date: Fri, 13 Dec 2019 18:24:56 +0000
Message-Id: <20191213182503.14460-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, jhogan@kernel.org, paulus@ozlabs.org,
 pbonzini@redhat.com, rkrcmar@redhat.com, sean.j.christopherson@intel.com,
 vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
 joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm-ppc@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-mips@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paul Mackerras <paulus@ozlabs.org>, linux-arm-kernel@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

[Yes, the subject is deliberately provocative!]

Having recently played with large, memory intensive, and very short lived
VMs, I have realised that we spend a substantial amount of time cleaning up
when a VM has terminated.

It turns out that 99% of the overhead is due to the unnecessary cache
cleaning that we perform when pages get unmapped from Stage-2, which
only serves a single purpose: to make the page visible to a non-coherent
IO subsystem when the page is being swapped out.

It would make sense to drop these cache maintenance operations when
userspace is either unmapping a VMA or simply exiting. Detecting the
latter is easy, as KVM calls kvm_arch_flush_shadow_all(). The unmap
case is harder, or at least it was until 5.2 gained the MMU notifier
event, which allows subsystems to find out about the reason of an
change in the page tables.

And it turns out we can do even better: We can also avoid invalidating
individual page mappings if we're tearing down the VM altogether, and
replace it with a single TLBI VMALL, which will be much lighter on the
whole system (specially if your interconnect is a bit flimsy).

With the above, terminating a 64GB VM that has most of its memory
mapped at S2 goes from several seconds (I've seen up to 12s) to less
than a second on my D05. In general, multi-socket systems seem to
benefit from this more than single socket machines (based on a
non-representative sample of 4 random machines I have access to).

The first patch affects most architectures, as it changes one of the
core architecture hooks (in a fairly mechanical way). The rest is
definitely ARM-specific.

Marc Zyngier (7):
  KVM: Pass mmu_notifier_range down to kvm_unmap_hva_range()
  KVM: arm/arm64: Pass flags along Stage-2 unmapping functions
  KVM: arm/arm64: Condition cache maintenance on unmap with a flag
  KVM: arm/arm64: Condition TLB maintenance on unmap with a flag
  KVM: arm/arm64: Elide both CMOs and TBLIs on freeing the whole Stage-2
  KVM: arm/arm64: Elide CMOs when retrying a block mapping
  KVM: arm/arm64: Elide CMOs when unmapping a range

 arch/arm/include/asm/kvm_host.h     |  2 +-
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/mips/include/asm/kvm_host.h    |  2 +-
 arch/mips/kvm/mmu.c                 |  6 +-
 arch/powerpc/include/asm/kvm_host.h |  2 +-
 arch/powerpc/kvm/book3s.c           |  5 +-
 arch/powerpc/kvm/e500_mmu_host.c    |  4 +-
 arch/x86/include/asm/kvm_host.h     |  3 +-
 arch/x86/kvm/mmu/mmu.c              |  5 +-
 arch/x86/kvm/x86.c                  |  4 +-
 include/linux/kvm_host.h            |  2 +-
 virt/kvm/arm/mmu.c                  | 97 +++++++++++++++++++----------
 virt/kvm/kvm_main.c                 |  7 +--
 13 files changed, 88 insertions(+), 53 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
