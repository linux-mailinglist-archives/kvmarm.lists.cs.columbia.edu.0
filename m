Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2924E9CE7
	for <lists+kvmarm@lfdr.de>; Mon, 28 Mar 2022 18:56:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 552F049F01;
	Mon, 28 Mar 2022 12:56:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -0.767
X-Spam-Level: 
X-Spam-Status: No, score=-0.767 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, MISSING_HEADERS=1.021,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 44kvvC4OjkUA; Mon, 28 Mar 2022 12:56:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 099B54B133;
	Mon, 28 Mar 2022 12:56:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A11124B092
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Mar 2022 12:56:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ASi6RAxXMV0v for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Mar 2022 12:56:04 -0400 (EDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 29C9A49F4A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Mar 2022 12:56:04 -0400 (EDT)
Received: by mail-wm1-f52.google.com with SMTP id
 p12-20020a05600c430c00b0038cbdf52227so8945316wme.2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Mar 2022 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
 bh=wdmr5jjdh07/KzOxKbpgA6wD042XekYuzlBRUsPQIMc=;
 b=UaauX/6NVwjFUGEyL1HMvGum0Lk8XovETWGfLSDc+nQQXnYuentU/sD+L33XyvxUEa
 q0UK5/lZlNjEZC7yY9flxH8l82GFIt113i7maptShsxPgoV2xW4qZli9V1G0qAFKICjO
 1Bwajkyv9rAFDwmwd3JM3C/Kws8N323Rl/LuO2wZIsrCODv33dfc8xhUOD61xsSLqC1N
 37ndc5sP+JSX5AL//NH+FhynFK/VyT+NVap3NdVjrEV7HRrz/2QqDXK4baxEs2GauK7Q
 TMJpXN0rAPLxH+/gD7OznB29TpeOv1KJ5lxE1UJyUlYzQwoa2EqrN3P3OSuMyKdyDu7b
 XmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:cc;
 bh=wdmr5jjdh07/KzOxKbpgA6wD042XekYuzlBRUsPQIMc=;
 b=kUl8B+0bJzQWwrNYYyYJ3m+mI4GkTBUkqr4q6NPKmcFZ7lXkWTxX6GohVeKLr5Fer8
 ZyGMCurkmtSiY+go2cku9GARuKTwsKIE8+QrMHTZ+ZG4eAQdSMYqUTwzDgBsCbxcCrYi
 q43pAqYeijwC5p9Wgk7LuPib0VjMu+LnKq3BEvkpuZYKd9daT6ygJvW5Pgote2LF0Yga
 mP9cGCbnPbvUvsKcoEszqt5J56kSdkzLxizFP6/dcHpzVAM1w+/3L1mz5spUlodz8dwD
 nJG7fUf7IbV4w11aPuYY7BaCQS6UrbL0DukyMXffpd783Wgw6x5sJ2ZMZdVBfrTvxiVA
 PyTg==
X-Gm-Message-State: AOAM5330+WuyMGr/vGK38+NTgriL77P2/CmCDn0MAkOeczSB5hxySNqs
 BobfuxrJbaTlHFyFwynuiTbYKs6a5kllifbesL2lbw==
X-Received: by 2002:a05:600c:1553:b0:38c:90fb:d3ca with SMTP id
 f19-20020a05600c155300b0038c90fbd3camt105383wmg.158.1648486562719; Mon, 28
 Mar 2022 09:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
In-Reply-To: <20220314200148.2695206-1-kaleshsingh@google.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 28 Mar 2022 09:55:51 -0700
Message-ID: <CAC_TJvdXaYZcAA0STQkhSo0SLhai-QUrSLmzDMAKH29QJZmZEQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] KVM: arm64: Hypervisor stack enhancements
Cc: "Cc: Android Kernel" <kernel-team@android.com>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>,
 Peter Collingbourne <pcc@google.com>, Marc Zyngier <maz@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
 Mark Brown <broonie@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, kvmarm <kvmarm@lists.cs.columbia.edu>
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

On Mon, Mar 14, 2022 at 1:02 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Hi all,
>
> This is v6 of the nVHE hypervisor stack enhancements. Addresses some
> refactoring/cleanup and documentation improvments from Stephen,
> and rebased on 5.17-rc8.

Friendly ping on this :). I've addressed all feedback received in this
latest version.

Thanks,
Kalesh

>
> Previous versions can be found at:
> v5: https://lore.kernel.org/r/20220307184935.1704614-1-kaleshsingh@google.com/
> v4: https://lore.kernel.org/r/20220225033548.1912117-1-kaleshsingh@google.com/
> v3: https://lore.kernel.org/r/20220224051439.640768-1-kaleshsingh@google.com/
> v2: https://lore.kernel.org/r/20220222165212.2005066-1-kaleshsingh@google.com/
> v1: https://lore.kernel.org/r/20220210224220.4076151-1-kaleshsingh@google.com/
>
> The previous cover letter has been copied below for convenience.
>
> Thanks,
> Kalesh
>
> -----
>
> This series is based on 5.17-rc8 and adds the following stack features to
> the KVM nVHE hypervisor:
>
> == Hyp Stack Guard Pages ==
>
> Based on the technique used by arm64 VMAP_STACK to detect overflow.
> i.e. the stack is aligned such that the 'stack shift' bit of any valid
> SP is 1. The 'stack shift' bit can be tested in the exception entry to
> detect overflow without corrupting GPRs.
>
> == Hyp Stack Unwinder ==
>
> The unwinding and dumping of the hyp stack is not enabled by default and
> depends on CONFIG_NVHE_EL2_DEBUG to avoid potential information leaks.
>
> When CONFIG_NVHE_EL2_DEBUG is enabled the host stage 2 protection is
> disabled, allowing the host to read the hypervisor stack pages and unwind
> the stack from EL1. This allows us to print the hypervisor stacktrace
> before panicking the host; as shown below.
>
> Example call trace:
>
> [   98.916444][  T426] kvm [426]: nVHE hyp panic at: [<ffffffc0096156fc>] __kvm_nvhe_overflow_stack+0x8/0x34!
> [   98.918360][  T426] nVHE HYP call trace:
> [   98.918692][  T426] kvm [426]: [<ffffffc009615aac>] __kvm_nvhe_cpu_prepare_nvhe_panic_info+0x4c/0x68
> [   98.919545][  T426] kvm [426]: [<ffffffc0096159a4>] __kvm_nvhe_hyp_panic+0x2c/0xe8
> [   98.920107][  T426] kvm [426]: [<ffffffc009615ad8>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
> [   98.920665][  T426] kvm [426]: [<ffffffc009610a4c>] __kvm_nvhe___kvm_hyp_host_vector+0x24c/0x794
> [   98.921292][  T426] kvm [426]: [<ffffffc009615718>] __kvm_nvhe_overflow_stack+0x24/0x34
> . . .
>
> [   98.973382][  T426] kvm [426]: [<ffffffc009615718>] __kvm_nvhe_overflow_stack+0x24/0x34
> [   98.973816][  T426] kvm [426]: [<ffffffc0096152f4>] __kvm_nvhe___kvm_vcpu_run+0x38/0x438
> [   98.974255][  T426] kvm [426]: [<ffffffc009616f80>] __kvm_nvhe_handle___kvm_vcpu_run+0x1c4/0x364
> [   98.974719][  T426] kvm [426]: [<ffffffc009616928>] __kvm_nvhe_handle_trap+0xa8/0x130
> [   98.975152][  T426] kvm [426]: [<ffffffc009610064>] __kvm_nvhe___host_exit+0x64/0x64
> [   98.975588][  T426] ---- end of nVHE HYP call trace ----
>
>
>
>
> Kalesh Singh (8):
>   KVM: arm64: Introduce hyp_alloc_private_va_range()
>   KVM: arm64: Introduce pkvm_alloc_private_va_range()
>   KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
>   KVM: arm64: Add guard pages for pKVM (protected nVHE) hypervisor stack
>   KVM: arm64: Detect and handle hypervisor stack overflows
>   KVM: arm64: Add hypervisor overflow stack
>   KVM: arm64: Unwind and dump nVHE HYP stacktrace
>   KVM: arm64: Symbolize the nVHE HYP backtrace
>
>  arch/arm64/include/asm/kvm_asm.h     |  21 +++
>  arch/arm64/include/asm/kvm_mmu.h     |   4 +
>  arch/arm64/include/asm/stacktrace.h  |  12 ++
>  arch/arm64/kernel/stacktrace.c       | 210 ++++++++++++++++++++++++---
>  arch/arm64/kvm/Kconfig               |   5 +-
>  arch/arm64/kvm/arm.c                 |  41 +++++-
>  arch/arm64/kvm/handle_exit.c         |  16 +-
>  arch/arm64/kvm/hyp/include/nvhe/mm.h |   6 +-
>  arch/arm64/kvm/hyp/nvhe/host.S       |  29 ++++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  18 ++-
>  arch/arm64/kvm/hyp/nvhe/mm.c         |  78 ++++++----
>  arch/arm64/kvm/hyp/nvhe/setup.c      |  31 +++-
>  arch/arm64/kvm/hyp/nvhe/switch.c     |  30 +++-
>  arch/arm64/kvm/mmu.c                 |  70 ++++++---
>  scripts/kallsyms.c                   |   2 +-
>  15 files changed, 477 insertions(+), 96 deletions(-)
>
>
> base-commit: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
> --
> 2.35.1.723.g4982287a31-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
