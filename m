Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B82C41664ED
	for <lists+kvmarm@lfdr.de>; Thu, 20 Feb 2020 18:33:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5026E4AF77;
	Thu, 20 Feb 2020 12:33:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jo4ZObALE02e; Thu, 20 Feb 2020 12:33:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F1464AF76;
	Thu, 20 Feb 2020 12:33:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A5494AF66
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Feb 2020 12:33:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QpQOzcy9jkbw for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Feb 2020 12:33:23 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C0344AF65
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Feb 2020 12:33:23 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2613531B;
 Thu, 20 Feb 2020 09:33:23 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B3073F68F;
 Thu, 20 Feb 2020 09:33:21 -0800 (PST)
Subject: Re: [PATCH 0/3] KVM: arm64: Ask the compiler to __always_inline
 functions used by KVM at HYP
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20200220165839.256881-1-james.morse@arm.com>
 <CAKv+Gu-tPOWyxjsKrL-auC=ZxeNJPgAPyQ2rBd9S8sgMbb=r_w@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <1ecedad2-1b3e-0d37-42e8-7022ac5a8370@arm.com>
Date: Thu, 20 Feb 2020 17:33:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-tPOWyxjsKrL-auC=ZxeNJPgAPyQ2rBd9S8sgMbb=r_w@mail.gmail.com>
Content-Language: en-GB
Cc: Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>
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

Hi Ard,

On 20/02/2020 17:04, Ard Biesheuvel wrote:
> On Thu, 20 Feb 2020 at 17:58, James Morse <james.morse@arm.com> wrote:
>> It turns out KVM relies on the inline hint being honoured by the compiler
>> in quite a few more places than expected. Something about the Shadow Call
>> Stack support[0] causes the compiler to avoid inline-ing and to place
>> these functions outside the __hyp_text. This ruins KVM's day.
>>
>> Add the simon-says __always_inline annotation to all the static
>> inlines that KVM calls from HYP code.

> This isn't quite as yuck as I expected, fortunately, but it does beg
> the question whether we shouldn't simply map the entire kernel at EL2
> instead?

If the kernel is big enough to need internal veneers (the 128M range?), these would
certainly go horribly wrong because its running somewhere other than the relocation-time
address. We would need a way of telling the linker to keep the bits of KVM close together...


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
