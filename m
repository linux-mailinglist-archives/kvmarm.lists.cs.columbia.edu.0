Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECF6190E4
	for <lists+kvmarm@lfdr.de>; Fri,  4 Nov 2022 07:21:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D6884B17C;
	Fri,  4 Nov 2022 02:21:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered)
	header.i=@bytedance-com.20210112.gappssmtp.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dRqXRcJfRQWZ; Fri,  4 Nov 2022 02:21:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1938B4A1D9;
	Fri,  4 Nov 2022 02:21:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4C4234141A
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 02:21:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U65PI2fhzGfS for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Nov 2022 02:21:15 -0400 (EDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EC3BB40EEF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 02:21:14 -0400 (EDT)
Received: by mail-wm1-f52.google.com with SMTP id o30so2442327wms.2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 03 Nov 2022 23:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+P9DG6QFhAnrOXoRpSt5bSP55OOBU13jcpINyqc0uW4=;
 b=Ri+1S0e1L8wR/k+sgSC3uVmm/tUuTVO/vcxTrFJcwPc/DgGZkgtw9SfiTV62RnMAte
 0GlfuF2GyrPePjKsc4z5DMKRClwioWoXE7YK6/lJQD7HLtlu1cPTe2xemwlUAAoDo0Uj
 cB2agqqaa5wsJ4KS6aWA/LM0cyWpHVSqPeGd1fpck4/NzoEdFtVspvAz6n4952kzJ/wL
 I4LAIHNotpJ6gH2g0K50E0rWNvPobqIl74YK80MhU1cAzuD5EIdPizFTy2IjdJky8Dad
 YnnPxyz1FuztA0ntaaK/8ZLmo7ny0Cm4j1WTUSw3sxDV7ZzRnP9m0AyeJt/rFcnwb8jM
 rnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+P9DG6QFhAnrOXoRpSt5bSP55OOBU13jcpINyqc0uW4=;
 b=FHDtuFr5AlwyEvIyotTO4FpJgyUpH2e4GtOHsaePPrP9NhUrUdeY+KeuF3grORQN61
 C5WzlAJQ+Cgap74xNek/Cyw4PUqlQnxXTmxGvL37VCQtMccAcIuCvHDTIomPXwDKRvL4
 w9K1spNu4h1EWYtle+R/RVj1ZwS/90XVlTMBoCXQfSL9jxfJSWQwMxJ4i4Th8HW+Zl7U
 Afh6v6K36kTdrS0iKh9OzbXa5DlaNYMd0OFsWfv47BGlEujnQ59N/tKAuamFSP4m/Nqa
 oRP0v4i1F9pO7213Pg2s8xGkHlT/CVK4eTNh0nBlNziHQ0V/AWLeCGfnl2n2OAXtPMh9
 oI0g==
X-Gm-Message-State: ACrzQf3N4rTFhfucPebciGjLgJTZuLIBZD2Bixw0vWz6f693yJSuXBH2
 e0IlqYg23gP7Vf/7yBSbuo89mA==
X-Google-Smtp-Source: AMsMyM7Cuzpepx2RjYfMrH6Nvy2wqrtLqP1UNktD+UgfCKijIH3Gapovhurrp8aBdfaMPE5SiufMfQ==
X-Received: by 2002:a05:600c:54ca:b0:3cf:8e5d:7146 with SMTP id
 iw10-20020a05600c54ca00b003cf8e5d7146mr4387357wmb.191.1667542874039; 
 Thu, 03 Nov 2022 23:21:14 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk
 ([2a02:6b6a:b4d7:0:c7c:f931:dd4c:1ea6])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a5d608b000000b002366f9bd717sm3099924wrt.45.2022.11.03.23.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Nov 2022 23:21:13 -0700 (PDT)
From: Usama Arif <usama.arif@bytedance.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux@armlinux.org.uk, yezengruan@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, maz@kernel.org, steven.price@arm.com,
 mark.rutland@arm.com, bagasdotme@gmail.com
Subject: [v2 1/6] KVM: arm64: Document PV-lock interface
Date: Fri,  4 Nov 2022 06:21:00 +0000
Message-Id: <20221104062105.4119003-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221104062105.4119003-1-usama.arif@bytedance.com>
References: <20221104062105.4119003-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Cc: punit.agrawal@bytedance.com, fam.zheng@bytedance.com, liangma@liangbit.com,
 Usama Arif <usama.arif@bytedance.com>
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

Introduce a paravirtualization interface for KVM/arm64 to obtain whether
the VCPU is currently running or not.

The PV lock structure of the guest is allocated by user space.

A hypercall interface is provided for the guest to interrogate the
location of the shared memory structures.

Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 Documentation/virt/kvm/arm/index.rst    |  1 +
 Documentation/virt/kvm/arm/pvlock.rst   | 52 +++++++++++++++++++++++++
 Documentation/virt/kvm/devices/vcpu.rst | 25 ++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 Documentation/virt/kvm/arm/pvlock.rst

diff --git a/Documentation/virt/kvm/arm/index.rst b/Documentation/virt/kvm/arm/index.rst
index e84848432158..b8499dc00a6a 100644
--- a/Documentation/virt/kvm/arm/index.rst
+++ b/Documentation/virt/kvm/arm/index.rst
@@ -10,4 +10,5 @@ ARM
    hyp-abi
    hypercalls
    pvtime
+   pvlock
    ptp_kvm
diff --git a/Documentation/virt/kvm/arm/pvlock.rst b/Documentation/virt/kvm/arm/pvlock.rst
new file mode 100644
index 000000000000..d3c391b16d36
--- /dev/null
+++ b/Documentation/virt/kvm/arm/pvlock.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Paravirtualized lock support for arm64
+======================================
+
+KVM/arm64 provides a hypervisor service call for paravirtualized guests to
+determine whether a VCPU is currently running or not.
+
+A new SMCCC compatible hypercall is defined:
+
+* ARM_SMCCC_VENDOR_HYP_KVM_PV_LOCK_FUNC_ID:   0xC6000002
+
+ARM_SMCCC_VENDOR_HYP_KVM_PV_LOCK_FUNC_ID
+
+    ============= ========    ==========================================
+    Function ID:  (uint32)    0xC6000002
+    Return value: (int64)     IPA of the pv lock data structure for this
+                              VCPU. On failure:
+                              NOT_SUPPORTED (-1)
+    ============= ========    ==========================================
+
+The IPA returned by PV_LOCK_PREEMPTED should be mapped by the guest as normal
+memory with inner and outer write back caching attributes, in the inner
+shareable domain.
+
+PV_LOCK_PREEMPTED returns the structure for the calling VCPU.
+
+PV lock state
+-------------
+
+The structure pointed to by the PV_LOCK_PREEMPTED hypercall is as follows:
+
++-----------+-------------+-------------+---------------------------------+
+| Field     | Byte Length | Byte Offset | Description                     |
++===========+=============+=============+=================================+
+| preempted |      8      |      0      | Indicate if the VCPU that owns  |
+|           |             |             | this struct is running or not.  |
+|           |             |             | Non-zero values mean the VCPU   |
+|           |             |             | has been preempted. Zero means  |
+|           |             |             | the VCPU is not preempted.      |
++-----------+-------------+-------------+---------------------------------+
+
+The preempted field will be updated to 1 by the hypervisor prior to scheduling
+a VCPU. When the VCPU is scheduled out, the preempted field will be updated
+to 0 by the hypervisor.
+
+The structure will be present within a reserved region of the normal memory
+given to the guest. The guest should not attempt to write into this memory.
+There is a structure per VCPU of the guest.
+
+For the user space interface see
+:ref:`Documentation/virt/kvm/devices/vcpu.rst <kvm_arm_vcpu_pvlock_ctrl>`.
\ No newline at end of file
diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 716aa3edae14..ea81b98f0e19 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -263,3 +263,28 @@ From the destination VMM process:
 
 7. Write the KVM_VCPU_TSC_OFFSET attribute for every vCPU with the
    respective value derived in the previous step.
+
+.. _kvm_arm_vcpu_pvlock_ctrl:
+
+5. GROUP: KVM_ARM_VCPU_PVLOCK_CTRL
+==================================
+
+:Architectures: ARM64
+
+5.1 ATTRIBUTE: KVM_ARM_VCPU_PVLOCK_IPA
+--------------------------------------
+
+:Parameters: 64-bit base address
+
+Returns:
+
+	 =======  ======================================
+	 -ENXIO   PV lock not implemented
+	 -EEXIST  Base address already set for this VCPU
+	 -EINVAL  Base address not 64 byte aligned
+	 =======  ======================================
+
+Specifies the base address of the pv lock structure for this VCPU. The
+base address must be 64 byte aligned and exist within a valid guest memory
+region. See Documentation/virt/kvm/arm/pvlock.rst for more information
+including the layout of the pv lock structure.
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
