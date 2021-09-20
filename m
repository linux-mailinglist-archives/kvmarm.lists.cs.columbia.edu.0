Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4225D4127D9
	for <lists+kvmarm@lfdr.de>; Mon, 20 Sep 2021 23:19:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C645B4B08D;
	Mon, 20 Sep 2021 17:19:44 -0400 (EDT)
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
	with ESMTP id tb5yqDoNCuUu; Mon, 20 Sep 2021 17:19:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A0F2C4B086;
	Mon, 20 Sep 2021 17:19:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C1BF4B09C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 06:05:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xc0pJ+OyJqqt for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Sep 2021 06:05:22 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8AB064B08A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 06:05:22 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCB760F21;
 Mon, 20 Sep 2021 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632132320;
 bh=BQ/pJEAhwojVoXtwSmRnTJ5Rlh46slyFWdQtV+Ah9rk=;
 h=From:To:Cc:Subject:Date:From;
 b=QsMHE9cHRVHvL8TUDwOHjUyfsYxJwqNDZmA2zBcwiVPnbOZ25NxJ4zdovMO4c1oRk
 R0hnaa7WcCV7cJ8mVF5oZoNinUu4YmkzZyiASj/ni+NkMWrleyFV7+No5ltYAyW5gp
 rEcwqCdSa+5Ao6D2nyS/YuxlvrGSZSjBewJ9tLB8pDAeIsVN/+lg5O4vBrCT6tw25t
 BTW/yDARFOjM7AAF1RpeKx/tOIB9azMOXWktc5+WSAa7eBy4fCr64Vs9htrdPUwDs3
 zRSSGQNHt1og8bbBuW8ySHKOsejbT8uOgyXKXm+D+ObD65slQOFAFbKd46WrGH0Zvz
 C5m5PWMxh0Ilw==
From: Arnd Bergmann <arnd@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, David Brazdil <dbrazdil@google.com>
Subject: [PATCH] KVM: arm: add Kbuild FORCE prerequisite for hyp-reloc
Date: Mon, 20 Sep 2021 12:05:10 +0200
Message-Id: <20210920100515.1554788-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 20 Sep 2021 17:19:43 -0400
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

From: Arnd Bergmann <arnd@arndb.de>

Commit e1f86d7b4b2a ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule)
and filechk") added a helpful check for Kbuild, which now notices
that a problem with the hyp-reloc rule:

arch/arm64/kvm/hyp/nvhe/Makefile:58: FORCE prerequisite is missing

Do as suggested and add FORCE here.

Fixes: 8c49b5d43d4c ("KVM: arm64: Generate hyp relocation data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 5df6193fc430..8d741f71377f 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -54,7 +54,7 @@ $(obj)/kvm_nvhe.tmp.o: $(obj)/hyp.lds $(addprefix $(obj)/,$(hyp-obj)) FORCE
 #    runtime. Because the hypervisor is part of the kernel binary, relocations
 #    produce a kernel VA. We enumerate relocations targeting hyp at build time
 #    and convert the kernel VAs at those positions to hyp VAs.
-$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel
+$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel FORCE
 	$(call if_changed,hyprel)
 
 # 5) Compile hyp-reloc.S and link it into the existing partially linked object.
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
