Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B774D292A4E
	for <lists+kvmarm@lfdr.de>; Mon, 19 Oct 2020 17:23:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 395594B2CC;
	Mon, 19 Oct 2020 11:23:25 -0400 (EDT)
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
	with ESMTP id izfBZaW5U5QA; Mon, 19 Oct 2020 11:23:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0789B4B349;
	Mon, 19 Oct 2020 11:23:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 261324B2CF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 11:23:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cf9WIdS6WeFc for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Oct 2020 11:23:21 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A5364B2CC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 11:23:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603121000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8qqe4i/Zi2sPJmvXzSJ7X87OrF4YFyucaDslDr3ii2k=;
 b=PZBezrplqaUyS2WzPPVleSNBWa4tzjsAEffRH1qiWwQ55StJqPLBsqsP7VpZFs5j0QnC88
 +2fB6K2mEi+l3oi7pERBk7NhvQ18KsYKZUnYSevMe1wM7paLrduBe6vxAzbw5SE1fjmjsh
 xMNIZNMoUpNC4W82wHpznm3POVmrF7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-cXtUVPOHN9uPi8dHsLPXhg-1; Mon, 19 Oct 2020 11:23:17 -0400
X-MC-Unique: cXtUVPOHN9uPi8dHsLPXhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C574A8049C1;
 Mon, 19 Oct 2020 15:23:15 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F5F410013D0;
 Mon, 19 Oct 2020 15:23:13 +0000 (UTC)
Date: Mon, 19 Oct 2020 17:23:11 +0200
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201019152311.csxcz52sawia4imi@kamzik.brq.redhat.com>
References: <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
 <20201019113157.GN32292@arm.com>
 <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
 <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
 <CAFEAcA8RB6MTnv0qavxWs28=pbT16i9dT1pd+0Dy9HxPVk+bZA@mail.gmail.com>
 <20201019145839.GO32292@arm.com>
MIME-Version: 1.0
In-Reply-To: <20201019145839.GO32292@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel <qemu-devel@nongnu.org>, xu910121@sina.com,
 kvmarm <kvmarm@lists.cs.columbia.edu>, Marc Zyngier <maz@kernel.org>
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

On Mon, Oct 19, 2020 at 03:58:40PM +0100, Dave Martin wrote:
> On Mon, Oct 19, 2020 at 03:18:11PM +0100, Peter Maydell wrote:
> > On Mon, 19 Oct 2020 at 14:40, Andrew Jones <drjones@redhat.com> wrote:
> > >
> > > On Mon, Oct 19, 2020 at 12:43:33PM +0100, Peter Maydell wrote:
> > > > Well, ID regs are special in the architecture -- they always exist
> > > > and must RAZ/WI, even if they're not actually given any fields yet.
> > > > This is different from other "unused" parts of the system register
> > > > encoding space, which UNDEF.
> > >
> > > Table D12-2 confirms the register should be RAZ, as it says the register
> > > is "RO, but RAZ if SVE is not implemented". Does "RO" imply "WI", though?
> > > For the guest we inject an exception on writes, and for userspace we
> > > require the value to be preserved on write.
> > 
> > Sorry, I mis-spoke. They're RAZ, but not WI, just RO (which is to say
> > they'll UNDEF if you try to write to them).
> > 
> > > I think we should follow the spec, even for userspace access, and be RAZ
> > > for when the feature isn't implemented. As for writes, assuming the
> > > exception injection is what we want for the guest (not WI), then that's
> > > correct. For userspace, I think we should continue forcing preservation
> > > (which will force preservation of zero when it's RAZ).
> > 
> > Yes, that sounds right.
> 
> [...]
> 
> > > > The problem is that you've actually removed registers from
> > > > the list that were previously in it (because pre-SVE
> > > > kernels put this ID register in the list as a RAZ/WI register,
> > > > and now it's not in the list if SVE isn't supported).
> 
> Define "previously", though.  IIUC, the full enumeration was added in
> v4.15 (with ID_AA64ZFR0_EL1 still not supported at all):
> 
> v4.15-rc1~110^2~27
> 93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from guests")
> 
> 
> And then ID_AA64FZR0_EL1 was removed from the enumeration, also in
> v4.15:
> 
> v4.15-rc1~110^2~5
> 07d79fe7c223 ("arm64/sve: KVM: Hide SVE from CPU features exposed to guests")
> 
> 
> So, are there really two upstram kernel tags that are mismatched on
> this, or is this just a bisectability issue in v4.14..v4.15?
> 
> It's a while since I looked at this, and I may have misunderstood the
> timeline.
> 
> 
> > > > > So, I think that instead of changing the ID_AA64ZFR0_EL1 behaviour,
> > > > > parhaps we should move all ID_UNALLOCATED() regs (and possibly
> > > > > ID_HIDDEN(), not sure about that) to have REG_HIDDEN_USER visibility.
> > > >
> > > > What does this do as far as the user-facing list-of-registers
> > > > is concerned? All these registers need to remain in the
> > > > KVM_GET_REG_LIST list, or you break migration from an old
> > > > kernel to a new one.
> 
> OK, I think I see where you are coming from, now.
> 
> It may make sense to get rid of the REG_HIDDEN_GUEST / REG_HIDDEN_USER
> distinction, and provide the same visibility for userspace as for MSR/
> MRS all the time.  This would restore ID_AA64ZFR0_EL1 into the userspace
> view, and may also allow a bit of simplification in the code.
> 
> Won't this will still break migration from the resulting kernel to a
> current kernel that hides ID_AA64ZFR0_EL1?  Or have I misunderstood
> something.
>

Yes, but, while neither direction old -> new nor new -> old is actually
something that people should do when using host cpu passthrough (they
should only ever migrate between identical hosts, both hardware and
host kernel version), migrating from old -> new makes more sense, as
that's the upgrade path, and it's more supportable - we can workaround
things on the new side. So, long story short, new -> old will fail due
to making this change, but it's still probably the right thing to do,
as we'll be defining a better pattern for ID registers going forward,
and we never claimed new -> old migrations would work anyway with host
passthrough.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
