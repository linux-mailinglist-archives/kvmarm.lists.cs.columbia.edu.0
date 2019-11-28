Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3C10CCE3
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 17:35:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A5C14ACC9;
	Thu, 28 Nov 2019 11:35:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RhlDMuycBhoa; Thu, 28 Nov 2019 11:35:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1C5824A7FD;
	Thu, 28 Nov 2019 11:35:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AB55D4A610
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 11:35:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glCgmccX62h6 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Nov 2019 11:35:46 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A26264A5A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Nov 2019 11:35:46 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iaMld-00038D-8Q; Thu, 28 Nov 2019 17:35:45 +0100
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/3] target/arm: More =?UTF-8?Q?HCR=5FEL=32=2ETIDx=20f?=
 =?UTF-8?Q?ixes?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Thu, 28 Nov 2019 16:35:45 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <CAFEAcA8GvqnwfGiKHi7OgcUqUu1JL9UKTe6J77-VHMnzRpKX_A@mail.gmail.com>
References: <20191128161718.24361-1-maz@kernel.org>
 <CAFEAcA8GvqnwfGiKHi7OgcUqUu1JL9UKTe6J77-VHMnzRpKX_A@mail.gmail.com>
Message-ID: <782ea75ba2ef3cff597ab07d7128dbc9@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, richard.henderson@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
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

On 2019-11-28 16:30, Peter Maydell wrote:
> On Thu, 28 Nov 2019 at 16:17, Marc Zyngier <maz@kernel.org> wrote:
>>
>> I started looking the rest of the missing TIDx handling,
>> and this resulted in the following patches.
>>
>> There is still one thing I'm a bit puzzled by though:
>>
>> HCR_EL2.TID0 mandates trapping of the AArch32 JIDR
>> register, but I couldn't find a trace of it in the QEMU
>> code, and trying to read it seems to generate an exception.
>>
>> It isn't like anyone is going to miss it, but I wonder if
>> it should be implemented... It could also be that I'm missing
>> the obvious and that my testing is broken! ;-)
>
> Hmm, I was under the impression that we correctly implemented
> 'trivial Jazelle', but we obviously missed some of it
> (we do have the handling of BXJ insns).
> We should, yes, ideally, have RAZ/WI implementations
> of JIDR, JMCR and JOSCR.

OK, I'll have a look at this, and plumb the handling of TID0
in JIDR.

> We also I think don't get right the fiddly detail about
> attempting an exception return with SPSR.J set, but that's
> not worth messing about with IMHO.

Indeed. The less we hear about Jazelle, the better... ;-)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
