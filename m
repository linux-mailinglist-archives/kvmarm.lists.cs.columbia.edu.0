Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C7ECE49B7C0
	for <lists+kvmarm@lfdr.de>; Tue, 25 Jan 2022 16:38:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4038C49ED9;
	Tue, 25 Jan 2022 10:38:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDjweBSn-ofC; Tue, 25 Jan 2022 10:38:30 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0703449EEB;
	Tue, 25 Jan 2022 10:38:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 12DCA49E42
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Jan 2022 10:38:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AwkcjqkIBcEE for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Jan 2022 10:38:26 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ADA3E49ECB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Jan 2022 10:38:26 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AB45101E;
 Tue, 25 Jan 2022 07:38:26 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.218])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C3423F793;
 Tue, 25 Jan 2022 07:38:25 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: kvmarm@lists.cs.columbia.edu,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] KVM: arm64: Stop handle_exit() from handling HVC twice
 when an SError occurs
Date: Tue, 25 Jan 2022 15:38:02 +0000
Message-Id: <20220125153803.549084-4-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125153803.549084-1-james.morse@arm.com>
References: <20220125153803.549084-1-james.morse@arm.com>
MIME-Version: 1.0
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
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

Prior to commit defe21f49bc9 ("KVM: arm64: Move PC rollback on SError to
HYP"), when an SError is synchronised due to another exception, KVM
handles the SError first. If the guest survives, the instruction that
triggered the original exception is re-exectued to handle the first
exception. HVC is treated as a special case as the instruction wouldn't
normally be re-exectued, as its not a trap.

Commit defe21f49bc9 didn't preserve the behaviour of the 'return 1'
that skips the rest of handle_exit().

Since commit defe21f49bc9, KVM will try to handle the SError and the
original exception at the same time. When the exception was an HVC,
fixup_guest_exit() has already rolled back ELR_EL2, meaning if the
guest has virtual SError masked, it will execute and handle the HVC
twice.

Restore the original behaviour.

Fixes: defe21f49bc9 ("KVM: arm64: Move PC rollback on SError to HYP")
Cc: stable@vger.kernel.org
Signed-off-by: James Morse <james.morse@arm.com>
---
It may be possible to remove both this patch, and the HVC handling code
in fixup_guest_exit(). This means KVM would always handle the exception
and the SError. This may result in unnecessary work if the guest takes
the virtual SError when it is next restarted, but should be harmless if
SError are always re-injected using HCR_EL2.VSE.
---
 arch/arm64/kvm/handle_exit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index fd2dd26caf91..e3140abd2e2e 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -228,6 +228,14 @@ int handle_exit(struct kvm_vcpu *vcpu, int exception_index)
 {
 	struct kvm_run *run = vcpu->run;
 
+	if (ARM_SERROR_PENDING(exception_index)) {
+		/*
+		 * The SError is handled by handle_exit_early(). If the guest
+		 * survives it will re-execute the original instruction.
+		 */
+		return 1;
+	}
+
 	exception_index = ARM_EXCEPTION_CODE(exception_index);
 
 	switch (exception_index) {
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
