Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C3A3F4C16E6
	for <lists+kvmarm@lfdr.de>; Wed, 23 Feb 2022 16:34:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2EC884C600;
	Wed, 23 Feb 2022 10:34:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elbO3bNg5zob; Wed, 23 Feb 2022 10:34:43 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6FEDE4C5F4;
	Wed, 23 Feb 2022 10:34:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D6134C5AD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Feb 2022 10:34:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GfmVT6mLHzf6 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 23 Feb 2022 10:34:38 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B4C574C5A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Feb 2022 10:34:38 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C8EB361828;
 Wed, 23 Feb 2022 15:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680A6C340E7;
 Wed, 23 Feb 2022 15:34:34 +0000 (UTC)
Date: Wed, 23 Feb 2022 15:34:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 27/40] KVM: arm64: Trap SME usage in guest
Message-ID: <YhZUB04SK3kZ08uz@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-28-broonie@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207152109.197566-28-broonie@kernel.org>
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Will Deacon <will@kernel.org>, Luis Machado <luis.machado@arm.com>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Salil Akerkar <Salil.Akerkar@arm.com>
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

On Mon, Feb 07, 2022 at 03:20:56PM +0000, Mark Brown wrote:
> SME defines two new traps which need to be enabled for guests to ensure
> that they can't use SME, one for the main SME operations which mirrors the
> traps for SVE and another for access to TPIDR2 in SCTLR_EL2.
> 
> For VHE manage SMEN along with ZEN in activate_traps() and the FP state
> management callbacks, along with SCTLR_EL2.EnTPIDR2.  There is no
> existing dynamic management of SCTLR_EL2.
> 
> For nVHE manage TSM in activate_traps() along with the fine grained
> traps for TPIDR2 and SMPRI.  There is no existing dynamic management of
> fine grained traps.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

This looks alright to me but I'm not a kvm expert. FWIW:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
