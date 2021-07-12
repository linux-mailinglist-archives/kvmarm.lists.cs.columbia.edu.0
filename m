Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 54FAC3C5DFA
	for <lists+kvmarm@lfdr.de>; Mon, 12 Jul 2021 16:08:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03F2F4086C;
	Mon, 12 Jul 2021 10:08:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@163.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ltfu-fAf7KJe; Mon, 12 Jul 2021 10:08:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F2AFA49D50;
	Mon, 12 Jul 2021 10:08:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E5B840667
 for <kvmarm@lists.cs.columbia.edu>; Mon, 12 Jul 2021 08:50:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NA4BIq9vLThZ for <kvmarm@lists.cs.columbia.edu>;
 Mon, 12 Jul 2021 08:50:19 -0400 (EDT)
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 641CC40489
 for <kvmarm@lists.cs.columbia.edu>; Mon, 12 Jul 2021 08:50:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Zth9h
 lybNni3WiyPDF7Xh8+1u3A/Ia/7eIAU4c+0rIs=; b=D+Q7spXUyaCO8GzgXO/Tf
 uS/LeReS2G663ePC9/5x8QiJ9Kz4svPBvaWUO9n+3bbbBTg1nuM/Ke/OuCCl1cF6
 Hl+PUQZVvt8wqepT5NRyUAcgsLWTRP60ypC86SSmS15/VD2ucumj4+euG0brsq5L
 5teTl3AdlBe5jF29i9mjRQ=
Received: from localhost (unknown [180.169.253.136])
 by smtp13 (Coremail) with SMTP id EcCowAAHSYp+Ouxg3lXNAQ--.49872S2;
 Mon, 12 Jul 2021 20:50:07 +0800 (CST)
From: John Gong <johngong0791@163.com>
To: maz@kernel.org
Subject: [PATCH] KVM/ARM: vgic: Delete the redundant lines of code
Date: Mon, 12 Jul 2021 20:49:33 +0800
Message-Id: <20210712124933.1153992-1-johngong0791@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: EcCowAAHSYp+Ouxg3lXNAQ--.49872S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1UZw4fWw1xCrykCrWDCFg_yoWxCrX_A3
 yIgw1aqFW8Cr1Iqw4Y93yfCrnFg34DJryYgF1q9rZ5trn8Zw4YkrWDXFsIgFy5W34agrs3
 A39rAry5tw18WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Hv3UUUUUU==
X-Originating-IP: [180.169.253.136]
X-CM-SenderInfo: xmrk0wxrqjilizr6il2tof0z/1tbiWR-NhVWBvHsZewAAs-
X-Mailman-Approved-At: Mon, 12 Jul 2021 10:08:46 -0400
Cc: John Gong <johngong0791@163.com>, kvmarm@lists.cs.columbia.edu
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

delete redundant lines of code

Signed-off-by: John Gong <johngong0791@163.com>
---
 arch/arm64/kvm/vgic/vgic-mmio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index 48c6067fc5ec..19cf661c451e 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -1004,8 +1004,6 @@ static int dispatch_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 
 	switch (iodev->iodev_type) {
 	case IODEV_CPUIF:
-		data = region->read(vcpu, addr, len);
-		break;
 	case IODEV_DIST:
 		data = region->read(vcpu, addr, len);
 		break;
-- 
2.25.1


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
