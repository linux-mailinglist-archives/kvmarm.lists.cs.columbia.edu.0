Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 014B71756D0
	for <lists+kvmarm@lfdr.de>; Mon,  2 Mar 2020 10:20:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6FEAB4AF8C;
	Mon,  2 Mar 2020 04:20:47 -0500 (EST)
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
	with ESMTP id 0eqjIUwwN7cM; Mon,  2 Mar 2020 04:20:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 687FF4AF85;
	Mon,  2 Mar 2020 04:20:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDF0A4AF7F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Mar 2020 04:20:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnYZcEdeCHa4 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Mar 2020 04:20:44 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D35394AF63
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Mar 2020 04:20:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583140844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZJFxdajhUjFzdrLxSpnS9/s8iz/FeaFiOGrLtEOmsgI=;
 b=HzF60C8cZ1b1DCgxmiX1JpNKyBE+2YiJB0RYNhZrX3zadT9do/D8L0e6jd1tmplaulGHIX
 /CsU5pbNLinMmSojg3tBUmgJC+mM9Jyzo5PoD4DvIlY5AQeHtTbXVZqichWxA3rt4ixks0
 iIfE2N1R+Bh5qGJeDmLZ+vi9QyLns/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-mnSEhPCwNjSTOH0xBNql0Q-1; Mon, 02 Mar 2020 04:20:40 -0500
X-MC-Unique: mnSEhPCwNjSTOH0xBNql0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59FED189F760;
 Mon,  2 Mar 2020 09:20:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EAE860BF3;
 Mon,  2 Mar 2020 09:20:34 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stable@vger.kernel.org,
 maz@kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: pmu: Don't increment SW_INCR if PMCR.E is unset
Date: Mon,  2 Mar 2020 10:20:25 +0100
Message-Id: <20200302092025.22321-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

commit 3837407c1aa1 upstream.

The specification says PMSWINC increments PMEVCNTR<n>_EL1 by 1
if PMEVCNTR<n>_EL0 is enabled and configured to count SW_INCR.

For PMEVCNTR<n>_EL0 to be enabled, we need both PMCNTENSET to
be set for the corresponding event counter but we also need
the PMCR.E bit to be set.

Fixes: 7a0adc7064b8 ("arm64: KVM: Add access handler for PMSWINC register")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Cc: <stable@vger.kernel.org> # 4.14 only

---

This is a backport of 3837407c1aa1 ("KVM: arm64: pmu: Don't
increment SW_INCR if PMCR.E is unset") which did not apply on
4.14-stable. Compared to the original patch
__vcpu_sys_reg() is replaced by vcpu_sys_reg().
---
 virt/kvm/arm/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 8a9c42366db7..3998add436da 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -316,6 +316,9 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
 	if (val == 0)
 		return;
 
+	if (!(vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
+		return;
+
 	enable = vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
 		if (!(val & BIT(i)))
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
