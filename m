Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09129161501
	for <lists+kvmarm@lfdr.de>; Mon, 17 Feb 2020 15:48:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 914014AF56;
	Mon, 17 Feb 2020 09:48:10 -0500 (EST)
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
	with ESMTP id 40D66HQNt0nN; Mon, 17 Feb 2020 09:48:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51D584AF52;
	Mon, 17 Feb 2020 09:48:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F4224AF33
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Feb 2020 09:48:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYX9hZQX0AbS for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Feb 2020 09:48:07 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2B4B24AF18
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Feb 2020 09:48:07 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0455520718;
 Mon, 17 Feb 2020 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581950886;
 bh=4RDGiKasjOOwAHqmFqM8yA6PTsGQyqGLDKJWJTZ7JPQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=djxRcUTVTHoQofx5RN5pFPWhHWdIEatYnYEtbshekzpKobmeBO8TTMGDDYk40B76u
 DidyHgN4w0Es721nAk2OZ3BrCsXTuLBAN2j0Nb7UebY+NZOfi+gHTyuZwPaqK1jSod
 aB0L11833MLQPBanSO0r+yzSh/Dq9QWYDID5WBOY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j3hgq-005wdT-7m; Mon, 17 Feb 2020 14:48:04 +0000
MIME-Version: 1.0
Date: Mon, 17 Feb 2020 14:48:04 +0000
From: Marc Zyngier <maz@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] arm64: add finalized cap helper
In-Reply-To: <20200210122708.38826-1-mark.rutland@arm.com>
References: <20200210122708.38826-1-mark.rutland@arm.com>
Message-ID: <58fa19a5899eb3295783afa7baf15c4e@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On 2020-02-10 12:27, Mark Rutland wrote:
> Across arm64 we use cpus_have_const_cap() to check for a capability
> without a runtime check. Prior to capabilities being finalized
> cpus_have_const_cap() falls back to a runtime check of the cpu_hwcaps
> array. In some cases we know that code is never invoked prior to the
> capabilities being finalized, and the fallback code is redundant (and
> unsound if ever executed in hyp context).
> 
> So that we can avoid the redundant code and detect when the caps are
> unexpectedly checked too early, this series adds a new
> cpus_have_final_cap() helper, and migrates the KVM hyp code over to it.
> 
> I'm hoping to use this as part of the entry.S -> entry-common.c
> conversion, and there are other places in arm64 that could potentially
> use this today.
> 
> Thanks,
> Mark.
> 
> Mark Rutland (2):
>   arm64: cpufeature: add cpus_have_final_cap()
>   arm64: kvm: hyp: use cpus_have_final_cap()
> 
>  arch/arm64/include/asm/cpufeature.h | 47 
> +++++++++++++++++++++++++++++++++----
>  arch/arm64/kvm/hyp/switch.c         | 14 +++++------
>  arch/arm64/kvm/hyp/sysreg-sr.c      |  8 +++----
>  arch/arm64/kvm/hyp/tlb.c            |  8 +++----
>  4 files changed, 57 insertions(+), 20 deletions(-)

Seems like a valuable optimization. For the series:

Reviewed-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
