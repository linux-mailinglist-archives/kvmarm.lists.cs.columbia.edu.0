Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB7626473
	for <lists+kvmarm@lfdr.de>; Fri, 11 Nov 2022 23:19:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C0C14B6E9;
	Fri, 11 Nov 2022 17:19:34 -0500 (EST)
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
	with ESMTP id zZ3SfIPeOEgu; Fri, 11 Nov 2022 17:19:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F21CA4B809;
	Fri, 11 Nov 2022 17:19:32 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 519ED4B712
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Nov 2022 17:19:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EZODSU3YPD+l for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Nov 2022 17:19:31 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DB58F4B6E9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Nov 2022 17:19:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668205170;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKdyDhOp/jDgAbFdi4JhqDR29ULsdYz30D0hpSnLbq4=;
 b=UFeND50rxShM94pnpEvrfbGBsJowbP0d3iY9CTBFdLP3pP5ejAsUDD9WObgsa6u0GgWOMd
 TwkEZz5LumoTWbYO1ZOqoFGk0dGXJupuwkDfv8G4JcGF6yEJZ2Iutl4nIw0s5kSDmSDIyN
 gXLm4w4UuyhGhrlPbwXe/Z+ENoxy90o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-4ShC1mh5OluSeesHPTT_fQ-1; Fri, 11 Nov 2022 17:19:24 -0500
X-MC-Unique: 4ShC1mh5OluSeesHPTT_fQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B21D28001B8;
 Fri, 11 Nov 2022 22:19:23 +0000 (UTC)
Received: from [10.67.24.81] (unknown [10.67.24.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97A1863A55;
 Fri, 11 Nov 2022 22:19:15 +0000 (UTC)
Subject: Re: [PATCH v10 3/7] KVM: Support dirty ring in conjunction with bitmap
To: Marc Zyngier <maz@kernel.org>
References: <20221110104914.31280-1-gshan@redhat.com>
 <20221110104914.31280-4-gshan@redhat.com> <Y20q3lq5oc2gAqr+@google.com>
 <1cfa0286-9a42-edd9-beab-02f95fc440ad@redhat.com>
 <86h6z5plhz.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <d11043b5-ff65-0461-146e-6353cf66f737@redhat.com>
Date: Sat, 12 Nov 2022 06:19:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <86h6z5plhz.wl-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: kvm@vger.kernel.org, bgardon@google.com, andrew.jones@linux.dev,
 dmatlack@google.com, will@kernel.org, shan.gavin@gmail.com,
 catalin.marinas@arm.com, kvmarm@lists.linux.dev, pbonzini@redhat.com,
 zhenyzha@redhat.com, shuah@kernel.org, kvmarm@lists.cs.columbia.edu,
 ajones@ventanamicro.com
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

Hi Marc,

On 11/11/22 11:19 PM, Marc Zyngier wrote:
> On Thu, 10 Nov 2022 23:47:41 +0000,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> commit b05377ecbe003f12c8b79846fa3a300401dcab68 (HEAD -> kvm/arm64_dirtyring)
>> Author: Gavin Shan <gshan@redhat.com>
>> Date:   Fri Nov 11 07:13:12 2022 +0800
>>
>>      KVM: Push dirty information unconditionally to backup bitmap
>>          In mark_page_dirty_in_slot(), we bail out when no running vcpu
>> exists and
>>      a running vcpu context is strictly required by architecture. It may cause
>>      backwards compatible issue. Currently, saving vgic/its tables is the only
>>      case where no running vcpu context is required. We may have other unknown
>>      cases where no running vcpu context exists and it's reported by the warning
>>      message. For this, the application is going to enable the backup bitmap for
>>      the unknown cases. However, the dirty information can't be pushed to the
>>      backup bitmap even though the backup bitmap has been enabled, until the
>>      unknown cases are added to the allowed list of non-running vcpu context
>>      with extra code changes to the host kernel.
>>          In order to make the new application, where the backup bitmap
>> has been
>>      enabled, to work with the unchanged host, we continue to push the dirty
>>      information to the backup bitmap instead of bailing out early.
>>          Suggested-by: Sean Christopherson <seanjc@google.com>
>>      Signed-off-by: Gavin Shan <gshan@redhat.com>
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 2719e10dd37d..03e6a38094c1 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -3308,8 +3308,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
>>          if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
>>                  return;
>>   -       if
>> (WARN_ON_ONCE(!kvm_arch_allow_write_without_running_vcpu(kvm) &&
>> !vcpu))
>> -               return;
>> +       WARN_ON_ONCE(!vcpu && !kvm_arch_allow_write_without_running_vcpu(kvm));
> 
> I'm happy with this.
> 

Thanks, it's the primary change in this patch.

>>   #endif
>>           if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
>> @@ -3318,7 +3317,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
>>                   if (kvm->dirty_ring_size && vcpu)
>>                          kvm_dirty_ring_push(vcpu, slot, rel_gfn);
>> -               else
>> +               else if (memslot->dirty_bitmap)
>>                          set_bit_le(rel_gfn, memslot->dirty_bitmap);
> 
> But that I don't get. Or rather, I don't get the commit message that
> matches this hunk. Do we want to catch the case where all of the
> following are true:
> 
> - we don't have a vcpu,
> - we're allowed to log non-vcpu dirtying
> - we *only* have the ring?
> 
> If so, can we please capture that in the commit message?
> 

Nice catch! This particular case needs to be warned explicitly. Without
the patch, kernel crash is triggered. With this patch applied, the error
or warning is dropped silently. We either check memslot->dirty_bitmap
in mark_page_dirty_in_slot(), or check it in kvm_arch_allow_write_without_running_vcpu().
I personally the later one. Let me post a formal patch on top of your
'next' branch where the commit log will be improved accordingly.

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
