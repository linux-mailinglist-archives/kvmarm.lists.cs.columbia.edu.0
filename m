Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3AA34205C
	for <lists+kvmarm@lfdr.de>; Wed, 12 Jun 2019 11:15:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7191D4A52A;
	Wed, 12 Jun 2019 05:15:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7sdJsgOlUZvC; Wed, 12 Jun 2019 05:15:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 508724A529;
	Wed, 12 Jun 2019 05:15:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D727A4A521
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 Jun 2019 05:15:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FPA9C4hIT25j for <kvmarm@lists.cs.columbia.edu>;
 Wed, 12 Jun 2019 05:15:02 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 458774A512
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 Jun 2019 05:15:01 -0400 (EDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0785F7029CD80C359046;
 Wed, 12 Jun 2019 17:11:51 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 17:11:44 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 1/5] KVM: arm/arm64: Remove kvm_mmio_emulate tracepoint
Date: Wed, 12 Jun 2019 09:08:42 +0000
Message-ID: <1560330526-15468-2-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
References: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 acme@kernel.org, linuxarm@huawei.com, acme@redhat.com, peterz@infradead.org,
 alexander.shishkin@linux.intel.com, mingo@redhat.com,
 ganapatrao.kulkarni@cavium.com, namhyung@kernel.org, jolsa@redhat.com,
 xiexiangyou@huawei.com
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

In current KVM/ARM code, no one will invoke trace_kvm_mmio_emulate().
Remove this TRACE_EVENT definition.

Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/trace.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
index 204d210..8b7dff2 100644
--- a/virt/kvm/arm/trace.h
+++ b/virt/kvm/arm/trace.h
@@ -114,27 +114,6 @@
 		  __entry->type, __entry->vcpu_idx, __entry->irq_num, __entry->level)
 );
 
-TRACE_EVENT(kvm_mmio_emulate,
-	TP_PROTO(unsigned long vcpu_pc, unsigned long instr,
-		 unsigned long cpsr),
-	TP_ARGS(vcpu_pc, instr, cpsr),
-
-	TP_STRUCT__entry(
-		__field(	unsigned long,	vcpu_pc		)
-		__field(	unsigned long,	instr		)
-		__field(	unsigned long,	cpsr		)
-	),
-
-	TP_fast_assign(
-		__entry->vcpu_pc		= vcpu_pc;
-		__entry->instr			= instr;
-		__entry->cpsr			= cpsr;
-	),
-
-	TP_printk("Emulate MMIO at: 0x%08lx (instr: %08lx, cpsr: %08lx)",
-		  __entry->vcpu_pc, __entry->instr, __entry->cpsr)
-);
-
 TRACE_EVENT(kvm_unmap_hva_range,
 	TP_PROTO(unsigned long start, unsigned long end),
 	TP_ARGS(start, end),
-- 
1.8.3.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
