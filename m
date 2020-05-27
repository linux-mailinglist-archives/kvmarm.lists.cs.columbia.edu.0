Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0FC1E3A38
	for <lists+kvmarm@lfdr.de>; Wed, 27 May 2020 09:18:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 414604B201;
	Wed, 27 May 2020 03:18:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	UNPARSEABLE_RELAY=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZ5yYwQ2OGpW; Wed, 27 May 2020 03:18:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 184184B21C;
	Wed, 27 May 2020 03:18:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3BF434B0DF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 May 2020 01:24:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZgRMpyFlu4SG for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 May 2020 01:24:03 -0400 (EDT)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 831B74B0CA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 May 2020 01:24:02 -0400 (EDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01358;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0TzmMcE-_1590557034; 
Received: from 30.27.118.64(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0TzmMcE-_1590557034) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 May 2020 13:23:56 +0800
Subject: Re: [PATCH v4 3/7] KVM: PPC: Remove redundant kvm_run from vcpu_arch
To: Paul Mackerras <paulus@ozlabs.org>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-4-tianjia.zhang@linux.alibaba.com>
 <20200527042055.GG293451@thinks.paulus.ozlabs.org>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <56064e35-583f-0dc8-9156-aabebdb8aff4@linux.alibaba.com>
Date: Wed, 27 May 2020 13:23:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527042055.GG293451@thinks.paulus.ozlabs.org>
X-Mailman-Approved-At: Wed, 27 May 2020 03:18:39 -0400
Cc: wanpengli@tencent.com, kvm@vger.kernel.org, david@redhat.com,
 benh@kernel.crashing.org, heiko.carstens@de.ibm.com,
 linux-mips@vger.kernel.org, hpa@zytor.com, kvmarm@lists.cs.columbia.edu,
 linux-s390@vger.kernel.org, frankja@linux.ibm.com, chenhuacai@gmail.com,
 maz@kernel.org, joro@8bytes.org, x86@kernel.org, borntraeger@de.ibm.com,
 mingo@redhat.com, thuth@redhat.com, gor@linux.ibm.com, kvm-ppc@vger.kernel.org,
 bp@alien8.de, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, tsbogend@alpha.franken.de, cohuck@redhat.com,
 sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, pbonzini@redhat.com, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
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



On 2020/5/27 12:20, Paul Mackerras wrote:
> On Mon, Apr 27, 2020 at 12:35:10PM +0800, Tianjia Zhang wrote:
>> The 'kvm_run' field already exists in the 'vcpu' structure, which
>> is the same structure as the 'kvm_run' in the 'vcpu_arch' and
>> should be deleted.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> Thanks, patches 3 and 4 of this series applied to my kvm-ppc-next branch.
> 
> Paul.
> 

Thanks for your suggestion, for 5/7, I will submit a new version patch.

Thanks,
Tianjia
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
