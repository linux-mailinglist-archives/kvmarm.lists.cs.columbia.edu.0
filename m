Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9DA376050
	for <lists+kvmarm@lfdr.de>; Fri,  7 May 2021 08:32:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 11CAE4B589;
	Fri,  7 May 2021 02:32:17 -0400 (EDT)
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
	with ESMTP id cgRLDaBGc6SO; Fri,  7 May 2021 02:32:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 11BC24B57F;
	Fri,  7 May 2021 02:32:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CBDE74B534
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 02:32:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIy4lJ3Wgmn1 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 May 2021 02:32:13 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F3C014B482
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 02:32:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620369132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qv6I3logkEqrFKBHAcTSKZ8CXuHzBhGguNUvVqUgdvc=;
 b=Wi2BTsXSO9VTbOoWB8pp1FrUBky3Y2OwISQYJX/FTXHQOM0mUgMcDS3ftFT6jW8bnD78GH
 RbA4niSuFID+VTKabdPVKlLomm14SL8ECoC/a4vCuJjRat26kynX4cWCtPYp9eCljAsITX
 9zyVN2tKQYqUNJ+t9i2DCRGTlIKF6pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-tNYanZKgNaO8rTBcC7itNA-1; Fri, 07 May 2021 02:32:11 -0400
X-MC-Unique: tNYanZKgNaO8rTBcC7itNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E4BD1006C81;
 Fri,  7 May 2021 06:32:09 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0C05D9DE;
 Fri,  7 May 2021 06:32:06 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 10/21] KVM: arm64: Support SDEI_EVENT_ROUTING_SET hypercall
Date: Fri,  7 May 2021 16:31:13 +0800
Message-Id: <20210507083124.43347-11-gshan@redhat.com>
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

This supports SDEI_EVENT_ROUTING_SET hypercall. It's used by the
guest to set route mode and affinity for the registered KVM event.
It's only valid for the shared events. It's not allowed to do so
when the corresponding event has been raised to the guest.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 5dfa74b093f1..458695c2394f 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -489,6 +489,68 @@ static unsigned long kvm_sdei_hypercall_info(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_route(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *kse = NULL;
+	struct kvm_sdei_kvm_event *kske = NULL;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	unsigned long route_mode = smccc_get_arg2(vcpu);
+	unsigned long route_affinity = smccc_get_arg3(vcpu);
+	int index = 0;
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	if (!kvm_sdei_is_valid_event_num(event_num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	if (!(route_mode == SDEI_EVENT_REGISTER_RM_ANY ||
+	      route_mode == SDEI_EVENT_REGISTER_RM_PE)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	/* Check if the KVM event has been registered */
+	spin_lock(&ksdei->lock);
+	kske = kvm_sdei_find_kvm_event(kvm, event_num);
+	if (!kske) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Validate KVM event state */
+	kse = kske->kse;
+	if (kse->state.type != SDEI_EVENT_TYPE_SHARED) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	if (!kvm_sdei_is_registered(kske, index) ||
+	    kvm_sdei_is_enabled(kske, index)     ||
+	    kske->state.refcount) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Update state */
+	kske->state.route_mode     = route_mode;
+	kske->state.route_affinity = route_affinity;
+
+unlock:
+	spin_unlock(&ksdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	u32 func = smccc_get_function(vcpu);
@@ -523,6 +585,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_info(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
+		ret = kvm_sdei_hypercall_route(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_PE_MASK:
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
 	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
