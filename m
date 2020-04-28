Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C8CCF1BBF8F
	for <lists+kvmarm@lfdr.de>; Tue, 28 Apr 2020 15:30:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4875E4B2A4;
	Tue, 28 Apr 2020 09:30:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GUnBH9G0yREy; Tue, 28 Apr 2020 09:30:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 332B14B29E;
	Tue, 28 Apr 2020 09:30:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3BB2E4B29A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Apr 2020 09:30:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oL2-5LqqpDx1 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 28 Apr 2020 09:30:35 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4C1554B299
 for <kvmarm@lists.cs.columbia.edu>; Tue, 28 Apr 2020 09:30:35 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A0D0206D6;
 Tue, 28 Apr 2020 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588080634;
 bh=ihXEN7hqofBhf0iwr+Tqvd+2fwwanH58oDMM3dKqwAs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=trxQV4p4nAp+q8mZzG/iTX+2zVMcl3AIIq13xK6bYEMRYrZzl8zuTTEylHuf2pIsg
 usJqZuqqqs1eFekYxCmL2g6dm8zrHunNsn7DGGWC7S10GOmBoinJ71Yy5MFT5UUrPt
 hv19tOGf/1QrDBQwTJkNA3ipzSXR+SdyrUN4Pp+c=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jTQJk-007MyE-7y; Tue, 28 Apr 2020 14:30:32 +0100
MIME-Version: 1.0
Date: Tue, 28 Apr 2020 14:30:31 +0100
From: Marc Zyngier <maz@kernel.org>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: Against removing aarch32 kvm host support
In-Reply-To: <20200428143850.4c8cbd2a@luklap>
References: <20200428143850.4c8cbd2a@luklap>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <916b6072a4a2688745a5e3f75c1c8c01@misterjones.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lukasstraub2@web.de, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, kernel@pyra-handheld.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, kernel@pyra-handheld.com
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

Hi Lukas,

Thanks for your email.

On 2020-04-28 13:38, Lukas Straub wrote:
> Hello Everyone,
> As a preorder of the Pyra handheld, (OMAP5 SoC with 2x cortex-a15 arm 
> cores)
> I'm against removing KVM host support for aarch32. I'm probably going 
> to use
> this device for more than 5 years and thus the latest lts-kernel is no 
> option
> for me.

So let me spell it out. You are against the removal of a feature that 
you don't
use yet, that you may of may not use on a device that doesn't exist yet, 
which
you may or may not still be using by the time 5.4/5.6 aren't supported 
anymore.
You don't seem to have the strongest case, I'm afraid.

But nothing is lost! The code is still in the git tree, ou can always 
revert
the removal patches and revive the port if you are so inclined. It will 
just need
to be stand-alone, and not depend on the arm64 code, which is now 
evolving its own
separate way.

Cheers,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
