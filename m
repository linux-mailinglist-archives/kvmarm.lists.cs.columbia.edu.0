Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57C3E2E1A
	for <lists+kvmarm@lfdr.de>; Fri,  6 Aug 2021 18:04:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1694A4B10E;
	Fri,  6 Aug 2021 12:04:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B2QIJstCbOSh; Fri,  6 Aug 2021 12:04:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 082004B108;
	Fri,  6 Aug 2021 12:04:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AF1A4B103
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Aug 2021 12:04:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J3GM9m9Oowvv for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Aug 2021 12:04:32 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0BC314B0FF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Aug 2021 12:04:32 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6143761165;
 Fri,  6 Aug 2021 16:04:29 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 0/4] Fix racing TLBI with ASID/VMID reallocation
Date: Fri,  6 Aug 2021 17:04:27 +0100
Message-Id: <162826584979.7468.15328966135917852100.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806113109.2475-1-will@kernel.org>
References: <20210806113109.2475-1-will@kernel.org>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
 Jade Alglave <jade.alglave@arm.com>
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

On Fri, 6 Aug 2021 12:31:03 +0100, Will Deacon wrote:
> While reviewing Shameer's reworked VMID allocator [1] and discussing
> with Marc, we spotted a race between TLB invalidation (which typically
> takes an ASID or VMID argument) and reallocation of ASID/VMID for the
> context being targetted.
> 
> The first patch spells out an example with try_to_unmap_one() in a
> comment, which Catalin has kindly modelled in TLA+ at [2].
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/4] arm64: mm: Fix TLBI vs ASID rollover
      https://git.kernel.org/arm64/c/5e10f9887ed8

-- 
Catalin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
