Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9A46B342D05
	for <lists+kvmarm@lfdr.de>; Sat, 20 Mar 2021 14:28:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B60B74B2CA;
	Sat, 20 Mar 2021 09:28:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2787p7F7XnU0; Sat, 20 Mar 2021 09:28:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5911F4B19E;
	Sat, 20 Mar 2021 09:28:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F14A14B664
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 12:18:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZH-Z1GaxQmP for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Mar 2021 12:17:59 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E1C184B606
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 12:17:59 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88794101E;
 Fri, 19 Mar 2021 09:17:59 -0700 (PDT)
Received: from yoan-MS-7758.Home (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32F343F718;
 Fri, 19 Mar 2021 09:17:58 -0700 (PDT)
From: Yoan Picchi <yoan.picchi@arm.com>
To: maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH 1/7] KVM: arm64: Add two page mapping counters for kvm_stat
Date: Fri, 19 Mar 2021 16:17:05 +0000
Message-Id: <20210319161711.24972-2-yoan.picchi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319161711.24972-1-yoan.picchi@arm.com>
References: <20210319161711.24972-1-yoan.picchi@arm.com>
X-Mailman-Approved-At: Sat, 20 Mar 2021 09:28:53 -0400
Cc: catalin.marinas@arm.com, Yoan Picchi <yoan.picchi@arm.com>, will@kernel.org
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

Add a counter for when a regular page is mapped, and another
for when a huge page is mapped.

Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 ++
 arch/arm64/kvm/guest.c            | 2 ++
 arch/arm64/kvm/mmu.c              | 7 +++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3d10e6527..863603285 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -561,6 +561,8 @@ struct kvm_vcpu_stat {
 	u64 wfi_exit_stat;
 	u64 mmio_exit_user;
 	u64 mmio_exit_kernel;
+	u64 regular_page_mapped;
+	u64 huge_page_mapped;
 	u64 exits;
 };
 
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 9bbd30e62..14b15fb8f 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -38,6 +38,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
 	VCPU_STAT("mmio_exit_user", mmio_exit_user),
 	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
+	VCPU_STAT("regular_page_mapped", regular_page_mapped),
+	VCPU_STAT("huge_page_mapped", huge_page_mapped),
 	VCPU_STAT("exits", exits),
 	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
 	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 77cb2d28f..3996b28da 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -914,6 +914,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		mark_page_dirty(kvm, gfn);
 	}
 
+	if (ret >= 0) {
+		if (vma_pagesize == PAGE_SIZE) {
+			vcpu->stat.regular_page_mapped++;
+		} else {
+			vcpu->stat.huge_page_mapped++;
+		}
+	}
 out_unlock:
 	spin_unlock(&kvm->mmu_lock);
 	kvm_set_pfn_accessed(pfn);
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
