Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEC298C14
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 12:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 510794B250;
	Mon, 26 Oct 2020 07:25:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@nvidia.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q1gMo3Fm6ucD; Mon, 26 Oct 2020 07:25:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1ED4B4B217;
	Mon, 26 Oct 2020 07:25:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EB7664B1F9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 07:25:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cPQDBRqNO2Fl for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 07:25:09 -0400 (EDT)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id ADFC74B56A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 07:25:09 -0400 (EDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f96b21c0000>; Mon, 26 Oct 2020 04:25:16 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 26 Oct 2020 04:25:08 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 26 Oct 2020 04:25:08 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 11:25:08 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 11:25:06 +0000
Received: from santosh-System-Product-Name.nvidia.com (172.20.13.39) by
 mail.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Oct 2020 11:25:02 +0000
From: Santosh Shukla <sashukla@nvidia.com>
To: <maz@kernel.org>, <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/1] KVM: arm64: fix the mmio faulting
Date: Mon, 26 Oct 2020 16:54:06 +0530
Message-ID: <1603711447-11998-1-git-send-email-sashukla@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603711516; bh=gagsFxX9VGPMNvFi2BG28Wch0bVOveZzbh0HO/8H9CA=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:Content-Type;
 b=LrCvbjDDp55D05uT4h/hOdxPe+SYyVKXgbd+plTO4flDu/bxIkMNZEPFTQIGhI1R8
 NowiEY30RoixATcVHccl7VZ/LsEYy9xVOlDIyI1D0eP28WMPo4LOJ+CdGu2ieVz28f
 hvPCHqRbfuYwqSA92bMRSNtJK5mm9k261qpioF90AzMRvkrV8W0JnA3a8Xn2sxUn8B
 1a+X0udG11vaGvSJvDLkxFX0qIn87NyEBYa0c3bt4De6zuYdWxCVSY218Tzzrqdecd
 sXQ1hOg8M8Eou/bsjujArQFmYV6BOKqyOu/WxvP1Ki1X+mnNDyUBv8MZlQ9Idwxe0n
 wpKq6neJWRLUA==
Cc: mcrossley@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Description of the Reproducer scenario as asked in the thread [1].

Tried to create the reproducer scenario with vfio-pci driver using
nvidia GPU in PT mode, As because vfio-pci driver now supports
vma faulting (/vfio_pci_mmap_fault) so could create a crude reproducer
situation with that.

To create the repro - I did an ugly hack into arm64/kvm/mmu.c.
The hack is to make sure that stage2 mapping are not created
at the time of vm_init by unsetting VM_PFNMAP flag. This `unsetting` flag
needed because vfio-pci's mmap func(/vfio_pci_mmap) by-default
sets the VM_PFNMAP flag for the MMIO region but I want
the remap_pfn_range() func to set the _PFNMAP flag via vfio's fault
handler func vfio_pci_mmap_fault().

So with above, when guest access the MMIO region, this will
trigger the mmio fault path at arm64-kvm hypervisor layer like below:
user_mem_abort() {->...
    --> Check the VM_PFNMAP flag, since not set so marks force_pte=false
    ....
    __gfn_to_pfn_memslot()-->
    ...
    handle_mm_fault()-->
    do_fault()-->
    vfio_pci_mmio_fault()-->
    remap_pfn_range()--> Now will set the VM_PFNMAP flag.
}

Since the force_pte flag is set to false so will lead to THP oops.
By setting the force_pte=true will avoid the THP Oops which was
mentioned in the [2] and patch proposition [1/1] fixes that.

hackish change to reproduce scenario:
--->
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d4cd25334610..b0a999aa6a95 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1318,6 +1318,12 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		vm_start = max(hva, vma->vm_start);
 		vm_end = min(reg_end, vma->vm_end);
 
+		/* Hack to make sure stage2 mapping not present, thus trigger
+		 * user_mem_abort for stage2 mapping
+		 */
+		if (vma->vm_flags & VM_PFNMAP) {
+			vma->vm_flags = vma->vm_flags & (~VM_PFNMAP);
+		}
 		if (vma->vm_flags & VM_PFNMAP) {
 			gpa_t gpa = mem->guest_phys_addr +
 				    (vm_start - mem->userspace_addr);


Thanks.
Santosh

[1] https://lkml.org/lkml/2020/10/23/310
[2] https://lkml.org/lkml/2020/10/21/460


Santosh Shukla (1):
  KVM: arm64: Correctly handle the mmio faulting

 arch/arm64/kvm/mmu.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
