Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 783BF125565
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 22:56:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 28F524AEC9;
	Wed, 18 Dec 2019 16:56:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FlrOJgpPfQ5M; Wed, 18 Dec 2019 16:56:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E0834AF1E;
	Wed, 18 Dec 2019 16:56:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 94B264AF02
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:56:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 66ZdepQurYG3 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 16:56:03 -0500 (EST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id ACA0E4ACBA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:55:51 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 13:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="222108183"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 13:55:51 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 41/45] KVM: PPC: Move all vcpu init code into
 kvm_arch_vcpu_create()
Date: Wed, 18 Dec 2019 13:55:26 -0800
Message-Id: <20191218215530.2280-42-sean.j.christopherson@intel.com>
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

Fold init() into create() now that the two are called back-to-back by
common KVM code (kvm_vcpu_init() calls kvm_arch_vcpu_init() as its last
action, and kvm_vm_ioctl_create_vcpu() calls kvm_arch_vcpu_create()
immediately thereafter).  Rinse and repeat for kvm_arch_vcpu_uninit()
and kvm_arch_vcpu_destroy().  This paves the way for removing
kvm_arch_vcpu_{un}init() entirely.

Note, calling kvmppc_mmu_destroy() if kvmppc_core_vcpu_create() fails
may or may not be necessary.  Move it along with the more obvious call
to kvmppc_subarch_vcpu_uninit() so as not to inadvertantly introduce a
functional change and/or bug.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/powerpc/kvm/powerpc.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index fce1b4776e55..91cf94d4191e 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -729,13 +729,29 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	int err;
 
-	err = kvmppc_core_vcpu_create(vcpu);
+	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	vcpu->arch.dec_timer.function = kvmppc_decrementer_wakeup;
+	vcpu->arch.dec_expires = get_tb();
+
+#ifdef CONFIG_KVM_EXIT_TIMING
+	mutex_init(&vcpu->arch.exit_timing_lock);
+#endif
+	err = kvmppc_subarch_vcpu_init(vcpu);
 	if (err)
 		return err;
 
+	err = kvmppc_core_vcpu_create(vcpu);
+	if (err)
+		goto out_vcpu_uninit;
+
 	vcpu->arch.wqp = &vcpu->wq;
 	kvmppc_create_vcpu_debugfs(vcpu, vcpu->vcpu_id);
 	return 0;
+
+out_vcpu_uninit:
+	kvmppc_mmu_destroy(vcpu);
+	kvmppc_subarch_vcpu_uninit(vcpu);
+	return err;
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
@@ -765,6 +781,9 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	}
 
 	kvmppc_core_vcpu_free(vcpu);
+
+	kvmppc_mmu_destroy(vcpu);
+	kvmppc_subarch_vcpu_uninit(vcpu);
 }
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
@@ -784,23 +803,12 @@ static enum hrtimer_restart kvmppc_decrementer_wakeup(struct hrtimer *timer)
 
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
-	int ret;
-
-	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	vcpu->arch.dec_timer.function = kvmppc_decrementer_wakeup;
-	vcpu->arch.dec_expires = get_tb();
-
-#ifdef CONFIG_KVM_EXIT_TIMING
-	mutex_init(&vcpu->arch.exit_timing_lock);
-#endif
-	ret = kvmppc_subarch_vcpu_init(vcpu);
-	return ret;
+	return 0;
 }
 
 void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
 {
-	kvmppc_mmu_destroy(vcpu);
-	kvmppc_subarch_vcpu_uninit(vcpu);
+
 }
 
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
