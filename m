Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4E449A64
	for <lists+kvmarm@lfdr.de>; Mon,  8 Nov 2021 18:05:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B38EB4B0C5;
	Mon,  8 Nov 2021 12:05:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eaYDS5Y0baVH; Mon,  8 Nov 2021 12:05:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 827434B130;
	Mon,  8 Nov 2021 12:05:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AA9D4B0C0
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Nov 2021 12:05:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DnbJInAj-PtT for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Nov 2021 12:05:04 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0C43D4B0BE
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Nov 2021 12:05:04 -0500 (EST)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@misterjones.org>)
 id 1mk84s-004CPi-54; Mon, 08 Nov 2021 17:05:02 +0000
MIME-Version: 1.0
Date: Mon, 08 Nov 2021 17:05:02 +0000
From: Marc Zyngier <maz@misterjones.org>
To: Chenxu Wang <irakatz51@gmail.com>
Subject: Re: How to translate a VA in Guest to PA in Host?
In-Reply-To: <CAFLP=uBWCsV3A_9BnUiyA05_kwg5e8XCSgVOaSX8MZMZjdKCpw@mail.gmail.com>
References: <CAFLP=uBWCsV3A_9BnUiyA05_kwg5e8XCSgVOaSX8MZMZjdKCpw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <9a4ca32ac38e23d8b81205a3df723675@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: irakatz51@gmail.com, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu
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

On 2021-11-08 16:42, Chenxu Wang wrote:
> Hi all,
> I am trying to translate a Virtual Address in Guest OS to the Physical
> Address in Host OS. Currently, I enable the VHE extension, so the Host
> is in EL2. I also enable EL2 Stage-1 translation and EL1 Stage-2
> translation.
> 
> In my experiment, I first get the VA in Guest OS. Then, I generate an
> exception that will be caught by Host KVM, and send the value as a
> parameter to the Host.
> In KVM, I want to use the "AT S12E1R" for this value, but it failed.
> 
> So, does KVM implement some API of it?

No, because KVM really doesn't need this information.

The only thing we care about is the IPA, which is either provided by
the architecture on translation faults, or obtained by AT S1 in other
cases.

Translating the IPA into a PA isn't always possible, since there is
no guarantee that the page is mapped at the time you perform the
translation.

         M.
-- 
Who you jivin' with that Cosmik Debris?
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
