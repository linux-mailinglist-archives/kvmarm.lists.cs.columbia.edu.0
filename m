Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4538D8D
	for <lists+kvmarm@lfdr.de>; Fri,  7 Jun 2019 16:42:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 00FEA4A479;
	Fri,  7 Jun 2019 10:42:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lluYfRpPKadX; Fri,  7 Jun 2019 10:42:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C185F4A4C9;
	Fri,  7 Jun 2019 10:42:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E8D464A36B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jun 2019 10:42:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PXvmt5lNPtp for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Jun 2019 10:42:35 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 745B14A3B2
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jun 2019 10:42:35 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CE78337;
 Fri,  7 Jun 2019 07:42:35 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05C733F71A;
 Fri,  7 Jun 2019 07:42:33 -0700 (PDT)
Date: Fri, 7 Jun 2019 15:42:31 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Message-ID: <20190607144229.GF28398@e103592.cambridge.arm.com>
References: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
 <20190604095915.GW28398@e103592.cambridge.arm.com>
 <20190607060037.eaof3hllyombxlhc@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190607060037.eaof3hllyombxlhc@vireshk-i7>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Fri, Jun 07, 2019 at 11:30:37AM +0530, Viresh Kumar wrote:
> On 04-06-19, 10:59, Dave Martin wrote:
> > On Tue, Jun 04, 2019 at 10:13:19AM +0530, Viresh Kumar wrote:
> > > We currently get following compilation warning:
> > > 
> > > arch/arm64/kvm/guest.c: In function 'set_sve_vls':
> > > arch/arm64/kvm/guest.c:262:18: warning: passing argument 1 of 'vq_present' from incompatible pointer type
> > > arch/arm64/kvm/guest.c:212:13: note: expected 'const u64 (* const)[8]' but argument is of type 'u64 (*)[8]'
> > > 
> > > The argument can't be const, as it is copied at runtime using
> > > copy_from_user(). Drop const from the prototype of vq_present().
> > > 
> > > Fixes: 9033bba4b535 ("KVM: arm64/sve: Add pseudo-register for the guest's vector lengths")
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  arch/arm64/kvm/guest.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > > index 3ae2f82fca46..78f5a4f45e0a 100644
> > > --- a/arch/arm64/kvm/guest.c
> > > +++ b/arch/arm64/kvm/guest.c
> > > @@ -209,7 +209,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> > >  #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
> > >  
> > >  static bool vq_present(
> > > -	const u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
> > > +	u64 (*const vqs)[KVM_ARM64_SVE_VLS_WORDS],
> > >  	unsigned int vq)
> > >  {
> > >  	return (*vqs)[vq_word(vq)] & vq_mask(vq);
> > 
> > Ack, but maybe this should just be converted to a macro?
> 
> I will send a patch with that if that's what you want.

I think this would solve the problem and simplify the code a bit at the
same time.

So go for it.

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
