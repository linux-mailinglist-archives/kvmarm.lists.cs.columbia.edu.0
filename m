Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5590A4F0ACB
	for <lists+kvmarm@lfdr.de>; Sun,  3 Apr 2022 17:40:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 015444B0D9;
	Sun,  3 Apr 2022 11:40:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eE68rvA4DZ9W; Sun,  3 Apr 2022 11:40:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C81794B1B6;
	Sun,  3 Apr 2022 11:40:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 89A084B0DF
 for <kvmarm@lists.cs.columbia.edu>; Sun,  3 Apr 2022 11:40:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sMiBhAj2+nNT for <kvmarm@lists.cs.columbia.edu>;
 Sun,  3 Apr 2022 11:40:53 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 889004B0D9
 for <kvmarm@lists.cs.columbia.edu>; Sun,  3 Apr 2022 11:40:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649000453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=845WvNiklQhaA5N8dsHhYvh4+Oz8svlNTDz8uRoZK4Q=;
 b=OqmMW06TYYU1ElxcV6a9mLgqk013soyf1eNxqwjhR4XRm+1B3oqn3wUkLw+PvGmvG2aRDn
 zT2mHqkGaczkd135/boxkl5pTYQK18S6IAiJrLg8i+hA/ycNFE3MHwbIexqr00lWr/6J2e
 6GAVfhNMOBsfO7FbQZ/Rjooz64Z690s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-ct3-QfrSMt-7IHB_MlW_2w-1; Sun, 03 Apr 2022 11:40:48 -0400
X-MC-Unique: ct3-QfrSMt-7IHB_MlW_2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E6F858EEC;
 Sun,  3 Apr 2022 15:40:47 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FD7A4538D7;
 Sun,  3 Apr 2022 15:40:40 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v6 11/18] KVM: arm64: Support SDEI_{PRIVATE, SHARED}_RESET
Date: Sun,  3 Apr 2022 23:39:04 +0800
Message-Id: <20220403153911.12332-12-gshan@redhat.com>
In-Reply-To: <20220403153911.12332-1-gshan@redhat.com>
References: <20220403153911.12332-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org
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

This supports SDEI_{PRIVATE, SHARED}_RESET. They are used by the
guest to reset the private events on the calling vCPU or the
shared events on all vCPUs.

The shared event isn't supported yet, we simply returns SDEI_SUCCESS
as the guest doesn't know it. It can't stop the guest from using
SDEI service.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 3aca36e7e27b..6716ed020aa2 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -352,6 +352,36 @@ static unsigned long hypercall_mask(struct kvm_vcpu *vcpu, bool mask)
 	return ret;
 }
 
+static unsigned long hypercall_reset(struct kvm_vcpu *vcpu, bool private)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *event;
+	unsigned int i;
+	unsigned long ret = SDEI_SUCCESS;
+
+	/*
+	 * All events, which have been registered, should be private
+	 * because the shared events aren't supported yet, so we needn't
+	 * do anything to reset the shared events.
+	 */
+	if (!private)
+		return ret;
+
+	spin_lock(&vsdei->lock);
+
+	kvm_sdei_for_each_event(vsdei, event, i) {
+		if (!kvm_sdei_is_registered(event))
+			continue;
+
+		if (reset_event(vcpu, event))
+			ret = SDEI_PENDING;
+	}
+
+	spin_unlock(&vsdei->lock);
+
+	return ret;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -400,6 +430,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
 		ret = hypercall_mask(vcpu, false);
 		break;
+	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+		ret = hypercall_reset(vcpu, true);
+		break;
+	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+		ret = hypercall_reset(vcpu, false);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
