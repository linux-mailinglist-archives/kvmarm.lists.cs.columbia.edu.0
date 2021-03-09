Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BE332924
	for <lists+kvmarm@lfdr.de>; Tue,  9 Mar 2021 15:52:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F9F84B41C;
	Tue,  9 Mar 2021 09:52:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hAgZpG8HzHhX; Tue,  9 Mar 2021 09:52:16 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C5D64B461;
	Tue,  9 Mar 2021 09:52:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D92204B3F9
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 09:52:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47AOGPIsFll1 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  9 Mar 2021 09:52:06 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E39E4B33D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  9 Mar 2021 09:52:06 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A04C1042;
 Tue,  9 Mar 2021 06:52:06 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EA983F71B;
 Tue,  9 Mar 2021 06:52:02 -0800 (PST)
Subject: Re: [PATCH] arm64/mm: Fix __enable_mmu() for new TGRAN range values
To: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <1614954969-14338-1-git-send-email-anshuman.khandual@arm.com>
 <8735x5zozr.wl-maz@kernel.org> <20210309140527.GB28395@willie-the-truck>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <718f4b0c-20d9-8588-1268-e5b26690899d@arm.com>
Date: Tue, 9 Mar 2021 20:22:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309140527.GB28395@willie-the-truck>
Content-Language: en-US
Cc: linux-efi@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu



On 3/9/21 7:35 PM, Will Deacon wrote:
> On Mon, Mar 08, 2021 at 02:42:00PM +0000, Marc Zyngier wrote:
>> On Fri, 05 Mar 2021 14:36:09 +0000,
>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>> -	switch (cpuid_feature_extract_unsigned_field(mmfr0, tgran_2)) {
>>> -	default:
>>> -	case 1:
>>> +	tgran_2 = cpuid_feature_extract_unsigned_field(mmfr0, tgran_2_shift);
>>> +	if (tgran_2 == ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE) {
>>>  		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
>>>  		return -EINVAL;
>>> -	case 0:
>>> +	} else if (tgran_2 == ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT) {
>>>  		kvm_debug("PAGE_SIZE supported at Stage-2 (default)\n");
>>> -		break;
>>> -	case 2:
>>> +	} else if (tgran_2 >= ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN &&
>>> +		   tgran_2 <= ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX) {
>>>  		kvm_debug("PAGE_SIZE supported at Stage-2 (advertised)\n");
>>> -		break;
>>> +	} else {
>>> +		kvm_err("Unsupported value, giving up\n");
>>> +		return -EINVAL;
>>
>> nit: this doesn't say *what* value is unsupported, and I really
>> preferred the switch-case version, such as this:
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 1f22b36a0eff..d267e4b1aec6 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -312,15 +312,18 @@ int kvm_set_ipa_limit(void)
>>  
>>  	switch (cpuid_feature_extract_unsigned_field(mmfr0, tgran_2)) {
>>  	default:
>> -	case 1:
>> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE:
>>  		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
>>  		return -EINVAL;
>> -	case 0:
>> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT:
>>  		kvm_debug("PAGE_SIZE supported at Stage-2 (default)\n");
>>  		break;
>> -	case 2:
>> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN ... ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX:
>>  		kvm_debug("PAGE_SIZE supported at Stage-2 (advertised)\n");
>>  		break;
>> +	default:
>> +		kvm_err("Unsupported value for TGRAN_2, giving up\n");
>> +		return -EINVAL;
>>  	}
>>  
>>  	kvm_ipa_limit = id_aa64mmfr0_parange_to_phys_shift(parange);
>>
>>
>> Otherwise:
>>
>> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Anshuman -- please can you spin a v2 with the switch syntax as suggested
> above by Marc?

Sure, will do.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
