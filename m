Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A280B2466AA
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 14:52:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 383724C0F4;
	Mon, 17 Aug 2020 08:52:17 -0400 (EDT)
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
	with ESMTP id GFHvl-2i74F6; Mon, 17 Aug 2020 08:52:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 198054C0BE;
	Mon, 17 Aug 2020 08:52:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C2ADC4C08A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 08:52:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8e9usw250M5Z for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 08:52:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DB6B54C088
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 08:52:13 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA53020789;
 Mon, 17 Aug 2020 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597668732;
 bh=LCkDhp0yrQ1H4GBGLsPDHG1MxDxVdl9KXyWjwLTvWPI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pUHLfV+s8fddXGPPQLHHqlb1z8AbfUZG7NYwsP6qnq5K2IVfcprGJsRrncpdFA9ra
 0yWmrmbHicohobmmQJY+O/OkOVFL+9FwbcCNn8IymvQarItwreniFbq0rqYpjzwCEx
 WpS6O+f+OLhmp7XvP9Rx93u16E0rFw/5ea5eTJsA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k7ecV-003ZH0-B9; Mon, 17 Aug 2020 13:52:11 +0100
MIME-Version: 1.0
Date: Mon, 17 Aug 2020 13:52:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH 1/2] clocksource: arm_arch_timer: Simplify and fix count
 reader code logic
In-Reply-To: <20200817122415.6568-2-zhukeqian1@huawei.com>
References: <20200817122415.6568-1-zhukeqian1@huawei.com>
 <20200817122415.6568-2-zhukeqian1@huawei.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <267c5f9151c39fd2dcd0ce0b09d96545@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhukeqian1@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, steven.price@arm.com, drjones@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
 suzuki.poulose@arm.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On 2020-08-17 13:24, Keqian Zhu wrote:
> In commit 0ea415390cd3 (clocksource/arm_arch_timer: Use 
> arch_timer_read_counter
> to access stable counters), we separate stable and normal count reader. 
> Actually
> the stable reader can correctly lead us to normal reader if we has no
> workaround.

Resulting in an unnecessary overhead on non-broken systems that can run
without CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND. Not happening.

> Besides, in erratum_set_next_event_tval_generic(), we use normal 
> reader, it is
> obviously wrong, so just revert this commit to solve this problem by 
> the way.

If you want to fix something, post a patch that does exactly that.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
