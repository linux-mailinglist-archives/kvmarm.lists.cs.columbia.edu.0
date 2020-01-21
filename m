Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 28B49143CEF
	for <lists+kvmarm@lfdr.de>; Tue, 21 Jan 2020 13:34:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B298C4AFEB;
	Tue, 21 Jan 2020 07:34:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level: 
X-Spam-Status: No, score=0.099 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fB2lWZNBctBn; Tue, 21 Jan 2020 07:34:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CFA944AFFC;
	Tue, 21 Jan 2020 07:34:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EBBB34AF6A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 07:34:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1nUbG2RuBaXT for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Jan 2020 07:34:04 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BEB944AF65
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 07:34:04 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D69B30E;
 Tue, 21 Jan 2020 04:34:04 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E8923F6C4;
 Tue, 21 Jan 2020 04:34:03 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/2] KVM: arm: fix KVM_CAP_ARM_INJECT_EXT_DABT for aarch32
 guests
Date: Tue, 21 Jan 2020 12:33:54 +0000
Message-Id: <20200121123356.203000-1-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>
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

Beata reports that KVM_CAP_ARM_INJECT_EXT_DABT doesn't do the expected
thing for aarch32 guests. We get the wrong register layout, and weren't
even trying to set a 'external abort' in the first place!

Both patches are intended as fixes, but patch 2 is somewhat in the eye
of the beholder. I don't know why an imp-def exception was picked...

Thanks,

James Morse (2):
  KVM: arm: fix DFSR setting for non-LPAE aarch32 guests
  KVM: arm: Make inject_abt32() inject an external abort instead

 virt/kvm/arm/aarch32.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
