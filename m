Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF53428219
	for <lists+kvmarm@lfdr.de>; Sun, 10 Oct 2021 16:57:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 299D54B130;
	Sun, 10 Oct 2021 10:57:08 -0400 (EDT)
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
	with ESMTP id OA08ZPXKDXYI; Sun, 10 Oct 2021 10:57:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EC5304A524;
	Sun, 10 Oct 2021 10:57:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 223A6406E0
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 Oct 2021 10:57:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ZyFVccDGRNb for <kvmarm@lists.cs.columbia.edu>;
 Sun, 10 Oct 2021 10:57:04 -0400 (EDT)
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7580C4B10B
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 Oct 2021 10:57:03 -0400 (EDT)
Received: by mail-wr1-f73.google.com with SMTP id
 r16-20020adfb1d0000000b00160bf8972ceso11175655wra.13
 for <kvmarm@lists.cs.columbia.edu>; Sun, 10 Oct 2021 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=iqD8cN6+ivvU4iBUA/M2YmIiCTZR+r/k27SL/Wa8sLA=;
 b=JkgJ+h41AKcXBuaovTWMlreIJ+wWWz1N/aBu0BO5M72w0oNjaRLkJrDNzotUdn/cAl
 8V0kCzynY0RgN3gUXiAsrXTF12s5FUwCJv61wp5QlFM/7X6VZq/tY1NvR8uoj+9fo9Ym
 7vPCYdWzErC0kuZq5TZIdeJbxbV40zYLjZtiSUy4lypwjGLcGau9crjYDf9BRADzTpTZ
 n+zk2/h+o+mh7FD/bI5uhzB6WIcx2Sc1u1PBsnXUEofKb4LqVZZ/fC+Muxuqk5SAWYL3
 41MZUM3T4o5KzVp3yLBM/1yaS5F2JAy+xsaYDgTmeK6+uPiiOkdClq7fwMb4xh8jUPXb
 q5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=iqD8cN6+ivvU4iBUA/M2YmIiCTZR+r/k27SL/Wa8sLA=;
 b=6dYtcYxiAFKRTF6gSvWz9I4TPhzc5kwSJRvbdV/aAssgXAUNPdDN0pdZ/XwM1JdEi3
 vjbQB5dZgL93Xkc6aPuc1sGa3CL1UECsW6mWClp8/1oy1qcXYnKClqemWdT0hOJZ8XKE
 wjB2LcUHzgMBZbFhvO/4LQ3yL2W0EdzaqNzm+W4dFNV7UWOEVnBPv/uOCKOEYh2jk64h
 63hOq33ZpAtJDoQyMybTj0MZWqDUdJrgw03pi6Xubn9/91X3Q3/XRd0lZfssjWGuWkab
 jRe3awcO7YBigmLZcWXzhpFtMci6LO4NdcEC9mK/M37s5KFyfB4RfjqHmyxIUc5r6ppi
 NyBQ==
X-Gm-Message-State: AOAM532mBMJrfxGOfRqp8BHEZ++15PnBqHXrLz51h+Qm4Fl2TVUi/kyR
 KdO39Q7kOR+GAJg62sfsUi/b3yGAslpHJP9x0sLNKglZ7q7FapEdxetFfoI34X4t7kn0RPYjm4u
 Tb3N/0l0dA5dWZwvMce6T2vP4LaHUKDFgITA0oRf/+JA9tQ83bSTvWKK1HIi/72tAbHg=
X-Google-Smtp-Source: ABdhPJzyzsbX9XBEOAzHExe8EnKvXmroPP9Ti8Of4mQOVfNcYEGFyNpZFTG+S7YxvTtrVrz7uUxNbXVbqw==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a1c:1941:: with SMTP id
 62mr7793689wmz.131.1633877822472; 
 Sun, 10 Oct 2021 07:57:02 -0700 (PDT)
Date: Sun, 10 Oct 2021 15:56:36 +0100
In-Reply-To: <20211010145636.1950948-1-tabba@google.com>
Message-Id: <20211010145636.1950948-12-tabba@google.com>
Mime-Version: 1.0
References: <20211010145636.1950948-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v8 11/11] KVM: arm64: Handle protected guests at 32 bits
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

Protected KVM does not support protected AArch32 guests. However,
it is possible for the guest to force run AArch32, potentially
causing problems. Add an extra check so that if the hypervisor
catches the guest doing that, it can prevent the guest from
running again by resetting vcpu->arch.target and returning
ARM_EXCEPTION_IL.

If this were to happen, The VMM can try and fix it by re-
initializing the vcpu with KVM_ARM_VCPU_INIT, however, this is
likely not possible for protected VMs.

Adapted from commit 22f553842b14 ("KVM: arm64: Handle Asymmetric
AArch32 systems")

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/switch.c | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 2c72c31e516e..f25b6353a598 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -232,6 +232,37 @@ static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm *kvm)
 	return hyp_exit_handlers;
 }
 
+/*
+ * Some guests (e.g., protected VMs) are not be allowed to run in AArch32.
+ * The ARMv8 architecture does not give the hypervisor a mechanism to prevent a
+ * guest from dropping to AArch32 EL0 if implemented by the CPU. If the
+ * hypervisor spots a guest in such a state ensure it is handled, and don't
+ * trust the host to spot or fix it.  The check below is based on the one in
+ * kvm_arch_vcpu_ioctl_run().
+ *
+ * Returns false if the guest ran in AArch32 when it shouldn't have, and
+ * thus should exit to the host, or true if a the guest run loop can continue.
+ */
+static bool handle_aarch32_guest(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	struct kvm *kvm = kern_hyp_va(vcpu->kvm);
+
+	if (kvm_vm_is_protected(kvm) && vcpu_mode_is_32bit(vcpu)) {
+		/*
+		 * As we have caught the guest red-handed, decide that it isn't
+		 * fit for purpose anymore by making the vcpu invalid. The VMM
+		 * can try and fix it by re-initializing the vcpu with
+		 * KVM_ARM_VCPU_INIT, however, this is likely not possible for
+		 * protected VMs.
+		 */
+		vcpu->arch.target = -1;
+		*exit_code = ARM_EXCEPTION_IL;
+		return false;
+	}
+
+	return true;
+}
+
 /* Switch to the guest for legacy non-VHE systems */
 int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 {
@@ -294,6 +325,9 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 		/* Jump in the fire! */
 		exit_code = __guest_enter(vcpu);
 
+		if (unlikely(!handle_aarch32_guest(vcpu, &exit_code)))
+			break;
+
 		/* And we're baaack! */
 	} while (fixup_guest_exit(vcpu, &exit_code));
 
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
