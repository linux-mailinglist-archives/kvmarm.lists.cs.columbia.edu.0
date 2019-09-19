Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74275B7A9F
	for <lists+kvmarm@lfdr.de>; Thu, 19 Sep 2019 15:37:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DEAC24A6C4;
	Thu, 19 Sep 2019 09:37:16 -0400 (EDT)
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
	with ESMTP id GPGOfLullbXj; Thu, 19 Sep 2019 09:37:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98D6D4A6BF;
	Thu, 19 Sep 2019 09:37:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7220C4A677
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Sep 2019 09:37:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9l9yfCjbukV2 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Sep 2019 09:37:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 224074A671
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Sep 2019 09:37:13 -0400 (EDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D4227222C1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Sep 2019 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568900232;
 bh=4h3Wk30EhI1KisIg5rn7cH+Dc4+DOKJ7JCZLxO6zmPI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mwBzoNaTiK9xjLVihi6v8b+ryPsg0IP++84Wia1oIqwwNfxtQ14YDYKpBHJ3dYMni
 fBW0yG7v0NaSg/4OkKv0v7bY4ZNVgMqn10+8QuxFJes4isxMfpfRJSSSnElwMfLq/C
 aLk1/rm+0igwywEd+xuqNGYA8E4GRYk48izsxAtU=
Received: by mail-wr1-f42.google.com with SMTP id n14so3112728wrw.9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Sep 2019 06:37:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUR8uy9ovKSOJF8mONp/hCYS6xDbY8njzfe9ICI+tWkJHrO/9xS
 w6Z3NzR7v74+De935U2E2LQw48OvW1Pq06jrtis=
X-Google-Smtp-Source: APXvYqzlXvVrim8rTycGbIV+PmHAEsjEw4YXguoJ0i5mulID6kS2AA+pRkt/c/jlP2DTaZZMrey31vSOQlTtKW2gKOA=
X-Received: by 2002:a5d:6b49:: with SMTP id x9mr6988060wrw.80.1568900230203;
 Thu, 19 Sep 2019 06:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190912140256.fwbutgmadpjbjnab@willie-the-truck>
 <mhng-166dcd4f-9483-4aab-a83a-914d70ddb5a4@palmer-si-x1e>
 <MN2PR04MB606117F2AC47385EF23D267D8D8D0@MN2PR04MB6061.namprd04.prod.outlook.com>
 <20190916181800.7lfpt3t627byoomt@willie-the-truck>
 <MN2PR04MB60612846CD50ED157DE5AB548D8F0@MN2PR04MB6061.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB60612846CD50ED157DE5AB548D8F0@MN2PR04MB6061.namprd04.prod.outlook.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 19 Sep 2019 21:36:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRu4cSPd09mXkUOxnL2HO0wnAzqeVr3a3He0AFGCFD00g@mail.gmail.com>
Message-ID: <CAJF2gTRu4cSPd09mXkUOxnL2HO0wnAzqeVr3a3He0AFGCFD00g@mail.gmail.com>
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To: Anup Patel <Anup.Patel@wdc.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 Atish Patra <Atish.Patra@wdc.com>,
 "julien.grall@arm.com" <julien.grall@arm.com>,
 "gary@garyguo.net" <gary@garyguo.net>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
 Christoph Hellwig <hch@infradead.org>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi,

On Tue, Sep 17, 2019 at 11:42 AM Anup Patel <Anup.Patel@wdc.com> wrote:

> >
> > With a reply stating that the patch "absolutely does not work" ;)
>
> This patch was tested on existing HW (which does not have ASID implementation)
> and tested on QEMU (which has very simplistic Implementation of ASID).
>
> When I asked Gary Guo about way to get access to their HW (in same patch
> email thread), I did not get any reply. After so many months passed, I now
> doubt the his comment "absolutely does not work".
> >
> > What exactly do you want people to do with that? It's an awful lot of effort to
> > review this sort of stuff and given that Guo Ren is talking about sharing page
> > tables between the CPU and an accelerator, maybe you're better off
> > stabilising Linux for the platforms that you can actually test rather than
> > getting so far ahead of yourselves that you end up with a bunch of wasted
> > work on patches that probably won't get merged any time soon.
>
> The intention of the ASID patch was to encourage RISC-V implementations
> having ASID in HW and also ensure that things don't break on existing HW.
>
> I don't see our efforts being wasted in trying to make Linux RISC-V feature
> complete and encouraging more feature rich RISC-V CPUs.
>
> Delays in merging patches are fine as long as people have something to try
> on their RISC-V CPU implementations.
>
I'm the supporter of that patch:
http://archive.lwn.net:8080/linux-kernel/20190329045111.14040-1-anup.patel@wdc.com/T/#u

Because it implicit hw broadcast tlb invalidation optimization.

Honestly it's not suitable for remote tlb flush with software IPI, but
it's still much better than current RISC-V's.

I'll try it on our hardware: 910. wait a moment :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
