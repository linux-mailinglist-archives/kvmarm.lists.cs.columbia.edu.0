Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1135820CE10
	for <lists+kvmarm@lfdr.de>; Mon, 29 Jun 2020 13:05:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96CA34B3CE;
	Mon, 29 Jun 2020 07:05:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rm60JL1j6jn6; Mon, 29 Jun 2020 07:05:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6997E4B3EC;
	Mon, 29 Jun 2020 07:05:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 555A34B35B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Jun 2020 07:05:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nUpKmUV-FRzG for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Jun 2020 07:05:18 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3BAC24B332
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Jun 2020 07:05:18 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D37F313D5;
 Mon, 29 Jun 2020 04:05:17 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.20.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5C03F73C;
 Mon, 29 Jun 2020 04:05:16 -0700 (PDT)
Date: Mon, 29 Jun 2020 12:05:13 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/2] kvm/arm64: Rename HSR to ESR
Message-ID: <20200629110513.GC59769@C02TD0UTHF1T.local>
References: <20200629091841.88198-1-gshan@redhat.com>
 <20200629091841.88198-2-gshan@redhat.com>
 <20200629103208.GA59769@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629103208.GA59769@C02TD0UTHF1T.local>
Cc: catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Mon, Jun 29, 2020 at 11:32:08AM +0100, Mark Rutland wrote:
> On Mon, Jun 29, 2020 at 07:18:40PM +1000, Gavin Shan wrote:
> > kvm/arm32 isn't supported since commit 541ad0150ca4 ("arm: Remove
> > 32bit KVM host support"). So HSR isn't meaningful since then. This
> > renames HSR to ESR accordingly. This shouldn't cause any functional
> > changes:
> > 
> >    * Rename kvm_vcpu_get_hsr() to kvm_vcpu_get_esr() to make the
> >      function names self-explanatory.
> >    * Rename variables from @hsr to @esr to make them self-explanatory.
> > 
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> At a high-level, I agree that we should move to the `esr` naming to
> match the architecture and minimize surprise. However, I think there are
> some ABI changes here, which *are* funcitonal changes, and those need to
> be avoided.
> 
> [...]
> 
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index ba85bb23f060..d54345573a88 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -140,7 +140,7 @@ struct kvm_guest_debug_arch {
> >  };
> >  
> >  struct kvm_debug_exit_arch {
> > -	__u32 hsr;
> > +	__u32 esr;
> >  	__u64 far;	/* used for watchpoints */
> >  };
> 
> This is userspace ABI, and changing this *will* break userspace. This
> *is* a functional change.

To be slightly clearer: while the structure isn't changed, any userspace
software consuming this header will fail to build after this change,
beacause there will no longer be a field called `hsr`.

Existing binaries will almost certianly not care, but regardless this is
a regression (when building userspce) that I don't think we can permit.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
