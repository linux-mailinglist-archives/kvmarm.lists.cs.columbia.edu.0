Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAAB203A0E
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jun 2020 16:54:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F23E94B0A1;
	Mon, 22 Jun 2020 10:54:13 -0400 (EDT)
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
	with ESMTP id yPBVU6ilTXxF; Mon, 22 Jun 2020 10:54:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D01064B0D7;
	Mon, 22 Jun 2020 10:54:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D6E674B0D3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 10:54:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dMV6pE+UNXG2 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jun 2020 10:54:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 342554B0A1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 10:54:10 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1EAF620732;
 Mon, 22 Jun 2020 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592837649;
 bh=d7yrkd1l4pDQLKm748DDiOt2bf46nUlovQ4x1Cc7gso=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tznd45BS7gFH5cXKSR163W6SqjPpvehoV7R5CB6Vnp7IeEefLBtqOOAkIc2oepcAK
 vTalDYvAflhCk65EwFW/k8w5A7dfWx+Yw3VrFXnbB9gzYa9CoT6QK5ErkS+ovsmxS9
 ztmFy3n5uvIbk2WKDZXdB+VEzJ507cxBtYfjPCdg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jnNpn-005MHc-92; Mon, 22 Jun 2020 15:54:07 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>,
	kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] KVM: arm64: pvtime: Ensure task delay accounting is
 enabled
Date: Mon, 22 Jun 2020 15:54:01 +0100
Message-Id: <159283763459.289666.11358331218092222141.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622142710.18677-1-drjones@redhat.com>
References: <20200622142710.18677-1-drjones@redhat.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: drjones@redhat.com, kvmarm@lists.cs.columbia.edu,
 steven.price@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: steven.price@arm.com
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

On Mon, 22 Jun 2020 16:27:10 +0200, Andrew Jones wrote:
> Ensure we're actually accounting run_delay before we claim that we'll
> expose it to the guest. If we're not, then we just pretend like steal
> time isn't supported in order to avoid any confusion.

Applied to next, thanks!

[1/1] KVM: arm64: pvtime: Ensure task delay accounting is enabled
      commit: a25e91028ac2f544e0140aff2c9360a0e995dd86

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
