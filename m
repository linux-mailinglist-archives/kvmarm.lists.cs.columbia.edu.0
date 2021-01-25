Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F9302766
	for <lists+kvmarm@lfdr.de>; Mon, 25 Jan 2021 17:03:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 246304B62C;
	Mon, 25 Jan 2021 11:03:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ve5ztbxErPl0; Mon, 25 Jan 2021 11:03:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F0E724B613;
	Mon, 25 Jan 2021 11:03:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC74C4B5D8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 11:03:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DoKQHk1dQwZC for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Jan 2021 11:03:23 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F342A4B5D7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 11:03:22 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D620720848;
 Mon, 25 Jan 2021 16:03:21 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l44Kl-009uNk-Nb; Mon, 25 Jan 2021 16:03:19 +0000
From: Marc Zyngier <maz@kernel.org>
To: Andrew Scull <ascull@google.com>, kvmarm@lists.cs.columbia.edu,
 kernel-team@android.com
Subject: Re: (subset) [PATCH 0/2] __do_hyp_init fix and tweak
Date: Mon, 25 Jan 2021 16:03:08 +0000
Message-Id: <161159056239.2329786.13050882173721885399.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125145415.122439-1-ascull@google.com>
References: <20210125145415.122439-1-ascull@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ascull@google.com, kvmarm@lists.cs.columbia.edu,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

On Mon, 25 Jan 2021 14:54:13 +0000, Andrew Scull wrote:
> These apply on 5.11-rc4. The second is a fix for a clobbered register,
> the first is more cosmetic.
> 
> Thanks, David, for helping with build and boot tests after my logistical
> issues.
> 
> Andrew Scull (2):
>   KVM: arm64: Simplify __kvm_hyp_init HVC detection
>   KVM: arm64: Don't clobber x4 in __do_hyp_init
> 
> [...]

Applied to kvmarm-master/fixes, thanks!

[2/2] KVM: arm64: Don't clobber x4 in __do_hyp_init
      commit: e500b805c39daff2670494fff94909d7e3d094d9

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
