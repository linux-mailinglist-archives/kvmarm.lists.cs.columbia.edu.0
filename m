Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA79B1ABECE
	for <lists+kvmarm@lfdr.de>; Thu, 16 Apr 2020 13:10:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 611EC4B231;
	Thu, 16 Apr 2020 07:10:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	UNPARSEABLE_RELAY=0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1d2EUebA9UvQ; Thu, 16 Apr 2020 07:10:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 28F8A4B250;
	Thu, 16 Apr 2020 07:10:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 084564B1B9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 22:00:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a1P2gceuwyOL for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 22:00:55 -0400 (EDT)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A011A4B19E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 22:00:54 -0400 (EDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R851e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07488;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=19; SR=0;
 TI=SMTPD_---0Tveg8zr_1587002446; 
Received: from 30.27.118.45(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0Tveg8zr_1587002446) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Apr 2020 10:00:47 +0800
Subject: Re: [PATCH] KVM: Optimize kvm_arch_vcpu_ioctl_run function
To: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com>
 <875ze2ywhy.fsf@vitty.brq.redhat.com>
 <cc29ce22-4c70-87d1-d7aa-9d38438ba8a5@linux.alibaba.com>
 <87a73dxgk6.fsf@vitty.brq.redhat.com>
 <9e122372-249d-3d93-99ed-a670fff33936@redhat.com>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <4843f690-7071-aa4f-cc9d-d9cc2321e669@linux.alibaba.com>
Date: Thu, 16 Apr 2020 10:00:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9e122372-249d-3d93-99ed-a670fff33936@redhat.com>
X-Mailman-Approved-At: Thu, 16 Apr 2020 07:10:16 -0400
Cc: wanpengli@tencent.com, kvm@vger.kernel.org, maz@kernel.org, joro@8bytes.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com
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



On 2020/4/15 22:53, Paolo Bonzini wrote:
> On 15/04/20 11:07, Vitaly Kuznetsov wrote:
>> In case this is no longer needed I'd suggest we drop 'kvm_run' parameter
>> and extract it from 'struct kvm_vcpu' when needed. This looks like a
>> natural add-on to your cleanup patch.
> 
> I agree, though I think it should be _instead_ of Tianjia's patch rather
> than on top.
> 
> Paolo
> 

Thank you very much for the comments of Vitaly and Paolo, I will make a 
v2 patch.

Thanks and best,
Tianjia
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
