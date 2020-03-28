Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ABB811965B6
	for <lists+kvmarm@lfdr.de>; Sat, 28 Mar 2020 12:24:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E69E54B0A0;
	Sat, 28 Mar 2020 07:24:01 -0400 (EDT)
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
	with ESMTP id cFOrhhtcj9bc; Sat, 28 Mar 2020 07:24:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF0DA4B085;
	Sat, 28 Mar 2020 07:24:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E4FD4A523
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 Mar 2020 07:23:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tge9C1mzrQSy for <kvmarm@lists.cs.columbia.edu>;
 Sat, 28 Mar 2020 07:23:58 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 93DAB4A3BF
 for <kvmarm@lists.cs.columbia.edu>; Sat, 28 Mar 2020 07:23:58 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 65F30206E6;
 Sat, 28 Mar 2020 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585394637;
 bh=OPdTpCBji5gpmZux7SMOKK6UF14o+bG6hhufft+DOnA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OIs2wvm7CpDgWIeS78sUQUHjpKH7KyEIjTnG2RhMbv+jFVCKCAM3OIOLhGz06OErD
 PekeG6Vth9KOVA8E2tPajhv2Qdpu2dL84DL0Og+8aOds9kYDE/R7wrssUZDhdkrzcT
 IGUNhYYJJKhWgUSadlukSphGohjuuv9lTk7Mt8wQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jI9ZD-00GQel-Ht; Sat, 28 Mar 2020 11:23:55 +0000
Date: Sat, 28 Mar 2020 11:23:51 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH] arm64: unify WORKAROUND_SPECULATIVE_AT_{NVHE,VHE}
Message-ID: <20200328112351.53f800ed@why>
In-Reply-To: <20200327180913.GA10454@willie-the-truck>
References: <20200327143941.195626-1-ascull@google.com>
 <1705907b-234c-6f56-1360-f598c8047d1d@arm.com>
 <20200327174838.GD178422@google.com>
 <e280f3f31bd5edc9db55757fcfa4ec62@kernel.org>
 <20200327180913.GA10454@willie-the-truck>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, ascull@google.com, steven.price@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 qperret@google.com, dbrazdil@google.com, qwandor@google.com, tabba@google.com,
 wedsonaf@google.com, kernel-team@android.com, James.Morse@arm.com,
 Suzuki.Poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: qwandor@google.com, tabba@google.com, Steven Price <steven.price@arm.com>,
 wedsonaf@google.com, dbrazdil@google.com, kernel-team@android.com,
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

On Fri, 27 Mar 2020 18:09:14 +0000
Will Deacon <will@kernel.org> wrote:

> On Fri, Mar 27, 2020 at 05:52:59PM +0000, Marc Zyngier wrote:
> > On 2020-03-27 17:48, Andrew Scull wrote:  
> > > Thanks, Steven. Could we look into the EPD* caching microarch details
> > > Marc was referring to for these A55 and A76 cores?  
> > 
> > Only the folks that have access to the RTL can tell you, unfortunately.
> > 
> > Thankfully, there is a bunch of people on Cc that should be able to ping
> > the relevant teams and report back...  
> 
> Yup, otherwise I guess we can throw in the TLB invalidation after setting
> the EPDx bits until we have clarity from Arm. We wouldn't need to broadcast
> it, so it might not be too bad on performance. If it is, I suppose we could
> switch to a reserved VMID?

I'd like to avoid the reserved VMID if at all possible -- we already
have one for the host on nVHE, and I bet your patches are going to
create some interesting havoc^Wchanges in that area, as the host is now
a guest from the mm perspective. It isn't clear either whether a
reserved VMID really solves the problem either, as you could still
end-up with speculative PTWs. Can it be harmful to create conflicting
TLB entries if you never hit them?

But if we bring in TLB invalidation, I wonder whether the problem can
be mitigated solely with just that on the affected CPUs, and what the
impact would be.

/me eyes the D05 running its 32 guests...

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
