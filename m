Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF5360E8F
	for <lists+kvmarm@lfdr.de>; Thu, 15 Apr 2021 17:17:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 618304B719;
	Thu, 15 Apr 2021 11:17:52 -0400 (EDT)
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
	with ESMTP id 2o6wNRfz+aLA; Thu, 15 Apr 2021 11:17:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 10BFF4B715;
	Thu, 15 Apr 2021 11:17:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F1BE4B6EA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 11:17:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id acSOO7yZ9nGC for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Apr 2021 11:17:46 -0400 (EDT)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9FF6E4B6E8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 11:17:46 -0400 (EDT)
Received: by mail-qt1-f202.google.com with SMTP id
 f6-20020ac80a460000b029019c5295a865so4225060qti.17
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 08:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=mlpq2JOS6LVo7hR/1JUgyMS7GDNYOTEdrZCVhgUJoZk=;
 b=C5QvjsMmtJ9feDzYR887MMwiqH1nEUYVC+yy6hcAyh86E+5yIP30YgA/UAHL1n3/Ja
 tQfHKpGCnul+SI1Bavpha03DyMiJwKHLYhflaVQn8JMwtRRN6htqpE0wXY9EF6c4dygY
 6ZWO8zY1nNOsCxh8CR1YLsTZcZGYsWOXwRpjS/VYT9v2m795COAo0zrjUUQ7ZZqfoZYi
 PxFn75NeQqA+TarRUdbDZami5XU/ATbqxhaMOaJidr7H29uo5FhZ3DO2tiwSftyp9MCk
 92wj85zNXV0iO8vVhgOCf0LyCuNf6yWNc8RQI7QmF37YKKcONa/OpoQUEq8TXtHTciYn
 fxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=mlpq2JOS6LVo7hR/1JUgyMS7GDNYOTEdrZCVhgUJoZk=;
 b=WQknzinEDYCpR6lx5roYyqHJ8yHjcmgCWaC+CTHO938J40D9LJlx7aii9YLEfEav5r
 8qgIEmKgqX/rEDSYwiU4A6JJ7pQR7fwBQjPyxV+7VUCN69aVSfqtE19g8Puzsiqqy1Gr
 h82Sd5UbbxBszxWmaSSRcelUWddri1y5QqNeKLDnMM1LJ2ZKgmorr/n+gjJGs6PrBEzS
 m4BS1WWvp0/26zcXws0KHdKZWEK2RcM/vWvfUjtHLaoFfogJdA6OhkVW4QdfHAY5AMfi
 qcPV7QkMLqgsjkivn8pqGRnFGOpMx7jdkqYsGFBB7fOkSgcUGUywrKZiS7uTX0ErLSOf
 AEGg==
X-Gm-Message-State: AOAM532uIEWCmwqIYfvGVoE/2ulamdteY/+G8R82A2XD0Woxh0iyXzSG
 DNTtOmb4GOkdZ8oODPQ2ztHSIUjEcJUvv4XcfQ==
X-Google-Smtp-Source: ABdhPJwrC+nyGQM9VZ9qcUYBJx+Xihn39yLQfi83D/lOKULB5hUpQ+ZZwIdkvGHaw/py2K7TofFgNDQDY2eZkcldog==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:ad4:576e:: with SMTP id
 r14mr3740970qvx.13.1618499866086; Thu, 15 Apr 2021 08:17:46 -0700 (PDT)
Date: Thu, 15 Apr 2021 15:17:38 +0000
In-Reply-To: <20210415151741.1607806-1-jingzhangos@google.com>
Message-Id: <20210415151741.1607806-2-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210415151741.1607806-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 1/4] KVM: stats: Separate common stats from architecture
 specific ones
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>, 
 LinuxMIPS <linux-mips@vger.kernel.org>, KVMPPC <kvm-ppc@vger.kernel.org>, 
 LinuxS390 <linux-s390@vger.kernel.org>, 
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>, 
 Peter Shier <pshier@google.com>, Oliver Upton <oupton@google.com>, 
 David Rientjes <rientjes@google.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>
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

Put all common statistics in a separate structure to ease
statistics handling for the incoming new statistics API.

No functional change intended.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arch/arm64/include/asm/kvm_host.h   |  9 ++-------
 arch/arm64/kvm/guest.c              | 12 ++++++------
 arch/mips/include/asm/kvm_host.h    |  9 ++-------
 arch/mips/kvm/mips.c                | 12 ++++++------
 arch/powerpc/include/asm/kvm_host.h |  9 ++-------
 arch/powerpc/kvm/book3s.c           | 12 ++++++------
 arch/powerpc/kvm/book3s_hv.c        | 12 ++++++------
 arch/powerpc/kvm/book3s_pr.c        |  2 +-
 arch/powerpc/kvm/book3s_pr_papr.c   |  2 +-
 arch/powerpc/kvm/booke.c            | 14 +++++++-------
 arch/s390/include/asm/kvm_host.h    |  9 ++-------
 arch/s390/kvm/kvm-s390.c            | 12 ++++++------
 arch/x86/include/asm/kvm_host.h     |  9 ++-------
 arch/x86/kvm/x86.c                  | 14 +++++++-------
 include/linux/kvm_host.h            |  5 +++++
 include/linux/kvm_types.h           | 12 ++++++++++++
 virt/kvm/kvm_main.c                 | 14 +++++++-------
 17 files changed, 80 insertions(+), 88 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 72e6b4600264..442e447e05d3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -546,16 +546,11 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
 }
 
 struct kvm_vm_stat {
-	ulong remote_tlb_flush;
+	struct kvm_vm_stat_common common;
 };
 
 struct kvm_vcpu_stat {
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
-	u64 halt_poll_invalid;
-	u64 halt_wakeup;
+	struct kvm_vcpu_stat_common common;
 	u64 hvc_exit_stat;
 	u64 wfe_exit_stat;
 	u64 wfi_exit_stat;
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 9bbd30e62799..cc5b1e2fdbd0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -29,18 +29,18 @@
 #include "trace.h"
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
+	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
 	VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
 	VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
 	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
 	VCPU_STAT("mmio_exit_user", mmio_exit_user),
 	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
 	VCPU_STAT("exits", exits),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
 	{ NULL }
 };
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index feaa77036b67..291a453ab447 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -143,10 +143,11 @@ static inline bool kvm_is_error_hva(unsigned long addr)
 }
 
 struct kvm_vm_stat {
-	ulong remote_tlb_flush;
+	struct kvm_vm_stat_common common;
 };
 
 struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_common common;
 	u64 wait_exits;
 	u64 cache_exits;
 	u64 signal_exits;
@@ -178,12 +179,6 @@ struct kvm_vcpu_stat {
 	u64 vz_cpucfg_exits;
 #endif
 #endif
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
-	u64 halt_poll_invalid;
-	u64 halt_wakeup;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 58a8812e2fa5..d78820777de1 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -71,12 +71,12 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("vz_cpucfg", vz_cpucfg_exits),
 #endif
 #endif
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
+	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
 	{NULL}
 };
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 1e83359f286b..473d9d0804ff 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -80,12 +80,13 @@ struct kvmppc_book3s_shadow_vcpu;
 struct kvm_nested_guest;
 
 struct kvm_vm_stat {
-	ulong remote_tlb_flush;
+	struct kvm_vm_stat_common common;
 	ulong num_2M_pages;
 	ulong num_1G_pages;
 };
 
 struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_common common;
 	u64 sum_exits;
 	u64 mmio_exits;
 	u64 signal_exits;
@@ -101,14 +102,8 @@ struct kvm_vcpu_stat {
 	u64 emulated_inst_exits;
 	u64 dec_exits;
 	u64 ext_intr_exits;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
 	u64 halt_wait_ns;
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
 	u64 halt_successful_wait;
-	u64 halt_poll_invalid;
-	u64 halt_wakeup;
 	u64 dbell_exits;
 	u64 gdbell_exits;
 	u64 ld;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 44bf567b6589..d799029f2e55 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -47,14 +47,14 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("dec", dec_exits),
 	VCPU_STAT("ext_intr", ext_intr_exits),
 	VCPU_STAT("queue_intr", queue_intr),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
 	VCPU_STAT("halt_wait_ns", halt_wait_ns),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
 	VCPU_STAT("halt_successful_wait", halt_successful_wait),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
+	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
 	VCPU_STAT("pf_storage", pf_storage),
 	VCPU_STAT("sp_storage", sp_storage),
 	VCPU_STAT("pf_instruc", pf_instruc),
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 13bad6bf4c95..ecc50a689bc5 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -236,7 +236,7 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 
 	waitp = kvm_arch_vcpu_get_wait(vcpu);
 	if (rcuwait_wake_up(waitp))
-		++vcpu->stat.halt_wakeup;
+		++vcpu->stat.common.halt_wakeup;
 
 	cpu = READ_ONCE(vcpu->arch.thread_cpu);
 	if (cpu >= 0 && kvmppc_ipi_thread(cpu))
@@ -3885,7 +3885,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	cur = start_poll = ktime_get();
 	if (vc->halt_poll_ns) {
 		ktime_t stop = ktime_add_ns(start_poll, vc->halt_poll_ns);
-		++vc->runner->stat.halt_attempted_poll;
+		++vc->runner->stat.common.halt_attempted_poll;
 
 		vc->vcore_state = VCORE_POLLING;
 		spin_unlock(&vc->lock);
@@ -3902,7 +3902,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 		vc->vcore_state = VCORE_INACTIVE;
 
 		if (!do_sleep) {
-			++vc->runner->stat.halt_successful_poll;
+			++vc->runner->stat.common.halt_successful_poll;
 			goto out;
 		}
 	}
@@ -3914,7 +3914,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 		do_sleep = 0;
 		/* If we polled, count this as a successful poll */
 		if (vc->halt_poll_ns)
-			++vc->runner->stat.halt_successful_poll;
+			++vc->runner->stat.common.halt_successful_poll;
 		goto out;
 	}
 
@@ -3941,13 +3941,13 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 			ktime_to_ns(cur) - ktime_to_ns(start_wait);
 		/* Attribute failed poll time */
 		if (vc->halt_poll_ns)
-			vc->runner->stat.halt_poll_fail_ns +=
+			vc->runner->stat.common.halt_poll_fail_ns +=
 				ktime_to_ns(start_wait) -
 				ktime_to_ns(start_poll);
 	} else {
 		/* Attribute successful poll time */
 		if (vc->halt_poll_ns)
-			vc->runner->stat.halt_poll_success_ns +=
+			vc->runner->stat.common.halt_poll_success_ns +=
 				ktime_to_ns(cur) -
 				ktime_to_ns(start_poll);
 	}
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 913944dc3620..0d6be10d19ae 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -515,7 +515,7 @@ static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
 		if (!vcpu->arch.pending_exceptions) {
 			kvm_vcpu_block(vcpu);
 			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
-			vcpu->stat.halt_wakeup++;
+			vcpu->stat.common.halt_wakeup++;
 
 			/* Unset POW bit after we woke up */
 			msr &= ~MSR_POW;
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index 031c8015864a..9384625c8051 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -378,7 +378,7 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
 		kvm_vcpu_block(vcpu);
 		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
-		vcpu->stat.halt_wakeup++;
+		vcpu->stat.common.halt_wakeup++;
 		return EMULATE_DONE;
 	case H_LOGICAL_CI_LOAD:
 		return kvmppc_h_pr_logical_ci_load(vcpu);
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 7d5fe43f85c4..07fdd7a1254a 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -49,15 +49,15 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("inst_emu", emulated_inst_exits),
 	VCPU_STAT("dec", dec_exits),
 	VCPU_STAT("ext_intr", ext_intr_exits),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
+	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
 	VCPU_STAT("doorbell", dbell_exits),
 	VCPU_STAT("guest doorbell", gdbell_exits),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
-	VM_STAT("remote_tlb_flush", remote_tlb_flush),
+	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
+	VM_STAT_COM("remote_tlb_flush", remote_tlb_flush),
 	{ NULL }
 };
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 6bcfc5614bbc..3b45476e70f6 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -361,6 +361,7 @@ struct sie_page {
 };
 
 struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_common common;
 	u64 exit_userspace;
 	u64 exit_null;
 	u64 exit_external_request;
@@ -370,13 +371,7 @@ struct kvm_vcpu_stat {
 	u64 exit_validity;
 	u64 exit_instruction;
 	u64 exit_pei;
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
-	u64 halt_poll_invalid;
 	u64 halt_no_poll_steal;
-	u64 halt_wakeup;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
 	u64 instruction_lctl;
 	u64 instruction_lctlg;
 	u64 instruction_stctl;
@@ -750,12 +745,12 @@ struct kvm_vcpu_arch {
 };
 
 struct kvm_vm_stat {
+	struct kvm_vm_stat_common common;
 	u64 inject_io;
 	u64 inject_float_mchk;
 	u64 inject_pfault_done;
 	u64 inject_service_signal;
 	u64 inject_virtio;
-	u64 remote_tlb_flush;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2f09e9d7dc95..14399985b7de 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -72,13 +72,13 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("exit_program_interruption", exit_program_interruption),
 	VCPU_STAT("exit_instr_and_program_int", exit_instr_and_program),
 	VCPU_STAT("exit_operation_exception", exit_operation_exception),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
 	VCPU_STAT("halt_no_poll_steal", halt_no_poll_steal),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
+	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
 	VCPU_STAT("instruction_lctlg", instruction_lctlg),
 	VCPU_STAT("instruction_lctl", instruction_lctl),
 	VCPU_STAT("instruction_stctl", instruction_stctl),
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 44f893043a3c..74bce65a0802 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1082,6 +1082,7 @@ struct kvm_arch {
 };
 
 struct kvm_vm_stat {
+	struct kvm_vm_stat_common common;
 	ulong mmu_shadow_zapped;
 	ulong mmu_pte_write;
 	ulong mmu_pde_zapped;
@@ -1089,13 +1090,13 @@ struct kvm_vm_stat {
 	ulong mmu_recycled;
 	ulong mmu_cache_miss;
 	ulong mmu_unsync;
-	ulong remote_tlb_flush;
 	ulong lpages;
 	ulong nx_lpage_splits;
 	ulong max_mmu_page_hash_collisions;
 };
 
 struct kvm_vcpu_stat {
+	struct kvm_vcpu_stat_common common;
 	u64 pf_fixed;
 	u64 pf_guest;
 	u64 tlb_flush;
@@ -1109,10 +1110,6 @@ struct kvm_vcpu_stat {
 	u64 nmi_window_exits;
 	u64 l1d_flush;
 	u64 halt_exits;
-	u64 halt_successful_poll;
-	u64 halt_attempted_poll;
-	u64 halt_poll_invalid;
-	u64 halt_wakeup;
 	u64 request_irq_exits;
 	u64 irq_exits;
 	u64 host_state_reload;
@@ -1123,8 +1120,6 @@ struct kvm_vcpu_stat {
 	u64 irq_injections;
 	u64 nmi_injections;
 	u64 req_event;
-	u64 halt_poll_success_ns;
-	u64 halt_poll_fail_ns;
 	u64 nested_run;
 };
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 16fb39503296..5d5d4806e93b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -228,10 +228,10 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("irq_window", irq_window_exits),
 	VCPU_STAT("nmi_window", nmi_window_exits),
 	VCPU_STAT("halt_exits", halt_exits),
-	VCPU_STAT("halt_successful_poll", halt_successful_poll),
-	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
-	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
-	VCPU_STAT("halt_wakeup", halt_wakeup),
+	VCPU_STAT_COM("halt_successful_poll", halt_successful_poll),
+	VCPU_STAT_COM("halt_attempted_poll", halt_attempted_poll),
+	VCPU_STAT_COM("halt_poll_invalid", halt_poll_invalid),
+	VCPU_STAT_COM("halt_wakeup", halt_wakeup),
 	VCPU_STAT("hypercalls", hypercalls),
 	VCPU_STAT("request_irq", request_irq_exits),
 	VCPU_STAT("irq_exits", irq_exits),
@@ -243,8 +243,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("nmi_injections", nmi_injections),
 	VCPU_STAT("req_event", req_event),
 	VCPU_STAT("l1d_flush", l1d_flush),
-	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
-	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT_COM("halt_poll_success_ns", halt_poll_success_ns),
+	VCPU_STAT_COM("halt_poll_fail_ns", halt_poll_fail_ns),
 	VCPU_STAT("nested_run", nested_run),
 	VM_STAT("mmu_shadow_zapped", mmu_shadow_zapped),
 	VM_STAT("mmu_pte_write", mmu_pte_write),
@@ -253,7 +253,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VM_STAT("mmu_recycled", mmu_recycled),
 	VM_STAT("mmu_cache_miss", mmu_cache_miss),
 	VM_STAT("mmu_unsync", mmu_unsync),
-	VM_STAT("remote_tlb_flush", remote_tlb_flush),
+	VM_STAT_COM("remote_tlb_flush", remote_tlb_flush),
 	VM_STAT("largepages", lpages, .mode = 0444),
 	VM_STAT("nx_largepages_splitted", nx_lpage_splits, .mode = 0444),
 	VM_STAT("max_mmu_page_hash_collisions", max_mmu_page_hash_collisions),
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3b06d12ec37e..53428b01224e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1195,6 +1195,11 @@ struct kvm_stats_debugfs_item {
 	{ n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
 #define VCPU_STAT(n, x, ...)							\
 	{ n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
+#define VM_STAT_COM(n, x, ...) 						       \
+	{ n, offsetof(struct kvm, stat.common.x), KVM_STAT_VM, ## __VA_ARGS__ }
+#define VCPU_STAT_COM(n, x, ...)					       \
+	{ n, offsetof(struct kvm_vcpu, stat.common.x),			       \
+	  KVM_STAT_VCPU, ## __VA_ARGS__ }
 
 extern struct kvm_stats_debugfs_item debugfs_entries[];
 extern struct dentry *kvm_debugfs_dir;
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a7580f69dda0..87eb05ad678b 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -76,5 +76,17 @@ struct kvm_mmu_memory_cache {
 };
 #endif
 
+struct kvm_vm_stat_common {
+	ulong remote_tlb_flush;
+};
+
+struct kvm_vcpu_stat_common {
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 halt_poll_success_ns;
+	u64 halt_poll_fail_ns;
+};
 
 #endif /* __KVM_TYPES_H__ */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0a481e7780f0..2c4205ccf3dd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -330,7 +330,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
 	 */
 	if (!kvm_arch_flush_remote_tlb(kvm)
 	    || kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
-		++kvm->stat.remote_tlb_flush;
+		++kvm->stat.common.remote_tlb_flush;
 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
 }
 EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
@@ -2815,9 +2815,9 @@ static inline void
 update_halt_poll_stats(struct kvm_vcpu *vcpu, u64 poll_ns, bool waited)
 {
 	if (waited)
-		vcpu->stat.halt_poll_fail_ns += poll_ns;
+		vcpu->stat.common.halt_poll_fail_ns += poll_ns;
 	else
-		vcpu->stat.halt_poll_success_ns += poll_ns;
+		vcpu->stat.common.halt_poll_success_ns += poll_ns;
 }
 
 /*
@@ -2835,16 +2835,16 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	if (vcpu->halt_poll_ns && !kvm_arch_no_poll(vcpu)) {
 		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
 
-		++vcpu->stat.halt_attempted_poll;
+		++vcpu->stat.common.halt_attempted_poll;
 		do {
 			/*
 			 * This sets KVM_REQ_UNHALT if an interrupt
 			 * arrives.
 			 */
 			if (kvm_vcpu_check_block(vcpu) < 0) {
-				++vcpu->stat.halt_successful_poll;
+				++vcpu->stat.common.halt_successful_poll;
 				if (!vcpu_valid_wakeup(vcpu))
-					++vcpu->stat.halt_poll_invalid;
+					++vcpu->stat.common.halt_poll_invalid;
 				goto out;
 			}
 			poll_end = cur = ktime_get();
@@ -2901,7 +2901,7 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 	waitp = kvm_arch_vcpu_get_wait(vcpu);
 	if (rcuwait_wake_up(waitp)) {
 		WRITE_ONCE(vcpu->ready, true);
-		++vcpu->stat.halt_wakeup;
+		++vcpu->stat.common.halt_wakeup;
 		return true;
 	}
 
-- 
2.31.1.295.g9ea45b61b8-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
