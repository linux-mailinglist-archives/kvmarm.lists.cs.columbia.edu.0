Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AE312426E34
	for <lists+kvmarm@lfdr.de>; Fri,  8 Oct 2021 17:58:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 53D9C4B130;
	Fri,  8 Oct 2021 11:58:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ppaTCTI3XM8t; Fri,  8 Oct 2021 11:58:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D56AC4B126;
	Fri,  8 Oct 2021 11:58:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A50D54B0DE
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 11:58:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gf8iwSqEnYiJ for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Oct 2021 11:58:37 -0400 (EDT)
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A215F4B0FB
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 11:58:37 -0400 (EDT)
Received: by mail-wr1-f73.google.com with SMTP id
 a10-20020a5d508a000000b00160723ce588so7659426wrt.23
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Oct 2021 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=AF4eoE9nmTsCT0Js3LBGybKDMs//CEnYD1ixUfZLO5A=;
 b=HrX/tXZNkaeFiS/Yr9pl1oq1+0zeuOqeAHJGn2qe8JO4G/wLuWNBfMYAYIKenUyhFF
 kuwgap7uYGwB9lbgRTrrzFvBRfc5GTp6gDn2p2ZkQg4OQQ6CbUVYhINNQTUbE6CG1x+u
 VgtL9rvo7JkyvdIWsWzR64tUymk331Q9gHfbuO+LMpGfDgMnY4iwRqJrNDC5yB2Pp0B/
 6USPoZ3qlRxMFyOYzTijyqhdDGEZRlbjdUHyXukJsF38lLpIl0EUCHe51fzZMHYzQueY
 SIHL+z8spXeDqMeZlzE955t3JhWu1va8sSstpC0nHZ44ivcmnYXON/3XDDBtTNoBf7V+
 dVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=AF4eoE9nmTsCT0Js3LBGybKDMs//CEnYD1ixUfZLO5A=;
 b=rdtFt+B37kJxhPjuJSig6QbwFAVcTwfNTYkZLw7FRyIMumsU0k0NK4CZJy5k0ljyzK
 xxDoY9/FsB+Rq4cMhNAb/BZekV7x04/rr6mvNSGoTADg+IMicKgCQ0AjdPrPHHE2Lqo2
 ptTnlk+IoYTxqx3SfX3jFDfXUW37EdlTL4dOLoRvoo56MWjTDpGwOMcOL/p+kNxVZci6
 S2eF6YmKJyGn5zYMS8t9a99enCQ5vf1gIgWIk0yG4w9Lzbgll0aSrQn8FK1h05NRNXvC
 Eug+GdU3i+RhIQydJ4BGuiFD5bFENza+6PoAQapvyv1YDF1oGVIxq9XmQdWL5byO0iwJ
 flWA==
X-Gm-Message-State: AOAM531KBFv1lFL4tPTQm0bjoMPpQKHy6GjyEeP2EtrxE27fbDeC8WAQ
 uvY1hiX49O2HwQPBq99V5pekZdZidDkOkP51Ybt5NCvWbCpe/mpgdDMHJzqHnNf6YS63S+zollA
 2pPywyUVk0NBE0NiTNTdo7tt7KAF2wmpjTjMeVKlHrkbNEIjdJBJu0bMNwbVUCAYA5+0=
X-Google-Smtp-Source: ABdhPJw3j88fx7mXkHrzClQzYUDvVzNXlo/iyFzAMOjG+H/NnjBAl4bNhcg6VI+X9rIoncK+E3JLXUWlyw==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a05:600c:1911:: with SMTP id
 j17mr4361730wmq.149.1633708716599; Fri, 08 Oct 2021 08:58:36 -0700 (PDT)
Date: Fri,  8 Oct 2021 16:58:22 +0100
In-Reply-To: <20211008155832.1415010-1-tabba@google.com>
Message-Id: <20211008155832.1415010-2-tabba@google.com>
Mime-Version: 1.0
References: <20211008155832.1415010-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v7 01/11] KVM: arm64: Move __get_fault_info() and co into
 their own include file
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

From: Marc Zyngier <maz@kernel.org>

In order to avoid including the whole of the switching helpers
in unrelated files, move the __get_fault_info() and related helpers
into their own include file.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/fault.h  | 75 +++++++++++++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 61 +-------------------
 arch/arm64/kvm/hyp/nvhe/mem_protect.c   |  2 +-
 3 files changed, 77 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/hyp/fault.h

diff --git a/arch/arm64/kvm/hyp/include/hyp/fault.h b/arch/arm64/kvm/hyp/include/hyp/fault.h
new file mode 100644
index 000000000000..1b8a2dcd712f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/hyp/fault.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#ifndef __ARM64_KVM_HYP_FAULT_H__
+#define __ARM64_KVM_HYP_FAULT_H__
+
+#include <asm/kvm_asm.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+
+static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
+{
+	u64 par, tmp;
+
+	/*
+	 * Resolve the IPA the hard way using the guest VA.
+	 *
+	 * Stage-1 translation already validated the memory access
+	 * rights. As such, we can use the EL1 translation regime, and
+	 * don't have to distinguish between EL0 and EL1 access.
+	 *
+	 * We do need to save/restore PAR_EL1 though, as we haven't
+	 * saved the guest context yet, and we may return early...
+	 */
+	par = read_sysreg_par();
+	if (!__kvm_at("s1e1r", far))
+		tmp = read_sysreg_par();
+	else
+		tmp = SYS_PAR_EL1_F; /* back to the guest */
+	write_sysreg(par, par_el1);
+
+	if (unlikely(tmp & SYS_PAR_EL1_F))
+		return false; /* Translation failed, back to guest */
+
+	/* Convert PAR to HPFAR format */
+	*hpfar = PAR_TO_HPFAR(tmp);
+	return true;
+}
+
+static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
+{
+	u64 hpfar, far;
+
+	far = read_sysreg_el2(SYS_FAR);
+
+	/*
+	 * The HPFAR can be invalid if the stage 2 fault did not
+	 * happen during a stage 1 page table walk (the ESR_EL2.S1PTW
+	 * bit is clear) and one of the two following cases are true:
+	 *   1. The fault was due to a permission fault
+	 *   2. The processor carries errata 834220
+	 *
+	 * Therefore, for all non S1PTW faults where we either have a
+	 * permission fault or the errata workaround is enabled, we
+	 * resolve the IPA using the AT instruction.
+	 */
+	if (!(esr & ESR_ELx_S1PTW) &&
+	    (cpus_have_final_cap(ARM64_WORKAROUND_834220) ||
+	     (esr & ESR_ELx_FSC_TYPE) == FSC_PERM)) {
+		if (!__translate_far_to_hpfar(far, &hpfar))
+			return false;
+	} else {
+		hpfar = read_sysreg(hpfar_el2);
+	}
+
+	fault->far_el2 = far;
+	fault->hpfar_el2 = hpfar;
+	return true;
+}
+
+#endif
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index a0e78a6027be..54abc8298ec3 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -8,6 +8,7 @@
 #define __ARM64_KVM_HYP_SWITCH_H__
 
 #include <hyp/adjust_pc.h>
+#include <hyp/fault.h>
 
 #include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
@@ -133,66 +134,6 @@ static inline void ___deactivate_traps(struct kvm_vcpu *vcpu)
 	}
 }
 
-static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
-{
-	u64 par, tmp;
-
-	/*
-	 * Resolve the IPA the hard way using the guest VA.
-	 *
-	 * Stage-1 translation already validated the memory access
-	 * rights. As such, we can use the EL1 translation regime, and
-	 * don't have to distinguish between EL0 and EL1 access.
-	 *
-	 * We do need to save/restore PAR_EL1 though, as we haven't
-	 * saved the guest context yet, and we may return early...
-	 */
-	par = read_sysreg_par();
-	if (!__kvm_at("s1e1r", far))
-		tmp = read_sysreg_par();
-	else
-		tmp = SYS_PAR_EL1_F; /* back to the guest */
-	write_sysreg(par, par_el1);
-
-	if (unlikely(tmp & SYS_PAR_EL1_F))
-		return false; /* Translation failed, back to guest */
-
-	/* Convert PAR to HPFAR format */
-	*hpfar = PAR_TO_HPFAR(tmp);
-	return true;
-}
-
-static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
-{
-	u64 hpfar, far;
-
-	far = read_sysreg_el2(SYS_FAR);
-
-	/*
-	 * The HPFAR can be invalid if the stage 2 fault did not
-	 * happen during a stage 1 page table walk (the ESR_EL2.S1PTW
-	 * bit is clear) and one of the two following cases are true:
-	 *   1. The fault was due to a permission fault
-	 *   2. The processor carries errata 834220
-	 *
-	 * Therefore, for all non S1PTW faults where we either have a
-	 * permission fault or the errata workaround is enabled, we
-	 * resolve the IPA using the AT instruction.
-	 */
-	if (!(esr & ESR_ELx_S1PTW) &&
-	    (cpus_have_final_cap(ARM64_WORKAROUND_834220) ||
-	     (esr & ESR_ELx_FSC_TYPE) == FSC_PERM)) {
-		if (!__translate_far_to_hpfar(far, &hpfar))
-			return false;
-	} else {
-		hpfar = read_sysreg(hpfar_el2);
-	}
-
-	fault->far_el2 = far;
-	fault->hpfar_el2 = hpfar;
-	return true;
-}
-
 static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 {
 	u8 ec;
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index bacd493a4eac..2a07d63b8498 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -11,7 +11,7 @@
 #include <asm/kvm_pgtable.h>
 #include <asm/stage2_pgtable.h>
 
-#include <hyp/switch.h>
+#include <hyp/fault.h>
 
 #include <nvhe/gfp.h>
 #include <nvhe/memory.h>
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
