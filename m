Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EED8235F237
	for <lists+kvmarm@lfdr.de>; Wed, 14 Apr 2021 13:25:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B1884B677;
	Wed, 14 Apr 2021 07:25:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sKCVdmySYRvD; Wed, 14 Apr 2021 07:25:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 206D14B6E1;
	Wed, 14 Apr 2021 07:25:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 023814B49C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 07:25:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CN9-uVIpQQus for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Apr 2021 07:25:33 -0400 (EDT)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E12AA4B34F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 07:25:32 -0400 (EDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FL0Tj4nTczkjyc;
 Wed, 14 Apr 2021 19:23:37 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:25:20 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 14/16] arm64/lib: Add an helper to free memory allocated by
 the ASID allocator
Date: Wed, 14 Apr 2021 12:23:10 +0100
Message-ID: <20210414112312.13704-15-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
References: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.82.32]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, julien@xen.org, maz@kernel.org,
 linuxarm@huawei.com, catalin.marinas@arm.com, will@kernel.org
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

From: Julien Grall <julien.grall@arm.com>

Some users of the ASID allocator (e.g VMID) may need to free any
resources if the initialization fail. So introduce a function that
allows freeing of any memory allocated by the ASID allocator.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/lib_asid.h | 2 ++
 arch/arm64/lib/asid.c             | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/lib_asid.h b/arch/arm64/include/asm/lib_asid.h
index acae8d243d17..4dbc0a3f19a6 100644
--- a/arch/arm64/include/asm/lib_asid.h
+++ b/arch/arm64/include/asm/lib_asid.h
@@ -82,4 +82,6 @@ void asid_context_pinned_put(struct asid_info *info, atomic64_t *pasid,
 			     refcount_t *pinned);
 int asid_allocator_init(struct asid_info *info, u32 bits, bool pinned);
 
+void asid_allocator_free(struct asid_info *info);
+
 #endif
diff --git a/arch/arm64/lib/asid.c b/arch/arm64/lib/asid.c
index 286285616f65..7bd031f9516a 100644
--- a/arch/arm64/lib/asid.c
+++ b/arch/arm64/lib/asid.c
@@ -256,3 +256,9 @@ int asid_allocator_init(struct asid_info *info, u32 bits, bool pinned)
 
 	return 0;
 }
+
+void asid_allocator_free(struct asid_info *info)
+{
+	kfree(info->map);
+	kfree(info->pinned_map);
+}
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
