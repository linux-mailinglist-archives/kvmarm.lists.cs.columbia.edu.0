Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1417DD71
	for <lists+kvmarm@lfdr.de>; Mon,  9 Mar 2020 11:25:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52B5340152;
	Mon,  9 Mar 2020 06:25:37 -0400 (EDT)
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
	with ESMTP id THbWTaPxCM39; Mon,  9 Mar 2020 06:25:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DC65B4A4E5;
	Mon,  9 Mar 2020 06:25:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A62F40A52
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Mar 2020 06:25:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MiJvvNdnA6Wl for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Mar 2020 06:25:34 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF0A24A32E
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Mar 2020 06:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583749533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtWY6EtZqZfpLJigCSJmpP6HidMT+k6tciMSfFWxjKM=;
 b=dBwoNTfgpT9ziNrL5p4cJ5jddAIrAGZiMvphwy9+notMghO3mAJ47LmNTjn8hILwGXy0+6
 1fGIj1dvQVG3bq24rXuFq7uKPMGYi3BR5jpKGa5EwYoNiLYWgBhffFyzzubqqLwGBg4RaA
 VxioZVzTDf73RstlX/eNVvZ5R6DfWDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-yXI4uzByNLmVZSM0ZeQc9g-1; Mon, 09 Mar 2020 06:25:31 -0400
X-MC-Unique: yXI4uzByNLmVZSM0ZeQc9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B76E6477;
 Mon,  9 Mar 2020 10:25:29 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62A0487B08;
 Mon,  9 Mar 2020 10:25:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v4 13/13] arm/arm64: ITS: pending table
 migration test
Date: Mon,  9 Mar 2020 11:24:20 +0100
Message-Id: <20200309102420.24498-14-eric.auger@redhat.com>
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

Add two new migration tests. One testing the migration of
a topology where collection were unmapped. The second test
checks the migration of the pending table.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- do not talk about odd/even CPUs, use pe0 and pe1
- comment the delay

v2 -> v3:
- tests belong to both its and migration groups
- use LPI(i)
- gicv3_lpi_set_pending_table_bit renamed into gicv3_lpi_set_clr_pending
---
 arm/gic.c                | 144 +++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg        |  16 +++++
 lib/arm/asm/gic-v3-its.h |   9 +++
 3 files changed, 169 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 96f0fd6..39994eb 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -194,6 +194,7 @@ static void lpi_handler(struct pt_regs *regs __unused)
 	smp_rmb(); /* pairs with wmb in lpi_stats_expect */
 	lpi_stats.observed.cpu_id = smp_processor_id();
 	lpi_stats.observed.lpi_id = irqnr;
+	acked[lpi_stats.observed.cpu_id]++;
 	smp_wmb(); /* pairs with rmb in check_lpi_stats */
 }
 
@@ -236,6 +237,22 @@ static void secondary_lpi_test(void)
 	while (1)
 		wfi();
 }
+
+static void check_lpi_hits(int *expected, const char *msg)
+{
+	bool pass = true;
+	int i;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (acked[i] != expected[i]) {
+			report_info("expected %d LPIs on PE #%d, %d observed",
+				    expected[i], i, acked[i]);
+			pass = false;
+			break;
+		}
+	}
+	report(pass, "%s", msg);
+}
 #endif
 
 static void gicv2_ipi_send_self(void)
@@ -653,6 +670,17 @@ static int its_prerequisites(int nb_cpus)
 	return 0;
 }
 
+static void set_lpi(struct its_device *dev, u32 eventid, u32 physid,
+		    struct its_collection *col)
+{
+	assert(dev && col);
+
+	its_send_mapti(dev, physid, eventid, col);
+
+	gicv3_lpi_set_config(physid, LPI_PROP_DEFAULT);
+	its_send_invall(col);
+}
+
 /*
  * Setup the configuration for those mappings:
  * dev_id=2 event=20 -> vcpu 3, intid=8195
@@ -793,6 +821,114 @@ static void test_its_migration(void)
 	its_send_int(dev7, 255);
 	check_lpi_stats("dev7/eventid=255 triggers LPI 8196 on PE #2 after migration");
 }
+
+static void test_migrate_unmapped_collection(void)
+{
+	struct its_collection *col;
+	struct its_device *dev2, *dev7;
+	int pe0 = nr_cpus - 1;
+	u8 config;
+
+	if (its_setup1())
+		return;
+
+	col = its_create_collection(pe0, pe0);
+	dev2 = its_get_device(2);
+	dev7 = its_get_device(7);
+
+	/* MAPTI with the collection unmapped */
+	set_lpi(dev2, 0, 8192, col);
+
+	puts("Now migrate the VM, then press a key to continue...\n");
+	(void)getchar();
+	report_info("Migration complete");
+
+	/* on the destination, map the collection */
+	its_send_mapc(col, true);
+
+	lpi_stats_expect(2, 8196);
+	its_send_int(dev7, 255);
+	check_lpi_stats("dev7/eventid= 255 triggered LPI 8196 on PE #2");
+
+	config = gicv3_lpi_get_config(8192);
+	report(config == LPI_PROP_DEFAULT,
+	       "Config of LPI 8192 was properly migrated");
+
+	lpi_stats_expect(pe0, 8192);
+	its_send_int(dev2, 0);
+	check_lpi_stats("dev2/eventid = 0 triggered LPI 8192 on PE0");
+
+	/* unmap the collection */
+	its_send_mapc(col, false);
+
+	lpi_stats_expect(-1, -1);
+	its_send_int(dev2, 0);
+	check_lpi_stats("no LPI triggered after collection unmapping");
+}
+
+static void test_its_pending_migration(void)
+{
+	struct its_device *dev;
+	struct its_collection *collection[2];
+	int *expected = malloc(nr_cpus * sizeof(int));
+	int pe0 = nr_cpus - 1, pe1 = nr_cpus - 2;
+	u64 pendbaser;
+	void *ptr;
+	int i;
+
+	if (its_prerequisites(4))
+		return;
+
+	dev = its_create_device(2 /* dev id */, 8 /* nb_ites */);
+	its_send_mapd(dev, true);
+
+	collection[0] = its_create_collection(pe0, pe0);
+	collection[1] = its_create_collection(pe1, pe1);
+	its_send_mapc(collection[0], true);
+	its_send_mapc(collection[1], true);
+
+	/* disable lpi at redist level */
+	gicv3_lpi_rdist_disable(pe0);
+	gicv3_lpi_rdist_disable(pe1);
+
+	/* lpis are interleaved inbetween the 2 PEs */
+	for (i = 0; i < 256; i++) {
+		struct its_collection *col = i % 2 ? collection[0] :
+						     collection[1];
+		int vcpu = col->target_address >> 16;
+
+		its_send_mapti(dev, LPI(i), i, col);
+		gicv3_lpi_set_config(LPI(i), LPI_PROP_DEFAULT);
+		gicv3_lpi_set_clr_pending(vcpu, LPI(i), true);
+	}
+	its_send_invall(collection[0]);
+	its_send_invall(collection[1]);
+
+	/* Set the PTZ bit on each pendbaser */
+
+	expected[pe0] = 128;
+	expected[pe1] = 128;
+
+	ptr = gicv3_data.redist_base[pe0] + GICR_PENDBASER;
+	pendbaser = readq(ptr);
+	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
+
+	ptr = gicv3_data.redist_base[pe1] + GICR_PENDBASER;
+	pendbaser = readq(ptr);
+	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
+
+	gicv3_lpi_rdist_enable(pe0);
+	gicv3_lpi_rdist_enable(pe1);
+
+	puts("Now migrate the VM, then press a key to continue...\n");
+	(void)getchar();
+	report_info("Migration complete");
+
+	/* let's wait for the 256 LPIs to be handled */
+	mdelay(1000);
+
+	check_lpi_hits(expected, "128 LPIs on both PE0 and PE1 after migration");
+}
 #endif
 
 int main(int argc, char **argv)
@@ -834,6 +970,14 @@ int main(int argc, char **argv)
 		report_prefix_push(argv[1]);
 		test_its_migration();
 		report_prefix_pop();
+	} else if (!strcmp(argv[1], "its-pending-migration")) {
+		report_prefix_push(argv[1]);
+		test_its_pending_migration();
+		report_prefix_pop();
+	} else if (!strcmp(argv[1], "its-migrate-unmapped-collection")) {
+		report_prefix_push(argv[1]);
+		test_migrate_unmapped_collection();
+		report_prefix_pop();
 	} else if (strcmp(argv[1], "its-introspection") == 0) {
 		report_prefix_push(argv[1]);
 		test_its_introspection();
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 480adec..b96f0a1 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -144,6 +144,22 @@ extra_params = -machine gic-version=3 -append 'its-migration'
 groups = its migration
 arch = arm64
 
+[its-pending-migration]
+file = gic.flat
+smp = $MAX_SMP
+accel = kvm
+extra_params = -machine gic-version=3 -append 'its-pending-migration'
+groups = its migration
+arch = arm64
+
+[its-migrate-unmapped-collection]
+file = gic.flat
+smp = $MAX_SMP
+accel = kvm
+extra_params = -machine gic-version=3 -append 'its-migrate-unmapped-collection'
+groups = its migration
+arch = arm64
+
 # Test PSCI emulation
 [psci]
 file = psci.flat
diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index 4d849c4..5ec2a04 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -26,5 +26,14 @@ static inline void test_its_migration(void)
 {
 	report_abort("not supported on 32-bit");
 }
+static inline void test_its_pending_migration(void)
+{
+	report_abort("not supported on 32-bit");
+}
+static inline void test_migrate_unmapped_collection(void)
+{
+	report_abort("not supported on 32-bit");
+}
+
 
 #endif /* _ASMARM_GICv3_ITS */
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
