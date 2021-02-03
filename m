Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2523530DE38
	for <lists+kvmarm@lfdr.de>; Wed,  3 Feb 2021 16:34:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F7374B28B;
	Wed,  3 Feb 2021 10:34:42 -0500 (EST)
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
	with ESMTP id Plt4xPG-ft9h; Wed,  3 Feb 2021 10:34:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F6704B286;
	Wed,  3 Feb 2021 10:34:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C073C4B286
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 10:34:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18-jYFXQICBE for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Feb 2021 10:34:39 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C99464B162
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 10:34:39 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B226B64F8D;
 Wed,  3 Feb 2021 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612366478;
 bh=S9+Bq4aGL8vsbiEdvdMBV0S68KqoN1oduE+b7bzwEXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nubzrsC4b6rjzazEb1YDuQhppwUNSktXo9CXG8NdZGVSsf5LLvZvo5fop0k6fZ2Hh
 kqgNvs+M/pwwFN+R3Cun3MjtUUhBP62uFcdsxxMiG/hIZs9bYge9MlW8iFAR27X230
 wIBaOixNb7z4pyTKDSjGw/WuPm5iXml+XAjkBmQFWOIBRcoBjXeIvxBD+OGVDuhbYK
 3kspVhQQzIwm+nsVyyCbv760KcMS/v9wU+xXSCYn98alZRNLrNmUV2AghECbIqTqKv
 zRbpuBwLp2CaSm0VeMmn72CI2WmWdcz+VeRdcpMD1cKBJWEzTEvXSzew9b9F6YL7l/
 WbN8/SMs9Ofnw==
Date: Wed, 3 Feb 2021 15:34:32 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 18/26] KVM: arm64: Use kvm_arch for stage 2 pgtable
Message-ID: <20210203153431.GC18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-19-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-19-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, kvmarm@lists.cs.columbia.edu
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

On Fri, Jan 08, 2021 at 12:15:16PM +0000, Quentin Perret wrote:
> In order to make use of the stage 2 pgtable code for the host stage 2,
> use struct kvm_arch in lieu of struct kvm as the host will have the
> former but not the latter.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 5 +++--
>  arch/arm64/kvm/hyp/pgtable.c         | 6 +++---
>  arch/arm64/kvm/mmu.c                 | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
