Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 27B61457D15
	for <lists+kvmarm@lfdr.de>; Sat, 20 Nov 2021 11:36:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D00474B154;
	Sat, 20 Nov 2021 05:36:11 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0-QdnTNj5FW; Sat, 20 Nov 2021 05:36:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 40CF24B177;
	Sat, 20 Nov 2021 05:36:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FEC14B164
 for <kvmarm@lists.cs.columbia.edu>; Sat, 20 Nov 2021 05:29:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejnwVnqE8+1r for <kvmarm@lists.cs.columbia.edu>;
 Sat, 20 Nov 2021 05:29:11 -0500 (EST)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8E4624ACC9
 for <kvmarm@lists.cs.columbia.edu>; Sat, 20 Nov 2021 05:29:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=IhomdJGyEpT4miSx3PHsvuZfOTBIMbEy9yEOpBFWNhc=; b=PebOsbaBKPEA3ueig3yxQlkh3h
 tDXBjTVG3I3JuVTbe5f6YBBgxdb7NJAyHq2+V329XZil5EUkOBjSz1YtbWYOiIPyCiyzwco1n2TR+
 IWla9K2IkpauoCljITfb1664XyhfYiNdLEUuYygz2WO2jYWC6WHc+2qPrV1vZj6ibGnEop5wz/mQk
 1BmeBwvuV+RQF7SW7RytQ/SgToAPaOy0CjgZ3df9/nnZjcnrEGn1hGYGKokqci8/Q2njaF/1yNQAE
 B8M9JY32tPj1M/DqZrpGyE55ixXawXj4okPzUHoHPr1Ua5/09CfugOKb7y9mis+TDpmVuLmWMdQ+P
 W9LIZhNw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1moNbR-00H55y-I8; Sat, 20 Nov 2021 10:28:13 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1moNbQ-0002K8-AN; Sat, 20 Nov 2021 10:28:12 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm <kvm@vger.kernel.org>
Subject: [PATCH v4 02/11] KVM: Add Makefile.kvm for common files,
 use it for x86
Date: Sat, 20 Nov 2021 10:28:01 +0000
Message-Id: <20211120102810.8858-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120102810.8858-1-dwmw2@infradead.org>
References: <20211120102810.8858-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Sat, 20 Nov 2021 05:36:05 -0500
Cc: Anup Patel <anup.patel@wdc.com>,
 "wanpengli @ tencent . com" <wanpengli@tencent.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Joao Martins <joao.m.martins@oracle.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, "joro @ 8bytes . org" <joro@8bytes.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, karahmed@amazon.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "jmattson @ google . com" <jmattson@google.com>,
 "mtosatti @ redhat . com" <mtosatti@redhat.com>, linux-mips@vger.kernel.org,
 kvm-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 "vkuznets @ redhat . com" <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
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

From: David Woodhouse <dwmw@amazon.co.uk>

Splitting kvm_main.c out into smaller and better-organized files is
slightly non-trivial when it involves editing a bunch of per-arch
KVM makefiles. Provide virt/kvm/Makefile.kvm for them to include.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Marc Zyngier <maz@kernel.org>
---
 arch/x86/kvm/Makefile |  7 +------
 virt/kvm/Makefile.kvm | 13 +++++++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)
 create mode 100644 virt/kvm/Makefile.kvm

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 75dfd27b6e8a..30f244b64523 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -7,12 +7,7 @@ ifeq ($(CONFIG_FRAME_POINTER),y)
 OBJECT_FILES_NON_STANDARD_vmenter.o := y
 endif
 
-KVM := ../../../virt/kvm
-
-kvm-y			+= $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
-				$(KVM)/eventfd.o $(KVM)/irqchip.o $(KVM)/vfio.o \
-				$(KVM)/dirty_ring.o $(KVM)/binary_stats.o
-kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
+include $(srctree)/virt/kvm/Makefile.kvm
 
 kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
new file mode 100644
index 000000000000..ffdcad3cc97a
--- /dev/null
+++ b/virt/kvm/Makefile.kvm
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Kernel-based Virtual Machine module
+#
+
+KVM ?= ../../../virt/kvm
+
+kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
+kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
+kvm-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
+kvm-$(CONFIG_KVM_ASYNC_PF) += $(KVM)/async_pf.o
+kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
+kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
