Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 24A154C4C36
	for <lists+kvmarm@lfdr.de>; Fri, 25 Feb 2022 18:34:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CE034B922;
	Fri, 25 Feb 2022 12:34:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZfaQ4NbRF-rd; Fri, 25 Feb 2022 12:34:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A5324B91C;
	Fri, 25 Feb 2022 12:34:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 09D244B903
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 12:34:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WkcAvVA64+ft for <kvmarm@lists.cs.columbia.edu>;
 Fri, 25 Feb 2022 12:34:25 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C9C654B8FD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 25 Feb 2022 12:34:25 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BC9B4B832CF;
 Fri, 25 Feb 2022 17:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FD7C340E7;
 Fri, 25 Feb 2022 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645810462;
 bh=B1Qc6jknaHGC/0addMl7PeOeRxPk4VjDa3G1CJmsGpw=;
 h=From:To:Cc:Subject:Date:From;
 b=KWeom6lxlRkr+ds1BYsxuDLKoKK3rwpxxQA0uYH/CnpdQaoGHKqMhhXaVElxvpea4
 6K3GhwzevetvKNHdxMST2RBiHXvZtcE03jDz9byRVeXT6jgZ7lj+E56qz+aNZZ4oaW
 iP8RQ3+7zPXEJCM3cLYWF5MrHVGEac+62redRT0pZNFnTByd8y3jY66cofc5RK2RpK
 iDElvfKjUnBq45FnwbZptTRTc7npNdljMTjB4S/ovverpZHwUNtviTtZIlnDc008UW
 Qtptm8DKcywqidWAaxLvWvaiCyFXWM7poT+fIXkLQQi6tDw6FLQrJMbvv+R5CJCdqM
 0oRkGkz8fUMhA==
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>
Subject: [PATCH v12 00/40] arm64/sme: Initial support for the Scalable Matrix
 Extension
Date: Fri, 25 Feb 2022 16:58:43 +0000
Message-Id: <20220225165923.1474372-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16151; h=from:subject;
 bh=B1Qc6jknaHGC/0addMl7PeOeRxPk4VjDa3G1CJmsGpw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiGQrKutDoedyali0hv+J8Isn20MLujCm7kw90TyoH
 kmn4s+CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhkKygAKCRAk1otyXVSH0EKoB/
 9ZhwPsZYw5Y09RrEV0m9YDieURwT6rOUlbpKulqU+AnBxgF3tfMMuqTz7NDM6h6lZO0fMQfNOBQpFP
 Hdd6q0+mfZNqL8n7wHQ+2b+TbJaePjC+6t2Z8d9qe1SescTIE8fVq7YP3VNs14zGAfT7UUSI7RbSEG
 ED++zyGKnghbbQVJ+oSWZmcrFhvmBsJQ62exv2y90dfd0MBOIWzxMslVDNFP4KjjkWfWNZE1BpJugC
 wEls2Ve/nLK8JF8yvUej+IHf9KYPGVNSBXgQzGuddHiUpyCROX6lUUQaCx2nkAjq5V3EHR4rFrvJxY
 pFX7QS18iBiaaDOjw5NGvVF8kT53q7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Luis Machado <luis.machado@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
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

This series provides initial support for the ARMv9 Scalable Matrix
Extension (SME).  SME takes the approach used for vectors in SVE and
extends this to provide architectural support for matrix operations.  A
more detailed overview can be found in [1].

For the kernel SME can be thought of as a series of features which are
intended to be used together by applications but operate mostly
orthogonally:

 - The ZA matrix register.
 - Streaming mode, in which ZA can be accessed and a subset of SVE
   features are available.
 - A second vector length, used for streaming mode SVE and ZA and
   controlled using a similar interface to that for SVE.
 - TPIDR2, a new userspace controllable system register intended for use
   by the C library for storing context related to the ZA ABI.

A substantial part of the series is dedicated to refactoring the
existing SVE support so that we don't need to duplicate code for
handling vector lengths and the SVE registers, this involves creating an
array of vector types and making the users take the vector type as a
parameter.  I'm not 100% happy with this but wasn't able to come up with
anything better, duplicating code definitely felt like a bad idea so
this felt like the least bad thing.  If this approach makes sense to
people it might make sense to split this off into a separate series
and/or merge it while the rest is pending review to try to make things a
little more digestable, the series is very large so it'd probably make
things easier to digest if some of the preparatory refactoring could be
merged before the rest is ready.

One feature of the architecture of particular note is that switching
to and from streaming mode may change the size of and invalidate the
contents of the SVE registers, and when in streaming mode the FFR is not
accessible.  This complicates aspects of the ABI like signal handling
and ptrace.

This initial implementation is mainly intended to get the ABI in place,
there are several areas which will be worked on going forwards - some of
these will be blockers, others could be handled in followup serieses:

 - SME is currently not supported for KVM guests, this will be done as a
   followup series.  A host system can use SME and run KVM guests but
   SME is not available in the guests.
 - The KVM host support is done in a very simplistic way, were anyone to
   attempt to use it in production there would be performance impacts on
   hosts with SME support. As part of this we also add enumeration of
   fine grained traps.
 - There is not currently ptrace or signal support TPIDR2, this will be
   done as a followup series.
 - No support is currently provided for scheduler control of SME or SME
   applications, given the size of the SME register state the context
   switch overhead may be noticable so this may be needed especially for
   real time applications.  Similar concerns already exist for larger
   SVE vector lengths but are amplified for SME, particularly as the
   vector length increases.
 - There has been no work on optimising the performance of anything the
   kernel does.

It is not expected that any systems will be encountered that support SME
but not SVE, SME is an ARMv9 feature and SVE is mandatory for ARMv9.
The code attempts to handle any such systems that are encountered but
this hasn't been tested extensively.

v12:
 - Fix some typos in the ABI document.
 - Print a message when we skip a vector length in the signal tests.
 - Add note of earliest toolchain versions with SME to manual encodings
   for future reference now that's landed.
 - Drop reference to PCS in sme.rst, it's not referenced and one of the
   links was broken.
 - Encode smstop and smstart as sysregs in the kernel.
 - Don't redundantly flush the SVE register state when loading FPSIMD
   state with SME enabled for the task, the architecture will do this
   for us.
 - Introduce and use task_get_cur_vl() to get the vector length for the
   currently active SVE registers.
 - Fix support for !FA64 mode in signal and syscall tests.
 - Simplify instruction sequence for ssve_regs signal test.
 - Actually include the ZA signal test in the patch set.
v11:
 - Rebase onto v5.17-rc3.
 - Provide a sme-inst.h to collect manual encodings in kselftest.
v10:
 - Actually do the rebase of fixups from the previous version into
   relevant patches.
v9:
 - Remove defensive programming around IS_ENABLED() and FGT in KVM code.
 - Fix naming of TPIDR2 FGT register bit.
 - Add patches making handling of floating point register bits more
   consistent (also sent as separate series).
 - Drop now unused enumeration of fine grained traps.
v8:
 - Rebase onto v5.17-rc1.
 - Support interoperation with KVM, SME is disabled for KVM guests with
   minimal handling for cleaning up SME state when entering and leaving
   the guest.
 - Document and implement that signal handlers are invoked with ZA and
   streaming mode disabled.
 - Use the RDSVL instruction introduced in EAC2 of the architecture to
   obtain the streaming mode vector length during enumeration, ZA state
   loading/saving and in test programs.
 - Store a pointer to SVCR in fpsimd_last_state and use it in fpsimd_save()
   for interoperation with KVM.
 - Add a test case sme_trap_no_sm checking that we generate a SIGILL
   when using an instruction that requires streaming mode without
   enabling it.
 - Add basic ZA context form validation to testcases helper library.
 - Move signal tests over to validating streaming VL from ZA information.
 - Pulled in patch removing ARRAY_SIZE() so that kselftest builds
   cleanly and to avoid trivial conflicts.
v7:
 - Rebase onto v5.16-rc3.
 - Reduce indentation when supporting custom triggers for signal tests
   as suggested by Catalin.
 - Change to specifying a width for all CPU features rather than adding
   single bit specific infrastructure.
 - Don't require zeroing of non-shared SVE state during syscalls.
v6:
 - Rebase onto v5.16-rc1.
 - Return to disabling TIF_SVE on kernel entry even if we have SME
   state, this avoids the need for KVM to handle the case where TIF_SVE
   is set on guest entry.
 - Add syscall-abi.h to SME updates to syscall-abi, mistakenly omitted
   from commit.
v5:
 - Rebase onto currently merged SVE and kselftest patches.
 - Add support for the FA64 option, introduced in the recently published
   EAC1 update to the specification.
 - Pull in test program for the syscall ABI previously sent separately
   with some revisions and add coverage for the SME ABI.
 - Fix checking for options with 1 bit fields in ID_AA64SMFR0_EL1.
 - Minor fixes and clarifications to the ABI documentation.
v4:
 - Rebase onto merged patches.
 - Remove an uneeded NULL check in vec_proc_do_default_vl().
 - Include patch to factor out utility routines in kselftests written in
   assembler.
 - Specify -ffreestanding when building TPIDR2 test.
v3:
 - Skip FFR rather than predicate registers in sve_flush_live().
 - Don't assume a bool is all zeros in sve_flush_live() as per AAPCS.
 - Don't redundantly specify a zero index when clearing FFR.
v2:
 - Fix several issues with !SME and !SVE configurations.
 - Preserve TPIDR2 when creating a new thread/process unless
   CLONE_SETTLS is set.
 - Report traps due to using features in an invalid mode as SIGILL.
 - Spell out streaming mode behaviour in SVE ABI documentation more
   directly.
 - Document TPIDR2 in the ABI document.
 - Use SMSTART and SMSTOP rather than read/modify/write sequences.
 - Rework logic for exiting streaming mode on syscall.
 - Don't needlessly initialise SVCR on access trap.
 - Always restore SME VL for userspace if SME traps are disabled.
 - Only yield to encourage preemption every 128 iterations in za-test,
   otherwise do a getpid(), and validate SVCR after syscall.
 - Leave streaming mode disabled except when reading the vector length
   in za-test, and disable ZA after detecting a mismatch.
 - Add SME support to vlset.
 - Clarifications and typo fixes in comments.
 - Move sme_alloc() forward declaration back a patch.

[1] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/scalable-matrix-extension-armv9-a-architecture

Mark Brown (40):
  arm64: Define CPACR_EL1_FPEN similarly to other floating point
    controls
  arm64: Always use individual bits in CPACR floating point enables
  arm64: cpufeature: Always specify and use a field width for
    capabilities
  kselftest/arm64: Remove local ARRAY_SIZE() definitions
  kselftest/arm64: signal: Allow tests to be incompatible with features
  arm64/sme: Provide ABI documentation for SME
  arm64/sme: System register and exception syndrome definitions
  arm64/sme: Manually encode SME instructions
  arm64/sme: Early CPU setup for SME
  arm64/sme: Basic enumeration support
  arm64/sme: Identify supported SME vector lengths at boot
  arm64/sme: Implement sysctl to set the default vector length
  arm64/sme: Implement vector length configuration prctl()s
  arm64/sme: Implement support for TPIDR2
  arm64/sme: Implement SVCR context switching
  arm64/sme: Implement streaming SVE context switching
  arm64/sme: Implement ZA context switching
  arm64/sme: Implement traps and syscall handling for SME
  arm64/sme: Disable ZA and streaming mode when handling signals
  arm64/sme: Implement streaming SVE signal handling
  arm64/sme: Implement ZA signal handling
  arm64/sme: Implement ptrace support for streaming mode SVE registers
  arm64/sme: Add ptrace support for ZA
  arm64/sme: Disable streaming mode and ZA when flushing CPU state
  arm64/sme: Save and restore streaming mode over EFI runtime calls
  KVM: arm64: Hide SME system registers from guests
  KVM: arm64: Trap SME usage in guest
  KVM: arm64: Handle SME host state when running guests
  arm64/sme: Provide Kconfig for SME
  kselftest/arm64: Add manual encodings for SME instructions
  kselftest/arm64: sme: Add SME support to vlset
  kselftest/arm64: Add tests for TPIDR2
  kselftest/arm64: Extend vector configuration API tests to cover SME
  kselftest/arm64: sme: Provide streaming mode SVE stress test
  kselftest/arm64: signal: Handle ZA signal context in core code
  kselftest/arm64: Add stress test for SME ZA context switching
  kselftest/arm64: signal: Add SME signal handling tests
  kselftest/arm64: Add streaming SVE to SVE ptrace tests
  kselftest/arm64: Add coverage for the ZA ptrace interface
  kselftest/arm64: Add SME support to syscall ABI test

 Documentation/arm64/elf_hwcaps.rst            |  33 +
 Documentation/arm64/index.rst                 |   1 +
 Documentation/arm64/sme.rst                   | 427 +++++++++++++
 Documentation/arm64/sve.rst                   |  70 ++-
 arch/arm64/Kconfig                            |  11 +
 arch/arm64/include/asm/cpu.h                  |   4 +
 arch/arm64/include/asm/cpufeature.h           |  25 +
 arch/arm64/include/asm/el2_setup.h            |  64 +-
 arch/arm64/include/asm/esr.h                  |  13 +-
 arch/arm64/include/asm/exception.h            |   1 +
 arch/arm64/include/asm/fpsimd.h               | 110 +++-
 arch/arm64/include/asm/fpsimdmacros.h         |  87 +++
 arch/arm64/include/asm/hwcap.h                |   8 +
 arch/arm64/include/asm/kvm_arm.h              |   5 +-
 arch/arm64/include/asm/kvm_host.h             |   4 +
 arch/arm64/include/asm/processor.h            |  26 +-
 arch/arm64/include/asm/sysreg.h               |  71 ++-
 arch/arm64/include/asm/thread_info.h          |   2 +
 arch/arm64/include/uapi/asm/hwcap.h           |   8 +
 arch/arm64/include/uapi/asm/ptrace.h          |  69 ++-
 arch/arm64/include/uapi/asm/sigcontext.h      |  55 +-
 arch/arm64/kernel/cpufeature.c                | 273 +++++++--
 arch/arm64/kernel/cpuinfo.c                   |  13 +
 arch/arm64/kernel/entry-common.c              |  11 +
 arch/arm64/kernel/entry-fpsimd.S              |  36 ++
 arch/arm64/kernel/fpsimd.c                    | 565 ++++++++++++++++--
 arch/arm64/kernel/process.c                   |  28 +-
 arch/arm64/kernel/ptrace.c                    | 356 +++++++++--
 arch/arm64/kernel/signal.c                    | 188 +++++-
 arch/arm64/kernel/syscall.c                   |  29 +-
 arch/arm64/kernel/traps.c                     |   1 +
 arch/arm64/kvm/fpsimd.c                       |  43 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |   4 +-
 arch/arm64/kvm/hyp/nvhe/switch.c              |  30 +
 arch/arm64/kvm/hyp/vhe/switch.c               |  15 +-
 arch/arm64/kvm/sys_regs.c                     |   9 +-
 arch/arm64/tools/cpucaps                      |   2 +
 include/uapi/linux/elf.h                      |   2 +
 include/uapi/linux/prctl.h                    |   9 +
 kernel/sys.c                                  |  12 +
 tools/testing/selftests/arm64/abi/.gitignore  |   1 +
 tools/testing/selftests/arm64/abi/Makefile    |   9 +-
 .../selftests/arm64/abi/syscall-abi-asm.S     |  79 ++-
 .../testing/selftests/arm64/abi/syscall-abi.c | 205 ++++++-
 .../testing/selftests/arm64/abi/syscall-abi.h |  15 +
 tools/testing/selftests/arm64/abi/tpidr2.c    | 298 +++++++++
 tools/testing/selftests/arm64/fp/.gitignore   |   4 +
 tools/testing/selftests/arm64/fp/Makefile     |  12 +-
 tools/testing/selftests/arm64/fp/rdvl-sme.c   |  14 +
 tools/testing/selftests/arm64/fp/rdvl.S       |  10 +
 tools/testing/selftests/arm64/fp/rdvl.h       |   1 +
 tools/testing/selftests/arm64/fp/sme-inst.h   |  51 ++
 tools/testing/selftests/arm64/fp/ssve-stress  |  59 ++
 tools/testing/selftests/arm64/fp/sve-ptrace.c |  13 +-
 tools/testing/selftests/arm64/fp/sve-test.S   |  20 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c |  10 +
 tools/testing/selftests/arm64/fp/vlset.c      |  10 +-
 tools/testing/selftests/arm64/fp/za-ptrace.c  | 354 +++++++++++
 tools/testing/selftests/arm64/fp/za-stress    |  59 ++
 tools/testing/selftests/arm64/fp/za-test.S    | 388 ++++++++++++
 .../testing/selftests/arm64/signal/.gitignore |   3 +
 .../selftests/arm64/signal/test_signals.h     |   5 +
 .../arm64/signal/test_signals_utils.c         |  40 +-
 .../arm64/signal/test_signals_utils.h         |   2 +
 .../testcases/fake_sigreturn_sme_change_vl.c  |  92 +++
 .../arm64/signal/testcases/sme_trap_no_sm.c   |  38 ++
 .../signal/testcases/sme_trap_non_streaming.c |  45 ++
 .../arm64/signal/testcases/sme_trap_za.c      |  36 ++
 .../selftests/arm64/signal/testcases/sme_vl.c |  68 +++
 .../arm64/signal/testcases/ssve_regs.c        | 133 +++++
 .../arm64/signal/testcases/testcases.c        |  36 ++
 .../arm64/signal/testcases/testcases.h        |   3 +-
 .../arm64/signal/testcases/za_regs.c          | 128 ++++
 73 files changed, 4711 insertions(+), 250 deletions(-)
 create mode 100644 Documentation/arm64/sme.rst
 create mode 100644 tools/testing/selftests/arm64/abi/syscall-abi.h
 create mode 100644 tools/testing/selftests/arm64/abi/tpidr2.c
 create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sme.c
 create mode 100644 tools/testing/selftests/arm64/fp/sme-inst.h
 create mode 100644 tools/testing/selftests/arm64/fp/ssve-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-ptrace.c
 create mode 100644 tools/testing/selftests/arm64/fp/za-stress
 create mode 100644 tools/testing/selftests/arm64/fp/za-test.S
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_no_sm.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_non_streaming.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_trap_za.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/sme_vl.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/za_regs.c


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
