Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E02441BA022
	for <lists+kvmarm@lfdr.de>; Mon, 27 Apr 2020 11:40:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B5214B1A9;
	Mon, 27 Apr 2020 05:40:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	UNPARSEABLE_RELAY=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K6VG0SImffGS; Mon, 27 Apr 2020 05:40:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFF034B109;
	Mon, 27 Apr 2020 05:39:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B4F034A4E5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Apr 2020 00:35:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r7muHgAmRC7g for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Apr 2020 00:35:22 -0400 (EDT)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 64E0C4B0F8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Apr 2020 00:35:22 -0400 (EDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R881e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=38; SR=0;
 TI=SMTPD_---0Twk-CBH_1587962117; 
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0Twk-CBH_1587962117) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Apr 2020 12:35:17 +0800
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To: pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com,
 frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 heiko.carstens@de.ibm.com, gor@linux.ibm.com,
 sean.j.christopherson@intel.com, vkuznets@redhat.com,
 wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, maz@kernel.org, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com,
 chenhuacai@gmail.com
Subject: [PATCH v4 3/7] KVM: PPC: Remove redundant kvm_run from vcpu_arch
Date: Mon, 27 Apr 2020 12:35:10 +0800
Message-Id: <20200427043514.16144-4-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
X-Mailman-Approved-At: Mon, 27 Apr 2020 05:39:54 -0400
Cc: linux-s390@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
 kvm@vger.kernel.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

The 'kvm_run' field already exists in the 'vcpu' structure, which
is the same structure as the 'kvm_run' in the 'vcpu_arch' and
should be deleted.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/powerpc/include/asm/kvm_host.h | 1 -
 arch/powerpc/kvm/book3s_hv.c        | 6 ++----
 arch/powerpc/kvm/book3s_hv_nested.c | 3 +--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 1dc63101ffe1..2745ff8faa01 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -795,7 +795,6 @@ struct kvm_vcpu_arch {
 	struct mmio_hpte_cache_entry *pgfault_cache;
 
 	struct task_struct *run_task;
-	struct kvm_run *kvm_run;
 
 	spinlock_t vpa_update_lock;
 	struct kvmppc_vpa vpa;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 93493f0cbfe8..413ea2dcb10c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2934,7 +2934,7 @@ static void post_guest_process(struct kvmppc_vcore *vc, bool is_master)
 
 		ret = RESUME_GUEST;
 		if (vcpu->arch.trap)
-			ret = kvmppc_handle_exit_hv(vcpu->arch.kvm_run, vcpu,
+			ret = kvmppc_handle_exit_hv(vcpu->run, vcpu,
 						    vcpu->arch.run_task);
 
 		vcpu->arch.ret = ret;
@@ -3920,7 +3920,6 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	spin_lock(&vc->lock);
 	vcpu->arch.ceded = 0;
 	vcpu->arch.run_task = current;
-	vcpu->arch.kvm_run = kvm_run;
 	vcpu->arch.stolen_logged = vcore_stolen_time(vc, mftb());
 	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
 	vcpu->arch.busy_preempt = TB_NIL;
@@ -3973,7 +3972,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			if (signal_pending(v->arch.run_task)) {
 				kvmppc_remove_runnable(vc, v);
 				v->stat.signal_exits++;
-				v->arch.kvm_run->exit_reason = KVM_EXIT_INTR;
+				v->run->exit_reason = KVM_EXIT_INTR;
 				v->arch.ret = -EINTR;
 				wake_up(&v->arch.cpu_run);
 			}
@@ -4049,7 +4048,6 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 	vc = vcpu->arch.vcore;
 	vcpu->arch.ceded = 0;
 	vcpu->arch.run_task = current;
-	vcpu->arch.kvm_run = kvm_run;
 	vcpu->arch.stolen_logged = vcore_stolen_time(vc, mftb());
 	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
 	vcpu->arch.busy_preempt = TB_NIL;
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index dc97e5be76f6..5a3987f3ebf3 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -290,8 +290,7 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 			r = RESUME_HOST;
 			break;
 		}
-		r = kvmhv_run_single_vcpu(vcpu->arch.kvm_run, vcpu, hdec_exp,
-					  lpcr);
+		r = kvmhv_run_single_vcpu(vcpu->run, vcpu, hdec_exp, lpcr);
 	} while (is_kvmppc_resume_guest(r));
 
 	/* save L2 state for return */
-- 
2.17.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
