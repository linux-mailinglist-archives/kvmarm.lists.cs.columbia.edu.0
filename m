Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 06B69576703
	for <lists+kvmarm@lfdr.de>; Fri, 15 Jul 2022 20:59:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 061C44C06C;
	Fri, 15 Jul 2022 14:59:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSAG5CZO9-Ij; Fri, 15 Jul 2022 14:59:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E7F34C062;
	Fri, 15 Jul 2022 14:59:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E9A774C05B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jul 2022 14:59:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fHwKQzx2sZN2 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 15 Jul 2022 14:59:09 -0400 (EDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5A1C54C05A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jul 2022 14:59:09 -0400 (EDT)
Received: by mail-wr1-f42.google.com with SMTP id z12so7985355wrq.7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jul 2022 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xf9uJYF5ACsf3N9sE+T/kH049bkqtRicxBRlf5NJwzI=;
 b=CwN6uSeDs3O6jb0UR1KCay3zWYnCy1FWwTJlKFngHztY9sNyPN5f1zEX61h9EZdjb4
 dTXPuppnKtCXSLsv8TfJ2cWllhpWOtP37ho6NxTHnSFZua9Mkpwk2Rh+w1jqiSQM8YzC
 Ll+jsq1uyvtkUSys6wG3b25DEeLp5lFXK/j+FUm05PHSEQOsyAi4yimwDL1agUcCylob
 T+GI8kY2O7r37cUXMy/SegHE2ly06SC904HLIaPgNAHCjGiK/Krpv8Xxwo8WPRRNpQ3q
 XmPXzvA9PyhyW+4TkF7BraGa1D0erEaWumlwupgbrUKerkG22PokP+YTBHu6J+kaUDXD
 A7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xf9uJYF5ACsf3N9sE+T/kH049bkqtRicxBRlf5NJwzI=;
 b=pQbFosRzRQ9CqeSG3srMrVtcZ41vp0+hdjOzrXAZmdkWVygnhquwbyDlihMimeaXRC
 AdFmV8YDDIjwihMhHj9WHuXDE6AwMcFYzez9r5Y/SuuvC88FMFFm+NOLKAGHHkE5r1uj
 TK1Mwr3xtX3eqPuntd/Pqod444H9YqkEY16vN3Rwyxj9tJ8cif7L93bZT7dkvjRDiVMV
 LysAsY7zQtmmQAetEJw3M5QutDuWzpFWML+QuqTM0wLbkBE1nwThx7TRUzWyAAHwqAn7
 Q/EdDAy97MVKP7tfcssG6Xhjcjr6H0OF2Zb5V/xvF2qZjWcnr8x34azHgCw25Lnh6VnB
 AOXQ==
X-Gm-Message-State: AJIora+E5Nf8nBhF12IzOvsMiEIj+URBiQzmrqqotk8qqly6uxUotK3K
 AlWDeSt9NJxvhHiGGpkSUkFvytdeI232Df39jwxkDg==
X-Google-Smtp-Source: AGRyM1v9zeCKDv2BzQwNi4ntgkA9iowWv3yPGQHa7sWbWYm3w4VEw/n5eMbY6X8cUNvySc25Uhd4xLv8zo162/Z6cvY=
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id
 a8-20020a056000050800b0021d4105caf9mr14181145wrf.699.1657911547888; Fri, 15
 Jul 2022 11:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <CA+EHjTzPu9hticW4sPbVsxp43swRGOv4ou843S=Q5q=oQ6ii=g@mail.gmail.com>
In-Reply-To: <CA+EHjTzPu9hticW4sPbVsxp43swRGOv4ou843S=Q5q=oQ6ii=g@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 15 Jul 2022 11:58:56 -0700
Message-ID: <CAC_TJveK_nfaD1=DyQ4oAvRpuWkC_qbBhoEEqWgtcOo1TOvAag@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] KVM nVHE Hypervisor stack unwinder
To: Fuad Tabba <tabba@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Marco Elver <elver@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 vincenzo.frascino@arm.com, Will Deacon <will@kernel.org>,
 android-mm@google.com, Marc Zyngier <maz@kernel.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
 "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
 andreyknvl@gmail.com, "Cc: Android Kernel" <kernel-team@android.com>,
 Andrew Jones <drjones@redhat.com>, Mark Brown <broonie@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>, russell.king@oracle.com,
 LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
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

On Fri, Jul 15, 2022 at 6:55 AM 'Fuad Tabba' via kernel-team
<kernel-team@android.com> wrote:
>
> Hi Kalesh,
>
> On Fri, Jul 15, 2022 at 7:10 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Hi all,
> >
> > This is v4 of the series adding support for nVHE hypervisor stacktraces;
> > and is based on arm64 for-next/stacktrace.
> >
> > Thanks all for your feedback on previous revisions. Mark Brown, I
> > appreciate your Reviewed-by on the v3, I have dropped the tags in this
> > new verision since I think the series has changed quite a bit.
> >
> > The previous versions were posted at:
> > v3: https://lore.kernel.org/r/20220607165105.639716-1-kaleshsingh@google.com/
> > v2: https://lore.kernel.org/r/20220502191222.4192768-1-kaleshsingh@google.com/
> > v1: https://lore.kernel.org/r/20220427184716.1949239-1-kaleshsingh@google.com/
> >
> > The main updates in this version are to address concerens from Marc on the
> > memory usage and reusing the common code by refactoring into a shared header.
> >
> > Thanks,
> > Kalesh
>
> I tested an earlier version of this patch series, and it worked fine,
> with symbolization. However, testing it now, both with nvhe and with
> pkvm the symbolization isn't working for me. e.g.
>
> [   32.986706] kvm [251]: Protected nVHE HYP call trace:
> [   32.986796] kvm [251]:  [<ffff800008f8b0e0>] 0xffff800008f8b0e0
> [   32.987391] kvm [251]:  [<ffff800008f8b388>] 0xffff800008f8b388
> [   32.987493] kvm [251]:  [<ffff800008f8d230>] 0xffff800008f8d230
> [   32.987591] kvm [251]:  [<ffff800008f8d51c>] 0xffff800008f8d51c
> [   32.987695] kvm [251]:  [<ffff800008f8c064>] 0xffff800008f8c064
> [   32.987803] kvm [251]: ---- End of Protected nVHE HYP call trace ----
>
> CONFIG_PROTECTED_NVHE_STACKTRACE CONFIG_NVHE_EL2_DEBUG and
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT are all enabled. Generating
> a backtrace in the host I get proper symbolisation.
>
> Is there anything else you'd like to know about my setup that would
> help get to the bottom of this?

Hi Fuad,

Thanks for reviewing it. Can you attach the .config when you have a
chance please? I will try reproducing it on my end.

--Kalesh

>
> Thanks,
> /fuad
>
>
>
>
> >
> > ============
> >
> > KVM nVHE Stack unwinding.
> > ===
> >
> > nVHE has two modes of operation: protected (pKVM) and unprotected
> > (conventional nVHE). Depending on the mode, a slightly different approach
> > is used to dump the hyperviosr stacktrace but the core unwinding logic
> > remains the same.
> >
> > Protected nVHE (pKVM) stacktraces
> > ====
> >
> > In protected nVHE mode, the host cannot directly access hypervisor memory.
> >
> > The hypervisor stack unwinding happens in EL2 and is made accessible to
> > the host via a shared buffer. Symbolizing and printing the stacktrace
> > addresses is delegated to the host and happens in EL1.
> >
> > Non-protected (Conventional) nVHE stacktraces
> > ====
> >
> > In non-protected mode, the host is able to directly access the hypervisor
> > stack pages.
> >
> > The hypervisor stack unwinding and dumping of the stacktrace is performed
> > by the host in EL1, as this avoids the memory overhead of setting up
> > shared buffers between the host and hypervisor.
> >
> > Resuing the Core Unwinding Logic
> > ====
> >
> > Since the hypervisor cannot link against the kernel code in proteced mode.
> > The common stack unwinding code is moved to a shared header to allow reuse
> > in the nVHE hypervisor.
> >
> > Reducing the memory footprint
> > ====
> >
> > In this version the below steps were taken to reduce the memory usage of
> > nVHE stack unwinding:
> >
> >     1) The nVHE overflow stack is reduced from PAGE_SIZE to 4KB; benificial
> >        for configurations with non 4KB pages (16KB or 64KB pages).
> >     2) In protected nVHE mode (pKVM), the shared stacktrace buffers with the
> >        host are reduced from PAGE_SIZE to the minimum size required.
> >     3) In systems other than Android, conventional nVHE makes up the vast
> >        majority of use case. So the pKVM stack tracing is disabled by default
> >        (!CONFIG_PROTECTED_NVHE_STACKTRACE), which avoid the memory usage for
> >        setting up shared buffers.
> >     4) In non-protected nVHE mode (conventional nVHE), the stack unwinding
> >        is done directly in EL1 by the host and no shared buffers with the
> >        hyperviosr are needed.
> >
> > Sample Output
> > ====
> >
> > The below shows an example output from a simple stack overflow test:
> >
> > [  126.862960] kvm [371]: nVHE hyp panic at: [<ffff8000090a51d0>] __kvm_nvhe_recursive_death+0x10/0x34!
> > [  126.869920] kvm [371]: Protected nVHE HYP call trace:
> > [  126.870528] kvm [371]:  [<ffff8000090a5570>] __kvm_nvhe_hyp_panic+0xac/0xf8
> > [  126.871342] kvm [371]:  [<ffff8000090a55cc>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
> > [  126.872174] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> > [  126.872971] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> >    . . .
> >
> > [  126.927314] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> > [  126.927727] kvm [371]:  [<ffff8000090a51e4>] __kvm_nvhe_recursive_death+0x24/0x34
> > [  126.928137] kvm [371]:  [<ffff8000090a4de4>] __kvm_nvhe___kvm_vcpu_run+0x30/0x40c
> > [  126.928561] kvm [371]:  [<ffff8000090a7b64>] __kvm_nvhe_handle___kvm_vcpu_run+0x30/0x48
> > [  126.928984] kvm [371]:  [<ffff8000090a78b8>] __kvm_nvhe_handle_trap+0xc4/0x128
> > [  126.929385] kvm [371]:  [<ffff8000090a6864>] __kvm_nvhe___host_exit+0x64/0x64
> > [  126.929804] kvm [371]: ---- End of Protected nVHE HYP call trace ----
> >
> > ============
> >
> >
> > Kalesh Singh (18):
> >   arm64: stacktrace: Add shared header for common stack unwinding code
> >   arm64: stacktrace: Factor out on_accessible_stack_common()
> >   arm64: stacktrace: Factor out unwind_next_common()
> >   arm64: stacktrace: Handle frame pointer from different address spaces
> >   arm64: stacktrace: Factor out common unwind()
> >   arm64: stacktrace: Add description of stacktrace/common.h
> >   KVM: arm64: On stack overflow switch to hyp overflow_stack
> >   KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
> >   KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
> >   KVM: arm64: Stub implementation of pKVM HYP stack unwinder
> >   KVM: arm64: Stub implementation of non-protected nVHE HYP stack
> >     unwinder
> >   KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
> >   KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
> >   KVM: arm64: Implement protected nVHE hyp stack unwinder
> >   KVM: arm64: Implement non-protected nVHE hyp stack unwinder
> >   KVM: arm64: Introduce pkvm_dump_backtrace()
> >   KVM: arm64: Introduce hyp_dump_backtrace()
> >   KVM: arm64: Dump nVHE hypervisor stack on panic
> >
> >  arch/arm64/include/asm/kvm_asm.h           |  16 ++
> >  arch/arm64/include/asm/memory.h            |   7 +
> >  arch/arm64/include/asm/stacktrace.h        |  92 ++++---
> >  arch/arm64/include/asm/stacktrace/common.h | 224 ++++++++++++++++
> >  arch/arm64/include/asm/stacktrace/nvhe.h   | 291 +++++++++++++++++++++
> >  arch/arm64/kernel/stacktrace.c             | 157 -----------
> >  arch/arm64/kvm/Kconfig                     |  15 ++
> >  arch/arm64/kvm/arm.c                       |   2 +-
> >  arch/arm64/kvm/handle_exit.c               |   4 +
> >  arch/arm64/kvm/hyp/nvhe/Makefile           |   2 +-
> >  arch/arm64/kvm/hyp/nvhe/host.S             |   9 +-
> >  arch/arm64/kvm/hyp/nvhe/stacktrace.c       | 108 ++++++++
> >  arch/arm64/kvm/hyp/nvhe/switch.c           |   5 +
> >  13 files changed, 727 insertions(+), 205 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/stacktrace/common.h
> >  create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h
> >  create mode 100644 arch/arm64/kvm/hyp/nvhe/stacktrace.c
> >
> >
> > base-commit: 82a592c13b0aeff94d84d54183dae0b26384c95f
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
