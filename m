Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B6277263473
	for <lists+kvmarm@lfdr.de>; Wed,  9 Sep 2020 19:20:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 502134B472;
	Wed,  9 Sep 2020 13:20:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LkwRBUIlIeZT; Wed,  9 Sep 2020 13:20:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 566DA4B438;
	Wed,  9 Sep 2020 13:20:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 90A264B390
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Sep 2020 13:20:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Lw1pmcLO3vx for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Sep 2020 13:20:48 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CCE064B376
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Sep 2020 13:20:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599672048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SQhMq/j8wv9M8NJ35HTtp9bCIMUSj7eRfqejEmxcMqo=;
 b=LKY4kUqiQUmP8VDn4OESOy0UTPKT+DGSQ4bQQAiuqVVWeQHgVL/pu3RAjtzUNG3Eb5fBdH
 IEFRu15UUbJH64SnQMjQb3ad6smOfVwSLOG3i1N4yjikakgPCb5puCGZ5IMzsCMXdTdvb9
 IyVs2hV2ZSF0DEVAdglEsiK1+hkugAo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-Nsra8rhBN7CSclEgqgmVlg-1; Wed, 09 Sep 2020 13:20:47 -0400
X-MC-Unique: Nsra8rhBN7CSclEgqgmVlg-1
Received: by mail-ed1-f72.google.com with SMTP id d27so1280706edj.21
 for <kvmarm@lists.cs.columbia.edu>; Wed, 09 Sep 2020 10:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SQhMq/j8wv9M8NJ35HTtp9bCIMUSj7eRfqejEmxcMqo=;
 b=bgvU7eKsF6w+t5Y2Pm3R3mf49aXRwKOuh5kjWWf1tT17/uvhkSBEhI3k1focgplivc
 vC6uBYO1oet5XC/BckpEDsUuSm/1Pt3b44LOl2OPP1mvpOduiD01b/GrY6SlBuJznOHx
 0SQfYxT6qPh0xpNF3Tn/LkFQiEAS5njU5l5j+Hu/Y5UF/djqMG266nFsrgfUJs3jXX9O
 ZVjJ7IntdqDn9SqT2lR26rrXtySDiYrq+bpo75sKdU0L/lPbpobD6Q11t+KwbiYjamqf
 mzYVboarylOQm9s9ykG+sDpDdqFotc1f+tXrxNVZjGRTTaEl27mEo7LhEN2Vy08rVzns
 Qklg==
X-Gm-Message-State: AOAM532ADn4gy1rRgyPNJC6HbsoCfVxMsO9DU2oVw5n81UD5hOs6Ejer
 wK/lS2knw8gCcFQjHtmj0Ga+LBo9/weVkZsjZIQaGsCxjYR1wA3oNhCvnhd00sRfK77zvvUPW90
 fnxIelj7/qwzMtAeXCgmj0dQZ
X-Received: by 2002:a17:906:341b:: with SMTP id
 c27mr4649985ejb.286.1599672045702; 
 Wed, 09 Sep 2020 10:20:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR0JhfniAOR3Q+4CaV0GSjjn8Qc/IDCqbAtZUAVgDJOvsx1CXOnPyuh1xtlTC2wLiQ4Me5wg==
X-Received: by 2002:a17:906:341b:: with SMTP id
 c27mr4649973ejb.286.1599672045510; 
 Wed, 09 Sep 2020 10:20:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:37de:1d96:8ea2:b59a?
 ([2001:b07:6468:f312:37de:1d96:8ea2:b59a])
 by smtp.gmail.com with ESMTPSA id b13sm3229274edf.89.2020.09.09.10.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 10:20:44 -0700 (PDT)
Subject: Re: [GIT PULL] KVM/arm64 fixes for 5.9
To: Marc Zyngier <maz@kernel.org>
References: <20200904104530.1082676-1-maz@kernel.org>
 <f7afbf0f-2e14-2720-5d23-2cd01982e4d1@redhat.com>
 <fea2e35a29967075e46d25220044c109@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8cba9da1-d2f4-efad-358d-92c510e9d05f@redhat.com>
Date: Wed, 9 Sep 2020 19:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fea2e35a29967075e46d25220044c109@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 Steven Price <steven.price@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On 09/09/20 19:15, Marc Zyngier wrote:
> On 2020-09-09 16:20, Paolo Bonzini wrote:
>> On 04/09/20 12:45, Marc Zyngier wrote:
>>> Hi Paolo,
>>>
>>> Here's a bunch of fixes for 5.9. The gist of it is the stolen time
>>> rework from Andrew, but we also have a couple of MM fixes that have
>>> surfaced as people have started to use hugetlbfs in anger.
>>
>> Hi Marc,
>>
>> I'll get to this next Friday.
> 
> Thanks. I may have another one for you by then though...

Sure, you can choose whether to send a separate tag or update this one.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
