Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD63F8616
	for <lists+kvmarm@lfdr.de>; Thu, 26 Aug 2021 13:07:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 224444B187;
	Thu, 26 Aug 2021 07:07:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rfiRcnriollH; Thu, 26 Aug 2021 07:07:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 411754B175;
	Thu, 26 Aug 2021 07:07:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ABE074B10C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Aug 2021 07:07:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X-3jS0Qh6COk for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Aug 2021 07:07:22 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 39F494B107
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Aug 2021 07:07:22 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A487B61053;
 Thu, 26 Aug 2021 11:07:19 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
 Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
 suzuki.poulose@arm.com, james.morse@arm.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, broonie@kernel.org
Subject: Re: [PATCH v2] arm64: Do not trap PMSNEVFR_EL1
Date: Thu, 26 Aug 2021 12:07:12 +0100
Message-Id: <162997601443.30374.2606931123548634826.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210824154523.906270-1-alexandru.elisei@arm.com>
References: <20210824154523.906270-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
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

On Tue, 24 Aug 2021 16:45:23 +0100, Alexandru Elisei wrote:
> Commit 31c00d2aeaa2 ("arm64: Disable fine grained traps on boot") zeroed
> the fine grained trap registers to prevent unwanted register traps from
> occuring. However, for the PMSNEVFR_EL1 register, the corresponding
> HDFG{R,W}TR_EL2.nPMSNEVFR_EL1 fields must be 1 to disable trapping. Set
> both fields to 1 if FEAT_SPEv1p2 is detected to disable read and write
> traps.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Do not trap PMSNEVFR_EL1
      https://git.kernel.org/arm64/c/50cb99fa89aa

-- 
Catalin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
