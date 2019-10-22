Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 513E4DFA53
	for <lists+kvmarm@lfdr.de>; Tue, 22 Oct 2019 03:59:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 006374A9B4;
	Mon, 21 Oct 2019 21:59:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OrQ7sznJh6mT; Mon, 21 Oct 2019 21:59:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A7D794AA09;
	Mon, 21 Oct 2019 21:59:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ECA774A9D9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Oct 2019 21:59:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZAelYqiUN95c for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Oct 2019 21:59:35 -0400 (EDT)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9D8CA4A9AF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Oct 2019 21:59:35 -0400 (EDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Oct 2019 18:59:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; d="scan'208";a="196293757"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
 by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2019 18:59:34 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 05/45] KVM: VMX: Use direct vcpu pointer during vCPU
 create/free
Date: Mon, 21 Oct 2019 18:58:45 -0700
Message-Id: <20191022015925.31916-6-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191022015925.31916-1-sean.j.christopherson@intel.com>
References: <20191022015925.31916-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
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

Capture the vcpu pointer in a local varaible and replace '&vmx->vcpu'
references with a direct reference to the pointer in anticipation of
moving bits of the code to common x86 and passing the vcpu pointer into
vmx_create_vcpu(), i.e. eliminate unnecessary noise from future patches.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 501e88bd6204..70b8d15eb2c5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6691,17 +6691,17 @@ static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 	free_loaded_vmcs(vmx->loaded_vmcs);
 	kfree(vmx->guest_msrs);
 	kvm_vcpu_uninit(vcpu);
-	kmem_cache_free(x86_fpu_cache, vmx->vcpu.arch.user_fpu);
-	kmem_cache_free(x86_fpu_cache, vmx->vcpu.arch.guest_fpu);
+	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
+	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
 	kmem_cache_free(kvm_vcpu_cache, vmx);
 }
 
 static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 {
-	int err;
+	struct kvm_vcpu *vcpu;
 	struct vcpu_vmx *vmx;
 	unsigned long *msr_bitmap;
-	int cpu;
+	int cpu, err;
 
 	BUILD_BUG_ON_MSG(offsetof(struct vcpu_vmx, vcpu) != 0,
 		"struct kvm_vcpu must be at offset 0 for arch usercopy region");
@@ -6710,23 +6710,25 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	if (!vmx)
 		return ERR_PTR(-ENOMEM);
 
-	vmx->vcpu.arch.user_fpu = kmem_cache_zalloc(x86_fpu_cache,
-			GFP_KERNEL_ACCOUNT);
-	if (!vmx->vcpu.arch.user_fpu) {
+	vcpu = &vmx->vcpu;
+
+	vcpu->arch.user_fpu = kmem_cache_zalloc(x86_fpu_cache,
+						GFP_KERNEL_ACCOUNT);
+	if (!vcpu->arch.user_fpu) {
 		printk(KERN_ERR "kvm: failed to allocate kvm userspace's fpu\n");
 		err = -ENOMEM;
 		goto free_partial_vcpu;
 	}
 
-	vmx->vcpu.arch.guest_fpu = kmem_cache_zalloc(x86_fpu_cache,
-			GFP_KERNEL_ACCOUNT);
-	if (!vmx->vcpu.arch.guest_fpu) {
+	vcpu->arch.guest_fpu = kmem_cache_zalloc(x86_fpu_cache,
+						 GFP_KERNEL_ACCOUNT);
+	if (!vcpu->arch.guest_fpu) {
 		printk(KERN_ERR "kvm: failed to allocate vcpu's fpu\n");
 		err = -ENOMEM;
 		goto free_user_fpu;
 	}
 
-	err = kvm_vcpu_init(&vmx->vcpu, kvm, id);
+	err = kvm_vcpu_init(vcpu, kvm, id);
 	if (err)
 		goto free_vcpu;
 
@@ -6775,12 +6777,12 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
 	cpu = get_cpu();
-	vmx_vcpu_load(&vmx->vcpu, cpu);
-	vmx->vcpu.cpu = cpu;
+	vmx_vcpu_load(vcpu, cpu);
+	vcpu->cpu = cpu;
 	vmx_vcpu_setup(vmx);
-	vmx_vcpu_put(&vmx->vcpu);
+	vmx_vcpu_put(vcpu);
 	put_cpu();
-	if (cpu_need_virtualize_apic_accesses(&vmx->vcpu)) {
+	if (cpu_need_virtualize_apic_accesses(vcpu)) {
 		err = alloc_apic_access_page(kvm);
 		if (err)
 			goto free_vmcs;
@@ -6795,7 +6797,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	if (nested)
 		nested_vmx_setup_ctls_msrs(&vmx->nested.msrs,
 					   vmx_capability.ept,
-					   kvm_vcpu_apicv_active(&vmx->vcpu));
+					   kvm_vcpu_apicv_active(vcpu));
 	else
 		memset(&vmx->nested.msrs, 0, sizeof(vmx->nested.msrs));
 
@@ -6813,7 +6815,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 
 	vmx->ept_pointer = INVALID_PAGE;
 
-	return &vmx->vcpu;
+	return vcpu;
 
 free_vmcs:
 	free_loaded_vmcs(vmx->loaded_vmcs);
@@ -6822,12 +6824,12 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 free_pml:
 	vmx_destroy_pml_buffer(vmx);
 uninit_vcpu:
-	kvm_vcpu_uninit(&vmx->vcpu);
+	kvm_vcpu_uninit(vcpu);
 	free_vpid(vmx->vpid);
 free_vcpu:
-	kmem_cache_free(x86_fpu_cache, vmx->vcpu.arch.guest_fpu);
+	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
 free_user_fpu:
-	kmem_cache_free(x86_fpu_cache, vmx->vcpu.arch.user_fpu);
+	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
 free_partial_vcpu:
 	kmem_cache_free(kvm_vcpu_cache, vmx);
 	return ERR_PTR(err);
-- 
2.22.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
