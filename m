Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3258EBFD
	for <lists+kvmarm@lfdr.de>; Wed, 10 Aug 2022 14:29:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A4F334D8E7;
	Wed, 10 Aug 2022 08:29:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@efficios.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NowVYyBd9CRJ; Wed, 10 Aug 2022 08:29:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 44AEF4D8E2;
	Wed, 10 Aug 2022 08:29:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4ABE54D8D5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 08:29:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZNbb7JdxmkRU for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Aug 2022 08:29:20 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B0CD14D8D3
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 08:29:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 68B2143EA36;
 Wed, 10 Aug 2022 08:29:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id h3gb2233B6MC; Wed, 10 Aug 2022 08:29:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6CD9E43ED02;
 Wed, 10 Aug 2022 08:29:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6CD9E43ED02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1660134559;
 bh=QBchzkobu6L+jcpw+dUlEz0k3O8E4+6GRlWJ0MXHIvs=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=PI+Lh9go6DchA6I6ZfU44MkHtWrACOshp+vTuj5r62mRjexFkHf0bTwM97qiZ/UB3
 X+UMSBKCbjhj4tGMCQnyIO2LqeuSeymfaH6LhpEZt8iYn+q/jF/v9aZKRuhorjXNnR
 KdIyZvvD81ucWRIWTXKs0B+rCjlzsXOSGYyPnMZ7Atx0AWP1t7xbIo1DIng+pAORyl
 Ae7SiOp0Ot3nfCnUtBJMe3V/u1tuw8BlefFcxJKDUBnq1mg/9xP4/3qpxMPuv2G0X9
 mpl2nMqj00hi17podl51qHx2TpsJ/tJuPGhGJS/+somd7WwcN9zHiCLod2ZNGidtDh
 8ZR/tYJ9G9qGQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 9xQH-mneLfu7; Wed, 10 Aug 2022 08:29:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 5327143E933;
 Wed, 10 Aug 2022 08:29:19 -0400 (EDT)
Date: Wed, 10 Aug 2022 08:29:19 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Gavin Shan <gshan@redhat.com>
Message-ID: <1316061904.375.1660134559269.JavaMail.zimbra@efficios.com>
In-Reply-To: <8c1f33b4-a5a1-fcfa-4521-36253ffa22c8@redhat.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
 <87o7wtnay6.fsf@oldenburg.str.redhat.com>
 <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com>
 <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
 <1014177394.115022.1660052656961.JavaMail.zimbra@efficios.com>
 <YvLT1fd8ddybF5Uw@google.com>
 <8c1f33b4-a5a1-fcfa-4521-36253ffa22c8@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103
 (Linux)/8.8.15_GA_4372)
Thread-Topic: selftests: Make rseq compatible with glibc-2.35
Thread-Index: Hmn4zQY3JK/eFlOJPqqhWHevLMt86A==
Cc: Florian Weimer <fweimer@redhat.com>, shan gavin <shan.gavin@gmail.com>,
 KVM list <kvm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 andrew jones <andrew.jones@linux.dev>, yihyu <yihyu@redhat.com>,
 linux-kselftest <linux-kselftest@vger.kernel.org>, maz <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
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

----- On Aug 9, 2022, at 8:37 PM, Gavin Shan gshan@redhat.com wrote:

> Hi Mathieu and Sean,
> 
> On 8/10/22 7:38 AM, Sean Christopherson wrote:
>> On Tue, Aug 09, 2022, Mathieu Desnoyers wrote:
>>> ----- On Aug 9, 2022, at 8:21 AM, Mathieu Desnoyers
>>> mathieu.desnoyers@efficios.com wrote:
>>>> ----- Gavin Shan <gshan@redhat.com> wrote:
>>>>> On 8/9/22 5:16 PM, Florian Weimer wrote:
>>>>>>>> __builtin_thread_pointer doesn't work on all architectures/GCC
>>>>>>>> versions.
>>>>>>>> Is this a problem for selftests?
>>>>>>>>
>>>>>>>
>>>>>>> It's a problem as the test case is running on all architectures. I think I
>>>>>>> need introduce our own __builtin_thread_pointer() for where it's not
>>>>>>> supported: (1) PowerPC  (2) x86 without GCC 11
>>>>>>>
>>>>>>> Please let me know if I still have missed cases where
>>>>>>> __buitin_thread_pointer() isn't supported?
>>>>>>
>>>>>> As far as I know, these are the two outliers that also have rseq
>>>>>> support.  The list is a bit longer if we also consider non-rseq
>>>>>> architectures (csky, hppa, ia64, m68k, microblaze, sparc, don't know
>>>>>> about the Linux architectures without glibc support).
>>>>>>
>>>>>
>>>>> For kvm/selftests, there are 3 architectures involved actually. So we
>>>>> just need consider 4 cases: aarch64, x86, s390 and other. For other
>>>>> case, we just use __builtin_thread_pointer() to maintain code's
>>>>> integrity, but it's not called at all.
>>>>>
>>>>> I think kvm/selftest is always relying on glibc if I'm correct.
>>>>
>>>> All those are handled in the rseq selftests and in librseq. Why duplicate all
>>>> that logic again?
>>>
>>> More to the point, considering that we have all the relevant rseq registration
>>> code in tools/testing/selftests/rseq/rseq.c already, and the relevant thread
>>> pointer getter code in tools/testing/selftests/rseq/rseq-*thread-pointer.h,
>>> is there an easy way to get test applications in tools/testing/selftests/kvm
>>> and in tools/testing/selftests/rseq to share that common code ?
>>>
>>> Keeping duplicated compatibility code is bad for long-term maintainability.
>> 
>> Any reason not to simply add tools/lib/rseq.c and then expose a helper to get
>> the
>> registered rseq struct?
>> 
> 
> There are couple of reasons, not to share
> tools/testing/selftests/rseq/librseq.so
> or add tools/lib/librseq.so. Please let me know if the arguments making sense
> to you?
> 
> - By design, selftests/rseq and selftests/kvm are parallel. It's going to
> introduce
>   unnecessary dependency for selftests/kvm to use selftests/rseq/librseq.so. To
>   me,
>   it makes the maintainability even harder.

In terms of build system, yes, selftests/rseq and selftests/kvm are side-by-side,
and I agree it is odd to have a cross-dependency.

That's where moving rseq.c to tools/lib/ makes sense.

> 
> - What selftests/kvm needs is rseq-thread-pointer.h, which accounts for ~5% of
>   functionalities, provided by selftests/rseq/librseq.so.

I've never seen this type of argument used to prevent using a library before, except
on extremely memory-constrained devices, which is not our target here.

Even if you would only use 1% of the features of a library, it does not justify
reimplementing that 1% if that code already sits within the same project (kernel
selftests).

> 
> - I'm not too much familiar with selftests/rseq, but it seems it need heavy
>   rework before it can become tools/lib/librseq.so. However, I'm not sure if
>   the effort is worthwhile. The newly added library is fully used by
>   testtests/rseq. ~5% of that is going to be used by selftests/kvm.
>   In this case, we still have cross-dependency issue.

No, it's just moving files around and a bit of Makefile modifications. That's
the simple part.

> 
> I personally prefer not to use selftests/rseq/librseq.so or add
> tools/lib/librseq.so,
> but I need your feedback. Please share your thoughts.

I strongly favor that we use a two steps approach:

1) immediate fix: include ../rseq/rseq.c into your test code and use the headers,
   as proposed by Paolo.

2) I'll move librseq code into tools/lib/ and tools/include/rseq/, and adapt the
   users accordingly. (after the end of my vacation)

Thanks,

Mathieu

> Thanks,
> Gavin

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
