Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7488D6560A
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jul 2019 13:51:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 276704A4E9;
	Thu, 11 Jul 2019 07:51:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SgZpUqRAjq-G; Thu, 11 Jul 2019 07:51:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DCDBE4A4FF;
	Thu, 11 Jul 2019 07:51:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CB8244A4E1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 07:51:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oNn0PRl92PBF for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jul 2019 07:51:06 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A57BB4A4CA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 07:51:06 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 051B481F12;
 Thu, 11 Jul 2019 11:51:06 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-46.ams2.redhat.com [10.36.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B39D600CD;
 Thu, 11 Jul 2019 11:50:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com, jean-philippe.brucker@arm.com, will.deacon@arm.com,
 robin.murphy@arm.com
Subject: [PATCH v9 08/14] iommu/smmuv3: Introduce
 __arm_smmu_tlb_inv_asid/s1_range_nosync
Date: Thu, 11 Jul 2019 13:49:53 +0200
Message-Id: <20190711114959.15675-9-eric.auger@redhat.com>
In-Reply-To: <20190711114959.15675-1-eric.auger@redhat.com>
References: <20190711114959.15675-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 11 Jul 2019 11:51:06 +0000 (UTC)
Cc: kevin.tian@intel.com, vincent.stehle@arm.com, ashok.raj@intel.com,
 marc.zyngier@arm.com
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

Introduce helpers to invalidate a given asid/vmid or invalidate
address ranges associated to a given asid/vmid.

S1 helpers will be used to invalidate stage 1 caches upon
userspace request, in nested mode.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 drivers/iommu/arm-smmu-v3.c | 98 ++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8785f26e669c..8b3c35ea58b2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1611,20 +1611,15 @@ static void arm_smmu_tlb_sync(void *cookie)
 	arm_smmu_cmdq_issue_sync(smmu_domain->smmu);
 }
 
-static void arm_smmu_tlb_inv_context(void *cookie)
+static void __arm_smmu_tlb_inv_asid(struct arm_smmu_domain *smmu_domain,
+				    u16 vmid, u16 asid)
 {
-	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_cmdq_ent cmd = {};
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg->cd.asid;
-		cmd.tlbi.vmid	= 0;
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg->vmid;
-	}
+	cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
+	cmd.tlbi.vmid	= vmid;
+	cmd.tlbi.asid	= asid;
 
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
@@ -1636,32 +1631,87 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	arm_smmu_cmdq_issue_sync(smmu);
 }
 
-static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
-					  size_t granule, bool leaf, void *cookie)
+static void __arm_smmu_tlb_inv_vmid(struct arm_smmu_domain *smmu_domain,
+				    u16 vmid)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_ent cmd = {};
+
+	cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
+	cmd.tlbi.vmid	= vmid;
+
+	/* See DSB related comment in __arm_smmu_tlb_inv_asid */
+	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
+}
+
+static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd = {
-		.tlbi = {
-			.leaf	= leaf,
-			.addr	= iova,
-		},
-	};
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg->cd.asid;
+		__arm_smmu_tlb_inv_asid(smmu_domain, 0,
+					smmu_domain->s1_cfg->cd.asid);
 	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg->vmid;
+		__arm_smmu_tlb_inv_vmid(smmu_domain,
+					smmu_domain->s2_cfg->vmid);
 	}
+}
 
+static void
+__arm_smmu_tlb_inv_s1_range_nosync(struct arm_smmu_domain *smmu_domain,
+				   u16 vmid, u16 asid, unsigned long iova,
+				   size_t size, size_t granule, bool leaf)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_ent cmd = {};
+
+	cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
+	cmd.tlbi.vmid	= vmid;
+	cmd.tlbi.asid	= asid;
+	cmd.tlbi.addr	= iova;
+	cmd.tlbi.leaf	= leaf;
 	do {
 		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 		cmd.tlbi.addr += granule;
 	} while (size -= granule);
 }
 
+static void
+__arm_smmu_tlb_inv_s2_range_nosync(struct arm_smmu_domain *smmu_domain,
+				   u16 vmid, unsigned long iova, size_t size,
+				   size_t granule, bool leaf)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_ent cmd = {};
+
+	cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
+	cmd.tlbi.vmid	= vmid;
+	cmd.tlbi.addr	= iova;
+	cmd.tlbi.leaf	= leaf;
+	do {
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		cmd.tlbi.addr += granule;
+	} while (size -= granule);
+}
+
+static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
+					  size_t granule, bool leaf,
+					  void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		__arm_smmu_tlb_inv_s1_range_nosync(smmu_domain, 0,
+						   smmu_domain->s1_cfg->cd.asid,
+						   iova, size, granule, leaf);
+	} else {
+		__arm_smmu_tlb_inv_s2_range_nosync(smmu_domain,
+						   smmu_domain->s2_cfg->vmid,
+						   iova, size, granule, leaf);
+	}
+}
+
 static const struct iommu_gather_ops arm_smmu_gather_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
