Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7C221497
	for <lists+kvmarm@lfdr.de>; Wed, 15 Jul 2020 20:45:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD1954B3C0;
	Wed, 15 Jul 2020 14:45:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9UN5n4uOkV7o; Wed, 15 Jul 2020 14:45:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C6B834B3CF;
	Wed, 15 Jul 2020 14:45:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 27BC34B323
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 14:45:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KT4homDdPpiH for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Jul 2020 14:45:45 -0400 (EDT)
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 24B814B3CF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 14:45:45 -0400 (EDT)
Received: by mail-wm1-f74.google.com with SMTP id b13so1744726wme.9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=bNfxp8vNqUMU6z9HXb6F5ln+dVIXrnPe24T0gjZPjQM=;
 b=QGZvrYbuPPKTPnfd09+iTYEDEfPtkm94Z6z3kVbJPu4+dUhkFJRcpdA9HHAycaXY3D
 dfJvlomj9RDilym4FdBfLdkI0plp7qc0WuvuXu/a7hCjl9FqxXMFj3wEnB5gjvVYYwR/
 /dTTyjKODBocO6nVVEpaq9F6Ldfvv/DEeIqAToSAUBVY2N1x7Pj1+WOa47ZjkXGl2S7Y
 enFkHzVDfDFjPTIXqyqwV73MpfPsiTsr3QNZZ6ODT+2+5b7CJ2K+DcyXDQ8zordcEOsN
 yBAA+efFvbuLjD/QZB+mF16dD6a4+GTWPCVKJrxlzSPkz0y28Yk/8VRvWQizpXm8v+fd
 KCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=bNfxp8vNqUMU6z9HXb6F5ln+dVIXrnPe24T0gjZPjQM=;
 b=rsnZwWgNIcf306J+BvuPW7ClWVJh4XiFrx8+/CS6vk+VqSoAD8Cr8Q7PuCA3Uv1PsY
 6CDZMhZdTEC9YBAPZf8yNlu5isMxZ2gFHyLAyJDztqI5iby/7nqRMgsB27lHvNRYLP25
 vKxAezNnz5xNNNfirCy6Vw0hqqK7Q7G80hKcPNpptNIxiJpwS3zXOS71kgQZQxEa3biD
 tETndogtM3dzWD1wr3zcDtjU1ikYnOs4a+fRU+hfKhefG5PpnaRCGWqMHghVr9HX71qT
 iU6nCpAeYHSgWzHObTjj5FeA2SnzzICRExWlpt/3ravFkA4y2b+SlBqFzMV361iUmJrP
 l16w==
X-Gm-Message-State: AOAM533yGwQxkeh+QdA2e+zOPwT1sisOwut9EUfxutHF+UQj+Z63FnGS
 0Z9/AhDn4L2jgMNFiX8D5LwJlaEt/hEDtE3qb2hlr3DGMaHXEPClpHTgmxuCpKcb8mjXkeec64S
 TygtvIrrbNUte1T5yvmURzfND5uH7vj8fWo+T47KEYYSGyCy/PTFYJ6yYAYf5cUfpI8/ZLg==
X-Google-Smtp-Source: ABdhPJwHFhzgNmN+3A2pZ5p7Dtm/ohniNP5ZPTiRQbZt9dAve9wfr0UBOv31oK8mHgwmh+2IoHXXnFaHU3U=
X-Received: by 2002:a1c:2d0c:: with SMTP id t12mr727008wmt.43.1594838744295;
 Wed, 15 Jul 2020 11:45:44 -0700 (PDT)
Date: Wed, 15 Jul 2020 19:44:26 +0100
In-Reply-To: <20200715184438.1390996-1-ascull@google.com>
Message-Id: <20200715184438.1390996-26-ascull@google.com>
Mime-Version: 1.0
References: <20200715184438.1390996-1-ascull@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 25/37] KVM: arm64: nVHE: Unify sysreg state saving paths
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, kernel-team@android.com
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

The sysreg state is stored in the vcpu for the guests and the host so a
common path can be used to save the sysreg state.

Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/kvm/hyp/nvhe/switch.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index f9a35ca02ad1..0cabb8ce7d68 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -155,8 +155,6 @@ static void __kvm_vcpu_switch_to_guest(struct kvm_vcpu *host_vcpu,
 
 	__pmu_switch_to_guest();
 
-	__sysreg_save_state_nvhe(&host_vcpu->arch.ctxt);
-
 	/*
 	 * We must restore the 32-bit state before the sysregs, thanks
 	 * to erratum #852523 (Cortex-A57) or #853709 (Cortex-A72).
@@ -182,7 +180,6 @@ static void __kvm_vcpu_switch_to_host(struct kvm_vcpu *host_vcpu,
 {
 	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
 
-	__sysreg_save_state_nvhe(guest_ctxt);
 	__sysreg32_save_state(vcpu);
 	__timer_disable_traps(vcpu);
 	__hyp_vgic_save_state(vcpu);
@@ -208,7 +205,12 @@ static void __kvm_vcpu_switch_to_host(struct kvm_vcpu *host_vcpu,
 		gic_write_pmr(GIC_PRIO_IRQOFF);
 }
 
-static void __vcpu_switch_to(struct kvm_vcpu *vcpu)
+static void __vcpu_save_state(struct kvm_vcpu *vcpu)
+{
+	__sysreg_save_state_nvhe(&vcpu->arch.ctxt);
+}
+
+static void __vcpu_restore_state(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *running_vcpu;
 
@@ -248,7 +250,8 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 			return ARM_EXCEPTION_IRQ;
 		}
 
-		__vcpu_switch_to(vcpu);
+		__vcpu_save_state(running_vcpu);
+		__vcpu_restore_state(vcpu);
 	}
 
 	__set_vcpu_arch_workaround_state(vcpu);
-- 
2.27.0.389.gc38d7665816-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
