Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E5D112A0388
	for <lists+kvmarm@lfdr.de>; Fri, 30 Oct 2020 11:59:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6713E4B3CB;
	Fri, 30 Oct 2020 06:59:57 -0400 (EDT)
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
	with ESMTP id bdYhuCxysC59; Fri, 30 Oct 2020 06:59:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 380194B3A6;
	Fri, 30 Oct 2020 06:59:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 422434B394
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 06:59:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JigwytWDBwqs for <kvmarm@lists.cs.columbia.edu>;
 Fri, 30 Oct 2020 06:59:54 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4C9944B345
 for <kvmarm@lists.cs.columbia.edu>; Fri, 30 Oct 2020 06:59:54 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BDCB1206E5;
 Fri, 30 Oct 2020 10:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604055592;
 bh=vFZEiRq+VecUTO7gR7w+iRbltgcn6QhEUpa9PM9Lnqg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AagIEkaxQuVS2TTTJQV1psjKPvM2l4eSshChK31N9XQUBSCRa9y++jEBg3ureBnIW
 ObchYQeRUR57y78V8U7cWE1l3BWyvfzeKqQBRVRtw+3qjqDkIZYmwJzOKyDKL6MZwq
 ltLgoRKpXRttsryl9RyLEMuC+5+MFOLUS3LiTeyA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kYS8M-005iuS-HR; Fri, 30 Oct 2020 10:59:50 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 0/3] arm64: kvm: avoid referencing cpu_hwcaps from hyp
Date: Fri, 30 Oct 2020 10:59:44 +0000
Message-Id: <160405552315.3015506.5626903450319191695.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026134931.28246-1-mark.rutland@arm.com>
References: <20201026134931.28246-1-mark.rutland@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org
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

On Mon, 26 Oct 2020 13:49:28 +0000, Mark Rutland wrote:
> In a few places we use cpus_have_const_cap() in hyp code, usually
> because this is hidden within a helper that's also used in regular
> kernel context. As cpus_have_const_cap() generates code to read the
> cpu_hwcaps array before capabilities are finalized, this means we
> generate some potentially-unsound references to regular kernel VAs, but
> this these are redundant as capabilities are finalized before we
> initialize the kvm hyp code.
> 
> [...]

Applied to next, thanks!

[1/3] KVM: arm64: Factor out is_{vhe,nvhe}_hyp_code()
      commit: e9a33caec90e05673e2f7fb7c80f172031964d25
[2/3] arm64: cpufeature: reorder cpus_have_{const, final}_cap()
      commit: dfc4e3f08903ed8fe0b66cc25b64524a82654166
[3/3] arm64: cpufeature: upgrade hyp caps to final
      commit: d86de40decaa14e6613af1b2783bf4d589d0f38b

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
