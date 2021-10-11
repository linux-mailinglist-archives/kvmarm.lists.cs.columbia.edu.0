Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 828BC428985
	for <lists+kvmarm@lfdr.de>; Mon, 11 Oct 2021 11:18:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D066B4B10D;
	Mon, 11 Oct 2021 05:18:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZwwUYqlTFONo; Mon, 11 Oct 2021 05:18:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 021054B0D6;
	Mon, 11 Oct 2021 05:18:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F2A84B0C0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 05:18:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kP9RWMB4vRp0 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 11 Oct 2021 05:18:07 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5A5024B0BF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 05:18:07 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5BAB960EB6;
 Mon, 11 Oct 2021 09:18:06 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mZrRb-00FyGH-Lk; Mon, 11 Oct 2021 10:18:03 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: Allow KVM to be disabled from the command
 line
Date: Mon, 11 Oct 2021 10:18:00 +0100
Message-Id: <163394386541.587062.2414212384225711646.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001170553.3062988-1-maz@kernel.org>
References: <20211001170553.3062988-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, alexandru.elisei@arm.com,
 will@kernel.org, dbrazdil@google.com, suzuki.poulose@arm.com,
 kernel-team@android.com, james.morse@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>
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

On Fri, 1 Oct 2021 18:05:53 +0100, Marc Zyngier wrote:
> Although KVM can be compiled out of the kernel, it cannot be disabled
> at runtime. Allow this possibility by introducing a new mode that
> will prevent KVM from initialising.
> 
> This is useful in the (limited) circumstances where you don't want
> KVM to be available (what is wrong with you?), or when you want
> to install another hypervisor instead (good luck with that).

Applied to next, thanks!

[1/1] KVM: arm64: Allow KVM to be disabled from the command line
      commit: b6a68b97af23cc75781bed38221ce73144ac2e39

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
