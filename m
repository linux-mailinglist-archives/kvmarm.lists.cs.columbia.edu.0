Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E0A9026806C
	for <lists+kvmarm@lfdr.de>; Sun, 13 Sep 2020 19:05:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21E9F4B370;
	Sun, 13 Sep 2020 13:05:36 -0400 (EDT)
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
	with ESMTP id a-WnLRUPusIl; Sun, 13 Sep 2020 13:05:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9F544B368;
	Sun, 13 Sep 2020 13:05:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 279C04B34C
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Sep 2020 13:05:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJ2JxA5QjHey for <kvmarm@lists.cs.columbia.edu>;
 Sun, 13 Sep 2020 13:05:32 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3C21D4B31A
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Sep 2020 13:05:32 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D9EAD206C3;
 Sun, 13 Sep 2020 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600016731;
 bh=tWUeEoiDLzjse01SftgPJVDp93ipLBBoG2B3S+yl1U8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=2FAaro49hjsaP7m2vX3EgVkgcKTLb9y0uIkvTb+MGolPLpqqKdjx5MLDEZyy42+mm
 CyicsspgrkDkn3drLqyeRVdUWCGILOSri3JgPVIFGHOANLExFjjGdOQRenUAfQxaqk
 a94tgzmpTTX983YcdKia3VvLQElJI9yY+/k3Zj1w=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kHVRQ-00BTQE-TL; Sun, 13 Sep 2020 18:05:29 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] irqchip/gic-v3: Support pseudo-NMIs when
 SCR_EL3.FIQ == 0
Date: Sun, 13 Sep 2020 18:05:15 +0100
Message-Id: <160001658182.6915.9030793517863303185.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912153707.667731-1-alexandru.elisei@arm.com>
References: <20200912153707.667731-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, alexandru.elisei@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
 catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, tglx@linutronix.de, will@kernel.org,
 jason@lakedaemon.net
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

On Sat, 12 Sep 2020 16:37:05 +0100, Alexandru Elisei wrote:
> Trusted Firmware-A's default interrupt routing model is to clear
> SCR_EL3.FIQ, which is the only case that GICv3 doesn't support. This series
> tries to fix that by detecting it at runtime and using a different priority
> value for ICC_PMR_EL1 when masking regular interrupts. As a result, we will
> be able to support pseudo-NMIs on all combinations of GIC security states
> and firmware configurations.
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/2] irqchip/gic-v3: Spell out when pseudo-NMIs are enabled
      commit: 4e594ad1068ea1db359d6161f580f03edecf6cb0
[2/2] irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0
      commit: 336780590990efa69596884114cad3f517b6333b

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
