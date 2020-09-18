Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26926FE75
	for <lists+kvmarm@lfdr.de>; Fri, 18 Sep 2020 15:29:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B9F3E4B23A;
	Fri, 18 Sep 2020 09:29:04 -0400 (EDT)
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
	with ESMTP id hmbgAO1Y9hO2; Fri, 18 Sep 2020 09:29:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 846274B23C;
	Fri, 18 Sep 2020 09:29:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CDA8A4B201
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 09:29:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6sH7n1m60V1b for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Sep 2020 09:29:00 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A5AA94B1F6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 09:29:00 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E7B0E20DD4;
 Fri, 18 Sep 2020 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600435739;
 bh=ZSXhJnytwBfZIguG2YZF5f+1ToMcOTDSxabFk/OagLs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SB5sadO+SW/AHdSWa0pxHQC1+WiMYxgcOKisX+5DtSFcraR7rysLlqSohsCBJ32uj
 z7AOXp2fxOyNvBZO4FMt8YgHMMlxf+6c97GLbggAOkHppGoKIS8cA/fwcKD0pij9fU
 3h3Ai2myIT4JLbdZg090Ga5oa6m3U2d9s3ue764Y=
Date: Fri, 18 Sep 2020 14:28:54 +0100
From: Will Deacon <will@kernel.org>
To: Xiaofei Tan <tanxiaofei@huawei.com>
Subject: Re: [PATCH v3] KVM: arm64: fix doc warnings in mmu code
Message-ID: <20200918132854.GC31232@willie-the-truck>
References: <1600307269-50957-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1600307269-50957-1-git-send-email-tanxiaofei@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 17, 2020 at 09:47:49AM +0800, Xiaofei Tan wrote:
> Fix following warnings caused by mismatch bewteen function parameters
> and comments.
> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'mmu' not described in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'may_block' not described in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:128: warning: Excess function parameter 'kvm' description in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:499: warning: Function parameter or member 'writable' not described in 'kvm_phys_addr_ioremap'
> arch/arm64/kvm/mmu.c:538: warning: Function parameter or member 'mmu' not described in 'stage2_wp_range'
> arch/arm64/kvm/mmu.c:538: warning: Excess function parameter 'kvm' description in 'stage2_wp_range'
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  arch/arm64/kvm/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
