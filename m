Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64737605D
	for <lists+kvmarm@lfdr.de>; Fri,  7 May 2021 08:32:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DA154B2C2;
	Fri,  7 May 2021 02:32:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XpR8jvWAVlMB; Fri,  7 May 2021 02:32:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 480E14B583;
	Fri,  7 May 2021 02:32:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BBDE34B52D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 02:32:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4aWcSha9B7Ka for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 May 2021 02:32:51 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D1DC04B5A6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 02:32:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620369171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVwwKdXnrlF17rr7ICUpWrckXNK7bZs/jTIpWezDxag=;
 b=FxZZrKkSU67IGXM8FIc5k5tgpjm1aZSvzpAJj/zf/kNpINxl2OxeLaN8sQ+Fue6MwVt/Rj
 He9OFOB0T4BbGE1uQqxXwkbOC98ZkNt2Xu3Y49PPfmRDWa4pRdTIBEoMkT7x4BlUXnszg/
 Gc+8IXhuePAS+ivD+EoCooVFeD5Ab+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-9TUvz9g1OHaw3NjnDunWSg-1; Fri, 07 May 2021 02:32:48 -0400
X-MC-Unique: 9TUvz9g1OHaw3NjnDunWSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3106564159;
 Fri,  7 May 2021 06:32:47 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 650315D9CA;
 Fri,  7 May 2021 06:32:44 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 19/21] KVM: arm64: Support SDEI event cancellation
Date: Fri,  7 May 2021 16:31:22 +0800
Message-Id: <20210507083124.43347-20-gshan@redhat.com>
In-Reply-To: <20210507083124.43347-1-gshan@redhat.com>
References: <20210507083124.43347-1-gshan@redhat.com>
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

The injected SDEI event is to send notification to guest. The SDEI
event might not be needed after it's injected. This introduces API
to support cancellation on the injected SDEI event if it's not fired
to the guest yet.

This mechanism will be needed when we're going to support asynchronous
page fault.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h |  1 +
 arch/arm64/kvm/sdei.c             | 49 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 51087fe971ba..353744c7bad9 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -126,6 +126,7 @@ int kvm_sdei_register_notifier(struct kvm *kvm, unsigned long num,
 			       kvm_sdei_notifier notifier);
 int kvm_sdei_inject(struct kvm_vcpu *vcpu,
 		    unsigned long num, bool immediate);
+int kvm_sdei_cancel(struct kvm_vcpu *vcpu, unsigned long num);
 void kvm_sdei_deliver(struct kvm_vcpu *vcpu);
 long kvm_sdei_vm_ioctl(struct kvm *kvm, unsigned long arg);
 long kvm_sdei_vcpu_ioctl(struct kvm_vcpu *vcpu, unsigned long arg);
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 7c2789cd1421..4f5a582daa97 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -907,6 +907,55 @@ int kvm_sdei_inject(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+int kvm_sdei_cancel(struct kvm_vcpu *vcpu, unsigned long num)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	struct kvm_sdei_vcpu_event *ksve = NULL;
+	int ret = 0;
+
+	if (!(ksdei && vsdei)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/* Find the vCPU event */
+	spin_lock(&vsdei->lock);
+	ksve = kvm_sdei_find_vcpu_event(vcpu, num);
+	if (!ksve) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/* Event can't be cancelled if it has been delivered */
+	if (ksve->state.refcount <= 1 &&
+	    (vsdei->critical_event == ksve ||
+	     vsdei->normal_event == ksve)) {
+		ret = -EINPROGRESS;
+		goto unlock;
+	}
+
+	/* Free the vCPU event if necessary */
+	kske = ksve->kske;
+	ksve->state.refcount--;
+	if (!ksve->state.refcount) {
+		list_del(&ksve->link);
+		kfree(ksve);
+	}
+
+unlock:
+	spin_unlock(&vsdei->lock);
+	if (kske) {
+		spin_lock(&ksdei->lock);
+		kske->state.refcount--;
+		spin_unlock(&ksdei->lock);
+	}
+out:
+	return ret;
+}
+
 void kvm_sdei_deliver(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
