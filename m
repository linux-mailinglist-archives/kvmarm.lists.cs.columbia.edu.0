Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFF153E1B5
	for <lists+kvmarm@lfdr.de>; Mon,  6 Jun 2022 10:42:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 97A374B272;
	Mon,  6 Jun 2022 04:42:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2AwnPS+2RDrF; Mon,  6 Jun 2022 04:42:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9692E4B11A;
	Mon,  6 Jun 2022 04:41:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 78E3E4B1E7
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jun 2022 04:41:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZvXmmv+XZkm1 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Jun 2022 04:41:57 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6585E4B103
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jun 2022 04:41:57 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 46A676125B;
 Mon,  6 Jun 2022 08:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BBEC341C0;
 Mon,  6 Jun 2022 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654504915;
 bh=WEpdSScadxR+JARqfRrZFpuBLMA2IajY1B95jy1+CZg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=McpTIIYILr+cbsE4dNsA4Ol5HKdNcBTyDd5+BP+sQCCu/NevG0uISr/Ayfq5kZFFJ
 /96/R6tQBIdRGTpwDnjw2e4BKDJ2ztjiaKwwnqmye6w/munE6DP45M4uK3Y5czkoNu
 sRT8eTDygoKyy2DEKigpGyIWyvMzSiy+hS0oWzNuYGhexvnl2uOQOsNXj9XurAgYR7
 ai68WctF7E8uPessLAk415g5Jwm6rTabnVoLqgApn8BJ9ckyzCw0uFPeqUbLgVB7zP
 qjvrrCF1vmmNXSLNIZG8xYCI+umhmvUujfEab1UuVwGLvjk5zlYerwhi1qX3GKFnPM
 x0a4xv+gg7qNg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1ny8J6-00Fpzn-MT; Mon, 06 Jun 2022 09:41:52 +0100
Date: Mon, 06 Jun 2022 09:41:52 +0100
Message-ID: <874k0y5gkv.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/18] KVM: arm64: Move FP state ownership from flag to a
 tristate
In-Reply-To: <YpnQ43WaGH96MxyY@sirena.org.uk>
References: <20220528113829.1043361-1-maz@kernel.org>
 <20220528113829.1043361-5-maz@kernel.org>
 <YpnQ43WaGH96MxyY@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, oupton@google.com,
 will@kernel.org, tabba@google.com, qperret@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
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

On Fri, 03 Jun 2022 10:14:11 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> On Sat, May 28, 2022 at 12:38:14PM +0100, Marc Zyngier wrote:
> 
> > As it turns out, this isn't really a good match for flags, and
> > we'd be better off if this was a simpler tristate, each state
> > having a name that actually reflect the state:
> > 
> > - FP_STATE_CLEAN
> > - FP_STATE_HOST_DIRTY
> > - FP_STATE_GUEST_DIRTY
> 
> I had to think a bit more than I liked about the _DIRTY in the
> names of the host and guest flags, but that's really just
> bikeshedding and not a meaningful issue.

Another option was:

- FP_STATE_FREE
- FP_STATE_HOST_OWNED
- FP_STATE_GUEST_OWNED

I don't mind wither way.

> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
