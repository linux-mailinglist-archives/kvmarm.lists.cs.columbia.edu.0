Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A2CC23147CD
	for <lists+kvmarm@lfdr.de>; Tue,  9 Feb 2021 06:04:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 469504B684;
	Tue,  9 Feb 2021 00:04:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8rYZ4Ispv-7; Tue,  9 Feb 2021 00:04:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A51874B67C;
	Tue,  9 Feb 2021 00:04:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 510EF4B417
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Feb 2021 00:04:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08oNK1PXcq+U for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Feb 2021 00:04:27 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CB8F34B679
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Feb 2021 00:04:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612847066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzvTzJ6goRIN4YhDsvw/QhGmG+NXT1gxkbhiSX59xsM=;
 b=gFWFTlohkF9anYSm/MaHl3feoBENPnm0SF//tkJwyAFXxytRYX9igUFgtfUdb3vommJLUd
 cDSO0VogppTh15E8LChNmaYW4viIl1BMqJbVFLPLo1WOEdCUltmlcEjMfbY+xFGOTeM4J/
 DFktAk0HejXkgoD6n412jmUjhCrcWpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-F7fY8r2vNA6LEwJntqvQ_Q-1; Tue, 09 Feb 2021 00:04:24 -0500
X-MC-Unique: F7fY8r2vNA6LEwJntqvQ_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14BA5803F49;
 Tue,  9 Feb 2021 05:04:23 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-26.bne.redhat.com [10.64.54.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0783F5D9C0;
 Tue,  9 Feb 2021 05:04:19 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 02/17] KVM: async_pf: Add helper function to check
 completion queue
Date: Tue,  9 Feb 2021 13:03:48 +0800
Message-Id: <20210209050403.103143-3-gshan@redhat.com>
In-Reply-To: <20210209050403.103143-1-gshan@redhat.com>
References: <20210209050403.103143-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
 Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
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

This adds inline function kvm_check_async_pf_completion_queue()
and stub on !CONFIG_KVM_ASYNC_PF so that the source code won't
have to care about CONFIG_KVM_ASYNC_PF. The kernel option is
used for once in kvm_main.c and it can be removed then. Besides,
the checks on the completion queue are all replaced by the newly
introduced helper as list_empty() and list_empty_careful() are
interchangeable.

The stub kvm_check_async_pf_completion() on !CONFIG_KVM_ASYNC_PF
is also introduced. It will be used by subsequent patch.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/x86/kvm/x86.c       |  2 +-
 include/linux/kvm_host.h | 12 ++++++++++++
 virt/kvm/async_pf.c      | 12 ++++++------
 virt/kvm/kvm_main.c      |  4 +---
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 76bce832cade..f3c9fe5c424e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10794,7 +10794,7 @@ static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 
 static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 {
-	if (!list_empty_careful(&vcpu->async_pf.done))
+	if (kvm_check_async_pf_completion_queue(vcpu))
 		return true;
 
 	if (kvm_apic_has_events(vcpu))
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b6697ee1182e..041d93f8f4b0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -316,11 +316,23 @@ struct kvm_async_pf {
 	bool				notpresent_injected;
 };
 
+static inline bool kvm_check_async_pf_completion_queue(struct kvm_vcpu *vcpu)
+{
+	return !list_empty_careful(&vcpu->async_pf.done);
+}
+
 void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
 void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
 bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			unsigned long hva, struct kvm_arch_async_pf *arch);
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
+#else
+static inline bool kvm_check_async_pf_completion_queue(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu) { }
 #endif
 
 
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index dd777688d14a..2cf864aafd0e 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -70,7 +70,7 @@ static void async_pf_execute(struct work_struct *work)
 		kvm_arch_async_page_present(vcpu, apf);
 
 	spin_lock(&vcpu->async_pf.lock);
-	first = list_empty(&vcpu->async_pf.done);
+	first = !kvm_check_async_pf_completion_queue(vcpu);
 	list_add_tail(&apf->link, &vcpu->async_pf.done);
 	apf->vcpu = NULL;
 	spin_unlock(&vcpu->async_pf.lock);
@@ -122,7 +122,7 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
 		spin_lock(&vcpu->async_pf.lock);
 	}
 
-	while (!list_empty(&vcpu->async_pf.done)) {
+	while (kvm_check_async_pf_completion_queue(vcpu)) {
 		struct kvm_async_pf *work =
 			list_first_entry(&vcpu->async_pf.done,
 					 typeof(*work), link);
@@ -138,8 +138,8 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 {
 	struct kvm_async_pf *work;
 
-	while (!list_empty_careful(&vcpu->async_pf.done) &&
-	      kvm_arch_can_dequeue_async_page_present(vcpu)) {
+	while (kvm_check_async_pf_completion_queue(vcpu) &&
+	       kvm_arch_can_dequeue_async_page_present(vcpu)) {
 		spin_lock(&vcpu->async_pf.lock);
 		work = list_first_entry(&vcpu->async_pf.done, typeof(*work),
 					      link);
@@ -205,7 +205,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu)
 	struct kvm_async_pf *work;
 	bool first;
 
-	if (!list_empty_careful(&vcpu->async_pf.done))
+	if (kvm_check_async_pf_completion_queue(vcpu))
 		return 0;
 
 	work = kmem_cache_zalloc(async_pf_cache, GFP_ATOMIC);
@@ -216,7 +216,7 @@ int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu)
 	INIT_LIST_HEAD(&work->queue); /* for list_del to work */
 
 	spin_lock(&vcpu->async_pf.lock);
-	first = list_empty(&vcpu->async_pf.done);
+	first = !kvm_check_async_pf_completion_queue(vcpu);
 	list_add_tail(&work->link, &vcpu->async_pf.done);
 	spin_unlock(&vcpu->async_pf.lock);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8367d88ce39b..632b80b6e485 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2961,10 +2961,8 @@ static bool vcpu_dy_runnable(struct kvm_vcpu *vcpu)
 	if (kvm_arch_dy_runnable(vcpu))
 		return true;
 
-#ifdef CONFIG_KVM_ASYNC_PF
-	if (!list_empty_careful(&vcpu->async_pf.done))
+	if (kvm_check_async_pf_completion_queue(vcpu))
 		return true;
-#endif
 
 	return false;
 }
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
