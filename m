Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CBB0726806E
	for <lists+kvmarm@lfdr.de>; Sun, 13 Sep 2020 19:05:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 756664B36F;
	Sun, 13 Sep 2020 13:05:37 -0400 (EDT)
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
	with ESMTP id 2rXKr4DvcInC; Sun, 13 Sep 2020 13:05:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F0F54B375;
	Sun, 13 Sep 2020 13:05:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BC6C54B315
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Sep 2020 13:05:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id logLOaDgvrQv for <kvmarm@lists.cs.columbia.edu>;
 Sun, 13 Sep 2020 13:05:32 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CE8C64B331
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Sep 2020 13:05:32 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E6171206C9;
 Sun, 13 Sep 2020 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600016732;
 bh=4mSBB5yuCBsb8DtXJKT9RU48Hmo8YtN6lltG9KNfU8A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FFfLcVBFgUrUWL7xMpiPycH4fqxj2z6l/o1EKkTGKFChr2nvAz9Kcy8L3kPgH0DaS
 GQfH5SexH/ZkGPMPzEYnjI+ZscIYWZgc4dRGrBZNAmrj5PIdfBW8z04ypghazAAL39
 5tFvhBvsU8JEM/aWeTPXgmhG1RJBJJVzr7v8+g2Q=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kHVRS-00BTQE-E2; Sun, 13 Sep 2020 18:05:30 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Thomas Gleixner <tglx@linutronix.de>, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/2] irqchip/ti-sci: Simplify with dev_err_probe()
Date: Sun, 13 Sep 2020 18:05:17 +0100
Message-Id: <160001658182.6915.14152547552697841903.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902174615.24695-1-krzk@kernel.org>
References: <20200902174615.24695-1-krzk@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, alexandru.elisei@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com,
 ssantosh@kernel.org, krzk@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
 t-kristo@ti.com, will@kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, will@kernel.org
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

On Wed, 2 Sep 2020 19:46:14 +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> There is also no need to assign NULL to 'intr->sci' as it is part of
> devm-allocated memory.

Applied to irq/irqchip-next, thanks!

[1/2] irqchip/ti-sci: Simplify with dev_err_probe()
      commit: ea6c25e6057c0b7c18337696be84b8f9751f19ec

Patch #2 didn't make a lot of sense, so not applied.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
