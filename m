Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3C267EE0
	for <lists+kvmarm@lfdr.de>; Sun, 13 Sep 2020 11:08:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 696B34B729;
	Sun, 13 Sep 2020 05:08:50 -0400 (EDT)
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
	with ESMTP id 9qWBFZatYXxa; Sun, 13 Sep 2020 05:08:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3019B4B678;
	Sun, 13 Sep 2020 05:08:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D5A194B59A
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Sep 2020 05:08:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjzpwxdZqT7p for <kvmarm@lists.cs.columbia.edu>;
 Sun, 13 Sep 2020 05:08:48 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EBBBA4B559
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Sep 2020 05:08:47 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9BFA6207BB;
 Sun, 13 Sep 2020 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599988126;
 bh=MRJOeOx2UA9wo/E2Ks+iu5fjJ1am4t2P+rW1mi+Dt04=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EQWcCLhR5F2i/bMKBRc+gCex8KBvwuY857K3mJV/ygSS3aNrbytrZqHec9QHkSp4y
 4JoBmpg2KvOts06itHaukwUZSIhu15Z0DDlFFKZ+/TcyXBc3XITlhMvQkgO9WskvNE
 lnh9VVxNXVCGYxRGLf86PkVM1rdtxnBZq4wQXMzk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kHO04-00BOju-Mz; Sun, 13 Sep 2020 10:08:44 +0100
MIME-Version: 1.0
Date: Sun, 13 Sep 2020 10:08:44 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v2 2/2] irqchip/gic-v3: Support pseudo-NMIs when
 SCR_EL3.FIQ == 0
In-Reply-To: <ca41885f-1d86-be38-1680-6847079efaf2@arm.com>
References: <20200819133630.527243-1-alexandru.elisei@arm.com>
 <20200819133630.527243-3-alexandru.elisei@arm.com>
 <87k0wzkxvz.wl-maz@kernel.org>
 <ca41885f-1d86-be38-1680-6847079efaf2@arm.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <f8b805d29096158f83783e1417776d55@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, jason@lakedaemon.net, catalin.marinas@arm.com,
 tglx@linutronix.de, will@kernel.org, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: jason@lakedaemon.net, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-09-12 14:34, Alexandru Elisei wrote:
> Hi Marc,

[...]

> Have you tested the series using the PMU NMI branch from the cover
> letter? If so, would you mind giving a Tested-by tag for that series 
> [1]?

I haven't had a chance, but that's next on my list once I've gone
through some other bits of review that have been lingering in my
inbox for too long...

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
