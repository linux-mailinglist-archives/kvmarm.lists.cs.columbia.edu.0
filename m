Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC395A51ED
	for <lists+kvmarm@lfdr.de>; Mon, 29 Aug 2022 18:36:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 39A5E4B880;
	Mon, 29 Aug 2022 12:36:38 -0400 (EDT)
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
	with ESMTP id ONTft0q0p45R; Mon, 29 Aug 2022 12:36:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D84F4B884;
	Mon, 29 Aug 2022 12:36:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BF6234B874
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Aug 2022 12:36:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rosh1qvxSJaw for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Aug 2022 12:36:33 -0400 (EDT)
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 15CFF4B86D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Aug 2022 12:36:33 -0400 (EDT)
Date: Mon, 29 Aug 2022 18:36:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1661790992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jeqfda5hacfguvxdxE/9MUFoXxfI35ya4rVvOsObN+s=;
 b=a7yF5LJQxTxV6xD2oelvbldJ9iRYG7Y71UfZJyea19oubR2bw0hYhCuFl80rNrX8+4i/uE
 YugZvPHEnaBxwns8abNs2t53yD/rtCJIQO9jVOhUjFbY1EIyxEltK0rsau2midnNwGagoS
 fmA4gqivlrX2V5eoCWdwVXs3ZLs/XuA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v5 7/7] KVM: selftests: Add ucall pool based implementation
Message-ID: <20220829163627.qbafyl4qz5cxxue5@kamzik>
References: <20220825232522.3997340-1-seanjc@google.com>
 <20220825232522.3997340-8-seanjc@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220825232522.3997340-8-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Tom Rix <trix@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 llvm@lists.linux.dev, Colton Lewis <coltonlewis@google.com>,
 linux-riscv@lists.infradead.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 kvmarm@lists.cs.columbia.edu, Janosch Frank <frankja@linux.ibm.com>,
 Marc Zyngier <maz@kernel.org>, Peter Gonda <pgonda@google.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-arm-kernel@lists.infradead.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, kvm-riscv@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Thu, Aug 25, 2022 at 11:25:22PM +0000, Sean Christopherson wrote:
> From: Peter Gonda <pgonda@google.com>
> 
> To play nice with guests whose stack memory is encrypted, e.g. AMD SEV,
> introduce a new "ucall pool" implementation that passes the ucall struct
> via dedicated memory (which can be mapped shared, a.k.a. as plain text).
> 
> Because not all architectures have access to the vCPU index in the guest,
> use a bitmap with atomic accesses to track which entries in the pool are
> free/used.  A list+lock could also work in theory, but synchronizing the
> individual pointers to the guest would be a mess.
> 
> Note, there's no need to rewalk the bitmap to ensure success.  If all
> vCPUs are simply allocating, success is guaranteed because there are
> enough entries for all vCPUs.  If one or more vCPUs are freeing and then
> reallocating, success is guaranteed because vCPUs _always_ walk the
> bitmap from 0=>N; if vCPU frees an entry and then wins a race to
> re-allocate, then either it will consume the entry it just freed (bit is
> the first free bit), or the losing vCPU is guaranteed to see the freed
> bit (winner consumes an earlier bit, which the loser hasn't yet visited).
> 
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../selftests/kvm/include/ucall_common.h      |  9 ++-
>  .../testing/selftests/kvm/lib/aarch64/ucall.c |  7 +-
>  tools/testing/selftests/kvm/lib/riscv/ucall.c |  2 +-
>  tools/testing/selftests/kvm/lib/s390x/ucall.c |  2 +-
>  .../testing/selftests/kvm/lib/ucall_common.c  | 71 +++++++++++++++++--
>  .../testing/selftests/kvm/lib/x86_64/ucall.c  |  2 +-
>  6 files changed, 76 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
> index 2662a4352a8c..bdd373189a77 100644
> --- a/tools/testing/selftests/kvm/include/ucall_common.h
> +++ b/tools/testing/selftests/kvm/include/ucall_common.h
> @@ -22,6 +22,9 @@ enum {
>  struct ucall {
>  	uint64_t cmd;
>  	uint64_t args[UCALL_MAX_ARGS];
> +
> +	/* Host virtual address of this struct. */
> +	struct ucall *hva;
>  };
>  
>  void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
> @@ -30,11 +33,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
>  
>  void ucall(uint64_t cmd, int nargs, ...);
>  uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
> -
> -static inline void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
> -{
> -	ucall_arch_init(vm, mmio_gpa);
> -}
> +void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
>  
>  #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
>  				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> index 21d73afcb14f..562c16dfbb00 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> @@ -32,12 +32,9 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>  
>  	if (run->exit_reason == KVM_EXIT_MMIO &&
>  	    run->mmio.phys_addr == vcpu->vm->ucall_mmio_addr) {
> -		vm_vaddr_t gva;
> -
> -		TEST_ASSERT(run->mmio.is_write && run->mmio.len == 8,
> +		TEST_ASSERT(run->mmio.is_write && run->mmio.len == sizeof(uint64_t),
>  			    "Unexpected ucall exit mmio address access");
> -		memcpy(&gva, run->mmio.data, sizeof(gva));
> -		return addr_gva2hva(vcpu->vm, gva);
> +		return (void *)(*((uint64_t *)run->mmio.data));
>  	}
>  
>  	return NULL;
> diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> index 78acdb084ab0..9a3476a2dfca 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> @@ -55,7 +55,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>  	    run->riscv_sbi.extension_id == KVM_RISCV_SELFTESTS_SBI_EXT) {
>  		switch (run->riscv_sbi.function_id) {
>  		case KVM_RISCV_SELFTESTS_SBI_UCALL:
> -			return addr_gva2hva(vcpu->vm, run->riscv_sbi.args[0]);
> +			return (void *)run->riscv_sbi.args[0];
>  		case KVM_RISCV_SELFTESTS_SBI_UNEXP:
>  			vcpu_dump(stderr, vcpu, 2);
>  			TEST_ASSERT(0, "Unexpected trap taken by guest");
> diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
> index cbee520a26f2..a7f02dc372cf 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
> @@ -26,7 +26,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>  	    (run->s390_sieic.ipb >> 16) == 0x501) {
>  		int reg = run->s390_sieic.ipa & 0xf;
>  
> -		return addr_gva2hva(vcpu->vm, run->s.regs.gprs[reg]);
> +		return (void *)run->s.regs.gprs[reg];
>  	}
>  	return NULL;
>  }
> diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
> index ced480860746..cc79d497b6b4 100644
> --- a/tools/testing/selftests/kvm/lib/ucall_common.c
> +++ b/tools/testing/selftests/kvm/lib/ucall_common.c
> @@ -1,22 +1,85 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include "kvm_util.h"
> +#include "linux/types.h"
> +#include "linux/bitmap.h"
> +#include "linux/atomic.h"
> +
> +struct ucall_header {
> +	DECLARE_BITMAP(in_use, KVM_MAX_VCPUS);
> +	struct ucall ucalls[KVM_MAX_VCPUS];
> +};
> +
> +/*
> + * ucall_pool holds per-VM values (global data is duplicated by each VM), it
> + * must not be accessed from host code.
> + */
> +static struct ucall_header *ucall_pool;
> +
> +void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
> +{
> +	struct ucall_header *hdr;
> +	struct ucall *uc;
> +	vm_vaddr_t vaddr;
> +	int i;
> +
> +	vaddr = vm_vaddr_alloc(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR);
> +	hdr = (struct ucall_header *)addr_gva2hva(vm, vaddr);
> +	memset(hdr, 0, sizeof(*hdr));
> +
> +	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
> +		uc = &hdr->ucalls[i];
> +		uc->hva = uc;
> +	}
> +
> +	write_guest_global(vm, ucall_pool, (struct ucall_header *)vaddr);
> +
> +	ucall_arch_init(vm, mmio_gpa);
> +}
> +
> +static struct ucall *ucall_alloc(void)
> +{
> +	struct ucall *uc;
> +	int i;
> +
> +	GUEST_ASSERT(ucall_pool && ucall_pool->in_use);

ucall_pool->in_use will never be null.

> +
> +	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
> +		if (!atomic_test_and_set_bit(i, ucall_pool->in_use)) {
> +			uc = &ucall_pool->ucalls[i];
> +			memset(uc->args, 0, sizeof(uc->args));
> +			return uc;
> +		}
> +	}

nit: blank line

> +	GUEST_ASSERT(0);
> +	return NULL;
> +}
> +
> +static void ucall_free(struct ucall *uc)
> +{
> +	/* Beware, here be pointer arithmetic.  */
> +	clear_bit(uc - ucall_pool->ucalls, ucall_pool->in_use);
> +}
>  
>  void ucall(uint64_t cmd, int nargs, ...)
>  {
> -	struct ucall uc = {};
> +	struct ucall *uc;
>  	va_list va;
>  	int i;
>  
> -	WRITE_ONCE(uc.cmd, cmd);
> +	uc = ucall_alloc();
> +
> +	WRITE_ONCE(uc->cmd, cmd);
>  
>  	nargs = min(nargs, UCALL_MAX_ARGS);
>  
>  	va_start(va, nargs);
>  	for (i = 0; i < nargs; ++i)
> -		WRITE_ONCE(uc.args[i], va_arg(va, uint64_t));
> +		WRITE_ONCE(uc->args[i], va_arg(va, uint64_t));
>  	va_end(va);
>  
> -	ucall_arch_do_ucall((vm_vaddr_t)&uc);
> +	ucall_arch_do_ucall((vm_vaddr_t)uc->hva);
> +
> +	ucall_free(uc);
>  }
>  
>  uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> index eb8bf55b359a..4d41dc63cc9e 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> @@ -26,7 +26,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>  		struct kvm_regs regs;
>  
>  		vcpu_regs_get(vcpu, &regs);
> -		return addr_gva2hva(vcpu->vm, regs.rdi);
> +		return (void *)regs.rdi;
>  	}
>  	return NULL;
>  }
> -- 
> 2.37.2.672.g94769d06f0-goog

Otherwise,

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
