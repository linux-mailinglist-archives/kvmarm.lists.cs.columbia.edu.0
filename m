Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5277833C1E0
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 17:32:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05D354B654;
	Mon, 15 Mar 2021 12:32:07 -0400 (EDT)
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
	with ESMTP id UAOBYMXfNb3U; Mon, 15 Mar 2021 12:32:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EECE74B640;
	Mon, 15 Mar 2021 12:32:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A92C4B62D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 12:32:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h029oYhBlBZP for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 12:32:03 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 37F1E4B61B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 12:32:03 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6331064F2A;
 Mon, 15 Mar 2021 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615825922;
 bh=iwo+by8AySGGmHW/D8BGbdboYbUVduzmcnfSM8i4yqI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zo5DGjgEb+KZdOnvPRLKgdHlv3B25inChQcgjGYHXp8AzplO8TabMLfYjT/Ccmz0o
 1cp/2IDbT74ivkPFSf6Uisml5wHb1ToqK1JRrs/Nemj5GyNuiwxWdQxxO1xhPrm3lI
 dO1rpqxCH7ukRLd/ggPorCQ885P9zx8cvuGExdxEw3I3d9ojcrZh96ipsRbnm27aoe
 0ZzT9E89a7YHggAOzzqsIsDL0rfyPKiZ//KALPKvnPdsdmHiRR3VaRc3hqguF6x+3s
 Z1liXeug6LkIYG5X15x5y+LuGL6Ad04c7Vo0B2zSIqorZ2Ffj3R3VtL7tmu1tt0QXJ
 zoepJNRQPxEmg==
Date: Mon, 15 Mar 2021 16:31:56 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v5 32/36] KVM: arm64: Provide sanitized mmfr* registers
 at EL2
Message-ID: <20210315163155.GB3430@willie-the-truck>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-33-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210315143536.214621-33-qperret@google.com>
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

On Mon, Mar 15, 2021 at 02:35:32PM +0000, Quentin Perret wrote:
> We will need to read sanitized values of mmfr{0,1}_el1 at EL2 soon, so
> add them to the list of copied variables.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_cpufeature.h | 2 ++
>  arch/arm64/kvm/sys_regs.c               | 2 ++
>  2 files changed, 4 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
