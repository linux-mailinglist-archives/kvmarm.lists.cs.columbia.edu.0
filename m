Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC2610C4A
	for <lists+kvmarm@lfdr.de>; Fri, 28 Oct 2022 10:35:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D3F6410F3;
	Fri, 28 Oct 2022 04:35:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xAU-v92KXvfL; Fri, 28 Oct 2022 04:35:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF75E40FAC;
	Fri, 28 Oct 2022 04:35:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AB94A40D0B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Oct 2022 04:35:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vc8DGM4FyEkL for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Oct 2022 04:35:11 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 931B540D02
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Oct 2022 04:35:11 -0400 (EDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1666946110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yf+n15Bb2ai4QCnL88CYPPcwLq0iceY6iN9pF2k3P5Q=;
 b=j4kJJ3RLELiXfnfiOSev4HcPjbiLyo2ZYe9906cwpPEHi5GeHTEmxSnwfS96sVLJ7mjH1M
 UaQJZZS5mhInspdE4rPozTxnSUFZd4Se2DfO9BGIgRVW1UWkzvnbbQtjWa4twTwUAeFDEN
 JGF0EqGst0zc7IPKVcnxshyf3KI15Bo=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH 0/2] KVM: arm64: pKVM memory transitions cleanup
Date: Fri, 28 Oct 2022 08:34:46 +0000
Message-Id: <20221028083448.1998389-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

In order to help resolve my own bikeshedding on the outstanding pKVM
patches [1], small deck of patches to polish up the existing memory
transitions. Mainly:

 - Rejig the layout of pkvm_mem_transition
 - Stop using out pointers to get at the 'completer' addr
 - Use better-fitting terminology (source/target) to describe the
   addresses involved in a memory transition

Applies to 6.1-rc2. Politely compile tested, and that's just about it.

Oliver Upton (2):
  KVM: arm64: Clean out the odd handling of completer_addr
  KVM: arm64: Redefine pKVM memory transitions in terms of source/target

 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 124 +++++++++++---------------
 1 file changed, 52 insertions(+), 72 deletions(-)


base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
-- 
2.38.1.273.g43a17bfeac-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
