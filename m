Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC33392A2
	for <lists+kvmarm@lfdr.de>; Fri, 12 Mar 2021 17:04:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 81BA04B4E2;
	Fri, 12 Mar 2021 11:04:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zJZF7dOyK6ro; Fri, 12 Mar 2021 11:04:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 719474B4D9;
	Fri, 12 Mar 2021 11:04:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C9FD4B41D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 11:04:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id duUo9AE-jwkx for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Mar 2021 11:04:22 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 45DB24B351
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 11:04:22 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 339AC64FFE;
 Fri, 12 Mar 2021 16:04:21 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lKkGx-001GFM-15; Fri, 12 Mar 2021 16:04:19 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 0/2] KVM: arm64: Assorted IPA size fixes
Date: Fri, 12 Mar 2021 16:04:12 +0000
Message-Id: <161556504005.3921077.277089202831479241.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311100016.3830038-1-maz@kernel.org>
References: <20210311100016.3830038-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, maz@kernel.org, drjones@redhat.com,
 suzuki.poulose@arm.com, james.morse@arm.com, will@kernel.org,
 eric.auger@redhat.com, julien.thierry.kdev@gmail.com, kernel-team@android.com,
 alexandru.elisei@arm.com
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

On Thu, 11 Mar 2021 10:00:14 +0000, Marc Zyngier wrote:
> This is a rework of an initial patch posted a couple of days back[1]
> 
> While working on enabling KVM on "reduced IPA size" systems, I realise
> we have a couple of issues, some of while do impact userspace.
> 
> The first issue is that we accept the creation of a "default IPA size"
> VM (40 bits) even when the HW doesn't support it. Not good.
> 
> [...]

Applied to fixes, thanks!

[1/2] KVM: arm64: Reject VM creation when the default IPA size is unsupported
      commit: 7d717558dd5ef10d28866750d5c24ff892ea3778
[2/2] KVM: arm64: Fix exclusive limit for IPA size
      commit: 262b003d059c6671601a19057e9fe1a5e7f23722

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
