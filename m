Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE610CC9E
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 17:17:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DB214AE9E;
	Thu, 28 Nov 2019 11:17:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ShEiavMSwK1Q; Thu, 28 Nov 2019 11:17:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 45B714A7FE;
	Thu, 28 Nov 2019 11:17:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 50B474ACC9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 11:17:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OC23RMTont9W for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Nov 2019 11:17:36 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 422C64A500
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 11:17:36 -0500 (EST)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iaMU2-0002vd-GD; Thu, 28 Nov 2019 17:17:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: More HCR_EL2.TIDx fixes
Date: Thu, 28 Nov 2019 16:17:15 +0000
Message-Id: <20191128161718.24361-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu,
 peter.maydell@linaro.org, richard.henderson@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: richard.henderson@linaro.org, kvmarm@lists.cs.columbia.edu
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

I started looking the rest of the missing TIDx handling,
and this resulted in the following patches.

There is still one thing I'm a bit puzzled by though:

HCR_EL2.TID0 mandates trapping of the AArch32 JIDR
register, but I couldn't find a trace of it in the QEMU
code, and trying to read it seems to generate an exception.

It isn't like anyone is going to miss it, but I wonder if
it should be implemented... It could also be that I'm missing
the obvious and that my testing is broken! ;-)

Marc Zyngier (3):
  target/arm: Honor HCR_EL2.TID2 trapping requirements
  target/arm: Honor HCR_EL2.TID1 trapping requirements
  target/arm: Handle trapping to EL2 of AArch32 VMRS instructions

 target/arm/helper-a64.h        |  2 ++
 target/arm/helper.c            | 64 ++++++++++++++++++++++++++++++----
 target/arm/internals.h         |  8 +++++
 target/arm/translate-vfp.inc.c | 12 +++++--
 target/arm/vfp_helper.c        | 27 ++++++++++++++
 5 files changed, 103 insertions(+), 10 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
