Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA027016D
	for <lists+kvmarm@lfdr.de>; Fri, 18 Sep 2020 17:57:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC7004B1E2;
	Fri, 18 Sep 2020 11:57:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hoz6hRVMFavS; Fri, 18 Sep 2020 11:57:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A70B44B1E3;
	Fri, 18 Sep 2020 11:57:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 569764B1D5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 11:57:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id entRGbI5wjXn for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Sep 2020 11:57:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7D2044B171
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 11:57:10 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6693123787;
 Fri, 18 Sep 2020 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600444629;
 bh=DhlXyASs6tErZwDG78yyYVmrjjDhpnw8zxD9PJOu5R0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=tQpBV9VMST9gIKEC7O4A7N9EOJPgLcVt/MWMzheSGMWyd20GeLmN06cgW2Xgjmk3x
 ZoCqR5pjZOcjNHBINAjxYOzhM92nGEbP+dk8f/a8s7s4qqwl4aphDgm+Houifb0IVD
 YzG8Q8swo1Hpj+4tBsgeI+POKmxnme2YJqphqGiE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kJIl1-00D3F2-BM; Fri, 18 Sep 2020 16:57:07 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
 Alexandru Elisei <alexandru.elisei@arm.com>, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] KVM: arm64: Do not flush memslot if FWB is supported
Date: Fri, 18 Sep 2020 16:56:57 +0100
Message-Id: <160044458393.1301915.12410405712694055057.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915170442.131635-1-alexandru.elisei@arm.com>
References: <20200915170442.131635-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu
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

On Tue, 15 Sep 2020 18:04:42 +0100, Alexandru Elisei wrote:
> As a result of a KVM_SET_USER_MEMORY_REGION ioctl, KVM flushes the
> dcache for the memslot being changed to ensure a consistent view of memory
> between the host and the guest: the host runs with caches enabled, and
> it is possible for the data written by the hypervisor to still be in the
> caches, but the guest is running with stage 1 disabled, meaning data
> accesses are to Device-nGnRnE memory, bypassing the caches entirely.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Do not flush memslot if FWB is supported
      commit: ada329e6b5b406f33fae665e62caff7814409906

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
