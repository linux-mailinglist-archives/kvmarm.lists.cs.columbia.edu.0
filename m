Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 42E771BC4BD
	for <lists+kvmarm@lfdr.de>; Tue, 28 Apr 2020 18:13:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C65394B289;
	Tue, 28 Apr 2020 12:13:58 -0400 (EDT)
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
	with ESMTP id EzWDNyVnLoL0; Tue, 28 Apr 2020 12:13:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 99E034B2B2;
	Tue, 28 Apr 2020 12:13:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D399A4B259
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Apr 2020 12:13:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id McAx5h3sT7pC for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 Apr 2020 12:13:55 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BD2124B244
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Apr 2020 12:13:55 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B69F2063A;
 Tue, 28 Apr 2020 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588090434;
 bh=CHxPMdMtXgCxp7jYJRO9Lz56+pxSSBnx2dPI3JGn6mQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Oh8fOJLNiku2IDCPSQblj3TfEucyBMwB1dATPVIP2q2tPa5qN05yteDCnICfRyouX
 2v4HOThXeH7+UiZKXvk6VczULmRhp6sCi10Hj4qzZ6Sb01KtQsiuCxj3y0UWStUq3o
 GsBjYh+b2Ke9RL1tp+ueRqKW9M5vrPxbfvBiEWdg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jTSrp-007QVJ-2k; Tue, 28 Apr 2020 17:13:53 +0100
MIME-Version: 1.0
Date: Tue, 28 Apr 2020 17:13:53 +0100
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: Fix spelling in code comments
In-Reply-To: <20200428155847.GC12697@willie-the-truck>
References: <20200401140310.29701-1-tabba@google.com>
 <20200428155847.GC12697@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <38234cbd287b9e7f4b87ec3d6fa9b0e5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, tabba@google.com, catalin.marinas@arm.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, trivial@kernel.org,
 jeffv@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: trivial@kernel.org, kvm@vger.kernel.org, jeffv@google.com,
 catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-04-28 16:58, Will Deacon wrote:
> On Wed, Apr 01, 2020 at 03:03:10PM +0100, Fuad Tabba wrote:
>> Fix spelling and typos (e.g., repeated words) in comments.
>> 
>> Signed-off-by: Fuad Tabba <tabba@google.com>
>> ---
>>  arch/arm64/kvm/guest.c        | 4 ++--
>>  arch/arm64/kvm/reset.c        | 6 +++---
>>  arch/arm64/kvm/sys_regs.c     | 6 +++---
>>  virt/kvm/arm/arm.c            | 6 +++---
>>  virt/kvm/arm/hyp/vgic-v3-sr.c | 2 +-
>>  virt/kvm/arm/mmio.c           | 2 +-
>>  virt/kvm/arm/mmu.c            | 6 +++---
>>  virt/kvm/arm/psci.c           | 6 +++---
>>  virt/kvm/arm/vgic/vgic-v3.c   | 2 +-
>>  virt/kvm/coalesced_mmio.c     | 2 +-
>>  virt/kvm/eventfd.c            | 2 +-
>>  virt/kvm/kvm_main.c           | 2 +-
>>  12 files changed, 23 insertions(+), 23 deletions(-)
> 
> FWIW, these *do* all look like valid typos to me, but I'll leave it at
> Marc's discretion as to whether he wants to merge the series, since 
> things
> like this can confuse 'git blame' and get in the way of backports.

I have provisionally queued this a couple of weeks ago, with a goal to
apply it on top of the whole arm64 cleanup series.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
