Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D73EC376049
	for <lists+kvmarm@lfdr.de>; Fri,  7 May 2021 08:32:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 85BAD4B297;
	Fri,  7 May 2021 02:32:02 -0400 (EDT)
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
	with ESMTP id 5EtFnULWhWKn; Fri,  7 May 2021 02:32:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 82E3C4B559;
	Fri,  7 May 2021 02:32:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EDC754B516
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 02:31:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhzhpZ5w4DLR for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 May 2021 02:31:59 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BB7B4B430
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 02:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620369119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmO12IyDy5qzS+T4IY7K2Y+LJ28N9E7M0ofJOxtqPww=;
 b=Rua+bFgZu5FT6mAFm3BK/V76bARryqIW1sGGgVKCSs1xVwcPOwitfk+g38uvPckkpzFEBL
 D88acSEkLQUr1UAHnIEkkcT3X0zSev3EsjM+GuIXK+UNcegSW20IoEzn1Z0g0vBGe1XHjr
 BUXVD2jWo6LHGC4ZzUazrGsDw8TJ7Ns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-SibVCbJzOIS5nuuLENUmVg-1; Fri, 07 May 2021 02:31:56 -0400
X-MC-Unique: SibVCbJzOIS5nuuLENUmVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F356580059E;
 Fri,  7 May 2021 06:31:54 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6A635D9CA;
 Fri,  7 May 2021 06:31:51 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 06/21] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
Date: Fri,  7 May 2021 16:31:09 +0800
Message-Id: <20210507083124.43347-7-gshan@redhat.com>
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

This supports SDEI_EVENT_CONTEXT hypercall. It's used by the guest
to retrieved the original registers (R0 - R17) in its SDEI event
handler. Those registers can be corrupted during the SDEI event
delivery.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index b022ce0a202b..b4162efda470 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -270,6 +270,44 @@ static unsigned long kvm_sdei_hypercall_enable(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static unsigned long kvm_sdei_hypercall_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_regs *regs;
+	unsigned long index = smccc_get_arg1(vcpu);
+	unsigned long ret = SDEI_SUCCESS;
+
+	/* Sanity check */
+	if (!(ksdei && vsdei)) {
+		ret = SDEI_NOT_SUPPORTED;
+		goto out;
+	}
+
+	if (index > ARRAY_SIZE(vsdei->state.critical_regs.regs)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	/* Check if the pending event exists */
+	spin_lock(&vsdei->lock);
+	if (!(vsdei->critical_event || vsdei->normal_event)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Fetch the requested register */
+	regs = vsdei->critical_event ? &vsdei->state.critical_regs :
+				       &vsdei->state.normal_regs;
+	ret = regs->regs[index];
+
+unlock:
+	spin_unlock(&vsdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	u32 func = smccc_get_function(vcpu);
@@ -290,6 +328,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_sdei_hypercall_enable(vcpu, false);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+		ret = kvm_sdei_hypercall_context(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
