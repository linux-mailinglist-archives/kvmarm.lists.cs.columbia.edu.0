Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF12C8864
	for <lists+kvmarm@lfdr.de>; Mon, 30 Nov 2020 16:40:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 36AA44D19A;
	Mon, 30 Nov 2020 10:40:23 -0500 (EST)
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
	with ESMTP id XlKLC-JrJhY4; Mon, 30 Nov 2020 10:40:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1EEE64D19D;
	Mon, 30 Nov 2020 10:40:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C2ACE4D18E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Nov 2020 10:40:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xCyWP3Miiq3r for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Nov 2020 10:40:19 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D8AD14D190
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Nov 2020 10:40:19 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F880206C0;
 Mon, 30 Nov 2020 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606750818;
 bh=xvn4o/Ps2MmjI/dRiv8oM22Yyzf+9XlrLVdNZNcgBko=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kSS5E+WkPTc5oeXpPcINZm3eSBnDfvMq4J4iFv4rFWgZE78tctxrEWiefyOS7HuLy
 RIanrltHcrVOvGM/Tc+oyVthAQAS0lEOEmZAcg7+U0L8R7oL2yr3PXWF2pNi/Rzmjm
 WDvG8Hbkk7BplkrnRgmyn4gSEjGfR2v17P2sLvLU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kjlHk-00Ejeo-7O; Mon, 30 Nov 2020 15:40:16 +0000
MIME-Version: 1.0
Date: Mon, 30 Nov 2020 15:40:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Advertise ID_AA64PFR0_EL1.CSV3=1 if the
 CPUs are Meltdown-safe
In-Reply-To: <20201130152655.oyzs2l4qg2pfzxmv@google.com>
References: <20201128124659.669578-1-maz@kernel.org>
 <20201128124659.669578-3-maz@kernel.org>
 <20201130152655.oyzs2l4qg2pfzxmv@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <4a398347b173c5c1a7a0ebd4b54a64bd@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, will@kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

Hi David,

On 2020-11-30 15:26, David Brazdil wrote:
>> @@ -1227,9 +1229,16 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu 
>> *vcpu,
>>  	    (csv2 && arm64_get_spectre_v2_state() != SPECTRE_UNAFFECTED))
>>  		return -EINVAL;
>> 
>> -	/* We can only differ with CSV2, and anything else is an error */
>> +	/* Same thing for CSV3 */
>> +	csv3 = cpuid_feature_extract_unsigned_field(val, 
>> ID_AA64PFR0_CSV3_SHIFT);
>> +	if (csv3 > 1 ||
>> +	    (csv3 && arm64_get_meltdown_state() != SPECTRE_UNAFFECTED))
>> +		return -EINVAL;
>> +
>> +	/* We can only differ with CSV[23], and anything else is an error */
>>  	val ^= read_id_reg(vcpu, rd, false);
>> -	val &= ~(0xFUL << ID_AA64PFR0_CSV2_SHIFT);
>> +	val &= ~((0xFUL << ID_AA64PFR0_CSV2_SHIFT) ||
>> +		 (0xFUL << ID_AA64PFR0_CSV3_SHIFT));
> 
> That boolean OR looks like a typo.

It definitely is. Who the hell is writing this code?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
