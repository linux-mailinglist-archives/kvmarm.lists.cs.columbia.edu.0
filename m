Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C633BFC9
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 16:34:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C1994B5AA;
	Mon, 15 Mar 2021 11:34:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W4GQdMMGwvhD; Mon, 15 Mar 2021 11:34:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B8C194B548;
	Mon, 15 Mar 2021 11:34:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 611BF4B483
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 11:34:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mN7OrW+48BbH for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 11:34:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CBEFD4B3FF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 11:34:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 382AF1FB;
 Mon, 15 Mar 2021 08:34:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E03333F792;
 Mon, 15 Mar 2021 08:34:09 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v3 00/22] Unify I/O port and MMIO trap handling
Date: Mon, 15 Mar 2021 15:33:28 +0000
Message-Id: <20210315153350.19988-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Cc: Marc Zyngier <maz@kernel.org>, Sami Mujawar <sami.mujawar@arm.com>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

Hi,

this version is addressing Alexandru's comments, fixing mostly minor
issues in the naming scheme. The biggest change is to keep the
ioport__read/ioport_write wrappers for the serial device.
For more details see the changelog below.
==============

At the moment we use two separate code paths to handle exits for
KVM_EXIT_IO (ioport.c) and KVM_EXIT_MMIO (mmio.c), even though they
are semantically very similar. Because the trap handler callback routine
is different, devices need to decide on one conduit or need to provide
different handler functions for both of them.

This is not only unnecessary code duplication, but makes switching
devices from I/O port to MMIO a tedious task, even though there is no
real difference between the two, especially on ARM and PowerPC.

For ARM we aim at providing a flexible memory layout, and also have
trouble with the UART and RTC device overlapping with the PCI I/O area,
so it seems indicated to tackle this once and for all.

The first three patches do some cleanup, to simplify things later.

Patch 04/22 lays the groundwork, by extending mmio.c to be able to also
register I/O port trap handlers, using the same callback prototype as
we use for MMIO.

The next 14 patches then convert devices that use the I/O port
interface over to the new joint interface. This requires to rework
the trap handler routine to adhere to the same prototype as the existing
MMIO handlers. For most devices this is done in two steps: a first to
introduce the reworked handler routine, and a second to switch to the new
joint registration routine. For some devices the first step is trivial,
so it's done in one patch.

Patch 19/22 then retires the old I/O port interface, by removing ioport.c
and friends.
Patch 20/22 uses the opportunity to clean up the memory map description,
also declares a new region (from 16MB on), where the final two patches
switch the UART and the RTC device to. They are now registered
on the MMIO "bus", when running on ARM or arm64. This moves them away
from the first 64KB, so they are not in the PCI I/O area anymore.

Please have a look and comment!

Cheers,
Andre

Changelog v2 .. v3:
- use _io as function prefix for x86 I/O port devices
- retain ioport__{read,write}8() wrappers for serial device
- fix memory map ASCII art
- fix serial base declaration
- minor nit fixes
- add Reviewed-by: tags

Changelog v1 .. v2:
- rework memory map definition
- add explicit debug output for debug I/O port
- add explicit check for MMIO coalescing on I/O ports
- drop usage of ioport__{read,write}8() from serial
- drop explicit I/O port cleanup routine (to mimic MMIO operation)
- add comment for IOTRAP_BUS_MASK
- minor cleanups / formatting changes


Andre Przywara (22):
  ioport: Remove ioport__setup_arch()
  hw/serial: Use device abstraction for FDT generator function
  ioport: Retire .generate_fdt_node functionality
  mmio: Extend handling to include ioport emulation
  hw/i8042: Clean up data types
  hw/i8042: Refactor trap handler
  hw/i8042: Switch to new trap handlers
  x86/ioport: Refactor trap handlers
  x86/ioport: Switch to new trap handlers
  hw/rtc: Refactor trap handlers
  hw/rtc: Switch to new trap handler
  hw/vesa: Switch trap handling to use MMIO handler
  hw/serial: Refactor trap handler
  hw/serial: Switch to new trap handlers
  vfio: Refactor ioport trap handler
  vfio: Switch to new ioport trap handlers
  virtio: Switch trap handling to use MMIO handler
  pci: Switch trap handling to use MMIO handler
  Remove ioport specific routines
  arm: Reorganise and document memory map
  hw/serial: ARM/arm64: Use MMIO at higher addresses
  hw/rtc: ARM/arm64: Use MMIO at higher addresses

 Makefile                          |   1 -
 arm/include/arm-common/kvm-arch.h |  47 ++++--
 arm/ioport.c                      |   5 -
 hw/i8042.c                        |  94 +++++-------
 hw/rtc.c                          |  91 ++++++------
 hw/serial.c                       | 126 +++++++++++-----
 hw/vesa.c                         |  19 +--
 include/kvm/i8042.h               |   1 -
 include/kvm/ioport.h              |  32 ----
 include/kvm/kvm.h                 |  49 ++++++-
 ioport.c                          | 235 ------------------------------
 mips/kvm.c                        |   5 -
 mmio.c                            |  65 +++++++--
 pci.c                             |  82 +++--------
 powerpc/ioport.c                  |   6 -
 vfio/core.c                       |  50 ++++---
 virtio/pci.c                      |  46 ++----
 x86/ioport.c                      | 108 +++++++-------
 18 files changed, 421 insertions(+), 641 deletions(-)
 delete mode 100644 ioport.c

-- 
2.17.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
