Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFA304567
	for <lists+kvmarm@lfdr.de>; Tue, 26 Jan 2021 18:35:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E1BDC4B372;
	Tue, 26 Jan 2021 12:35:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2SNiqZjMlr1s; Tue, 26 Jan 2021 12:35:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F18A4B368;
	Tue, 26 Jan 2021 12:35:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E43A04B360
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Jan 2021 12:35:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0nkfwhOfUmoJ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 Jan 2021 12:35:54 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8F144B138
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Jan 2021 12:35:54 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 475E731B;
 Tue, 26 Jan 2021 09:35:54 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9A53F66E;
 Tue, 26 Jan 2021 09:35:52 -0800 (PST)
Subject: Re: [PATCH v2 2/7] KVM: arm64: Fix AArch32 PMUv3 capping
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20210125122638.2947058-1-maz@kernel.org>
 <20210125122638.2947058-3-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <72a3faa2-e33a-8803-70ee-822afb2f1657@arm.com>
Date: Tue, 26 Jan 2021 17:35:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125122638.2947058-3-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com
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

Hi Marc,

This matches what we do for ID_AA64DFR0_EL1:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

On 1/25/21 12:26 PM, Marc Zyngier wrote:
> We shouldn't expose *any* PMU capability when no PMU has been
> configured for this VM.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 0c0832472c4a..ce08d28ab15c 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1048,8 +1048,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  	} else if (id == SYS_ID_DFR0_EL1) {
>  		/* Limit guests to PMUv3 for ARMv8.1 */
>  		val = cpuid_feature_cap_perfmon_field(val,
> -						ID_DFR0_PERFMON_SHIFT,
> -						ID_DFR0_PERFMON_8_1);
> +						      ID_DFR0_PERFMON_SHIFT,
> +						      kvm_vcpu_has_pmu(vcpu) ? ID_DFR0_PERFMON_8_1 : 0);
>  	}
>  
>  	return val;
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
