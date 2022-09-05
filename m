Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 194625ACCCB
	for <lists+kvmarm@lfdr.de>; Mon,  5 Sep 2022 09:31:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25A4A4C008;
	Mon,  5 Sep 2022 03:31:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iyqUCjKlK6c0; Mon,  5 Sep 2022 03:31:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8462C4BFFE;
	Mon,  5 Sep 2022 03:31:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D5C34BF9E
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Sep 2022 03:31:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aHjliZ7oQegu for <kvmarm@lists.cs.columbia.edu>;
 Mon,  5 Sep 2022 03:31:43 -0400 (EDT)
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C8BF94BE42
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Sep 2022 03:31:43 -0400 (EDT)
Date: Mon, 5 Sep 2022 09:31:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1662363102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRgVXREhnYAT2UWNxZgIgPWYkP5DgXnZ3gmvS0nsTF4=;
 b=PPMqe7wKlQ/65Q8WGpBqIXrecN3XgJnWaf9c6H0A94uv7qWM3jAWlxuIiTRFdrcJL4e2DJ
 ieF6OM+VKlBxFN0JV2bDVl5b9QldpfuOGhyBr6FIk66uLyHLfX5eP5VXjLRy8GwQ+E5cZ+
 QUim7QAeV6B1zXmG+09AFJvUHb8eskg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 7/7] KVM: selftests: Add test for RAZ/WI AArch32 ID
 registers
Message-ID: <20220905073140.lrsrbyu2zhkiki5a@kamzik>
References: <20220902154804.1939819-1-oliver.upton@linux.dev>
 <20220902154804.1939819-8-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220902154804.1939819-8-oliver.upton@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Fri, Sep 02, 2022 at 03:48:03PM +0000, Oliver Upton wrote:
> Add a test to assert that KVM handles the AArch64 views of the AArch32
> ID registers as RAZ/WI (writable only from userspace).
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/aarch64/aarch64_only_id_regs.c        | 135 ++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/aarch64_only_id_regs.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index d625a3f83780..4331af62a982 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +/aarch64/aarch64_only_id_regs
>  /aarch64/arch_timer
>  /aarch64/debug-exceptions
>  /aarch64/get-reg-list
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 4c122f1b1737..efe155259095 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -144,6 +144,7 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
>  # Compiled outputs used by test targets
>  TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
>  
> +TEST_GEN_PROGS_aarch64 += aarch64/aarch64_only_id_regs
>  TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
> diff --git a/tools/testing/selftests/kvm/aarch64/aarch64_only_id_regs.c b/tools/testing/selftests/kvm/aarch64/aarch64_only_id_regs.c
> new file mode 100644
> index 000000000000..704a3e7524a8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/aarch64_only_id_regs.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * aarch64_only_id_regs - Test for ID register behavior on AArch64-only systems
> + *
> + * Copyright (c) 2022 Google LLC.
> + *
> + * Test that KVM handles the AArch64 views of the AArch32 ID registers as RAZ
> + * and WI from userspace.
> + */
> +
> +#include <stdint.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "test_util.h"
> +
> +#define BAD_ID_REG_VAL	0x1badc0deul
> +
> +#define GUEST_ASSERT_REG_RAZ(reg)	GUEST_ASSERT_EQ(read_sysreg_s(reg), 0)
> +
> +static void guest_main(void)
> +{
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_PFR0_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_PFR1_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_DFR0_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_MMFR0_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_MMFR1_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_MMFR2_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_MMFR3_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_ISAR0_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_ISAR1_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_ISAR2_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_ISAR3_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_ISAR4_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_ISAR5_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_MMFR4_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_ISAR6_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_MVFR0_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_MVFR1_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_MVFR2_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_PFR2_EL1);
> +	GUEST_ASSERT_REG_RAZ(SYS_ID_MMFR5_EL1);
> +
> +	GUEST_DONE();
> +}
> +
> +static void test_guest_raz(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	vcpu_run(vcpu);
> +
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);
> +		break;
> +	case UCALL_DONE:
> +		break;
> +	default:
> +		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
> +	}
> +}
> +
> +static uint64_t reg_ids[] = {
> +	KVM_ARM64_SYS_REG(SYS_ID_PFR0_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_PFR1_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_DFR0_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_MMFR0_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_MMFR1_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_MMFR2_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_MMFR3_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_ISAR0_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_ISAR1_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_ISAR2_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_ISAR3_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_ISAR4_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_ISAR5_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_MMFR4_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_ISAR6_EL1),
> +	KVM_ARM64_SYS_REG(SYS_MVFR0_EL1),
> +	KVM_ARM64_SYS_REG(SYS_MVFR1_EL1),
> +	KVM_ARM64_SYS_REG(SYS_MVFR2_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_PFR2_EL1),
> +	KVM_ARM64_SYS_REG(SYS_ID_MMFR5_EL1),

Hi Oliver,

I see all the hidden and unallocated registers have been filtered out of
the test lists. They should also behave as RAZ, right? Maybe we should
keep them in the lists here for consistency and to test them as well.

Thanks,
drew

> +};
> +
> +static void test_user_raz_wi(struct kvm_vcpu *vcpu)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(reg_ids); i++) {
> +		uint64_t reg_id = reg_ids[i];
> +		uint64_t val;
> +
> +		vcpu_get_reg(vcpu, reg_id, &val);
> +		ASSERT_EQ(val, 0);
> +
> +		/*
> +		 * Expect the ioctl to succeed with no effect on the register
> +		 * value.
> +		 */
> +		vcpu_set_reg(vcpu, reg_id, BAD_ID_REG_VAL);
> +
> +		vcpu_get_reg(vcpu, reg_id, &val);
> +		ASSERT_EQ(val, 0);
> +	}
> +}
> +
> +static bool vcpu_aarch64_only(struct kvm_vcpu *vcpu)
> +{
> +	uint64_t val, el0;
> +
> +	vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_ID_AA64PFR0_EL1), &val);
> +
> +	el0 = (val & ARM64_FEATURE_MASK(ID_AA64PFR0_EL0)) >> ID_AA64PFR0_EL0_SHIFT;
> +	return el0 == ID_AA64PFR0_ELx_64BIT_ONLY;
> +}
> +
> +int main(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
> +
> +	TEST_REQUIRE(vcpu_aarch64_only(vcpu));
> +
> +	ucall_init(vm, NULL);
> +
> +	test_user_raz_wi(vcpu);
> +	test_guest_raz(vcpu);
> +
> +	ucall_uninit(vm);
> +	kvm_vm_free(vm);
> +}
> -- 
> 2.37.2.789.g6183377224-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
