Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1712E8D46
	for <lists+kvmarm@lfdr.de>; Sun,  3 Jan 2021 17:45:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DFC44B277;
	Sun,  3 Jan 2021 11:45:10 -0500 (EST)
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
	with ESMTP id VPiQCM+eJL7u; Sun,  3 Jan 2021 11:45:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 194BE4B27E;
	Sun,  3 Jan 2021 11:45:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C0BA24B266
 for <kvmarm@lists.cs.columbia.edu>; Sun,  3 Jan 2021 09:01:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40ZFLdsvA4d0 for <kvmarm@lists.cs.columbia.edu>;
 Sun,  3 Jan 2021 09:01:09 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C452B4B1F2
 for <kvmarm@lists.cs.columbia.edu>; Sun,  3 Jan 2021 09:01:09 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CC5B20C56;
 Sun,  3 Jan 2021 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609682468;
 bh=HTypC30TDtap+wwyfZ7D+lF6Xf783015Cd+73+IGuD4=;
 h=From:To:Cc:Subject:Date:From;
 b=hoqjBQMsL0M+WFOYBk/RiHhGD0f3wf3zgivimzkWaIaHRZOWHhvs83ko3/UIquXZr
 JzoqCqv6D9c/Fs0qO9HcPRSZhUeaK7hTX7nusmqp7/8KzhcSKESrTsXLEcXz1ZOQlS
 cEnm+L7eF5Z+DvzLuA5H/BSN7W03A7AVtgOn/C0pXKUKoYGIiu6agHFaw4HAxCwfdW
 zm+Onu/34tJwWr922C7vUUj17Z7fHIkAn2AVRg43mru0Mm8oiqBSmq5SE/NDYVPPdc
 R0jrFiHjUunynrXGv3FTaJtSzqzrAXH1gxUAS1TTAo51C9df5wOlKUNlFNFLrk/6cI
 ErsZZbvoLRxbA==
From: Arnd Bergmann <arnd@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: [PATCH] KVM: arm64: remove incorrect __init annotation
Date: Sun,  3 Jan 2021 15:00:50 +0100
Message-Id: <20210103140104.3853922-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 03 Jan 2021 11:45:07 -0500
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

From: Arnd Bergmann <arnd@arndb.de>

When hyp_cpu_pm_exit() is not inlined, it causes a link time warning:

WARNING: modpost: vmlinux.o(.text+0x39974): Section mismatch in reference from the function kvm_arch_init() to the function .init.text:hyp_cpu_pm_exit()
The function kvm_arch_init() references
the function __init hyp_cpu_pm_exit().
This is often because kvm_arch_init lacks a __init
annotation or the annotation of hyp_cpu_pm_exit is wrong.

This is not only called at boot time, so remove the annotation
to prevent undefined behavior in case it gets called after being
freed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kvm/arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6e637d2b4cfb..71a49eae9ea0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1574,12 +1574,12 @@ static struct notifier_block hyp_init_cpu_pm_nb = {
 	.notifier_call = hyp_init_cpu_pm_notifier,
 };
 
-static void __init hyp_cpu_pm_init(void)
+static void hyp_cpu_pm_init(void)
 {
 	if (!is_protected_kvm_enabled())
 		cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
 }
-static void __init hyp_cpu_pm_exit(void)
+static void hyp_cpu_pm_exit(void)
 {
 	if (!is_protected_kvm_enabled())
 		cpu_pm_unregister_notifier(&hyp_init_cpu_pm_nb);
-- 
2.29.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
