Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 556D648EB3C
	for <lists+kvmarm@lfdr.de>; Fri, 14 Jan 2022 15:08:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A26DA49EE3;
	Fri, 14 Jan 2022 09:08:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HMKplVi+ais4; Fri, 14 Jan 2022 09:08:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AB7F449EFD;
	Fri, 14 Jan 2022 09:08:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CB3249E34
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Jan 2022 09:08:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RrLN3B58ukEJ for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Jan 2022 09:08:06 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4CE5B49E3F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Jan 2022 09:08:06 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 35AF361C36;
 Fri, 14 Jan 2022 14:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB31C36AEA;
 Fri, 14 Jan 2022 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642169284;
 bh=knOBnUE82gt9CRPjZF6CxX2oukDKd5Mgh+KsoFSKdKo=;
 h=From:To:Cc:Subject:Date:From;
 b=Or0G3wm6TzjDuXFNjXFJKPgN0O1xeNzSj8ugOdspnJQpYkt0xDa1l3kUARpBrwRHW
 CegsBQsXZbHIhL+wC2U32dc/nugrvkJ5qLg1mv6kx0vHMYP2uqqN/Hls27jVrYZyHV
 e1KZD9mvTVlWyg2wy4XLivIsfwb/oczKCGFfYVmQDtXrgnNQRQCzcmN/XMiWmzrP8r
 VZo5DHEUaMxyRDOI63wzo3TnypbAE1GRz7sJjF3yFRMcdaPEaD/SU664NzQDlYQxOV
 SMp0z8V53AY8HOFvO55QwCGNf1+R/J2CicKZfpRpbe7LTiHaqQ0Q4UXQEd+ntb2W8h
 GU1BXxJ9mEOJg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1n8NFK-000V8K-Iy; Fri, 14 Jan 2022 14:08:02 +0000
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/6] target/arm: Reduced-IPA space and highmem fixes
Date: Fri, 14 Jan 2022 14:07:35 +0000
Message-Id: <20220114140741.1358263-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: qemu-devel@nongnu.org, drjones@redhat.com,
 eric.auger@redhat.com, peter.maydell@linaro.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, kernel-team@android.com
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

Here's yet another stab at enabling QEMU on systems with
pathologically reduced IPA ranges such as the Apple M1 (previous
version at [1]). Eventually, we're able to run a KVM guest with more
than just 3GB of RAM on a system with a 36bit IPA space, and at most
123 vCPUs.

This also addresses some pathological QEMU behaviours, where the
highmem property is used as a flag allowing exposure of devices that
can't possibly fit in the PA space of the VM, resulting in a guest
failure.

In the end, we generalise the notion of PA space when exposing
individual devices in the expanded memory map, and treat highmem as
another flavour of PA space restriction.

This series does a few things:

- introduce new attributes to control the enabling of the highmem
  GICv3 redistributors and the highmem PCIe MMIO range

- correctly cap the PA range with highmem is off

- generalise the highmem behaviour to any PA range

- disable each highmem device region that doesn't fit in the PA range

- cleanup uses of highmem outside of virt_set_memmap()

This has been tested on an M1-based Mac-mini running Linux v5.16-rc6
with both KVM and TCG.

* From v4: [1]

  - Moved cpu_type_valid() check before we compute the memory map
  - Drop useless MAX() when computing highest_gpa
  - Fixed more deviations from the QEMU coding style
  - Collected Eric's RBs, with thanks

[1]: https://lore.kernel.org/r/20220107163324.2491209-1-maz@kernel.org

Marc Zyngier (6):
  hw/arm/virt: Add a control for the the highmem PCIe MMIO
  hw/arm/virt: Add a control for the the highmem redistributors
  hw/arm/virt: Honor highmem setting when computing the memory map
  hw/arm/virt: Use the PA range to compute the memory map
  hw/arm/virt: Disable highmem devices that don't fit in the PA range
  hw/arm/virt: Drop superfluous checks against highmem

 hw/arm/virt-acpi-build.c | 10 ++--
 hw/arm/virt.c            | 98 ++++++++++++++++++++++++++++++++++------
 include/hw/arm/virt.h    |  5 +-
 3 files changed, 91 insertions(+), 22 deletions(-)

-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
