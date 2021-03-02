Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB132A9EA
	for <lists+kvmarm@lfdr.de>; Tue,  2 Mar 2021 19:57:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF14C4B45C;
	Tue,  2 Mar 2021 13:57:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JURiSrBSh7G0; Tue,  2 Mar 2021 13:57:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 982894B6DA;
	Tue,  2 Mar 2021 13:57:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 18F9D4B2A1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Mar 2021 13:57:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R2pe4Xra7Xg6 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Mar 2021 13:57:27 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7DEEE4B29C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Mar 2021 13:57:27 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6221664F14;
 Tue,  2 Mar 2021 18:57:25 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lHACu-00GmGh-RB; Tue, 02 Mar 2021 18:57:20 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	Andrew Scull <ascull@google.com>
Subject: Re: [PATCH] KVM: arm64: Fix nVHE hyp panic host context restore
Date: Tue,  2 Mar 2021 18:57:09 +0000
Message-Id: <161471117620.3770794.15315149295499752217.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219122406.1337626-1-ascull@google.com>
References: <20210219122406.1337626-1-ascull@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, ascull@google.com,
 kernel-team@android.com, will@kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: will@kernel.org, kernel-team@android.com, catalin.marinas@arm.com
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

On Fri, 19 Feb 2021 12:24:06 +0000, Andrew Scull wrote:
> When panicking from the nVHE hyp and restoring the host context, x29 is
> expected to hold a pointer to the host context. This wasn't being done
> so fix it to make sure there's a valid pointer the host context being
> used.
> 
> Rather than passing a boolean indicating whether or not the host context
> should be restored, instead pass the pointer to the host context. NULL
> is passed to indicate that no context should be restored.

Applied to kvmarm-master/fixes, thanks!

[1/1] KVM: arm64: Fix nVHE hyp panic host context restore
      commit: ff9b922a28554de61b9dc36578db77d6720c652a

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
