Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 46FF7210F92
	for <lists+kvmarm@lfdr.de>; Wed,  1 Jul 2020 17:42:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EFA734B35D;
	Wed,  1 Jul 2020 11:42:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -3.291
X-Spam-Level: 
X-Spam-Status: No, score=-3.291 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XEpQjqycuzUA; Wed,  1 Jul 2020 11:42:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C2BAD4B349;
	Wed,  1 Jul 2020 11:42:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C59394B294
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 10:02:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsvwyNWlWXpz for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Jul 2020 10:02:28 -0400 (EDT)
Received: from smtp-fw-9101.amazon.com (smtp-fw-9101.amazon.com
 [207.171.184.25])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AD6084B1C5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 10:02:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1593612150; x=1625148150;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=5zs5lyxU5AtUdWhiM9M4OnXzAKmqv7biVE/Gy/y7dYc=;
 b=jl2ZkyRyRLeWCi2HM+7mtwNrZDPxc7GKCmlaiyCUCC/8y4SAvi+HzEPu
 yOi1mFuZXL2PpqK1pGiuXBrUJkRZdk9PHH8KPuenefYqjen7KIMP8Eol6
 g9Xh6z73cBssE2gzcFMu5YEyMTrQN1NSJGLPRUK5PviamfpPXlZbAyMCM E=;
IronPort-SDR: /W76JCUcLQtk7wQg9wwmfEH4BUJ0N5VwiTtPu0r4q1nWt0lIbl7VZ5lLBHNJhWL0Do5IzhbSQw
 5Haek1aXZJcQ==
X-IronPort-AV: E=Sophos;i="5.75,300,1589241600"; d="scan'208";a="48368723"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 01 Jul 2020 14:02:20 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS
 id AA33CA26D8; Wed,  1 Jul 2020 14:02:16 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 1 Jul 2020 14:02:15 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.162.85) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 1 Jul 2020 14:02:13 +0000
From: Alexander Graf <graf@amazon.com>
To: <kvmarm@lists.cs.columbia.edu>
Subject: [PATCH] KVM: arm64: Change default caching mode for {PEND,
 PROP}BASER.outer
Date: Wed, 1 Jul 2020 16:02:06 +0200
Message-ID: <20200701140206.8664-1-graf@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.43.162.85]
X-ClientProxiedBy: EX13D06UWA003.ant.amazon.com (10.43.160.13) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
X-Mailman-Approved-At: Wed, 01 Jul 2020 11:42:44 -0400
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

PENDBASER and PROPBASER define the outer caching mode for LPI tables.
The memory backing them may not be outer sharable, so we mark them as nC
by default. This however, breaks Windows on ARM which only accepts
SameAsInner or RaWaWb as values for outer cachability.

We do today already allow the outer mode to be set to SameAsInner
explicitly, so the easy fix is to default to that instead of nC for
situations when an OS asks for a not fulfillable cachability request.

This fixes booting Windows in KVM with vgicv3 and ITS enabled for me.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index d2339a2b9fb9..5c786b915cd3 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -389,7 +389,7 @@ u64 vgic_sanitise_outer_cacheability(u64 field)
 	case GIC_BASER_CACHE_nC:
 		return field;
 	default:
-		return GIC_BASER_CACHE_nC;
+		return GIC_BASER_CACHE_SameAsInner;
 	}
 }
 
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
