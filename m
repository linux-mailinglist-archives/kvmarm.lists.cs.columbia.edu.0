Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 664F23F2800
	for <lists+kvmarm@lfdr.de>; Fri, 20 Aug 2021 09:58:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EDB1F4B0CA;
	Fri, 20 Aug 2021 03:58:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fP1SX4EV5kl5; Fri, 20 Aug 2021 03:58:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 18E7D4B116;
	Fri, 20 Aug 2021 03:58:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B5F64B0DD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Aug 2021 03:58:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hxaE2CVg9fdh for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Aug 2021 03:58:29 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 57E7A4B0B9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Aug 2021 03:58:29 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F80861042;
 Fri, 20 Aug 2021 07:58:27 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mGzQ1-0068ip-K3; Fri, 20 Aug 2021 08:58:25 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] KVM: arm64: vgic: Resample HW pending state on
 deactivation
Date: Fri, 20 Aug 2021 08:58:22 +0100
Message-Id: <162944629227.1671663.6947098620852443792.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819180305.1670525-1-maz@kernel.org>
References: <20210819180305.1670525-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, maz@kernel.org, james.morse@arm.com,
 andre.przywara@arm.com, kernel-team@android.com, suzuki.poulose@arm.com,
 rananta@google.com, ricarkol@google.com, eric.auger@redhat.com,
 stable@vger.kernel.org, alexandru.elisei@arm.com, oupton@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Andre Przywara <andre.przywara@arm.com>, stable@vger.kernel.org,
 Raghavendra Rao Ananta <rananta@google.com>, kernel-team@android.com
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

On Thu, 19 Aug 2021 19:03:05 +0100, Marc Zyngier wrote:
> When a mapped level interrupt (a timer, for example) is deactivated
> by the guest, the corresponding host interrupt is equally deactivated.
> However, the fate of the pending state still needs to be dealt
> with in SW.
> 
> This is specially true when the interrupt was in the active+pending
> state in the virtual distributor at the point where the guest
> was entered. On exit, the pending state is potentially stale
> (the guest may have put the interrupt in a non-pending state).
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: vgic: Resample HW pending state on deactivation
      commit: 3134cc8beb69d0db9de651081707c4651c011621

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
