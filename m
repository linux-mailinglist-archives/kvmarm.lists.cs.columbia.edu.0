Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B352C120801
	for <lists+kvmarm@lfdr.de>; Mon, 16 Dec 2019 15:04:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 630AE4A959;
	Mon, 16 Dec 2019 09:04:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXNrPjMmzgJZ; Mon, 16 Dec 2019 09:04:43 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0307B4AC65;
	Mon, 16 Dec 2019 09:04:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CBC184A521
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Dec 2019 09:04:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 264nzmFsgdBl for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Dec 2019 09:04:39 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A35F44A591
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Dec 2019 09:04:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576505079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQJlLjmRnoxnyH5I+FAGf7Zim3+eldLoAm/hBFPMOq8=;
 b=JpMFaasEnFeDZcKsi5MJ/IEHnghF81Qe3qoaVsptWaboyOQYdZx/iCforGMnd8pDkZqXg7
 70+k5YpyzxJeciLdzH6qbRxcw0/z7CncZA80u17xIvzqDcPkeFQB+1JUYq9jonJxlcgcnG
 B7rG55tt+ongH8dATmQJCXgrT3YNIhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-uP40nYjUPiaYgrBYDA816Q-1; Mon, 16 Dec 2019 09:04:37 -0500
X-MC-Unique: uP40nYjUPiaYgrBYDA816Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC5118543AE;
 Mon, 16 Dec 2019 14:04:36 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 253EE675B8;
 Mon, 16 Dec 2019 14:04:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH 16/16] arm/arm64: ITS: pending table migration
 test
Date: Mon, 16 Dec 2019 15:02:35 +0100
Message-Id: <20191216140235.10751-17-eric.auger@redhat.com>
In-Reply-To: <20191216140235.10751-1-eric.auger@redhat.com>
References: <20191216140235.10751-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 arm/gic.c         | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  16 ++++-
 2 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/arm/gic.c b/arm/gic.c
index 8cca743..fc8cf6e 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -170,6 +170,7 @@ static void lpi_handler(struct pt_regs *regs __unused)
 	smp_rmb(); /* pairs with wmb in lpi_stats_expect */
 	lpi_stats.observed.cpu_id = smp_processor_id();
 	lpi_stats.observed.lpi_id = irqnr;
+	acked[lpi_stats.observed.cpu_id]++;
 	smp_wmb(); /* pairs with rmb in check_lpi_stats */
 }
 
@@ -207,6 +208,18 @@ static void check_lpi_stats(void)
 	}
 }
 
+static void check_lpi_hits(int *expected)
+{
+	int i;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (acked[i] != expected[i])
+			report(false, "expected %d LPIs on PE #%d, %d observed",
+			       expected[i], i, acked[i]);
+		}
+	report(true, "check LPI on all vcpus");
+}
+
 static void gicv2_ipi_send_self(void)
 {
 	writel(2 << 24 | IPI_IRQ, gicv2_dist_base() + GICD_SGIR);
@@ -642,6 +655,18 @@ static int its_prerequisites(int nb_cpus)
 	return 0;
 }
 
+static void set_lpi(struct its_device *dev, u32 eventid, u32 physid,
+		    struct its_collection *col)
+{
+	if (!dev || !col)
+		report_abort("wrong device or collection");
+
+	its_send_mapti(dev, physid, eventid, col);
+
+	set_lpi_config(physid, LPI_PROP_DEFAULT);
+	its_send_invall(col);
+}
+
 /*
  * Setup the configuration for those mappings:
  * dev_id=2 event=20 -> vcpu 3, intid=8195
@@ -766,6 +791,121 @@ static void test_its_migration(void)
 	check_lpi_stats();
 }
 
+static void test_migrate_unmapped_collection(void)
+{
+	struct its_collection *col;
+	struct its_device *dev2, *dev7;
+	u8 config;
+
+	if (its_setup1())
+		return;
+
+	col = its_create_collection(nr_cpus - 1, nr_cpus - 1);
+	dev2 = its_get_device(2);
+	dev7 = its_get_device(7);
+
+	/* MAPTI with the collection unmapped */
+	set_lpi(dev2, 0, 8192, col);
+
+	puts("Now migrate the VM, then press a key to continue...\n");
+	(void)getchar();
+	report(true, "Migration complete");
+
+	/* on the destination, map the collection */
+	its_send_mapc(col, true);
+
+	lpi_stats_expect(2, 8196);
+	its_send_int(dev7, 255);
+	check_lpi_stats();
+
+	config = get_lpi_config(8192);
+	report(config == LPI_PROP_DEFAULT,
+	       "Config of LPI 8192 was properly migrated");
+
+	lpi_stats_expect(nr_cpus - 1, 8192);
+	its_send_int(dev2, 0);
+	check_lpi_stats();
+
+	/* unmap the collection */
+	its_send_mapc(col, false);
+
+	lpi_stats_expect(-1, -1);
+	its_send_int(dev2, 0);
+	check_lpi_stats();
+
+	/* remap event 0 onto lpiid 8193 */
+	set_lpi(dev2, 0, 8193, col);
+	lpi_stats_expect(-1, -1);
+	its_send_int(dev2, 0);
+	check_lpi_stats();
+
+	/* remap the collection */
+	its_send_mapc(col, true);
+	lpi_stats_expect(nr_cpus - 1, 8193);
+}
+
+static void test_its_pending_migration(void)
+{
+	struct its_device *dev;
+	struct its_collection *collection[2];
+	int expected[NR_CPUS];
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
+	collection[0] = its_create_collection(nr_cpus - 1, nr_cpus - 1);
+	collection[1] = its_create_collection(nr_cpus - 2, nr_cpus - 2);
+	its_send_mapc(collection[0], true);
+	its_send_mapc(collection[1], true);
+
+	/* disable lpi at redist level */
+	gicv3_rdist_ctrl_lpi(nr_cpus - 1, false);
+	gicv3_rdist_ctrl_lpi(nr_cpus - 2, false);
+
+	/* even lpis are assigned to even cpu */
+	for (i = 0; i < 256; i++) {
+		struct its_collection *col = i % 2 ? collection[0] :
+						     collection[1];
+		int vcpu = col->target_address >> 16;
+
+		its_send_mapti(dev, 8192 + i, i, col);
+		set_lpi_config(8192 + i, LPI_PROP_DEFAULT);
+		set_pending_table_bit(vcpu, 8192 + i, true);
+	}
+	its_send_invall(collection[0]);
+	its_send_invall(collection[1]);
+
+	/* Set the PTZ bit on each pendbaser */
+
+	expected[nr_cpus - 1] = 128;
+	expected[nr_cpus - 2] = 128;
+
+	ptr = gicv3_data.redist_base[nr_cpus - 1] + GICR_PENDBASER;
+	pendbaser = readq(ptr);
+	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
+
+	ptr = gicv3_data.redist_base[nr_cpus - 2] + GICR_PENDBASER;
+	pendbaser = readq(ptr);
+	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
+
+	gicv3_rdist_ctrl_lpi(nr_cpus - 1, true);
+	gicv3_rdist_ctrl_lpi(nr_cpus - 2, true);
+
+	puts("Now migrate the VM, then press a key to continue...\n");
+	(void)getchar();
+	report(true, "Migration complete");
+
+	mdelay(1000);
+
+	check_lpi_hits(expected);
+}
+
 int main(int argc, char **argv)
 {
 	if (!gic_init()) {
@@ -804,6 +944,14 @@ int main(int argc, char **argv)
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
index 29e2efc..911f0b7 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -145,7 +145,21 @@ file = gic.flat
 smp = $MAX_SMP
 accel = kvm
 extra_params = -machine gic-version=3 -append 'its-migration'
-groups = its migration
+groups = migration
+
+[its-pending-migration]
+file = gic.flat
+smp = $MAX_SMP
+accel = kvm
+extra_params = -machine gic-version=3 -append 'its-pending-migration'
+groups = migration
+
+[its-migrate-unmapped-collection]
+file = gic.flat
+smp = $MAX_SMP
+accel = kvm
+extra_params = -machine gic-version=3 -append 'its-migrate-unmapped-collection'
+groups = migration
 
 # Test PSCI emulation
 [psci]
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
