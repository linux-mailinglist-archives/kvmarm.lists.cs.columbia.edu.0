Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 78440125527
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 22:55:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B6AE4A7FE;
	Wed, 18 Dec 2019 16:55:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50k5wCd87+-h; Wed, 18 Dec 2019 16:55:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BB44B4AEB3;
	Wed, 18 Dec 2019 16:55:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 550184A7F1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:55:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUkDmr00hGAi for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 16:55:35 -0500 (EST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 24AAA4A4A0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:55:35 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 13:55:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="222108030"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 13:55:34 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 06/45] KVM: SVM: Use direct vcpu pointer during vCPU
 create/free
Date: Wed, 18 Dec 2019 13:54:51 -0800
Message-Id: <20191218215530.2280-7-sean.j.christopherson@intel.com>
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

Capture the vcpu pointer in a local varaible and replace '&svm->vcpu'
references with a direct reference to the pointer in anticipation of
moving bits of the code to common x86 and passing the vcpu pointer into
svm_create_vcpu(), i.e. eliminate unnecessary noise from future patches.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/svm.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 8f1b715dfde8..1afa10cf365f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2146,6 +2146,7 @@ static int avic_init_vcpu(struct vcpu_svm *svm)
 
 static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
 {
+	struct kvm_vcpu *vcpu;
 	struct vcpu_svm *svm;
 	struct page *page;
 	struct page *msrpm_pages;
@@ -2161,24 +2162,25 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
 		err = -ENOMEM;
 		goto out;
 	}
+	vcpu = &svm->vcpu;
 
-	svm->vcpu.arch.user_fpu = kmem_cache_zalloc(x86_fpu_cache,
-						     GFP_KERNEL_ACCOUNT);
-	if (!svm->vcpu.arch.user_fpu) {
+	vcpu->arch.user_fpu = kmem_cache_zalloc(x86_fpu_cache,
+						GFP_KERNEL_ACCOUNT);
+	if (!vcpu->arch.user_fpu) {
 		printk(KERN_ERR "kvm: failed to allocate kvm userspace's fpu\n");
 		err = -ENOMEM;
 		goto free_partial_svm;
 	}
 
-	svm->vcpu.arch.guest_fpu = kmem_cache_zalloc(x86_fpu_cache,
-						     GFP_KERNEL_ACCOUNT);
-	if (!svm->vcpu.arch.guest_fpu) {
+	vcpu->arch.guest_fpu = kmem_cache_zalloc(x86_fpu_cache,
+						 GFP_KERNEL_ACCOUNT);
+	if (!vcpu->arch.guest_fpu) {
 		printk(KERN_ERR "kvm: failed to allocate vcpu's fpu\n");
 		err = -ENOMEM;
 		goto free_user_fpu;
 	}
 
-	err = kvm_vcpu_init(&svm->vcpu, kvm, id);
+	err = kvm_vcpu_init(vcpu, kvm, id);
 	if (err)
 		goto free_svm;
 
@@ -2222,9 +2224,9 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
 	svm->asid_generation = 0;
 	init_vmcb(svm);
 
-	svm_init_osvw(&svm->vcpu);
+	svm_init_osvw(vcpu);
 
-	return &svm->vcpu;
+	return vcpu;
 
 free_page4:
 	__free_page(hsave_page);
@@ -2235,11 +2237,11 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
 free_page1:
 	__free_page(page);
 uninit:
-	kvm_vcpu_uninit(&svm->vcpu);
+	kvm_vcpu_uninit(vcpu);
 free_svm:
-	kmem_cache_free(x86_fpu_cache, svm->vcpu.arch.guest_fpu);
+	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
 free_user_fpu:
-	kmem_cache_free(x86_fpu_cache, svm->vcpu.arch.user_fpu);
+	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
 free_partial_svm:
 	kmem_cache_free(kvm_vcpu_cache, svm);
 out:
@@ -2270,8 +2272,8 @@ static void svm_free_vcpu(struct kvm_vcpu *vcpu)
 	__free_page(virt_to_page(svm->nested.hsave));
 	__free_pages(virt_to_page(svm->nested.msrpm), MSRPM_ALLOC_ORDER);
 	kvm_vcpu_uninit(vcpu);
-	kmem_cache_free(x86_fpu_cache, svm->vcpu.arch.user_fpu);
-	kmem_cache_free(x86_fpu_cache, svm->vcpu.arch.guest_fpu);
+	kmem_cache_free(x86_fpu_cache, vcpu->arch.user_fpu);
+	kmem_cache_free(x86_fpu_cache, vcpu->arch.guest_fpu);
 	kmem_cache_free(kvm_vcpu_cache, svm);
 }
 
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
