Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6059625CEEA
	for <lists+kvmarm@lfdr.de>; Fri,  4 Sep 2020 03:02:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E21834B345;
	Thu,  3 Sep 2020 21:02:07 -0400 (EDT)
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
	with ESMTP id Ba1x5Z8PT-BN; Thu,  3 Sep 2020 21:02:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE5E94B324;
	Thu,  3 Sep 2020 21:02:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 111BE4B31B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 21:02:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yNMLT-F6yTnc for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 21:02:04 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2CD8A4B31A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 21:02:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599181324;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLeIPiws4G7aX/bY/3JypF9XxwhNJ2foyB1wMepr/2U=;
 b=Ih7BU71Eax8D1yr+dKDW8iZkClGdU7Zho6TETNg3+nUUB+80li+YzC/LZ802mOfKYt6iXT
 FVRHCsBQTerRXETf+fVFiPajiCW10+qx4PktiHP6LO3DwCjYLSVTwSYOWfzU5aTZeShv4h
 EFsOO+UR/GHh8v/bxAo6MNBXuPY2L3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-qtWmNGlgPGSdMKCwrruY-A-1; Thu, 03 Sep 2020 21:01:57 -0400
X-MC-Unique: qtWmNGlgPGSdMKCwrruY-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C7D81F035;
 Fri,  4 Sep 2020 01:01:55 +0000 (UTC)
Received: from [10.64.54.159] (vpn2-54-159.bne.redhat.com [10.64.54.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D7CA7E412;
 Fri,  4 Sep 2020 01:01:53 +0000 (UTC)
Subject: Re: [PATCH v3 10/21] KVM: arm64: Add support for stage-2 page-aging
 in generic page-table
To: Will Deacon <will@kernel.org>
References: <20200825093953.26493-1-will@kernel.org>
 <20200825093953.26493-11-will@kernel.org>
 <cbf5a908-9e15-d0bb-459e-b5289d8a3ad8@redhat.com>
 <20200903164832.GB7791@willie-the-truck>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <8573bc7e-e54a-9714-4dbe-c7791f59953d@redhat.com>
Date: Fri, 4 Sep 2020 11:01:51 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200903164832.GB7791@willie-the-truck>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

Hi Will,

On 9/4/20 2:48 AM, Will Deacon wrote:
> On Thu, Sep 03, 2020 at 02:33:22PM +1000, Gavin Shan wrote:
>> On 8/25/20 7:39 PM, Will Deacon wrote:
>>> Add stage-2 mkyoung(), mkold() and is_young() operations to the generic
>>> page-table code.
>>>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Quentin Perret <qperret@google.com>
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> ---
>>>    arch/arm64/include/asm/kvm_pgtable.h | 38 ++++++++++++
>>>    arch/arm64/kvm/hyp/pgtable.c         | 86 ++++++++++++++++++++++++++++
>>>    2 files changed, 124 insertions(+)
> 
> [...]
> 
>>> +static int stage2_update_leaf_attrs(struct kvm_pgtable *pgt, u64 addr,
>>> +				    u64 size, kvm_pte_t attr_set,
>>> +				    kvm_pte_t attr_clr, kvm_pte_t *orig_pte)
>>> +{
>>> +	int ret;
>>> +	kvm_pte_t attr_mask = KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI;
>>> +	struct stage2_attr_data data = {
>>> +		.attr_set	= attr_set & attr_mask,
>>> +		.attr_clr	= attr_clr & attr_mask,
>>> +	};
>>> +	struct kvm_pgtable_walker walker = {
>>> +		.cb		= stage2_attr_walker,
>>> +		.arg		= &data,
>>> +		.flags		= KVM_PGTABLE_WALK_LEAF,
>>> +	};
>>> +
>>> +	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (orig_pte)
>>> +		*orig_pte = data.pte;
>>> +	return 0;
>>> +}
>>> +
>>
>> The @size is always 1 from the caller, which means the parameter
>> can be dropped from stage2_update_leaf_attrs(). In the meanwhile,
>> we don't know the page is mapped by PUD, PMD or PTE. So to have
>> fixed value ("1") looks meaningless.
> 
> I add extra callers later on, for example kvm_pgtable_stage2_wrprotect(),
> which pass a size, so it's needed for that.
> 

Yes, we still need @size in the subsequent patches. So this suggestion
isn't valid.

Thanks,
Gavin


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
