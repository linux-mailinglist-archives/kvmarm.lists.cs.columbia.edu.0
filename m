Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5E5F5DD3
	for <lists+kvmarm@lfdr.de>; Thu,  6 Oct 2022 02:34:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3533E49F55;
	Wed,  5 Oct 2022 20:34:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7wq2-mVmzP3; Wed,  5 Oct 2022 20:34:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C65D841174;
	Wed,  5 Oct 2022 20:34:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 70C6E40B78
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Oct 2022 20:34:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uHmnAcP7fJqO for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Oct 2022 20:34:26 -0400 (EDT)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EE14A49F01
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Oct 2022 20:34:25 -0400 (EDT)
Received: by mail-pf1-f202.google.com with SMTP id
 24-20020aa79118000000b00561ed88c3b9so239861pfh.7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 05 Oct 2022 17:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=xX8uG7SUYg5pdixpO8XUZnQg2hng+veRMQibKkyiaZI=;
 b=fP1ryi98o179n93GMiv0EoLb1mN2viyG2IzwW68Vr4eTwDeUdsGpCVIrlW4utQC1Ma
 2Oxih7QtSnTZT3TnBg8Jn4eqsvEUGd2nK1QPoxmiY60Qgm6BymroY8s0ccb/BhdLMPk9
 IEPhooFAkorod/TItmjH6ZduDkCBN5e5du7Sy8ayuogr0XB9sDHN4GXG1j28pOZFreHM
 bdGsCH7pJIId62KmvtM7UVZzBXE4dWBYHS/a0ehBTCja1PVtEbubd/iLVhlzWxkdnAiW
 IFt+IFSn528cs56k2NBC62wakCtUI6OvIhw7gkQSuumjxqTxoe7cyUDZfINXLJt81gVm
 R/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xX8uG7SUYg5pdixpO8XUZnQg2hng+veRMQibKkyiaZI=;
 b=NqZCVygvvxU1wUL56LHTUh4tH0PJzm/bAhsJtqyfKX/IE1t8oVqs95cXy54UivSFZB
 DvZ5aKS6GVNN/j16aKLFGTfcfvJFuGcIKemgvanSW0Gnl218n0dp+XfekxNb/yx28ISe
 +aJ/FswrrgDJla3JojI9yO1THhBaY5IBR2wUdp4+7qfpxTk1f1AwJvzJVeUUN0xIO/kl
 avMWHUKjBl+hOwzNpYL8/f5KZKFCmpz1PTvLbsccW4c9ImCZHItCGOwABXVgl3xY+RPB
 2qkt7cga5erzV8mbK6GtPpqpDeC84/pnGYuzVDcBV2j4jgKAX4juKxjdxdO5VpWDXhGX
 LwAw==
X-Gm-Message-State: ACrzQf2jdY4F26mG8/xOCIORas9kGfUb4QRaOWcOFFdP10FbNWEwnVgG
 OpOc0Blm3rwmz6ZHL0yp2EbR59Kazoo=
X-Google-Smtp-Source: AMsMyM61Rswnni6B0rnAAeLaPaUNYNDgjRmTAANkWM3BTrYnMkG4glUe+fu2YvtLP2GsuvLSnHd5dlMUWuE=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2918:b0:535:ea9:791a with SMTP id
 cg24-20020a056a00291800b005350ea9791amr2061782pfb.54.1665016465171; Wed, 05
 Oct 2022 17:34:25 -0700 (PDT)
Date: Thu,  6 Oct 2022 00:34:09 +0000
In-Reply-To: <20221006003409.649993-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006003409.649993-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006003409.649993-8-seanjc@google.com>
Subject: [PATCH v6 7/7] KVM: selftests: Add ucall pool based implementation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Marc Zyngier <maz@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: llvm@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>,
 Peter Gonda <pgonda@google.com>, linux-kselftest@vger.kernel.org,
 Atish Patra <atishp@atishpatra.org>, kvmarm@lists.linux.dev,
 linux-riscv@lists.infradead.org, Andrew Jones <andrew.jones@linux.dev>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
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

From: Peter Gonda <pgonda@google.com>

To play nice with guests whose stack memory is encrypted, e.g. AMD SEV,
introduce a new "ucall pool" implementation that passes the ucall struct
via dedicated memory (which can be mapped shared, a.k.a. as plain text).

Because not all architectures have access to the vCPU index in the guest,
use a bitmap with atomic accesses to track which entries in the pool are
free/used.  A list+lock could also work in theory, but synchronizing the
individual pointers to the guest would be a mess.

Note, there's no need to rewalk the bitmap to ensure success.  If all
vCPUs are simply allocating, success is guaranteed because there are
enough entries for all vCPUs.  If one or more vCPUs are freeing and then
reallocating, success is guaranteed because vCPUs _always_ walk the
bitmap from 0=>N; if vCPU frees an entry and then wins a race to
re-allocate, then either it will consume the entry it just freed (bit is
the first free bit), or the losing vCPU is guaranteed to see the freed
bit (winner consumes an earlier bit, which the loser hasn't yet visited).

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Peter Gonda <pgonda@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/ucall_common.h      |  9 ++-
 .../testing/selftests/kvm/lib/aarch64/ucall.c |  7 +-
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  2 +-
 tools/testing/selftests/kvm/lib/s390x/ucall.c |  2 +-
 .../testing/selftests/kvm/lib/ucall_common.c  | 72 +++++++++++++++++--
 .../testing/selftests/kvm/lib/x86_64/ucall.c  |  2 +-
 6 files changed, 77 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 2662a4352a8c..bdd373189a77 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -22,6 +22,9 @@ enum {
 struct ucall {
 	uint64_t cmd;
 	uint64_t args[UCALL_MAX_ARGS];
+
+	/* Host virtual address of this struct. */
+	struct ucall *hva;
 };
 
 void ucall_arch_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
@@ -30,11 +33,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
 
 void ucall(uint64_t cmd, int nargs, ...);
 uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
-
-static inline void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
-{
-	ucall_arch_init(vm, mmio_gpa);
-}
+void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
 
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index 21d73afcb14f..562c16dfbb00 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -32,12 +32,9 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 
 	if (run->exit_reason == KVM_EXIT_MMIO &&
 	    run->mmio.phys_addr == vcpu->vm->ucall_mmio_addr) {
-		vm_vaddr_t gva;
-
-		TEST_ASSERT(run->mmio.is_write && run->mmio.len == 8,
+		TEST_ASSERT(run->mmio.is_write && run->mmio.len == sizeof(uint64_t),
 			    "Unexpected ucall exit mmio address access");
-		memcpy(&gva, run->mmio.data, sizeof(gva));
-		return addr_gva2hva(vcpu->vm, gva);
+		return (void *)(*((uint64_t *)run->mmio.data));
 	}
 
 	return NULL;
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index 78acdb084ab0..9a3476a2dfca 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -55,7 +55,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 	    run->riscv_sbi.extension_id == KVM_RISCV_SELFTESTS_SBI_EXT) {
 		switch (run->riscv_sbi.function_id) {
 		case KVM_RISCV_SELFTESTS_SBI_UCALL:
-			return addr_gva2hva(vcpu->vm, run->riscv_sbi.args[0]);
+			return (void *)run->riscv_sbi.args[0];
 		case KVM_RISCV_SELFTESTS_SBI_UNEXP:
 			vcpu_dump(stderr, vcpu, 2);
 			TEST_ASSERT(0, "Unexpected trap taken by guest");
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
index cbee520a26f2..a7f02dc372cf 100644
--- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -26,7 +26,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 	    (run->s390_sieic.ipb >> 16) == 0x501) {
 		int reg = run->s390_sieic.ipa & 0xf;
 
-		return addr_gva2hva(vcpu->vm, run->s.regs.gprs[reg]);
+		return (void *)run->s.regs.gprs[reg];
 	}
 	return NULL;
 }
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index ced480860746..fcae96461e46 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -1,22 +1,86 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "kvm_util.h"
+#include "linux/types.h"
+#include "linux/bitmap.h"
+#include "linux/atomic.h"
+
+struct ucall_header {
+	DECLARE_BITMAP(in_use, KVM_MAX_VCPUS);
+	struct ucall ucalls[KVM_MAX_VCPUS];
+};
+
+/*
+ * ucall_pool holds per-VM values (global data is duplicated by each VM), it
+ * must not be accessed from host code.
+ */
+static struct ucall_header *ucall_pool;
+
+void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
+{
+	struct ucall_header *hdr;
+	struct ucall *uc;
+	vm_vaddr_t vaddr;
+	int i;
+
+	vaddr = vm_vaddr_alloc(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR);
+	hdr = (struct ucall_header *)addr_gva2hva(vm, vaddr);
+	memset(hdr, 0, sizeof(*hdr));
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		uc = &hdr->ucalls[i];
+		uc->hva = uc;
+	}
+
+	write_guest_global(vm, ucall_pool, (struct ucall_header *)vaddr);
+
+	ucall_arch_init(vm, mmio_gpa);
+}
+
+static struct ucall *ucall_alloc(void)
+{
+	struct ucall *uc;
+	int i;
+
+	GUEST_ASSERT(ucall_pool);
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		if (!atomic_test_and_set_bit(i, ucall_pool->in_use)) {
+			uc = &ucall_pool->ucalls[i];
+			memset(uc->args, 0, sizeof(uc->args));
+			return uc;
+		}
+	}
+
+	GUEST_ASSERT(0);
+	return NULL;
+}
+
+static void ucall_free(struct ucall *uc)
+{
+	/* Beware, here be pointer arithmetic.  */
+	clear_bit(uc - ucall_pool->ucalls, ucall_pool->in_use);
+}
 
 void ucall(uint64_t cmd, int nargs, ...)
 {
-	struct ucall uc = {};
+	struct ucall *uc;
 	va_list va;
 	int i;
 
-	WRITE_ONCE(uc.cmd, cmd);
+	uc = ucall_alloc();
+
+	WRITE_ONCE(uc->cmd, cmd);
 
 	nargs = min(nargs, UCALL_MAX_ARGS);
 
 	va_start(va, nargs);
 	for (i = 0; i < nargs; ++i)
-		WRITE_ONCE(uc.args[i], va_arg(va, uint64_t));
+		WRITE_ONCE(uc->args[i], va_arg(va, uint64_t));
 	va_end(va);
 
-	ucall_arch_do_ucall((vm_vaddr_t)&uc);
+	ucall_arch_do_ucall((vm_vaddr_t)uc->hva);
+
+	ucall_free(uc);
 }
 
 uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index eb8bf55b359a..4d41dc63cc9e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -26,7 +26,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 		struct kvm_regs regs;
 
 		vcpu_regs_get(vcpu, &regs);
-		return addr_gva2hva(vcpu->vm, regs.rdi);
+		return (void *)regs.rdi;
 	}
 	return NULL;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
