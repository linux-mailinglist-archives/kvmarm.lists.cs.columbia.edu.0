Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D2C041487DA
	for <lists+kvmarm@lfdr.de>; Fri, 24 Jan 2020 15:26:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 854EE4AF08;
	Fri, 24 Jan 2020 09:26:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kg1w09psLkw2; Fri, 24 Jan 2020 09:26:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 78ED44AF27;
	Fri, 24 Jan 2020 09:26:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3204B4AF21
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jan 2020 09:26:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xUFTbU4H-lpt for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Jan 2020 09:26:03 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE74E4AF12
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Jan 2020 09:26:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579875962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcYl7Hnv7p+sg1oHvBDUntuXOOPjc9pGbSFE7rJ89fY=;
 b=Q1lgZuCu1PRT1C89oBwuDG+EJom1wJCUCIkTGwDBTKiljgEoMC1ibQB7vjI+e6hHtTppyy
 goeU203ZJbSRKPwM1F8kt+Mp0c/9pVwqZVfA4La6Tjg2Vi8Xg1SeIs+VFIuY9/Zn9dW6hG
 O1BIFmgT91vc16PEwaLBiz0XtHOOrRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-n7u0JYvMN36UujCAySSk7w-1; Fri, 24 Jan 2020 09:26:01 -0500
X-MC-Unique: n7u0JYvMN36UujCAySSk7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DCF4477;
 Fri, 24 Jan 2020 14:25:59 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4492A19C69;
 Fri, 24 Jan 2020 14:25:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH 4/4] KVM: arm64: pmu: Only handle supported event counters
Date: Fri, 24 Jan 2020 15:25:35 +0100
Message-Id: <20200124142535.29386-5-eric.auger@redhat.com>
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

Let the code never use unsupported event counters. Change
kvm_pmu_handle_pmcr() to only reset supported counters and
kvm_pmu_vcpu_reset() to only sto supported counters.

Other actions are filtered on the supported counters in
kvm/sysregs.c

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 560db6282137..f0d0312c0a55 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -247,10 +247,11 @@ void kvm_pmu_vcpu_init(struct kvm_vcpu *vcpu)
  */
 void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu)
 {
-	int i;
+	unsigned long mask = kvm_pmu_valid_counter_mask(vcpu);
 	struct kvm_pmu *pmu = &vcpu->arch.pmu;
+	int i;
 
-	for (i = 0; i < ARMV8_PMU_MAX_COUNTERS; i++)
+	for_each_set_bit(i, &mask, 32)
 		kvm_pmu_stop_counter(vcpu, &pmu->pmc[i]);
 
 	bitmap_zero(vcpu->arch.pmu.chained, ARMV8_PMU_MAX_COUNTER_PAIRS);
@@ -527,10 +528,9 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
  */
 void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 {
-	u64 mask;
+	unsigned long mask = kvm_pmu_valid_counter_mask(vcpu);
 	int i;
 
-	mask = kvm_pmu_valid_counter_mask(vcpu);
 	if (val & ARMV8_PMU_PMCR_E) {
 		kvm_pmu_enable_counter_mask(vcpu,
 		       __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask);
@@ -542,7 +542,7 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
 		kvm_pmu_set_counter_value(vcpu, ARMV8_PMU_CYCLE_IDX, 0);
 
 	if (val & ARMV8_PMU_PMCR_P) {
-		for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++)
+		for_each_set_bit(i, &mask, 32)
 			kvm_pmu_set_counter_value(vcpu, i, 0);
 	}
 }
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
