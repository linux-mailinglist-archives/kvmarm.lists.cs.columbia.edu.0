Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3C28125561
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 22:56:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 964464A576;
	Wed, 18 Dec 2019 16:56:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsEJW5UkBePM; Wed, 18 Dec 2019 16:56:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 249584AEDC;
	Wed, 18 Dec 2019 16:56:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AE0B4AEB9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:56:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U55zsFYhRW7t for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 16:56:02 -0500 (EST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 562C34AF17
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:55:49 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 13:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="222108161"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 13:55:48 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 36/45] KVM: PPC: BookE: Setup vcpu during
 kvmppc_core_vcpu_create()
Date: Wed, 18 Dec 2019 13:55:21 -0800
Message-Id: <20191218215530.2280-37-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218215530.2280-1-sean.j.christopherson@intel.com>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 linux-kernel@vger.kernel.org, Greg Kurz <groug@kaod.org>,
 linux-arm-kernel@lists.infradead.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
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

Fold setup() into create() now that the two are called back-to-back by
common KVM code.  This paves the way for removing kvm_arch_vcpu_setup().
Note, BookE directly implements kvm_arch_vcpu_setup() and PPC's common
kvm_arch_vcpu_create() is responsible for its own cleanup, thus the only
cleanup required when directly invoking kvmppc_core_vcpu_setup() is to
call .vcpu_free(), which is the BookE specific portion of PPC's
kvm_arch_vcpu_destroy() by way of kvmppc_core_vcpu_free().

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/powerpc/kvm/booke.c | 60 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index dd7440e50c7a..b1b5073a22b1 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1377,34 +1377,9 @@ static void kvmppc_set_tsr(struct kvm_vcpu *vcpu, u32 new_tsr)
 	update_timer_ints(vcpu);
 }
 
-/* Initial guest state: 16MB mapping 0 -> 0, PC = 0, MSR = 0, R1 = 16MB */
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	int i;
-	int r;
-
-	vcpu->arch.regs.nip = 0;
-	vcpu->arch.shared->pir = vcpu->vcpu_id;
-	kvmppc_set_gpr(vcpu, 1, (16<<20) - 8); /* -8 for the callee-save LR slot */
-	kvmppc_set_msr(vcpu, 0);
-
-#ifndef CONFIG_KVM_BOOKE_HV
-	vcpu->arch.shadow_msr = MSR_USER | MSR_IS | MSR_DS;
-	vcpu->arch.shadow_pid = 1;
-	vcpu->arch.shared->msr = 0;
-#endif
-
-	/* Eye-catching numbers so we know if the guest takes an interrupt
-	 * before it's programmed its own IVPR/IVORs. */
-	vcpu->arch.ivpr = 0x55550000;
-	for (i = 0; i < BOOKE_IRQPRIO_MAX; i++)
-		vcpu->arch.ivor[i] = 0x7700 | i * 4;
-
-	kvmppc_init_timing_stats(vcpu);
-
-	r = kvmppc_core_vcpu_setup(vcpu);
-	kvmppc_sanity_check(vcpu);
-	return r;
+	return 0;
 }
 
 int kvmppc_subarch_vcpu_init(struct kvm_vcpu *vcpu)
@@ -2116,7 +2091,38 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 
 int kvmppc_core_vcpu_create(struct kvm_vcpu *vcpu)
 {
-	return kvm->arch.kvm_ops->vcpu_create(vcpu);
+	int i;
+	int r;
+
+	r = kvm->arch.kvm_ops->vcpu_create(vcpu);
+	if (r)
+		return r;
+
+	/* Initial guest state: 16MB mapping 0 -> 0, PC = 0, MSR = 0, R1 = 16MB */
+	vcpu->arch.regs.nip = 0;
+	vcpu->arch.shared->pir = vcpu->vcpu_id;
+	kvmppc_set_gpr(vcpu, 1, (16<<20) - 8); /* -8 for the callee-save LR slot */
+	kvmppc_set_msr(vcpu, 0);
+
+#ifndef CONFIG_KVM_BOOKE_HV
+	vcpu->arch.shadow_msr = MSR_USER | MSR_IS | MSR_DS;
+	vcpu->arch.shadow_pid = 1;
+	vcpu->arch.shared->msr = 0;
+#endif
+
+	/* Eye-catching numbers so we know if the guest takes an interrupt
+	 * before it's programmed its own IVPR/IVORs. */
+	vcpu->arch.ivpr = 0x55550000;
+	for (i = 0; i < BOOKE_IRQPRIO_MAX; i++)
+		vcpu->arch.ivor[i] = 0x7700 | i * 4;
+
+	kvmppc_init_timing_stats(vcpu);
+
+	r = kvmppc_core_vcpu_setup(vcpu);
+	if (r)
+		vcpu->kvm->arch.kvm_ops->vcpu_free(vcpu);
+	kvmppc_sanity_check(vcpu);
+	return r;
 }
 
 void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
