Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7A962E323D
	for <lists+kvmarm@lfdr.de>; Thu, 24 Oct 2019 14:25:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F3ED4A853;
	Thu, 24 Oct 2019 08:25:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.1
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	UNPARSEABLE_RELAY=0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxsrCm1vRaPU; Thu, 24 Oct 2019 08:25:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED9D94A8C4;
	Thu, 24 Oct 2019 08:25:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00B684A523
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Oct 2019 06:27:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eK75cRTCHl7u for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Oct 2019 06:27:56 -0400 (EDT)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C87EC4A60D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Oct 2019 06:27:55 -0400 (EDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419; MF=shannon.zhao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0Tg31GPL_1571912867; 
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com
 fp:SMTPD_---0Tg31GPL_1571912867) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Oct 2019 18:27:49 +0800
From: Shannon Zhao <shannon.zhao@linux.alibaba.com>
To: kvmarm@lists.cs.columbia.edu, maz@kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, christoffer.dall@arm.com
Subject: [PATCH RFC 3/7] KVM: vgic: make vgic parameters work well for module
Date: Thu, 24 Oct 2019 18:27:46 +0800
Message-Id: <1571912870-18471-4-git-send-email-shannon.zhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
X-Mailman-Approved-At: Thu, 24 Oct 2019 08:25:09 -0400
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 virt/kvm/arm/vgic/vgic-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 8d69f00..228cfeb 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -548,6 +548,12 @@ int vgic_v3_map_resources(struct kvm *kvm)
 
 DEFINE_STATIC_KEY_FALSE(vgic_v3_cpuif_trap);
 
+#ifdef MODULE
+module_param_named(vgic_v3_group0_trap, group0_trap, bool, S_IRUGO);
+module_param_named(vgic_v3_group1_trap, group1_trap, bool, S_IRUGO);
+module_param_named(vgic_v3_common_trap, common_trap, bool, S_IRUGO);
+module_param_named(vgic_v4_enable, gicv4_enable, bool, S_IRUGO);
+#else
 static int __init early_group0_trap_cfg(char *buf)
 {
 	return strtobool(buf, &group0_trap);
@@ -571,6 +577,7 @@ static int __init early_gicv4_enable(char *buf)
 	return strtobool(buf, &gicv4_enable);
 }
 early_param("kvm-arm.vgic_v4_enable", early_gicv4_enable);
+#endif
 
 /**
  * vgic_v3_probe - probe for a VGICv3 compatible interrupt controller
-- 
1.8.3.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
