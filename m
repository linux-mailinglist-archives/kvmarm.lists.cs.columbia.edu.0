Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9C30A32D035
	for <lists+kvmarm@lfdr.de>; Thu,  4 Mar 2021 10:55:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D5E54B5D7;
	Thu,  4 Mar 2021 04:55:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4SIMIkt4O9eK; Thu,  4 Mar 2021 04:55:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BC2E44B5A6;
	Thu,  4 Mar 2021 04:55:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D3584B58F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 04:55:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M42nOqTE5Pwx for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Mar 2021 04:55:37 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4CC224B566
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Mar 2021 04:55:37 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 128D664F20;
 Thu,  4 Mar 2021 09:55:36 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lHkhh-00HE83-Tl; Thu, 04 Mar 2021 09:55:34 +0000
From: Marc Zyngier <maz@kernel.org>
To: Jia He <justin.he@arm.com>,
	kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Date: Thu,  4 Mar 2021 09:55:30 +0000
Message-Id: <161485171220.119036.4621661434944217679.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210303024225.2591-1-justin.he@arm.com>
References: <20210303024225.2591-1-justin.he@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: justin.he@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Wed, 3 Mar 2021 10:42:25 +0800, Jia He wrote:
> If the start addr is not aligned with the granule size of that level.
> loop step size should be adjusted to boundary instead of simple
> kvm_granual_size(level) increment. Otherwise, some mmu entries might miss
> the chance to be walked through.
> E.g. Assume the unmap range [data->addr, data->end] is
> [0xff00ab2000,0xff00cb2000] in level 2 walking and NOT block mapping.
> And the 1st part of that pmd entry is [0xff00ab2000,0xff00c00000]. The
> pmd value is 0x83fbd2c1002 (not valid entry). In this case, data->addr
> should be adjusted to 0xff00c00000 instead of 0xff00cb2000.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: Fix unaligned addr case in mmu walking
      commit: e85583b3f1fe62c9b371a3100c1c91af94005ca9

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
