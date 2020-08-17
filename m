Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 44AD4246071
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 10:41:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E53E94BF94;
	Mon, 17 Aug 2020 04:41:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IlE4tGi7UaNv; Mon, 17 Aug 2020 04:41:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4819D4BF6E;
	Mon, 17 Aug 2020 04:41:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EEE524BF6A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 04:41:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2HrbMNobHjwC for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 04:41:26 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EBFF14BF65
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 04:41:25 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8E9C953B776B2C53A1D1;
 Mon, 17 Aug 2020 16:41:22 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.22) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 16:41:12 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>
Subject: [RFC PATCH 1/5] KVM: arm64: Document pvtime LPT interface
Date: Mon, 17 Aug 2020 16:41:06 +0800
Message-ID: <20200817084110.2672-2-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20200817084110.2672-1-zhukeqian1@huawei.com>
References: <20200817084110.2672-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
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

The "Arm Paravirtualized Time for Arm-Base Systems" specification
DEN 0057A just contains "Stolen Time" now, as the details of "Live
Physical Time" have not been fully agreed.

This introduces a new LPT structure with more understandable fields,
as scale_mult and rscale_mult are symmetrical.

Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 Documentation/virt/kvm/arm/pvtime.rst | 78 ++++++++++++++++++++++++++++++-----
 Documentation/virt/kvm/devices/vm.rst | 30 ++++++++++++++
 2 files changed, 97 insertions(+), 11 deletions(-)

diff --git a/Documentation/virt/kvm/arm/pvtime.rst b/Documentation/virt/kvm/arm/pvtime.rst
index 94bffe2..fd11915 100644
--- a/Documentation/virt/kvm/arm/pvtime.rst
+++ b/Documentation/virt/kvm/arm/pvtime.rst
@@ -8,14 +8,17 @@ support for AArch64 guests:
 
 https://developer.arm.com/docs/den0057/a
 
-KVM/arm64 implements the stolen time part of this specification by providing
-some hypervisor service calls to support a paravirtualized guest obtaining a
-view of the amount of time stolen from its execution.
+KVM/arm64 implements the stolen time and live physical time (LPT) parts of this
+specification by providing some hypervisor service calls to a paravirtualized
+guest. With stolen time support, guest can obtain the amount of time stolen
+from its execution. LPT represents time during which the guest is running and
+it realizes cross-native-frequency migrations.
 
-Two new SMCCC compatible hypercalls are defined:
+Three new SMCCC compatible hypercalls are defined:
 
 * PV_TIME_FEATURES: 0xC5000020
 * PV_TIME_ST:       0xC5000021
+* PV_TIME_LPT:      0xC5000022
 
 These are only available in the SMC64/HVC64 calling convention as
 paravirtualized time is not available to 32 bit Arm guests. The existence of
@@ -26,7 +29,8 @@ PV_TIME_FEATURES
     ============= ========    ==========
     Function ID:  (uint32)    0xC5000020
     PV_call_id:   (uint32)    The function to query for support.
-                              Currently only PV_TIME_ST is supported.
+                              Currently only PV_TIME_ST and PV_TIME_LPT are
+                              supported.
     Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the relevant
                               PV-time feature is supported by the hypervisor.
     ============= ========    ==========
@@ -39,17 +43,23 @@ PV_TIME_ST
                               NOT_SUPPORTED (-1)
     ============= ========    ==========
 
-The IPA returned by PV_TIME_ST should be mapped by the guest as normal memory
-with inner and outer write back caching attributes, in the inner shareable
-domain. A total of 16 bytes from the IPA returned are guaranteed to be
-meaningfully filled by the hypervisor (see structure below).
+PV_TIME_LPT
+    ============= ========    ==========
+    Function ID:  (uint32)    0xC5000022
+    Return value: (int64)     IPA of the LPT data structure for this guest.
+                              On failure:
+                              NOT_SUPPORTED (-1)
+    ============= ========    ==========
 
-PV_TIME_ST returns the structure for the calling VCPU.
+The IPA returned by PV_TIME_ST and PV_TIME_LPT should be mapped by the guest as
+normal memory with inner and outer write back caching attributes, in the inner
+shareable domain.
 
 Stolen Time
 -----------
 
-The structure pointed to by the PV_TIME_ST hypercall is as follows:
+A total of 16 bytes from the IPA returned are guaranteed to be meaningfully
+filled by the hypervisor. The structure description is as follows:
 
 +-------------+-------------+-------------+----------------------------+
 | Field       | Byte Length | Byte Offset | Description                |
@@ -78,3 +88,49 @@ the region using 64k pages and avoids conflicting attributes with other memory.
 
 For the user space interface see Documentation/virt/kvm/devices/vcpu.rst
 section "3. GROUP: KVM_ARM_VCPU_PVTIME_CTRL".
+
+Live Physical Time
+-----------
+
+A total of 48 bytes from the IPA returned are guaranteed to be meaningfully
+filled by the hypervisor. The structure description is as follows:
+
++-----------------+-------------+-------------+----------------------------+
+| Field           | Byte Length | Byte Offset | Description                |
++=================+=============+=============+============================+
+| Revision        |      4      |      0      | Must be 0 for version 1.0  |
++-----------------+-------------+-------------+----------------------------+
+| Attributes      |      4      |      4      | Must be 0                  |
++-----------------+-------------+-------------+----------------------------+
+| sequence_number |      8      |      8      | Bit 0: reserved            |
+|                 |             |             | Bits 1-63: number of runs, |
+|                 |             |             | including the initial run. |
++-----------------+-------------+-------------+----------------------------|
+| native_freq     |      4      |      16     | Native frequency           |
++-----------------+-------------+-------------+----------------------------|
+| pv_freq         |      4      |      20     | Paravirtualized frequency  |
+|                 |             |             | seen by guest              |
++-----------------+-------------+-------------+----------------------------|
+| scale_mult      |      8      |      24     | Multiplier to scale native |
+|                 |             |             | cycles to PV cycles        |
++-----------------+-------------+-------------+----------------------------|
+| rscale_mult     |      8      |      32     | Multiplier to reversely    |
+|                 |             |             | scale PV cycles to native  |
+|                 |             |             | cycles                     |
++-----------------+-------------+-------------+----------------------------|
+| fracbits        |      4      |      40     | The bits of fraction of    |
+|                 |             |             | scale_mult                 |
++-----------------+-------------+-------------+----------------------------|
+| rfracbits       |      4      |      44     | The bits of fraction of    |
+|                 |             |             | rscale_mult                |
++-----------------+-------------+-------------+----------------------------|
+
+All values in the structure are stored little-endian.
+
+The structure will be updated by the hypervisor prior to scheduling VCPUs. It
+will be present within a reserved region of the normal memory given to the
+guest. The guest should not attempt to write into this memory. There is a
+structure per guest.
+
+For the user space interface see Documentation/virt/kvm/devices/vm.rst
+section "6. GROUP: KVM_ARM_VM_PVTIME_LPT_CTRL".
diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/kvm/devices/vm.rst
index 0aa5b1c..7e5a189 100644
--- a/Documentation/virt/kvm/devices/vm.rst
+++ b/Documentation/virt/kvm/devices/vm.rst
@@ -314,3 +314,33 @@ Allows userspace to query the status of migration mode.
 	     if it is enabled
 :Returns:   -EFAULT if the given address is not accessible from kernel space;
 	    0 in case of success.
+
+6. GROUP: KVM_ARM_VM_PVTIME_LPT_CTRL
+====================================
+
+:Architectures: ARM64
+
+6.1. ATTRIBUTE: KVM_ARM_VM_PVTIME_LPT_IPA (r/w)
+-----------------------------------------------
+
+Specifies the base address of the live physical time (LPT) structure for this
+guest. The base address must be 64 byte aligned and exist within a valid guest
+memory region. See Documentation/virt/kvm/arm/pvtime.rst for more information
+including the layout of the LPT structure.
+
+Parameters: 64-bit base address
+Returns: -ENXIO:  LPT not implemented
+         -EEXIST: Base address already set for this guest
+         -EINVAL: Base address not 64 byte aligned or not within guest memory
+
+6.2. ATTRIBUTE: KVM_ARM_VM_PVTIME_LPT_FREQ (r/w)
+------------------------------------------------
+
+Specifies the paravirtualized (PV) frequency for this guest. The PV frequency
+is independent with native frequency, so we can support cross-native-frequency
+migration.
+
+Parameters: 32-bit PV frequency
+Returns: -ENXIO:  LPT not implemented
+         -EEXIST: PV frequency already set for this guest
+         -EINVAL: PV frequency is zero
-- 
1.8.3.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
