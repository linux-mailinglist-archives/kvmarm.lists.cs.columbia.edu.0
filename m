Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 81D91ACA0C
	for <lists+kvmarm@lfdr.de>; Sun,  8 Sep 2019 01:53:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC6A34A58E;
	Sat,  7 Sep 2019 19:53:14 -0400 (EDT)
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
	with ESMTP id ODi0GEVPyQCj; Sat,  7 Sep 2019 19:53:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 522754A555;
	Sat,  7 Sep 2019 19:53:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8D494A534
 for <kvmarm@lists.cs.columbia.edu>; Sat,  7 Sep 2019 19:53:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qPuujCIiIG38 for <kvmarm@lists.cs.columbia.edu>;
 Sat,  7 Sep 2019 19:53:09 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B57374A500
 for <kvmarm@lists.cs.columbia.edu>; Sat,  7 Sep 2019 19:53:09 -0400 (EDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 66C4921835
 for <kvmarm@lists.cs.columbia.edu>; Sat,  7 Sep 2019 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1567900388;
 bh=KU+yu1dnpjqMkvaxD0NQ/62kFYi8GAP69zuvLWhpBPg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=iQhzSJ+9oXgDhIW7PRJgS7OAd27+ApcmlwV1Pr1t7tIdVxFSSbNmEPtHB+EVkx/QI
 3oFy7UEQ8OJz3CxRjUYWmyWOwvSBH4uR+n5qkd1ZBcZeaqG5m2rMeo15JOhhtEIi6O
 gZUNlX9yNbmazWAWH7DCrTZAkCxjkeJuFftVnO9s=
Received: by mail-wm1-f54.google.com with SMTP id t17so9948296wmi.2
 for <kvmarm@lists.cs.columbia.edu>; Sat, 07 Sep 2019 16:53:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWWyyjdizFXxbIqA7SOyMc6nucwt63pXt+/FXtt/31V9hMmP8nj
 NMBEu7KxQVt1J7fUaxiVVmUfT1fnTjAzvhbe43o=
X-Google-Smtp-Source: APXvYqz/EaoziXhxATPtaiz7WMpDkudp2uTSNKWYfbpcDLkqo0GVOyZavKTFmq2PKcMvW87cxTCwTetw/AbRtRbW9aM=
X-Received: by 2002:a1c:f007:: with SMTP id a7mr12784687wmb.172.1567900386906; 
 Sat, 07 Sep 2019 16:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
 <20190619091219.GB7767@fuggles.cambridge.arm.com>
 <CAJF2gTTmFq3yYa9UrdZRAFwJgC=KmKTe2_NFy_UZBUQovqQJPg@mail.gmail.com>
 <20190619123939.GF7767@fuggles.cambridge.arm.com>
 <CAJF2gTSiiiewTLwVAXvPLO7rTSUw1rg8VtFLzANdP2S2EEbTjg@mail.gmail.com>
 <20190624104006.lvm32nahemaqklxc@willie-the-truck>
In-Reply-To: <20190624104006.lvm32nahemaqklxc@willie-the-truck>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 8 Sep 2019 07:52:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
Message-ID: <CAJF2gTSC1sGgmiTCgzKUTdPyUZ3LG4H7N8YbMyWr-E+eifGuYg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 Atish Patra <Atish.Patra@wdc.com>, Julien Grall <julien.grall@arm.com>,
 gary@garyguo.net, linux-riscv@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, Mike Rapoport <rppt@linux.ibm.com>,
 Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-arm-kernel@lists.infradead.org,
 Anup Patel <anup.Patel@wdc.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org
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

Thx Will,

On Mon, Jun 24, 2019 at 6:40 PM Will Deacon <will@kernel.org> wrote:
> > I'll keep my system use the same ASID for SMP + IOMMU :P
>
> You will want a separate allocator for that:
>
> https://lkml.kernel.org/r/20190610184714.6786-2-jean-philippe.brucker@arm.com

Yes, it is hard to maintain ASID between IOMMU and CPUMMU or different
system, because it's difficult to synchronize the IO_ASID when the CPU
ASID is rollover.
But we could still use hardware broadcast TLB invalidation instruction
to uniformly manage the ASID and IO_ASID, or OTHER_ASID in our IOMMU.

Welcome to join our disscusion:
"Introduce an implementation of IOMMU in linux-riscv"
9 Sep 2019, 10:45 Jade-room-I&II (Corinthia Hotel Lisbon) RISC-V MC

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
