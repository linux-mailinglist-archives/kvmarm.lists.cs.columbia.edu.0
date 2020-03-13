Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5012E18430A
	for <lists+kvmarm@lfdr.de>; Fri, 13 Mar 2020 10:00:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D8BD64AEF7;
	Fri, 13 Mar 2020 05:00:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wATzFFYUU-8s; Fri, 13 Mar 2020 05:00:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C67504AEE3;
	Fri, 13 Mar 2020 05:00:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2BF344A541
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Mar 2020 05:00:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5WNAvedLkFK for <kvmarm@lists.cs.columbia.edu>;
 Fri, 13 Mar 2020 05:00:28 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B9A834A536
 for <kvmarm@lists.cs.columbia.edu>; Fri, 13 Mar 2020 05:00:27 -0400 (EDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 628A81046C273E8B1C8A;
 Fri, 13 Mar 2020 17:00:23 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Mar 2020
 17:00:19 +0800
From: linmiaohe <linmiaohe@huawei.com>
To: <maz@kernel.org>
Subject: [PATCH RESEND] KVM: arm: fix missing free_percpu_irq in
 kvm_timer_hyp_init()
Date: Fri, 13 Mar 2020 17:03:09 +0800
Message-ID: <1584090189-20301-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

From: Miaohe Lin <linmiaohe@huawei.com>

When host_ptimer_irq request irq resource failed, we forget to release the
host_vtimer_irq resource already requested. Fix this missing irq release
and other similar scenario.

Fixes: 9e01dc76be6a ("KVM: arm/arm64: arch_timer: Assign the phys timer on VHE systems")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 virt/kvm/arm/arch_timer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index e2bb5bd60227..fe958255ae2b 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -935,7 +935,7 @@ int kvm_timer_hyp_init(bool has_gic)
 					    kvm_get_running_vcpus());
 		if (err) {
 			kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
-			goto out_free_irq;
+			goto out_free_vtime_irq;
 		}
 
 		static_branch_enable(&has_gic_active_state);
@@ -960,7 +960,7 @@ int kvm_timer_hyp_init(bool has_gic)
 		if (err) {
 			kvm_err("kvm_arch_timer: can't request ptimer interrupt %d (%d)\n",
 				host_ptimer_irq, err);
-			return err;
+			goto out_free_vtime_irq;
 		}
 
 		if (has_gic) {
@@ -968,7 +968,7 @@ int kvm_timer_hyp_init(bool has_gic)
 						    kvm_get_running_vcpus());
 			if (err) {
 				kvm_err("kvm_arch_timer: error setting vcpu affinity\n");
-				goto out_free_irq;
+				goto out_free_ptime_irq;
 			}
 		}
 
@@ -977,14 +977,17 @@ int kvm_timer_hyp_init(bool has_gic)
 		kvm_err("kvm_arch_timer: invalid physical timer IRQ: %d\n",
 			info->physical_irq);
 		err = -ENODEV;
-		goto out_free_irq;
+		goto out_free_vtime_irq;
 	}
 
 	cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
 			  "kvm/arm/timer:starting", kvm_timer_starting_cpu,
 			  kvm_timer_dying_cpu);
 	return 0;
-out_free_irq:
+
+out_free_ptime_irq:
+	free_percpu_irq(host_ptimer_irq, kvm_get_running_vcpus());
+out_free_vtime_irq:
 	free_percpu_irq(host_vtimer_irq, kvm_get_running_vcpus());
 	return err;
 }
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
