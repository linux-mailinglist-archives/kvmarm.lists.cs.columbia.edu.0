Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 62701515C6F
	for <lists+kvmarm@lfdr.de>; Sat, 30 Apr 2022 13:38:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C9364B178;
	Sat, 30 Apr 2022 07:38:50 -0400 (EDT)
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
	with ESMTP id H6VqZ40DB7DV; Sat, 30 Apr 2022 07:38:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D1B1D4B1B4;
	Sat, 30 Apr 2022 07:38:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C8474B11E
 for <kvmarm@lists.cs.columbia.edu>; Sat, 30 Apr 2022 07:38:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fnIAK4kNHxMx for <kvmarm@lists.cs.columbia.edu>;
 Sat, 30 Apr 2022 07:38:45 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 707354B0C0
 for <kvmarm@lists.cs.columbia.edu>; Sat, 30 Apr 2022 07:38:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651318725;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/hdjWeoQyXBCrvjLK1k7gtbP/XQjQkF9Cmab34yxaI=;
 b=bfQmK31rg0jqXgZf1EZVE2rs0O1byAD3Hmlfw5y1YHFsR2/apW5biOed2iA497fYhTYZOY
 qLZqELfyCrWyvaQpbPqQOBgfcZrzJqEHX/UGho4mQ6pwRiYdof9VRT6lFABNVDxx+8yn5H
 2gX1EM32lJiOcQf+bfaOxI6ApHFwo88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-SPkWPKeZNJKzvCUbX-O1CA-1; Sat, 30 Apr 2022 07:38:41 -0400
X-MC-Unique: SPkWPKeZNJKzvCUbX-O1CA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B917811E76;
 Sat, 30 Apr 2022 11:38:41 +0000 (UTC)
Received: from [10.72.12.86] (ovpn-12-86.pek2.redhat.com [10.72.12.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C020201AC5A;
 Sat, 30 Apr 2022 11:38:32 +0000 (UTC)
Subject: Re: [PATCH v6 03/18] KVM: arm64: Add SDEI virtualization
 infrastructure
To: Oliver Upton <oupton@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-4-gshan@redhat.com> <YmMiyt/TDjJt0mdG@google.com>
 <36899ea9-e8bd-27b2-8dfb-75b76eab50d7@redhat.com>
 <YmRI7Bh7fWCYLUGT@google.com>
 <0e26da1a-00bb-3d63-a8bf-6cd3271b0a38@redhat.com>
 <Ymr45B+8xTlhi7vk@google.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <96711526-c4f3-3b50-c015-beba8cc9fcc9@redhat.com>
Date: Sat, 30 Apr 2022 19:38:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Ymr45B+8xTlhi7vk@google.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

Hi Oliver,

On 4/29/22 4:28 AM, Oliver Upton wrote:
> On Sun, Apr 24, 2022 at 11:00:56AM +0800, Gavin Shan wrote:
> 
> [...]
> 
>> Yes, The assumption that all events are always singled by software should
>> be true. So this field (@signaled) can be dropped either. So I plan to
>> change the data structures like below, according to the suggestions given
>> by you. Please double check if there are anything missed.
>>
>> (1) Those fields of struct kvm_sdei_exposed_event are dropped or merged
>>      to struct kvm_sdei_event.
>>
>>      struct kvm_sdei_event {
>>             unsigned int          num;
>>             unsigned long         ep_addr;
>>             unsigned long         ep_arg;
>> #define KVM_SDEI_EVENT_STATE_REGISTERED         0
>> #define KVM_SDEI_EVENT_STATE_ENABLED            1
>> #define KVM_SDEI_EVENT_STATE_UNREGISTER_PENDING 2
>>             unsigned long         state;                 /* accessed by {test,set,clear}_bit() */
>>             unsigned long         event_count;
>>      };
>>
>> (2) In arch/arm64/kvm/sdei.c
>>
>>      static kvm_sdei_event exposed_events[] = {
>>             { .num = SDEI_SW_SIGNALED_EVENT },
>>      };
>>
>> (3) In arch/arm64/kvm/sdei.c::kvm_sdei_create_vcpu(), the SDEI events
>>      are instantiated based on @exposed_events[]. It's just what we're
>>      doing and nothing is changed.
> 
> The part I find troubling is the fact that we are treating SDEI events
> as a list-like thing. If we want to behave more like hardware, why can't
> we track the state of an event in bitmaps? There are three bits of
> relevant state for any given event in the context of a vCPU: registered,
> enabled, and pending.
> 
> I'm having some second thoughts about the suggestion to use MP state for
> this, given that we need to represent a few bits of state for the vCPU
> as well. Seems we need to track the mask state of a vCPU and a bit to
> indicate whether an SDEI handler is active. You could put these bits in
> kvm_vcpu_arch::flags, actually.
> 
> So maybe it could be organized like so:
> 
>    /* bits for the bitmaps below */
>    enum kvm_sdei_event {
>    	KVM_SDEI_EVENT_SW_SIGNALED = 0,
> 	KVM_SDEI_EVENT_ASYNC_PF,
> 	...
> 	NR_KVM_SDEI_EVENTS,
>    };
> 
>    struct kvm_sdei_event_handler {
>    	unsigned long ep_addr;
> 	unsigned long ep_arg;
>    };
> 
>    struct kvm_sdei_event_context {
>    	unsigned long pc;
> 	unsigned long pstate;
> 	unsigned long regs[18];
>    };
> 
>    struct kvm_sdei_vcpu {
>    	unsigned long registered;
> 	unsigned long enabled;
> 	unsigned long pending;
> 
> 	struct kvm_sdei_event_handler handlers[NR_KVM_SDEI_EVENTS];
> 	struct kvm_sdei_event_context ctxt;
>    };
> 
> But it is hard to really talk about these data structures w/o a feel for
> the mechanics of working the series around it.
> 

Thank you for the comments and details. It should work by using bitmaps
to represent event's states. I will adopt your proposed structs in next
respin. However, there are more states needed. So I would adjust
"struct kvm_sdei_vcpu" like below in next respin.

     struct kvm_sdei_vcpu {
         unsigned long registered;    /* the event is registered or not                 */
         unsigned long enabled;       /* the event is enabled or not                    */
         unsigned long unregistering; /* the event is pending for unregistration        */
         unsigned long pending;       /* the event is pending for delivery and handling */
         unsigned long active;        /* the event is currently being handled           */

         :
         <this part is just like what you suggested>
     };

I rename @pending to @unregister. Besides, there are two states added:

    @pending: Indicate there has one event has been injected. The next step
              for the event is to deliver it for handling. For one particular
              event, we allow one pending event in the maximum.
    @active:  Indicate the event is currently being handled. The information
              stored in 'struct kvm_sdei_event_context' instance can be
              correlated with the event.

Furthermore, it's fair enough to put the (vcpu) mask state into 'flags'
field of struct kvm_vcpu_arch :)

>>>>> Do we need this if we disallow nesting events?
>>>>>
>>>>
>>>> Yes, we need this. "event == NULL" is used as indication of invalid
>>>> context. @event is the associated SDEI event when the context is
>>>> valid.
>>>
>>> What if we use some other plumbing to indicate the state of the vCPU? MP
>>> state comes to mind, for example.
>>>
>>
>> Even the indication is done by another state, kvm_sdei_vcpu_context still
>> need to be linked (associated) with the event. After the vCPU context becomes
>> valid after the event is delivered, we still need to know the associated
>> event when some of hypercalls are triggered. SDEI_1_0_FN_SDEI_EVENT_COMPLETE
>> is one of the examples, we need to decrease struct kvm_sdei_event::event_count
>> for the hypercall.
> 
> Why do we need to keep track of how many times an event has been
> signaled? Nothing in SDEI seems to suggest that the number of event
> signals corresponds to the number of times the handler is invoked. In
> fact, the documentation on SDEI_EVENT_SIGNAL corroborates this:
> 
> """
> The event has edgetriggered semantics and the number of event signals
> may not correspond to the number of times the handler is invoked in the
> target PE.
> """
> 
> DEN0054C 5.1.16.1
> 
> So perhaps we queue at most 1 pending event for the guest.
> 
> I'd also like to see if anyone else has thoughts on the topic, as I'd
> hate for you to go back to the whiteboard again in the next spin.
> 

Agreed. In next respin, we will have one pending event at most. Error
can be returned if user attempts to inject event whose pending state
(struct kvm_sdei_vcpu::pending) has been set.

Indeed, the hardest part is to determine the data structures and
functions we need. Oliver, your valuable comments are helping to
bring this series to the right track. However, I do think it's
helpful if somebody else can confirm the outcomes from the previous
discussions. I'm not sure if Marc has time for a quick scan and provide
comments.

I would summarize the outcomes from our discussions, to help Marc
or others to confirm:

- Drop support for the shared event.
- Dropsupport for the critical event.
- The events in the implementations are all private and can be signaled
   (raised) by software.
- Drop migration support for now, and we will consider it using
   pseudo firmware registers. So add-on patches are expected to support
   the migration in future.
- Drop locking mechanism. All the functions are executed in vcpu context.
- To use the data struct as you suggested. Besides, the vcpu's mask
   state is put to struct kvm_arch_vcpu::flags.
   enum kvm_sdei_event
   struct kvm_sdei_event_handler
   struct kvm_sdei_event_context
   struct kvm_sdei_vcpu

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
