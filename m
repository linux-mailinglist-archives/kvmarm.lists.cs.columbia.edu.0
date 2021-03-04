Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E132DACE
	for <lists+kvmarm@lfdr.de>; Thu,  4 Mar 2021 21:05:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CEA74B3F3;
	Thu,  4 Mar 2021 15:05:41 -0500 (EST)
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
	with ESMTP id KArqwBzU0cuE; Thu,  4 Mar 2021 15:05:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6471B4B60F;
	Thu,  4 Mar 2021 15:05:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D395A4B427
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 15:05:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vz90J8XFzW-f for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Mar 2021 15:05:37 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C16F24B414
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 15:05:37 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A63364F73;
 Thu,  4 Mar 2021 20:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614888336;
 bh=FUVg1X26+WbK2+gd2WkNaErZqBQdZJhpxO9hYC8znog=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WUr7W1rh47prVwLZBWbrrPMqyCxV00k+dS5ZnJDRPr2cMW6WQsdrq/M/PS7r/Pzy3
 W4qo0y207uXNLxAcdMVtzWEVDPz5JTyVXKX4nuZyouLO7V7JT6348kngpINsHAtCt6
 G5gFQ3JRCRNINW0Pkchn4UYGlNtU/e2maqDp/StTkhKSzv8KEi8DMl7mRVm4rWCv/F
 iEon2O6RRPX4DDSJ4Eo5cO2uRlycMmd+p+52Vrolqi+7HddTDCJNNpPnhUzlqO1yWL
 kVE50r9BOGSzb5pw+F5lzRixyLo5nYBXdvfb8fBxGweos7wpC1cpOlcC2gnRAmQ8C6
 tRDQdmYw4gWIA==
Date: Thu, 4 Mar 2021 20:05:31 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v3 30/32] KVM: arm64: Page-align the .hyp sections
Message-ID: <20210304200530.GH21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-31-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-31-qperret@google.com>
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

On Tue, Mar 02, 2021 at 03:00:00PM +0000, Quentin Perret wrote:
> We will soon unmap the .hyp sections from the host stage 2 in Protected
> nVHE mode, which obvisouly works with at least page granularity, so make
> sure to align them correctly.

s/obvisouly/obviously/

> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

With the typo fixed:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
