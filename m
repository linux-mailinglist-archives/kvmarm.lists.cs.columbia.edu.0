Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 78C252F5EE4
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jan 2021 11:37:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C1C64B1A1;
	Thu, 14 Jan 2021 05:37:45 -0500 (EST)
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
	with ESMTP id JW1aL1fben12; Thu, 14 Jan 2021 05:37:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 220FD4B197;
	Thu, 14 Jan 2021 05:37:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDEE34B143
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 05:37:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oXWYIMQEkqCC for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jan 2021 05:37:42 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C86A4B088
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 05:37:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610620661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hJXtfkfIsQuOWJQwFllSA/VmwaaMSwqBRVC3R1TgZY=;
 b=HlEtjwXpnWQk0qi6f7mi5oob+b4yZ1Ukea3Tv7OUjOOaVDWz0+nms81C64YosfC4I4/xx1
 odEQxpQ0rWdeRjOdi5Vd3+a60Il/WII33IOB68Tfk2rEnothgxTEjSLRomic+DvMO5Qy45
 XA3DNnNQCs7KXZNxWbREPHygqXAdtvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-qAFO6Wd9NrmhCjLZgaESvQ-1; Thu, 14 Jan 2021 05:37:40 -0500
X-MC-Unique: qAFO6Wd9NrmhCjLZgaESvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F37C107ACF8;
 Thu, 14 Jan 2021 10:37:38 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-165.ams2.redhat.com [10.36.114.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B07287047A;
 Thu, 14 Jan 2021 10:37:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, maz@kernel.org, drjones@redhat.com
Subject: [PATCH v2 5/9] KVM: arm: move has_run_once after the map_resources
Date: Thu, 14 Jan 2021 11:37:04 +0100
Message-Id: <20210114103708.26763-6-eric.auger@redhat.com>
In-Reply-To: <20210114103708.26763-1-eric.auger@redhat.com>
References: <20210114103708.26763-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: pbonzini@redhat.com, shuah@kernel.org
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

has_run_once is set to true at the beginning of
kvm_vcpu_first_run_init(). This generally is not an issue
except when exercising the code with KVM selftests. for instance,
if kvm_vgic_map_resources() fails due to erroneous user settings,
has_run_once is set and this prevents from continuing
executing the test. This patch moves the assignment after the
kvm_vgic_map_resources().

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- slight reword of the commit msg (for instance)
---
 arch/arm64/kvm/arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 04c44853b103..580760e58980 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -573,8 +573,6 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	if (!kvm_arm_vcpu_is_finalized(vcpu))
 		return -EPERM;
 
-	vcpu->arch.has_run_once = true;
-
 	if (likely(irqchip_in_kernel(kvm))) {
 		/*
 		 * Map the VGIC hardware resources before running a vcpu the
@@ -591,6 +589,8 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 		static_branch_inc(&userspace_irqchip_in_use);
 	}
 
+	vcpu->arch.has_run_once = true;
+
 	ret = kvm_timer_enable(vcpu);
 	if (ret)
 		return ret;
-- 
2.21.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
