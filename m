Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 31A461B6219
	for <lists+kvmarm@lfdr.de>; Thu, 23 Apr 2020 19:39:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C57E4B18C;
	Thu, 23 Apr 2020 13:39:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YLGxgwr7qaYE; Thu, 23 Apr 2020 13:39:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 450E84B190;
	Thu, 23 Apr 2020 13:39:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EC274B16D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Apr 2020 13:39:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8dQCC+voXPgr for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Apr 2020 13:39:02 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AFFD44B185
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Apr 2020 13:39:02 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AC7430E;
 Thu, 23 Apr 2020 10:39:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B996C3F68F;
 Thu, 23 Apr 2020 10:39:00 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: [PATCH kvmtool v4 0/5] Add CFI flash emulation
Date: Thu, 23 Apr 2020 18:38:39 +0100
Message-Id: <20200423173844.24220-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: kvm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Raphael Gault <raphael.gault@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
 kvmarm@lists.cs.columbia.edu
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

an update for the CFI flash emulation, addressing Alex' comments and
adding direct mapping support.
The actual code changes to the flash emulation are minimal, mostly this
is about renaming and cleanups.
This versions now adds some patches. 1/5 is a required fix, the last
three patches add mapping support as an extension. See below.

In addition to a branch with this series[1], I also put a git branch with
all the changes compared to v3[2] as separate patches on the server, please
have a look if you want to verify against a previous review.

===============
The EDK II UEFI firmware implementation requires some storage for the EFI
variables, which is typically some flash storage.
Since this is already supported on the EDK II side, and looks like a
generic standard, this series adds a CFI flash emulation to kvmtool.

Patch 2/5 is the actual emulation code, patch 1/5 is a bug-fix for
registering MMIO devices, which is needed for this device.
Patches 3-5 add support for mapping the flash memory into guest, should
it be in read-array mode. For this to work, patch 3/5 is cherry-picked
from Alex' PCIe reassignable BAR series, to support removing a memslot
mapping. Patch 4/5 adds support for read-only mappings, while patch 5/5
adds or removes the mapping based on the current state.
I am happy to squash 5/5 into 2/5, if we agree that patch 3/5 should be
merged either separately or the PCIe series is actually merged before
this one.

This is one missing piece towards a working UEFI boot with kvmtool on
ARM guests, the other is to provide writable PCI BARs, which is WIP.
This series alone already enables UEFI boot, but only with virtio-mmio.

Cheers,
Andre

[1] http://www.linux-arm.org/git?p=kvmtool.git;a=log;h=refs/heads/cfi-flash/v4
[2] http://www.linux-arm.org/git?p=kvmtool.git;a=log;h=refs/heads/cfi-flash/v3
git://linux-arm.org/kvmtool.git (branches cfi-flash/v3 and cfi-flash/v4)

Changelog v3 .. v4:
- Rename file to cfi-flash.c (dash instead of underscore).
- Unify macro names for states, modes and commands.
- Enforce one or two chips only.
- Comment on pow2_size() function.
- Use more consistent identifier spellings.
- Assign symbols to status register values.
- Drop RCR register emulation.
- Use numerical offsets instead of names for query offsets to match spec.
- Cleanup error path and reword info message in create_flash_device_file().
- Add fix to allow non-virtio MMIO device emulations.
- Support tearing down and adding read-only memslots.
- Add read-only memslot mapping when in read mode.

Changelog v2 .. v3:
- Breaking MMIO handling into three separate functions.
- Assing the flash base address in the memory map, but stay at 32 MB for now.
  The MMIO area has been moved up to 48 MB, to never overlap with the
  flash.
- Impose a limit of 16 MB for the flash size, mostly to fit into the
  (for now) fixed memory map.
- Trim flash size down to nearest power-of-2, to match hardware.
- Announce forced flash size trimming.
- Rework the CFI query table slightly, to add the addresses as array
  indicies.
- Fix error handling when creating the flash device.
- Fix pow2_size implementation for 0 and 1 as input values.
- Fix write buffer size handling.
- Improve some comments.

Changelog v1 .. v2:
- Add locking for MMIO handling.
- Fold flash read into handler.
- Move pow2_size() into generic header.
- Spell out flash base address.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
