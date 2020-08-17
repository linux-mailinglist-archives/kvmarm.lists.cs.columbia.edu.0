Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 00725245B15
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 05:38:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D05B4BD73;
	Sun, 16 Aug 2020 23:38:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISJYsfcLECfH; Sun, 16 Aug 2020 23:38:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 43D914BD57;
	Sun, 16 Aug 2020 23:38:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A0AC54BD33
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Aug 2020 23:38:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L8i9-uG0eSxd for <kvmarm@lists.cs.columbia.edu>;
 Sun, 16 Aug 2020 23:38:16 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 91FCD4BCF5
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Aug 2020 23:38:16 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 71BB2E42055582206BF7;
 Mon, 17 Aug 2020 11:38:13 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.22) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 11:38:06 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
Subject: [PATCH 2/3] KVM: uapi: Remove KVM_DEV_TYPE_ARM_PV_TIME in
 kvm_device_type
Date: Mon, 17 Aug 2020 11:37:28 +0800
Message-ID: <20200817033729.10848-3-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20200817033729.10848-1-zhukeqian1@huawei.com>
References: <20200817033729.10848-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

ARM64 PV-time ST is configured by userspace through vCPU attribute,
and KVM_DEV_TYPE_ARM_PV_TIME is unused.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 include/uapi/linux/kvm.h       | 2 --
 tools/include/uapi/linux/kvm.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4fdf303..9a6b97e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1258,8 +1258,6 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
 	KVM_DEV_TYPE_XIVE,
 #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
-	KVM_DEV_TYPE_ARM_PV_TIME,
-#define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
 	KVM_DEV_TYPE_MAX,
 };
 
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 4fdf303..9a6b97e 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1258,8 +1258,6 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
 	KVM_DEV_TYPE_XIVE,
 #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
-	KVM_DEV_TYPE_ARM_PV_TIME,
-#define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
 	KVM_DEV_TYPE_MAX,
 };
 
-- 
1.8.3.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
