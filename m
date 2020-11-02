Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B43792A338A
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 20:03:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 67C3F4B470;
	Mon,  2 Nov 2020 14:03:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jt7luiPjwsxQ; Mon,  2 Nov 2020 14:03:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DACA4B569;
	Mon,  2 Nov 2020 14:03:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C3944B470
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 14:03:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nb06Z1as7P0Y for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 14:03:20 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F14AA4B494
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 14:03:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604343799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3DZ9FLP/h7oQU/WTir0mNtH8qW5ViOpp522zv7JM/0s=;
 b=ef7spEaT+PPbZ22CGsfPub5VTXlSWSfAzQwwS/aX4zdpMZanEnspskrW+nTAYqUM+ZIVo7
 9MkH2XnJcLc6Mi87hfiD577aHKKqAFNyY7JRrjWKIBqsMi+5SVaIrDcss/RWelir3BwEK9
 WGQamLWa/0vS4ibwao22JACTY5d3cRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520--mxUgGWuPZGmod8LDqJk-g-1; Mon, 02 Nov 2020 14:03:16 -0500
X-MC-Unique: -mxUgGWuPZGmod8LDqJk-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EF261099F67;
 Mon,  2 Nov 2020 19:03:14 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D88F5B4A1;
 Mon,  2 Nov 2020 19:03:12 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 2/3] KVM: selftests: Update aarch64 get-reg-list blessed
 list
Date: Mon,  2 Nov 2020 20:02:52 +0100
Message-Id: <20201102190253.50575-3-drjones@redhat.com>
In-Reply-To: <20201102190253.50575-1-drjones@redhat.com>
References: <20201102190253.50575-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: pbonzini@redhat.com, Dave.Martin@arm.com, maz@kernel.org
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

The new registers come from the following commits:

commit 99adb567632b ("KVM: arm/arm64: Add save/restore support for
firmware workaround state")

commit c773ae2b3476 ("KVM: arm64: Save/Restore guest DISR_EL1")

commit 03fdfb269009 ("KVM: arm64: Don't write junk to sysregs on reset")

The last commit, which adds ARM64_SYS_REG(3, 3, 9, 12, 0) (PMCR_EL0),
and was committed for v5.3, doesn't indicate in its commit message that
enumerating it for save/restore was the plan. It's a good idea anyway,
since the other PMU registers have been enumerated since v4.10.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 6fae4c3cb0c6..db97001f37f7 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -352,7 +352,10 @@ int main(int ac, char **av)
 }
 
 /*
- * The current blessed list comes from kernel version v4.15 with --core-reg-fixup
+ * The current blessed list was primed with the output of kernel version
+ * v4.15 with --core-reg-fixup and then later updated with new registers.
+ *
+ * The blessed list is up to date with kernel version v5.10-rc2
  */
 static __u64 blessed_reg[] = {
 	KVM_REG_ARM64 | KVM_REG_SIZE_U64 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(regs.regs[0]),
@@ -430,6 +433,9 @@ static __u64 blessed_reg[] = {
 	KVM_REG_ARM64 | KVM_REG_SIZE_U128 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]),
 	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.fpsr),
 	KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(fp_regs.fpcr),
+	KVM_REG_ARM_FW_REG(0),
+	KVM_REG_ARM_FW_REG(1),
+	KVM_REG_ARM_FW_REG(2),
 	ARM64_SYS_REG(3, 3, 14, 3, 1),	/* CNTV_CTL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 3, 2),	/* CNTV_CVAL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 0, 2),
@@ -578,10 +584,12 @@ static __u64 blessed_reg[] = {
 	ARM64_SYS_REG(3, 0, 10, 2, 0),	/* MAIR_EL1 */
 	ARM64_SYS_REG(3, 0, 10, 3, 0),	/* AMAIR_EL1 */
 	ARM64_SYS_REG(3, 0, 12, 0, 0),	/* VBAR_EL1 */
+	ARM64_SYS_REG(3, 0, 12, 1, 1),	/* DISR_EL1 */
 	ARM64_SYS_REG(3, 0, 13, 0, 1),	/* CONTEXTIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 13, 0, 4),	/* TPIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 14, 1, 0),	/* CNTKCTL_EL1 */
 	ARM64_SYS_REG(3, 2, 0, 0, 0),	/* CSSELR_EL1 */
+	ARM64_SYS_REG(3, 3, 9, 12, 0),	/* PMCR_EL0 */
 	ARM64_SYS_REG(3, 3, 9, 12, 1),	/* PMCNTENSET_EL0 */
 	ARM64_SYS_REG(3, 3, 9, 12, 2),	/* PMCNTENCLR_EL0 */
 	ARM64_SYS_REG(3, 3, 9, 12, 3),	/* PMOVSCLR_EL0 */
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
