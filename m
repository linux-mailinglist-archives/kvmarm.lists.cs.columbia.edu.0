Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD512552B
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 22:55:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9ED794A610;
	Wed, 18 Dec 2019 16:55:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8iOgcnZugyHW; Wed, 18 Dec 2019 16:55:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E4E344AECE;
	Wed, 18 Dec 2019 16:55:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EBD384A4A0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:55:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1cH502gcIH6y for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 16:55:38 -0500 (EST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 24B614AC87
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:55:36 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 13:55:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="222108034"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 13:55:34 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 07/45] KVM: x86: Allocate vcpu struct in common x86 code
Date: Wed, 18 Dec 2019 13:54:52 -0800
Message-Id: <20191218215530.2280-8-sean.j.christopherson@intel.com>
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

Move allocation of VMX and SVM vcpus to common x86.  Although the struct
being allocated is technically a VMX/SVM struct, it can be interpreted
directly as a 'struct kvm_vcpu' because of the pre-existing requirement
that 'struct kvm_vcpu' be located at offset zero of the arch/vendor vcpu
struct.

Remove the message from the build-time assertions regarding placement of
the struct, as compatibility with the arch usercopy region is no longer
the sole dependent on 'struct kvm_vcpu' being at offset zero.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/svm.c              | 28 +++++++++-------------------
 arch/x86/kvm/vmx/vmx.c          | 24 ++++++++----------------
 arch/x86/kvm/x86.c              | 16 ++++++++++++----
 4 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 159a28512e4c..dbc2aa055942 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1045,7 +1045,7 @@ struct kvm_x86_ops {
 	void (*vm_destroy)(struct kvm *kvm);
 
 	/* Create, but do not attach this VCPU */
-	struct kvm_vcpu *(*vcpu_create)(struct kvm *kvm, unsigned id);
+	int (*vcpu_create)(struct kvm *kvm, struct kvm_vcpu *vcpu, unsigned id);
 	void (*vcpu_free)(struct kvm_vcpu *vcpu);
 	void (*vcpu_reset)(struct kvm_vcpu *vcpu, bool init_event);
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1afa10cf365f..4a979278abba 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2144,9 +2144,9 @@ static int avic_init_vcpu(struct vcpu_svm *svm)
 	return ret;
 }
 
-static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
+static int svm_create_vcpu(struct kvm *kvm, struct kvm_vcpu *vcpu,
+			   unsigned int id)
 {
-	struct kvm_vcpu *vcpu;
 	struct vcpu_svm *svm;
 	struct page *page;
 	struct page *msrpm_pages;
@@ -2154,22 +2154,15 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
 	struct page *nested_msrpm_pages;
 	int err;
 
-	BUILD_BUG_ON_MSG(offsetof(struct vcpu_svm, vcpu) != 0,
-		"struct kvm_vcpu must be at offset 0 for arch usercopy region");
-
-	svm = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
-	if (!svm) {
-		err = -ENOMEM;
-		goto out;
-	}
-	vcpu = &svm->vcpu;
+	BUILD_BUG_ON(offsetof(struct vcpu_svm, vcpu) != 0);
+	svm = to_svm(vcpu);
 
 	vcpu->arch.user_fpu = kmem_cache_zalloc(x86_fpu_cache,
 						GFP_KERNEL_ACCOUNT);
 	if (!vcpu->arch.user_fpu) {
 		printk(KERN_ERR "kvm: failed to allocate kvm userspace's fpu\n");
 		err = -ENOMEM;
-		goto free_partial_svm;
+		goto out;
 	}
 
 	vcpu->arch.guest_fpu = kmem_cache_zalloc(x86_fpu_cache,
@@ -2182,7 +2175,7 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
 
 	err = kvm_vcpu_init(vcpu, kvm, id);
 	if (err)
-		goto free_svm;
+		goto free_guest_fpu;
 
 	err = -ENOMEM;
 	page = alloc_page(GFP_KERNEL_ACCOUNT);
@@ -2226,7 +2219,7 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
 
 	svm_init_osvw(vcpu);
 
-	return vcpu;
+	return 0;
 
 free_page4:
 	__free_page(hsave_page);
@@ -2238,14 +2231,12 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
 	__free_page(page);
 uninit:
 	kvm_vcpu_uninit(vcpu);
-free_svm:
+free_guest_fpu:
 	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
 free_user_fpu:
 	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
-free_partial_svm:
-	kmem_cache_free(kvm_vcpu_cache, svm);
 out:
-	return ERR_PTR(err);
+	return err;
 }
 
 static void svm_clear_current_vmcb(struct vmcb *vmcb)
@@ -2274,7 +2265,6 @@ static void svm_free_vcpu(struct kvm_vcpu *vcpu)
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
 	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
-	kmem_cache_free(kvm_vcpu_cache, svm);
 }
 
 static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5db455796965..44166309b66c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6675,31 +6675,24 @@ static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
 	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
-	kmem_cache_free(kvm_vcpu_cache, vmx);
 }
 
-static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
+static int vmx_create_vcpu(struct kvm *kvm, struct kvm_vcpu *vcpu,
+			   unsigned int id)
 {
-	struct kvm_vcpu *vcpu;
 	struct vcpu_vmx *vmx;
 	unsigned long *msr_bitmap;
 	int i, cpu, err;
 
-	BUILD_BUG_ON_MSG(offsetof(struct vcpu_vmx, vcpu) != 0,
-		"struct kvm_vcpu must be at offset 0 for arch usercopy region");
-
-	vmx = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
-	if (!vmx)
-		return ERR_PTR(-ENOMEM);
-
-	vcpu = &vmx->vcpu;
+	BUILD_BUG_ON(offsetof(struct vcpu_vmx, vcpu) != 0);
+	vmx = to_vmx(vcpu);
 
 	vcpu->arch.user_fpu = kmem_cache_zalloc(x86_fpu_cache,
 						GFP_KERNEL_ACCOUNT);
 	if (!vcpu->arch.user_fpu) {
 		printk(KERN_ERR "kvm: failed to allocate kvm userspace's fpu\n");
 		err = -ENOMEM;
-		goto free_partial_vcpu;
+		goto out;
 	}
 
 	vcpu->arch.guest_fpu = kmem_cache_zalloc(x86_fpu_cache,
@@ -6820,7 +6813,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 
 	vmx->ept_pointer = INVALID_PAGE;
 
-	return vcpu;
+	return 0;
 
 free_vmcs:
 	free_loaded_vmcs(vmx->loaded_vmcs);
@@ -6833,9 +6826,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
 free_user_fpu:
 	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
-free_partial_vcpu:
-	kmem_cache_free(kvm_vcpu_cache, vmx);
-	return ERR_PTR(err);
+out:
+	return err;
 }
 
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 82d41257d2a3..b7f565a43ad7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9091,26 +9091,34 @@ static void fx_init(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
 {
-	void *wbinvd_dirty_mask = vcpu->arch.wbinvd_dirty_mask;
-
 	kvmclock_reset(vcpu);
 
 	kvm_x86_ops->vcpu_free(vcpu);
-	free_cpumask_var(wbinvd_dirty_mask);
+
+	free_cpumask_var(vcpu->arch.wbinvd_dirty_mask);
+	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 						unsigned int id)
 {
 	struct kvm_vcpu *vcpu;
+	int r;
 
 	if (kvm_check_tsc_unstable() && atomic_read(&kvm->online_vcpus) != 0)
 		printk_once(KERN_WARNING
 		"kvm: SMP vm created on host with unstable TSC; "
 		"guest TSC will not be reliable\n");
 
-	vcpu = kvm_x86_ops->vcpu_create(kvm, id);
+	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
+	if (!vcpu)
+		return ERR_PTR(-ENOMEM);
 
+	r = kvm_x86_ops->vcpu_create(kvm, vcpu, id);
+	if (r) {
+		kmem_cache_free(kvm_vcpu_cache, vcpu);
+		return ERR_PTR(r);
+	}
 	return vcpu;
 }
 
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
