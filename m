Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 62ACD17DD63
	for <lists+kvmarm@lfdr.de>; Mon,  9 Mar 2020 11:25:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DDBE64A5C3;
	Mon,  9 Mar 2020 06:25:10 -0400 (EDT)
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
	with ESMTP id Nz6zlDr2oLbt; Mon,  9 Mar 2020 06:25:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 07B7F4A94D;
	Mon,  9 Mar 2020 06:25:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 38AF34A4FC
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Mar 2020 06:25:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I744advMVTkD for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Mar 2020 06:25:07 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 257704A542
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Mar 2020 06:25:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583749507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHE2jaHMx2EkPvI2/FqDuVO4fkyIww/LmhYOOZFcS78=;
 b=UGOe7UF3HcySuObLSbk7fW4mqM/sDURlsWIrB3ZbyDTlLQfBUdfU4a3qk8p2lzMfFQtEam
 2WOsCYtGrE9yfF+1K1uMhMlOQIAcmwwWjU8x3AwG3/V/wchmi9dmqGYNF1a8LQBG83L8cr
 NN58kc933GpaSG2V556+YrEArFfZcvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-ZnfUZy5rOuqfB01fqZXnvQ-1; Mon, 09 Mar 2020 06:25:05 -0400
X-MC-Unique: ZnfUZy5rOuqfB01fqZXnvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA15C477;
 Mon,  9 Mar 2020 10:25:03 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B508F87B08;
 Mon,  9 Mar 2020 10:25:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v4 07/13] arm/arm64: ITS: its_enable_defaults
Date: Mon,  9 Mar 2020 11:24:14 +0100
Message-Id: <20200309102420.24498-8-eric.auger@redhat.com>
In-Reply-To: <20200309102420.24498-1-eric.auger@redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: andre.przywara@arm.com, thuth@redhat.com
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

its_enable_defaults() enable LPIs at distributor level
and ITS level.

gicv3_enable_defaults must be called before.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- use GITS_BASER_INDIRECT & GITS_BASER_VALID in its_setup_baser()
- don't parse BASERs again in its_enable_defaults
- rename its_setup_baser into its_baser_alloc_table
- All allocations moved to the init function
- squashed "arm/arm64: gicv3: Enable/Disable LPIs at re-distributor level"
  into this patch
- introduce gicv3_lpi_rdist_enable and gicv3_lpi_rdist_disable
- pend and prop table bases stored as virt addresses
- move some init functions from enable() to its_init
- removed GICR_PROPBASER_IDBITS_MASK
- introduced LPI_OFFSET
- lpi_prop becomes u8 *
- gicv3_lpi_set_config/get_config became macro
- renamed gicv3_lpi_set_pending_table_bit into gicv3_lpi_set_clr_pending

v2 -> v3:
- introduce its_setup_baser in this patch
- squash "arm/arm64: ITS: Init the command queue" in this patch.
---
 lib/arm/asm/gic-v3.h       | 28 +++++++++++------
 lib/arm/gic-v3.c           | 64 ++++++++++++++++++++++----------------
 lib/arm64/asm/gic-v3-its.h |  1 +
 lib/arm64/gic-v3-its.c     | 16 ++++++++--
 4 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
index 12134ef..ea9ae8e 100644
--- a/lib/arm/asm/gic-v3.h
+++ b/lib/arm/asm/gic-v3.h
@@ -50,15 +50,16 @@
 #define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
 	(MPIDR_AFFINITY_LEVEL(cluster_id, level) << ICC_SGI1R_AFFINITY_## level ## _SHIFT)
 
-#define GICR_PROPBASER_IDBITS_MASK                      (0x1f)
+#define GICR_PENDBASER_PTZ		BIT_ULL(62)
 
-#define GICR_PENDBASER_PTZ                              BIT_ULL(62)
+#define LPI_PROP_GROUP1			(1 << 1)
+#define LPI_PROP_ENABLED		(1 << 0)
+#define LPI_PROP_DEFAULT_PRIO		0xa0
+#define LPI_PROP_DEFAULT		(LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1 | LPI_PROP_ENABLED)
 
-#define LPI_PROP_GROUP1		(1 << 1)
-#define LPI_PROP_ENABLED	(1 << 0)
-#define LPI_PROP_DEFAULT_PRIO   0xa0
-#define LPI_PROP_DEFAULT	(LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1 | \
-				 LPI_PROP_ENABLED)
+#define LPI_ID_BASE			8192
+#define LPI(lpi)			((lpi) + LPI_ID_BASE)
+#define LPI_OFFSET(intid)		((intid) - LPI_ID_BASE)
 
 #include <asm/arch_gicv3.h>
 
@@ -76,7 +77,7 @@ struct gicv3_data {
 	void *dist_base;
 	void *redist_bases[GICV3_NR_REDISTS];
 	void *redist_base[NR_CPUS];
-	void *lpi_prop;
+	u8 *lpi_prop;
 	void *lpi_pend[NR_CPUS];
 	unsigned int irq_nr;
 };
@@ -96,8 +97,10 @@ extern void gicv3_ipi_send_mask(int irq, const cpumask_t *dest);
 extern void gicv3_set_redist_base(size_t stride);
 extern void gicv3_lpi_set_config(int n, u8 val);
 extern u8 gicv3_lpi_get_config(int n);
-extern void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set);
+extern void gicv3_lpi_set_clr_pending(int rdist, int n, bool set);
 extern void gicv3_lpi_alloc_tables(void);
+extern void gicv3_lpi_rdist_enable(int redist);
+extern void gicv3_lpi_rdist_disable(int redist);
 
 static inline void gicv3_do_wait_for_rwp(void *base)
 {
@@ -143,5 +146,12 @@ static inline u64 mpidr_uncompress(u32 compressed)
 	return mpidr;
 }
 
+#define gicv3_lpi_set_config(intid, value) ({		\
+	gicv3_data.lpi_prop[LPI_OFFSET(intid)] = value; \
+})
+
+#define gicv3_lpi_get_config(intid) (gicv3_data.lpi_prop[LPI_OFFSET(intid)])
+
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_V3_H_ */
diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
index 949a986..a3b55b2 100644
--- a/lib/arm/gic-v3.c
+++ b/lib/arm/gic-v3.c
@@ -150,7 +150,14 @@ void gicv3_ipi_send_single(int irq, int cpu)
 }
 
 #if defined(__aarch64__)
-/* alloc_lpi_tables: Allocate LPI config and pending tables */
+
+/**
+ * alloc_lpi_tables - Allocate LPI config and pending tables
+ * and set PROPBASER (shared by all rdistributors) and per
+ * redistributor PENDBASER.
+ *
+ * gicv3_set_redist_base() must be called before
+ */
 void gicv3_lpi_alloc_tables(void)
 {
 	unsigned long n = SZ_64K >> PAGE_SHIFT;
@@ -161,13 +168,9 @@ void gicv3_lpi_alloc_tables(void)
 	gicv3_data.lpi_prop = alloc_pages(order);
 
 	/* ID bits = 13, ie. up to 14b LPI INTID */
-	prop_val = (u64)virt_to_phys(gicv3_data.lpi_prop) | 13;
+	prop_val = (u64)(virt_to_phys(gicv3_data.lpi_prop)) | 13;
 
-	/*
-	 * Allocate pending tables for each redistributor
-	 * and set PROPBASER and PENDBASER
-	 */
-	for_each_present_cpu(cpu) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		u64 pend_val;
 		void *ptr;
 
@@ -176,30 +179,14 @@ void gicv3_lpi_alloc_tables(void)
 		writeq(prop_val, ptr + GICR_PROPBASER);
 
 		gicv3_data.lpi_pend[cpu] = alloc_pages(order);
-
-		pend_val = (u64)virt_to_phys(gicv3_data.lpi_pend[cpu]);
-
+		pend_val = (u64)(virt_to_phys(gicv3_data.lpi_pend[cpu]));
 		writeq(pend_val, ptr + GICR_PENDBASER);
 	}
 }
 
-void gicv3_lpi_set_config(int n, u8 value)
+void gicv3_lpi_set_clr_pending(int rdist, int n, bool set)
 {
-	u8 *entry = (u8 *)(gicv3_data.lpi_prop + (n - 8192));
-
-	*entry = value;
-}
-
-u8 gicv3_lpi_get_config(int n)
-{
-	u8 *entry = (u8 *)(gicv3_data.lpi_prop + (n - 8192));
-
-	return *entry;
-}
-
-void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set)
-{
-	u8 *ptr = phys_to_virt((phys_addr_t)gicv3_data.lpi_pend[rdist]);
+	u8 *ptr = gicv3_data.lpi_pend[rdist];
 	u8 mask = 1 << (n % 8), byte;
 
 	ptr += (n / 8);
@@ -210,4 +197,29 @@ void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set)
 		byte &= ~mask;
 	*ptr = byte;
 }
+
+static void gicv3_lpi_rdist_ctrl(u32 redist, bool set)
+{
+	void *ptr;
+	u64 val;
+
+	assert(redist < nr_cpus);
+
+	ptr = gicv3_data.redist_base[redist];
+	val = readl(ptr + GICR_CTLR);
+	if (set)
+		val |= GICR_CTLR_ENABLE_LPIS;
+	else
+		val &= ~GICR_CTLR_ENABLE_LPIS;
+	writel(val,  ptr + GICR_CTLR);
+}
+
+void gicv3_lpi_rdist_enable(int redist)
+{
+	gicv3_lpi_rdist_ctrl(redist, true);
+}
+void gicv3_lpi_rdist_disable(int redist)
+{
+	gicv3_lpi_rdist_ctrl(redist, false);
+}
 #endif /* __aarch64__ */
diff --git a/lib/arm64/asm/gic-v3-its.h b/lib/arm64/asm/gic-v3-its.h
index 331ba0e..1e95977 100644
--- a/lib/arm64/asm/gic-v3-its.h
+++ b/lib/arm64/asm/gic-v3-its.h
@@ -88,5 +88,6 @@ extern struct its_data its_data;
 extern void its_parse_typer(void);
 extern void its_init(void);
 extern int its_baser_lookup(int i, struct its_baser *baser);
+extern void its_enable_defaults(void);
 
 #endif /* _ASMARM64_GIC_V3_ITS_H_ */
diff --git a/lib/arm64/gic-v3-its.c b/lib/arm64/gic-v3-its.c
index 23b0d06..2f480ae 100644
--- a/lib/arm64/gic-v3-its.c
+++ b/lib/arm64/gic-v3-its.c
@@ -94,9 +94,19 @@ void its_init(void)
 	its_baser_alloc_table(&its_data.device_baser, SZ_64K);
 	its_baser_alloc_table(&its_data.coll_baser, SZ_64K);
 
-	/* Allocate LPI config and pending tables */
-	gicv3_lpi_alloc_tables();
-
 	its_cmd_queue_init();
 }
 
+/* must be called after gicv3_enable_defaults */
+void its_enable_defaults(void)
+{
+	int i;
+
+	/* Allocate LPI config and pending tables */
+	gicv3_lpi_alloc_tables();
+
+	for (i = 0; i < nr_cpus; i++)
+		gicv3_lpi_rdist_enable(i);
+
+	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
+}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
