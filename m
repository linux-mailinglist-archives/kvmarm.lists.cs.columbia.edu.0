Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2A292B9A
	for <lists+kvmarm@lfdr.de>; Mon, 19 Oct 2020 18:36:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F03C34B3B3;
	Mon, 19 Oct 2020 12:36:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRl4djPYj0CY; Mon, 19 Oct 2020 12:36:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B1D84B3C6;
	Mon, 19 Oct 2020 12:36:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 422984B3B3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 12:36:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 64iIoKZsFYYy for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Oct 2020 12:36:53 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A3CE34B27A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 12:36:53 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B6151FB;
 Mon, 19 Oct 2020 09:36:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408C73F66B;
 Mon, 19 Oct 2020 09:36:52 -0700 (PDT)
Date: Mon, 19 Oct 2020 17:36:49 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201019163648.GR32292@arm.com>
References: <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
 <20201019113157.GN32292@arm.com>
 <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
 <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
 <CAFEAcA8RB6MTnv0qavxWs28=pbT16i9dT1pd+0Dy9HxPVk+bZA@mail.gmail.com>
 <20201019145839.GO32292@arm.com>
 <20201019152311.csxcz52sawia4imi@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201019152311.csxcz52sawia4imi@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Marc Zyngier <maz@kernel.org>, xu910121@sina.com,
 qemu-devel <qemu-devel@nongnu.org>, kvmarm <kvmarm@lists.cs.columbia.edu>
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

On Mon, Oct 19, 2020 at 05:23:11PM +0200, Andrew Jones wrote:
> On Mon, Oct 19, 2020 at 03:58:40PM +0100, Dave Martin wrote:
> > On Mon, Oct 19, 2020 at 03:18:11PM +0100, Peter Maydell wrote:
> > > On Mon, 19 Oct 2020 at 14:40, Andrew Jones <drjones@redhat.com> wrote:
> > > >
> > > > On Mon, Oct 19, 2020 at 12:43:33PM +0100, Peter Maydell wrote:
> > > > > Well, ID regs are special in the architecture -- they always exist
> > > > > and must RAZ/WI, even if they're not actually given any fields yet.
> > > > > This is different from other "unused" parts of the system register
> > > > > encoding space, which UNDEF.
> > > >
> > > > Table D12-2 confirms the register should be RAZ, as it says the register
> > > > is "RO, but RAZ if SVE is not implemented". Does "RO" imply "WI", though?
> > > > For the guest we inject an exception on writes, and for userspace we
> > > > require the value to be preserved on write.
> > > 
> > > Sorry, I mis-spoke. They're RAZ, but not WI, just RO (which is to say
> > > they'll UNDEF if you try to write to them).
> > > 
> > > > I think we should follow the spec, even for userspace access, and be RAZ
> > > > for when the feature isn't implemented. As for writes, assuming the
> > > > exception injection is what we want for the guest (not WI), then that's
> > > > correct. For userspace, I think we should continue forcing preservation
> > > > (which will force preservation of zero when it's RAZ).
> > > 
> > > Yes, that sounds right.
> > 
> > [...]
> > 
> > > > > The problem is that you've actually removed registers from
> > > > > the list that were previously in it (because pre-SVE
> > > > > kernels put this ID register in the list as a RAZ/WI register,
> > > > > and now it's not in the list if SVE isn't supported).
> > 
> > Define "previously", though.  IIUC, the full enumeration was added in
> > v4.15 (with ID_AA64ZFR0_EL1 still not supported at all):
> > 
> > v4.15-rc1~110^2~27
> > 93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from guests")
> > 
> > 
> > And then ID_AA64FZR0_EL1 was removed from the enumeration, also in
> > v4.15:
> > 
> > v4.15-rc1~110^2~5
> > 07d79fe7c223 ("arm64/sve: KVM: Hide SVE from CPU features exposed to guests")
> > 
> > 
> > So, are there really two upstram kernel tags that are mismatched on
> > this, or is this just a bisectability issue in v4.14..v4.15?
> > 
> > It's a while since I looked at this, and I may have misunderstood the
> > timeline.
> > 
> > 
> > > > > > So, I think that instead of changing the ID_AA64ZFR0_EL1 behaviour,
> > > > > > parhaps we should move all ID_UNALLOCATED() regs (and possibly
> > > > > > ID_HIDDEN(), not sure about that) to have REG_HIDDEN_USER visibility.
> > > > >
> > > > > What does this do as far as the user-facing list-of-registers
> > > > > is concerned? All these registers need to remain in the
> > > > > KVM_GET_REG_LIST list, or you break migration from an old
> > > > > kernel to a new one.
> > 
> > OK, I think I see where you are coming from, now.
> > 
> > It may make sense to get rid of the REG_HIDDEN_GUEST / REG_HIDDEN_USER
> > distinction, and provide the same visibility for userspace as for MSR/
> > MRS all the time.  This would restore ID_AA64ZFR0_EL1 into the userspace
> > view, and may also allow a bit of simplification in the code.
> > 
> > Won't this will still break migration from the resulting kernel to a
> > current kernel that hides ID_AA64ZFR0_EL1?  Or have I misunderstood
> > something.
> >
> 
> Yes, but, while neither direction old -> new nor new -> old is actually
> something that people should do when using host cpu passthrough (they
> should only ever migrate between identical hosts, both hardware and
> host kernel version), migrating from old -> new makes more sense, as
> that's the upgrade path, and it's more supportable - we can workaround
> things on the new side. So, long story short, new -> old will fail due
> to making this change, but it's still probably the right thing to do,
> as we'll be defining a better pattern for ID registers going forward,
> and we never claimed new -> old migrations would work anyway with host
> passthrough.
> 
> Thanks,
> drew

Ack, just wanted to make sure I understood the implications correctly.

I'm still not sure I fully understand why we hit this problem (i.e.,
ZFR0 enumeration mismatch between host and guest) in the first place,
unless I've misunderstood which patches make these changes, or unless
RHEL has cherry-picked odd patches that weren't intended to be applied
separately...

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
