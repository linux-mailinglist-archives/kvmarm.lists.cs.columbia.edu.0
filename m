Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 605825BC0B9
	for <lists+kvmarm@lfdr.de>; Mon, 19 Sep 2022 01:58:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DDB14B808;
	Sun, 18 Sep 2022 19:58:35 -0400 (EDT)
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
	with ESMTP id Pn2M8pP66jQd; Sun, 18 Sep 2022 19:58:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF83C4B630;
	Sun, 18 Sep 2022 19:58:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 92CDB4B5F4
 for <kvmarm@lists.cs.columbia.edu>; Sun, 18 Sep 2022 19:58:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h+qbrJTcbUfz for <kvmarm@lists.cs.columbia.edu>;
 Sun, 18 Sep 2022 19:58:31 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 219C34B2A5
 for <kvmarm@lists.cs.columbia.edu>; Sun, 18 Sep 2022 19:58:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663545510;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ud14KPmofNeyFdYS8YyOBxzic/NSH3aF62bCDlpoP+Q=;
 b=LKYOwjVOpE+B7UYJ/V7JtNuQNFpkX+Og9ZeaVSl+7K1xiVdWp1PzrK+eT+1rcaH9r6nnxl
 yaLZ0oPomTkjgczoJ2ET8QqlqIpNuWVaMHfqSkaSyPY40h7wUHn+qx01pO23Hx4NkcUaMm
 m0cu5bBJQr1wodHrvsWNAvyuXSwSLj0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455--_Ff72U0OI2N8p1iuC-k6A-1; Sun, 18 Sep 2022 19:58:24 -0400
X-MC-Unique: -_Ff72U0OI2N8p1iuC-k6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCEFA380673A;
 Sun, 18 Sep 2022 23:58:23 +0000 (UTC)
Received: from [10.64.54.126] (vpn2-54-126.bne.redhat.com [10.64.54.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90F7C40C6EC3;
 Sun, 18 Sep 2022 23:58:14 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] KVM: x86: Introduce KVM_REQ_RING_SOFT_FULL
To: Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20220916045135.154505-1-gshan@redhat.com>
 <20220916045135.154505-2-gshan@redhat.com> <YyS78BqsQxKkLOiW@xz-m1.local>
 <87illlkqfu.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <a2e0b9bc-2c67-8683-d722-7298bd65058c@redhat.com>
Date: Mon, 19 Sep 2022 09:58:10 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87illlkqfu.wl-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: drjones@redhat.com, shan.gavin@gmail.com, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, catalin.marinas@arm.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, zhenyzha@redhat.com, will@kernel.org,
 linux-kselftest@vger.kernel.org, bgardon@google.com, dmatlack@google.com,
 pbonzini@redhat.com, shuah@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On 9/18/22 7:00 PM, Marc Zyngier wrote:
> On Fri, 16 Sep 2022 19:09:52 +0100,
> Peter Xu <peterx@redhat.com> wrote:
>>
>> On Fri, Sep 16, 2022 at 12:51:31PM +0800, Gavin Shan wrote:
>>> This adds KVM_REQ_RING_SOFT_FULL, which is raised when the dirty
>>> ring of the specific VCPU becomes softly full in kvm_dirty_ring_push().
>>> The VCPU is enforced to exit when the request is raised and its
>>> dirty ring is softly full on its entrance.
>>>
>>> Suggested-by: Marc Zyngier <maz@kernel.org>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/x86/kvm/x86.c       | 5 +++--
>>>   include/linux/kvm_host.h | 1 +
>>>   virt/kvm/dirty_ring.c    | 4 ++++
>>>   3 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 43a6a7efc6ec..7f368f59f033 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -10265,8 +10265,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>>>   	bool req_immediate_exit = false;
>>>   
>>>   	/* Forbid vmenter if vcpu dirty ring is soft-full */
>>> -	if (unlikely(vcpu->kvm->dirty_ring_size &&
>>> -		     kvm_dirty_ring_soft_full(&vcpu->dirty_ring))) {
>>> +	if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
>>> +	    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
>>> +		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
>>>   		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>>>   		trace_kvm_dirty_ring_exit(vcpu);
>>>   		r = 0;
>>
>> As commented previously - can we use kvm_test_request() instead? because we
>> don't want to unconditionally clear the bit.  Instead of making the request
>> again, we can clear request only if !full.
> 
> I have the feeling that this is a micro-optimisation that won't lead
> to much benefit in practice. You already have the cache line, just not
> in exclusive mode, and given that this is per-vcpu, you'd only see the
> cost if someone else is setting a request to this vcpu while
> evaluating the local requests.
> 
> And now you need extra barriers...
> 
> Also, can we please refrain from changing things without data showing
> that this actually is worse than what we had before? The point below
> makes me think that this is actually beneficial as is.
> 

I think Marc's explanation makes sense. It won't make difference in terms
of performance. We need to explicitly handle barrier when kvm_test_request()
is used. So I prefer to keep the code if Peter agrees.

>> We can also safely move this into the block of below kvm_request_pending()
>> as Marc used to suggest.
> 
> This, on the other hand, makes sure that we share the cost across all
> requests. Requests should be extremely rare anyway (and if they
> aren't, you have a whole lot of performance issues on your hands
> anyway).
> 

Yeah, We shouldn't have too much requests. I missed the comment from Marc
to move this chunk to kvm_request_pending(). I will fix it in v3.

>>
>> To explicitly use kvm_clear_request(), we may need to be careful on the
>> memory barriers.  I'm wondering whether we should have moved
>> smp_mb__after_atomic() into kvm_clear_request() because kvm_clear_request()
>> is used outside kvm_check_request() and IIUC all the call sites should
>> better have that barrier too to be safe.
>>
>> Side note: when I read the code around I also see some mis-use of clear
>> request where it can be omitted, e.g.:
>>
>> 		if (kvm_check_request(KVM_REQ_UNHALT, vcpu)) {
>> 			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
>> 			vcpu->run->exit_reason = KVM_EXIT_IRQ_WINDOW_OPEN;
>> 		}
>>
>> Maybe it's a sign of bad naming, so we should renamed kvm_check_request()
>> to kvm_test_clear_request() too to show that clearing after that is not
>> needed?
> 
> Yeah, this kvm_clear_request() is superfluous. But this is rather well
> documented, for once, and I don't think we should repaint it based on
> a sample of one.
> 

Yeah, I think Peter is correct that smp_mb__after_atomic() would be
part of kvm_clear_request(). Otherwise, the following two cases aren't
in same order:

       // kvm_check_request()             // test and clear
       kvm_test_request()                 kvm_test_request()
       kvm_clear_request()                kvm_clear_request()
       smp_mb__after_atomic()

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
