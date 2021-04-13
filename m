Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 702B135E0EB
	for <lists+kvmarm@lfdr.de>; Tue, 13 Apr 2021 16:05:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A94B04B9A5;
	Tue, 13 Apr 2021 10:05:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Zb+kEeOO0tQ; Tue, 13 Apr 2021 10:05:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D4F64B779;
	Tue, 13 Apr 2021 10:05:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDED74B58B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Apr 2021 10:05:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YxoTFLHCDgQg for <kvmarm@lists.cs.columbia.edu>;
 Tue, 13 Apr 2021 10:05:48 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C94C94B573
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Apr 2021 10:05:48 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA1C261242;
 Tue, 13 Apr 2021 14:05:47 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lWJfl-007FMf-M4; Tue, 13 Apr 2021 15:05:45 +0100
From: Marc Zyngier <maz@kernel.org>
To: james.morse@arm.com, eric.auger.pro@gmail.com,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 alexandru.elisei@arm.com, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>, suzuki.poulose@arm.com
Subject: Re: [PATCH] KVM: arm/arm64: Fix KVM_VGIC_V3_ADDR_TYPE_REDIST read
Date: Tue, 13 Apr 2021 15:05:41 +0100
Message-Id: <161832273337.3709196.17485368965759835272.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412150034.29185-1-eric.auger@redhat.com>
References: <20210412150034.29185-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: james.morse@arm.com, eric.auger.pro@gmail.com,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 alexandru.elisei@arm.com, kvm@vger.kernel.org, eric.auger@redhat.com,
 suzuki.poulose@arm.com, gshan@redhat.com, drjones@redhat.com
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

On Mon, 12 Apr 2021 17:00:34 +0200, Eric Auger wrote:
> When reading the base address of the a REDIST region
> through KVM_VGIC_V3_ADDR_TYPE_REDIST we expect the
> redistributor region list to be populated with a single
> element.
> 
> However list_first_entry() expects the list to be non empty.
> Instead we should use list_first_entry_or_null which effectively
> returns NULL if the list is empty.

Applied to kvm-arm64/vgic-5.13, thanks!

[1/1] KVM: arm/arm64: Fix KVM_VGIC_V3_ADDR_TYPE_REDIST read
      commit: 94ac0835391efc1a30feda6fc908913ec012951e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
