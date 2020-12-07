Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4B2D1956
	for <lists+kvmarm@lfdr.de>; Mon,  7 Dec 2020 20:22:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B6C24B259;
	Mon,  7 Dec 2020 14:22:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xwt2rXDgOac1; Mon,  7 Dec 2020 14:22:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B6224B24A;
	Mon,  7 Dec 2020 14:22:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 44C154B232
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Dec 2020 14:22:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CNFbauRiVfiA for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Dec 2020 14:22:04 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 098924B143
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Dec 2020 14:22:04 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A61FB31B;
 Mon,  7 Dec 2020 11:22:03 -0800 (PST)
Received: from [10.57.61.6] (unknown [10.57.61.6])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6707C3F66B;
 Mon,  7 Dec 2020 11:22:02 -0800 (PST)
Subject: Re: [PATCH] arm64: Work around broken GCC handling of "S" constraint
To: Marc Zyngier <maz@kernel.org>
References: <20201207154341.1004276-1-maz@kernel.org>
 <CAMj1kXHb9=KPkCAwYWDFH1ddy_p3sDTZ7QemtvWV8nC_14rN+g@mail.gmail.com>
 <CAMj1kXG9mmC8wY9Gvo-oJat0bZTNk495x1Hmmi-_FXbu-gDzDw@mail.gmail.com>
 <87316821c90a13a912a624250055f50f@kernel.org>
 <CAMj1kXG0DRX22SuoXC9VypKfwaUWTUJPAJ6mOZ=ra7+c9UCMXg@mail.gmail.com>
 <ce1666ea-eb6f-33d6-cfd8-934bfcf7e336@arm.com> <87360h5tf7.wl-maz@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6e7ecff2-5014-216d-cc0a-6f653dfb3c39@arm.com>
Date: Mon, 7 Dec 2020 19:22:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87360h5tf7.wl-maz@kernel.org>
Content-Language: en-GB
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
 Android Kernel Team <kernel-team@android.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On 2020-12-07 19:04, Marc Zyngier wrote:
> Hi Robin,
> 
> On Mon, 07 Dec 2020 18:42:23 +0000,
> Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2020-12-07 17:47, Ard Biesheuvel wrote:
>>> On Mon, 7 Dec 2020 at 18:41, Marc Zyngier <maz@kernel.org> wrote:
>>>>
>>>> On 2020-12-07 17:19, Ard Biesheuvel wrote:
>>>>> (resend with David's email address fixed)
>>>>
>>>> Irk. Thanks for that.
>>>>
>>>>>>> +#ifdef CONFIG_CC_HAS_BROKEN_S_CONSTRAINT
>>>>>>> +#define SYM_CONSTRAINT "i"
>>>>>>> +#else
>>>>>>> +#define SYM_CONSTRAINT "S"
>>>>>>> +#endif
>>>>>>> +
>>>>>>
>>>>>> Could we just check GCC_VERSION here?
>>>>
>>>> I guess we could. But I haven't investigated which exact range of
>>>> compiler is broken (GCC 6.3 seems fixed, but that's the oldest
>>>> I have apart from the offending 4.9).
>>>>
>>>
>>> I tried 5.4 on godbolt, and it seems happy. And the failure will be
>>> obvious, so we can afford to get it slightly wrong and refine it
>>> later.
>>
>> FWIW the Linaro 14.11, 15.02 and 15.05 releases of GCC 4.9.3 seem to
>> build rc7 without complaint. The only thing older that I have to hand
>> is Ubuntu's GCC 4.8.4, which Kbuild chokes on entirely now.
> 
> Can you try kvmarm/next? David's PSCI relay is breaking badly here.

Ah, gotcha... Yes, they're all falling over on that :(

The 15.08 release of 5.1.1 is happy though, so Ard's probably right 
about generalising it to 4.x.

Cheers,
Robin.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
