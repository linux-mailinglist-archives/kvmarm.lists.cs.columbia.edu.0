Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB34D59C5
	for <lists+kvmarm@lfdr.de>; Fri, 11 Mar 2022 05:48:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4508949E57;
	Thu, 10 Mar 2022 23:48:22 -0500 (EST)
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
	with ESMTP id D6+OE71kktWg; Thu, 10 Mar 2022 23:48:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 94B1F41174;
	Thu, 10 Mar 2022 23:48:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B0D540CF5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 23:48:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id akytvghJA9rr for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Mar 2022 23:48:17 -0500 (EST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59F5A40C95
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 23:48:17 -0500 (EST)
Received: by mail-pf1-f202.google.com with SMTP id
 c70-20020a624e49000000b004f69bac03d0so4519084pfb.13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Mar 2022 20:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=xCBZXe4E9m9q6+FTKOpm/OIuBMhCnJJ0A2x3FMK2uRw=;
 b=qHZml4JCTSvPLsXwRubE604N/sW/gRVnO+A/jEoff1E5Q6xoTJA3kjTGl5QeR/9Eht
 CyICyvdUR36IDY2/D5P5WCLosPf8CV/D2oeBPbcpnvBeeqPAKfEOQo7ZOlImpVlwgEYs
 y0XsFB2XOXHbVfJAWRxf5k2ZlsINEkck9fNNWgtcCVYwewF3n5srw8+EKFM+E+EeaxYA
 CdzD5xsW/KzhlO4smZpMHCwxefc2+wWkEeKtHHepk7IjePSjIF5ieAFvfDtM8fdW86il
 A4niMN5mj1duw7HLiPsg3BaYRevSvfJWXyQlWhDzfV3zy7A4T+6kh1HUv56t/jcIZgI/
 XVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=xCBZXe4E9m9q6+FTKOpm/OIuBMhCnJJ0A2x3FMK2uRw=;
 b=UJzMcCRLCFnfhwWvWuLduuzHe7QdZpA5eyBRK4EkQxyVHTIidGjBfuPrSCdxRyKU4I
 4t+m856n0nEfcoe6Nuij8+Laz7nOchpxZ4ktwIA/rcD26pz0JFFy16taoEwgD7V8YGdL
 dsJzpisOcTQYieIJLajhX0QL4r/oHjtkdzQy9xKYWXeJ+vaBITRMmvxhtEx3Q7Gln7KS
 SOBiDQetjVGzwD12eOV5/uSSDlFeI42pfg6wsSlCB18pnWBIzsSEEuGuXy4Eie9GbfvC
 HwoV68s2eKqrTV2SmYp69rMSrZRB5QYQkPJVQ4skEc5jYGrptzSTW8VQWeJ5cKXUTqB+
 FmrQ==
X-Gm-Message-State: AOAM533oa/Ga7n5tkaYuumAXdFE5fpvrnmHQ0i/wpX7u/bHAqBH+mgkW
 QJ/CGPiu1Z0C6nBon2sIdb//1uYk5ko=
X-Google-Smtp-Source: ABdhPJzj6nL4pWiYfgGNBZvQQApUL//v0g+9TDHguUna9Uaj8GEf5DP7qNgfDWRGQQjCPFqSL96Q92IIntY=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a62:5291:0:b0:4f7:ad3:1532 with SMTP id
 g139-20020a625291000000b004f70ad31532mr8541972pfb.80.1646974096269; Thu, 10
 Mar 2022 20:48:16 -0800 (PST)
Date: Thu, 10 Mar 2022 20:47:46 -0800
Message-Id: <20220311044811.1980336-1-reijiw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH v6 00/25] KVM: arm64: Make CPU ID registers writable by
 userspace
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

In KVM/arm64, values of ID registers for a guest are mostly same as
its host's values except for bits for feature that KVM doesn't support
and for opt-in features that userspace didn't configure.  Userspace
can use KVM_SET_ONE_REG to a set ID register value, but it fails
if userspace attempts to modify the register value.

This patch series adds support to allow userspace to modify a value of
ID registers (as long as KVM can support features that are indicated
in the registers) so userspace can have more control of configuring
and unconfiguring features for guests.  We need this because we would
like to expose a uniform set/level of features for a group of guests on
systems with different ARM CPUs.  Since some features are not binary
in nature (e.g. AA64DFR0_EL1.BRPs fields indicate number of
breakpoints minus 1), using KVM_ARM_VCPU_INIT to control such features
is inconvenient.

The patch series is for both VHE and non-VHE, except for protected VMs,
which have a different way of configuring ID registers based on its
different requirements [1].
There was a patch series that tried to achieve the same thing [2].
A few snippets of codes in this series were inspired by or came from [2].

The initial value of ID registers for a vCPU will be the host's value
with bits cleared for unsupported features and for opt-in features that
were not configured. So, the initial value userspace can see (via
KVM_GET_ONE_REG) is the upper limit that can be set for the register.
Any requests to change the value that conflicts with opt-in features'
configuration will fail (e.g. if KVM_ARM_VCPU_PMU_V3 is configured by
KVM_ARM_VCPU_INIT, ID_AA64DFR0_EL1.PMUVER cannot be set to zero.
Otherwise, the initial value of ID_AA64DFR0_EL1.PMUVER will be zero,
and cannot be changed from zero).

When a guest tries to use a CPU feature that is not exposed to the guest,
trapping it (to emulate a real CPU's behavior) would generally be a
desirable behavior (when it is possible with no or little side effects).
The later patches in the series add codes for this.  Only features that
can be trapped independently will be trapped by this series though.

This series adds kunit tests for new functions in sys_regs.c (except for
trivial ones), and these tests are enabled with a new configuration
option 'CONFIG_KVM_KUNIT_TEST'.

The series is based on v5.17-rc7 with the patch [3] applied.

v6:
  - Remove entries for all ID register entries from sys_reg_descs[],
    and use id_reg_desc_table[] for ID registers instead. [Oliver]
  - Remove sys_reg field from id_reg_info, add reg_desc (sys_reg_desc)
    field to id_reg_info, and rename 'id_reg_info' to 'id_reg_desc'.
  - Merge the following three patches of v5 into one patch "KVM: arm64:
    Make ID_AA64DFR0_EL1/ID_DFR0_EL1 writable" to accept userspace's
    request to set ID_AA64DFR0_EL1.PMUVER/ID_DFR0_EL1.PERFMON to 0xf
    (they are set to 0 though) even after applying the patch-10. [Oliver]
     patch-10 KVM: arm64: Hide IMPLEMENTATION DEFINED PMU support for the guest
     patch-11 KVM: arm64: Make ID_AA64DFR0_EL1 writable"
     patch-12 KVM: arm64: Make ID_DFR0_EL1 writable"

v5: https://lore.kernel.org/all/20220214065746.1230608-1-reijiw@google.com/
  - Change the return value of kcalloc failure of init_arm64_ftr_bits_kvm
    to -ENOMEM from ENOMEM. [Fuad]
  - Call init_arm64_ftr_bits_kvm from init_cpu_features(). [Ricardo, Fuad]
  - Move is_id_reg() in arch/arm64/kvm/sys_regs.c. [Fuad]
  - Remove frac_ftr_check from feature_frac [Fuad]
  - Rename kvm_id_regs_consistency_check() [Fuad]
  - Add feature_config_ctrl for ID_AA64DFR0_TRACEVER [Fuad]
  - Move changes for kvm_set_id_reg_feature and __modify_kvm_id_reg from
    patch-4 to patch-3. [Fuad]
  - Comment additions and fixes [Fuad]
  - Rename arm64_check_features() [Ricardo]
  - Run arm64_check_features_kvm() for the default guest value [Ricardo]
  - Add ID_AA64MMFR1_EL1.HAFDBS validation
  - Cosmetic fixes

v4: https://lore.kernel.org/all/20220106042708.2869332-1-reijiw@google.com/
  - Make ID registers storage per VM instead of per vCPU. [Marc]
  - Implement arm64_check_features() in arch/arm64/kernel/cpufeature.c
    by using existing codes in the file. [Marc]
  - Use a configuration function to enable traps for disabled
    features. [Marc]
  - Document ID registers become immutable after the first KVM_RUN [Eric]
  - Update ID_AA64PFR0.GIC at the point where a GICv3 is created. [Marc]
  - Get TGranX's bit position by substracting 12 from TGranX_2's bit
    position. [Eric]
  - Don't validate AArch32 ID registers when the system doesn't support
    32bit EL0. [Eric]
  - Add/fixes comments for patches. [Eric]
  - Made bug fixes/improvements of the selftest. [Eric]
  - Added .kunitconfig for arm64 KUnit tests

v3: https://lore.kernel.org/all/20211117064359.2362060-1-reijiw@google.com/
  - Remove ID register consistency checking across vCPUs. [Oliver]
  - Change KVM_CAP_ARM_ID_REG_WRITABLE to
    KVM_CAP_ARM_ID_REG_CONFIGURABLE. [Oliver]
  - Add KUnit testing for ID register validation and trap initialization.
  - Change read_id_reg() to take care of ID_AA64PFR0_EL1.GIC.
  - Add a helper of read_id_reg() (__read_id_reg()) and use the helper
    instead of directly using __vcpu_sys_reg().
  - Change not to run kvm_id_regs_consistency_check() and
    kvm_vcpu_init_traps() for protected VMs.
  - Update selftest to remove test cases for ID register consistency.
    checking across vCPUs and to add test cases for ID_AA64PFR0_EL1.GIC.

v2: https://lore.kernel.org/all/20211103062520.1445832-1-reijiw@google.com/
  - Remove unnecessary line breaks. [Andrew]
  - Use @params for comments. [Andrew]
  - Move arm64_check_features to arch/arm64/kvm/sys_regs.c and
    change that KVM specific feature check function.  [Andrew]
  - Remove unnecessary raz handling from __set_id_reg. [Andrew]
  - Remove sys_val field from the initial id_reg_info and add it
    in the later patch. [Andrew]
  - Call id_reg->init() from id_reg_info_init(). [Andrew]
  - Fix cpuid_feature_cap_perfmon_field() to convert 0xf to 0x0
    (and use it in the following patches).
  - Change kvm_vcpu_first_run_init to set has_run_once to false
    when kvm_id_regs_consistency_check() fails.
  - Add a patch to introduce id_reg_info for ID_AA64MMFR0_EL1,
    which requires special validity checking for TGran*_2 fields.
  - Add patches to introduce id_reg_info for ID_DFR1_EL1 and
    ID_MMFR0_EL1, which are required due to arm64_check_features
    implementation change.
  - Add a new argument, which is a pointer to id_reg_info, for
    id_reg_info's validate().

v1: https://lore.kernel.org/all/20211012043535.500493-1-reijiw@google.com/

[1] https://lore.kernel.org/all/20211010145636.1950948-1-tabba@google.com/
[2] https://lore.kernel.org/all/20201102033422.657391-1-liangpeng10@huawei.com/
[3] https://lore.kernel.org/all/20220127161759.53553-2-alexandru.elisei@arm.com/

Reiji Watanabe (25):
  KVM: arm64: Introduce a validation function for an ID register
  KVM: arm64: Save ID registers' sanitized value per guest
  KVM: arm64: Introduce struct id_reg_desc
  KVM: arm64: Make ID_AA64PFR0_EL1 writable
  KVM: arm64: Make ID_AA64PFR1_EL1 writable
  KVM: arm64: Make ID_AA64ISAR0_EL1 writable
  KVM: arm64: Make ID_AA64ISAR1_EL1 writable
  KVM: arm64: Make ID_AA64MMFR0_EL1 writable
  KVM: arm64: Make ID_AA64DFR0_EL1/ID_DFR0_EL1 writable
  KVM: arm64: Make MVFR1_EL1 writable
  KVM: arm64: Add remaining ID registers to id_reg_desc_table
  KVM: arm64: Use id_reg_desc_table for ID registers
  KVM: arm64: Add consistency checking for frac fields of ID registers
  KVM: arm64: Introduce KVM_CAP_ARM_ID_REG_CONFIGURABLE capability
  KVM: arm64: Add kunit test for ID register validation
  KVM: arm64: Use vcpu->arch cptr_el2 to track value of cptr_el2 for VHE
  KVM: arm64: Use vcpu->arch.mdcr_el2 to track value of mdcr_el2
  KVM: arm64: Introduce framework to trap disabled features
  KVM: arm64: Trap disabled features of ID_AA64PFR0_EL1
  KVM: arm64: Trap disabled features of ID_AA64PFR1_EL1
  KVM: arm64: Trap disabled features of ID_AA64DFR0_EL1
  KVM: arm64: Trap disabled features of ID_AA64MMFR1_EL1
  KVM: arm64: Trap disabled features of ID_AA64ISAR1_EL1
  KVM: arm64: Add kunit test for trap initialization
  KVM: arm64: selftests: Introduce id_reg_test

 Documentation/virt/kvm/api.rst                |   12 +
 arch/arm64/include/asm/cpufeature.h           |    3 +-
 arch/arm64/include/asm/kvm_arm.h              |   32 +
 arch/arm64/include/asm/kvm_host.h             |   15 +
 arch/arm64/include/asm/sysreg.h               |    5 +-
 arch/arm64/kernel/cpufeature.c                |  229 +++
 arch/arm64/kvm/.kunitconfig                   |    4 +
 arch/arm64/kvm/Kconfig                        |   11 +
 arch/arm64/kvm/arm.c                          |   24 +-
 arch/arm64/kvm/debug.c                        |   13 +-
 arch/arm64/kvm/hyp/vhe/switch.c               |   14 +-
 arch/arm64/kvm/sys_regs.c                     | 1637 +++++++++++++++--
 arch/arm64/kvm/sys_regs_test.c                | 1238 +++++++++++++
 arch/arm64/kvm/vgic/vgic-init.c               |    9 +
 include/uapi/linux/kvm.h                      |    1 +
 tools/arch/arm64/include/asm/sysreg.h         |    1 +
 tools/testing/selftests/kvm/.gitignore        |    1 +
 tools/testing/selftests/kvm/Makefile          |    1 +
 .../selftests/kvm/aarch64/id_reg_test.c       | 1300 +++++++++++++
 19 files changed, 4324 insertions(+), 226 deletions(-)
 create mode 100644 arch/arm64/kvm/.kunitconfig
 create mode 100644 arch/arm64/kvm/sys_regs_test.c
 create mode 100644 tools/testing/selftests/kvm/aarch64/id_reg_test.c


base-commit: d1358550d36d8514b340f27a35ee0afc68f27cfc
-- 
2.35.1.723.g4982287a31-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
