Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC02D3F01
	for <lists+kvmarm@lfdr.de>; Wed,  9 Dec 2020 10:43:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 18DA44B1A8;
	Wed,  9 Dec 2020 04:43:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUEjZN9rxc+f; Wed,  9 Dec 2020 04:43:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A31264B28B;
	Wed,  9 Dec 2020 04:43:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 765C04B28B
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 04:43:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tdJhX1A3-5pt for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Dec 2020 04:43:20 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 263B74B13A
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 04:43:20 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C4756233FA;
 Wed,  9 Dec 2020 09:43:18 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kmw0C-00HKn3-JQ; Wed, 09 Dec 2020 09:43:16 +0000
MIME-Version: 1.0
Date: Wed, 09 Dec 2020 09:43:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
In-Reply-To: <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
 <20200911085841.GB562@jagdpanzerIV.localdomain>
 <CAJWu+oq26OK1-7Ze2pb5xpRJ-tS9wtXOdGFrYpHq+fhkyGhjkA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <fdc35e25f2bc2cdfa0849a84802eafd6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: joelaf@google.com, sergey.senozhatsky@gmail.com,
 yezengruan@huawei.com, will@kernel.org, linux-kernel@vger.kernel.org,
 suleiman@google.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, wanghaibin.wang@huawei.com,
 qperret@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Suleiman Souhlal <suleiman@google.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, "moderated list:ARM64 PORT \(AARCH64
 ARCHITECTURE\)" <linux-arm-kernel@lists.infradead.org>
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

Hi all,

On 2020-12-08 20:02, Joel Fernandes wrote:
> On Fri, Sep 11, 2020 at 4:58 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
>> 
>> My apologies for the slow reply.
>> 
>> On (20/08/17 13:25), Marc Zyngier wrote:
>> >
>> > It really isn't the same thing at all. You are exposing PV spinlocks,
>> > while Sergey exposes preemption to vcpus.
>> >
>> 
>> Correct, we see vcpu preemption as a "fundamental" feature, with
>> consequences that affect scheduling, which is a core feature :)
>> 
>> Marc, is there anything in particular that you dislike about this RFC
>> patch set? Joel has some ideas, which we may discuss offline if that
>> works for you.
> 
> Hi Marc, Sergey, Just checking what is the latest on this series?

I was planning to give it a go, but obviously got sidetracked. :-(

> 
> About the idea me and Sergey discussed, at a high level we discussed
> being able to share information similar to "Is the vCPU preempted?"
> using a more arch-independent infrastructure. I do not believe this
> needs to be arch-specific. Maybe the speciifc mechanism about how to
> share a page of information needs to be arch-specific, but the actual
> information shared need not be.

We already have some information sharing in the form of steal time
accounting, and I believe this "vcpu preempted" falls in the same
bucket. It looks like we could implement the feature as an extension
of the steal-time accounting, as the two concepts are linked
(one describes the accumulation of non-running time, the other is
instantaneous).

> This could open the door to sharing
> more such information in an arch-independent way (for example, if the
> scheduler needs to know other information such as the capacity of the
> CPU that the vCPU is on).

Quentin and I have discussed potential ways of improving guest 
scheduling
on terminally broken systems (otherwise known as big-little), in the
form of a capacity request from the guest to the host. I'm not really
keen on the host exposing its own capacity, as that doesn't tell the
host what the guest actually needs.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
