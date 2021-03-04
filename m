Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 076B032DA98
	for <lists+kvmarm@lfdr.de>; Thu,  4 Mar 2021 20:51:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 79A594B665;
	Thu,  4 Mar 2021 14:51:41 -0500 (EST)
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
	with ESMTP id yW9B+gRJ4YHa; Thu,  4 Mar 2021 14:51:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 65E474B667;
	Thu,  4 Mar 2021 14:51:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5393E4B664
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 14:51:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fntLOs3d0GAK for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Mar 2021 14:51:38 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7D72D4B660
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 14:51:38 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB9164F36;
 Thu,  4 Mar 2021 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614887497;
 bh=ppev95IRq0ko0CFGee8LBgrN4g0vaWYUMRdDU803TPo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kss5eJZbCOMAhR49LUrOU62oxFhl6HZfRQt1aJrNyfWTPUoHuXX1EUXLCdTGgrfHh
 Ab2sNWyll1YeBA4fCCVlDzvgH13S+eB8f4BTd3QS1dZKZIl7/zpUT1cY/eWRkNHj2x
 Uqa3f3rhwC9L8EUyN9sHVV80SHr3sJTJEevY+1fNSnb0XuYNa1xSj7NiCizLL6Cm00
 i07ORjh0/fra1zDhCSxw59N5jZgQwF53m3o7Jfy8a7+ygzQ83WFvXAObocL/22nNyV
 CfcWezrT0SY4ZwhTSgVsHloW0KQd9Th6OaMlYLfYpPSAqiabzDG2+272k9olN/KPkX
 7fyIWZUX3kFUA==
Date: Thu, 4 Mar 2021 19:51:31 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v3 25/32] KVM: arm64: Sort the hypervisor memblocks
Message-ID: <20210304195131.GE21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-26-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-26-qperret@google.com>
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

On Tue, Mar 02, 2021 at 02:59:55PM +0000, Quentin Perret wrote:
> We will soon need to check if a Physical Address belongs to a memblock
> at EL2, so make sure to sort them so this can be done efficiently.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/reserved_mem.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
