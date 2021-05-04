Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 04EE2372F19
	for <lists+kvmarm@lfdr.de>; Tue,  4 May 2021 19:44:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BB5D4B384;
	Tue,  4 May 2021 13:44:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rGL9vQH0bTI9; Tue,  4 May 2021 13:44:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 540AC4B48A;
	Tue,  4 May 2021 13:44:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9878B4B2D1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 May 2021 13:44:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xqJ-9yrAmhPR for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 May 2021 13:44:43 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 927E44B314
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 May 2021 13:44:43 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9249C61166;
 Tue,  4 May 2021 17:44:39 +0000 (UTC)
Date: Tue, 4 May 2021 18:44:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v11 5/6] KVM: arm64: ioctl to fetch/store tags in a guest
Message-ID: <YJGIBTor+blelKKT@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
 <20210416154309.22129-6-steven.price@arm.com>
 <20210427175844.GB17872@arm.com>
 <340d35c2-46ed-35ea-43fa-e5cb64c27230@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <340d35c2-46ed-35ea-43fa-e5cb64c27230@arm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Apr 29, 2021 at 05:06:07PM +0100, Steven Price wrote:
> On 27/04/2021 18:58, Catalin Marinas wrote:
> > On Fri, Apr 16, 2021 at 04:43:08PM +0100, Steven Price wrote:
> > > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > > index 24223adae150..2b85a047c37d 100644
> > > --- a/arch/arm64/include/uapi/asm/kvm.h
> > > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > > @@ -184,6 +184,20 @@ struct kvm_vcpu_events {
> > >   	__u32 reserved[12];
> > >   };
> > > +struct kvm_arm_copy_mte_tags {
> > > +	__u64 guest_ipa;
> > > +	__u64 length;
> > > +	union {
> > > +		void __user *addr;
> > > +		__u64 padding;
> > > +	};
> > > +	__u64 flags;
> > > +	__u64 reserved[2];
> > > +};
[...]
> > Maybe add the two reserved
> > values to the union in case we want to store something else in the
> > future.
> 
> I'm not sure what you mean here. What would the reserved fields be unioned
> with? And surely they are no longer reserved in that case?

In case you want to keep the structure size the same for future
expansion and the expansion only happens via the union, you'd add some
padding in there just in case. We do this for struct siginfo with an
_si_pad[] array in the union.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
