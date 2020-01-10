Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8FE137036
	for <lists+kvmarm@lfdr.de>; Fri, 10 Jan 2020 15:55:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 100D44B13A;
	Fri, 10 Jan 2020 09:55:15 -0500 (EST)
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
	with ESMTP id lFKtRIfNvhhk; Fri, 10 Jan 2020 09:55:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EFB694B184;
	Fri, 10 Jan 2020 09:55:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CFEC84B178
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 09:55:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-AFdHdpDX7m for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Jan 2020 09:55:11 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E5CCA4B154
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Jan 2020 09:55:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578668111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBKAcnxc2MYZzCoP970ndMhL3JY30iNVMqi2oK57oys=;
 b=RNJzlConDDNJyLKfAVOIcB28NlVTMKWNNfwAP1WZ9wxnoAS9E+xe4A9SndEUoZx3SrHtBW
 HUvjkqVQauMzL0NSNQSYT9lpbCeb9X97jCr4IEFZjEBFGVT4HAGPioUP7LzCdRCRFifDzG
 yxbNrCcpHsD8lwvicvKTmzrFHqIvYkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-JQMSqK-yNEazhUrjO_r2Cg-1; Fri, 10 Jan 2020 09:55:10 -0500
X-MC-Unique: JQMSqK-yNEazhUrjO_r2Cg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 841A6108838E;
 Fri, 10 Jan 2020 14:55:07 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB427BA5F;
 Fri, 10 Jan 2020 14:54:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v2 09/16] arm/arm64: ITS: Enable/Disable LPIs
 at re-distributor level
Date: Fri, 10 Jan 2020 15:54:05 +0100
Message-Id: <20200110145412.14937-10-eric.auger@redhat.com>
In-Reply-To: <20200110145412.14937-1-eric.auger@redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
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

This helper function enables or disables the signaling of LPIs
at redistributor level.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 lib/arm/asm/gic-v3-its.h |  1 +
 lib/arm/gic-v3-its.c     | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index 93814f7..d2db292 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -99,6 +99,7 @@ extern struct its_baser *its_lookup_baser(int type);
 extern void set_lpi_config(int n, u8 val);
 extern u8 get_lpi_config(int n);
 extern void set_pending_table_bit(int rdist, int n, bool set);
+extern void gicv3_rdist_ctrl_lpi(u32 redist, bool set);
 
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_V3_ITS_H_ */
diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
index 3037c84..c7c6f80 100644
--- a/lib/arm/gic-v3-its.c
+++ b/lib/arm/gic-v3-its.c
@@ -199,3 +199,21 @@ void init_cmd_queue(void)
 	its_data.cmd_write = its_data.cmd_base;
 	writeq(0, its_data.base + GITS_CWRITER);
 }
+
+void gicv3_rdist_ctrl_lpi(u32 redist, bool set)
+{
+	void *ptr;
+	u64 val;
+
+	if (redist >= nr_cpus)
+		report_abort("%s redist=%d >= cpu_count=%d\n",
+			     __func__, redist, nr_cpus);
+
+	ptr = gicv3_data.redist_base[redist];
+	val = readl(ptr + GICR_CTLR);
+	if (set)
+		val |= GICR_CTLR_ENABLE_LPIS;
+	else
+		val &= ~GICR_CTLR_ENABLE_LPIS;
+	writel(val,  ptr + GICR_CTLR);
+}
-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
