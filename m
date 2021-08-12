Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AD91B3EA0E9
	for <lists+kvmarm@lfdr.de>; Thu, 12 Aug 2021 10:46:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 294CB49F8F;
	Thu, 12 Aug 2021 04:46:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cF24CmbCLeq; Thu, 12 Aug 2021 04:46:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 022CA49F5F;
	Thu, 12 Aug 2021 04:46:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 299B340856
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 04:46:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lLFu8+iddPLm for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Aug 2021 04:46:08 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 30BCA40825
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 04:46:08 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDB6960724;
 Thu, 12 Aug 2021 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628757967;
 bh=bkl8tFQVs/zWYEgsZnhecDk9futAxtTTe8bCKKSsTbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z2xEWPhGXCC3hYjkoOwVu5NNCZixMYARc4Obyms3/6Sll6y15fu++5hzxXpe19DRx
 EhYSelrSgMUtSRqyyDWoF8aU53SNNBsMCsz/oE1a4Uuykg/PmfSuwKpWM4U79UjcjE
 +FBepWdxQ0UofglZOQAgBIFc0zgMNmwtCFs5QKkE1WVMSyRs6H81uDgVkBCE3TMCQT
 y2qrz0rXzvSbQ/LZ9GLhqbQZvxvyXibIhBqjF+zWrad975+NrHB7Dkuo6l4SolV8BY
 tYsvlHdHLIUVh0obkeNpkUiMjQxgXhdLk7xcfRf7X1DIiR/ZBnWyhOL0KdnJb9n2dq
 AxUNUinPIaNCg==
Date: Thu, 12 Aug 2021 09:46:01 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 06/15] KVM: arm64: Restore mdcr_el2 from vcpu
Message-ID: <20210812084600.GA5912@willie-the-truck>
References: <20210719160346.609914-1-tabba@google.com>
 <20210719160346.609914-7-tabba@google.com>
 <20210720145258.axhqog3abdvtpqhw@gator>
 <CA+EHjTweLPu+DQ8hR9kEW0LrawtaoAoXR_+HmSEZpP-XOEm2qg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+EHjTweLPu+DQ8hR9kEW0LrawtaoAoXR_+HmSEZpP-XOEm2qg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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

On Wed, Jul 21, 2021 at 08:37:21AM +0100, Fuad Tabba wrote:
> On Tue, Jul 20, 2021 at 3:53 PM Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Mon, Jul 19, 2021 at 05:03:37PM +0100, Fuad Tabba wrote:
> > > On deactivating traps, restore the value of mdcr_el2 from the
> > > newly created and preserved host value vcpu context, rather than
> > > directly reading the hardware register.
> > >
> > > Up until and including this patch the two values are the same,
> > > i.e., the hardware register and the vcpu one. A future patch will
> > > be changing the value of mdcr_el2 on activating traps, and this
> > > ensures that its value will be restored.
> > >
> > > No functional change intended.
> >
> > I'm probably missing something, but I can't convince myself that the host
> > will end up with the same mdcr_el2 value after deactivating traps after
> > this patch as before. We clearly now restore whatever we had when
> > activating traps (presumably whatever we configured at init_el2_state
> > time), but is that equivalent to what we had before with the masking and
> > ORing that this patch drops?
> 
> You're right. I thought that these were actually being initialized to
> the same values, but having a closer look at the code the mdcr values
> are not the same as pre-patch. I will fix this.

Can you elaborate on the issue here, please? I was just looking at this
but aren't you now relying on __init_el2_debug to configure this, which
should be fine?

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
