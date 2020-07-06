Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC3C215588
	for <lists+kvmarm@lfdr.de>; Mon,  6 Jul 2020 12:29:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 944E24B412;
	Mon,  6 Jul 2020 06:29:30 -0400 (EDT)
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
	with ESMTP id ocly7RPn5mJq; Mon,  6 Jul 2020 06:29:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E0594B3FA;
	Mon,  6 Jul 2020 06:29:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A330E4B3E9
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jul 2020 06:29:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p2NtAJHvCh1n for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Jul 2020 06:29:27 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BEFBC4B3BA
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jul 2020 06:29:27 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C1B120739;
 Mon,  6 Jul 2020 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594031366;
 bh=QjkAVlRfpwXmDPK4fuq/Uu1Sy28tsa/hHOkpORwmtQU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wRiVV5kzLw1qBzlkc+IsxIu8tePyHoCz8PLRXnqSGnk5nqtP1Z9sNOU5FP8Q04+pl
 RqJqytBeUYnIFy4LCSFe9nUmonlVj6rXLDNlfVrL7BCPUGbpxhX/+Jo5RLghW+jYLi
 k2mbm2ZGrQcFMDNi9AJy2hUPOpjoxkWJRnjf2Cxs=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jsONI-009QEz-T0; Mon, 06 Jul 2020 11:29:25 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	Andrew Scull <ascull@google.com>
Subject: Re: [PATCH] arm64: kvm: Stop clobbering x0 for HVC_SOFT_RESTART
Date: Mon,  6 Jul 2020 11:29:19 +0100
Message-Id: <159403131778.1613997.10464265237505511017.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706095259.1338221-1-ascull@google.com>
References: <20200706095259.1338221-1-ascull@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, ascull@google.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com
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

On Mon, 6 Jul 2020 10:52:59 +0100, Andrew Scull wrote:
> HVC_SOFT_RESTART is given values for x0-2 that it should installed
> before exiting to the new address so should not set x0 to stub HVC
> success or failure code.

Applied to kvm-arm64/fixes-5.8-3, thanks!

[1/1] KVM: arm64: Stop clobbering x0 for HVC_SOFT_RESTART
      commit: e86a688bce9e2c77087c797504dd3dc97d688a62

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
