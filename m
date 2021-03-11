Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD03378D0
	for <lists+kvmarm@lfdr.de>; Thu, 11 Mar 2021 17:09:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A3B834B6C7;
	Thu, 11 Mar 2021 11:09:39 -0500 (EST)
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
	with ESMTP id oD-ZW65tNoIF; Thu, 11 Mar 2021 11:09:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 878F04B577;
	Thu, 11 Mar 2021 11:09:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 82BD24B4C7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 11:09:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zEHdNqC-UCay for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Mar 2021 11:09:29 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6BE3E4B49C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 11:09:29 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ADE964D5D;
 Thu, 11 Mar 2021 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615478966;
 bh=CMKCM7h0YQHLp6ZA1+GQSMClZW5GB0avjdcUEF2pvzs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fwm0z8S4cbkmBI9wGOic+8gXazddLFOq+1WS0pmt2WIgCo8ilgf2CYIvNtECwnV+Y
 XaYEthzmQGBxR89fkBTfPZzUWe/Rr7c18eePTkUBJiBMw1JJasc4DXIUSo2ALGxOFB
 zlNhoVrlBOs+l8JYlCyyP/4JfnKQRuFEeoLQIl7oyBVsgZ5nT0XDiRARuJPIp3wArB
 AesXYfsTIGOsKHVN4B7fIwl8+EBKKYvx5V94kYCyF/ZupTGHO167M0sXqq28Xh8q6f
 kWn+P9jA33sbDslbET4BuzIGsvfgVYLaTaIdV6cQTkeQ+3xJKSPcBgxTKW0zfvaIWM
 1qXrNDcdpNpZA==
Date: Thu, 11 Mar 2021 16:09:19 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 06/34] KVM: arm64: Factor memory allocation out of
 pgtable.c
Message-ID: <20210311160919.GA31206@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-7-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-7-qperret@google.com>
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

On Wed, Mar 10, 2021 at 05:57:23PM +0000, Quentin Perret wrote:
> In preparation for enabling the creation of page-tables at EL2, factor
> all memory allocation out of the page-table code, hence making it
> re-usable with any compatible memory allocator.
> 
> No functional changes intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 41 +++++++++++-
>  arch/arm64/kvm/hyp/pgtable.c         | 98 +++++++++++++++++-----------
>  arch/arm64/kvm/mmu.c                 | 66 ++++++++++++++++++-
>  3 files changed, 163 insertions(+), 42 deletions(-)

Thanks, looks good to me now:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
