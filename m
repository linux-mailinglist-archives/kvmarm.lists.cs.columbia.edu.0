Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 974462602A1
	for <lists+kvmarm@lfdr.de>; Mon,  7 Sep 2020 19:31:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2ADBF4B26B;
	Mon,  7 Sep 2020 13:31:08 -0400 (EDT)
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
	with ESMTP id f3Hf7z90fiYF; Mon,  7 Sep 2020 13:31:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2161E4B511;
	Mon,  7 Sep 2020 13:31:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B5D384B4F5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 13:31:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bdjOg25CIDtR for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Sep 2020 13:31:05 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BA0324B48D
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Sep 2020 13:31:05 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3405206E6;
 Mon,  7 Sep 2020 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599499864;
 bh=v4eUwCV34u+Sa46vIPEyfiVoXpxmL1v3Eie6JJRYvnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=z8SOJvvaBCS3jNYTBRXOYqK2/PwXj92zthSVVSD8r0MlTk6/rn673me+KiFyb334d
 Go2aVq7VIwjW3pXpLNJIctDowHW5gMlNyIJskA3i70VNIvDSkvF9WkpjiSRK2dFcWk
 wDg1Tr7rU8QYHerh5a8+56bAS4niz/mbKcTozETg=
Date: Mon, 7 Sep 2020 18:31:00 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 00/21] KVM: arm64: Rewrite page-table code and fault
 handling
Message-ID: <20200907173059.GA13442@willie-the-truck>
References: <20200907152344.12978-1-will@kernel.org>
 <159949883707.112892.18214784615282984595.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <159949883707.112892.18214784615282984595.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Sep 07, 2020 at 06:16:14PM +0100, Marc Zyngier wrote:
> On Mon, 7 Sep 2020 16:23:23 +0100, Will Deacon wrote:
> > Here's version four of the KVM page-table rework I previously posted here:
> > 
> >   v1: https://lore.kernel.org/r/20200730153406.25136-1-will@kernel.org
> >   v2: https://lore.kernel.org/r/20200818132818.16065-1-will@kernel.org
> >   v3: https://lore.kernel.org/r/20200825093953.26493-1-will@kernel.org
> > 
> > Changes since v3 include:
> > 
> > [...]
> 
> I have provisionally applied this to kvmarm/next in order to give it
> some exposure. Please have a look at the conflict resolution with
> the latest fixes though.

Cheers, looks good to me. Holler if anything explodes.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
