Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 890DD487A76
	for <lists+kvmarm@lfdr.de>; Fri,  7 Jan 2022 17:34:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E04ED4B2A0;
	Fri,  7 Jan 2022 11:34:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YkwDm60bzZFh; Fri,  7 Jan 2022 11:34:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AB1A4B2D1;
	Fri,  7 Jan 2022 11:34:06 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F5124B245
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 11:34:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCs7OQPx7-P4 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Jan 2022 11:34:03 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1C8514B248
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 11:34:03 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1732EB82670;
 Fri,  7 Jan 2022 16:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFE0C36AED;
 Fri,  7 Jan 2022 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641573240;
 bh=soaLkV2PTYcc57ba0KLYk7Cu62Qw6D2b5TmoCuhgtXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jrYvff1ZlayQFFYeDEvBtrlHxg/D+fELM8dItT+4vGREERVKxhvBavl5w+xXiwv8L
 TUZXYTBQGi8rsVNBuyAZAYoiosF7v1v6nzh/vvgXmO8aI/3aSnHZKgKZLTNJzsrhU2
 I1wdErQHTEQTpavOUmZlY2vNDGX0iLvV2PTzWF30PEC5RKEeYuxf+d3LfxaFZhiwmt
 yVJ0RjNomtv/Id/X253een1RtvDwgdFKaGMROJAPfpd9i4A0sz+GZ7HxGnab6QIejt
 uiWz0LnNqoGSYzUX/v5+/VvaXc++lV9O1a1B/9+prCT/5g6llFrZYPSaU2WJxz5WKd
 wMXTs6XYs04DA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1n5sBj-00GbiJ-0c; Fri, 07 Jan 2022 16:33:59 +0000
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/6] hw/arm/virt: Disable highmem devices that don't fit in
 the PA range
Date: Fri,  7 Jan 2022 16:33:23 +0000
Message-Id: <20220107163324.2491209-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220107163324.2491209-1-maz@kernel.org>
References: <20220107163324.2491209-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, kernel-team@android.com, drjones@redhat.com,
 eric.auger@redhat.com, peter.maydell@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

In order to only keep the highmem devices that actually fit in
the PA range, check their location against the range and update
highest_gpa if they fit. If they don't, mark them them as disabled.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 hw/arm/virt.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index db4b0636e1..70b4773b3e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1711,21 +1711,43 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
         base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
     }
 
+    /* We know for sure that at least the memory fits in the PA space */
+    vms->highest_gpa = memtop - 1;
+
     for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
         hwaddr size = extended_memmap[i].size;
+        bool fits;
 
         base = ROUND_UP(base, size);
         vms->memmap[i].base = base;
         vms->memmap[i].size = size;
+
+        /*
+         * Check each device to see if they fit in the PA space,
+         * moving highest_gpa as we go.
+         *
+         * For each device that doesn't fit, disable it.
+         */
+        fits = (base + size) <= BIT_ULL(pa_bits);
+        if (fits) {
+            vms->highest_gpa = MAX(vms->highest_gpa, base + size - 1);
+        }
+
+        switch (i) {
+        case VIRT_HIGH_GIC_REDIST2:
+            vms->highmem_redists &= fits;
+            break;
+        case VIRT_HIGH_PCIE_ECAM:
+            vms->highmem_ecam &= fits;
+            break;
+        case VIRT_HIGH_PCIE_MMIO:
+            vms->highmem_mmio &= fits;
+            break;
+        }
+
         base += size;
     }
 
-    /*
-     * If base fits within pa_bits, all good. If it doesn't, limit it
-     * to the end of RAM, which is guaranteed to fit within pa_bits.
-     */
-    vms->highest_gpa = (base <= BIT_ULL(pa_bits) ? base : memtop) - 1;
-
     if (device_memory_size > 0) {
         ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
         ms->device_memory->base = device_memory_base;
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
