Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 007482B4155
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 11:44:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A936D4C151;
	Mon, 16 Nov 2020 05:44:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n5UNS4gJoBXG; Mon, 16 Nov 2020 05:44:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 28ED84C144;
	Mon, 16 Nov 2020 05:44:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A4384BFB7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 05:44:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2CrQTlf9cnUO for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 05:44:00 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A96E4B822
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 05:43:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605523439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzYA4PVmsCxBmP6uHGBSoFiHXCtSp1wbblLTxgRXOzU=;
 b=R/useTDha4tQ18YZZFO0DDnyW8ixhvW6ReOtAdWnEUFBDoHNOkX2fsZs7jXJtJveGhc8U3
 f9a3GURBwkaKuEwrjVf1DiTHnuvxvvwHMwuNKvyNZRK6U7PgmILKJxYqi3ITLzgZQ+Nzsn
 NT9oF+NW05l4ILZt8hD9YphARVf5yRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-GGgFhBzyPCiEQ1KPH1C7Ww-1; Mon, 16 Nov 2020 05:43:57 -0500
X-MC-Unique: GGgFhBzyPCiEQ1KPH1C7Ww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA1757203;
 Mon, 16 Nov 2020 10:43:55 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-230.ams2.redhat.com [10.36.113.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 910A05C5FE;
 Mon, 16 Nov 2020 10:43:50 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com
Subject: [PATCH v12 04/15] iommu/smmuv3: Dynamically allocate s1_cfg and s2_cfg
Date: Mon, 16 Nov 2020 11:43:05 +0100
Message-Id: <20201116104316.31816-5-eric.auger@redhat.com>
In-Reply-To: <20201116104316.31816-1-eric.auger@redhat.com>
References: <20201116104316.31816-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com,
 nicoleotsuka@gmail.com, vivek.gautam@arm.com, alex.williamson@redhat.com,
 yi.l.liu@intel.com, zhangfei.gao@linaro.org
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

In preparation for the introduction of nested stages
let's turn s1_cfg and s2_cfg fields into pointers which are
dynamically allocated depending on the smmu_domain stage.

In nested mode, both stages will coexist and s1_cfg will
be allocated when the guest configuration gets passed.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 83 ++++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 +-
 2 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d828d6cbeb0e..4baf9fafe462 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -953,9 +953,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg->cdcfg;
 
-	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+	if (smmu_domain->s1_cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
@@ -990,7 +990,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	__le64 *cdptr;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg->s1cdmax)))
 		return -E2BIG;
 
 	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
@@ -1056,7 +1056,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_s1_cfg *cfg = smmu_domain->s1_cfg;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
 
 	max_contexts = 1 << cfg->s1cdmax;
@@ -1104,7 +1104,7 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 	int i;
 	size_t size, l1size;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg->cdcfg;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -1211,17 +1211,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}
 
 	if (smmu_domain) {
-		switch (smmu_domain->stage) {
-		case ARM_SMMU_DOMAIN_S1:
-			s1_cfg = &smmu_domain->s1_cfg;
-			break;
-		case ARM_SMMU_DOMAIN_S2:
-		case ARM_SMMU_DOMAIN_NESTED:
-			s2_cfg = &smmu_domain->s2_cfg;
-			break;
-		default:
-			break;
-		}
+		s1_cfg = smmu_domain->s1_cfg;
+		s2_cfg = smmu_domain->s2_cfg;
 	}
 
 	if (val & STRTAB_STE_0_V) {
@@ -1664,10 +1655,10 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
+		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg->cd.asid);
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg->vmid;
 		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 		arm_smmu_cmdq_issue_sync(smmu);
 	}
@@ -1693,10 +1684,10 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
+		cmd.tlbi.asid	= smmu_domain->s1_cfg->cd.asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg->vmid;
 	}
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
@@ -1846,24 +1837,25 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_s1_cfg *s1_cfg = smmu_domain->s1_cfg;
+	struct arm_smmu_s2_cfg *s2_cfg = smmu_domain->s2_cfg;
 
 	iommu_put_dma_cookie(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
 	/* Free the CD and ASID, if we allocated them */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-
-		/* Prevent SVA from touching the CD while we're freeing it */
+	if (s1_cfg) {
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cfg->cdcfg.cdtab)
+		/* Prevent SVA from touching the CD while we're freeing it */
+		if (s1_cfg->cdcfg.cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
-		arm_smmu_free_asid(&cfg->cd);
+		arm_smmu_free_asid(&s1_cfg->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
-	} else {
-		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
-		if (cfg->vmid)
-			arm_smmu_bitmap_free(smmu->vmid_map, cfg->vmid);
+	}
+	if (s2_cfg) {
+		if (s2_cfg->vmid)
+			arm_smmu_bitmap_free(smmu->vmid_map, s2_cfg->vmid);
+		kfree(s2_cfg);
 	}
 
 	kfree(smmu_domain);
@@ -1876,8 +1868,11 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
+	struct arm_smmu_s1_cfg *cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+
+	if (!cfg)
+		return -ENOMEM;
 
 	refcount_set(&cfg->cd.refs, 1);
 
@@ -1890,6 +1885,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 
 	cfg->s1cdmax = master->ssid_bits;
 
+	smmu_domain->s1_cfg = cfg;
+
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
 		goto out_free_asid;
@@ -1922,6 +1919,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 out_free_asid:
 	arm_smmu_free_asid(&cfg->cd);
 out_unlock:
+	kfree(cfg);
+	smmu_domain->s1_cfg = NULL;
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
 }
@@ -1930,14 +1929,19 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
-	int vmid;
+	int vmid, ret;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
+	struct arm_smmu_s2_cfg *cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
+	if (!cfg)
+		return -ENOMEM;
+
 	vmid = arm_smmu_bitmap_alloc(smmu->vmid_map, smmu->vmid_bits);
-	if (vmid < 0)
-		return vmid;
+	if (vmid < 0) {
+		ret = vmid;
+		goto out_free_cfg;
+	}
 
 	vtcr = &pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
 	cfg->vmid	= (u16)vmid;
@@ -1949,7 +1953,12 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 			  FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, vtcr->sh) |
 			  FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
 			  FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
+	smmu_domain->s2_cfg = cfg;
 	return 0;
+
+out_free_cfg:
+	kfree(cfg);
+	return ret;
 }
 
 static int arm_smmu_domain_finalise(struct iommu_domain *domain,
@@ -2231,10 +2240,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -ENXIO;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		   master->ssid_bits != smmu_domain->s1_cfg->s1cdmax) {
 		dev_err(dev,
 			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
-			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
+			smmu_domain->s1_cfg->s1cdmax, master->ssid_bits);
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2944beb1571b..6fdc35b32dbf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -679,10 +679,8 @@ struct arm_smmu_domain {
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-	union {
-		struct arm_smmu_s1_cfg	s1_cfg;
-		struct arm_smmu_s2_cfg	s2_cfg;
-	};
+	struct arm_smmu_s1_cfg	*s1_cfg;
+	struct arm_smmu_s2_cfg	*s2_cfg;
 
 	struct iommu_domain		domain;
 
-- 
2.21.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
