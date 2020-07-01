Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AA771210D98
	for <lists+kvmarm@lfdr.de>; Wed,  1 Jul 2020 16:20:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BB0F4B31D;
	Wed,  1 Jul 2020 10:20:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wwkJ9sOoXWOx; Wed,  1 Jul 2020 10:20:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3EA94B31A;
	Wed,  1 Jul 2020 10:20:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 380104B277
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 10:20:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3zJMMn7zG49 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Jul 2020 10:20:28 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A19D4B275
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 10:20:28 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60C5E30E;
 Wed,  1 Jul 2020 07:20:26 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com
 [10.1.197.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2242C3F73C;
 Wed,  1 Jul 2020 07:20:24 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: kvm@vger.kernel.org
Subject: [PATCH] kvmtool: arm64: Report missing support for 32bit guests
Date: Wed,  1 Jul 2020 15:20:02 +0100
Message-Id: <20200701142002.51654-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: andre.przywara@arm.com, Sami Mujawar <sami.mujawar@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

When the host doesn't support 32bit guests, the kvmtool fails
without a proper message on what is wrong. i.e,

 $ lkvm run -c 1 Image --aarch32
  # lkvm run -k Image -m 256 -c 1 --name guest-105618
  Fatal: Unable to initialise vcpu

Given that there is no other easy way to check if the host supports 32bit
guests, it is always good to report this by checking the capability, rather
than leaving the users to hunt this down by looking at the code!

After this patch:

 $ lkvm run -c 1 Image --aarch32
  # lkvm run -k Image -m 256 -c 1 --name guest-105695
  Fatal: 32bit guests are not supported

Cc: Will Deacon <will@kernel.org>
Reported-by: Sami Mujawar <sami.mujawar@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/kvm-cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
index 554414f..2acecae 100644
--- a/arm/kvm-cpu.c
+++ b/arm/kvm-cpu.c
@@ -46,6 +46,10 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 		.features = ARM_VCPU_FEATURE_FLAGS(kvm, cpu_id)
 	};
 
+	if (kvm->cfg.arch.aarch32_guest &&
+	    !kvm__supports_extension(kvm, KVM_CAP_ARM_EL1_32BIT))
+		die("32bit guests are not supported\n");
+
 	vcpu = calloc(1, sizeof(struct kvm_cpu));
 	if (!vcpu)
 		return NULL;
-- 
2.24.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
