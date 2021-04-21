Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D44D43665A8
	for <lists+kvmarm@lfdr.de>; Wed, 21 Apr 2021 08:51:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54A824B4B6;
	Wed, 21 Apr 2021 02:51:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ok7VSWwomXur; Wed, 21 Apr 2021 02:51:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 152924B4B7;
	Wed, 21 Apr 2021 02:51:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 566F94B4A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Apr 2021 02:51:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I3sC0oM9lf40 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Apr 2021 02:51:18 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 140FB4B47D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Apr 2021 02:51:18 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2A3F6141C;
 Wed, 21 Apr 2021 06:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618987877;
 bh=h4GND5vJICk88LCJ9meFOAMI9O6wV3PzqLp/IpgFJ7U=;
 h=From:To:Cc:Subject:Date:From;
 b=Sa/SkDUfTgVqWZXzIXBK9d2C/yo2XcW+5D8jncWLrCpkTua+0/K3LdRSdZaDn/oq8
 p1D+KhoiFeBa8xb6Z9UFllDPVCvaVSylc4lQOskt/bNX2EWVz+04L1Ei3JX7AfH1m4
 jgEIE24S7R6HkKcfU/PgPKyQ7hiWJ8SIeoqy6dRhpJkwW6wquRFM6EztRvgUCQrAS7
 s04ebkNr/UT6CsAO2UsCDG9mK3cR7ypINnS1jy1X97f7Kteov8DtUApmzFsoxH4cQ4
 tX1YfgfNDud8WqTdgTHuC56C/P/VtjXn3CrzXeZAf2nPB0xqd3MXW5BscLfR2ydMK5
 uoCF7wb3lZs5g==
From: Mike Rapoport <rppt@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
Date: Wed, 21 Apr 2021 09:51:04 +0300
Message-Id: <20210421065108.1987-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
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

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
pfn_valid_within() to 1. 

The idea is to mark NOMAP pages as reserved in the memory map and restore
the intended semantics of pfn_valid() to designate availability of struct
page for a pfn.

With this the core mm will be able to cope with the fact that it cannot use
NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
will be treated correctly even without the need for pfn_valid_within.

The patches are only boot tested on qemu-system-aarch64 so I'd really
appreciate memory stress tests on real hardware.

If this actually works we'll be one step closer to drop custom pfn_valid()
on arm64 altogether.

v2:
* Add check for PFN overflow in pfn_is_map_memory()
* Add Acked-by and Reviewed-by tags, thanks David.

v1: Link: https://lore.kernel.org/lkml/20210420090925.7457-1-rppt@kernel.org
* Add comment about the semantics of pfn_valid() as Anshuman suggested
* Extend comments about MEMBLOCK_NOMAP, per Anshuman
* Use pfn_is_map_memory() name for the exported wrapper for
  memblock_is_map_memory(). It is still local to arch/arm64 in the end
  because of header dependency issues.

rfc: Link: https://lore.kernel.org/lkml/20210407172607.8812-1-rppt@kernel.org

Mike Rapoport (4):
  include/linux/mmzone.h: add documentation for pfn_valid()
  memblock: update initialization of reserved pages
  arm64: decouple check whether pfn is in linear map from pfn_valid()
  arm64: drop pfn_valid_within() and simplify pfn_valid()

 arch/arm64/Kconfig              |  3 ---
 arch/arm64/include/asm/memory.h |  2 +-
 arch/arm64/include/asm/page.h   |  1 +
 arch/arm64/kvm/mmu.c            |  2 +-
 arch/arm64/mm/init.c            | 10 ++++++++--
 arch/arm64/mm/ioremap.c         |  4 ++--
 arch/arm64/mm/mmu.c             |  2 +-
 include/linux/memblock.h        |  4 +++-
 include/linux/mmzone.h          | 11 +++++++++++
 mm/memblock.c                   | 28 ++++++++++++++++++++++++++--
 10 files changed, 54 insertions(+), 13 deletions(-)

base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.28.0

*** BLURB HERE ***

Mike Rapoport (4):
  include/linux/mmzone.h: add documentation for pfn_valid()
  memblock: update initialization of reserved pages
  arm64: decouple check whether pfn is in linear map from pfn_valid()
  arm64: drop pfn_valid_within() and simplify pfn_valid()

 arch/arm64/Kconfig              |  3 ---
 arch/arm64/include/asm/memory.h |  2 +-
 arch/arm64/include/asm/page.h   |  1 +
 arch/arm64/kvm/mmu.c            |  2 +-
 arch/arm64/mm/init.c            | 15 +++++++++++++--
 arch/arm64/mm/ioremap.c         |  4 ++--
 arch/arm64/mm/mmu.c             |  2 +-
 include/linux/memblock.h        |  4 +++-
 include/linux/mmzone.h          | 11 +++++++++++
 mm/memblock.c                   | 28 ++++++++++++++++++++++++++--
 10 files changed, 59 insertions(+), 13 deletions(-)

-- 
2.28.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
