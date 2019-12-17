Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BC99D122E7C
	for <lists+kvmarm@lfdr.de>; Tue, 17 Dec 2019 15:21:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 536AD4A597;
	Tue, 17 Dec 2019 09:21:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJMqpLZQeroo; Tue, 17 Dec 2019 09:21:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 09B924A522;
	Tue, 17 Dec 2019 09:21:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD41C4A4F7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 09:21:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oi-bIKZrAQsd for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Dec 2019 09:21:46 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B0B24A36B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 09:21:46 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7E31FB;
 Tue, 17 Dec 2019 06:21:45 -0800 (PST)
Received: from arm.com (e112269-lin.cambridge.arm.com [10.1.196.56])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29473F719;
 Tue, 17 Dec 2019 06:21:43 -0800 (PST)
Date: Tue, 17 Dec 2019 14:21:39 +0000
From: Steven Price <steven.price@arm.com>
To: "yezengruan@huawei.com" <yezengruan@huawei.com>
Subject: Re: [PATCH 1/5] KVM: arm64: Document PV-lock interface
Message-ID: <20191217142138.GA38811@arm.com>
References: <20191217135549.3240-1-yezengruan@huawei.com>
 <20191217135549.3240-2-yezengruan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191217135549.3240-2-yezengruan@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Tue, Dec 17, 2019 at 01:55:45PM +0000, yezengruan@huawei.com wrote:
> From: Zengruan Ye <yezengruan@huawei.com>
> 
> Introduce a paravirtualization interface for KVM/arm64 to obtain the vcpu
> is currently running or not.
> 
> A hypercall interface is provided for the guest to interrogate the
> hypervisor's support for this interface and the location of the shared
> memory structures.
> 
> Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
> ---
>  Documentation/virt/kvm/arm/pvlock.rst | 31 +++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/virt/kvm/arm/pvlock.rst
> 
> diff --git a/Documentation/virt/kvm/arm/pvlock.rst b/Documentation/virt/kvm/arm/pvlock.rst
> new file mode 100644
> index 000000000000..eec0c36edf17
> --- /dev/null
> +++ b/Documentation/virt/kvm/arm/pvlock.rst
> @@ -0,0 +1,31 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Paravirtualized lock support for arm64
> +======================================
> +
> +KVM/arm64 provids some hypervisor service calls to support a paravirtualized
> +guest obtaining the vcpu is currently running or not.
> +
> +Two new SMCCC compatible hypercalls are defined:
> +
> +* PV_LOCK_FEATURES:   0xC5000040
> +* PV_LOCK_PREEMPTED:  0xC5000041

These values are in the "Standard Hypervisor Service Calls" section of
SMCCC - so is there a document that describes this features such that
other OSes or hypervisors can implement it? I'm also not entirely sure
of the process of ensuring that the IDs picked are non-conflicting.

Otherwise if this is a KVM specific interface this should probably
belong within the "Vendor Specific Hypervisor Service Calls" section
along with some probing that the hypervisor is actually KVM. Although I
don't see anything KVM specific.

> +
> +The existence of the PV_LOCK hypercall should be probed using the SMCCC 1.1
> +ARCH_FEATURES mechanism before calling it.
> +
> +PV_LOCK_FEATURES
> +    ============= ========    ==========
> +    Function ID:  (uint32)    0xC5000040
> +    PV_call_id:   (uint32)    The function to query for support.
> +    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the relevant
> +                              PV-lock feature is supported by the hypervisor.
> +    ============= ========    ==========
> +
> +PV_LOCK_PREEMPTED
> +    ============= ========    ==========
> +    Function ID:  (uint32)    0xC5000041
> +    Return value: (int64)     NOT_SUPPORTED (-1) or SUCCESS (0) if the IPA of
> +                              this vcpu's pv data structure is configured by
> +                              the hypervisor.
> +    ============= ========    ==========

From the code it looks like there's another argument for this SMC - the
physical address (or IPA) of a struct pvlock_vcpu_state. This structure
also needs to be described as it is part of the ABI.

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
