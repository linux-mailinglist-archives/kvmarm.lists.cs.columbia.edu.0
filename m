Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 018955EAB3
	for <lists+kvmarm@lfdr.de>; Wed,  3 Jul 2019 19:43:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8084B4A53C;
	Wed,  3 Jul 2019 13:43:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cNII62t-ux3m; Wed,  3 Jul 2019 13:43:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 37AC84A51E;
	Wed,  3 Jul 2019 13:43:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C64A4A508
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 13:42:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SUO5gAABJZ1b for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Jul 2019 13:42:58 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2192D4A4F7
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Jul 2019 13:42:58 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6D40344;
 Wed,  3 Jul 2019 10:42:57 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BF4F3F718;
 Wed,  3 Jul 2019 10:42:56 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64/sve: Fix vq_present() macro to yield a bool
Date: Wed,  3 Jul 2019 18:42:50 +0100
Message-Id: <1562175770-10952-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Julien Grall <julien.grall@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

From: Zhang Lei <zhang.lei@jp.fujitsu.com>

The original implementation of vq_present() relied on aggressive
inlining in order for the compiler to know that the code is
correct, due to some const-casting issues.  This was causing sparse
and clang to complain, while GCC compiled cleanly.

Commit 0c529ff789bc addressed this problem, but since vq_present()
is no longer a function, there is now no implicit casting of the
returned value to the return type (bool).

In set_sve_vls(), this uncast bit value is compared against a bool,
and so may spuriously compare as unequal when both are nonzero.  As
a result, KVM may reject valid SVE vector length configurations as
invalid, and vice versa.

Fix it by forcing the returned value to a bool.

Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
Fixes: 0c529ff789bc ("KVM: arm64: Implement vq_present() as a macro")
Signed-off-by: Dave Martin <Dave.Martin@arm.com> [commit message rewrite]
Cc: Viresh Kumar <viresh.kumar@linaro.org>

---

Posting this under Zhang Lei's authorship, due to the need to turn this
fix around quickly.  The fix is as per the original suggestion [1].

Originally observed with the QEMU KVM SVE support under review:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04945.html

Bug reproduced and fix tested on the Arm Fast Model, with
http://linux-arm.org/git?p=kvmtool-dm.git;a=shortlog;h=refs/heads/sve/v3/head
(After rerunning util/update_headers.sh.)

(the --sve-vls command line argument was removed in v4 of the
kvmtool patches).

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-July/664633.html
---
 arch/arm64/kvm/guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index c2afa79..dfd6264 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -208,7 +208,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
 #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
-#define vq_present(vqs, vq) ((vqs)[vq_word(vq)] & vq_mask(vq))
+#define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
 
 static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
-- 
2.1.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
