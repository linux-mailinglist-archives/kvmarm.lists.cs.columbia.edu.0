Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD5E2C5660
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 14:46:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DFBA4BD38;
	Thu, 26 Nov 2020 08:46:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xFBV57CJfYr9; Thu, 26 Nov 2020 08:46:55 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 061D64C16E;
	Thu, 26 Nov 2020 08:46:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 78FD54BD13
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 08:46:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gUODNKGO2JoU for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 08:46:51 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EF404B9EF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 08:46:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606398411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZV1eVRFg54k0Zal0/KxnT+naLTq9uAHCIPcq+JSenDw=;
 b=GrKx8u/3qpjpOoMMxEUPQUen+PBRS1vxDeGp0TIGRRsbqpuA5HjXaWgGMhlRmMrPBprt3a
 HQTTfpkZBhSR//bFZKsn2c7TC+8O02P66Ky3A6+/IgaCg9Vf3R5g0X/ork0HKdOG/c8D31
 a7KGirG3SXCiZdpcJzmpyIDVVgx62t4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Xn-HebAfNb6nwNvM1dGkkQ-1; Thu, 26 Nov 2020 08:46:47 -0500
X-MC-Unique: Xn-HebAfNb6nwNvM1dGkkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D2E6193ECE3;
 Thu, 26 Nov 2020 13:46:46 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1D1010021AA;
 Thu, 26 Nov 2020 13:46:44 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 1/2] KVM: arm64: CSSELR_EL1 max is 13
Date: Thu, 26 Nov 2020 14:46:40 +0100
Message-Id: <20201126134641.35231-2-drjones@redhat.com>
In-Reply-To: <20201126134641.35231-1-drjones@redhat.com>
References: <20201126134641.35231-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: maz@kernel.org, pbonzini@redhat.com
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

Not counting TnD, which KVM doesn't currently consider, CSSELR_EL1
can have a maximum value of 0b1101 (13), which corresponds to an
instruction cache at level 7. With CSSELR_MAX set to 12 we can
only select up to cache level 6. Change it to 14.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm64/kvm/sys_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c1fac9836af1..ef453f7827fa 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -169,7 +169,7 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
 static u32 cache_levels;
 
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
-#define CSSELR_MAX 12
+#define CSSELR_MAX 14
 
 /* Which cache CCSIDR represents depends on CSSELR value. */
 static u32 get_ccsidr(u32 csselr)
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
