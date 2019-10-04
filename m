Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4595ACB4C5
	for <lists+kvmarm@lfdr.de>; Fri,  4 Oct 2019 09:03:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 801A94A60F;
	Fri,  4 Oct 2019 03:03:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyoA8dNxOKxf; Fri,  4 Oct 2019 03:03:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E60E4A5F0;
	Fri,  4 Oct 2019 03:03:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C7EE44A5CD
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Oct 2019 03:03:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BOI-e-dvm1II for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Oct 2019 03:03:10 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 86CA54A598
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Oct 2019 03:03:10 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 781B920F0;
 Fri,  4 Oct 2019 07:03:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F32B5D9DC;
 Fri,  4 Oct 2019 07:03:03 +0000 (UTC)
Date: Fri, 4 Oct 2019 09:03:01 +0200
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v5 05/10] KVM: arm64: Support stolen time reporting via
 shared structure
Message-ID: <20191004070301.d7ari5rjlu3uuara@kamzik.brq.redhat.com>
References: <20191002145037.51630-1-steven.price@arm.com>
 <20191002145037.51630-6-steven.price@arm.com>
 <20191003132235.ruanyfmdim5s6npj@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191003132235.ruanyfmdim5s6npj@kamzik.brq.redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 04 Oct 2019 07:03:09 +0000 (UTC)
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Thu, Oct 03, 2019 at 03:22:35PM +0200, Andrew Jones wrote:
> On Wed, Oct 02, 2019 at 03:50:32PM +0100, Steven Price wrote:
> > +int kvm_update_stolen_time(struct kvm_vcpu *vcpu, bool init)
> > +{
> > +	struct kvm *kvm = vcpu->kvm;
> > +	u64 steal;
> > +	u64 steal_le;
> > +	u64 offset;
> > +	int idx;
> > +	u64 base = vcpu->arch.steal.base;
> > +
> > +	if (base == GPA_INVALID)
> > +		return -ENOTSUPP;
> > +
> > +	/* Let's do the local bookkeeping */
> > +	steal = vcpu->arch.steal.steal;
> > +	steal += current->sched_info.run_delay - vcpu->arch.steal.last_steal;
> > +	vcpu->arch.steal.last_steal = current->sched_info.run_delay;
> > +	vcpu->arch.steal.steal = steal;
> > +
> > +	steal_le = cpu_to_le64(steal);
> 
> Agreeing on a byte order for this interface makes sense, but I don't see
> it documented anywhere. Is this an SMCCC thing? Because I skimmed some
> of those specs and other users too but didn't see anything obvious. Anyway
> even if everybody but me knows that all data returned from SMCCC calls
> should be LE, it might be nice to document that in the pvtime doc.
>

I have another [potentially dumb] SMCCC byte order question. If we need
to worry about using LE for the members of this structure, then why don't
we need to worry about the actual return values of the SMCCC calls? Like
the IPA of the structure?

Thanks,
drew
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
