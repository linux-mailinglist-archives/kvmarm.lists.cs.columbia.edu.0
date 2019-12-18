Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 805F5125558
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 22:56:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 348524ACD6;
	Wed, 18 Dec 2019 16:56:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wOYv2O+-z7DD; Wed, 18 Dec 2019 16:56:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 944854AF4C;
	Wed, 18 Dec 2019 16:56:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C46A14AED3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:56:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s-0kaURP+W2l for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 16:56:00 -0500 (EST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 08B664ACD6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 16:55:46 -0500 (EST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 13:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="222108141"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
 by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2019 13:55:46 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 31/45] KVM: Unexport kvm_vcpu_cache and kvm_vcpu_{un}init()
Date: Wed, 18 Dec 2019 13:55:16 -0800
Message-Id: <20191218215530.2280-32-sean.j.christopherson@intel.com>
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

Unexport kvm_vcpu_cache and kvm_vcpu_{un}init() and make them static
now that they are referenced only in kvm_main.c.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 include/linux/kvm_host.h | 4 ----
 virt/kvm/kvm_main.c      | 9 +++------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a9abd9e9f621..d24e6c134d15 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -157,8 +157,6 @@ static inline bool is_error_page(struct page *page)
 #define KVM_USERSPACE_IRQ_SOURCE_ID		0
 #define KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID	1
 
-extern struct kmem_cache *kvm_vcpu_cache;
-
 extern struct mutex kvm_lock;
 extern struct list_head vm_list;
 
@@ -579,8 +577,6 @@ static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 	      memslot < slots->memslots + KVM_MEM_SLOTS_NUM && memslot->npages;\
 		memslot++)
 
-int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id);
-void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 void kvm_vcpu_destroy(struct kvm_vcpu *vcpu);
 
 void vcpu_load(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1afffb0da7cc..fd8168b8c0e4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -104,8 +104,7 @@ static cpumask_var_t cpus_hardware_enabled;
 static int kvm_usage_count;
 static atomic_t hardware_enable_failed;
 
-struct kmem_cache *kvm_vcpu_cache;
-EXPORT_SYMBOL_GPL(kvm_vcpu_cache);
+static struct kmem_cache *kvm_vcpu_cache;
 
 static __read_mostly struct preempt_ops kvm_preempt_ops;
 
@@ -322,7 +321,7 @@ void kvm_reload_remote_mmus(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);
 }
 
-int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
+static int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 {
 	struct page *page;
 	int r;
@@ -360,9 +359,8 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 fail:
 	return r;
 }
-EXPORT_SYMBOL_GPL(kvm_vcpu_init);
 
-void kvm_vcpu_uninit(struct kvm_vcpu *vcpu)
+static void kvm_vcpu_uninit(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * no need for rcu_read_lock as VCPU_RUN is the only place that
@@ -373,7 +371,6 @@ void kvm_vcpu_uninit(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_uninit(vcpu);
 	free_page((unsigned long)vcpu->run);
 }
-EXPORT_SYMBOL_GPL(kvm_vcpu_uninit);
 
 void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
