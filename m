Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AE0791487D2
	for <lists+kvmarm@lfdr.de>; Fri, 24 Jan 2020 15:26:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F5CD4AF17;
	Fri, 24 Jan 2020 09:26:03 -0500 (EST)
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
	with ESMTP id krcmI17Dj4lO; Fri, 24 Jan 2020 09:26:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3BC164AF20;
	Fri, 24 Jan 2020 09:26:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 79EB04AF12
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jan 2020 09:26:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRERi9SS2vHM for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Jan 2020 09:25:59 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 903B44AF08
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jan 2020 09:25:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579875959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+xkkLcGvn4l2z374gMhccJvWqyhAjGkRVHUTmNEzYI=;
 b=gCA6bZXy5/Y8HE4csEk0UZnccpy9d0qpGHCMhyTmcdS3RJquMwASfUS0hC6l+I3nJHMW9V
 KG0to65p2tpbvOdqoQ+1bJAJqdrrzzKsFiQscDrdUQREhvoRyXz1FGFAYWx6DSt1+B255o
 jW5s4yWL6XNTEKpTUHumv48bU8QYXic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-4vA9tXH4PUyVOE6thtzQvw-1; Fri, 24 Jan 2020 09:25:57 -0500
X-MC-Unique: 4vA9tXH4PUyVOE6thtzQvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D082800D41;
 Fri, 24 Jan 2020 14:25:55 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8528319C69;
 Fri, 24 Jan 2020 14:25:52 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH 3/4] KVM: arm64: pmu: Fix chained SW_INCR counters
Date: Fri, 24 Jan 2020 15:25:34 +0100
Message-Id: <20200124142535.29386-4-eric.auger@redhat.com>
In-Reply-To: <20200124142535.29386-1-eric.auger@redhat.com>
References: <20200124142535.29386-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: andrew.murray@arm.com
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

At the moment a SW_INCR counter always overflows on 32-bit
boundary, independently on whether the n+1th counter is
programmed as CHAIN.

Check whether the SW_INCR counter is a 64b counter and if so,
implement the 64b logic.

Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>

---

v1 -> v2:
- Reorganize the kvm_pmu_software_increment() flow as suggested by
  Marc. At the exception I did not use kvm_pmu_get_counter_value()
  as it returns only the right half of the 64b counter.
---
 virt/kvm/arm/pmu.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 9f605e0b8dd7..560db6282137 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -477,28 +477,45 @@ static void kvm_pmu_perf_overflow(struct perf_event *perf_event,
  */
 void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
 {
+	struct kvm_pmu *pmu = &vcpu->arch.pmu;
 	int i;
-	u64 type, enable, reg;
-
-	if (val == 0)
-		return;
 
 	if (!(__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E))
 		return;
 
-	enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+	/* Weed out disabled counters */
+	val &= __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
+
 	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
+		u64 type, reg;
+
 		if (!(val & BIT(i)))
 			continue;
-		type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
-		       & ARMV8_PMU_EVTYPE_EVENT;
-		if ((type == ARMV8_PMUV3_PERFCTR_SW_INCR)
-		    && (enable & BIT(i))) {
-			reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
+
+		/* PMSWINC only applies to ... SW_INC! */
+		type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i);
+		type &= ARMV8_PMU_EVTYPE_EVENT;
+		if (type != ARMV8_PMUV3_PERFCTR_SW_INCR)
+			continue;
+
+		/* increment this even SW_INC counter */
+		reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
+		reg = lower_32_bits(reg);
+		__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
+
+		if (reg) /* no overflow on the low part */
+			continue;
+
+		if (kvm_pmu_pmc_is_chained(&pmu->pmc[i])) {
+			/* increment the high counter */
+			reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) + 1;
 			reg = lower_32_bits(reg);
-			__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
-			if (!reg)
-				__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i);
+			__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) = reg;
+			if (!reg) /* mark overflow on the high counter */
+				__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i + 1);
+		} else {
+			/* mark overflow on low counter */
+			__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i);
 		}
 	}
 }
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
