Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0A5828A5
	for <lists+kvmarm@lfdr.de>; Wed, 27 Jul 2022 16:29:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 919AC4C7B8;
	Wed, 27 Jul 2022 10:29:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7vd6uvBn1kf; Wed, 27 Jul 2022 10:29:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A6EF4C7D9;
	Wed, 27 Jul 2022 10:29:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CE494C792
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jul 2022 10:29:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TM-pPzCDsUpB for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Jul 2022 10:29:28 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1B6364C795
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jul 2022 10:29:28 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4391DB82186;
 Wed, 27 Jul 2022 14:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C78C433D6;
 Wed, 27 Jul 2022 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658932164;
 bh=C0fFCqtOLRJbXlVkkLns9Pw1a9RaVmm9QzhFCj+FTOI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CjMTVfWWDiKQSqProKDRbhzNZSm6LlsyYqv7ARDwKr7/LZbDIMooFLHPyv1ZA7k3r
 s4M1h1mfVni0CwP+xhynwSA/e7dy6UNrWhnuAKdK5x7/OPudgDv4AZL5yIeQewF+C1
 F3JD5clTB5DWvWtcv2WxVJfRHr2YSUxAGunY7amprAgOw24RLK+N15GkvQ7SRajs2e
 /wIfUX53jEH70kFecHUEdOQXiEQyBTOz+gJmrl99yAcQFBG5Jn4CMphfQdbBnvUybv
 p2s3T0P4ENfUkAi16ztbu9C5WVbfWXdO/ZW7B9aKATrpwYf9JM5GxQbIgr7y6YOS2W
 Z45HYSIJ+DGdg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oGi2L-00APjL-TD;
 Wed, 27 Jul 2022 15:29:22 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH 0/6] KVM: arm64: nVHE stack unwinder rework
Date: Wed, 27 Jul 2022 15:29:00 +0100
Message-Id: <20220727142906.1856759-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726073750.3219117-18-kaleshsingh@google.com>
References: <20220726073750.3219117-18-kaleshsingh@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, mark.rutland@arm.com,
 broonie@kernel.org, madvenka@linux.microsoft.com, tabba@google.com,
 oliver.upton@linux.dev, qperret@google.com, kaleshsingh@google.com,
 james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 catalin.marinas@arm.com, andreyknvl@gmail.com, vincenzo.frascino@arm.com,
 mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
 elver@google.com, keirf@google.com, yuzenghui@huawei.com, ardb@kernel.org,
 oupton@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: wangkefeng.wang@huawei.com, catalin.marinas@arm.com, ast@kernel.org,
 vincenzo.frascino@arm.com, madvenka@linux.microsoft.com,
 kernel-team@android.com, elver@google.com, broonie@kernel.org,
 andreyknvl@gmail.com, mhiramat@kernel.org
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

Hi all,

As Kalesh's series[1] already went through quite a few rounds and that
it has proved to be an extremely useful debugging help, I'd like to
queue it for 5.20.

However, there is a couple of nits that I'd like to address:

- the code is extremely hard to follow, due to the include maze and
  the various levels of inline functions that have forward
  declarations...

- there is a subtle bug in the way the kernel on_accessible_stack()
  helper has been rewritten

- the config symbol for the protected unwinder is oddly placed

Instead of going for another round and missing the merge window, I
propose to stash the following patches on top, which IMHO result in
something much more readable.

This series directly applies on top of Kalesh's.

[1] https://lore.kernel.org/r/20220726073750.3219117-1-kaleshsingh@google.com

Marc Zyngier (5):
  KVM: arm64: Move PROTECTED_NVHE_STACKTRACE around
  KVM: arm64: Move nVHE stacktrace unwinding into its own compilation
    unit
  KVM: arm64: Make unwind()/on_accessible_stack() per-unwinder functions
  KVM: arm64: Move nVHE-only helpers into kvm/stacktrace.c
  arm64: Update 'unwinder howto'

Oliver Upton (1):
  KVM: arm64: Don't open code ARRAY_SIZE()

 arch/arm64/include/asm/stacktrace.h        |  74 -------
 arch/arm64/include/asm/stacktrace/common.h |  69 ++-----
 arch/arm64/include/asm/stacktrace/nvhe.h   | 125 +-----------
 arch/arm64/kernel/stacktrace.c             |  90 +++++++++
 arch/arm64/kvm/Kconfig                     |  24 ++-
 arch/arm64/kvm/Makefile                    |   2 +-
 arch/arm64/kvm/handle_exit.c               |  98 ---------
 arch/arm64/kvm/hyp/nvhe/stacktrace.c       |  55 +++++-
 arch/arm64/kvm/stacktrace.c                | 218 +++++++++++++++++++++
 9 files changed, 394 insertions(+), 361 deletions(-)
 create mode 100644 arch/arm64/kvm/stacktrace.c

-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
