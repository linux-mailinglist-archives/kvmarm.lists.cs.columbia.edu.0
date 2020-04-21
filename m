Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9591B30AE
	for <lists+kvmarm@lfdr.de>; Tue, 21 Apr 2020 21:52:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AC8C4B15B;
	Tue, 21 Apr 2020 15:52:57 -0400 (EDT)
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
	with ESMTP id YWtXZtwGCJQm; Tue, 21 Apr 2020 15:52:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 199D14B141;
	Tue, 21 Apr 2020 15:52:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 46A354B0CB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Apr 2020 15:52:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5zvgyvSPCDcF for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Apr 2020 15:52:54 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 540C54AC80
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Apr 2020 15:52:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587498774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTdCjw+xJyiyOVepRoiBzPpX6UPTHW6RSy1+eF5nCoY=;
 b=OLjgrRl/8huqCNLAElAtHPqnu7h8+wB2vD04r4DzA/3LDaYYFUpCQS29KK+VgwTDf5OUHr
 4edPoeFs7EECk/0kOJZoT9u5MQ7/c9iQRuEBVBqox9avnchUYjXAWXWF6M3vn0BEotheLb
 ZYBcdGLLkUp8G3lawKOT4uJ7O+XupU8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-SK4QU2WLO-eRfoXIn0GffQ-1; Tue, 21 Apr 2020 15:52:52 -0400
X-MC-Unique: SK4QU2WLO-eRfoXIn0GffQ-1
Received: by mail-wm1-f70.google.com with SMTP id n127so1871086wme.4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Apr 2020 12:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TTdCjw+xJyiyOVepRoiBzPpX6UPTHW6RSy1+eF5nCoY=;
 b=sW9xlLdMhJEYhuQ7BbnhpwkZKdeA3Llc2nbicNeHhcfMbc1QNy4s0cSsZiTWwzZxV3
 9xFMoQov78XpW3bj1wuwupzvYZmKobgl1VGpN91qFUbFAHx06VPUUtqcApNN8bTrGurB
 1m4XMNDES6qXtoAUq03aKsEaas2ouaMm0jsZPja2tZZhiL0qfeMBns1IamQAt/3RwZCt
 M49fqy9pYMeMOuH90BoQ6TDUkJG90N8XWZjhrt/cuE/jP05rlNDWdS6nubTp1qaaSthx
 CHY3Z04ZnkHgWDUy/8gg0GQzFtbaDe3xXJC2DTS3F18jcStzxG16iVdSUMtsiVObIxJE
 IvUw==
X-Gm-Message-State: AGi0PualgUv+4vyJOyWrcLRO2+1/ltXtNbgfsdX82Nl/TFDQD1DQcl0A
 Rw+jWR4Lf3Hra7NRJGzMntVJD2s+b5JOwAN1FARD5qty/tvaj9DCtHqE6XkWkrzOm5HdjAjeLSI
 Kmz8jrV6SgXP3ZMmObdw+grtE
X-Received: by 2002:adf:bc05:: with SMTP id s5mr25183114wrg.70.1587498769683; 
 Tue, 21 Apr 2020 12:52:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypLppZDmxlXD8GhpLz87T+p+wy/ipriyB1TljFwkP+/SqFt2cdsfkDNAw/S0mujJ1KBuTCSHFg==
X-Received: by 2002:adf:bc05:: with SMTP id s5mr25183091wrg.70.1587498769480; 
 Tue, 21 Apr 2020 12:52:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446?
 ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
 by smtp.gmail.com with ESMTPSA id 5sm4473852wmg.34.2020.04.21.12.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 12:52:48 -0700 (PDT)
Subject: Re: [PATCH v2] kvm: Replace vcpu->swait with rcuwait
To: Davidlohr Bueso <dave@stgolabs.net>
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
 <20200420164132.tjzk5ebx35m66yce@linux-p48b>
 <418acdb5001a9ae836095b7187338085@misterjones.org>
 <20200420205641.6sgsllj6pmsnwrvp@linux-p48b>
 <f7cc83fe-3e91-0057-9af2-26c201456689@redhat.com>
 <20200420215014.sarodevmhphnkkn7@linux-p48b>
 <02e1b00d-a8ea-a947-bbe6-0b1380aa7ec4@redhat.com>
 <20200421180733.xrl5ta6cuo2weuva@linux-p48b>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab78bbc8-aa03-6e88-940e-5e1c041f48e4@redhat.com>
Date: Tue, 21 Apr 2020 21:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421180733.xrl5ta6cuo2weuva@linux-p48b>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>, peterz@infradead.org,
 Marc Zyngier <maz@kernel.org>, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, will@kernel.org, joel@joelfernandes.org,
 tglx@linutronix.de, torvalds@linux-foundation.org,
 kvmarm@lists.cs.columbia.edu
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

On 21/04/20 20:07, Davidlohr Bueso wrote:
>> 
> 
> I should have looked closer here - I was thinking about the return
> value of rcuwait_wait_event. Yes, that signal_pending check you
> mention makes the sleep semantics change bogus as interruptible is no
> longer just to avoid contributing to the load balance.
> 
> And yes, unfortunately adding prepare_to and finish_rcuwait() looks
> like the most reasonable approach to keeping the tracepoint
> semantics. I also considered extending rcuwait_wait_event() by
> another parameter to pass back to the caller if there was any wait at
> all, but that enlarges the call and is probably less generic.

Yes, at some point the usual prepare_to/finish APIs become simpler.

> I'll send another version keeping the current sleep and tracepoint 
> semantics.

Thanks---and sorry, I should have noticed that way earlier.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
