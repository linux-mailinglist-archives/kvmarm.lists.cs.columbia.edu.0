Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A01371E1221
	for <lists+kvmarm@lfdr.de>; Mon, 25 May 2020 17:54:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 362184B255;
	Mon, 25 May 2020 11:54:14 -0400 (EDT)
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
	with ESMTP id Et8gPcyvKCiQ; Mon, 25 May 2020 11:54:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 278184B227;
	Mon, 25 May 2020 11:54:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B73F54B1C4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 May 2020 11:54:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v+7N4NbqEPmj for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 May 2020 11:54:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A02284B1A5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 May 2020 11:54:10 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7DC3D2071A;
 Mon, 25 May 2020 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590422049;
 bh=qZ6RMksGQZiA4eSsGFLy891qBO5fEMuJO5HHUufdMaI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n3r4KWYBi6oAIU+RGGVaMe86PaJQUVLKI44QfZ3TNT9bx99DWjD05enqpnhYLDV6f
 LZpkQXtC/mLDZSsW0RZZbLAI1Gy6TD0I0MswDYWsTIxtnS56SmtCgs7KQppBfm9eZl
 UNAX8mn+akc1yuUCIF8GOP0A35eQvvVA7hIna5ik=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jdFQV-00FCNH-Uy; Mon, 25 May 2020 16:54:08 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH] arm64: kvm: Remove obsolete kvm_virt_to_phys abstraction
Date: Mon, 25 May 2020 16:54:02 +0100
Message-Id: <159042183582.424075.13656992029577510218.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519104036.259917-1-ascull@google.com>
References: <20200519104036.259917-1-ascull@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ascull@google.com, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu
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

On Tue, 19 May 2020 11:40:36 +0100, Andrew Scull wrote:
> This abstraction was introduced to hide the difference between arm and
> arm64 but, with the former no longer supported, this abstraction can be
> removed and the canonical kernel API used directly instead.
> 
> Signed-off-by: Andrew Scull <ascull@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> CC: Marc Zyngier <maz@kernel.org>
> CC: James Morse <james.morse@arm.com>
> CC: Suzuki K Poulose <suzuki.poulose@arm.com>
> Link: https://lore.kernel.org/r/20200519104036.259917-1-ascull@google.com
> 
> [...]

Applied to kvmarm-master/next, thanks!

[1/1] KVM: arm64: Remove obsolete kvm_virt_to_phys abstraction
      commit: 0a78791c0d12fcd5d3f486668defb9ab055e3729 

Note that I rebased it onto next to deal with the path changes.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
