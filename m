Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9258F4FD
	for <lists+kvmarm@lfdr.de>; Thu, 11 Aug 2022 01:53:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 423224DDE5;
	Wed, 10 Aug 2022 19:53:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4ib8iJk2OZ0; Wed, 10 Aug 2022 19:53:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D029E4DDE3;
	Wed, 10 Aug 2022 19:53:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BB924DDD9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 19:53:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WoEVhytE6k5n for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Aug 2022 19:53:10 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 33DEA4DDDF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 19:53:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660175589;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RK+rr0mfAx0H6DNfJ38VHaiOqlQCgpVZGMqD2Vgy3AU=;
 b=ZqLWhRlddssTJgMWyB6IQ8ISbD8pzsWyLYaVuUnWt/8Ff5D7WkSs5eU7jZdg7R7aVklhmL
 8LT28ndY/S6Xk8vjCN9BKQdFyV1DvYRh/ZFTDJQPv1iLrJvnXs8I3N32HQYZ1Ynx8dql8L
 eqC0lAP+Lrfg3hFK+VS97Hu0ZVrJomM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-xWnBAyr8PHS6t1-mPqJvlw-1; Wed, 10 Aug 2022 19:53:03 -0400
X-MC-Unique: xWnBAyr8PHS6t1-mPqJvlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4495885A587;
 Wed, 10 Aug 2022 23:53:03 +0000 (UTC)
Received: from [10.64.54.77] (vpn2-54-77.bne.redhat.com [10.64.54.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8611C9459C;
 Wed, 10 Aug 2022 23:52:58 +0000 (UTC)
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Christopherson <seanjc@google.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <8735e6ncxw.fsf@oldenburg.str.redhat.com>
 <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
 <87o7wtnay6.fsf@oldenburg.str.redhat.com>
 <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com>
 <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
 <1014177394.115022.1660052656961.JavaMail.zimbra@efficios.com>
 <YvLT1fd8ddybF5Uw@google.com>
 <1478461718.353.1660133626967.JavaMail.zimbra@efficios.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <1191ef05-ef2c-fe8e-656d-cb89141b36fb@redhat.com>
Date: Thu, 11 Aug 2022 09:52:55 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1478461718.353.1660133626967.JavaMail.zimbra@efficios.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: Florian Weimer <fweimer@redhat.com>, shan gavin <shan.gavin@gmail.com>,
 KVM list <kvm@vger.kernel.org>, maz <maz@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 andrew jones <andrew.jones@linux.dev>, yihyu <yihyu@redhat.com>,
 linux-kselftest <linux-kselftest@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

Hi Mathieu,

On 8/10/22 10:13 PM, Mathieu Desnoyers wrote:
> ----- On Aug 9, 2022, at 5:38 PM, Sean Christopherson seanjc@google.com wrote: 
>> On Tue, Aug 09, 2022, Mathieu Desnoyers wrote:
>>> ----- On Aug 9, 2022, at 8:21 AM, Mathieu Desnoyers
>>> mathieu.desnoyers@efficios.com wrote:

[...]

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
> 
> Indeed, moving rseq.c to tools/lib/ would allow building a .so from any selftest
> which needs to use it.
> 
> And we could move the relevant rseq helper header files to tools/include/rseq/*
> as well.
> 
> Thoughts ?
> 

One question is how librseq.so can be built automatically, when I'm going to
build tools/testing/selftests/kvm/rseq_test.

     # cd linux/tools/testing/selftests/kvm
     # make rseq_test

It's not perfect if I have to build tools/lib/librseq.so in advance, in order
to build tools/testing/selftests/kvm/rseq_test for the sake of dependency.

Thanks,
Gavin




_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
