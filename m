Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 813B5369104
	for <lists+kvmarm@lfdr.de>; Fri, 23 Apr 2021 13:22:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F194E4B4FC;
	Fri, 23 Apr 2021 07:22:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9fTtCqYWZw2; Fri, 23 Apr 2021 07:22:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 758344B3B1;
	Fri, 23 Apr 2021 07:22:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BCE414B35A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Apr 2021 07:22:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 603JSIvtNWov for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Apr 2021 07:22:29 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 653544B270
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Apr 2021 07:22:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619176949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qKak5PAjD7nwuV1d6xM0s2XCPnXHbQUu3Rp7wokfhE=;
 b=V5jidbKkHkadmGIMEh1GQv3ligdgAdFCyGi+auR+m90m89FnP3N+gcFa+gmeXojDNQPPrb
 g8NYdbPQ4E6id+JYg5VqJ8J1yQgaP5NVb3ctaLuKdCUboCcxbvvwTobPsHpBGYZJUoh6Ii
 zADrULLpzLmu/TQRX5/IpnYA1SnYoGI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-lf9PCh_8OQSmqjO2s2p3Ww-1; Fri, 23 Apr 2021 07:22:27 -0400
X-MC-Unique: lf9PCh_8OQSmqjO2s2p3Ww-1
Received: by mail-wm1-f71.google.com with SMTP id
 d78-20020a1c1d510000b0290132794b7801so637940wmd.1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Apr 2021 04:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5qKak5PAjD7nwuV1d6xM0s2XCPnXHbQUu3Rp7wokfhE=;
 b=TP+u9ImCz6lRzaKaEveI/lePmEaBZInrt0DflQuw2zueIhSUs2OdlfqZrzj58tBsgH
 RXRmKYoYB/ZG4LHlf+GO1JRst4h57FodKdluSjMqcPxGcYmeaYa0zYWlK7Su8JPbSUwC
 aeWaS7JrYzXr1ktwJ5k0fugrjkBa8SJBGtBzLGz9PoKLzCpTL5miqaUrGQcKaXYLqd5F
 NWHDrIUisOVxBODUxqjJhD6bx/jnF5HaggkKrrHDMRQuToIjpy/MbrsvLryBQApwdsGB
 67/oKjnGlshth5dZcYVELVRspdmxTE9Ql4Nxtvbwts9ZosnM468GOk8plwJ6ablGIojq
 Z/qA==
X-Gm-Message-State: AOAM5301zqvvZ1wDH/UXmxG6G3CM7JMLX9G0of/PJmS03MzqiUy0TQCE
 BnZN5957INxokIp5iPfUv6f1CxRNjqelwWHle7Impzw44cDuSKEm2/mDFpNO8UFXTfeiW1TnHrb
 NF21BsBHEHihwi5u1l330ILmN
X-Received: by 2002:a5d:5151:: with SMTP id u17mr4228799wrt.413.1619176946396; 
 Fri, 23 Apr 2021 04:22:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/sCh8tKwrqR5d5QfxgBLR2KIXpZhslJWMqDfX5PwpKPlYvr7iyhP8mDmv5U3xY2nQG/pJAQ==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr4228776wrt.413.1619176946175; 
 Fri, 23 Apr 2021 04:22:26 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id h63sm7597392wmh.13.2021.04.23.04.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 04:22:25 -0700 (PDT)
Date: Fri, 23 Apr 2021 13:22:23 +0200
From: Andrew Jones <drjones@redhat.com>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH 2/3] KVM: selftests: Add aarch64/debug-exceptions test
Message-ID: <20210423112223.f45wsjq2biunbmcb@gator>
References: <20210423040351.1132218-1-ricarkol@google.com>
 <20210423040351.1132218-3-ricarkol@google.com>
MIME-Version: 1.0
In-Reply-To: <20210423040351.1132218-3-ricarkol@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maz@kernel.org, pbonzini@redhat.com,
 kvmarm@lists.cs.columbia.edu
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

On Thu, Apr 22, 2021 at 09:03:50PM -0700, Ricardo Koller wrote:
> Covers fundamental tests for debug exceptions. The guest installs and
> handle its debug exceptions itself, without KVM_SET_GUEST_DEBUG.
> 
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/aarch64/debug-exceptions.c  | 250 ++++++++++++++++++
>  .../selftests/kvm/include/aarch64/processor.h |  17 ++
>  4 files changed, 269 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index e65d5572aefc..f09ed908422b 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +/aarch64/debug-exceptions
>  /aarch64/get-reg-list
>  /aarch64/get-reg-list-sve
>  /aarch64/vgic_init
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 618c5903f478..2f92442c0cc9 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -73,6 +73,7 @@ TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
>  TEST_GEN_PROGS_x86_64 += set_memory_region_test
>  TEST_GEN_PROGS_x86_64 += steal_time
>  
> +TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
>  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
>  TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
> diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> new file mode 100644
> index 000000000000..18e8de2711d3
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE /* for program_invocation_short_name */

There's no reference to program_invocation_short_name below.

> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <semaphore.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <asm/barrier.h>
> +
> +#include <linux/compiler.h>
> +
> +#include <test_util.h>
> +#include <kvm_util.h>
> +#include <processor.h>

This is a boatload of includes, but it looks to me like all we need are
the bottom three. Also, our pattern is to use "" for these local to kvm
selftests includes.

> +
> +#define VCPU_ID 0
> +
> +extern unsigned char sw_bp, hw_bp, bp_svc, bp_brk, hw_wp, ss_start;
> +static volatile uint64_t sw_bp_addr, hw_bp_addr;
> +static volatile uint64_t wp_addr, wp_data_addr;
> +static volatile uint64_t svc_addr;
> +static volatile uint64_t ss_addr[4], ss_idx;
> +#define  CAST_TO_PC(v)  ((uint64_t)&(v))

The 'CAST_TO_' prefix isn't necessary, please just use PC()

> +
> +static void reset_debug_state(void)
> +{
> +	asm volatile("msr daifset, #8");
> +
> +	write_sysreg(osdlr_el1, 0);
> +	write_sysreg(oslar_el1, 0);
> +	asm volatile("isb" : : : "memory");
> +
> +	write_sysreg(mdscr_el1, 0);
> +	/* This test only uses the first bp and wp slot. */
> +	write_sysreg(dbgbvr0_el1, 0);
> +	write_sysreg(dbgbcr0_el1, 0);
> +	write_sysreg(dbgwcr0_el1, 0);
> +	write_sysreg(dbgwvr0_el1, 0);
> +	asm volatile("isb" : : : "memory");
> +}
> +
> +static void install_wp(uint64_t addr)
> +{
> +	uint32_t wcr;
> +	uint32_t mdscr;
> +
> +	wcr = DBGWCR_LEN8 | DBGWCR_RD | DBGWCR_WR | DBGWCR_EL1 | DBGWCR_E;
> +	write_sysreg(dbgwcr0_el1, wcr);
> +	write_sysreg(dbgwvr0_el1, addr);
> +	asm volatile("isb" : : : "memory");
> +
> +	asm volatile("msr daifclr, #8");
> +
> +	mdscr = read_sysreg(mdscr_el1) | MDSCR_KDE | MDSCR_MDE;
> +	write_sysreg(mdscr_el1, mdscr);
> +}
> +
> +static void install_hw_bp(uint64_t addr)
> +{
> +	uint32_t bcr;
> +	uint32_t mdscr;
> +
> +	bcr = DBGBCR_LEN8 | DBGBCR_EXEC | DBGBCR_EL1 | DBGBCR_E;
> +	write_sysreg(dbgbcr0_el1, bcr);
> +	write_sysreg(dbgbvr0_el1, addr);
> +	asm volatile("isb" : : : "memory");
> +
> +	asm volatile("msr daifclr, #8");
> +
> +	mdscr = read_sysreg(mdscr_el1) | MDSCR_KDE | MDSCR_MDE;
> +	write_sysreg(mdscr_el1, mdscr);
> +}
> +
> +static void install_ss(void)
> +{
> +	uint32_t mdscr;
> +
> +	asm volatile("msr daifclr, #8");
> +
> +	mdscr = read_sysreg(mdscr_el1) | MDSCR_KDE | MDSCR_SS;
> +	write_sysreg(mdscr_el1, mdscr);
> +}
> +
> +static volatile char write_data;
> +
> +#define GUEST_ASSERT_EQ(arg1, arg2) \
> +	GUEST_ASSERT_2((arg1) == (arg2), (arg1), (arg2))

Please add this to kvm_util.h.

> +
> +static void guest_code(void)
> +{
> +	GUEST_SYNC(0);
> +
> +	/* Software-breakpoint */
> +	asm volatile("sw_bp: brk #0");
> +	GUEST_ASSERT_EQ(sw_bp_addr, CAST_TO_PC(sw_bp));
> +
> +	GUEST_SYNC(1);
> +
> +	/* Hardware-breakpoint */
> +	reset_debug_state();
> +	install_hw_bp(CAST_TO_PC(hw_bp));
> +	asm volatile("hw_bp: nop");
> +	GUEST_ASSERT_EQ(hw_bp_addr, CAST_TO_PC(hw_bp));
> +
> +	GUEST_SYNC(2);
> +
> +	/* Hardware-breakpoint + svc */
> +	reset_debug_state();
> +	install_hw_bp(CAST_TO_PC(bp_svc));
> +	asm volatile("bp_svc: svc #0");
> +	GUEST_ASSERT_EQ(hw_bp_addr, CAST_TO_PC(bp_svc));
> +	GUEST_ASSERT_EQ(svc_addr, CAST_TO_PC(bp_svc) + 4);
> +
> +	GUEST_SYNC(3);
> +
> +	/* Hardware-breakpoint + software-breakpoint */
> +	reset_debug_state();
> +	install_hw_bp(CAST_TO_PC(bp_brk));
> +	asm volatile("bp_brk: brk #0");
> +	GUEST_ASSERT_EQ(sw_bp_addr, CAST_TO_PC(bp_brk));
> +	GUEST_ASSERT_EQ(hw_bp_addr, CAST_TO_PC(bp_brk));
> +
> +	GUEST_SYNC(4);
> +
> +	/* Watchpoint */
> +	reset_debug_state();
> +	install_wp(CAST_TO_PC(write_data));
> +	write_data = 'x';
> +	GUEST_ASSERT_EQ(write_data, 'x');
> +	GUEST_ASSERT_EQ(wp_data_addr, CAST_TO_PC(write_data));
> +
> +	GUEST_SYNC(5);
> +
> +	/* Single-step */
> +	reset_debug_state();
> +	install_ss();
> +	ss_idx = 0;
> +	asm volatile("ss_start:\n"
> +		     "mrs x0, esr_el1\n"
> +		     "add x0, x0, #1\n"
> +		     "msr daifset, #8\n"
> +		     : : : "x0");
> +	GUEST_ASSERT_EQ(ss_addr[0], CAST_TO_PC(ss_start));
> +	GUEST_ASSERT_EQ(ss_addr[1], CAST_TO_PC(ss_start) + 4);
> +	GUEST_ASSERT_EQ(ss_addr[2], CAST_TO_PC(ss_start) + 8);
> +
> +	GUEST_DONE();
> +}
> +
> +static void guest_sw_bp_handler(struct ex_regs *regs)
> +{
> +	sw_bp_addr = regs->pc;
> +	regs->pc += 4;
> +}
> +
> +static void guest_hw_bp_handler(struct ex_regs *regs)
> +{
> +	hw_bp_addr = regs->pc;
> +	regs->pstate |= SPSR_D;
> +}
> +
> +static void guest_wp_handler(struct ex_regs *regs)
> +{
> +	wp_data_addr = read_sysreg(far_el1);
> +	wp_addr = regs->pc;
> +	regs->pstate |= SPSR_D;
> +}
> +
> +static void guest_ss_handler(struct ex_regs *regs)
> +{
> +	GUEST_ASSERT_1(ss_idx < 4, ss_idx);
> +	ss_addr[ss_idx++] = regs->pc;
> +	regs->pstate |= SPSR_SS;
> +}
> +
> +static void guest_svc_handler(struct ex_regs *regs)
> +{
> +	svc_addr = regs->pc;
> +}
> +
> +static int debug_version(struct kvm_vm *vm)
> +{
> +	uint64_t id_aa64dfr0;
> +
> +	get_reg(vm, VCPU_ID, ARM64_SYS_REG(ID_AA64DFR0_EL1), &id_aa64dfr0);
> +	return id_aa64dfr0 & 0xf;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	int stage;
> +	int ret;
> +
> +	vm = vm_create_default(VCPU_ID, 0, guest_code);
> +	ucall_init(vm, NULL);
> +
> +	vm_init_descriptor_tables(vm);
> +	vcpu_init_descriptor_tables(vm, VCPU_ID);
> +
> +	if (debug_version(vm) < 6) {
> +		print_skip("Armv8 debug architecture not supported.");
> +		kvm_vm_free(vm);
> +		exit(KSFT_SKIP);
> +	}
> +
> +	vm_handle_exception(vm, VECTOR_SYNC_EL1,
> +			ESR_EC_BRK_INS, guest_sw_bp_handler);
> +	vm_handle_exception(vm, VECTOR_SYNC_EL1,
> +			ESR_EC_HW_BP_EL1, guest_hw_bp_handler);
> +	vm_handle_exception(vm, VECTOR_SYNC_EL1,
> +			ESR_EC_WP_EL1, guest_wp_handler);
> +	vm_handle_exception(vm, VECTOR_SYNC_EL1,
> +			ESR_EC_SSTEP_EL1, guest_ss_handler);
> +	vm_handle_exception(vm, VECTOR_SYNC_EL1,
> +			ESR_EC_SVC64, guest_svc_handler);
> +
> +	for (stage = 0; stage < 7; stage++) {
> +		ret = _vcpu_run(vm, VCPU_ID);
> +
> +		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);

Instead of using the _ variant of vcpu_run and this assert on the ret==0,
you can just use the non _ variant (vcpu_run), which does the same thing.


> +		switch (get_ucall(vm, VCPU_ID, &uc)) {
> +		case UCALL_SYNC:
> +			TEST_ASSERT(uc.args[1] == stage,
> +				"Stage %d: Unexpected sync ucall, got %lx",
> +				stage, (ulong)uc.args[1]);
> +

Unnecessary blank line

> +			break;
> +		case UCALL_ABORT:
> +			TEST_FAIL("%s at %s:%ld\n\tvalues: %#lx, %#lx",
> +				(const char *)uc.args[0],
> +				__FILE__, uc.args[1], uc.args[2], uc.args[3]);
> +			break;
> +		case UCALL_DONE:
> +			goto done;
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +		}
> +	}
> +
> +done:
> +	kvm_vm_free(vm);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index 5c902ad95c35..eee69b92e01e 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -21,6 +21,8 @@
>  #define SCTLR_EL1	3, 0,  1, 0, 0
>  #define VBAR_EL1	3, 0, 12, 0, 0
>  
> +#define ID_AA64DFR0_EL1	3, 0,  0, 5, 0

It'd be nice to add a couple more tabs to the register defines above to
get them aligned with this new one.

> +
>  /*
>   * Default MAIR
>   *                  index   attribute
> @@ -125,4 +127,19 @@ void vm_handle_exception(struct kvm_vm *vm, int vector, int ec,
>  	val;								  \
>  })
>  
> +#define MDSCR_KDE	(1 << 13)
> +#define MDSCR_MDE	(1 << 15)
> +#define MDSCR_SS	(1 << 0)
> +
> +#define DBGBCR_LEN8	(0xff << 5)
> +#define DBGBCR_EXEC	(0x0 << 3)
> +#define DBGBCR_EL1	(0x1 << 1)
> +#define DBGBCR_E	(0x1 << 0)
> +
> +#define DBGWCR_LEN8	(0xff << 5)
> +#define DBGWCR_RD	(0x1 << 3)
> +#define DBGWCR_WR	(0x2 << 3)
> +#define DBGWCR_EL1	(0x1 << 1)
> +#define DBGWCR_E	(0x1 << 0)

I think these debug specific defines should be put directly in the debug
test.

> +
>  #endif /* SELFTEST_KVM_PROCESSOR_H */
> -- 
> 2.31.1.498.g6c1eba8ee3d-goog
>

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
