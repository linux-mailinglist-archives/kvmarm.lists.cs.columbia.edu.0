Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 17F922073DF
	for <lists+kvmarm@lfdr.de>; Wed, 24 Jun 2020 14:58:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 756A74B259;
	Wed, 24 Jun 2020 08:58:56 -0400 (EDT)
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
	with ESMTP id i1Imr4dutKMX; Wed, 24 Jun 2020 08:58:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 196F14B248;
	Wed, 24 Jun 2020 08:58:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C2BB64B20A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Jun 2020 08:58:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dZftt-d-Nog1 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Jun 2020 08:58:52 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C11F44B1E7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Jun 2020 08:58:52 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC7F920706;
 Wed, 24 Jun 2020 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593003531;
 bh=wc5mxzVtIYH7yXtP0I4Y5L+JdMP9jb1MqWLgvygyC2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g7LBBWk0hcjd9EWZt5yCOj+T1kx3Nm+H/7l/getRmdhgGbnYXcCS7OByq70ddLFLp
 c26IiFZtjdu0zSZHl/BF7aEBhL5FZ21TcitI3oJgebolD4iDQdMXOL2H/63jOWFhbl
 1LguVB1N74FOG5WCRfQjYaROpMCGXIAihnhNJpsM=
Date: Wed, 24 Jun 2020 13:58:46 +0100
From: Will Deacon <will@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH stable 4.9] arm64: entry: Place an SB sequence following
 an ERET instruction
Message-ID: <20200624125846.GD6270@willie-the-truck>
References: <20200612044219.31606-1-f.fainelli@gmail.com>
 <2bcebe48-1218-403a-798c-da30d678fdd6@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2bcebe48-1218-403a-798c-da30d678fdd6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "open list:KERNEL VIRTUAL MACHINE \(KVM\)" <kvm@vger.kernel.org>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Christoffer Dall <christoffer.dall@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, linux-arm-kernel@lists.infradead.org
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

On Tue, Jun 23, 2020 at 11:46:37AM -0700, Florian Fainelli wrote:
> On 6/11/20 9:42 PM, Florian Fainelli wrote:
> > From: Will Deacon <will.deacon@arm.com>
> > 
> > commit 679db70801da9fda91d26caf13bf5b5ccc74e8e8 upstream
> > 
> > Some CPUs can speculate past an ERET instruction and potentially perform
> > speculative accesses to memory before processing the exception return.
> > Since the register state is often controlled by a lower privilege level
> > at the point of an ERET, this could potentially be used as part of a
> > side-channel attack.
> > 
> > This patch emits an SB sequence after each ERET so that speculation is
> > held up on exception return.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > [florian: Adjust hyp-entry.S to account for the label]
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> > Will,
> > 
> > Can you confirm that for 4.9 these are the only places that require
> > patching? Thank you!
> 
> Hi Will, Catalin,
> 
> Does this look good to you for a 4.9 backport? I would like to see this
> included at some point since this pertains to CVE-2020-13844.

I think you're missing one of the ERET instructions in hyp/entry.S

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
