Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BE41C4B97E4
	for <lists+kvmarm@lfdr.de>; Thu, 17 Feb 2022 05:52:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EDBDC49E35;
	Wed, 16 Feb 2022 23:52:21 -0500 (EST)
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
	with ESMTP id DkAHrDoJHoCX; Wed, 16 Feb 2022 23:52:21 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E527348F9C;
	Wed, 16 Feb 2022 23:52:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A9E1940C02
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Feb 2022 23:52:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCkaGClJtTuA for <kvmarm@lists.cs.columbia.edu>;
 Wed, 16 Feb 2022 23:52:16 -0500 (EST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
 [209.85.166.44])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9467B40BF0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Feb 2022 23:52:16 -0500 (EST)
Received: by mail-io1-f44.google.com with SMTP id y20so2348027iod.1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 16 Feb 2022 20:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Jqpk58vCE1vg5i1PhZMdqeXeRsNfHtYpoRn+ZLB5DT0=;
 b=ojXo2n7ihHazexzt4cd/gi8JBaPIiIaoateEFVzo2mXM4eOHIpPEi1NSRcdMs4Udrj
 P5QTwYqqS3tN++Jwp5MWiEUCYhDMxvfD95k3d7aksdp9R/MC+Yggvs6LhENNwtnLvPTw
 d/cWOLBv91karYADvgdgToz2M5IqgA1oVHcY/ZFcSNaL6zTkp4s79IO3DNTACgpLBp8v
 Zq/Qx6uL4oYw6czc/s4c3JfGznVEHHlFrlL9J0EsX9cBI19N/I2NLKjslSbLW4q295dr
 EogpOGYp8K2ezLyy/M1RlVldrAphL7lS3JPWMmmF3eKz9cEKg0V1TqmKdpbTgRkhpAwV
 cCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Jqpk58vCE1vg5i1PhZMdqeXeRsNfHtYpoRn+ZLB5DT0=;
 b=Dtdi/a3KblymRPbM6OHDzXpKp2pSUkc46C3NhomP8vMncoI/OUvTvw950dbK7hxltD
 s0n2BFKnW5MoUJgMFRG81/Fs4mGRFYwbk5TyJIkeh3yyBWtS4j6ql0NUMMhkhzzR9UJA
 7XSJvdP05/xdFCiqqe3QF7NGWnz8d1LKXnc3eY0eJ1RxJXBHCJ2Ly3/0b2T2X3vgNq/L
 kTF6evutUIuUHXCaYKwtYy1uoLFuVN2/Eyl9VdJ1W6tWRrY909E+mD38poyTqoJTuUDX
 kKejnTF/O8vEF1s6nSJz1I4dCIVEFxO9p0kyCcrhoxS4mBO847CfqiOe9crcSopifomn
 0urA==
X-Gm-Message-State: AOAM533k+hmA84VInZc4GGSHByxq2rxfH+fN6JOHwY6TVFVb0pOEgOnm
 sdiJhnD04lA768FkJnk7GbbZ3w==
X-Google-Smtp-Source: ABdhPJxInVweiXkrXBkG0JyH7KuGpWXHDrujKdzKztcCu38EPftAEv4uxMZsk2v+8wKmYPGiuGhULw==
X-Received: by 2002:a02:c953:0:b0:314:3463:f725 with SMTP id
 u19-20020a02c953000000b003143463f725mr813104jao.275.1645073535477; 
 Wed, 16 Feb 2022 20:52:15 -0800 (PST)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194])
 by smtp.gmail.com with ESMTPSA id q18sm1132032ils.78.2022.02.16.20.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Feb 2022 20:52:14 -0800 (PST)
Date: Thu, 17 Feb 2022 04:52:10 +0000
From: Oliver Upton <oupton@google.com>
To: Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 2/2] KVM: arm64: selftests: Introduce get_set_regs_perf
 test
Message-ID: <Yg3Uer/K6n/h6oBz@google.com>
References: <20220217034947.180935-1-reijiw@google.com>
 <20220217034947.180935-2-reijiw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220217034947.180935-2-reijiw@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Will Deacon <will@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

First off, thanks for looking into this! Seems like a very useful thing
to test :-)

On Wed, Feb 16, 2022 at 07:49:47PM -0800, Reiji Watanabe wrote:
> Introduce a simple performance test of KVM_GET_ONE_REG/KVM_SET_ONE_REG
> for registers that are returned by KVM_GET_REG_LIST. This is a pseudo
> process of saving/restoring registers during live migration, and this
> test quantifies the performance of the process.
> 
> Signed-off-by: Reiji Watanabe <reijiw@google.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/aarch64/get_set_regs_perf.c | 456 ++++++++++++++++++

Without having looked at the diff yet, I wonder if this can be done for
multiple architectures, as the whole get/set reg UAPI is used by several
other architectures.

>  3 files changed, 458 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/get_set_regs_perf.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index dce7de7755e6..b6b18aaf9322 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -2,6 +2,7 @@
>  /aarch64/arch_timer
>  /aarch64/debug-exceptions
>  /aarch64/get-reg-list
> +/aarch64/get_set_regs_perf
>  /aarch64/psci_cpu_on_test
>  /aarch64/vgic_init
>  /aarch64/vgic_irq
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 0e4926bc9a58..46a28ce89002 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -103,6 +103,7 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
>  TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
> +TEST_GEN_PROGS_aarch64 += aarch64/get_set_regs_perf
>  TEST_GEN_PROGS_aarch64 += aarch64/psci_cpu_on_test
>  TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
>  TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
> diff --git a/tools/testing/selftests/kvm/aarch64/get_set_regs_perf.c b/tools/testing/selftests/kvm/aarch64/get_set_regs_perf.c
> new file mode 100644
> index 000000000000..27944ccce4a1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/get_set_regs_perf.c
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * get_set_regs_perf - KVM_GET_ONE_REG/KVM_SET_ONE_REG performance test
> + *
> + * The test runs performance test of saving registers that are returned
> + * by KVM_GET_REG_LIST for vCPUs in a VM and restoring them for vCPUs
> + * in another VM (a part of behavior during blackout on live migration).
> + *
> + * Copyright (c) 2022, Google LLC.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <time.h>
> +#include <pthread.h>
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +#define	N2USEC(nsec)	((nsec)/1000)

How about defining:

  #define	NSEC_PER_USEC	1000L

and explicitly doing division inline? This is consistent with the kernel
as well.

> +#define	REG_STR_LEN	64
> +
> +struct reg_val {
> +	 /* Big enough buffer even for the longest vector register */
> +	uint64_t	val[32];
> +};
> +
> +struct thread_data {
> +	uint32_t	vcpuid;
> +	bool		is_set_reg;
> +	volatile bool	*start;
> +	struct kvm_vm	*vm;
> +	struct timespec	time;
> +	struct kvm_reg_list	*reg_list;
> +
> +	/*
> +	 * Pointer to an array of reg_val, which will hold a value of each
> +	 * register. The number of elements in it is indicated in reg_list.n.
> +	 */
> +	struct reg_val	*reg_vals;
> +
> +	/*
> +	 * Pointer to an array of timespec, which will hold per register
> +	 * latency of KVM_GET_ONE_REG or KVM_SET_ONE_REG. The number of
> +	 * elements in it is indicated in reg_list.n.
> +	 */
> +	struct timespec	*reg_time;
> +};
> +
> +pthread_t threads[KVM_MAX_VCPUS];
> +struct thread_data thread_args[KVM_MAX_VCPUS];
> +
> +struct sys_reg_params {
> +	u8	Op0;
> +	u8	Op1;
> +	u8	CRn;
> +	u8	CRm;
> +	u8	Op2;
> +};
> +
> +static int regid_to_params(u64 id, struct sys_reg_params *params)
> +{
> +	switch (id & KVM_REG_SIZE_MASK) {
> +	case KVM_REG_SIZE_U64:
> +		/* Any unused index bits means it's not valid. */
> +		if (id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK
> +			      | KVM_REG_ARM_COPROC_MASK
> +			      | KVM_REG_ARM64_SYSREG_OP0_MASK
> +			      | KVM_REG_ARM64_SYSREG_OP1_MASK
> +			      | KVM_REG_ARM64_SYSREG_CRN_MASK
> +			      | KVM_REG_ARM64_SYSREG_CRM_MASK
> +			      | KVM_REG_ARM64_SYSREG_OP2_MASK))
> +			return -1;
> +		params->Op0 = ((id & KVM_REG_ARM64_SYSREG_OP0_MASK)
> +			       >> KVM_REG_ARM64_SYSREG_OP0_SHIFT);
> +		params->Op1 = ((id & KVM_REG_ARM64_SYSREG_OP1_MASK)
> +			       >> KVM_REG_ARM64_SYSREG_OP1_SHIFT);
> +		params->CRn = ((id & KVM_REG_ARM64_SYSREG_CRN_MASK)
> +			       >> KVM_REG_ARM64_SYSREG_CRN_SHIFT);
> +		params->CRm = ((id & KVM_REG_ARM64_SYSREG_CRM_MASK)
> +			       >> KVM_REG_ARM64_SYSREG_CRM_SHIFT);
> +		params->Op2 = ((id & KVM_REG_ARM64_SYSREG_OP2_MASK)
> +			       >> KVM_REG_ARM64_SYSREG_OP2_SHIFT);
> +		return 0;
> +	default:
> +		return -1;
> +	}
> +}
> +
> +static void reg_id_to_str(uint64_t id, char *str, int len)
> +{
> +	struct sys_reg_params p;
> +
> +	TEST_ASSERT((id & KVM_REG_ARCH_MASK) == KVM_REG_ARM64,
> +		    "Not KVM_REG_ARM64 register (0x%lx)", id);
> +
> +	switch (id & KVM_REG_ARM_COPROC_MASK) {
> +	case KVM_REG_ARM_CORE:
> +		snprintf(str, len, "CORE(id:0x%lx)", id);
> +		break;
> +	case KVM_REG_ARM64_SVE:
> +		snprintf(str, len, "SVE(id:0x%lx)", id);
> +		break;
> +	case KVM_REG_ARM_DEMUX:
> +		snprintf(str, len, "DEMUX(id:0x%lx)", id);
> +		break;
> +	case KVM_REG_ARM_FW:
> +		snprintf(str, len, "FW_REG_%ld", id & 0xffff);
> +		break;
> +	case KVM_REG_ARM64_SYSREG:
> +		if (regid_to_params(id, &p) == 0)
> +			snprintf(str, len, "SYSREG(%d,%d,%d,%d,%d)",
> +				 p.Op0, p.Op1, p.CRn, p.CRm, p.Op2);
> +		else
> +			snprintf(str, len, "SYSREG(id:0x%lx)", id);
> +		break;
> +	default:
> +		snprintf(str, len, "KVM_REG_ARM64(id:0x%lx)", id);
> +	}
> +}

I see that print_reg() in aarch64/get-reg-list.c implements most of
this. Would it be possible to hoist that into a shared helper function?

> +/*
> + * Save or restore registers that were saved by get_regs_vcpu_thread with
> + * KVM_GET_ONE_REG or KVM_SET_ONE_REG. Measure time taken by this process.
> + */
> +static void *vcpu_thread(void *data)
> +{
> +	int i, ret;
> +	struct thread_data *arg = data;
> +	struct kvm_reg_list *reg_list = arg->reg_list;
> +	bool is_set_reg = arg->is_set_reg;
> +	unsigned int cmd = is_set_reg ? KVM_SET_ONE_REG : KVM_GET_ONE_REG;
> +	char *cmd_str = is_set_reg ? "SET_ONE_REG" : "GET_ONE_REG";

Why not use vcpu_{get,set}_reg() instead? They already have informative
assertions that print the name of the ioctl and the name of the errno.

> +	struct timespec ts_reg_diff, ts_reg_start;
> +	struct kvm_one_reg reg;
> +
> +	memset(&arg->time, 0, sizeof(arg->time));
> +
> +	/* Wait until start is set */
> +	while (!(*arg->start))
> +		;

Have you considered using a pthread_barrier for this?

> +	/* Warm up the cache. */
> +	reg.id = reg_list->reg[0];
> +	reg.addr = (uint64_t)&arg->reg_vals[0];
> +	ret = _vcpu_ioctl(arg->vm, arg->vcpuid, cmd, &reg);
> +	TEST_ASSERT(!ret, "%s(id:0x%llx) failed\n", cmd_str, reg.id);

I wouldn't expect VMMs to do this before starting migration. Do you
think it would be better to replicate the behavior of typical userspace?

> +	pr_debug("%s[%d] start\n", __func__, arg->vcpuid);
> +
> +	/* Run KVM_SET_ONE_REG or KVM_GET_ONE_REG for registers in reg_list */
> +	for (i = 0; i < reg_list->n; i++) {
> +		clock_gettime(CLOCK_MONOTONIC, &ts_reg_start);
> +
> +		reg.id = reg_list->reg[i];
> +		reg.addr = (uint64_t)&arg->reg_vals[i];
> +		ret = _vcpu_ioctl(arg->vm, arg->vcpuid, cmd, &reg);
> +
> +		ts_reg_diff = timespec_elapsed(ts_reg_start);
> +		arg->time = timespec_add(arg->time, ts_reg_diff);
> +		if (arg->reg_time)
> +			/* Need per register latency separately */
> +			arg->reg_time[i] = ts_reg_diff;
> +
> +		TEST_ASSERT(!ret, "%s(id:0x%llx) failed\n", cmd_str, reg.id);
> +		pr_debug("%s: id:0x%lx, val:0x%lx\n", cmd_str, (uint64_t)reg.id,
> +			 arg->reg_vals[i].val[0]);
> +	}
> +
> +	return NULL;
> +}
> +
> +void aggregate_time(uint64_t cnt, struct timespec *total, struct timespec *data)
> +{
> +	uint64_t i;
> +
> +	for (i = 0; i < cnt; i++)
> +		total[i] = timespec_add(total[i], data[i]);
> +}
> +
> +struct result_timespec {
> +	struct timespec src;
> +	struct timespec dst;
> +	struct timespec *src_per_reg;
> +	struct timespec *dst_per_reg;
> +};
> +
> +/*
> + * Run KVM_GET_ONE_REG/KVM_SET_ONE_REG performance test.
> + * Create a VM with the given number of vCPUs, create a thread for each
> + * vCPU in the VM, and wait until all the threads complete KVM_GET_ONE_REG
> + * for all the registers KVM_GET_REG_LIST returns. Then repeat the same thing
> + * with KVM_SET_ONE_REG. Aggregate the time spent by each thread on
> + * KVM_GET_ONE_REG and KVM_SET_ONE_REG, and return the vCPU average value to
> + * the caller via @res.
> + */
> +void run_test_one(int nvcpus, struct kvm_reg_list *reg_list,
> +		  struct result_timespec *res)
> +{
> +	bool per_reg_data = res->src_per_reg ? true : false;
> +	uint64_t nregs = reg_list->n;
> +	volatile bool start = false;
> +	int i, ret;
> +	struct kvm_vm *src_vm, *dst_vm;
> +	struct thread_data *targ;
> +	struct timespec src_sum = (struct timespec){0};
> +	struct timespec dst_sum = (struct timespec){0};

Is the cast required?

> +	if (per_reg_data) {
> +		/* Reset the buffers to save the per register result */
> +		memset(res->src_per_reg, 0, nregs * sizeof(struct timespec));
> +		memset(res->dst_per_reg, 0, nregs * sizeof(struct timespec));
> +	}
> +
> +	/* Create VMs to save/restore registers */
> +	src_vm = vm_create_default_with_vcpus(nvcpus, 0, 0, NULL, NULL);
> +	dst_vm = vm_create_default_with_vcpus(nvcpus, 0, 0, NULL, NULL);
> +
> +	/* Start saving registers process for src_vm */
> +
> +	/* Create source VM's vCPU threads */
> +	for (i = 0; i < nvcpus; i++) {
> +		targ = &thread_args[i];
> +		targ->vm = src_vm;
> +		targ->vcpuid = i;
> +		targ->is_set_reg = false;
> +		targ->start = &start;
> +		targ->reg_list = reg_list;
> +		targ->reg_vals = calloc(nregs, sizeof(struct reg_val));
> +		TEST_ASSERT(targ->reg_vals, "Failed to allocate reg_vals");
> +		if (per_reg_data) {
> +			/* Per register result buffer for the vCPU */
> +			targ->reg_time = calloc(nregs, sizeof(struct timespec));
> +			TEST_ASSERT(targ->reg_time, "Failed to allocate reg_time");
> +		}
> +		ret = pthread_create(&threads[i], NULL, vcpu_thread, targ);
> +		TEST_ASSERT(!ret, "pthread_create failed: %d\n", ret);
> +	}
> +
> +	/*
> +	 * Let threads start saving registers for vCPUs, and wait for all
> +	 * threads to complete restoring registers.
> +	 */
> +	start = true;
> +	for (i = 0; i < nvcpus; i++) {
> +		targ = &thread_args[i];
> +		ret = pthread_join(threads[i], NULL);
> +		TEST_ASSERT(!ret, "pthread_join failed: %d\n", ret);
> +		src_sum = timespec_add(src_sum, targ->time);

I think it would make more sense to measure wall time instead of CPU
time here. It may not be immediately obvious when running this test why
the reported time scales as the number of vCPUs increases.

> +		if (per_reg_data)
> +			aggregate_time(nregs, res->src_per_reg, targ->reg_time);
> +	}
> +
> +	start = false;
> +	pr_debug("%s Saving registers completed.\n", __func__);
> +
> +	/* Start restoring registers process for dst_vm */
> +
> +	/* Create destination VM's vCPU threads */
> +	for (i = 0; i < nvcpus; i++) {
> +		targ = &thread_args[i];
> +		/* Update fields that are different from the src case */
> +		targ->vm = dst_vm;
> +		targ->is_set_reg = true;
> +		ret = pthread_create(&threads[i], NULL, vcpu_thread, targ);
> +		TEST_ASSERT(!ret, "pthread_create failed: %d\n", ret);
> +	}
> +
> +	/*
> +	 * Let threads start saving registers for vCPUs, and wait for all
> +	 * threads to complete restoring registers.
> +	 */
> +	start = true;
> +	for (i = 0; i < nvcpus; i++) {
> +		targ = &thread_args[i];
> +		ret = pthread_join(threads[i], NULL);
> +		TEST_ASSERT(!ret, "pthread_join failed: %d\n", ret);
> +
> +		free(targ->reg_vals);
> +		dst_sum = timespec_add(dst_sum, targ->time);
> +		if (per_reg_data) {
> +			aggregate_time(nregs, res->dst_per_reg, targ->reg_time);
> +			free(targ->reg_time);
> +		}
> +	}
> +
> +	kvm_vm_free(src_vm);
> +	kvm_vm_free(dst_vm);
> +
> +	pr_debug("%s Restoring registers completed.\n", __func__);
> +
> +	/* Calculate the vCPU average */
> +	res->src = timespec_div(src_sum, nvcpus);
> +	res->dst = timespec_div(dst_sum, nvcpus);
> +	if (!per_reg_data)
> +		return;
> +
> +	/* Calculate the vCPU average for each register */
> +	for (i = 0; i < nregs; i++) {
> +		res->src_per_reg[i] = timespec_div(res->src_per_reg[i], nvcpus);
> +		res->dst_per_reg[i] = timespec_div(res->dst_per_reg[i], nvcpus);
> +	}
> +}
> +
> +/*
> + * Run saving/restoring vCPU registers (KVM_GET_ONE_REG/KVM_SET_ONE_REG)
> + * performance test with the given number of vCPUs (@nvcpus) for the given
> + * number (@iterations) of times.
> + * Each iteration of the test returns the latency of saving/restoring all
> + * the registers that KVM_GET_REG_LIST returns (See comments for
> + * run_test_one() for more details of each iteration of the test).
> + * Print the average latency of each iteration, and if @per_reg_result is set,
> + * print the average latency for each register as well.
> + */
> +void run_test(int nvcpus, int iterations, bool per_reg_result)
> +{
> +	int i, j;
> +	uint64_t nregs;
> +	struct result_timespec res = {0};
> +	struct timespec src_sum = {0};
> +	struct timespec dst_sum = {0};
> +	struct timespec avg, src_avg, dst_avg;
> +	struct timespec *src_per_reg_sum, *dst_per_reg_sum;
> +	struct kvm_vm *vm;
> +	struct kvm_reg_list *reg_list;
> +	char reg_str[REG_STR_LEN];
> +
> +	/* Get kvm_reg_list */
> +	vm = vm_create_default(0, 0, NULL);
> +	reg_list = vcpu_get_reg_list(vm, 0);

Would it make sense to test some opt-in capabilities that expose
additional registers (PMU, SVE, etc.)?

> +	kvm_vm_free(vm);
> +	nregs = reg_list->n;
> +
> +	if (per_reg_result) {
> +		/*
> +		 * Allocate buffers to save latency of KVM_GET_ONE_REG
> +		 * and KVM_SET_ONE_REG respectively.
> +		 */
> +
> +		/* Buffers for each iteration */
> +		res.src_per_reg = calloc(nregs, sizeof(struct timespec));
> +		res.dst_per_reg = calloc(nregs, sizeof(struct timespec));
> +
> +		/* Buffers for the sum */
> +		src_per_reg_sum = calloc(nregs, sizeof(struct timespec));
> +		dst_per_reg_sum = calloc(nregs, sizeof(struct timespec));
> +
> +		TEST_ASSERT(res.src_per_reg && res.dst_per_reg &&
> +			    src_per_reg_sum && dst_per_reg_sum,
> +			    "Failed to allocate per register time buffer");
> +	}
> +
> +	pr_info("Iterations %d (vCPUs %d, regs %lld): ",
> +		iterations, nvcpus, reg_list->n);
> +
> +	for (i = 0; i < iterations; i++) {
> +		/* Run the test */
> +		run_test_one(nvcpus, reg_list, &res);
> +
> +		src_sum = timespec_add(src_sum, res.src);
> +		dst_sum = timespec_add(dst_sum, res.dst);
> +
> +		if (!per_reg_result)
> +			continue;
> +
> +		/* Aggregate per register result */
> +		for (j = 0; j < nregs; j++) {
> +			src_per_reg_sum[j] = timespec_add(src_per_reg_sum[j],
> +							  res.src_per_reg[j]);
> +			dst_per_reg_sum[j] = timespec_add(dst_per_reg_sum[j],
> +							  res.dst_per_reg[j]);
> +		}
> +	}
> +
> +	/* Calculate the iteration average */
> +	src_avg = timespec_div(src_sum, iterations);
> +	dst_avg = timespec_div(dst_sum, iterations);
> +	avg = timespec_add(src_avg, dst_avg);
> +
> +	/* Print the average */
> +	if (avg.tv_sec > 0) {
> +		pr_info("get+set %ld.%.9lds (get %ld.%.9lds, set %ld.%.9lds)\n",
> +			avg.tv_sec, avg.tv_nsec,
> +			src_avg.tv_sec, src_avg.tv_nsec,
> +			dst_avg.tv_sec, dst_avg.tv_nsec);
> +	} else {
> +		pr_info("get+set %ldus (get %ldus, set %ldus)\n",
> +			N2USEC(avg.tv_nsec), N2USEC(src_avg.tv_nsec),
> +			N2USEC(dst_avg.tv_nsec));
> +	}
> +
> +	/* Print per register result when requested */
> +	if (per_reg_result) {
> +		pr_info("Per Register Result:\n");
> +		pr_info(" %-32s %13s  %9s  %9s\n", "Register", "get+set(ns)", "get(ns)", "set(ns)");
> +		for (i = 0; i < nregs; i++) {
> +			/* Calculate the average for the register */
> +			src_avg = timespec_div(src_per_reg_sum[i], iterations);
> +			dst_avg = timespec_div(dst_per_reg_sum[i], iterations);
> +			avg = timespec_add(src_avg, dst_avg);
> +
> +			assert(avg.tv_sec == 0);
> +			reg_id_to_str(reg_list->reg[i], reg_str, REG_STR_LEN);
> +			pr_info(" %-32s %13ld  %9ld  %9ld\n", reg_str,
> +				avg.tv_nsec, src_avg.tv_nsec, dst_avg.tv_nsec);
> +		}

Do you think it would be useful to optionally dump this granular data
into a machine-parseable format (like CSV)? It could be helpful for
analysis. We have several hundred exposed registers (and always
growing!) and grokking stdout might be a bit difficult.

> +		free(res.src_per_reg);
> +		free(res.dst_per_reg);
> +		free(src_per_reg_sum);
> +		free(dst_per_reg_sum);
> +	}
> +
> +	free(reg_list);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int opt;
> +	int nvcpus = 1;
> +	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
> +	int iterations = 1000;
> +	bool per_reg_result = false;
> +
> +	while ((opt = getopt(argc, argv, "hri:v:")) != -1) {
> +		switch (opt) {
> +		case 'i':
> +			iterations = atoi(optarg);
> +			break;
> +		case 'v':
> +			nvcpus = atoi(optarg);
> +			TEST_ASSERT(nvcpus > 0 && nvcpus <= max_vcpus,
> +				    "Number of vcpus, must be between 1 and %d",
> +				    max_vcpus);
> +			break;
> +		case 'r':
> +			per_reg_result = true;
> +			break;
> +		case 'h':
> +		default:
> +			printf("usage: %s [-h] [-v vcpus] [-i iterations]\n",
> +			       argv[0]);
> +			exit(0);
> +		}
> +	}
> +
> +	setbuf(stdout, NULL);
> +
> +	run_test(nvcpus, iterations, per_reg_result);
> +
> +	return 0;
> +}
> -- 
> 2.35.1.473.g83b2b277ed-goog
> 

--
Best,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
