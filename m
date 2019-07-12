Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A3CEE6690F
	for <lists+kvmarm@lfdr.de>; Fri, 12 Jul 2019 10:23:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E7CA24A4F8;
	Fri, 12 Jul 2019 04:23:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -0.591
X-Spam-Level: 
X-Spam-Status: No, score=-0.591 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_MED=-2.3, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.de
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5aIU-so463+L; Fri, 12 Jul 2019 04:23:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E59D4A534;
	Fri, 12 Jul 2019 04:23:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 689394A4BE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Jul 2019 04:23:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7S8Lx4HjEiOZ for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Jul 2019 04:22:59 -0400 (EDT)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 03BBE4A4A9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Jul 2019 04:22:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1562919778; x=1594455778;
 h=from:to:cc:subject:date:message-id;
 bh=2GHXvodd5mYiOI7g2dcIp8dLyBwMPtlaooER9mc1rHw=;
 b=gyUhg1vsaIObtkpZPaaVVpaxpkwOoilN48zS4zmf1/WpGmnvERXfrHGP
 hbrxp580FhpbN98lvIxaQdW3MpmppEWgpPaxNNiV7ON4TraQzn5J3wL+9
 V3yhqCOzqdjbonazKrK4zF9dQmFEWD1OOxtARQnS0Ym4UdCWTetSN6PXM 8=;
X-IronPort-AV: E=Sophos;i="5.62,481,1554768000"; d="scan'208";a="404647834"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.124.125.6])
 by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
 12 Jul 2019 08:22:57 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com
 (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
 by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS
 id 8BFEEA252A; Fri, 12 Jul 2019 08:22:53 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
 by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id
 x6C8MoPk016257; Fri, 12 Jul 2019 10:22:50 +0200
Received: (from karahmed@localhost)
 by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id
 x6C8MnRH016242; Fri, 12 Jul 2019 10:22:49 +0200
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] KVM: arm/arm64: Properly check for MMIO regions
Date: Fri, 12 Jul 2019 10:22:08 +0200
Message-Id: <1562919728-642-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Cc: KarimAllah Ahmed <karahmed@amazon.de>, Marc Zyngier <marc.zyngier@arm.com>,
 kvmarm@lists.cs.columbia.edu
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

Valid RAM can live outside kernel control (e.g. using "mem=" command-line
parameter). This memory can still be used as valid guest memory for KVM. So
ensure that we validate that this memory is definitely not "RAM" before
assuming that it is an MMIO region.

One way to use memory outside kernel control is:

1- Pass 'mem=' in the kernel command-line to limit the amount of memory managed
   by the kernel.
2- Map this physical memory you want to give to the guest with:
   mmap("/dev/mem", physical_address_offset, ..)
3- Use the user-space virtual address as the "userspace_addr" field in
   KVM_SET_USER_MEMORY_REGION ioctl.

One of the limitations of the current /dev/mem for ARM is that it would map
this memory as uncached without this patch:
https://lkml.org/lkml/2019/7/11/684

This work is similar to the work done on x86 here:
https://lkml.org/lkml/2019/1/31/933

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Suzuki K Pouloze <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 virt/kvm/arm/mmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 06180c9..2105134 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -8,6 +8,7 @@
 #include <linux/kvm_host.h>
 #include <linux/io.h>
 #include <linux/hugetlb.h>
+#include <linux/memblock.h>
 #include <linux/sched/signal.h>
 #include <trace/events/kvm.h>
 #include <asm/pgalloc.h>
@@ -89,7 +90,7 @@ static void kvm_flush_dcache_pud(struct kvm *kvm,
 
 static bool kvm_is_device_pfn(unsigned long pfn)
 {
-	return !pfn_valid(pfn);
+	return !memblock_is_memory(__pfn_to_phys(pfn));
 }
 
 /**
@@ -949,6 +950,7 @@ static void stage2_unmap_memslot(struct kvm *kvm,
 	do {
 		struct vm_area_struct *vma = find_vma(current->mm, hva);
 		hva_t vm_start, vm_end;
+		gpa_t gpa;
 
 		if (!vma || vma->vm_start >= reg_end)
 			break;
@@ -959,11 +961,14 @@ static void stage2_unmap_memslot(struct kvm *kvm,
 		vm_start = max(hva, vma->vm_start);
 		vm_end = min(reg_end, vma->vm_end);
 
-		if (!(vma->vm_flags & VM_PFNMAP)) {
-			gpa_t gpa = addr + (vm_start - memslot->userspace_addr);
-			unmap_stage2_range(kvm, gpa, vm_end - vm_start);
-		}
 		hva = vm_end;
+
+		if ((vma->vm_flags & VM_PFNMAP) &&
+		    !memblock_is_memory(__pfn_to_phys(vma->vm_pgoff)))
+			continue;
+
+		gpa = addr + (vm_start - memslot->userspace_addr);
+		unmap_stage2_range(kvm, gpa, vm_end - vm_start);
 	} while (hva < reg_end);
 }
 
@@ -2329,7 +2334,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		vm_start = max(hva, vma->vm_start);
 		vm_end = min(reg_end, vma->vm_end);
 
-		if (vma->vm_flags & VM_PFNMAP) {
+		if ((vma->vm_flags & VM_PFNMAP) &&
+		    !memblock_is_memory(__pfn_to_phys(vma->vm_pgoff))) {
 			gpa_t gpa = mem->guest_phys_addr +
 				    (vm_start - mem->userspace_addr);
 			phys_addr_t pa;
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
