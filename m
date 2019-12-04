Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE71136AA
	for <lists+kvmarm@lfdr.de>; Wed,  4 Dec 2019 21:44:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D2E94AF0C;
	Wed,  4 Dec 2019 15:44:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A2DnsglD0MDt; Wed,  4 Dec 2019 15:44:53 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E8434AEFF;
	Wed,  4 Dec 2019 15:44:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A553E4AEA3
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Dec 2019 15:44:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YbntMYyY01B2 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  4 Dec 2019 15:44:49 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C5FF84AC7C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Dec 2019 15:44:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575492289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2YEk5cwsZz1UE3QUcoyQVivBnXjlS4sWD+akWvYinI=;
 b=YVTQgY1yvIJfN38otZ5VPbNIqYjwCfWbMPQQQCo+MpsLEZs7mwMRzlS0rWGta48hTi1YQh
 M4UIgsHsJ3oqur7b+YH0yu/72hIOrgjdYXTqV+X8YGy9L1n65IhHgoTlrPtmGqQdP4nD7x
 Jll0Ss17WSaDsvaw/oifjIABXLGNlfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-hOPwBX_pOLC879bhLu4dwQ-1; Wed, 04 Dec 2019 15:44:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26298DBE6;
 Wed,  4 Dec 2019 20:44:47 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8B9694A1;
 Wed,  4 Dec 2019 20:44:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [RFC 2/3] KVM: arm64: pmu: Fix chained SW_INCR counters
Date: Wed,  4 Dec 2019 21:44:25 +0100
Message-Id: <20191204204426.9628-3-eric.auger@redhat.com>
In-Reply-To: <20191204204426.9628-1-eric.auger@redhat.com>
References: <20191204204426.9628-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hOPwBX_pOLC879bhLu4dwQ-1
X-Mimecast-Spam-Score: 0
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
---
 virt/kvm/arm/pmu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index c3f8b059881e..7ab477db2f75 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -491,6 +491,8 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
 
 	enable = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
+		bool chained = test_bit(i >> 1, vcpu->arch.pmu.chained);
+
 		if (!(val & BIT(i)))
 			continue;
 		type = __vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
@@ -500,8 +502,20 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val)
 			reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
 			reg = lower_32_bits(reg);
 			__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = reg;
-			if (!reg)
+			if (reg) /* no overflow */
+				continue;
+			if (chained) {
+				reg = __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) + 1;
+				reg = lower_32_bits(reg);
+				__vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i + 1) = reg;
+				if (reg)
+					continue;
+				/* mark an overflow on high counter */
+				__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i + 1);
+			} else {
+				/* mark an overflow */
 				__vcpu_sys_reg(vcpu, PMOVSSET_EL0) |= BIT(i);
+			}
 		}
 	}
 }
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
