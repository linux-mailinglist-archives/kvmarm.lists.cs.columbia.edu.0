Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2779D17130B
	for <lists+kvmarm@lfdr.de>; Thu, 27 Feb 2020 09:49:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE9E04AFAB;
	Thu, 27 Feb 2020 03:49:19 -0500 (EST)
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
	with ESMTP id Kb+lz5DuIYy7; Thu, 27 Feb 2020 03:49:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A40BF4AF58;
	Thu, 27 Feb 2020 03:49:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F26CF4AF44
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Feb 2020 03:49:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RTtxZJVpNT07 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 27 Feb 2020 03:49:16 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D60D84AEE1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 27 Feb 2020 03:49:15 -0500 (EST)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1FE62467B;
 Thu, 27 Feb 2020 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582793355;
 bh=W4eq3oKBNtn5njtCQFUl0E8W7deUmxpRXFBznDlnmPc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GWg6a4X86jnLVYeXklLgcO156TnY++Xe71DSE6B1Y2Dk/Puxcd0a8LMs3S0xl5CFX
 5YlbgPgfYKgyFMe1wYpSYNS9erfRpNc1gh2Fq6vTszeT2r9rd+OFjzSzuA3OpDO4u2
 Mmx5ZuMnIcG1AOK95gK1Usu2hj4aFWzw+k/5D5Ss=
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] openrisc: add support for folded p4d page tables
Date: Thu, 27 Feb 2020 10:46:00 +0200
Message-Id: <20200227084608.18223-7-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200227084608.18223-1-rppt@kernel.org>
References: <20200227084608.18223-1-rppt@kernel.org>
MIME-Version: 1.0
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linux-hexagon@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Jonas Bonn <jonas@southpole.se>, linux-arch@vger.kernel.org,
 Brian Cain <bcain@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>, Tony Luck <tony.luck@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
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

From: Mike Rapoport <rppt@linux.ibm.com>

Implement primitives necessary for the 4th level folding, add walks of p4d
level where appropriate and remove usage of __ARCH_USE_5LEVEL_HACK.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/openrisc/include/asm/pgtable.h |  1 -
 arch/openrisc/mm/fault.c            | 10 ++++++++--
 arch/openrisc/mm/init.c             |  4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 248d22d8faa7..c072943fc721 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -21,7 +21,6 @@
 #ifndef __ASM_OPENRISC_PGTABLE_H
 #define __ASM_OPENRISC_PGTABLE_H
 
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 5d4d3a9691d0..44aa04545de3 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -296,6 +296,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 		int offset = pgd_index(address);
 		pgd_t *pgd, *pgd_k;
+		p4d_t *p4d, *p4d_k;
 		pud_t *pud, *pud_k;
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
@@ -322,8 +323,13 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 		 * it exists.
 		 */
 
-		pud = pud_offset(pgd, address);
-		pud_k = pud_offset(pgd_k, address);
+		p4d = p4d_offset(pgd, address);
+		p4d_k = p4d_offset(pgd_k, address);
+		if (!p4d_present(*p4d_k))
+			goto no_context;
+
+		pud = pud_offset(p4d, address);
+		pud_k = pud_offset(p4d_k, address);
 		if (!pud_present(*pud_k))
 			goto no_context;
 
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 1f87b524db78..2536aeae0975 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -71,6 +71,7 @@ static void __init map_ram(void)
 	unsigned long v, p, e;
 	pgprot_t prot;
 	pgd_t *pge;
+	p4d_t *p4e;
 	pud_t *pue;
 	pmd_t *pme;
 	pte_t *pte;
@@ -90,7 +91,8 @@ static void __init map_ram(void)
 
 		while (p < e) {
 			int j;
-			pue = pud_offset(pge, v);
+			p4e = p4d_offset(pge, v);
+			pue = pud_offset(p4e, v);
 			pme = pmd_offset(pue, v);
 
 			if ((u32) pue != (u32) pge || (u32) pme != (u32) pge) {
-- 
2.24.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
