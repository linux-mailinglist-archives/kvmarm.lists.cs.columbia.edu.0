Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A6218303D6E
	for <lists+kvmarm@lfdr.de>; Tue, 26 Jan 2021 13:45:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A35C4B219;
	Tue, 26 Jan 2021 07:45:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JmuWmRiRSqB7; Tue, 26 Jan 2021 07:45:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FE784B281;
	Tue, 26 Jan 2021 07:45:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA7364B27C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Jan 2021 07:45:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qQck3xe3tTn9 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 Jan 2021 07:45:16 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CA13A4B21B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Jan 2021 07:45:15 -0500 (EST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DQ5yR0MSnzjDYt;
 Tue, 26 Jan 2021 20:43:59 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 20:45:02 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, Marc Zyngier
 <maz@kernel.org>, Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>
Subject: [RFC PATCH 1/7] arm64: cpufeature: Add API to report system support
 of HWDBM
Date: Tue, 26 Jan 2021 20:44:38 +0800
Message-ID: <20210126124444.27136-2-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210126124444.27136-1-zhukeqian1@huawei.com>
References: <20210126124444.27136-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: yubihong@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, zhengchuan@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Though we already has a cpu capability named ARM64_HW_DBM, it's a
LOCAL_CPU cap and conditionally compiled by CONFIG_ARM64_HW_AFDBM.

This reports the system wide support of HW_DBM.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 arch/arm64/include/asm/cpufeature.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9a555809b89c..dfded86c7684 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -664,6 +664,18 @@ static inline bool system_supports_mixed_endian(void)
 	return val == 0x1;
 }
 
+static inline bool system_supports_hw_dbm(void)
+{
+	u64 mmfr1;
+	u32 val;
+
+	mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr1,
+						ID_AA64MMFR1_HADBS_SHIFT);
+
+	return val == 0x2;
+}
+
 static __always_inline bool system_supports_fpsimd(void)
 {
 	return !cpus_have_const_cap(ARM64_HAS_NO_FPSIMD);
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
