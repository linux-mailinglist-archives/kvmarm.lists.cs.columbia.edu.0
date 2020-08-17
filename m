Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C67D52463FA
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 12:06:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 791394BF95;
	Mon, 17 Aug 2020 06:06:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hcOoKvk-hKF3; Mon, 17 Aug 2020 06:06:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 702A34C015;
	Mon, 17 Aug 2020 06:05:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E884F4BEE9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:05:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JGLcDu-0TwgA for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 06:05:57 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0F8584BE67
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:05:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597658756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arTRMeex/x0u9H8GZuQoqTAX2K8cHFNAQ7G6DIee1VE=;
 b=PYg8wf6pEkNNEQVEbKVioUL27u75SX6uCWwimoKOGGFoChWpRoH0sXk9lGZ/E4TSHvecaI
 GG1UKX3rRamYqJKVUD3LMauIB7bjZuE7yUiYCUsQvDkj3IC8zom7jFaZz38qbaOX9eEGSd
 fmv9pQtAm/aPgkSauaqlJSw/r+rg99A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-wKCYBNy7OeuKwQ-ka8LXnA-1; Mon, 17 Aug 2020 06:05:53 -0400
X-MC-Unique: wKCYBNy7OeuKwQ-ka8LXnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4112981F00F;
 Mon, 17 Aug 2020 10:05:52 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-130.bne.redhat.com [10.64.54.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A9AF78414;
 Mon, 17 Aug 2020 10:05:48 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 03/18] arm/smccc: Introduce template for inline functions
Date: Mon, 17 Aug 2020 20:05:16 +1000
Message-Id: <20200817100531.83045-4-gshan@redhat.com>
In-Reply-To: <20200817100531.83045-1-gshan@redhat.com>
References: <20200817100531.83045-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Cc: maz@kernel.org, shan.gavin@gmail.com, pbonzini@redhat.com
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

The inline functions used to get the SMCCC parameters have same
layout. It means it can be covered by a template to make the code
simplified. Also, this adds more similar inline functions like
smccc_get_arg{4,5,6,7,8}() to visit more SMCCC arguments. It's
required to support SDEI virtualization.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/kvm/arm_hypercalls.h | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 0e2509d27910..1120eff7aa28 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -6,27 +6,21 @@
 
 #include <asm/kvm_emulate.h>
 
-int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
-
-static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 0);
+#define SMCCC_DECLARE_GET_FUNCTION(type, name, reg)		\
+static inline type smccc_get_##name(struct kvm_vcpu *vcpu)	\
+{								\
+	return vcpu_get_reg(vcpu, (reg));			\
 }
 
-static inline unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 1);
-}
-
-static inline unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 2);
-}
-
-static inline unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 3);
-}
+SMCCC_DECLARE_GET_FUNCTION(u32,           function, 0)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg1,     1)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg2,     2)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg3,     3)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg4,     4)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg5,     5)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg6,     6)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg7,     7)
+SMCCC_DECLARE_GET_FUNCTION(unsigned long, arg8,     8)
 
 static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
 				    unsigned long a0,
@@ -40,4 +34,6 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
 	vcpu_set_reg(vcpu, 3, a3);
 }
 
+int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
+
 #endif
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
