Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6130C994
	for <lists+kvmarm@lfdr.de>; Tue,  2 Feb 2021 19:24:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA16A4B1EC;
	Tue,  2 Feb 2021 13:24:32 -0500 (EST)
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
	with ESMTP id aTzHBg56FnMC; Tue,  2 Feb 2021 13:24:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DA754B1CF;
	Tue,  2 Feb 2021 13:24:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B93364B1C9
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Feb 2021 13:24:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDEotkVFF4Zk for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Feb 2021 13:24:29 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B349B4B1A8
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Feb 2021 13:24:29 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6ED064F5E;
 Tue,  2 Feb 2021 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612290268;
 bh=W1IuyyCVtN9nb9HYjJ7+xdSm5mp9t0pkfUAf4II4elY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CCAib0qBVSZ78VMBIzFz/4NCH8++z5N6UdDRJkDlw37aocpi0MBKKJ+WH45WxIl8x
 XityNuus+I6AnlCsqL35HXBZjYgqGnGGIZOX9wzgnZybZwQWJqRY1dkysF2zA4KvMw
 LaXlTTwHrxlMOGQU3Hcn+MVjiSclDb7u1o4dtOQPahlEKqEwP4sN4OpUavXF810Qsi
 rv3HG+zAablMOyxAmLPWtAEC3+DelKN6XEsjcZWdl5J/B8txVfqYh3zBAULgMG5tL2
 3DaOY7PUObl8/TzMrMCykQzmmkM9Z4jNf25kTcyuJo6WYkutPqyo25m+yERPVL1Ogq
 15JGQc/HdLr8w==
Date: Tue, 2 Feb 2021 18:24:22 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 14/26] KVM: arm64: Factor out vector address
 calculation
Message-ID: <20210202182422.GB17311@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-15-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-15-qperret@google.com>
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

On Fri, Jan 08, 2021 at 12:15:12PM +0000, Quentin Perret wrote:
> In order to re-map the guest vectors at EL2 when pKVM is enabled,
> refactor __kvm_vector_slot2idx() and kvm_init_vector_slot() to move all
> the address calculation logic in a static inline function.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 8 ++++++++
>  arch/arm64/kvm/arm.c             | 9 +--------
>  2 files changed, 9 insertions(+), 8 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
