Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD07A1D2BB9
	for <lists+kvmarm@lfdr.de>; Thu, 14 May 2020 11:46:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 747594B2C0;
	Thu, 14 May 2020 05:46:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMkTmHC1ewga; Thu, 14 May 2020 05:46:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 37AA34B2BB;
	Thu, 14 May 2020 05:46:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 488444B2BB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 May 2020 05:46:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MC87PlHo9A+d for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 May 2020 05:46:00 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 19A5E4B1BD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 May 2020 05:46:00 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A886431B;
 Thu, 14 May 2020 02:45:59 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACFCA3F305;
 Thu, 14 May 2020 02:45:58 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool] rtc: Generate fdt node for the real-time clock
Date: Thu, 14 May 2020 10:45:53 +0100
Message-Id: <20200514094553.135663-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: Sami Mujawar <sami.mujawar@arm.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On arm and arm64 we expose the Motorola RTC emulation to the guest,
but never advertised this in the device tree.

EDK-2 seems to rely on this device, but on its hardcoded address. To
make this more future-proof, add a DT node with the address in it.
EDK-2 can then read the proper address from there, and we can change
this address later (with the flexible memory layout).

Please note that an arm64 Linux kernel is not ready to use this device,
there are some include files missing under arch/arm64 to compile the
driver. I hacked this up in the kernel, just to verify this DT snippet
is correct, but don't see much value in enabling this properly in
Linux.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 hw/rtc.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/hw/rtc.c b/hw/rtc.c
index c1fa72f2..5483879f 100644
--- a/hw/rtc.c
+++ b/hw/rtc.c
@@ -130,24 +130,56 @@ static struct ioport_operations cmos_ram_index_ioport_ops = {
 	.io_out		= cmos_ram_index_out,
 };
 
+#ifdef CONFIG_HAS_LIBFDT
+static void generate_rtc_fdt_node(void *fdt,
+				  struct device_header *dev_hdr,
+				  void (*generate_irq_prop)(void *fdt,
+							    u8 irq,
+							    enum irq_type))
+{
+	u64 reg_prop[2] = { cpu_to_fdt64(0x70), cpu_to_fdt64(2) };
+
+	_FDT(fdt_begin_node(fdt, "rtc"));
+	_FDT(fdt_property_string(fdt, "compatible", "motorola,mc146818"));
+	_FDT(fdt_property(fdt, "reg", reg_prop, sizeof(reg_prop)));
+	_FDT(fdt_end_node(fdt));
+}
+#else
+#define generate_rtc_fdt_node NULL
+#endif
+
+struct device_header rtc_dev_hdr = {
+	.bus_type = DEVICE_BUS_IOPORT,
+	.data = generate_rtc_fdt_node,
+};
+
 int rtc__init(struct kvm *kvm)
 {
-	int r = 0;
+	int r;
+
+	r = device__register(&rtc_dev_hdr);
+	if (r < 0)
+		return r;
 
 	/* PORT 0070-007F - CMOS RAM/RTC (REAL TIME CLOCK) */
 	r = ioport__register(kvm, 0x0070, &cmos_ram_index_ioport_ops, 1, NULL);
 	if (r < 0)
-		return r;
+		goto out_device;
 
 	r = ioport__register(kvm, 0x0071, &cmos_ram_data_ioport_ops, 1, NULL);
-	if (r < 0) {
-		ioport__unregister(kvm, 0x0071);
-		return r;
-	}
+	if (r < 0)
+		goto out_ioport;
 
 	/* Set the VRT bit in Register D to indicate valid RAM and time */
 	rtc.cmos_data[RTC_REG_D] = RTC_REG_D_VRT;
 
+	return r;
+
+out_ioport:
+	ioport__unregister(kvm, 0x0070);
+out_device:
+	device__unregister(&rtc_dev_hdr);
+
 	return r;
 }
 dev_init(rtc__init);
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
