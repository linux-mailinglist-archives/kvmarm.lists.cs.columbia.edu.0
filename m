Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12E2D455B
	for <lists+kvmarm@lfdr.de>; Wed,  9 Dec 2020 16:27:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B5F654B2DD;
	Wed,  9 Dec 2020 10:27:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9-WK6d8uuEk; Wed,  9 Dec 2020 10:27:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7E8F84B2D8;
	Wed,  9 Dec 2020 10:27:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C11E14B235
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 10:27:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFXPNJQ-sGPB for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Dec 2020 10:27:47 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 697C64B220
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 10:27:47 -0500 (EST)
Date: Wed, 9 Dec 2020 15:27:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
Message-ID: <20201209152741.GC13566@gaia>
References: <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
 <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
 <0d0eb6da6a11f76d10e532c157181985@kernel.org>
 <20201207163405.GD1526@gaia> <874kkx5thq.wl-maz@kernel.org>
 <20201208172143.GB13960@gaia>
 <7ff14490e253878d0735633b792e1ea9@kernel.org>
 <20201209124443.GB13566@gaia>
 <ef14a5158fc65c00f6c3c842cfa83b2c@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef14a5158fc65c00f6c3c842cfa83b2c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave Martin <Dave.Martin@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Price <steven.price@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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

On Wed, Dec 09, 2020 at 01:25:18PM +0000, Marc Zyngier wrote:
> On 2020-12-09 12:44, Catalin Marinas wrote:
> > On Tue, Dec 08, 2020 at 06:21:12PM +0000, Marc Zyngier wrote:
> > > On 2020-12-08 17:21, Catalin Marinas wrote:
> > > > On Mon, Dec 07, 2020 at 07:03:13PM +0000, Marc Zyngier wrote:
> > > > > I wonder whether we will have to have something kernel side to
> > > > > dump/reload tags in a way that matches the patterns used by live
> > > > > migration.
> > > >
> > > > We have something related - ptrace dumps/resores the tags. Can the same
> > > > concept be expanded to a KVM ioctl?
> > > 
> > > Yes, although I wonder whether we should integrate this deeply into
> > > the dirty-log mechanism: it would be really interesting to dump the
> > > tags at the point where the page is flagged as clean from a dirty-log
> > > point of view. As the page is dirtied, discard the saved tags.
> > 
> > From the VMM perspective, the tags can be treated just like additional
> > (meta)data in a page. We'd only need the tags when copying over. It can
> > race with the VM dirtying the page (writing tags would dirty it) but I
> > don't think the current migration code cares about this. If dirtied, it
> > copies it again.
> > 
> > The only downside I see is an extra syscall per page both on the origin
> > VMM and the destination one to dump/restore the tags. Is this a
> > performance issue?
> 
> I'm not sure. Migrating VMs already has a massive overhead, so an extra
> syscall per page isn't terrifying. But that's the point where I admit
> not knowing enough about what the VMM expects, nor whether that matches
> what happens on other architectures that deal with per-page metadata.
> 
> Would this syscall operate on the guest address space? Or on the VMM's
> own mapping?

Whatever is easier for the VMM, I don't think it matters as long as the
host kernel can get the actual physical address (and linear map
correspondent). Maybe simpler if it's the VMM address space as the
kernel can check the access permissions in case you want to hide the
guest memory from the VMM for other reasons (migration is also off the
table).

Without syscalls, an option would be for the VMM to create two mappings:
one with PROT_MTE for migration and the other without for normal DMA
etc. That's achievable using memfd_create() or shm_open() and two mmap()
calls, only one having PROT_MTE. The VMM address space should be
sufficiently large to map two guest IPAs.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
