Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 336662B9ACE
	for <lists+kvmarm@lfdr.de>; Thu, 19 Nov 2020 19:43:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AAA044B581;
	Thu, 19 Nov 2020 13:43:06 -0500 (EST)
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
	with ESMTP id Mokne2jY5XlD; Thu, 19 Nov 2020 13:43:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 913E54B559;
	Thu, 19 Nov 2020 13:43:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B04B4B500
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 13:43:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u8GY8iNKMOeg for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Nov 2020 13:43:03 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1FEBE4B4F6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 13:43:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605811383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y55OZ3OjAK2zbBI3eJj5fJ3qrb+J/+b/r6JS6Ay9OF4=;
 b=OJdcHb32vQbzELfyJRCyjUHQ8OcWIQ68O6lPNmIHXRYX8d7XSTZoOXlKcbwJgPq4Ns85L+
 ePAmHEX5ubKpCDn+CyR7jPMfzKTUqKGL6s5T5eTjzYjPPDE8HNRnw9Dg5K5Ha4Qm+zn9WD
 E3tTXyYrCM9+oJwnSE17FZpt6UJWS88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-S6ZPH1jbP6WK2oA8bMO-Nw-1; Thu, 19 Nov 2020 13:42:59 -0500
X-MC-Unique: S6ZPH1jbP6WK2oA8bMO-Nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAA36107ACE3;
 Thu, 19 Nov 2020 18:42:56 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19EA060BE2;
 Thu, 19 Nov 2020 18:42:50 +0000 (UTC)
Date: Thu, 19 Nov 2020 19:42:48 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
Message-ID: <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: kvmarm <kvmarm@lists.cs.columbia.edu>,
 Catalin Marinas <catalin.marinas@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Nov 19, 2020 at 03:45:40PM +0000, Peter Maydell wrote:
> On Thu, 19 Nov 2020 at 15:39, Steven Price <steven.price@arm.com> wrote:
> > This series adds support for Arm's Memory Tagging Extension (MTE) to
> > KVM, allowing KVM guests to make use of it. This builds on the existing
> > user space support already in v5.10-rc1, see [1] for an overview.
> 
> > The change to require the VMM to map all guest memory PROT_MTE is
> > significant as it means that the VMM has to deal with the MTE tags even
> > if it doesn't care about them (e.g. for virtual devices or if the VMM
> > doesn't support migration). Also unfortunately because the VMM can
> > change the memory layout at any time the check for PROT_MTE/VM_MTE has
> > to be done very late (at the point of faulting pages into stage 2).
> 
> I'm a bit dubious about requring the VMM to map the guest memory
> PROT_MTE unless somebody's done at least a sketch of the design
> for how this would work on the QEMU side. Currently QEMU just
> assumes the guest memory is guest memory and it can access it
> without special precautions...
>

There are two statements being made here:

1) Requiring the use of PROT_MTE when mapping guest memory may not fit
   QEMU well.

2) New KVM features should be accompanied with supporting QEMU code in
   order to prove that the APIs make sense.

I strongly agree with (2). While kvmtool supports some quick testing, it
doesn't support migration. We must test all new features with a migration
supporting VMM.

I'm not sure about (1). I don't feel like it should be a major problem,
but (2).

I'd be happy to help with the QEMU prototype, but preferably when there's
hardware available. Has all the current MTE testing just been done on
simulators? And, if so, are there regression tests regularly running on
the simulators too? And can they test migration? If hardware doesn't
show up quickly and simulators aren't used for regression tests, then
all this code will start rotting from day one.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
