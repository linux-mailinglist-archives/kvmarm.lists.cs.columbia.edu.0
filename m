Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6E85C655A31
	for <lists+kvmarm@lfdr.de>; Sat, 24 Dec 2022 14:10:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FEE24B9CB;
	Sat, 24 Dec 2022 08:10:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JISivwrGyjwx; Sat, 24 Dec 2022 08:10:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DC694BA96;
	Sat, 24 Dec 2022 08:10:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05C394B97F
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Dec 2022 08:10:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id of+6OhN46QaH for <kvmarm@lists.cs.columbia.edu>;
 Sat, 24 Dec 2022 08:09:57 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9A9634B936
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Dec 2022 08:09:57 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3DD4AB81E11
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Dec 2022 13:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF615C433EF
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Dec 2022 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671887395;
 bh=1KAD3La7ae36+389O+98UCvX9OlY6/zJI9OrSau1bJE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Glwxh4vHrRtMXdFRp2W8FakdI2s4AoO1Ic0njgIusQMZtyKupJUvbtTqWYmCt8Olg
 DpKTBXKR4DISv+bdMbneVMksD2AjcM1ZtvWUvP7cwj7MSTA5Wj/rtm4QpzLb6JAWnN
 Uxwm1ggmug4Nkqj/FMH0fb9U1Y7jR0ot1avKpA7AfK9uraXPFVCa8svudffWWGC9uj
 H0Zo0EJUnWeE4TYp3T6O7QCT82UOnhtrxf0l/OHzqIHrG47mgEQd6JxaqKCfhsWmM9
 eQcgYnFabGqEmWyhLwTeaXZ01FXPDufFwC4WC4Osx/YmzKHIc0lzQ4HSFObWFwndA+
 SrhFJXJSxTxnw==
Received: by mail-lf1-f54.google.com with SMTP id g13so10357402lfv.7
 for <kvmarm@lists.cs.columbia.edu>; Sat, 24 Dec 2022 05:09:54 -0800 (PST)
X-Gm-Message-State: AFqh2kpU7ya8K9rzUwOK+m02LpP1R319FdkRecUOKxVmPVll3z9grJsz
 QDdVHVLtD0S5Cnck6QG4KyKMxfrUXtV8TEQ0ZPs=
X-Google-Smtp-Source: AMrXdXsrYvZLeJidxouIlemfUek/dfoOHZis6FsZAm0Ua3lh36yDaSUDGPVSKz3CZBVcXeLzD4BqCZxMP6aPSvrBga4=
X-Received: by 2002:ac2:5dfa:0:b0:4b7:3a0:45d2 with SMTP id
 z26-20020ac25dfa000000b004b703a045d2mr647494lfq.228.1671887392928; Sat, 24
 Dec 2022 05:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20221220200923.1532710-1-maz@kernel.org>
 <20221220200923.1532710-2-maz@kernel.org>
 <CAMj1kXE57xTzkmdhQzxOBSePVzUCS5GW7PAVvx+iF+3UHv0OrA@mail.gmail.com>
 <877cyhf113.wl-maz@kernel.org>
In-Reply-To: <877cyhf113.wl-maz@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 24 Dec 2022 14:09:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFiiSr+8wgCYZ5iZme6HV1_=dRaiNcjgkEitPcu6u3VBQ@mail.gmail.com>
Message-ID: <CAMj1kXFiiSr+8wgCYZ5iZme6HV1_=dRaiNcjgkEitPcu6u3VBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: arm64: Fix S1PTW handling on RO memslots
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, stable@vger.kernel.org,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
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

On Sat, 24 Dec 2022 at 13:19, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 22 Dec 2022 13:01:55 +0000,
> Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 20 Dec 2022 at 21:09, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > A recent development on the EFI front has resulted in guests having
> > > their page tables baked in the firmware binary, and mapped into
> > > the IPA space as part as a read-only memslot.
> > >
> > > Not only this is legitimate, but it also results in added security,
> > > so thumbs up. However, this clashes mildly with our handling of a S1PTW
> > > as a write to correctly handle AF/DB updates to the S1 PTs, and results
> > > in the guest taking an abort it won't recover from (the PTs mapping the
> > > vectors will suffer freom the same problem...).
> > >
> > > So clearly our handling is... wrong.
> > >
> > > Instead, switch to a two-pronged approach:
> > >
> > > - On S1PTW translation fault, handle the fault as a read
> > >
> > > - On S1PTW permission fault, handle the fault as a write
> > >
> > > This is of no consequence to SW that *writes* to its PTs (the write
> > > will trigger a non-S1PTW fault), and SW that uses RO PTs will not
> > > use AF/DB anyway, as that'd be wrong.
> > >
> > > Only in the case described in c4ad98e4b72c ("KVM: arm64: Assume write
> > > fault on S1PTW permission fault on instruction fetch") do we end-up
> > > with two back-to-back faults (page being evicted and faulted back).
> > > I don't think this is a case worth optimising for.
> > >
> > > Fixes: c4ad98e4b72c ("KVM: arm64: Assume write fault on S1PTW permission fault on instruction fetch")
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: stable@vger.kernel.org
> >
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > I have tested this patch on my TX2 with one of the EFI builds in
> > question, and everything works as before (I never observed the issue
> > itself)
>
> If you get the chance, could you try with non-4kB page sizes? Here, I
> could only reproduce it with 16kB pages. It was firing like clockwork
> on Cortex-A55 with that.
>

I'll try on 64k but I don't have access to a 16k capable machine that
runs KVM atm (I'm still enjoying working wifi and GPU etc on my M1
Macbook Air)

> >
> > Regression-tested-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > For the record, the EFI build in question targets QEMU/mach-virt and
> > switches to a set of read-only page tables in emulated NOR flash
> > straight out of reset, so it can create and populate the real page
> > tables with MMU and caches enabled. EFI does not use virtual memory or
> > paging so managing access flags or dirty bits in hardware is unlikely
> > to add any value, and it is not being used at the moment. And given
> > that this is emulated NOR flash, any ordinary write to it tears down
> > the r/o memslot altogether, and kicks the NOR flash emulation in QEMU
> > into programming mode, which is fully based on MMIO emulation and does
> > not use a memslot at all. IOW, even if we could figure out what store
> > the PTW was attempting to do, it is always going to be rejected since
> > the r/o page tables can only be modified by 'programming' the NOR
> > flash sector.
>
> Indeed, and this would be a pretty dodgy setup anyway.
>
> Thanks for having had a look,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
