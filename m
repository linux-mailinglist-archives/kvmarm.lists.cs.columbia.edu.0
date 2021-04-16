Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DA21F361F2C
	for <lists+kvmarm@lfdr.de>; Fri, 16 Apr 2021 13:54:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 67DC84B4A0;
	Fri, 16 Apr 2021 07:54:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sl6rd7Cw0jat; Fri, 16 Apr 2021 07:54:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4AC634B498;
	Fri, 16 Apr 2021 07:54:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 66D844B476
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Apr 2021 07:54:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D9XPgkt2N7YO for <kvmarm@lists.cs.columbia.edu>;
 Fri, 16 Apr 2021 07:54:07 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 71B194B3FB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Apr 2021 07:54:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618574047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRi3iLx/d1dCutzOrV2diewuBUaVQYIWtJjdL4DqXrA=;
 b=U5kduDFXJ13rnyBzQXObLRY1jPYsKAV1g65VpM6qPfF3+Wa0T2ZK2ZkNkRLfgO1Ys4bmPZ
 gLxUlb+Vs/CsjO8SiqXVa4gYw72JEC0Uie0JA+D+YX3BQgDrjWff9cvR5SriDfRN1sPKRp
 VxG/3Ct52FQG/fMmTTwgp4uSJ12DnQs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-a_gQaE1hObSkOJITUoJ4jQ-1; Fri, 16 Apr 2021 07:54:03 -0400
X-MC-Unique: a_gQaE1hObSkOJITUoJ4jQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 d15-20020a5d538f0000b02901027c18c581so4311561wrv.3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Apr 2021 04:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xRi3iLx/d1dCutzOrV2diewuBUaVQYIWtJjdL4DqXrA=;
 b=pEFnXLNhpoaJCbM3rGkMWs9Afll/sHlxYnYazlZXqUnOkEE41FThlnncB3zCke+1hL
 tAwV2aLtp1YCqC+W2c9jiPCYy1rpEMxYeTviOgi+fSDrSLGrQjBKI8ktbsSJifLQ8ZmE
 12jmRidTmZd7LMqQKEWeZWqaq7ZTGkcXGsXUz9k063xHCJWlVw/Ep+EydvqhgKnB0Zcb
 c6JLZfwuiD7IkXM+PnDRtfUVpDWuW6Hw7ueVY9W2a0mlejxKj1/dgT72PdL8xzAo13E5
 TmdW+WtdTYJo0jFD++qclyRqj1OI5RjSdTpwBf30sWLYEQfrPI/to6NMBLxQ9vsBzcOO
 QqPg==
X-Gm-Message-State: AOAM531KikyO7tRlmOvl3eD9ctnmN+ZWmbRd7m1LY5iAlqV6s1Q8L5P0
 IZuPWxejwLkrnnMJ6i6ivQDbDZDk0ZHjJuX4RaxuegrMPyEd8REOH9xgfZUVtXW4ZeMBaqpLJAm
 OUTonMMcCwtfoRAyZ9AnOWY/m
X-Received: by 2002:adf:bc49:: with SMTP id a9mr8859073wrh.109.1618574042168; 
 Fri, 16 Apr 2021 04:54:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz45TPUrdRBbQjp6UKDSX/x4TG0TTzsbY/zQUnfTmbSPTX9s6AXQGbir4RRmOHT+616Hu9Ffw==
X-Received: by 2002:adf:bc49:: with SMTP id a9mr8859040wrh.109.1618574041925; 
 Fri, 16 Apr 2021 04:54:01 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fb.dip0.t-ipconnect.de. [91.12.100.251])
 by smtp.gmail.com with ESMTPSA id b1sm10150075wru.90.2021.04.16.04.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Apr 2021 04:54:01 -0700 (PDT)
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
To: Mike Rapoport <rppt@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
 <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
 <3811547a-9057-3c80-3805-2e658488ac99@redhat.com>
 <YHdPmtpzFxHE9mAt@kernel.org>
 <f5503130-c0e7-329f-86c4-727ece1c860f@redhat.com>
 <YHl4mqgh5CtNk1l7@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <1065c0ac-f9e3-2d3a-1ec4-a5c28f98c6ae@redhat.com>
Date: Fri, 16 Apr 2021 13:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHl4mqgh5CtNk1l7@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>,
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

On 16.04.21 13:44, Mike Rapoport wrote:
> On Thu, Apr 15, 2021 at 11:30:12AM +0200, David Hildenbrand wrote:
>>> Not sure we really need a new pagetype here, PG_Reserved seems to be quite
>>> enough to say "don't touch this".  I generally agree that we could make
>>> PG_Reserved a PageType and then have several sub-types for reserved memory.
>>> This definitely will add clarity but I'm not sure that this justifies
>>> amount of churn and effort required to audit uses of PageResrved().
>>>> Then, we could mostly avoid having to query memblock at runtime to figure
>>>> out that this is special memory. This would obviously be an extension to
>>>> this series. Just a thought.
>>>
>>> Stop pushing memblock out of kernel! ;-)
>>
>> Can't stop. Won't stop. :D
>>
>> It's lovely for booting up a kernel until we have other data-structures in
>> place ;)
> 
> A bit more seriously, we don't have any data structure that reliably
> represents physical memory layout and arch-independent fashion.
> memblock is probably the best starting point for eventually having one.

We have the (slowish) kernel resource tree after boot and the (faster) 
memmap. I really don't see why we really need another slowish variant.

We might be better off to just extend and speed up the kernel resource tree.

Memblock as is is not a reasonable datastructure to keep around after 
boot: for example, how we handle boottime allocations and reserve 
regions both as reserved.

-- 
Thanks,

David / dhildenb

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
