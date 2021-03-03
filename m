Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 585D732AE16
	for <lists+kvmarm@lfdr.de>; Wed,  3 Mar 2021 03:42:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 01F514B717;
	Tue,  2 Mar 2021 21:42:42 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gns4wPquzhYN; Tue,  2 Mar 2021 21:42:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD7E24B707;
	Tue,  2 Mar 2021 21:42:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DF974B707
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Mar 2021 21:42:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tSmRKDhWcanL for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Mar 2021 21:42:39 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 10F0A4B67B
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Mar 2021 21:42:39 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D8B71FB;
 Tue,  2 Mar 2021 18:42:38 -0800 (PST)
Received: from entos-ampere-02.shanghai.arm.com
 (entos-ampere-02.shanghai.arm.com [10.169.214.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A34EE3F73B;
 Tue,  2 Mar 2021 18:42:34 -0800 (PST)
From: Jia He <justin.he@arm.com>
To: Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Date: Wed,  3 Mar 2021 10:42:25 +0800
Message-Id: <20210303024225.2591-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jia He <justin.he@arm.com>,
 Will Deacon <will@kernel.org>
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

If the start addr is not aligned with the granule size of that level.
loop step size should be adjusted to boundary instead of simple
kvm_granual_size(level) increment. Otherwise, some mmu entries might miss
the chance to be walked through.
E.g. Assume the unmap range [data->addr, data->end] is
[0xff00ab2000,0xff00cb2000] in level 2 walking and NOT block mapping.
And the 1st part of that pmd entry is [0xff00ab2000,0xff00c00000]. The
pmd value is 0x83fbd2c1002 (not valid entry). In this case, data->addr
should be adjusted to 0xff00c00000 instead of 0xff00cb2000.

Without this fix, userspace "segment fault" error can be easily
triggered by running simple gVisor runsc cases on an Ampere Altra
server:
    docker run --runtime=runsc -it --rm  ubuntu /bin/bash

In container:
    for i in `seq 1 100`;do ls;done

Reported-by: Howard Zhang <Howard.Zhang@arm.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index bdf8e55ed308..4d99d07c610c 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -225,6 +225,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
 		goto out;
 
 	if (!table) {
+		data->addr = ALIGN_DOWN(data->addr, kvm_granule_size(level));
 		data->addr += kvm_granule_size(level);
 		goto out;
 	}
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
