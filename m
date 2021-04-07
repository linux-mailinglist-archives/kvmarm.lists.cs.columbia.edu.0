Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F145B35713D
	for <lists+kvmarm@lfdr.de>; Wed,  7 Apr 2021 17:58:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 804E04B923;
	Wed,  7 Apr 2021 11:58:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MY7Z09Zii4NM; Wed,  7 Apr 2021 11:58:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 763F24B8F2;
	Wed,  7 Apr 2021 11:58:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BE3D4B8DE
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 11:58:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l-k6iYxMB8Z2 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Apr 2021 11:58:56 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 876E04B703
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 11:58:56 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B179861154;
 Wed,  7 Apr 2021 15:58:53 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lUAZv-0066z6-PJ; Wed, 07 Apr 2021 16:58:51 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v3 0/2] KVM: arm64: Debug fixes
Date: Wed,  7 Apr 2021 16:58:48 +0100
Message-Id: <161781112106.1984801.2208066478824922199.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407144857.199746-1-alexandru.elisei@arm.com>
References: <20210407144857.199746-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

On Wed, 7 Apr 2021 15:48:55 +0100, Alexandru Elisei wrote:
> v2 can be found at [1]. Patch #1 in this series is new.
> 
> Tested on an odroid-c4 with VHE. vcpu->arch.mdcr_el2 is calculated to be
> 0x84e66. Without this patch, reading MDCR_EL2 after the first vcpu_load() in
> kvm_arch_vcpu_ioctl_run() returns 0, subsequent reads return 0xe66
> (FEAT_TFF and FEAT_SPE are not implemented by the PE). With this patch, all
> reads, including the first time the VCPU is run, return 0xe66.
> 
> [...]

Applied to kvm-arm64/debug-5.13, thanks!

[1/2] Documentation: KVM: Document KVM_GUESTDBG_USE_HW control flag for arm64
      commit: feb5dc3de03711d846f0b729cb12fc05cbe49ccb
[2/2] KVM: arm64: Initialize VCPU mdcr_el2 before loading it
      commit: 263d6287da1433aba11c5b4046388f2cdf49675c

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
