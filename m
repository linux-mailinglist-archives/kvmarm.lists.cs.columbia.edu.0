Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3F487A71
	for <lists+kvmarm@lfdr.de>; Fri,  7 Jan 2022 17:34:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F04084B2C2;
	Fri,  7 Jan 2022 11:34:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KLg3mJKsOHwt; Fri,  7 Jan 2022 11:34:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 78D314B2B9;
	Fri,  7 Jan 2022 11:34:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95CE74B227
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 11:34:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i89aTQO9qEWT for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Jan 2022 11:34:01 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5F6DE4B245
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jan 2022 11:34:01 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 93A9261EA2;
 Fri,  7 Jan 2022 16:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DB7C36AE0;
 Fri,  7 Jan 2022 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641573240;
 bh=3L/9tPruGiz7h73xzwH+NCKLF8ym5mrinTHffjc2kFg=;
 h=From:To:Cc:Subject:Date:From;
 b=oVXlzK1D01nQc1pBIq5O6nlDeAJEJg0wp1al2nRGBhEv3ORCuQn3wIimT1tGAu+/J
 /CFHr4knaIHMOyIQGRwyVbMMfXhPqyY6bc3BGL9T6wDTxKNprVHZYDg7WlmYzw7amK
 8Yl6oTRXmtFslym/4o0aFFrEB0vaAJBUaa2mvQk9YCChFjD4YeCGcDNO3bEKplkiXE
 gEMGOApOp/V1Rdhg6Eist8WCmJ63JQKOycQb/CZQr9fcQulfp0BKdTsLCxspLXV+39
 X2tA0CWdiEu9qJoeFtdIzNRWPa+iCnsRZ3VuM55sxNjVBjsOqKX00vGXnwfHhgnjzE
 BuWI1sO0SDoAg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1n5sBi-00GbiJ-0T; Fri, 07 Jan 2022 16:33:58 +0000
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/6] target/arm: Reduced-IPA space and highmem fixes
Date: Fri,  7 Jan 2022 16:33:18 +0000
Message-Id: <20220107163324.2491209-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Here's another stab at enabling QEMU on systems with pathologically
reduced IPA ranges such as the Apple M1 (previous version at [1]).
Eventually, we're able to run a KVM guest with more than just 3GB of
RAM on a system with a 36bit IPA space, and at most 123 vCPUs.

This also addresses some pathological QEMU behaviours, where the
highmem property is used as a flag allowing exposure of devices that
can't possibly fit in the PA space of the VM, resulting in a guest
failure.

In the end, we generalise the notion of PA space when exposing
individual devices in the expanded memory map, and treat highmem as
another flavour or PA space restriction.

This series does a few things:

- introduce new attributes to control the enabling of the highmem
  GICv3 redistributors and the highmem PCIe MMIO range

- correctly cap the PA range with highmem is off

- generalise the highmem behaviour to any PA range

- disable each highmem device region that doesn't fit in the PA range

- cleanup uses of highmem outside of virt_set_memmap()

This has been tested on an M1-based Mac-mini running Linux v5.16-rc6
with both KVM and TCG.

* From v3 [1]:

  - Introduced highmem_mmio as the MMIO pendant to highmem_ecam after
    Eric made it plain that I was misguided in using highmem_ecam to
    gate the MMIO region.

  - Fixed the way the top of RAM is enforced (using the device memory
    size, rounded up to the nearest GB). I long debated *not* using
    the rounded up version, but finally decided that it would be the
    least surprising, given that each slot is supposed to hold a full
    GB.

  - Now allowing some of the highmem devices to be individually
    enabled if they fit in the PA range. For example, a system with a
    39bit PA range and at most 255GB of RAM can use the highmem redist
    and PCIe ECAM ranges, but not the high PCIe range.

  - Dropped some of Andrew's RBs, as the code significantly changed.

[1] https://lore.kernel.org/r/20211227211642.994461-1-maz@kernel.org

Marc Zyngier (6):
  hw/arm/virt: Add a control for the the highmem PCIe MMIO
  hw/arm/virt: Add a control for the the highmem redistributors
  hw/arm/virt: Honor highmem setting when computing the memory map
  hw/arm/virt: Use the PA range to compute the memory map
  hw/arm/virt: Disable highmem devices that don't fit in the PA range
  hw/arm/virt: Drop superfluous checks against highmem

 hw/arm/virt-acpi-build.c | 10 ++---
 hw/arm/virt.c            | 87 +++++++++++++++++++++++++++++++++++-----
 include/hw/arm/virt.h    |  5 ++-
 3 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
