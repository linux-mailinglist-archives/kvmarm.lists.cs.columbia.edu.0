Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7233C1CC
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 17:31:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 009554B653;
	Mon, 15 Mar 2021 12:31:19 -0400 (EDT)
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
	with ESMTP id jIHyftOL00AS; Mon, 15 Mar 2021 12:31:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C04644B63C;
	Mon, 15 Mar 2021 12:31:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B2A54B61B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 12:31:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qOcYswPTrfTf for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 12:31:15 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 277314B602
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 12:31:15 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4077264F2A;
 Mon, 15 Mar 2021 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615825874;
 bh=z4NG2AwrvKp1rnGS0SnMJpQVrKZy6B5wV36WyKhoKEo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tyt+CaZLBoLOKlgYe6sqDGdASlo2gRzBQ+4lDt1Z7Tzr1mCndmIzDb2TXpey2Nbg4
 5bWEAEWryYnRe4wowJCAUc1QEee1xbU9dqctOglt4WC536c8iLm1vvZuFsWk5rhWEw
 drmFCiy+bHWWLhnDQwtl1FTAqcCBZgmumzZvIs+t+0k4VwliM1L9cZLaRBWNqU8W4G
 K//s+7Z91kz8PIDC8y24LSW1moBBJwSZC0usRSUlgzvFgLKEOSnY0NcPzuemBLuHQw
 adv65R533Yx5o4pv0LMMsyYb3CU5YSiSIH64GKnwAhh+HOBLfwtIII6RpEC7wiK92G
 hINYWbd8VDEjg==
Date: Mon, 15 Mar 2021 16:31:07 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v5 31/36] KVM: arm64: Add kvm_pgtable_stage2_find_range()
Message-ID: <20210315163107.GA3430@willie-the-truck>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-32-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210315143536.214621-32-qperret@google.com>
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

On Mon, Mar 15, 2021 at 02:35:31PM +0000, Quentin Perret wrote:
> Since the host stage 2 will be identity mapped, and since it will own
> most of memory, it would preferable for performance to try and use large
> block mappings whenever that is possible. To ease this, introduce a new
> helper in the KVM page-table code which allows to search for large
> ranges of available IPA space. This will be used in the host memory
> abort path to greedily idmap large portion of the PA space.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 29 +++++++++
>  arch/arm64/kvm/hyp/pgtable.c         | 89 ++++++++++++++++++++++++++--
>  2 files changed, 114 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
