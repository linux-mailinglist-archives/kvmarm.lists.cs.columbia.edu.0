Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D6B1E4848DD
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jan 2022 20:49:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 864494A10E;
	Tue,  4 Jan 2022 14:49:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmV7GAWGKdnh; Tue,  4 Jan 2022 14:49:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 490554AC78;
	Tue,  4 Jan 2022 14:49:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BE49F4A4BE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jan 2022 14:49:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEBX-Z2q3Hp5 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jan 2022 14:49:47 -0500 (EST)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EFD064B0DE
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jan 2022 14:49:45 -0500 (EST)
Received: by mail-pg1-f202.google.com with SMTP id
 j186-20020a636ec3000000b00340c5f3a0cbso20345471pgc.0
 for <kvmarm@lists.cs.columbia.edu>; Tue, 04 Jan 2022 11:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=qxftiJcdUZf4HiiTODBdErN1n11tZbdt+QJMuZxMAlI=;
 b=YkMmDRAAFDDPYGNhhIRDFxfkKYpuGqlN9D9sXGCZAE11WaqNM+IHCUuRiJ1hcF0tbu
 kVdUhM5Pu78t+NphyqjAEVKSsUJrryu1NiffqPFbdsvlVlK/ZAsjpM/LPSHlep6jnwNk
 HBrkosSfU8q5DxVJ0BWrjd+CVT57/vrcZwcUawB2hLgRbhpI3khcYZS5a6qrbPqjHCUK
 6zGs/PKX6JAaVyzxfcyCjJq1DE74ndzj4mqyR2IlZKmmZBTUfN56qCGgCrhAqv5ndfRi
 /U17VXZV1C0FXOiLtd8atkyhIQ/b4gG2Iy7z3tsyMeciRdJcKctKOHcBLD/to2jml0B4
 R4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=qxftiJcdUZf4HiiTODBdErN1n11tZbdt+QJMuZxMAlI=;
 b=KOPOSzNRFoI8LLqkoRsQmCRttXol8TfwqqQj51pClj+9vRf/CiuvsMxro3EoU9y8qi
 gTuzOtxm8bPqJqlAITzLSRMS3Zj6zQ49QVoQ1ntjGi+rx6Mu7jZZpFbBQ1m64JpOZfzp
 CH/STNK6OCMEZRaqOv1DUihPhar/a1MTlF/3Nd2K5nvullH1YR63TrsEycBOItlUaozg
 vzFqY4crEKGI6Wx1falqSss0LFS+B/+E+nmIp1Hk25SuXtB753kOLXj480p+0oeM3GN8
 LgeCkIhkZ3pa0gB8FS8YFW6v/7XSjcIILGCyiNTF5Jfp2w6c+IP5rKp+EqXUqH/0M6WR
 NPFQ==
X-Gm-Message-State: AOAM531N5XP5E+rTnmu3p70yb1K8248dv3eI7dZMsnDuIn7Y5jUPUAvr
 KEEbDlbGvtjXPprOv3JmiseVsRJLlGvt
X-Google-Smtp-Source: ABdhPJwtINulE60i0V/8q8hHi+gLB5QjLyb+pcgORysvbdogsBEYosGxGWehe//E5ULxvhq2CdSQ/dNbyMu6
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6a00:1485:b0:4bb:317a:a909 with SMTP
 id v5-20020a056a00148500b004bb317aa909mr52783212pfu.29.1641325785228; Tue, 04
 Jan 2022 11:49:45 -0800 (PST)
Date: Tue,  4 Jan 2022 19:49:14 +0000
In-Reply-To: <20220104194918.373612-1-rananta@google.com>
Message-Id: <20220104194918.373612-8-rananta@google.com>
Mime-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [RFC PATCH v3 07/11] Docs: KVM: Add doc for the bitmap firmware
 registers
From: Raghavendra Rao Ananta <rananta@google.com>
To: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>, 
 James Morse <james.morse@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Add the documentation for the bitmap firmware registers in
psci.rst. This includes the details for KVM_REG_ARM_STD_BMAP,
KVM_REG_ARM_STD_HYP_BMAP, and KVM_REG_ARM_VENDOR_HYP_BMAP
registers.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 Documentation/virt/kvm/arm/psci.rst | 85 +++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 17 deletions(-)

diff --git a/Documentation/virt/kvm/arm/psci.rst b/Documentation/virt/kvm/arm/psci.rst
index d52c2e83b5b8..edc3caf927ae 100644
--- a/Documentation/virt/kvm/arm/psci.rst
+++ b/Documentation/virt/kvm/arm/psci.rst
@@ -1,32 +1,32 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=========================================
-Power State Coordination Interface (PSCI)
-=========================================
+=======================
+ARM Hypercall Interface
+=======================
 
-KVM implements the PSCI (Power State Coordination Interface)
-specification in order to provide services such as CPU on/off, reset
-and power-off to the guest.
+KVM handles the hypercall services as requested by the guests. New hypercall
+services are regularly made available by the ARM specification or by KVM (as
+vendor services) if they make sense from a virtualization point of view.
 
-The PSCI specification is regularly updated to provide new features,
-and KVM implements these updates if they make sense from a virtualization
-point of view.
-
-This means that a guest booted on two different versions of KVM can
-observe two different "firmware" revisions. This could cause issues if
-a given guest is tied to a particular PSCI revision (unlikely), or if
-a migration causes a different PSCI version to be exposed out of the
-blue to an unsuspecting guest.
+This means that a guest booted on two different versions of KVM can observe
+two different "firmware" revisions. This could cause issues if a given guest
+is tied to a particular version of a hypercall service, or if a migration
+causes a different version to be exposed out of the blue to an unsuspecting
+guest.
 
 In order to remedy this situation, KVM exposes a set of "firmware
 pseudo-registers" that can be manipulated using the GET/SET_ONE_REG
 interface. These registers can be saved/restored by userspace, and set
 to a convenient value if required.
 
-The following register is defined:
+The following registers are defined:
 
 * KVM_REG_ARM_PSCI_VERSION:
 
+  KVM implements the PSCI (Power State Coordination Interface)
+  specification in order to provide services such as CPU on/off, reset
+  and power-off to the guest.
+
   - Only valid if the vcpu has the KVM_ARM_VCPU_PSCI_0_2 feature set
     (and thus has already been initialized)
   - Returns the current PSCI version on GET_ONE_REG (defaulting to the
@@ -74,4 +74,55 @@ The following register is defined:
     KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED:
       The workaround is always active on this vCPU or it is not needed.
 
-.. [1] https://developer.arm.com/-/media/developer/pdf/ARM_DEN_0070A_Firmware_interfaces_for_mitigating_CVE-2017-5715.pdf
+Contrary to the above registers, the following registers exposes the hypercall
+services in the form of a feature-bitmap. This bitmap is translated to the
+services that are exposed to the guest. There is a register defined per service
+call owner and can be accessed via GET/SET_ONE_REG interface.
+
+A new KVM capability, KVM_CAP_ARM_HVC_FW_REG_BMAP, is introduced to let
+user-space know of this extension. A simple 'read' of the capability would
+return the number of bitmapped registers. The user-space is expected to
+make a not of this value and configure each of the register.
+
+By default, these registers are set with the upper limit of the features that
+are supported. User-space can discover this configuration via GET_ONE_REG. If
+unsatisfied, the user-space can write back the desired bitmap back via
+SET_ONE_REG.
+
+The psuedo-firmware bitmap register are as follows:
+
+* KVM_REG_ARM_STD_BMAP:
+    Controls the bitmap of the ARM Standard Secure Service Calls.
+
+  The following bits are accepted:
+
+    KVM_REG_ARM_STD_BIT_TRNG_V1_0:
+      The bit represents the services offered under v1.0 of ARM True Random
+      Number Generator (TRNG) specification, ARM DEN0098.
+
+* KVM_REG_ARM_STD_HYP_BMAP:
+    Controls the bitmap of the ARM Standard Hypervisor Service Calls.
+
+  The following bits are accepted:
+
+    KVM_REG_ARM_STD_HYP_BIT_PV_TIME:
+      The bit represents the Paravirtualized Time service as represented by
+      ARM DEN0057A.
+
+* KVM_REG_ARM_VENDOR_HYP_BMAP:
+    Controls the bitmap of the Vendor specific Hypervisor Service Calls.
+
+  The following bits are accepted:
+
+    KVM_REG_ARM_VENDOR_HYP_BIT_PTP:
+      The bit represents the Precision Time Protocol KVM service.
+
+Errors:
+
+    =======  =============================================================
+    -ENOENT   Unknown register accessed.
+    -EBUSY    Attempt a 'write' to the register after the VM has started.
+    -EINVAL   Invalid bitmap written to the register.
+    =======  =============================================================
+
+.. [1] https://developer.arm.com/-/media/developer/pdf/ARM_DEN_0070A_Firmware_interfaces_for_mitigating_CVE-2017-5715.pdf
\ No newline at end of file
-- 
2.34.1.448.ga2b2bfdf31-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
