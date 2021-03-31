Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C07543504BB
	for <lists+kvmarm@lfdr.de>; Wed, 31 Mar 2021 18:36:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 401B64B494;
	Wed, 31 Mar 2021 12:36:53 -0400 (EDT)
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
	with ESMTP id xbC+x-2tnaOL; Wed, 31 Mar 2021 12:36:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 067D64B491;
	Wed, 31 Mar 2021 12:36:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 99AB54B43F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 12:36:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nyp7ipsqjMm for <kvmarm@lists.cs.columbia.edu>;
 Wed, 31 Mar 2021 12:36:49 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9431E4B0C7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 12:36:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617208609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVCeiltaTGJXJYSW6dhbkobIMYPQfKpSFl3XbU9a+wA=;
 b=Z1Foasehn2XmvJG751Vlb333YRRv2hQxD96MGHmWTyGD0khQBB4hFtKKd7u8BvMNlY28HQ
 6Dah9a+l/mVY69//hjUn179zF4HzhcRzzGXLQN5s42ATAhojMOZ9UO1QBsv/+eFG34oeQ6
 +T1tKhEUDIFdZ9cW4OpQAUqSsKm3dGc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-tDi7BbrWOdGKZnN1e1vs3A-1; Wed, 31 Mar 2021 12:36:47 -0400
X-MC-Unique: tDi7BbrWOdGKZnN1e1vs3A-1
Received: by mail-ej1-f72.google.com with SMTP id jo6so1042288ejb.13
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 09:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QVCeiltaTGJXJYSW6dhbkobIMYPQfKpSFl3XbU9a+wA=;
 b=OYc0UkMup4C88RwXOaiSoFRfNXgMzZzJKi/5Nj/twsrwH+FVdI55BNKTcwX44+lhBm
 dR1+jxstJX0ElBKZgu5TczBsE6AvzlUXUsa9mff+JPh3HGetWM0G3P57soW2WpxdEFG9
 U/IMNswCan2En1okAFLNJXYo9Da/R7K5NsidyCykWa+somYIiQMfHP3OHoS3ZCSqteWB
 ZX0w4JSOuFsBopIv7ewdmsl1jVTHh0jhFDzL8mXl/2xdMQNm8FBVChwUhnuQyyIxH/VA
 +TxvBtofSoGAQaqHuqxir5N4DaJ60am0IDnxT1yfpAQr4MVCtfy2qhXLpMmeGl9AhRse
 EzIw==
X-Gm-Message-State: AOAM530XCd7EdYrJbb96vPLs0JhnPq/bJNpnXP9VZHdsvvPI3FL2E4wA
 aLbtJc46zaThTdy5hckFkyGbrr6fD5swKTVDI1N43S78KNzCPvci/3SJuUQu0r6bHblg30JR5C8
 /aJNKF7YX2pvGOX5HAXYe95Bb
X-Received: by 2002:a17:906:2786:: with SMTP id
 j6mr4459328ejc.157.1617208606698; 
 Wed, 31 Mar 2021 09:36:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH0TubmRiztxbbKWWpE6U/9a4Jmz4SSbDeZziJUjL7bKl7L31NfjvonwQzH04qoJmbwktymw==
X-Received: by 2002:a17:906:2786:: with SMTP id
 j6mr4459281ejc.157.1617208606447; 
 Wed, 31 Mar 2021 09:36:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id hb19sm1500893ejb.11.2021.03.31.09.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 09:36:45 -0700 (PDT)
To: Sean Christopherson <seanjc@google.com>
References: <20210326021957.1424875-1-seanjc@google.com>
 <20210326021957.1424875-11-seanjc@google.com>
 <ba3f7a9c-0b59-cbeb-5d46-4236cde2c51f@redhat.com>
 <YGShRP9E49p3vcos@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 10/18] KVM: Move x86's MMU notifier memslot walkers to
 generic code
Message-ID: <d843bbd5-d3f0-3cda-aaa5-8e0fb1d69554@redhat.com>
Date: Wed, 31 Mar 2021 18:36:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YGShRP9E49p3vcos@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Ben Gardon <bgardon@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
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

On 31/03/21 18:20, Sean Christopherson wrote:
> Every call
> to .change_pte() is bookended by .invalidate_range_{start,end}(), i.e. the above
> missing kvm->mmu_notifier_seq++ is benign because kvm->mmu_notifier_count is
> guaranteed to be non-zero.

In fact ARM even relies on invalidate wrapping the change_pte handler.

         /*
          * The MMU notifiers will have unmapped a huge PMD before calling
          * ->change_pte() (which in turn calls kvm_set_spte_hva()) and
          * therefore we never need to clear out a huge PMD through this
          * calling path and a memcache is not required.
          */

> Assuming all of the above is correct, I'm very tempted to rip out .change_pte()
> entirely.

There is still the performance benefit from immediately remapping the 
page to the new destination without waiting for a fault.  Yes it's 
hypothetical but I would prefer to leave that change for later.

The fact that the count is nonzero means that you will not even have to 
complicate kvm_mmu_notifier_change_pte to handle the removal of 
mmu_notifier_seq; just add a patch before this one to WARN if it is 
zero.  (The rest of my review to patch 16 still holds).

Paolo

> It's been dead weight for 8+ years and no one has complained about
> KSM+KVM performance (I'd also be curious to know how much performance was gained
> by shaving VM-Exits).  As KVM is the only user of .change_pte(), dropping it in
> KVM would mean the entire MMU notifier could also go away.
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
