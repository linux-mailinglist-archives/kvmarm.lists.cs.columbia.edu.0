Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9E159758
	for <lists+kvmarm@lfdr.de>; Tue, 11 Feb 2020 18:55:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 82BBF4AF17;
	Tue, 11 Feb 2020 12:55:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iyd5ZmtWxKnG; Tue, 11 Feb 2020 12:55:26 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EF514AEE9;
	Tue, 11 Feb 2020 12:55:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E0E544AED3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 12:55:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3Fkg+ZeqQKx for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Feb 2020 12:55:23 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C25CD4AEE9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Feb 2020 12:55:23 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F3E31FB;
 Tue, 11 Feb 2020 09:55:23 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87ADA3F68E;
 Tue, 11 Feb 2020 09:55:22 -0800 (PST)
Subject: Re: [PATCH v5 2/3] KVM: arm64: limit PMU version to PMUv3 for ARMv8.1
To: Andrew Murray <andrew.murray@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <1580125469-23887-1-git-send-email-andrew.murray@arm.com>
 <1580125469-23887-3-git-send-email-andrew.murray@arm.com>
From: Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <7f5a1a45-34f0-596b-8a93-c77e35d0faaf@arm.com>
Date: Tue, 11 Feb 2020 17:55:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1580125469-23887-3-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 27/01/2020 11:44, Andrew Murray wrote:
> We currently expose the PMU version of the host to the guest via
> emulation of the DFR0_EL1 and AA64DFR0_EL1 debug feature registers.
> However many of the features offered beyond PMUv3 for 8.1 are not
> supported in KVM. Examples of this include support for the PMMIR
> registers (added in PMUv3 for ARMv8.4) and 64-bit event counters
> added in (PMUv3 for ARMv8.5).
> 
> Let's trap the Debug Feature Registers in order to limit
> PMUVer/PerfMon in the Debug Feature Registers to PMUv3 for ARMv8.1
> to avoid unexpected behaviour.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>   arch/arm64/include/asm/sysreg.h |  5 +++++
>   arch/arm64/kvm/sys_regs.c       | 11 +++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6e919fa..1009878 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -672,6 +672,11 @@
>   #define ID_AA64DFR0_TRACEVER_SHIFT	4
>   #define ID_AA64DFR0_DEBUGVER_SHIFT	0
>   
> +#define ID_DFR0_PERFMON_SHIFT		24
> +
> +#define ID_DFR0_EL1_PMUVER_8_1		4
> +#define ID_AA64DFR0_EL1_PMUVER_8_1	4
> +
>   #define ID_ISAR5_RDM_SHIFT		24
>   #define ID_ISAR5_CRC32_SHIFT		16
>   #define ID_ISAR5_SHA2_SHIFT		12
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 9f21659..3f0f3cc 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1085,6 +1085,17 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>   			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
>   			 (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
>   			 (0xfUL << ID_AA64ISAR1_GPI_SHIFT));
> +	} else if (id == SYS_ID_AA64DFR0_EL1) {
> +		/* Limit guests to PMUv3 for ARMv8.1 */
> +		val = cpuid_feature_cap_signed_field_width(val,
> +						ID_AA64DFR0_PMUVER_SHIFT,
> +						4, ID_AA64DFR0_EL1_PMUVER_8_1);
> +	} else if (id == SYS_ID_DFR0_EL1) {
> +		/* Limit guests to PMUv3 for ARMv8.1 */
> +		val = cpuid_feature_cap_signed_field_width(val,
> +						ID_DFR0_PERFMON_SHIFT,
> +						4, ID_DFR0_EL1_PMUVER_8_1);
> +
>   	}

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
