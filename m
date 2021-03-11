Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0552C33792E
	for <lists+kvmarm@lfdr.de>; Thu, 11 Mar 2021 17:22:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6E5F4B68F;
	Thu, 11 Mar 2021 11:22:17 -0500 (EST)
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
	with ESMTP id kT5gIGXdAfGO; Thu, 11 Mar 2021 11:22:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83F3E4B6B8;
	Thu, 11 Mar 2021 11:22:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FC504B621
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 11:22:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XYJv-u1I9fZJ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Mar 2021 11:22:10 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 070424B548
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 11:22:09 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEB776146B;
 Thu, 11 Mar 2021 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615479728;
 bh=1VYaodho3Fb2my+EoZ2QcmI2TzkSbTeXP60JfAHZD8E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LMKLdG1n8750gfq5NUbVfRcgOwLwtLSBp3+oVjApFw4OYSxxjnjWcqHa03ztA92Lz
 aIt3vMqS5PAIsqZ/1Tc5fgLYV01t5Qpa1vW/trKAd1UbcPQHhuHQQJyRhoOmHN+9FE
 CwQFfFya4qUmSQ+mjHGeeHKoSJNPNZJp3O2uOR+PJKFSW5ItcWOZBHoGHMEsX6krZu
 7aA2bw3TkZPz3opFzfInaDpCUrGBjXnzjSRj6mBdmfms6NdwbP2xM1rlIivbNrhOnZ
 rIy1RttdU7npdm8PONdNhLosyN+ckCZnw1kWirSPCqXBI10DjY5YUnSEuezjQeLpze
 P3xanJ9ns49jw==
Date: Thu, 11 Mar 2021 16:22:01 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 15/34] arm64: asm: Provide set_sctlr_el2 macro
Message-ID: <20210311162201.GE31206@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-16-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-16-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: android-kvm@google.com, catalin.marinas@arm.com, mate.toth-pal@arm.com,
 seanjc@google.com, tabba@google.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Wed, Mar 10, 2021 at 05:57:32PM +0000, Quentin Perret wrote:
> We will soon need to turn the EL2 stage 1 MMU on and off in nVHE
> protected mode, so refactor the set_sctlr_el1 macro to make it usable
> for that purpose.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/assembler.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
