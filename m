Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EF55839FB3F
	for <lists+kvmarm@lfdr.de>; Tue,  8 Jun 2021 17:54:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A417149E8C;
	Tue,  8 Jun 2021 11:54:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bYutCrDDTjpf; Tue,  8 Jun 2021 11:54:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F9234A19E;
	Tue,  8 Jun 2021 11:54:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B42F340878
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Jun 2021 11:54:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 42younHrMYnP for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Jun 2021 11:54:07 -0400 (EDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6A5654086F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Jun 2021 11:54:05 -0400 (EDT)
Received: by mail-wr1-f54.google.com with SMTP id m18so22155628wrv.2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 08 Jun 2021 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vY60FWlLV1xpe2gtDWbEapubpchtwsNSBFFHT7yOxe0=;
 b=qfSlHca66UxSFszZIYf1Ho34VW7NdqKkuU+Pc8aTRoFu2WAU8C7R5vlR511TO3aKYr
 kroybsX+yhcmbjt2IlLgNnQyKw0ZOnCws+R1zr3ywgOUz849ROejIKxhybmKnv35DELZ
 RfP8PTeca+tIUXQI0EWgp8V2dYYsKqx3T9LOmH/cg0FmJ+Hu53AIaZ19HmoIEvkat938
 DQiEIaOKoBAAGW3iJRpIigw7h6Y6v0/rxv/yzhJE1hUuY96aGWcRtfcaZfTX6QbW/wuT
 vDqpUUDN/7RRZTZxr/NgRPEWBhBw+zaNf4KTdybDBajcKU32apwOlG3cP00Yvu3r9GpF
 09Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vY60FWlLV1xpe2gtDWbEapubpchtwsNSBFFHT7yOxe0=;
 b=rgMEyVd5AL0F+yOYs6Wv9GzkY/gTF2WFiHhmTvPD2p6ciWFumLpYNnyzHgLkkh78v3
 aKQaKXk3UBZOruwW1tQpdanoU5xyQ9hUDT6g0EmLZxf51QrUzswmXLfO8Q8kFcRQlhO4
 nzoIKx/c2QPr5Q6vqE5JxUCMvlM4zWCPEm1/ER5JOJdXKB5wxY7rPWpScBMPX5YAeye/
 3R5otkqPoVNzaZQ6MgVJ/O5E6lN8EFxsxBBLScsyQKIPul+iVmudXa0tXA6aGKLg1WQ9
 RJyC1fooUF+lbEeM2FxK4SkZ+HuacxeCw+OmDaW6Xl5kCPHKo4EtllWeKNVWs75oc4SL
 ZMiA==
X-Gm-Message-State: AOAM532ZBKPEs5Nct+6JobXmiyGbNSWyDAVF3XbkQdEJxv5B+H0lqxFm
 bqDbuGKnLtC+jc4UIwE9Yzwkxg==
X-Google-Smtp-Source: ABdhPJyKyuA8FB6TyDgi8X2Ffbrwu7e7pRxSFAZugb7LawFRVBOmbO7jA2vBPjlJibJuploId8Mjkw==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr23036101wrx.144.1623167644621; 
 Tue, 08 Jun 2021 08:54:04 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch.
 [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id l31sm3314180wms.16.2021.06.08.08.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 08:54:04 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: maz@kernel.org
Subject: [RFC PATCH 4/5] KVM: arm64: Pass hypercalls to userspace
Date: Tue,  8 Jun 2021 17:48:05 +0200
Message-Id: <20210608154805.216869-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608154805.216869-1-jean-philippe@linaro.org>
References: <20210608154805.216869-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, salil.mehta@huawei.com,
 lorenzo.pieralisi@arm.com, kvm@vger.kernel.org, corbet@lwn.net,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, will@kernel.org,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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

Let userspace request to handle all hypercalls that aren't handled by
KVM, by setting the KVM_CAP_ARM_HVC_TO_USER capability.

With the help of another capability, this will allow userspace to handle
PSCI calls.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---

Notes on this implementation:

* A similar mechanism was proposed for SDEI some time ago [1]. This RFC
  generalizes the idea to all hypercalls, since that was suggested on
  the list [2, 3].

* We're reusing kvm_run.hypercall. I copied x0-x5 into
  kvm_run.hypercall.args[] to help userspace but I'm tempted to remove
  this, because:
  - Most user handlers will need to write results back into the
    registers (x0-x3 for SMCCC), so if we keep this shortcut we should
    go all the way and synchronize them on return to kernel.
  - QEMU doesn't care about this shortcut, it pulls all vcpu regs before
    handling the call.
  - SMCCC uses x0-x16 for parameters.
  x0 does contain the SMCCC function ID and may be useful for fast
  dispatch, we could keep that plus the immediate number.

* Should we add a flag in the kvm_run.hypercall telling whether this is
  HVC or SMC?  Can be added later in those bottom longmode and pad
  fields.

* On top of this we could share with userspace which HVC ranges are
  available and which ones are handled by KVM. That can actually be
  added independently, through a vCPU/VM device attribute (which doesn't
  consume a new ioctl):
  - userspace issues HAS_ATTR ioctl on the VM fd to query whether this
    feature is available.
  - userspace queries the number N of HVC ranges using one GET_ATTR.
  - userspace passes an array of N ranges using another GET_ATTR.
    The array is filled and returned by KVM.

* Untested for AArch32 guests.

[1] https://lore.kernel.org/linux-arm-kernel/20170808164616.25949-12-james.morse@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/bf7e83f1-c58e-8d65-edd0-d08f27b8b766@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/f56cf420-affc-35f0-2355-801a924b8a35@arm.com/
---
 Documentation/virt/kvm/api.rst    | 17 +++++++++++++++--
 arch/arm64/include/asm/kvm_host.h |  1 +
 include/kvm/arm_psci.h            |  4 ++++
 include/uapi/linux/kvm.h          |  1 +
 arch/arm64/kvm/arm.c              |  5 +++++
 arch/arm64/kvm/hypercalls.c       | 28 +++++++++++++++++++++++++++-
 6 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e4fe7fb60d5d..3d8c1661e7b2 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5228,8 +5228,12 @@ to the byte array.
 			__u32 pad;
 		} hypercall;
 
-Unused.  This was once used for 'hypercall to userspace'.  To implement
-such functionality, use KVM_EXIT_IO (x86) or KVM_EXIT_MMIO (all except s390).
+On x86 this was once used for 'hypercall to userspace'.  To implement such
+functionality, use KVM_EXIT_IO (x86) or KVM_EXIT_MMIO (all except s390).
+
+On arm64 it is used for hypercalls, when the KVM_CAP_ARM_HVC_TO_USER capability
+is enabled. 'nr' contains the HVC or SMC immediate. 'args' contains registers
+x0 - x5. The other parameters are unused.
 
 .. note:: KVM_EXIT_IO is significantly faster than KVM_EXIT_MMIO.
 
@@ -6894,3 +6898,12 @@ This capability is always enabled.
 This capability indicates that the KVM virtual PTP service is
 supported in the host. A VMM can check whether the service is
 available to the guest on migration.
+
+8.33 KVM_CAP_ARM_HVC_TO_USER
+----------------------------
+
+:Architecture: arm64
+
+This capability indicates that KVM can pass unhandled hypercalls to userspace,
+if the VMM enables it. Hypercalls are passed with KVM_EXIT_HYPERCALL in
+kvm_run::hypercall.
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3ca732feb9a5..25554ce97045 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -123,6 +123,7 @@ struct kvm_arch {
 	 * supported.
 	 */
 	bool return_nisv_io_abort_to_user;
+	bool hvc_to_user;
 
 	/*
 	 * VM-wide PMU filter, implemented as a bitmap and big enough for
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 5b58bd2fe088..d6b71a48fbb1 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -16,6 +16,10 @@
 
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
+#define KVM_PSCI_FN_LAST	KVM_PSCI_FN(3)
+#define PSCI_0_2_FN_LAST	PSCI_0_2_FN(0x3f)
+#define PSCI_0_2_FN64_LAST	PSCI_0_2_FN64(0x3f)
+
 /*
  * We need the KVM pointer independently from the vcpu as we can call
  * this from HYP, and need to apply kern_hyp_va on it...
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 06ba64c49737..aa831986a399 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1084,6 +1084,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
 #define KVM_CAP_PTP_KVM 198
 #define KVM_CAP_ARM_MP_HALTED 199
+#define KVM_CAP_ARM_HVC_TO_USER 200
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d6ad977fea5f..074197721e97 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -93,6 +93,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		r = 0;
 		kvm->arch.return_nisv_io_abort_to_user = true;
 		break;
+	case KVM_CAP_ARM_HVC_TO_USER:
+		r = 0;
+		kvm->arch.hvc_to_user = true;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -208,6 +212,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VCPU_ATTRIBUTES:
 	case KVM_CAP_PTP_KVM:
 	case KVM_CAP_ARM_MP_HALTED:
+	case KVM_CAP_ARM_HVC_TO_USER:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 30da78f72b3b..ccc2015eddf9 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -58,6 +58,28 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
 	val[3] = lower_32_bits(cycles);
 }
 
+static int kvm_hvc_user(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_run *run = vcpu->run;
+
+	if (!vcpu->kvm->arch.hvc_to_user) {
+		smccc_set_retval(vcpu, SMCCC_RET_NOT_SUPPORTED, 0, 0, 0);
+		return 1;
+	}
+
+	run->exit_reason = KVM_EXIT_HYPERCALL;
+	run->hypercall.nr = kvm_vcpu_hvc_get_imm(vcpu);
+	/* Copy the first parameters for fast access */
+	for (i = 0; i < 6; i++)
+		run->hypercall.args[i] = vcpu_get_reg(vcpu, i);
+	run->hypercall.ret = 0;
+	run->hypercall.longmode = 0;
+	run->hypercall.pad = 0;
+
+	return 0;
+}
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
@@ -139,8 +161,12 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	case ARM_SMCCC_TRNG_RND32:
 	case ARM_SMCCC_TRNG_RND64:
 		return kvm_trng_call(vcpu);
-	default:
+	case KVM_PSCI_FN_BASE...KVM_PSCI_FN_LAST:
+	case PSCI_0_2_FN_BASE...PSCI_0_2_FN_LAST:
+	case PSCI_0_2_FN64_BASE...PSCI_0_2_FN64_LAST:
 		return kvm_psci_call(vcpu);
+	default:
+		return kvm_hvc_user(vcpu);
 	}
 
 	smccc_set_retval(vcpu, val[0], val[1], val[2], val[3]);
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
