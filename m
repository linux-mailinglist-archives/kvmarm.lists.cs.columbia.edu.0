Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6501B2F2C
	for <lists+kvmarm@lfdr.de>; Tue, 21 Apr 2020 20:33:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 061BA4B178;
	Tue, 21 Apr 2020 14:33:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MWgBs0TFuI8y; Tue, 21 Apr 2020 14:33:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D29C24B16C;
	Tue, 21 Apr 2020 14:33:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0779B4B163
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Apr 2020 14:11:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7NDZ8+KdiYGd for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Apr 2020 14:11:05 -0400 (EDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E29A64B0D8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Apr 2020 14:11:04 -0400 (EDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EB498ADDD;
 Tue, 21 Apr 2020 18:11:01 +0000 (UTC)
Date: Tue, 21 Apr 2020 11:07:33 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] kvm: Replace vcpu->swait with rcuwait
Message-ID: <20200421180733.xrl5ta6cuo2weuva@linux-p48b>
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
 <20200420164132.tjzk5ebx35m66yce@linux-p48b>
 <418acdb5001a9ae836095b7187338085@misterjones.org>
 <20200420205641.6sgsllj6pmsnwrvp@linux-p48b>
 <f7cc83fe-3e91-0057-9af2-26c201456689@redhat.com>
 <20200420215014.sarodevmhphnkkn7@linux-p48b>
 <02e1b00d-a8ea-a947-bbe6-0b1380aa7ec4@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <02e1b00d-a8ea-a947-bbe6-0b1380aa7ec4@redhat.com>
User-Agent: NeoMutt/20180716
X-Mailman-Approved-At: Tue, 21 Apr 2020 14:33:25 -0400
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, 21 Apr 2020, Paolo Bonzini wrote:

>On 20/04/20 23:50, Davidlohr Bueso wrote:
>> On Mon, 20 Apr 2020, Paolo Bonzini wrote:
>>
>>> On 20/04/20 22:56, Davidlohr Bueso wrote:
>>>> On Mon, 20 Apr 2020, Marc Zyngier wrote:
>>>>
>>>>> This looks like a change in the semantics of the tracepoint. Before
>>>>> this
>>>>> change, 'waited' would have been true if the vcpu waited at all. Here,
>>>>> you'd
>>>>> have false if it has been interrupted by a signal, even if the vcpu
>>>>> has waited
>>>>> for a period of time.
>>>>
>>>> Hmm but sleeps are now uninterruptible as we're using TASK_IDLE.
>>>
>>> Hold on, does that mean that you can't anymore send a signal in order to
>>> kick a thread out of KVM_RUN?=A0 Or am I just misunderstanding?
>>
>> Considering that the return value of the interruptible wait is not
>> checked, I would not think this breaks KVM_RUN.
>
>What return value?  kvm_vcpu_check_block checks signal_pending, so you
>could have a case where the signal is injected but you're not woken up.
>
>Admittedly I am not familiar with how TASK_* work under the hood, but it
>does seem to be like that.

I should have looked closer here - I was thinking about the return value
of rcuwait_wait_event. Yes, that signal_pending check you mention makes
the sleep semantics change bogus as interruptible is no longer just to
avoid contributing to the load balance.

And yes, unfortunately adding prepare_to and finish_rcuwait() looks like the
most reasonable approach to keeping the tracepoint semantics. I also consid=
ered
extending rcuwait_wait_event() by another parameter to pass back to the cal=
ler
if there was any wait at all, but that enlarges the call and is probably le=
ss
generic.

I'll send another version keeping the current sleep and tracepoint semantic=
s.

Thanks,
Davidlohr
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
