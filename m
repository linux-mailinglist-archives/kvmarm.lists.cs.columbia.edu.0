Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE52A237F
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 04:37:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8ACD24B4F4;
	Sun,  1 Nov 2020 22:37:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id waUZ9YrVV72z; Sun,  1 Nov 2020 22:37:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E3034B4E8;
	Sun,  1 Nov 2020 22:37:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 326054B4E1
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Nov 2020 22:37:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cMNF1Trxiw5q for <kvmarm@lists.cs.columbia.edu>;
 Sun,  1 Nov 2020 22:37:18 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 447834B485
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 Nov 2020 22:37:17 -0500 (EST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPdrm3tT4zLp34;
 Mon,  2 Nov 2020 11:37:12 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 11:37:04 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <kvmarm@lists.cs.columbia.edu>
Subject: [RFC v3 02/12] arm64: Introduce check_features
Date: Mon, 2 Nov 2020 11:34:12 +0800
Message-ID: <20201102033422.657391-3-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102033422.657391-1-liangpeng10@huawei.com>
References: <20201102033422.657391-1-liangpeng10@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, maz@kernel.org,
 will@kernel.org
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

To emulate ID registers, we need to validate the value of the register
defined by user space.  For most ID registers, we need to check whether
each field defined by user space is no more than that of host (whether
host support the corresponding features) and whether the fields are
supposed to be exposed to guest.  Introduce check_features to do those
jobs.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 arch/arm64/include/asm/cpufeature.h |  2 ++
 arch/arm64/kernel/cpufeature.c      | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8ea2c4307708..e0e5dcffe58a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -579,6 +579,8 @@ void check_local_cpu_capabilities(void);
 
 u64 read_sanitised_ftr_reg(u32 id);
 
+int check_features(u32 sys_reg, u64 val);
+
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
 	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6e31d3fbd791..f78cd50a1980 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2868,3 +2868,26 @@ int arm64_cpu_ftr_regs_traverse(int (*op)(u32, u64, void *), void *argp)
 	}
 	return 0;
 }
+
+int check_features(u32 sys_reg, u64 val)
+{
+	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
+	const struct arm64_ftr_bits *ftrp;
+	u64 exposed_mask = 0;
+
+	if (!reg)
+		return -ENOENT;
+
+	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
+		if (arm64_ftr_value(ftrp, reg->sys_val) <
+		    arm64_ftr_value(ftrp, val)) {
+			return -EINVAL;
+		}
+		exposed_mask |= arm64_ftr_mask(ftrp);
+	}
+
+	if (val & ~exposed_mask)
+		return -EINVAL;
+
+	return 0;
+}
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
