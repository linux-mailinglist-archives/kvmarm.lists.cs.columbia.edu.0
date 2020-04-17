Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8161ADF92
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 16:13:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ACE704B22B;
	Fri, 17 Apr 2020 10:13:05 -0400 (EDT)
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
	with ESMTP id l6NNg7esCb4F; Fri, 17 Apr 2020 10:13:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E4904B1C8;
	Fri, 17 Apr 2020 10:13:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A7034B13F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 10:13:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zma88l6jnM5f for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 10:13:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 699484B126
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 10:13:02 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 44DE621924;
 Fri, 17 Apr 2020 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587132781;
 bh=M4/a3GTFyTTUc41jLKf6709P1gBUWAv59M/3tMzrIJY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jjwga/bT7nrAeRJDfylQ6XQHolyoY7D4QnGUcLJlx8z7njJ8npLnPmEVh85VR7wiF
 rDZlO0GYC09X5SYUTPz2vhTZVuF8cDGV45tpaa2sAKj7E52X5vUAt1hMR4KJJlz2DY
 tfYQfHBEHmKikt5q5ZV1u8S04KI9oMYPl+Lnto2A=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jPRjn-004CTs-9S; Fri, 17 Apr 2020 15:12:59 +0100
Date: Fri, 17 Apr 2020 15:12:57 +0100
From: Marc Zyngier <maz@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v2 1/4] KVM: arm64: Kill off CONFIG_KVM_ARM_HOST
Message-ID: <20200417151257.6a1e3883@why>
In-Reply-To: <CA+EHjTwsnDR7cp-uM6RWk2QscqAoDe0m=xrgnFuo-W2d-Or57Q@mail.gmail.com>
References: <20200417135801.82871-1-tabba@google.com>
 <20200417135801.82871-2-tabba@google.com>
 <20200417140314.GA53632@C02TD0UTHF1T.local>
 <CA+EHjTwsnDR7cp-uM6RWk2QscqAoDe0m=xrgnFuo-W2d-Or57Q@mail.gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tabba@google.com, mark.rutland@arm.com,
 catalin.marinas@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kvmarm@lists.cs.columbia.edu, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Fri, 17 Apr 2020 15:05:32 +0100
Fuad Tabba <tabba@google.com> wrote:

Hi Fuad,

> Thanks Mark.  I'll will fix this and send out a v3.

Whilst we're on the process chapter:

- Please don't use HTML email (I'm sure gmail has a "plain text only"
  option)
- Avoid top-posting, and instead place your reply after the part you
  are replying to
- Please take your time between versions of the same series. You have
  just sent 3 versions in about 5 hours... ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
