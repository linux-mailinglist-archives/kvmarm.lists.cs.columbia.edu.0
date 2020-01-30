Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C324614DC95
	for <lists+kvmarm@lfdr.de>; Thu, 30 Jan 2020 15:12:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F3044A800;
	Thu, 30 Jan 2020 09:12:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level: 
X-Spam-Status: No, score=0.099 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LaktMDi+-TqO; Thu, 30 Jan 2020 09:12:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AF7F4A7E4;
	Thu, 30 Jan 2020 09:12:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B445B4A59B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 09:12:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8m8mS3kcVZ8I for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Jan 2020 09:12:00 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D1574A3A5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 09:12:00 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6FF91FB;
 Thu, 30 Jan 2020 06:11:59 -0800 (PST)
Received: from [10.1.36.201] (e121566-lin.cambridge.arm.com [10.1.36.201])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF61F3F68E;
 Thu, 30 Jan 2020 06:11:54 -0800 (PST)
Subject: Re: [PATCH 23/23] KVM: arm64: Treat emulated TVAL TimerValue as a
 signed 32-bit integer
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200130132558.10201-1-maz@kernel.org>
 <20200130132558.10201-24-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <aec2c75e-24d0-8157-14bd-72883a9df6bf@arm.com>
Date: Thu, 30 Jan 2020 14:11:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130132558.10201-24-maz@kernel.org>
Content-Language: en-US
Cc: Gavin Shan <gshan@redhat.com>, kvm@vger.kernel.org,
 YueHaibing <yuehaibing@huawei.com>, Steven Price <steven.price@arm.com>,
 Shannon Zhao <shannon.zhao@linux.alibaba.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Andrew Murray <andrew.murray@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

Hi,

On 1/30/20 1:25 PM, Marc Zyngier wrote:
> From: Alexandru Elisei <alexandru.elisei@arm.com>
>
> According to the ARM ARM, registers CNT{P,V}_TVAL_EL0 have bits [63:32]
> RES0 [1]. When reading the register, the value is truncated to the least
> significant 32 bits [2], and on writes, TimerValue is treated as a signed
> 32-bit integer [1, 2].
>
> When the guest behaves correctly and writes 32-bit values, treating TVAL
> as an unsigned 64 bit register works as expected. However, things start
> to break down when the guest writes larger values, because
> (u64)0x1_ffff_ffff = 8589934591. but (s32)0x1_ffff_ffff = -1, and the
> former will cause the timer interrupt to be asserted in the future, but
> the latter will cause it to be asserted now.  Let's treat TVAL as a
> signed 32-bit register on writes, to match the behaviour described in
> the architecture, and the behaviour experimentally exhibited by the
> virtual timer on a non-vhe host.
>
> [1] Arm DDI 0487E.a, section D13.8.18
> [2] Arm DDI 0487E.a, section D11.2.4
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> [maz: replaced the read-side mask with lower_32_bits]
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Fixes: 8fa761624871 ("KVM: arm/arm64: arch_timer: Fix CNTP_TVAL calculation")
> Link: https://lore.kernel.org/r/20200127103652.2326-1-alexandru.elisei@arm.com
> ---
>  virt/kvm/arm/arch_timer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index f182b2380345..c6c2a9dde00c 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -805,6 +805,7 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>  	switch (treg) {
>  	case TIMER_REG_TVAL:
>  		val = timer->cnt_cval - kvm_phys_timer_read() + timer->cntvoff;
> +		val &= lower_32_bits(val);

This is correct, but how about making it val = lower_32_bits(val) for more
clarity? Apologies for not spotting it earlier :(

Thanks,
Alex
>  		break;
>  
>  	case TIMER_REG_CTL:
> @@ -850,7 +851,7 @@ static void kvm_arm_timer_write(struct kvm_vcpu *vcpu,
>  {
>  	switch (treg) {
>  	case TIMER_REG_TVAL:
> -		timer->cnt_cval = kvm_phys_timer_read() - timer->cntvoff + val;
> +		timer->cnt_cval = kvm_phys_timer_read() - timer->cntvoff + (s32)val;
>  		break;
>  
>  	case TIMER_REG_CTL:
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
