Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 580AC260F4E
	for <lists+kvmarm@lfdr.de>; Tue,  8 Sep 2020 12:09:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EAF514B567;
	Tue,  8 Sep 2020 06:09:39 -0400 (EDT)
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
	with ESMTP id vSBGBv2BiiaW; Tue,  8 Sep 2020 06:09:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E23984B561;
	Tue,  8 Sep 2020 06:09:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8572C4B43C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 06:09:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fxCHpaLoPauN for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Sep 2020 06:09:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4A23B4B42F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 06:09:36 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 52E4D2078B;
 Tue,  8 Sep 2020 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599559773;
 bh=mq78I3lg4rqaeKV6Rpy3lOwu/7yLhiG0/8O0/Th1bIk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AVP+wVAPhSvXy5kGi8uDreJPEUQDCXDzf6IT3hZw4tA6V9lIf9P2jQ+Op+F+klbcU
 Ey7rpPT8Iy1EY91cw7VsPRFGEZTHfYgpfTAu4bwHkUYoPbRHSXPSKOlKtWQrJqzJGB
 11SvoKVg834c/QunEM0phK+5gDUOU1CZP1adEX8s=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kFaZ9-00A1XD-FM; Tue, 08 Sep 2020 11:09:31 +0100
MIME-Version: 1.0
Date: Tue, 08 Sep 2020 11:09:31 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v3 1/5] KVM: arm64: Refactor PMU attribute error handling
In-Reply-To: <20200908095318.nzbnadvgcmxvt3xs@kamzik.brq.redhat.com>
References: <20200908075830.1161921-1-maz@kernel.org>
 <20200908075830.1161921-2-maz@kernel.org>
 <20200908095318.nzbnadvgcmxvt3xs@kamzik.brq.redhat.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <79c1a29f8596c4b0c8af7dcfdc600f36@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: drjones@redhat.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, kernel-team@android.com,
 graf@amazon.com, robin.murphy@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com, graf@amazon.com,
 Robin Murphy <robin.murphy@arm.com>, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Andrew,

On 2020-09-08 10:53, Andrew Jones wrote:
> Hi Marc,
> 
> On Tue, Sep 08, 2020 at 08:58:26AM +0100, Marc Zyngier wrote:
>> The PMU emulation error handling is pretty messy when dealing with
>> attributes. Let's refactor it so that we have less duplication,
>> and that it is easy to extend later on.
>> 
>> A functional change is that kvm_arm_pmu_v3_init() used to return
>> -ENXIO when the PMU feature wasn't set. The error is now reported
>> as -ENODEV, matching the documentation.
> 
> Hmm, I didn't think we could make changes like that, since some 
> userspace
> somewhere may now depend on the buggy interface.

Well, this is the whole point of this patch: discussing whether
this change is acceptable or whether existing VMMs are relying
on such behaviour. We *could* leave it as is, but I thought I'd
bring it up!

> That said, I'm not really
> against the change, but maybe it should go as a separate patch.

Sure, why not.

>> -ENXIO is still returned
>> when the interrupt isn't properly configured.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/kvm/pmu-emul.c | 21 +++++++++------------
>>  1 file changed, 9 insertions(+), 12 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
>> index f0d0312c0a55..93d797df42c6 100644
>> --- a/arch/arm64/kvm/pmu-emul.c
>> +++ b/arch/arm64/kvm/pmu-emul.c
>> @@ -735,15 +735,6 @@ int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
>> 
>>  static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
>>  {
>> -	if (!kvm_arm_support_pmu_v3())
>> -		return -ENODEV;
>> -
>> -	if (!test_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features))
>> -		return -ENXIO;
>> -
>> -	if (vcpu->arch.pmu.created)
>> -		return -EBUSY;
>> -
>>  	if (irqchip_in_kernel(vcpu->kvm)) {
>>  		int ret;
>> 
>> @@ -796,6 +787,15 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int 
>> irq)
>> 
>>  int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct 
>> kvm_device_attr *attr)
>>  {
>> +	if (!kvm_arm_support_pmu_v3())
>> +		return -ENODEV;
>> +
>> +	if (!test_bit(KVM_ARM_VCPU_PMU_V3, vcpu->arch.features))
>> +		return -ENODEV;
> 
> nit: could combine these two if's w/ an ||

This was made to make the userspace visible change obvious to the
reviewer. Now that you have noticed it, I'm happy to merge these
two! ;-)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
