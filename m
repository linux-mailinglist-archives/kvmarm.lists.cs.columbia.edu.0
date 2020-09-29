Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6720027C0D4
	for <lists+kvmarm@lfdr.de>; Tue, 29 Sep 2020 11:18:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BD674B339;
	Tue, 29 Sep 2020 05:18:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DGvmB5cPVxZ1; Tue, 29 Sep 2020 05:18:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C28984B358;
	Tue, 29 Sep 2020 05:18:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D587D4B332
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 05:18:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i-ckIbNHohFR for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Sep 2020 05:18:10 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BBCF44B324
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 05:18:09 -0400 (EDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A7ECDD523EC78719281F;
 Tue, 29 Sep 2020 17:18:07 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.69) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 17:17:58 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 4/4] KVM: arm64: Add trace for TWED update
Date: Tue, 29 Sep 2020 17:17:27 +0800
Message-ID: <20200929091727.8692-5-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20200929091727.8692-1-wangjingyi11@huawei.com>
References: <20200929091727.8692-1-wangjingyi11@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.187.69]
X-CFilter-Loop: Reflected
Cc: catalin.marinas@arm.com, fanhenglong@huawei.com, prime.zeng@hisilicon.com,
 maz@kernel.org, will@kernel.org
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

From: Zengruan Ye <yezengruan@huawei.com>

Add tracepoints for TWE delay value update

Signed-off-by: Zengruan Ye <yezengruan@huawei.com>
Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
---
 arch/arm64/kvm/arm.c       |  4 ++++
 arch/arm64/kvm/trace_arm.h | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 989bffdcb3e9..c3d7a326bf1b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -80,6 +80,8 @@ void grow_twed(struct kvm_vcpu *vcpu)
 		vcpu->arch.twed += 1;
 		vcpu->arch.twed_dirty = true;
 	}
+
+	trace_kvm_twed_update(vcpu->vcpu_id, vcpu->arch.twed, old);
 }
 
 void shrink_twed(struct kvm_vcpu *vcpu)
@@ -90,6 +92,8 @@ void shrink_twed(struct kvm_vcpu *vcpu)
 		vcpu->arch.twed -= 1;
 		vcpu->arch.twed_dirty = true;
 	}
+
+	trace_kvm_twed_update(vcpu->vcpu_id, vcpu->arch.twed, old);
 }
 #endif
 
diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
index ff0444352bba..5081266399e8 100644
--- a/arch/arm64/kvm/trace_arm.h
+++ b/arch/arm64/kvm/trace_arm.h
@@ -367,6 +367,27 @@ TRACE_EVENT(kvm_timer_emulate,
 		  __entry->timer_idx, __entry->should_fire)
 );
 
+TRACE_EVENT(kvm_twed_update,
+	TP_PROTO(unsigned int vcpu_id, unsigned int new, unsigned int old),
+	TP_ARGS(vcpu_id, new, old),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	vcpu_id		)
+		__field(	unsigned int,	new		)
+		__field(	unsigned int,	old		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id	= vcpu_id;
+		__entry->new		= new;
+		__entry->old		= old;
+	),
+
+	TP_printk("vcpu %u old %u new %u (%s)",
+		  __entry->vcpu_id, __entry->old, __entry->new,
+		  __entry->old < __entry->new ? "growed" : "shrinked")
+);
+
 #endif /* _TRACE_ARM_ARM64_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
