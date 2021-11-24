Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52D45B89C
	for <lists+kvmarm@lfdr.de>; Wed, 24 Nov 2021 11:46:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B653A4B129;
	Wed, 24 Nov 2021 05:46:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36CUXa3VUHBg; Wed, 24 Nov 2021 05:46:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 036B14B132;
	Wed, 24 Nov 2021 05:46:50 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DFE1F49FB7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Nov 2021 05:46:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c+2WyCU18219 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Nov 2021 05:46:46 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DD15049DE7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Nov 2021 05:46:45 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632DA1FB;
 Wed, 24 Nov 2021 02:46:45 -0800 (PST)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C4A53F73B;
 Wed, 24 Nov 2021 02:46:42 -0800 (PST)
Date: Wed, 24 Nov 2021 10:48:35 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Reiji Watanabe <reijiw@google.com>
Subject: Re: [RFC PATCH v3 00/29] KVM: arm64: Make CPU ID registers writable
 by userspace
Message-ID: <YZ4Yg2R+r7q/iHpu@monolith.localdoman>
References: <20211117064359.2362060-1-reijiw@google.com>
 <YZ0WfQDGT5d8+6i1@monolith.localdoman>
 <CAAeT=FwTrWts=jdO2SzAECKKp5-1gGc5UR22Mf=xpx_8qOcbHw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAeT=FwTrWts=jdO2SzAECKKp5-1gGc5UR22Mf=xpx_8qOcbHw@mail.gmail.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

Hi Reiji,

On Tue, Nov 23, 2021 at 09:49:02PM -0800, Reiji Watanabe wrote:
> Hi Alex,
> 
> On Tue, Nov 23, 2021 at 8:25 AM Alexandru Elisei
> <alexandru.elisei@arm.com> wrote:
> >
> > Hi Reiji,
> >
> > The API documentation for KVM_ARM_VCPU_INIT states:
> >
> > "Userspace can call this function multiple times for a given vcpu,
> > including after the vcpu has been run. This will reset the vcpu to its
> > initial state. All calls to this function after the initial call must use
> > the same target and same set of feature flags, otherwise EINVAL will be
> > returned."
> >
> > The consequences of that, according to my understanding:
> >
> > 1. Any changes to the VCPU features made by KVM are observable by
> > userspace.
> >
> > 2. The features in KVM weren't designed and implemented to be disabled
> > after being enabled.
> >
> > With that in mind, I have two questions:
> >
> > 1. What happens when userspace disables a feature via the ID registers
> > which is set in vcpu->arch.features? Does the feature bit get cleared from
> > vcpu->arch.features? Does it stay set? If it gets cleared, is it now
> > possible for userspace to call KVM_ARM_VCPU_INIT again with a different set
> > of VCPU features (it doesn't look possible to me after looking at the
> > code). If it stays set, what does it mean when userspace calls
> > KVM_ARM_VCPU_INIT with a different set of features enabled than what is
> > present in the ID registers? Should the ID registers be changed to match
> > the features that userspace set in the last KVM_ARM_VCPU_INIT call (it
> > looks to me that the ID registers are not changed)?
> 
> KVM will not allow userspace to set the ID register value that conflicts
> with CPU features that are configured by the initial KVM_ARM_VCPU_INIT
> (or there are a few more APIs).
> KVM_SET_ONE_REG for such requests will fail.
> 
> 
> > 2. What happens to vcpu->arch.features when userspace enables a feature via
> > the ID registers which is not present in the bitmap?
> 
> The answer for this question is basically the same as above.
> Userspace is not allowed to enable a feature via the ID registers
> which is not present in the bit map.
> 
> The cover lever included a brief explanation of this, but I will
> try to improve the explanation:-)

So the ID registers are used to set the version of a feature which is present in
the VCPU features bitmap, not to enable or a disable a VCPU feature. Thank you
for the explanation!

Thanks,
Alex

> 
> Regards,
> Reiji
> 
> >
> > Thanks,
> > Alex
> >
> > On Tue, Nov 16, 2021 at 10:43:30PM -0800, Reiji Watanabe wrote:
> > > In KVM/arm64, values of ID registers for a guest are mostly same as
> > > its host's values except for bits for feature that KVM doesn't support
> > > and for opt-in features that userspace didn't configure.  Userspace
> > > can use KVM_SET_ONE_REG to a set ID register value, but it fails
> > > if userspace attempts to modify the register value.
> > >
> > > This patch series adds support to allow userspace to modify a value of
> > > ID registers (as long as KVM can support features that are indicated
> > > in the registers) so userspace can have more control of configuring
> > > and unconfiguring features for guests.
> > >
> > > The patch series is for both VHE and non-VHE, except for protected VMs,
> > > which have a different way of configuring ID registers based on its
> > > different requirements [1].
> > > There was a patch series that tried to achieve the same thing [2].
> > > A few snippets of codes in this series were inspired by or came from [2].
> > >
> > > The initial value of ID registers for a vCPU will be the host's value
> > > with bits cleared for unsupported features and for opt-in features that
> > > were not configured. So, the initial value userspace can see (via
> > > KVM_GET_ONE_REG) is the upper limit that can be set for the register.
> > > Any requests to change the value that conflicts with opt-in features'
> > > configuration will fail.
> > >
> > > When a guest tries to use a CPU feature that is not exposed to the guest,
> > > trapping it (to emulate a real CPU's behavior) would generally be a
> > > desirable behavior (when it is possible with no or little side effects).
> > > The later patches in the series add codes for this.  Only features that
> > > can be trapped independently will be trapped by this series though.
> > >
> > > This series adds kunit tests for new functions in sys_regs.c (except for
> > > trivial ones), and these tests are enabled with a new configuration
> > > option 'CONFIG_KVM_KUNIT_TEST'.
> > >
> > > The series is based on v5.16-rc1.
> > >
> > > v3:
> > >   - Remove ID register consistency checking across vCPUs [Oliver]
> > >   - Change KVM_CAP_ARM_ID_REG_WRITABLE to
> > >     KVM_CAP_ARM_ID_REG_CONFIGURABLE [Oliver]
> > >   - Add KUnit testing for ID register validation and trap initialization.
> > >   - Change read_id_reg() to take care of ID_AA64PFR0_EL1.GIC
> > >   - Add a helper of read_id_reg() (__read_id_reg()) and use the helper
> > >     instead of directly using __vcpu_sys_reg()
> > >   - Change not to run kvm_id_regs_consistency_check() and
> > >     kvm_vcpu_init_traps() for protected VMs.
> > >   - Update selftest to remove test cases for ID register consistency
> > >     checking across vCPUs and to add test cases for ID_AA64PFR0_EL1.GIC.
> > >
> > > v2: https://lore.kernel.org/all/20211103062520.1445832-1-reijiw@google.com/
> > >   - Remove unnecessary line breaks. [Andrew]
> > >   - Use @params for comments. [Andrew]
> > >   - Move arm64_check_features to arch/arm64/kvm/sys_regs.c and
> > >     change that KVM specific feature check function.  [Andrew]
> > >   - Remove unnecessary raz handling from __set_id_reg. [Andrew]
> > >   - Remove sys_val field from the initial id_reg_info and add it
> > >     in the later patch. [Andrew]
> > >   - Call id_reg->init() from id_reg_info_init(). [Andrew]
> > >   - Fix cpuid_feature_cap_perfmon_field() to convert 0xf to 0x0
> > >     (and use it in the following patches).
> > >   - Change kvm_vcpu_first_run_init to set has_run_once to false
> > >     when kvm_id_regs_consistency_check() fails.
> > >   - Add a patch to introduce id_reg_info for ID_AA64MMFR0_EL1,
> > >     which requires special validity checking for TGran*_2 fields.
> > >   - Add patches to introduce id_reg_info for ID_DFR1_EL1 and
> > >     ID_MMFR0_EL1, which are required due to arm64_check_features
> > >     implementation change.
> > >   - Add a new argument, which is a pointer to id_reg_info, for
> > >     id_reg_info's validate()
> > >
> > > v1: https://lore.kernel.org/all/20211012043535.500493-1-reijiw@google.com/
> > >
> > > [1] https://lore.kernel.org/kvmarm/20211010145636.1950948-1-tabba@google.com/
> > > [2] https://lore.kernel.org/kvm/20201102033422.657391-1-liangpeng10@huawei.com/
> > >
> > > Reiji Watanabe (29):
> > >   KVM: arm64: Add has_reset_once flag for vcpu
> > >   KVM: arm64: Save ID registers' sanitized value per vCPU
> > >   KVM: arm64: Introduce struct id_reg_info
> > >   KVM: arm64: Make ID_AA64PFR0_EL1 writable
> > >   KVM: arm64: Make ID_AA64PFR1_EL1 writable
> > >   KVM: arm64: Make ID_AA64ISAR0_EL1 writable
> > >   KVM: arm64: Make ID_AA64ISAR1_EL1 writable
> > >   KVM: arm64: Make ID_AA64MMFR0_EL1 writable
> > >   KVM: arm64: Hide IMPLEMENTATION DEFINED PMU support for the guest
> > >   KVM: arm64: Make ID_AA64DFR0_EL1 writable
> > >   KVM: arm64: Make ID_DFR0_EL1 writable
> > >   KVM: arm64: Make ID_DFR1_EL1 writable
> > >   KVM: arm64: Make ID_MMFR0_EL1 writable
> > >   KVM: arm64: Make MVFR1_EL1 writable
> > >   KVM: arm64: Make ID registers without id_reg_info writable
> > >   KVM: arm64: Add consistency checking for frac fields of ID registers
> > >   KVM: arm64: Introduce KVM_CAP_ARM_ID_REG_CONFIGURABLE capability
> > >   KVM: arm64: Add kunit test for ID register validation
> > >   KVM: arm64: Use vcpu->arch cptr_el2 to track value of cptr_el2 for VHE
> > >   KVM: arm64: Use vcpu->arch.mdcr_el2 to track value of mdcr_el2
> > >   KVM: arm64: Introduce framework to trap disabled features
> > >   KVM: arm64: Trap disabled features of ID_AA64PFR0_EL1
> > >   KVM: arm64: Trap disabled features of ID_AA64PFR1_EL1
> > >   KVM: arm64: Trap disabled features of ID_AA64DFR0_EL1
> > >   KVM: arm64: Trap disabled features of ID_AA64MMFR1_EL1
> > >   KVM: arm64: Trap disabled features of ID_AA64ISAR1_EL1
> > >   KVM: arm64: Initialize trapping of disabled CPU features for the guest
> > >   KVM: arm64: Add kunit test for trap initialization
> > >   KVM: arm64: selftests: Introduce id_reg_test
> > >
> > >  Documentation/virt/kvm/api.rst                |    8 +
> > >  arch/arm64/include/asm/cpufeature.h           |    2 +-
> > >  arch/arm64/include/asm/kvm_arm.h              |   32 +
> > >  arch/arm64/include/asm/kvm_host.h             |   15 +
> > >  arch/arm64/include/asm/sysreg.h               |    2 +
> > >  arch/arm64/kvm/Kconfig                        |   11 +
> > >  arch/arm64/kvm/arm.c                          |   12 +-
> > >  arch/arm64/kvm/debug.c                        |   13 +-
> > >  arch/arm64/kvm/hyp/vhe/switch.c               |   14 +-
> > >  arch/arm64/kvm/reset.c                        |    4 +
> > >  arch/arm64/kvm/sys_regs.c                     | 1265 +++++++++++++++--
> > >  arch/arm64/kvm/sys_regs_test.c                | 1109 +++++++++++++++
> > >  include/uapi/linux/kvm.h                      |    1 +
> > >  tools/arch/arm64/include/asm/sysreg.h         |    1 +
> > >  tools/testing/selftests/kvm/.gitignore        |    1 +
> > >  tools/testing/selftests/kvm/Makefile          |    1 +
> > >  .../selftests/kvm/aarch64/id_reg_test.c       | 1128 +++++++++++++++
> > >  17 files changed, 3488 insertions(+), 131 deletions(-)
> > >  create mode 100644 arch/arm64/kvm/sys_regs_test.c
> > >  create mode 100644 tools/testing/selftests/kvm/aarch64/id_reg_test.c
> > >
> > > --
> > > 2.34.0.rc1.387.gb447b232ab-goog
> > >
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
