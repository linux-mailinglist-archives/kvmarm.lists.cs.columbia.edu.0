Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 15C553CBE9A
	for <lists+kvmarm@lfdr.de>; Fri, 16 Jul 2021 23:29:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9DAE14B08A;
	Fri, 16 Jul 2021 17:29:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J73r7AWcIhE6; Fri, 16 Jul 2021 17:29:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 415B74B081;
	Fri, 16 Jul 2021 17:29:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F13214A4A0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Jul 2021 17:29:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KL46sHNs7gFF for <kvmarm@lists.cs.columbia.edu>;
 Fri, 16 Jul 2021 17:29:23 -0400 (EDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 88A1E4A1AF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Jul 2021 17:29:23 -0400 (EDT)
Received: by mail-lj1-f175.google.com with SMTP id q4so15828392ljp.13
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Jul 2021 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rG0QzRVn0xvgBNRpL2thyKE3h6hzU4e3t1z4e1/od60=;
 b=gGIJ35R95kAzj9vkH0r/wUr9FG5xyFairDEwjCtTS6XF7MTM+ucxhHOQhzSMKQjqYg
 OdINZFXiXRtuYOEroMB80J80YmqiuwOPy9/zKZIUdpr+aTqhJqzRtxjQZ7rJB2mUOf7Y
 grZ7SxTZ+6oRLRj+hEAvevMMNvFrSV9i1Op1YLVBoAGXYeO68HeuCg3930vm5JsiOeDi
 llGy+htXFEOiQHAk4LEFIrYRcQRYqV/PSobtBsWshBumu7qhauwi4kD8dUSw/NDqQe6D
 jTsxPn7hNm06Za4RdI5LsGQacJI/7Gw/ME6ZCaeysK3zirRDxw4TjpMGBPm/NI/kc2hL
 RepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rG0QzRVn0xvgBNRpL2thyKE3h6hzU4e3t1z4e1/od60=;
 b=RH8zhEP3OKijAsyZ5M0km33eZEitwPWXOWR7ZzUzHXeRgAaAdDz76Vt6LK3UXS7LqX
 +aX7+Hiy2c4SfEfKvwMbiYHFCHCnUULvaDV9Ng/Ag4D9t40ebfaaWeLdOLrEn4CzCrqw
 BHCpWOWDkkn3ClpgNbOq/8izsmVI25qJiEu7HVTuArFAa1FjtAOL5mLYUGiXNeKSZU+k
 CZ7VQZOOAOxtAJCzDNxmiDQdFpurysbOCXqF/hsjxZzSgBsTtHfpyIeby7BF15jo2FKS
 t+D0b0DKxMp10aVwpOPYxj/4my8AusIj6ctv+mBh5mzfTAOONbmB2glWU2xUOVddK1eF
 ufcw==
X-Gm-Message-State: AOAM531/tOyVt2Yv6j+3Cu91WbuuHAswcXb+s971MlyFLH7xFAYtDFVI
 x4ZGLeTXzI8268cRXLYgy+1+KLc4p/dzXMCHnefnlw==
X-Google-Smtp-Source: ABdhPJxENIN3EeY5PxUXqLG9ZyFnAWt1M4SR05S23JywwbrbBG6I4jdTp/okqwweP3Y+G+B9/JOFHjNv2x7WVVZlCsY=
X-Received: by 2002:a2e:9059:: with SMTP id n25mr10854878ljg.314.1626470961626; 
 Fri, 16 Jul 2021 14:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210716212629.2232756-1-oupton@google.com>
In-Reply-To: <20210716212629.2232756-1-oupton@google.com>
From: Oliver Upton <oupton@google.com>
Date: Fri, 16 Jul 2021 14:29:10 -0700
Message-ID: <CAOQ_QshH6pSe9L_CiiWodR2AKC1AGbe2Afxh1971-5whuY=3qQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] KVM: Add idempotent controls for migrating
 system counter state
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

On Fri, Jul 16, 2021 at 2:26 PM Oliver Upton <oupton@google.com> wrote:
>
> KVM's current means of saving/restoring system counters is plagued with
> temporal issues. At least on ARM64 and x86, we migrate the guest's
> system counter by-value through the respective guest system register
> values (cntvct_el0, ia32_tsc). Restoring system counters by-value is
> brittle as the state is not idempotent: the host system counter is still
> oscillating between the attempted save and restore. Furthermore, VMMs
> may wish to transparently live migrate guest VMs, meaning that they
> include the elapsed time due to live migration blackout in the guest
> system counter view. The VMM thread could be preempted for any number of
> reasons (scheduler, L0 hypervisor under nested) between the time that
> it calculates the desired guest counter value and when KVM actually sets
> this counter state.
>
> Despite the value-based interface that we present to userspace, KVM
> actually has idempotent guest controls by way of system counter offsets.
> We can avoid all of the issues associated with a value-based interface
> by abstracting these offset controls in new ioctls. This series
> introduces new vCPU device attributes to provide userspace access to the
> vCPU's system counter offset.
>
> Patch 1 adopts Paolo's suggestion, augmenting the KVM_{GET,SET}_CLOCK
> ioctls to provide userspace with a (host_tsc, realtime) instant. This is
> essential for a VMM to perform precise migration of the guest's system
> counters.
>
> Patches 2-3 add support for x86 by shoehorning the new controls into the
> pre-existing synchronization heuristics.
>
> Patches 4-5 implement a test for the new additions to
> KVM_{GET,SET}_CLOCK.
>
> Patches 6-7 implement at test for the tsc offset attribute introduced in
> patch 3.
>
> Patch 8 adds a device attribute for the arm64 virtual counter-timer
> offset.
>
> Patch 9 extends the test from patch 7 to cover the arm64 virtual
> counter-timer offset.
>
> Patch 10 adds a device attribute for the arm64 physical counter-timer
> offset. Currently, this is implemented as a synthetic register, forcing
> the guest to trap to the host and emulating the offset in the fast exit
> path. Later down the line we will have hardware with FEAT_ECV, which
> allows the hypervisor to perform physical counter-timer offsetting in
> hardware (CNTPOFF_EL2).
>
> Patch 11 extends the test from patch 7 to cover the arm64 physical
> counter-timer offset.
>
> Patch 12 introduces a benchmark to measure the overhead of emulation in
> patch 10.
>
> Physical counter benchmark
> --------------------------
>
> The following data was collected by running 10000 iterations of the
> benchmark test from Patch 6 on an Ampere Mt. Jade reference server, A 2S
> machine with 2 80-core Ampere Altra SoCs. Measurements were collected
> for both VHE and nVHE operation using the `kvm-arm.mode=` command-line
> parameter.
>
> nVHE
> ----
>
> +--------------------+--------+---------+
> |       Metric       | Native | Trapped |
> +--------------------+--------+---------+
> | Average            | 54ns   | 148ns   |
> | Standard Deviation | 124ns  | 122ns   |
> | 95th Percentile    | 258ns  | 348ns   |
> +--------------------+--------+---------+
>
> VHE
> ---
>
> +--------------------+--------+---------+
> |       Metric       | Native | Trapped |
> +--------------------+--------+---------+
> | Average            | 53ns   | 152ns   |
> | Standard Deviation | 92ns   | 94ns    |
> | 95th Percentile    | 204ns  | 307ns   |
> +--------------------+--------+---------+
>
> This series applies cleanly to the following commit:
>
> 1889228d80fe ("KVM: selftests: smm_test: Test SMM enter from L2")

v1: https://lore.kernel.org/kvm/20210608214742.1897483-1-oupton@google.com/

> v1 -> v2:
>   - Reimplemented as vCPU device attributes instead of a distinct ioctl.
>   - Added the (realtime, host_tsc) instant support to
>     KVM_{GET,SET}_CLOCK
>   - Changed the arm64 implementation to broadcast counter offset values
>     to all vCPUs in a guest. This upholds the architectural expectations
>     of a consistent counter-timer across CPUs.
>   - Fixed a bug with traps in VHE mode. We now configure traps on every
>     transition into a guest to handle differing VMs (trapped, emulated).
>
> Oliver Upton (12):
>   KVM: x86: Report host tsc and realtime values in KVM_GET_CLOCK
>   KVM: x86: Refactor tsc synchronization code
>   KVM: x86: Expose TSC offset controls to userspace
>   tools: arch: x86: pull in pvclock headers
>   selftests: KVM: Add test for KVM_{GET,SET}_CLOCK
>   selftests: KVM: Add helpers for vCPU device attributes
>   selftests: KVM: Introduce system counter offset test
>   KVM: arm64: Allow userspace to configure a vCPU's virtual offset
>   selftests: KVM: Add support for aarch64 to system_counter_offset_test
>   KVM: arm64: Provide userspace access to the physical counter offset
>   selftests: KVM: Test physical counter offsetting
>   selftests: KVM: Add counter emulation benchmark
>
>  Documentation/virt/kvm/api.rst                |  42 +-
>  Documentation/virt/kvm/locking.rst            |  11 +
>  arch/arm64/include/asm/kvm_host.h             |   1 +
>  arch/arm64/include/asm/kvm_hyp.h              |   2 -
>  arch/arm64/include/asm/sysreg.h               |   1 +
>  arch/arm64/include/uapi/asm/kvm.h             |   2 +
>  arch/arm64/kvm/arch_timer.c                   | 118 ++++-
>  arch/arm64/kvm/arm.c                          |   4 +-
>  arch/arm64/kvm/hyp/include/hyp/switch.h       |  23 +
>  arch/arm64/kvm/hyp/include/hyp/timer-sr.h     |  26 ++
>  arch/arm64/kvm/hyp/nvhe/switch.c              |   2 -
>  arch/arm64/kvm/hyp/nvhe/timer-sr.c            |  21 +-
>  arch/arm64/kvm/hyp/vhe/timer-sr.c             |  27 ++
>  arch/x86/include/asm/kvm_host.h               |   4 +
>  arch/x86/include/uapi/asm/kvm.h               |   4 +
>  arch/x86/kvm/x86.c                            | 421 ++++++++++++++----
>  include/kvm/arm_arch_timer.h                  |   2 -
>  include/uapi/linux/kvm.h                      |   7 +-
>  tools/arch/x86/include/asm/pvclock-abi.h      |  48 ++
>  tools/arch/x86/include/asm/pvclock.h          | 103 +++++
>  tools/testing/selftests/kvm/.gitignore        |   3 +
>  tools/testing/selftests/kvm/Makefile          |   4 +
>  .../kvm/aarch64/counter_emulation_benchmark.c | 215 +++++++++
>  .../selftests/kvm/include/aarch64/processor.h |  24 +
>  .../testing/selftests/kvm/include/kvm_util.h  |  11 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  38 ++
>  .../kvm/system_counter_offset_test.c          | 206 +++++++++
>  .../selftests/kvm/x86_64/kvm_clock_test.c     | 210 +++++++++
>  28 files changed, 1447 insertions(+), 133 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/include/hyp/timer-sr.h
>  create mode 100644 tools/arch/x86/include/asm/pvclock-abi.h
>  create mode 100644 tools/arch/x86/include/asm/pvclock.h
>  create mode 100644 tools/testing/selftests/kvm/aarch64/counter_emulation_benchmark.c
>  create mode 100644 tools/testing/selftests/kvm/system_counter_offset_test.c
>  create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
>
> --
> 2.32.0.402.g57bb445576-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
