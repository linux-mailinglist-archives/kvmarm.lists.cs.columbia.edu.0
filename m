Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BB186802
	for <lists+kvmarm@lfdr.de>; Mon, 16 Mar 2020 10:39:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 979D04B087;
	Mon, 16 Mar 2020 05:39:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -3.291
X-Spam-Level: 
X-Spam-Status: No, score=-3.291 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.de
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZRJrHSGLsB1k; Mon, 16 Mar 2020 05:39:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E1204AF1F;
	Mon, 16 Mar 2020 05:39:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EFFF94A523
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Mar 2020 05:39:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9sFsRLRiDmaM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Mar 2020 05:39:25 -0400 (EDT)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com
 [207.171.184.29])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3D3E34A1B0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Mar 2020 05:39:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1584351566; x=1615887566;
 h=from:to:cc:subject:date:message-id;
 bh=qSfJ6u84LZu6czX0X2ef4AdDkN6oHZIFm1K2WciznEs=;
 b=skCk830byYs2FhEyfpqcrJG1p7DiQNjaGZFJOzDkAfGhr4Yqi4lI192U
 ML23PvTXjAisLqPi6lAlPMsUUPel1bT3xMspIEehjGSZMQdS8Qu8pi8ak
 0E/MkfirYsg+6QVDFZ/LQ4ifYTDrPvWsEgGhkXNn0yhGjkKyftP5hl4im g=;
IronPort-SDR: xsYhxKPGjqk2aAysy+zQY9HiQRGEhcQrSC6cz8QMXDMAK4Bl9ABga5RZJdQs+98Mauhlz0Fl+1
 EnHgnQILdeOw==
X-IronPort-AV: E=Sophos;i="5.70,559,1574121600"; d="scan'208";a="31381162"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 16 Mar 2020 09:39:23 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com
 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
 by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS
 id F1E8DA175E; Mon, 16 Mar 2020 09:39:21 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
 by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 02G9dI8G005147; Mon, 16 Mar 2020 10:39:18 +0100
Received: (from karahmed@localhost)
 by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id
 02G9dHYs005143; Mon, 16 Mar 2020 10:39:17 +0100
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Use the correct timer for accessing CNT
Date: Mon, 16 Mar 2020 10:39:06 +0100
Message-Id: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Cc: KarimAllah Ahmed <karahmed@amazon.de>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Use the physical timer object when reading the physical timer counter
instead of using the virtual timer object. This is only visible when
reading it from user-space as kvm_arm_timer_get_reg() is only executed on
the get register patch from user-space.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 virt/kvm/arm/arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 0d9438e..93bd59b 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -788,7 +788,7 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
 					  vcpu_ptimer(vcpu), TIMER_REG_CTL);
 	case KVM_REG_ARM_PTIMER_CNT:
 		return kvm_arm_timer_read(vcpu,
-					  vcpu_vtimer(vcpu), TIMER_REG_CNT);
+					  vcpu_ptimer(vcpu), TIMER_REG_CNT);
 	case KVM_REG_ARM_PTIMER_CVAL:
 		return kvm_arm_timer_read(vcpu,
 					  vcpu_ptimer(vcpu), TIMER_REG_CVAL);
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
