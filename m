Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 975612D4926
	for <lists+kvmarm@lfdr.de>; Wed,  9 Dec 2020 19:39:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B6734B135;
	Wed,  9 Dec 2020 13:39:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKG2YdFGFIxs; Wed,  9 Dec 2020 13:39:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFDB34B105;
	Wed,  9 Dec 2020 13:39:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D61F94B0E4
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 13:39:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qxsIrErgCCsI for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Dec 2020 13:39:26 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 662614B0D0
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Dec 2020 13:39:26 -0500 (EST)
Date: Wed, 9 Dec 2020 18:39:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
Message-ID: <20201209183920.GI13566@gaia>
References: <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
 <0d0eb6da6a11f76d10e532c157181985@kernel.org>
 <20201207163405.GD1526@gaia> <874kkx5thq.wl-maz@kernel.org>
 <20201208172143.GB13960@gaia>
 <7ff14490e253878d0735633b792e1ea9@kernel.org>
 <20201209124443.GB13566@gaia>
 <ef14a5158fc65c00f6c3c842cfa83b2c@kernel.org>
 <20201209152741.GC13566@gaia>
 <8c39b104-39c3-7cca-82b9-2e47d7cb9a9a@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c39b104-39c3-7cca-82b9-2e47d7cb9a9a@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Marc Zyngier <maz@kernel.org>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Price <steven.price@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dave Martin <Dave.Martin@arm.com>
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

On Wed, Dec 09, 2020 at 12:27:59PM -0600, Richard Henderson wrote:
> On 12/9/20 9:27 AM, Catalin Marinas wrote:
> > On Wed, Dec 09, 2020 at 01:25:18PM +0000, Marc Zyngier wrote:
> >> Would this syscall operate on the guest address space? Or on the VMM's
> >> own mapping?
> ...
> > Whatever is easier for the VMM, I don't think it matters as long as the
> > host kernel can get the actual physical address (and linear map
> > correspondent). Maybe simpler if it's the VMM address space as the
> > kernel can check the access permissions in case you want to hide the
> > guest memory from the VMM for other reasons (migration is also off the
> > table).
> 
> Indeed, such a syscall is no longer specific to vmm's and may be used for any
> bulk move of tags that userland might want.

For CRIU, I think the current ptrace interface would do. With VMMs, the
same remote VM model doesn't apply (the "remote" VM is actually the
guest memory). I'd keep this under a KVM ioctl() number rather than a
new, specific syscall.

> > Without syscalls, an option would be for the VMM to create two mappings:
> > one with PROT_MTE for migration and the other without for normal DMA
> > etc. That's achievable using memfd_create() or shm_open() and two mmap()
> > calls, only one having PROT_MTE. The VMM address space should be
> > sufficiently large to map two guest IPAs.
> 
> I would have thought that the best way is to use TCO, so that we don't have to
> have dual mappings (and however many MB of extra page tables that might imply).

The problem appears when the VMM wants to use MTE itself (e.g. linked
against an MTE-aware glibc), toggling TCO is no longer generic enough,
especially when it comes to device emulation.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
