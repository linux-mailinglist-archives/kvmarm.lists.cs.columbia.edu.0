Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DF539491E7D
	for <lists+kvmarm@lfdr.de>; Tue, 18 Jan 2022 05:25:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 369D149EEA;
	Mon, 17 Jan 2022 23:25:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QBeia+qvP76D; Mon, 17 Jan 2022 23:25:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F2F540E2A;
	Mon, 17 Jan 2022 23:25:16 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 749DB40E25
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Jan 2022 23:25:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vK2jZI9BAIzx for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Jan 2022 23:25:13 -0500 (EST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2417840CE3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Jan 2022 23:25:13 -0500 (EST)
Received: by mail-pg1-f182.google.com with SMTP id h23so12784257pgk.11
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Jan 2022 20:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/KiEjTbr7mV22Iwjp/ByerxeqSvZMhmbYnRZo6WKer4=;
 b=byAYP8qLYQSW2RuQxL/XrqNPwNQ0kfamBRbJMQ7KeoAd0zMgxCTvWa9wUKYsiJyBw6
 oIXWTmgq9jBfalqDN5uJNybQ2HRm1mC1aKZVc6COpgSGIOlWZ07+shc4Gi7QO7H5LLUF
 rZIFyEmXD3TuRZeW4tZFkL3TjT6f58Lyqlm6Fm21xgNjWbfo6ZhBLQs+EXui9L7uXEcZ
 T4SPdv7pJeCpLjbTALgy9mNcjdI6nQPPoZ9yp/kP5fGa00WGUxJigw4+Sv8auwgJPPBP
 t4hmXGeiKBln+5HCGAXO+6S0X7rzmTQ/lOofNwpExhq5bakbB8k3ljEUcmmpo6rasYNi
 ONog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/KiEjTbr7mV22Iwjp/ByerxeqSvZMhmbYnRZo6WKer4=;
 b=tMlpEwYO6+3FSFRr+sfDJg07LPw74YaQY9AYgY/2D5Xu9ayU+jRwZqLnGRS1T5JRP5
 WooYDsy1+yNvTveDi2InK72Xk+VDF608Ktki6YvWecC23cWtAAlhxQDwNwhdEq73F5Hv
 gbj+XRujEDePVra6B2DFCXkdrRfTDm1TlqNhLGe1yXGv/C0F2GNEvpsqR4jF9Ud3kMU/
 LCrsjboEoPs/jJWoZdZ1nApWYGzkm6F2KbxuJaOu8ByC8xSJP/69z10nazAUdVIAAif9
 EWPd7Xn7Up1fDijGZrRfdBMffItCOIc5e+XHdVg1kHcJSz5W/OP3DZEPAS6IFo0YrPE4
 1iiA==
X-Gm-Message-State: AOAM533GyPaL9NFMcDeOayYr9yEyidxOZ9cF2avfkF383p+C4v4rl3XX
 T1iNlt3riZF7rg+uOPkU/uqIpX03B+EFZfMwuql6/Q==
X-Google-Smtp-Source: ABdhPJy9dN3br55hPmjDQhsXnIIAj3PRNvZbNpxAZXjDO6/ElP/PzF+/qxAMj+PkOPsEXMJmMNXkawM6ISRTCSjA4SA=
X-Received: by 2002:a63:7d4e:: with SMTP id m14mr21827572pgn.514.1642479911844; 
 Mon, 17 Jan 2022 20:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20220106042708.2869332-1-reijiw@google.com>
In-Reply-To: <20220106042708.2869332-1-reijiw@google.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Mon, 17 Jan 2022 20:24:55 -0800
Message-ID: <CAAeT=FyjqC47pHe_G_Z0sVua8A1SEbzQg6UZkQBwkTezA7tLsA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/26] KVM: arm64: Make CPU ID registers writable
 by userspace
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Wed, Jan 5, 2022 at 8:27 PM Reiji Watanabe <reijiw@google.com> wrote:
>
> In KVM/arm64, values of ID registers for a guest are mostly same as
> its host's values except for bits for feature that KVM doesn't support
> and for opt-in features that userspace didn't configure.  Userspace
> can use KVM_SET_ONE_REG to a set ID register value, but it fails
> if userspace attempts to modify the register value.
>
> This patch series adds support to allow userspace to modify a value of
> ID registers (as long as KVM can support features that are indicated
> in the registers) so userspace can have more control of configuring
> and unconfiguring features for guests.  We need this because we would
> like to expose a uniform set/level of features for a group of guests on
> systems with different ARM CPUs.  Since some features are not binary
> in nature (e.g. AA64DFR0_EL1.BRPs fields indicate number of
> breakpoints minus 1), using KVM_ARM_VCPU_INIT to control such features
> is inconvenient.
>
> The patch series is for both VHE and non-VHE, except for protected VMs,
> which have a different way of configuring ID registers based on its
> different requirements [1].
> There was a patch series that tried to achieve the same thing [2].
> A few snippets of codes in this series were inspired by or came from [2].
>
> The initial value of ID registers for a vCPU will be the host's value
> with bits cleared for unsupported features and for opt-in features that
> were not configured. So, the initial value userspace can see (via
> KVM_GET_ONE_REG) is the upper limit that can be set for the register.
> Any requests to change the value that conflicts with opt-in features'
> configuration will fail (e.g. if KVM_ARM_VCPU_PMU_V3 is configured by
> KVM_ARM_VCPU_INIT, ID_AA64DFR0_EL1.PMUVER cannot be set to zero.
> Otherwise, the initial value of ID_AA64DFR0_EL1.PMUVER will be zero,
> and cannot be changed from zero).
>
> When a guest tries to use a CPU feature that is not exposed to the guest,
> trapping it (to emulate a real CPU's behavior) would generally be a
> desirable behavior (when it is possible with no or little side effects).
> The later patches in the series add codes for this.  Only features that
> can be trapped independently will be trapped by this series though.
>
> This series adds kunit tests for new functions in sys_regs.c (except for
> trivial ones), and these tests are enabled with a new configuration
> option 'CONFIG_KVM_KUNIT_TEST'.

A gentle ping on this series.

Since KVM/ARM doesn't have any kunit tests yet, the series (patch-16)
introduces .kunitconfig for KVM/ARM in addition to the new configuration
option (The .kunitconfig in the patch includes only the minimum
configuration options needed for the current tests in the patch).

Any feedback on the patch-16 would be appreciated as with other patches.

Thanks,
Reiji








>
> The series is based on v5.16-rc8 with the patch [3] applied.
>
> v4:
>   - Make ID registers storage per VM instead of per vCPU. [Marc]
>   - Implement arm64_check_features() in arch/arm64/kernel/cpufeature.c
>     by using existing codes in the file. [Marc]
>   - Use a configuration function to enable traps for disabled
>     features. [Marc]
>   - Document ID registers become immutable after the first KVM_RUN [Eric]
>   - Update ID_AA64PFR0.GIC at the point where a GICv3 is created. [Marc]
>   - Get TGranX's bit position by substracting 12 from TGranX_2's bit
>     position. [Eric]
>   - Don't validate AArch32 ID registers when the system doesn't support
>     32bit EL0. [Eric]
>   - Add/fixes comments for patches. [Eric]
>   - Made bug fixes/improvements of the selftest. [Eric]
>   - Added .kunitconfig for arm64 KUnit tests
>
> v3: https://lore.kernel.org/all/20211117064359.2362060-1-reijiw@google.com/
>   - Remove ID register consistency checking across vCPUs. [Oliver]
>   - Change KVM_CAP_ARM_ID_REG_WRITABLE to
>     KVM_CAP_ARM_ID_REG_CONFIGURABLE. [Oliver]
>   - Add KUnit testing for ID register validation and trap initialization.
>   - Change read_id_reg() to take care of ID_AA64PFR0_EL1.GIC.
>   - Add a helper of read_id_reg() (__read_id_reg()) and use the helper
>     instead of directly using __vcpu_sys_reg().
>   - Change not to run kvm_id_regs_consistency_check() and
>     kvm_vcpu_init_traps() for protected VMs.
>   - Update selftest to remove test cases for ID register consistency.
>     checking across vCPUs and to add test cases for ID_AA64PFR0_EL1.GIC.
>
> v2: https://lore.kernel.org/all/20211103062520.1445832-1-reijiw@google.com/
>   - Remove unnecessary line breaks. [Andrew]
>   - Use @params for comments. [Andrew]
>   - Move arm64_check_features to arch/arm64/kvm/sys_regs.c and
>     change that KVM specific feature check function.  [Andrew]
>   - Remove unnecessary raz handling from __set_id_reg. [Andrew]
>   - Remove sys_val field from the initial id_reg_info and add it
>     in the later patch. [Andrew]
>   - Call id_reg->init() from id_reg_info_init(). [Andrew]
>   - Fix cpuid_feature_cap_perfmon_field() to convert 0xf to 0x0
>     (and use it in the following patches).
>   - Change kvm_vcpu_first_run_init to set has_run_once to false
>     when kvm_id_regs_consistency_check() fails.
>   - Add a patch to introduce id_reg_info for ID_AA64MMFR0_EL1,
>     which requires special validity checking for TGran*_2 fields.
>   - Add patches to introduce id_reg_info for ID_DFR1_EL1 and
>     ID_MMFR0_EL1, which are required due to arm64_check_features
>     implementation change.
>   - Add a new argument, which is a pointer to id_reg_info, for
>     id_reg_info's validate().
>
> v1: https://lore.kernel.org/all/20211012043535.500493-1-reijiw@google.com/
>
> [1] https://lore.kernel.org/kvmarm/20211010145636.1950948-1-tabba@google.com/
> [2] https://lore.kernel.org/kvm/20201102033422.657391-1-liangpeng10@huawei.com/
> [3] https://lore.kernel.org/all/20220104194918.373612-2-rananta@google.com/
>
> Reiji Watanabe (26):
>   KVM: arm64: Introduce a validation function for an ID register
>   KVM: arm64: Save ID registers' sanitized value per guest
>   KVM: arm64: Introduce struct id_reg_info
>   KVM: arm64: Make ID_AA64PFR0_EL1 writable
>   KVM: arm64: Make ID_AA64PFR1_EL1 writable
>   KVM: arm64: Make ID_AA64ISAR0_EL1 writable
>   KVM: arm64: Make ID_AA64ISAR1_EL1 writable
>   KVM: arm64: Make ID_AA64MMFR0_EL1 writable
>   KVM: arm64: Hide IMPLEMENTATION DEFINED PMU support for the guest
>   KVM: arm64: Make ID_AA64DFR0_EL1 writable
>   KVM: arm64: Make ID_DFR0_EL1 writable
>   KVM: arm64: Make MVFR1_EL1 writable
>   KVM: arm64: Make ID registers without id_reg_info writable
>   KVM: arm64: Add consistency checking for frac fields of ID registers
>   KVM: arm64: Introduce KVM_CAP_ARM_ID_REG_CONFIGURABLE capability
>   KVM: arm64: Add kunit test for ID register validation
>   KVM: arm64: Use vcpu->arch cptr_el2 to track value of cptr_el2 for VHE
>   KVM: arm64: Use vcpu->arch.mdcr_el2 to track value of mdcr_el2
>   KVM: arm64: Introduce framework to trap disabled features
>   KVM: arm64: Trap disabled features of ID_AA64PFR0_EL1
>   KVM: arm64: Trap disabled features of ID_AA64PFR1_EL1
>   KVM: arm64: Trap disabled features of ID_AA64DFR0_EL1
>   KVM: arm64: Trap disabled features of ID_AA64MMFR1_EL1
>   KVM: arm64: Trap disabled features of ID_AA64ISAR1_EL1
>   KVM: arm64: Add kunit test for trap initialization
>   KVM: arm64: selftests: Introduce id_reg_test
>
>  Documentation/virt/kvm/api.rst                |   12 +
>  arch/arm64/include/asm/cpufeature.h           |    3 +-
>  arch/arm64/include/asm/kvm_arm.h              |   32 +
>  arch/arm64/include/asm/kvm_host.h             |   19 +
>  arch/arm64/include/asm/sysreg.h               |    3 +
>  arch/arm64/kernel/cpufeature.c                |  228 +++
>  arch/arm64/kvm/.kunitconfig                   |    4 +
>  arch/arm64/kvm/Kconfig                        |   11 +
>  arch/arm64/kvm/arm.c                          |   24 +-
>  arch/arm64/kvm/debug.c                        |   13 +-
>  arch/arm64/kvm/hyp/vhe/switch.c               |   14 +-
>  arch/arm64/kvm/sys_regs.c                     | 1329 +++++++++++++++--
>  arch/arm64/kvm/sys_regs_test.c                | 1247 ++++++++++++++++
>  arch/arm64/kvm/vgic/vgic-init.c               |    5 +
>  include/uapi/linux/kvm.h                      |    1 +
>  tools/arch/arm64/include/asm/sysreg.h         |    1 +
>  tools/testing/selftests/kvm/.gitignore        |    1 +
>  tools/testing/selftests/kvm/Makefile          |    1 +
>  .../selftests/kvm/aarch64/id_reg_test.c       | 1239 +++++++++++++++
>  19 files changed, 4041 insertions(+), 146 deletions(-)
>  create mode 100644 arch/arm64/kvm/.kunitconfig
>  create mode 100644 arch/arm64/kvm/sys_regs_test.c
>  create mode 100644 tools/testing/selftests/kvm/aarch64/id_reg_test.c
>
>
> base-commit: d399b107ee49bf5ea0391bd7614d512809e927b0
> --
> 2.34.1.448.ga2b2bfdf31-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
