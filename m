Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD7142CB5
	for <lists+kvmarm@lfdr.de>; Mon, 20 Jan 2020 15:02:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CF474AF22;
	Mon, 20 Jan 2020 09:02:07 -0500 (EST)
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
	with ESMTP id ELhR8cMW9E9i; Mon, 20 Jan 2020 09:02:07 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC7BE4AEEC;
	Mon, 20 Jan 2020 09:02:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C9B544A542
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Jan 2020 09:02:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cczVJ3+lmJCU for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Jan 2020 09:01:55 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AF9F44A536
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Jan 2020 09:01:55 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B304217F4;
 Mon, 20 Jan 2020 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579528914;
 bh=M1EgUDmDzzmWGPa5hMGBVoa7jQVXqY15uhPl0guxJ08=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hAYExH16KQPRLa1rkib44cavvzzn29LNrV6QuqD04XdwgZAceXqZJKoSkx+NNYe5r
 OBIXlXXAo4PSYa9B6YxTSpH7+PPcA/2YCqp7iBDI/r2qAU0M2oZ+/2DwyA9lOPwxwm
 FmNfsxz1e08kC3YuDl1zz+4IO2nwuxx2kkH18cAM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1itXcm-000HgP-Ra; Mon, 20 Jan 2020 14:01:52 +0000
MIME-Version: 1.0
Date: Mon, 20 Jan 2020 14:01:52 +0000
From: Marc Zyngier <maz@kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH v2] ARM: virt: Relax arch timer version check during early
 boot
In-Reply-To: <1579527498-31081-1-git-send-email-vladimir.murzin@arm.com>
References: <1579527498-31081-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <c573c3f5b86ece28a10c2466e985b256@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: vladimir.murzin@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 2020-01-20 13:38, Vladimir Murzin wrote:
> Updates to the Generic Timer architecture allow ID_PFR1.GenTimer to
> have values other than 0 or 1 while still preserving backward
> compatibility. At the moment, Linux is quite strict in the way it
> handles this field at early boot and will not configure arch timer if
> it doesn't find the value 1.
> 
> Since here use ubfx for arch timer version extraction (hyb-stub build
> with -march=armv7-a, so it is safe)
> 
> To help backports (even though the code was correct at the time of 
> writing)
> Fixes: 8ec58be9f3ff ("ARM: virt: arch_timers: enable access to physical 
> timers")
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Acked-by: Marc Zyngier <maz@kernel.org>

Feel free to put it into Russell's patch system.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
