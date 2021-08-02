Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB213DDAD4
	for <lists+kvmarm@lfdr.de>; Mon,  2 Aug 2021 16:22:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 010E64A4FC;
	Mon,  2 Aug 2021 10:22:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqiN9cBnZHp8; Mon,  2 Aug 2021 10:22:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F0D2B4A49C;
	Mon,  2 Aug 2021 10:22:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F32E84A1A5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Aug 2021 10:22:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MKKvW7TqRIDz for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Aug 2021 10:22:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0ADC749FA6
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Aug 2021 10:22:13 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0CACF60EC0;
 Mon,  2 Aug 2021 14:22:12 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mAYpW-002Toq-1N; Mon, 02 Aug 2021 15:22:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH] KVM: arm64: fix comment typo
Date: Mon,  2 Aug 2021 15:22:07 +0100
Message-Id: <162791412064.3442307.9131610789137541537.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210728130623.12017-1-wangborong@cdjrlc.com>
References: <20210728130623.12017-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: wangborong@cdjrlc.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, james.morse@arm.com,
 catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org, will@kernel.org,
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

On Wed, 28 Jul 2021 21:06:23 +0800, Jason Wang wrote:
> Remove the repeated word 'the' from two comments.

Applied to next, thanks!

[1/1] KVM: arm64: fix comment typo
      commit: 013cc4c6788f1ce9885d3c0281904f93ee8f2271

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
