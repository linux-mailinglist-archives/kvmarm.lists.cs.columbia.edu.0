Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D9E1810C2BE
	for <lists+kvmarm@lfdr.de>; Thu, 28 Nov 2019 04:10:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 887004A598;
	Wed, 27 Nov 2019 22:10:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WAApXf84dNQG; Wed, 27 Nov 2019 22:10:09 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 781544ACD6;
	Wed, 27 Nov 2019 22:10:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BA794AC88
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Nov 2019 22:10:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3lF2Mx9uh2Id for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Nov 2019 22:10:07 -0500 (EST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 000664A598
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Nov 2019 22:10:06 -0500 (EST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 351A96ADCDBDC841C9DC;
 Thu, 28 Nov 2019 11:10:05 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 11:09:55 +0800
From: linmiaohe <linmiaohe@huawei.com>
To: <maz@kernel.org>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
 <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
 <suzuki.poulose@arm.com>, <christoffer.dall@arm.com>,
 <catalin.marinas@arm.com>, <eric.auger@redhat.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>, <andre.przywara@arm.com>,
 <tglx@linutronix.de>
Subject: [PATCH] KVM: arm64: eliminate unnecessary var err and jump label in
 set_core_reg()
Date: Thu, 28 Nov 2019 11:09:58 +0800
Message-ID: <1574910598-14468-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

From: Miaohe Lin <linmiaohe@huawei.com>

The var err and jump label out isn't really needed in
set_core_reg(). Clean them up.
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/arm64/kvm/guest.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 3b836c91609e..88eb6e5399ed 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -159,7 +159,6 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	__uint128_t tmp;
 	void *valp = &tmp;
 	u64 off;
-	int err = 0;
 
 	/* Our ID is an index into the kvm_regs struct. */
 	off = core_reg_offset_from_id(reg->id);
@@ -173,10 +172,8 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
 		return -EINVAL;
 
-	if (copy_from_user(valp, uaddr, KVM_REG_SIZE(reg->id))) {
-		err = -EFAULT;
-		goto out;
-	}
+	if (copy_from_user(valp, uaddr, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
 
 	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
 		u64 mode = (*(u64 *)valp) & PSR_AA32_MODE_MASK;
@@ -200,14 +197,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 				return -EINVAL;
 			break;
 		default:
-			err = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 	}
 
 	memcpy((u32 *)regs + off, valp, KVM_REG_SIZE(reg->id));
-out:
-	return err;
+	return 0;
 }
 
 #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
-- 
2.19.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
