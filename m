Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B0564FB0B4
	for <lists+kvmarm@lfdr.de>; Wed, 13 Nov 2019 13:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C8D14B154;
	Wed, 13 Nov 2019 07:44:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 2.056
X-Spam-Level: **
X-Spam-Status: No, score=2.056 required=6.1 tests=[BAYES_00=-1.9,
	BUG6152_INVALID_DATE_TZ_ABSURD=0.766, DNS_FROM_AHBL_RHSBL=2.699,
	INVALID_DATE_TZ_ABSURD=0.491] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y-PPWJK0a9dI; Wed, 13 Nov 2019 07:44:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AFA24B151;
	Wed, 13 Nov 2019 07:44:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DFEE44B14A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 07:44:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vh1o4DNA1qww for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Nov 2019 07:44:29 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CAE344B148
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Nov 2019 07:44:29 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iUs0a-0001J2-0j; Wed, 13 Nov 2019 13:44:28 +0100
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/2] arm64: Combine workarounds for speculative AT
 errata
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Wed, 13 Nov 2019 13:53:48 +0109
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <20191113114118.2427-2-steven.price@arm.com>
References: <20191113114118.2427-1-steven.price@arm.com>
 <20191113114118.2427-2-steven.price@arm.com>
Message-ID: <566ecd45c8bf07b3cb5d75a10c9413a8@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
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

On 2019-11-13 12:50, Steven Price wrote:
> Cortex-A57/A72 have a similar errata to Cortex-A76 regarding 
> speculation
> of the AT instruction. Since the workaround for A57/A72 doesn't 
> require
> VHE, the restriction enforcing VHE for A76 can be removed by 
> combining
> the workaround flag for both errata.

Are we sure that A76 behaves the same as A57/A72 when it comes to not
caching any of the EPD* bits in the TLB? Because the 1319367 workaround
has a lot of the A72 microarch implicit to it, and I'm not sure this
works as is on A76 or A55...

The patch itself looks OK, but I'd like some reassurance about the
above.

          M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
