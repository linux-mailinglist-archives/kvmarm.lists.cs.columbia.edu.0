Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F0CAF2D424C
	for <lists+kvmarm@lfdr.de>; Wed,  9 Dec 2020 13:44:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77FAE4B1A5;
	Wed,  9 Dec 2020 07:44:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsbHk9XnBxqQ; Wed,  9 Dec 2020 07:44:53 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D8774B2CF;
	Wed,  9 Dec 2020 07:44:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A20464B1C0
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 07:44:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Utfqr0QowxXX for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Dec 2020 07:44:49 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8CC094B1A5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 07:44:49 -0500 (EST)
Date: Wed, 9 Dec 2020 12:44:43 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
Message-ID: <20201209124443.GB13566@gaia>
References: <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
 <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
 <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
 <0d0eb6da6a11f76d10e532c157181985@kernel.org>
 <20201207163405.GD1526@gaia> <874kkx5thq.wl-maz@kernel.org>
 <20201208172143.GB13960@gaia>
 <7ff14490e253878d0735633b792e1ea9@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7ff14490e253878d0735633b792e1ea9@kernel.org>
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

On Tue, Dec 08, 2020 at 06:21:12PM +0000, Marc Zyngier wrote:
> On 2020-12-08 17:21, Catalin Marinas wrote:
> > On Mon, Dec 07, 2020 at 07:03:13PM +0000, Marc Zyngier wrote:
> > > I wonder whether we will have to have something kernel side to
> > > dump/reload tags in a way that matches the patterns used by live
> > > migration.
> > 
> > We have something related - ptrace dumps/resores the tags. Can the same
> > concept be expanded to a KVM ioctl?
> 
> Yes, although I wonder whether we should integrate this deeply into
> the dirty-log mechanism: it would be really interesting to dump the
> tags at the point where the page is flagged as clean from a dirty-log
> point of view. As the page is dirtied, discard the saved tags.

From the VMM perspective, the tags can be treated just like additional
(meta)data in a page. We'd only need the tags when copying over. It can
race with the VM dirtying the page (writing tags would dirty it) but I
don't think the current migration code cares about this. If dirtied, it
copies it again.

The only downside I see is an extra syscall per page both on the origin
VMM and the destination one to dump/restore the tags. Is this a
performance issue?

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
