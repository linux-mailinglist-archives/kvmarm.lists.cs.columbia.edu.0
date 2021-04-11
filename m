Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD535B279
	for <lists+kvmarm@lfdr.de>; Sun, 11 Apr 2021 10:47:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0EEC14B8E3;
	Sun, 11 Apr 2021 04:47:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENeYcqs8Uu78; Sun, 11 Apr 2021 04:47:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE2DA4B68C;
	Sun, 11 Apr 2021 04:47:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8FAD4B672
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Apr 2021 04:47:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SlqoUictKIhz for <kvmarm@lists.cs.columbia.edu>;
 Sun, 11 Apr 2021 04:47:25 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C60204B657
 for <kvmarm@lists.cs.columbia.edu>; Sun, 11 Apr 2021 04:47:25 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DDC0960C41;
 Sun, 11 Apr 2021 08:47:23 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lVVkX-006nXC-Mi; Sun, 11 Apr 2021 09:47:21 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] KVM: arm64: Hide SPE from guests
Date: Sun, 11 Apr 2021 09:47:15 +0100
Message-Id: <161813082031.3091906.14413697257092481825.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409152154.198566-1-alexandru.elisei@arm.com>
References: <20210409152154.198566-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, 9 Apr 2021 16:21:52 +0100, Alexandru Elisei wrote:
> This was part of the KVM SPE series that I posted some time ago [1]. The
> series didn't get too much attention, so I've decided to send this
> fix/cleanup/improvement separately, to make it easier to review.
> 
> I've split the original patch into two because it makes more sense to me
> this way, but I'm not opposed to squashing the series back into a single
> patch if that is preferred.
> 
> [...]

Applied to kvm-arm64/debug-5.13, thanks!

[1/2] KVM: arm64: Don't print warning when trapping SPE registers
      commit: 13611bc80d3da162aaf32b01ceffc804e027d406
[2/2] KVM: arm64: Don't advertise FEAT_SPE to guests
      commit: 96f4f6809beec1bb2338e1aeac408e6a733f8135

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
