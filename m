Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB3516999
	for <lists+kvmarm@lfdr.de>; Mon,  2 May 2022 05:40:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 08B4E49ED5;
	Sun,  1 May 2022 23:40:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FxSH9c3KVuWn; Sun,  1 May 2022 23:40:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8ED924B17C;
	Sun,  1 May 2022 23:40:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D6EEF49ED5
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 May 2022 23:40:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5gV5z-y9sZvR for <kvmarm@lists.cs.columbia.edu>;
 Sun,  1 May 2022 23:40:24 -0400 (EDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
 [209.85.166.53])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 47D0E49ECC
 for <kvmarm@lists.cs.columbia.edu>; Sun,  1 May 2022 23:40:24 -0400 (EDT)
Received: by mail-io1-f53.google.com with SMTP id i20so13321891ion.0
 for <kvmarm@lists.cs.columbia.edu>; Sun, 01 May 2022 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sElaWLOyKUxazQojYLrnvAx04p2BuOgFqaeUXWDNphc=;
 b=PI89Bel9IH0osdgZv/f/nPPG/qArbrfgTx65sMPDWIMCQkBjP+VKfPxGMfPyYxVhXm
 gNoKgT0fA3ABes0RAb/N/AAZiOXt2IviminS46gFw42qjRRVcDxTU8zb2iayO9hCAxgK
 sTqSwt7KUIIi0Pa08YMoEXO56StqeKuwjPNB+unoRuSm8YAQFJRjsvNx92DfDaIe1lf2
 LjCYLYNo05DOT8Kaqbz+KHvQwyGPo6SeEd3d8shJrhdOGejBHzfD8jhD2U9VRdlwP78z
 lD9QwvrlLHez7CmK7oriwwDUHJlchVu3qNScv6x5EN//MOmGE11gbS6KuZuq/K+VlLkp
 MLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sElaWLOyKUxazQojYLrnvAx04p2BuOgFqaeUXWDNphc=;
 b=n6Eb4U5qQWZhIddRHa1JGcbshosks08KJ8MI+EOF87miX4AVSX9ybZ/WngrUDXqP/j
 ajeuvzfONxL0UcN1diVUxiIFaiZgfFKYJY2a3B+1VhS75zRCFxbgvaniLp+yci2A4GWm
 yr7P85hVVbIh7c9t7EYVCyFfA5+VLP9pBhbsbxfO4YBb20zqgk5TZvad8NLJVRXFNljf
 zUTGFGyoEm3XBy+r86EN6jGfDeekTNS2FaVBa8gBEmqNcwkJwbWA7dIYz22TG6wu3hee
 A5ElLC0NEjSNgYxjUIhjLu02Ea8x9iwlfb84lKxLTXbBzQm9AJr+qbTq2V036IPQYI3S
 dDDw==
X-Gm-Message-State: AOAM532izyNDwjCmUOIjsWVk4t/pCWlEnVGOcUGBLRSi8PJe+5o4ZNtE
 609j07zuARbMmGAVq6r/xCXV9g==
X-Google-Smtp-Source: ABdhPJz2vFLn1waUdU8voiXOHX+s1j40CDQZd+pHOX4xK76LO8vr1iu7cwjasiU7vJCVgDE/ZZT0Pw==
X-Received: by 2002:a05:6638:144b:b0:321:589b:a8ea with SMTP id
 l11-20020a056638144b00b00321589ba8eamr4352384jad.296.1651462823197; 
 Sun, 01 May 2022 20:40:23 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194]) by smtp.gmail.com with ESMTPSA id
 h17-20020a02c731000000b0032b3a781746sm2761517jao.10.2022.05.01.20.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 May 2022 20:40:22 -0700 (PDT)
Date: Mon, 2 May 2022 03:40:19 +0000
From: Oliver Upton <oupton@google.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 03/18] KVM: arm64: Add SDEI virtualization
 infrastructure
Message-ID: <Ym9So9YariC0M7Zu@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-4-gshan@redhat.com>
 <YmMiyt/TDjJt0mdG@google.com>
 <36899ea9-e8bd-27b2-8dfb-75b76eab50d7@redhat.com>
 <YmRI7Bh7fWCYLUGT@google.com>
 <0e26da1a-00bb-3d63-a8bf-6cd3271b0a38@redhat.com>
 <Ymr45B+8xTlhi7vk@google.com>
 <96711526-c4f3-3b50-c015-beba8cc9fcc9@redhat.com>
 <Ym1EztjkJIHrg4Qz@google.com>
 <62f06a03-d6fc-3803-a2d2-7a85cf733459@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62f06a03-d6fc-3803-a2d2-7a85cf733459@redhat.com>
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

Hi Gavin,

On Mon, May 02, 2022 at 10:35:08AM +0800, Gavin Shan wrote:
> Hi Oliver,
> 
> On 4/30/22 10:16 PM, Oliver Upton wrote:
> > On Sat, Apr 30, 2022 at 07:38:29PM +0800, Gavin Shan wrote:
> > > Thank you for the comments and details. It should work by using bitmaps
> > > to represent event's states. I will adopt your proposed structs in next
> > > respin. However, there are more states needed. So I would adjust
> > > "struct kvm_sdei_vcpu" like below in next respin.
> > > 
> > >      struct kvm_sdei_vcpu {
> > >          unsigned long registered;    /* the event is registered or not                 */
> > >          unsigned long enabled;       /* the event is enabled or not                    */
> > >          unsigned long unregistering; /* the event is pending for unregistration        */
> > 
> > I'm not following why we need to keep track of the 'pending unregister'
> > state directly. Is it not possible to infer from (active && !registered)?
> > 
> 
> The event can be unregistered and reseted through hypercalls when it's
> being handled. In this case, the unregistration for the event can't
> be done immediately and has to be delayed until the handling is finished.
> The unregistration pending state is used in this case. Yes, it's
> correct we also can use (active & !registered) to represent the state.

I don't believe there is any delay in the unregistration of an event.
The state is only meant to imply that the handler must complete before
software can re-register for the event.

The event state machine from 6.1 can be encoded using 3 bits, which is
exactly what we see in Table 13 of DEN0054C.

I'm sorry for being pedantic, but avoiding duplication of state reduces
the chance of bugs + makes things a bit easier to reason about.

> > >          unsigned long pending;       /* the event is pending for delivery and handling */
> > >          unsigned long active;        /* the event is currently being handled           */
> > > 
> > >          :
> > >          <this part is just like what you suggested>
> > >      };
> > > 
> > > I rename @pending to @unregister. Besides, there are two states added:
> > > 
> > >     @pending: Indicate there has one event has been injected. The next step
> > >               for the event is to deliver it for handling. For one particular
> > >               event, we allow one pending event in the maximum.
> > 
> > Right, if an event retriggers when it is pending we still dispatch a
> > single event to the guest. And since we're only doing normal priority
> > events, it is entirely implementation defined which gets dispatched
> > first.
> > 
> 
> Yep, we will simply rely on find_first_bit() for the priority. It means
> the software signaled event, whose number is zero, will have the highest
> priority.
> 
> > >     @active:  Indicate the event is currently being handled. The information
> > >               stored in 'struct kvm_sdei_event_context' instance can be
> > >               correlated with the event.
> > 
> > Does this need to be a bitmap though? We can't ever have more than one
> > SDEI event active at a time since this is private to a vCPU.
> > 
> 
> Yes, one event is active at most on one particular vCPU. So tt don't
> have to be a bitmap necessarily. The reason I proposed to use bitmap
> for this state is to having all (event) states represented by bitmaps.
> In this way, all states are managed in a unified fashion. The alternative
> way is to have "unsigned long active_event", which traces the active
> event number. It also consumes 8-bytes when live migration is concerned.
> So I prefer a bitmap :)
>

The small benefit of using the event number is that we can address all
events in 8 bytes, whereas we'd need to extend the bitmap for >64
events. I suppose we'll run into that issue either way, since the
pending, registered, and enabled portions are also bitmaps.

When live migration is in scope we should probably bark at userspace if
it attempts to set more than a single bit in the register.

> > > Furthermore, it's fair enough to put the (vcpu) mask state into 'flags'
> > > field of struct kvm_vcpu_arch :)
> > 
> > I think you can get away with putting active in there too, I don't see
> > why we need more than a single bit for this info.
> > 
> 
> Not really. We just need one single bit for vCPU's mask state. We need
> multiple bits for event's active state, depending on how many events are
> supported. We need to know which event is currently active at least.
> For now, there are only two supported events (0/1), but one single bit
> is still not enough because there are 3 states: (1) software signaled
> event is active. (2) async pf event is active. (3) none of them is
> active.
> 
> Lets use a bitmap for the event active state as I said above, if you
> don't strongly object :)
> 
> > > > > > > > Do we need this if we disallow nesting events?
> > > > > > > > 
> > > > > > > 
> > > > > > > Yes, we need this. "event == NULL" is used as indication of invalid
> > > > > > > context. @event is the associated SDEI event when the context is
> > > > > > > valid.
> > > > > > 
> > > > > > What if we use some other plumbing to indicate the state of the vCPU? MP
> > > > > > state comes to mind, for example.
> > > > > > 
> > > > > 
> > > > > Even the indication is done by another state, kvm_sdei_vcpu_context still
> > > > > need to be linked (associated) with the event. After the vCPU context becomes
> > > > > valid after the event is delivered, we still need to know the associated
> > > > > event when some of hypercalls are triggered. SDEI_1_0_FN_SDEI_EVENT_COMPLETE
> > > > > is one of the examples, we need to decrease struct kvm_sdei_event::event_count
> > > > > for the hypercall.
> > > > 
> > > > Why do we need to keep track of how many times an event has been
> > > > signaled? Nothing in SDEI seems to suggest that the number of event
> > > > signals corresponds to the number of times the handler is invoked. In
> > > > fact, the documentation on SDEI_EVENT_SIGNAL corroborates this:
> > > > 
> > > > """
> > > > The event has edgetriggered semantics and the number of event signals
> > > > may not correspond to the number of times the handler is invoked in the
> > > > target PE.
> > > > """
> > > > 
> > > > DEN0054C 5.1.16.1
> > > > 
> > > > So perhaps we queue at most 1 pending event for the guest.
> > > > 
> > > > I'd also like to see if anyone else has thoughts on the topic, as I'd
> > > > hate for you to go back to the whiteboard again in the next spin.
> > > > 
> > > 
> > > Agreed. In next respin, we will have one pending event at most. Error
> > > can be returned if user attempts to inject event whose pending state
> > > (struct kvm_sdei_vcpu::pending) has been set.
> > 
> > I don't believe we can do that. The SDEI_EVENT_SIGNAL call should succeed,
> > even if the event was already pending.
> > 
> 
> I rethinking it a bit. Yes, you're correct. In this specific case, the
> event handler is running for multiple events.
>
> > > Indeed, the hardest part is to determine the data structures and
> > > functions we need. Oliver, your valuable comments are helping to
> > > bring this series to the right track. However, I do think it's
> > > helpful if somebody else can confirm the outcomes from the previous
> > > discussions. I'm not sure if Marc has time for a quick scan and provide
> > > comments.
> > > 
> > > I would summarize the outcomes from our discussions, to help Marc
> > > or others to confirm:
> > 
> > Going to take a look at some of your later patches as well, just a heads
> > up.
> > 
> 
> Yep, thanks again for your valuable comments :)
> 
> > > - Drop support for the shared event.
> > > - Dropsupport for the critical event.
> > > - The events in the implementations are all private and can be signaled
> > >    (raised) by software.
> > > - Drop migration support for now, and we will consider it using
> > >    pseudo firmware registers. So add-on patches are expected to support
> > >    the migration in future.
> > 
> > Migration will be supported in a future spin of this series, not a
> > subsequent one right? :) I had just made the suggestion because there was
> > a lot of renovations that we were discussing.
> > 
> 
> I prefer a separate series to support migration after this series gets
> merged. There are couple of reasons to do so: (1) The migration depends
> on Raghavendra's series to support for hypercall services selection.
> The series is close to be merged, but not happen yet. The SDEI is one
> of the hypercall services at least. SDEI's pseudo firmware registers
> for migration will be managed by the infrastructure. (2) I would focus
> on the core functinality for now. In this way, we give migration space.
> For example, the data structures needs sorts of adjustments for migration,
> just in case.

Although merging this series w/o support for LM would mean that a guest
using SDEI could potentially explode when migrated, right? We can't
break it to implement something else.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
