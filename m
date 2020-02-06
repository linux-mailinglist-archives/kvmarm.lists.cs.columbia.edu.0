Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF24154A0E
	for <lists+kvmarm@lfdr.de>; Thu,  6 Feb 2020 18:13:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A757F4A541;
	Thu,  6 Feb 2020 12:13:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level: 
X-Spam-Status: No, score=0.099 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n4DsYNRWKEdt; Thu,  6 Feb 2020 12:13:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C4C44A522;
	Thu,  6 Feb 2020 12:13:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9DCE14A4FC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 12:13:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tEXKUP4a7Xp1 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Feb 2020 12:13:09 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 529CE4A389
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 12:13:09 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E069D1FB;
 Thu,  6 Feb 2020 09:13:08 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC5873F68E;
 Thu,  6 Feb 2020 09:13:07 -0800 (PST)
Date: Thu, 6 Feb 2020 17:13:05 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH kvmtool] Add emulation for CFI compatible flash memory
Message-ID: <20200206171305.4029832c@donnerap.cambridge.arm.com>
In-Reply-To: <20200206144211.34a27285@donnerap.cambridge.arm.com>
References: <20200108183212.252810-1-andre.przywara@arm.com>
 <20200205171156.GA908@willie-the-truck>
 <20200206144211.34a27285@donnerap.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: Raphael Gault <raphael.gault@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, kvmarm@lists.cs.columbia.edu,
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

On Thu, 6 Feb 2020 14:42:11 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

Hi,

> On Wed, 5 Feb 2020 17:11:57 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> Hi Will,
> 
> many thanks for having a look!
> 
> > On Wed, Jan 08, 2020 at 06:32:12PM +0000, Andre Przywara wrote:  
> > > From: Raphael Gault <raphael.gault@arm.com>

[ ... ]

> > > +/* We only support synchronous page mode read accesses. */
> > > +static void read_flash(struct cfi_flash_device *sfdev,
> > > +		       u64 addr, u8 *buffer, int len)
> > > +{
> > > +	memcpy(buffer, sfdev->flash_memory + addr, len);
> > > +}    
> > 
> > Hmm, you open-code the memcpy when writing the flash so it's a bit weird  
> 
> Not sure what you refer to exactly?
> The only open-code access I see is in the MMIO handler when doing the CFI QRY *read*, which is a very special MMIO style read access. Every other write access (word_program(), buffer_confirm()) is already using memcpy.
> What am I missing here?

Robin pointed out that you probably mean that there is a wrapper around the memcpy on read_flash, but not on the write operations?
The reason for that is that read and write are two very different operations on any flash memory: the read side is following proper memory semantics: no side effects, could be cached, etc. I was briefly tempted to actually map it r/o into the guest, but the problem is that this semantics only holds when we are in read mode. In any other mode and whenever we write, the CFI flash is actually an MMIO mapped device, where each access triggers something and the access width matters. So that would require frequently changing the memslot, because we need to trap reads when not in read mode.

Anyway, adding a write wrapper doesn't make sense here, but I can of course easily replace the read_flash() call with the respective memcpy() line.

Cheers,
Andre
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
