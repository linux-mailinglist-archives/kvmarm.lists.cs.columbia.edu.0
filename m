Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4F3EC62E
	for <lists+kvmarm@lfdr.de>; Sun, 15 Aug 2021 02:15:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F0DF64B0A3;
	Sat, 14 Aug 2021 20:15:21 -0400 (EDT)
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
	with ESMTP id jVf1XknFsPjg; Sat, 14 Aug 2021 20:15:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AACC4B0BA;
	Sat, 14 Aug 2021 20:15:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BBE24B086
 for <kvmarm@lists.cs.columbia.edu>; Sat, 14 Aug 2021 20:15:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hpx+-oveJliI for <kvmarm@lists.cs.columbia.edu>;
 Sat, 14 Aug 2021 20:15:15 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D7854B0C0
 for <kvmarm@lists.cs.columbia.edu>; Sat, 14 Aug 2021 20:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628986514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DElgAKnXxGi8roylqPYAKEl/MuVnVKXjV89e67/IzUs=;
 b=CMBNbzrSvgbFLHgHqQta1SlwRmrjfrMclAJC6NOmdy8qi792ILmhVlR/fQwmY9KKH90Hmy
 q7yHWl6sG7YMPqM1PyqQW0CPzLIh83/nSnOEbL0UIy3tRuFgnXaCWZqNSNiW3eFBRo5RMY
 85xxZoLPVVQrGCtIBwfUzemMFADcpnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-u7EXkTDYPOCrt3foqR6R_Q-1; Sat, 14 Aug 2021 20:15:12 -0400
X-MC-Unique: u7EXkTDYPOCrt3foqR6R_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7452C801B3D;
 Sun, 15 Aug 2021 00:15:11 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B44B1036D2E;
 Sun, 15 Aug 2021 00:15:08 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 12/21] KVM: arm64: Support SDEI_{PRIVATE,
 SHARED}_RESET hypercall
Date: Sun, 15 Aug 2021 08:13:43 +0800
Message-Id: <20210815001352.81927-13-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
 pbonzini@redhat.com, will@kernel.org
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
guest to purge the private or shared SDEI events, which are registered
previously.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 3fb33258b494..62efee2b67b8 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -582,6 +582,29 @@ static unsigned long kvm_sdei_hypercall_mask(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_reset(struct kvm_vcpu *vcpu,
+					      bool private)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned int mask = private ? (1 << SDEI_EVENT_TYPE_PRIVATE) :
+				      (1 << SDEI_EVENT_TYPE_SHARED);
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+	kvm_sdei_remove_kvm_events(kvm, mask, false);
+	spin_unlock(&ksdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	u32 func = smccc_get_function(vcpu);
@@ -626,8 +649,14 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		break;
 	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
 	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
+		ret = SDEI_NOT_SUPPORTED;
+		break;
 	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+		ret = kvm_sdei_hypercall_reset(vcpu, true);
+		break;
 	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+		ret = kvm_sdei_hypercall_reset(vcpu, false);
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
