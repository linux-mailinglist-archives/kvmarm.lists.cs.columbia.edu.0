Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB014DCA5
	for <lists+kvmarm@lfdr.de>; Thu, 30 Jan 2020 15:15:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFE134A7E4;
	Thu, 30 Jan 2020 09:15:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2LNJMk88qhWe; Thu, 30 Jan 2020 09:15:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 702774A7FD;
	Thu, 30 Jan 2020 09:15:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE5674A551
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 09:15:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J-7sOtvwqZiG for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Jan 2020 09:15:04 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 92E124A542
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Jan 2020 09:15:04 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53C3420658;
 Thu, 30 Jan 2020 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580393703;
 bh=fLFS4MsI4Xqb1q1b9ZZYwHXmgmXnIzhWE8jaSJpBJnw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=zawswnw40D17Q1KUd03C6hPxIndcJI5s2TZeJo6VFYYy5ucA3alcao9/hf6EqGLYR
 PjJsxO5AE8c/e8qs94nzYRBolHmEkXUlAEotO/IWphwKKXx6bKdk6HpLEWoTBezxnH
 yQesQwLUpAVuVw5/aKKSdzdx/IoP/veeZ1lFuBy8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1ixAaz-002CVK-JM; Thu, 30 Jan 2020 14:15:01 +0000
MIME-Version: 1.0
Date: Thu, 30 Jan 2020 14:15:01 +0000
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH 23/23] KVM: arm64: Treat emulated TVAL TimerValue as a
 signed 32-bit integer
In-Reply-To: <aec2c75e-24d0-8157-14bd-72883a9df6bf@arm.com>
References: <20200130132558.10201-1-maz@kernel.org>
 <20200130132558.10201-24-maz@kernel.org>
 <aec2c75e-24d0-8157-14bd-72883a9df6bf@arm.com>
Message-ID: <6898d36c8453756418924bf4718219fd@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, pbonzini@redhat.com,
 drjones@redhat.com, andrew.murray@arm.com, beata.michalska@linaro.org,
 christoffer.dall@arm.com, eric.auger@redhat.com, gshan@redhat.com,
 wanghaibin.wang@huawei.com, james.morse@arm.com, broonie@kernel.org,
 mark.rutland@arm.com, rmk+kernel@armlinux.org.uk,
 shannon.zhao@linux.alibaba.com, steven.price@arm.com, will@kernel.org,
 yuehaibing@huawei.com, yuzenghui@huawei.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Gavin Shan <gshan@redhat.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 YueHaibing <yuehaibing@huawei.com>, Steven Price <steven.price@arm.com>,
 Shannon Zhao <shannon.zhao@linux.alibaba.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Mark Brown <broonie@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Andrew Murray <andrew.murray@arm.com>
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

On 2020-01-30 14:11, Alexandru Elisei wrote:
> Hi,
> 
> On 1/30/20 1:25 PM, Marc Zyngier wrote:
>> From: Alexandru Elisei <alexandru.elisei@arm.com>
>> 
>> According to the ARM ARM, registers CNT{P,V}_TVAL_EL0 have bits 
>> [63:32]
>> RES0 [1]. When reading the register, the value is truncated to the 
>> least
>> significant 32 bits [2], and on writes, TimerValue is treated as a 
>> signed
>> 32-bit integer [1, 2].
>> 
>> When the guest behaves correctly and writes 32-bit values, treating 
>> TVAL
>> as an unsigned 64 bit register works as expected. However, things 
>> start
>> to break down when the guest writes larger values, because
>> (u64)0x1_ffff_ffff = 8589934591. but (s32)0x1_ffff_ffff = -1, and the
>> former will cause the timer interrupt to be asserted in the future, 
>> but
>> the latter will cause it to be asserted now.  Let's treat TVAL as a
>> signed 32-bit register on writes, to match the behaviour described in
>> the architecture, and the behaviour experimentally exhibited by the
>> virtual timer on a non-vhe host.
>> 
>> [1] Arm DDI 0487E.a, section D13.8.18
>> [2] Arm DDI 0487E.a, section D11.2.4
>> 
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> [maz: replaced the read-side mask with lower_32_bits]
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Fixes: 8fa761624871 ("KVM: arm/arm64: arch_timer: Fix CNTP_TVAL 
>> calculation")
>> Link: 
>> https://lore.kernel.org/r/20200127103652.2326-1-alexandru.elisei@arm.com
>> ---
>>  virt/kvm/arm/arch_timer.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
>> index f182b2380345..c6c2a9dde00c 100644
>> --- a/virt/kvm/arm/arch_timer.c
>> +++ b/virt/kvm/arm/arch_timer.c
>> @@ -805,6 +805,7 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu 
>> *vcpu,
>>  	switch (treg) {
>>  	case TIMER_REG_TVAL:
>>  		val = timer->cnt_cval - kvm_phys_timer_read() + timer->cntvoff;
>> +		val &= lower_32_bits(val);
> 
> This is correct, but how about making it val = lower_32_bits(val) for 
> more
> clarity? Apologies for not spotting it earlier :(

That's what it should have been, but I obviously typoed it. As it passed
all my tests, I didn't notice the issue. I'll queue a cleanup once Paolo
has a chance to pull this.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
