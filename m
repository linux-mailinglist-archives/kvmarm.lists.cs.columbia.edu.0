Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 994752F7569
	for <lists+kvmarm@lfdr.de>; Fri, 15 Jan 2021 10:30:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29ADC4B1A7;
	Fri, 15 Jan 2021 04:30:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vd0X22Q7XG95; Fri, 15 Jan 2021 04:30:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CABB4B19D;
	Fri, 15 Jan 2021 04:30:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 703214B0ED
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jan 2021 04:30:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e1shBZI0fuW8 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 15 Jan 2021 04:30:52 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 98F5C4B0DE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jan 2021 04:30:52 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20E79D6E;
 Fri, 15 Jan 2021 01:30:52 -0800 (PST)
Received: from entos-thunderx2-desktop.shanghai.arm.com
 (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.218])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D7DEB3F66E;
 Fri, 15 Jan 2021 01:30:48 -0800 (PST)
From: Jianyong Wu <jianyong.wu@arm.com>
To: maz@kernel.org,
	james.morse@arm.com,
	will@kernel.org
Subject: [PATCH] arm64/kvm: correct the error report in kvm_handle_guest_abort
Date: Fri, 15 Jan 2021 17:30:28 +0800
Message-Id: <20210115093028.6504-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Cc: justin.he@arm.com, nd@arm.com, kvmarm@lists.cs.columbia.edu,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Currently, error report when cache maintenance at read-only memory range,
like rom, is not clear enough and even not correct. As the specific error
is definitely known by kvm, it is obliged to give it out.

Fox example, in a qemu/kvm VM, if the guest do dc at the pflash range from
0 to 128M, error is reported by kvm as "Data abort outside memslots with
no valid syndrome info" which is not quite correct.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 arch/arm64/kvm/mmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7d2257cc5438..de66b7e38a5b 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1022,9 +1022,15 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		 * So let's assume that the guest is just being
 		 * cautious, and skip the instruction.
 		 */
-		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
-			kvm_incr_pc(vcpu);
-			ret = 1;
+		if (kvm_vcpu_dabt_is_cm(vcpu)) {
+			if (kvm_is_error_hva(hva)) {
+				kvm_incr_pc(vcpu);
+				ret = 1;
+				goto out_unlock;
+			}
+
+			kvm_err("Do cache maintenance in the read-only memory range\n");
+			ret = -EFAULT;
 			goto out_unlock;
 		}
 
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
