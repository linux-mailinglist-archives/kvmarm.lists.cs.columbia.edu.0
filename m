Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE591ADAF6
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 12:26:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 14DC24B235;
	Fri, 17 Apr 2020 06:26:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BT0PFKewpGgc; Fri, 17 Apr 2020 06:26:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7C9A4B256;
	Fri, 17 Apr 2020 06:26:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DC5C64B235
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 06:26:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aw5soOYexTim for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 06:26:27 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8D8034B1AF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 06:26:27 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6961721D95;
 Fri, 17 Apr 2020 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587119186;
 bh=oW28VIx5XmqwFX5wQzbrLvIwt9N3aKct2/dyVLRXO8Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KhY03ZlMX29C4p1+Z4vrGH2tV89xCZeDPT21ASW7dZ+xTIY51CNUSLCNvmPxMpul1
 xRcQl5Ju1wrNXoErNfm340O7lam+pLTEPVrsWqIbd1/k+8HZVAeAhWbqtmTEFUMkOm
 BpfF/zWkzSqI79moc1XKO1smVODANyBgYLxay8Fw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jPOCW-0048tL-G6; Fri, 17 Apr 2020 11:26:24 +0100
MIME-Version: 1.0
Date: Fri, 17 Apr 2020 11:26:24 +0100
From: Marc Zyngier <maz@kernel.org>
To: zhukeqian <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2] KVM/arm64: Support enabling dirty log gradually in
 small chunks
In-Reply-To: <44ce4553-5215-2290-5956-2e6c577d030b@huawei.com>
References: <20200413122023.52583-1-zhukeqian1@huawei.com>
 <20200416160833.728017e9@why>
 <44ce4553-5215-2290-5956-2e6c577d030b@huawei.com>
Message-ID: <f3d4c6963f98b10f78640f0c99f867b6@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zhukeqian1@huawei.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, pbonzini@redhat.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, will@kernel.org, suzuki.poulose@arm.com,
 sean.j.christopherson@intel.com, jianjay.zhou@huawei.com,
 wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Jay Zhou <jianjay.zhou@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-04-17 10:46, zhukeqian wrote:
> Hi Marc,
> 
> On 2020/4/16 23:08, Marc Zyngier wrote:
>> On Mon, 13 Apr 2020 20:20:23 +0800
>> Keqian Zhu <zhukeqian1@huawei.com> wrote:
>> 
>>> There is already support of enabling dirty log graually in small 
>>> chunks
>> 
>> gradually
>> 
>>> for x86 in commit 3c9bd4006bfc ("KVM: x86: enable dirty log gradually 
>>> in
>>> small chunks"). This adds support for arm64.
>>> 
>>> x86 still writes protect all huge pages when 
>>> DIRTY_LOG_INITIALLY_ALL_SET
>>> is eanbled. However, for arm64, both huge pages and normal pages can 
>>> be
>> 
>> enabled
>> 
>>> write protected gradually by userspace.
>>> 
>>> Under the Huawei Kunpeng 920 2.6GHz platform, I did some tests on 
>>> 128G
>>> Linux VMs with different page size. The memory pressure is 127G in 
>>> each
>>> case. The time taken of memory_global_dirty_log_start in QEMU is 
>>> listed
>>> below:
>>> 
>>> Page Size      Before    After Optimization
>>>   4K            650ms         1.8ms
>>>   2M             4ms          1.8ms
>>>   1G             2ms          1.8ms
>> 
>> These numbers are different from what you have advertised before. What
>> changed?
> In patch RFC, the numbers is got when memory pressure is 100G, so the 
> number
> is bigger here.

OK.

>> 
>>> 
>>> Besides the time reduction, the biggest income is that we will 
>>> minimize
>> 
>> s/income/improvement/
>> 
>>> the performance side effect (because of dissloving huge pages and 
>>> marking
>> 
>> dissolving
> embarrassed for these misspell :(

No need to be embarrassed. I do a lot worse, at all times. That is why 
you
and I need other people to review our patches and fix things! ;-)

>> 
>>> memslots dirty) on guest after enabling dirty log.
>>> 
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> ---
>>>  Documentation/virt/kvm/api.rst    |  2 +-
>>>  arch/arm64/include/asm/kvm_host.h |  3 +++
>>>  virt/kvm/arm/mmu.c                | 12 ++++++++++--
>>>  3 files changed, 14 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/Documentation/virt/kvm/api.rst 
>>> b/Documentation/virt/kvm/api.rst
>>> index efbbe570aa9b..0017f63fa44f 100644
>>> --- a/Documentation/virt/kvm/api.rst
>>> +++ b/Documentation/virt/kvm/api.rst
>>> @@ -5777,7 +5777,7 @@ will be initialized to 1 when created.  This 
>>> also improves performance because
>>>  dirty logging can be enabled gradually in small chunks on the first 
>>> call
>>>  to KVM_CLEAR_DIRTY_LOG.  KVM_DIRTY_LOG_INITIALLY_SET depends on
>>>  KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (it is also only available on
>>> -x86 for now).
>>> +x86 and arm64 for now).
>>> 
>>>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 was previously available under the 
>>> name
>>>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT, but the implementation had bugs 
>>> that make
>>> diff --git a/arch/arm64/include/asm/kvm_host.h 
>>> b/arch/arm64/include/asm/kvm_host.h
>>> index 32c8a675e5a4..a723f84fab83 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -46,6 +46,9 @@
>>>  #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
>>>  #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>>> 
>>> +#define KVM_DIRTY_LOG_MANUAL_CAPS   
>>> (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
>>> +				     KVM_DIRTY_LOG_INITIALLY_SET)
>>> +
>>>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>>> 
>>>  extern unsigned int kvm_sve_max_vl;
>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>> index e3b9ee268823..1077f653a611 100644
>>> --- a/virt/kvm/arm/mmu.c
>>> +++ b/virt/kvm/arm/mmu.c
>>> @@ -2265,8 +2265,16 @@ void kvm_arch_commit_memory_region(struct kvm 
>>> *kvm,
>>>  	 * allocated dirty_bitmap[], dirty pages will be be tracked while 
>>> the
>>>  	 * memory slot is write protected.
>>>  	 */
>>> -	if (change != KVM_MR_DELETE && mem->flags & 
>>> KVM_MEM_LOG_DIRTY_PAGES)
>>> -		kvm_mmu_wp_memory_region(kvm, mem->slot);
>>> +	if (change != KVM_MR_DELETE && mem->flags & 
>>> KVM_MEM_LOG_DIRTY_PAGES) {
>>> +		/*
>>> +		 * If we're with initial-all-set, we don't need to write
>>> +		 * protect any pages because they're all reported as dirty.
>>> +		 * Huge pages and normal pages will be write protect gradually.
>>> +		 */
>>> +		if (!kvm_dirty_log_manual_protect_and_init_set(kvm)) {
>>> +			kvm_mmu_wp_memory_region(kvm, mem->slot);
>>> +		}
>>> +	}
>>>  }
>>> 
>>>  int kvm_arch_prepare_memory_region(struct kvm *kvm,
>> 
>> As it is, it is pretty good. The one thing that isn't clear to me is
>> why we have a difference in behaviour between x86 and arm64. What
>> prevents x86 from having the same behaviour as arm64?
> I am also not very clear about the difference. Maybe there is historic 
> reason.
> 
> Before introducing DIRTY_LOG_INITIALLY_ALL_SET, all pages will be write
> protected when starting dirty log, but only normal pages are needed
> to be write protected again during dirty log sync, because huge pages 
> will
> be dissolved to normal pages.
> 
> For that x86 uses different routine to write protect huge pages and
> normal pages,
> and arm64 uses same routine to do this, so arm64 still write protect 
> all
> pages again during dirty log sync, but x86 didn't.
> 
> So I think that x86 can write protect huge pages gradually too, just 
> need to add
> some code legs in dirty log sync.

Fair enough. It'd be good if you could investigate this as well. In the 
meantime,
I'll queue this patch for a spin in -next.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
