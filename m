Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 56C7B342D0A
	for <lists+kvmarm@lfdr.de>; Sat, 20 Mar 2021 14:29:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF40F4B227;
	Sat, 20 Mar 2021 09:28:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KdbqO0XEGmg4; Sat, 20 Mar 2021 09:28:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D6A234B382;
	Sat, 20 Mar 2021 09:28:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DE074B664
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 12:18:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0660axHpjc1R for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Mar 2021 12:18:07 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6B274B5E6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Mar 2021 12:18:07 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91FD7143B;
 Fri, 19 Mar 2021 09:18:07 -0700 (PDT)
Received: from yoan-MS-7758.Home (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3AB403F718;
 Fri, 19 Mar 2021 09:18:06 -0700 (PDT)
From: Yoan Picchi <yoan.picchi@arm.com>
To: maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH 6/7] KVM: arm64: Add stage2_unmap_vm counter for kvm_stat
Date: Fri, 19 Mar 2021 16:17:10 +0000
Message-Id: <20210319161711.24972-7-yoan.picchi@arm.com>
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

Add a counter for when the one want to unmap all the ram of a VM.
This mostly happens when one restart a VM so we make sure to clear
the ram and free the memory for other VMs.

Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/guest.c            | 1 +
 arch/arm64/kvm/mmu.c              | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 76c81aa79..fa59b669c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -549,6 +549,7 @@ struct kvm_vm_stat {
 	ulong remote_tlb_flush;
 	ulong flush_all_cache_lines;
 	ulong memory_slot_unmaped;
+	ulong stage2_unmap_vm;
 	ulong cached_page_invalidated;
 };
 
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index cd227136e..129c0d53d 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -43,6 +43,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VM_STAT("remote_tlb_flush", remote_tlb_flush),
 	VM_STAT("flush_all_cache_lines", flush_all_cache_lines),
 	VM_STAT("memory_slot_unmaped", memory_slot_unmaped),
+	VM_STAT("stage2_unmap_vm", stage2_unmap_vm),
 	VM_STAT("cached_page_invalidated", cached_page_invalidated),
 	VCPU_STAT("exits", exits),
 	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1e8aeafc2..6d150a785 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -471,6 +471,8 @@ void stage2_unmap_vm(struct kvm *kvm)
 	mmap_read_lock(current->mm);
 	spin_lock(&kvm->mmu_lock);
 
+	kvm->stat.stage2_unmap_vm++;
+
 	slots = kvm_memslots(kvm);
 	kvm_for_each_memslot(memslot, slots)
 		stage2_unmap_memslot(kvm, memslot);
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
