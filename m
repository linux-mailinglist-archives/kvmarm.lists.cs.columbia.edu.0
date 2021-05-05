Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7461637475A
	for <lists+kvmarm@lfdr.de>; Wed,  5 May 2021 20:02:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A73B74B5AB;
	Wed,  5 May 2021 14:02:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CrWadxd8zw70; Wed,  5 May 2021 14:02:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A43424B521;
	Wed,  5 May 2021 14:02:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E722F4B510
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 May 2021 14:02:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfCvyx-mejYr for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 May 2021 14:02:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CB9D54B508
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 May 2021 14:02:36 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB46861176;
 Wed,  5 May 2021 18:02:33 +0000 (UTC)
Date: Wed, 5 May 2021 19:02:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/2] vfio/pci: keep the prefetchable attribute of a BAR
 region in VMA
Message-ID: <20210505180228.GA3874@arm.com>
References: <878s4zokll.wl-maz@kernel.org>
 <BL0PR12MB2532CC436EBF626966B15994BD5E9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <87eeeqvm1d.wl-maz@kernel.org>
 <BL0PR12MB25329EF5DFA7BBAA732064A7BD5C9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <87bl9sunnw.wl-maz@kernel.org>
 <c1bd514a531988c9@bloch.sibelius.xs4all.nl>
 <BL0PR12MB253296086906C4A850EC68E6BD5B9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <20210503084432.75e0126d@x1.home.shazbot.org>
 <BL0PR12MB2532BEAE226E7D68A8A2F97EBD5B9@BL0PR12MB2532.namprd12.prod.outlook.com>
 <20210504083005.GA12290@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210504083005.GA12290@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Sequeira <jsequeira@nvidia.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

On Tue, May 04, 2021 at 09:30:05AM +0100, Will Deacon wrote:
> On Mon, May 03, 2021 at 10:03:59PM +0000, Vikram Sethi wrote:
> > Will/Catalin, perhaps you could explain your thought process on why you chose
> > Normal NC for ioremap_wc on the armv8 linux port instead of Device GRE or other
> > Device Gxx. 
> 
> I think a combination of: compatibility with 32-bit Arm, the need to
> support unaligned accesses and the potential for higher performance.

IIRC the _wc suffix also matches the pgprot_writecombine() used by some
drivers to map a video framebuffer into user space. Accesses to the
framebuffer are not guaranteed to be aligned (memset/memcpy don't ensure
alignment on arm64 and the user doesn't have a memset_io or memcpy_toio).

> Furthermore, ioremap() already gives you a Device memory type, and we're
> tight on MAIR space.

We have MT_DEVICE_GRE currently reserved though no in-kernel user, we
might as well remove it.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
