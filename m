Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 237831E8301
	for <lists+kvmarm@lfdr.de>; Fri, 29 May 2020 18:04:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA5434B273;
	Fri, 29 May 2020 12:04:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hOVezEVAxFZ4; Fri, 29 May 2020 12:04:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D7484B28E;
	Fri, 29 May 2020 12:04:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A0DB24B0D0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 12:04:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Usnac-pyZitE for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 May 2020 12:04:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6B4344B29D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 12:04:09 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E933207BC;
 Fri, 29 May 2020 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590768248;
 bh=9yqTa5LpsDYSLQJHPcL8M1lq28IIleOmSLUASgoqcAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NApHd2XIa3F6tKzwVofEEEZMTW7hh6FA33rvqkQ7U+GcMi1d/qgBKMXQliiJTtYsl
 9h68Kc2wlC3BW6Qr6mc4kiYm6D8YPDiMDxOwzXvqpF2xLSPc2TRPmSGFTnaM4Hfe/8
 MoMLMCRTeaZ/pDmTZmTnkFq4wyLM/guOtw8aRKAU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jehSC-00GJKc-Tk; Fri, 29 May 2020 17:01:53 +0100
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 13/24] KVM: arm64: Support enabling dirty log gradually in
 small chunks
Date: Fri, 29 May 2020 17:01:10 +0100
Message-Id: <20200529160121.899083-14-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529160121.899083-1-maz@kernel.org>
References: <20200529160121.899083-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, alexandru.elisei@arm.com,
 ascull@google.com, ardb@kernel.org, christoffer.dall@arm.com,
 dbrazdil@google.com, tabba@google.com, james.morse@arm.com, giangyi@amazon.com,
 zhukeqian1@huawei.com, mark.rutland@arm.com, suzuki.poulose@arm.com,
 will@kernel.org, yuzenghui@huawei.com, julien.thierry.kdev@gmail.com,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Jiang Yi <giangyi@amazon.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
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

From: Keqian Zhu <zhukeqian1@huawei.com>

There is already support of enabling dirty log gradually in small chunks
for x86 in commit 3c9bd4006bfc ("KVM: x86: enable dirty log gradually in
small chunks"). This adds support for arm64.

x86 still writes protect all huge pages when DIRTY_LOG_INITIALLY_ALL_SET
is enabled. However, for arm64, both huge pages and normal pages can be
write protected gradually by userspace.

Under the Huawei Kunpeng 920 2.6GHz platform, I did some tests on 128G
Linux VMs with different page size. The memory pressure is 127G in each
case. The time taken of memory_global_dirty_log_start in QEMU is listed
below:

Page Size      Before    After Optimization
  4K            650ms         1.8ms
  2M             4ms          1.8ms
  1G             2ms          1.8ms

Besides the time reduction, the biggest improvement is that we will minimize
the performance side effect (because of dissolving huge pages and marking
memslots dirty) on guest after enabling dirty log.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200413122023.52583-1-zhukeqian1@huawei.com
---
 Documentation/virt/kvm/api.rst    |  2 +-
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/mmu.c              | 12 ++++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index efbbe570aa9b..0017f63fa44f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5777,7 +5777,7 @@ will be initialized to 1 when created.  This also improves performance because
 dirty logging can be enabled gradually in small chunks on the first call
 to KVM_CLEAR_DIRTY_LOG.  KVM_DIRTY_LOG_INITIALLY_SET depends on
 KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (it is also only available on
-x86 for now).
+x86 and arm64 for now).
 
 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 was previously available under the name
 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT, but the implementation had bugs that make
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 32c8a675e5a4..a723f84fab83 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -46,6 +46,9 @@
 #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
 #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
 
+#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
+				     KVM_DIRTY_LOG_INITIALLY_SET)
+
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 extern unsigned int kvm_sve_max_vl;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 66eb8e3f6e8c..ddf85bf21897 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -2277,8 +2277,16 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	 * allocated dirty_bitmap[], dirty pages will be tracked while the
 	 * memory slot is write protected.
 	 */
-	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES)
-		kvm_mmu_wp_memory_region(kvm, mem->slot);
+	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+		/*
+		 * If we're with initial-all-set, we don't need to write
+		 * protect any pages because they're all reported as dirty.
+		 * Huge pages and normal pages will be write protect gradually.
+		 */
+		if (!kvm_dirty_log_manual_protect_and_init_set(kvm)) {
+			kvm_mmu_wp_memory_region(kvm, mem->slot);
+		}
+	}
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
