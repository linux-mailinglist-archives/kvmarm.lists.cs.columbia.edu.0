Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF31152DF
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 15:19:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B4124AF3F;
	Fri,  6 Dec 2019 09:19:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18ECRUZdM44z; Fri,  6 Dec 2019 09:19:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D8E54AF3E;
	Fri,  6 Dec 2019 09:19:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A279C4AF2D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 09:19:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kh2tex4kAuES for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 09:19:24 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B6C194AF20
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 09:19:24 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1idES3-0004NV-Dl; Fri, 06 Dec 2019 15:19:23 +0100
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/5] target/arm: More EL2 trapping fixes
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Fri, 06 Dec 2019 14:19:23 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <CAFEAcA_XWvO4yhJzEaTGatTfqqjZ9u3cTd=eo1xaPszwEYpPkQ@mail.gmail.com>
References: <20191201122018.25808-1-maz@kernel.org>
 <CAFEAcA_XWvO4yhJzEaTGatTfqqjZ9u3cTd=eo1xaPszwEYpPkQ@mail.gmail.com>
Message-ID: <848fd5b2d53b092476879a102b5bd40c@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, richard.henderson@linaro.org,
 edgar.iglesias@xilinx.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
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

On 2019-12-06 14:13, Peter Maydell wrote:
> On Sun, 1 Dec 2019 at 12:20, Marc Zyngier <maz@kernel.org> wrote:
>>
>> Hi all,
>>
>> This series is a follow-up on [1], which tried to address the
>> remaining missing HCR_EL2.TIDx traps. I've hopefully now adressed 
>> the
>> comments that Peter and Edgar raised.
>>
>> I've also tried to tackle missing traps generated by HSTR_EL2, which
>> got completely ignored so far. Note that this results in the use of 
>> a
>> new TB bit, which I understand is a rare resource. I'd welcome
>> comments on how to handle it differently if at all possible.
>>
>> Finally, and as a bonus non-feature, I've added support for the
>> missing Jazelle registers, giving me the opportunity to allow 
>> trapping
>> of JIDR to EL2 using HCR_EL2.TID0. Yay, Christmas! ;-)
>>
>> I'm now going back to kernel stuff. I swear!
>
> To save you from having to roll a v3, I've fixed up the
> handful of nits Richard and I found as I applied this
> series to target-arm.next.

Ah, brilliant. Thanks a lot Peter.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
