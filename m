Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DC63E18CA4F
	for <lists+kvmarm@lfdr.de>; Fri, 20 Mar 2020 10:25:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C8834B082;
	Fri, 20 Mar 2020 05:25:46 -0400 (EDT)
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
	with ESMTP id TyGOJRktkic2; Fri, 20 Mar 2020 05:25:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 385134B08F;
	Fri, 20 Mar 2020 05:25:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D5D34B08A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Mar 2020 05:25:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vwtiOo+Cltd8 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Mar 2020 05:25:42 -0400 (EDT)
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 59E494A4A9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Mar 2020 05:25:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584696342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5t+K99nOllz6/nKHgn1LHqrPr5sxfTVf2PPG+27oSQ=;
 b=fWw8R5oh8VulmNcr/Sav5pjNBNhHAyK06olHPFhiV1G3o58cuu7NESX8ouVktPHRnY0E8o
 vqUH2zKNsEOrFq7ZhxO8SpGsJGO0OgT0y9ChqpzrzykDtJYM4Cer32e7Mb9728BXYl6pNH
 XbmitK53osmgVPUHix3yeoxxqwJf2II=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-vLEtzNdIOh6WSnEv-oVOsA-1; Fri, 20 Mar 2020 05:25:40 -0400
X-MC-Unique: vLEtzNdIOh6WSnEv-oVOsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA15DB60;
 Fri, 20 Mar 2020 09:25:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 744D95C1D8;
 Fri, 20 Mar 2020 09:25:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v7 13/13] arm/arm64: ITS: pending table
 migration test
Date: Fri, 20 Mar 2020 10:24:28 +0100
Message-Id: <20200320092428.20880-14-eric.auger@redhat.com>
In-Reply-To: <20200320092428.20880-1-eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

v6 -> v7:
- test_migrate_unmapped_collection now uses pe0=0. Otherwise,
  depending on SMP value it collides with collections created
  by setup1()
- use of for_each_present_cpu

v5 -> v6:
- s/Set the PTZ/Clear the PTZ
- Move the collection inval after MAPC
- remove the unmap collection test

v4 -> v5:
- move stub from header to arm/gic.c

v3 -> v4:
- do not talk about odd/even CPUs, use pe0 and pe1
- comment the delay

v2 -> v3:
- tests belong to both its and migration groups
- use LPI(i)
- gicv3_lpi_set_pending_table_bit renamed into gicv3_lpi_set_clr_pending
---
 arm/gic.c         | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  16 ++++++
 2 files changed, 154 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 6ecfdbc..2c661dc 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -193,6 +193,7 @@ static void lpi_handler(struct pt_regs *regs __unused)
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
+	for_each_present_cpu(i) {
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
@@ -591,6 +608,8 @@ static void gic_test_mmio(void)
 static void test_its_introspection(void) {}
 static void test_its_trigger(void) {}
 static void test_its_migration(void) {}
+static void test_its_pending_migration(void) {}
+static void test_migrate_unmapped_collection(void) {}
 
 #else /* __aarch64__ */
 
@@ -659,6 +678,15 @@ static int its_prerequisites(int nb_cpus)
 	return 0;
 }
 
+static void set_lpi(struct its_device *dev, u32 eventid, u32 physid,
+		    struct its_collection *col)
+{
+	assert(dev && col);
+
+	its_send_mapti(dev, physid, eventid, col);
+	gicv3_lpi_set_config(physid, LPI_PROP_DEFAULT);
+}
+
 /*
  * Setup the configuration for those mappings:
  * dev_id=2 event=20 -> vcpu 3, intid=8195
@@ -790,6 +818,108 @@ static void test_its_migration(void)
 	its_send_int(dev7, 255);
 	check_lpi_stats("dev7/eventid=255 triggers LPI 8196 on PE #2 after migration");
 }
+
+static void test_migrate_unmapped_collection(void)
+{
+	struct its_collection *col;
+	struct its_device *dev2, *dev7;
+	int pe0 = 0;
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
+	its_send_invall(col);
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
+	/* Clear the PTZ bit on each pendbaser */
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
@@ -831,6 +961,14 @@ int main(int argc, char **argv)
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
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
