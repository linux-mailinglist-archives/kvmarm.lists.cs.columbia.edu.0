Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA919B42B
	for <lists+kvmarm@lfdr.de>; Wed,  1 Apr 2020 18:58:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA2C24B0FA;
	Wed,  1 Apr 2020 12:58:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PAha4OjvsaP5; Wed,  1 Apr 2020 12:58:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A2D7B4B0F7;
	Wed,  1 Apr 2020 12:58:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C432B4A4A4
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 12:58:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pIUyH4-QHT-1 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Apr 2020 12:58:31 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DD94D4B0BA
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Apr 2020 12:58:31 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ADA822063A;
 Wed,  1 Apr 2020 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585760310;
 bh=CBZKD+m/KX3im6HA1XqrNu2FJtS3v/4jycpmEZoi/q4=;
 h=From:To:Cc:Subject:Date:From;
 b=j1gug4YUthSAfCSHVZmmWwy70QFl6X5tQUOrJ5xDx3OPiLRJpn6FOp3RTBHtjjKwZ
 YQNyuXzfKl14Oq3ixq8UltLEJVl0TulMcTzLckPULcjx3SpoaQySvVZtUrzN+s4Xlb
 G7oTZPpkbKeLfB0hIzIqMNzT4uOhrY7Yn9u5ln6k=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jJghA-00Haev-ND; Wed, 01 Apr 2020 17:58:28 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 0/2] KVM: arm64: PSCI fixes
Date: Wed,  1 Apr 2020 17:58:14 +0100
Message-Id: <20200401165816.530281-1-maz@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, Christoffer.Dall@arm.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
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

Christoffer recently pointed out that we don't narrow the arguments to
SMC32 PSCI functions called by a 64bit guest. This could result in a
guest failing to boot its secondary CPUs if it had junk in the upper
32bits. Yes, this is silly, but the guest is allowed to do that. Duh.

Whist I was looking at this, it became apparent that we allow a 32bit
guest to call 64bit functions, which the spec explicitly forbids. Oh
well, another patch.

This has been lightly tested, but I feel that we could do with a new
set of PSCI corner cases in KVM-unit-tests (hint, nudge... ;-).

Marc Zyngier (2):
  KVM: arm64: PSCI: Narrow input registers when using 32bit functions
  KVM: arm64: PSCI: Forbid 64bit functions for 32bit guests

 virt/kvm/arm/psci.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

-- 
2.25.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
