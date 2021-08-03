Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E26FF3DF1DF
	for <lists+kvmarm@lfdr.de>; Tue,  3 Aug 2021 17:56:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 706FF4A4C0;
	Tue,  3 Aug 2021 11:56:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9GRorES+Oa5E; Tue,  3 Aug 2021 11:56:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A8E94A17F;
	Tue,  3 Aug 2021 11:56:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F16174064F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Aug 2021 11:56:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOKqaz39Is4u for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Aug 2021 11:56:16 -0400 (EDT)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3FC2E40463
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Aug 2021 11:56:16 -0400 (EDT)
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4GfKCL1Y7lzmmZs;
 Tue,  3 Aug 2021 23:53:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 23:56:10 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Tue, 3 Aug 2021 16:56:09 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Will Deacon <will@kernel.org>
Subject: RE: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU schedule out
Thread-Topic: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU schedule
 out
Thread-Index: AQHXhGar1JrryboKrU+7h+yU/0K2/6thny2AgAAaZCCAACXigIAAEl3Q
Date: Tue, 3 Aug 2021 15:56:08 +0000
Message-ID: <58bf7a27a4c440c685c6b1e7c9325441@huawei.com>
References: <20210729104009.382-1-shameerali.kolothum.thodi@huawei.com>
 <20210729104009.382-5-shameerali.kolothum.thodi@huawei.com>
 <20210803114034.GB30853@willie-the-truck>
 <ee2863107d614ef8a36006b5aa912eca@huawei.com>
 <20210803153036.GA31125@willie-the-truck>
In-Reply-To: <20210803153036.GA31125@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.86.18]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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



> -----Original Message-----
> From: Will Deacon [mailto:will@kernel.org]
> Sent: 03 August 2021 16:31
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> linux-kernel@vger.kernel.org; maz@kernel.org; catalin.marinas@arm.com;
> james.morse@arm.com; julien.thierry.kdev@gmail.com;
> suzuki.poulose@arm.com; jean-philippe@linaro.org;
> Alexandru.Elisei@arm.com; qperret@google.com; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [PATCH v3 4/4] KVM: arm64: Clear active_vmids on vCPU
> schedule out
> 
> On Tue, Aug 03, 2021 at 12:55:25PM +0000, Shameerali Kolothum Thodi
> wrote:
> > > > diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
> > > > index 5584e84aed95..5fd51f5445c1 100644
> > > > --- a/arch/arm64/kvm/vmid.c
> > > > +++ b/arch/arm64/kvm/vmid.c
> > > > @@ -116,6 +116,12 @@ static u64 new_vmid(struct kvm_vmid
> > > *kvm_vmid)
> > > >  	return idx2vmid(vmid) | generation;
> > > >  }
> > > >
> > > > +/* Call with preemption disabled */
> > > > +void kvm_arm_vmid_clear_active(void)
> > > > +{
> > > > +	atomic64_set(this_cpu_ptr(&active_vmids), 0);
> > > > +}
> > >
> > > I think this is very broken, as it will force everybody to take the
> > > slow-path when they see an active_vmid of 0.
> >
> > Yes. I have seen that happening in my test setup.
> 
> Why didn't you say so?!

Sorry. I thought of getting some performance numbers with and
without this patch and measure the impact. But didn't quite get time
to finish it yet.
 
> 
> > > It also doesn't solve the issue I mentioned before, as an active_vmid of 0
> > > means that the reserved vmid is preserved.
> > >
> > > Needs more thought...
> >
> > How about we clear all the active_vmids in kvm_arch_free_vm() if it
> > matches the kvm_vmid->id ? But we may have to hold the lock
> > there
> 
> I think we have to be really careful not to run into the "suspended
> animation" problem described in ae120d9edfe9 ("ARM: 7767/1: let the ASID
> allocator handle suspended animation") if we go down this road.


Ok. I will go through that.
 
> Maybe something along the lines of:
> 
> ROLLOVER
> 
>   * Take lock
>   * Inc generation
>     => This will force everybody down the slow path
>   * Record active VMIDs
>   * Broadcast TLBI
>     => Only active VMIDs can be dirty
>     => Reserve active VMIDs and mark as allocated
> 
> VCPU SCHED IN
> 
>   * Set active VMID
>   * Check generation
>   * If mismatch then:
>         * Take lock
>         * Try to match a reserved VMID
>         * If no reserved VMID, allocate new
> 
> VCPU SCHED OUT
> 
>   * Clear active VMID
> 
> but I'm not daft enough to think I got it right first time. I think it
> needs both implementing *and* modelling in TLA+ before we merge it!
> 

Ok. I need some time to digest the above first :).

On another note, how serious do you think is the problem of extra
reservation of the VMID space? Just wondering if we can skip this
patch for now or not..

Thanks,
Shameer
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
