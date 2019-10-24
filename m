Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3EE323B
	for <lists+kvmarm@lfdr.de>; Thu, 24 Oct 2019 14:25:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F23B24A591;
	Thu, 24 Oct 2019 08:25:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	UNPARSEABLE_RELAY=0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LPjLANnzIxkU; Thu, 24 Oct 2019 08:25:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B41954A8B7;
	Thu, 24 Oct 2019 08:25:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CDB5E4A53F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Oct 2019 06:27:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GnbFCssSyMIP for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Oct 2019 06:27:54 -0400 (EDT)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8B9914A5EE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Oct 2019 06:27:53 -0400 (EDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=shannon.zhao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0Tg31GPl_1571912869; 
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com
 fp:SMTPD_---0Tg31GPl_1571912869) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Oct 2019 18:27:50 +0800
From: Shannon Zhao <shannon.zhao@linux.alibaba.com>
To: kvmarm@lists.cs.columbia.edu, maz@kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, christoffer.dall@arm.com
Subject: [PATCH RFC 4/7] KVM: vgic: Add hyp uninitialize function
Date: Thu, 24 Oct 2019 18:27:47 +0800
Message-Id: <1571912870-18471-5-git-send-email-shannon.zhao@linux.alibaba.com>
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

When KVM ARM exits, it needs to cleanup vgic setup by kvm_vgic_hyp_init.

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 include/kvm/arm_vgic.h        | 1 +
 virt/kvm/arm/arm.c            | 1 +
 virt/kvm/arm/vgic/vgic-init.c | 7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index af4f09c..7f44ebb 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -339,6 +339,7 @@ struct vgic_cpu {
 void kvm_vgic_vcpu_destroy(struct kvm_vcpu *vcpu);
 int kvm_vgic_map_resources(struct kvm *kvm);
 int kvm_vgic_hyp_init(void);
+void kvm_vgic_hyp_uninit(void);
 void kvm_vgic_init_cpu_hardware(void);
 
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int intid,
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index da32c9b..0c60074 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1724,6 +1724,7 @@ int kvm_arch_init(void *opaque)
 void kvm_arch_exit(void)
 {
 	kvm_perf_teardown();
+	kvm_vgic_hyp_uninit();
 	hyp_cpu_pm_exit();
 }
 
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 6f50c42..cd48047 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -550,3 +550,10 @@ int kvm_vgic_hyp_init(void)
 			kvm_get_running_vcpus());
 	return ret;
 }
+
+void kvm_vgic_hyp_uninit(void)
+{
+	cpuhp_remove_state(CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING);
+	free_percpu_irq(kvm_vgic_global_state.maint_irq,
+			kvm_get_running_vcpus());
+}
-- 
1.8.3.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
