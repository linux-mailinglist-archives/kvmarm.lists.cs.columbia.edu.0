Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0E34C2B52DF
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 21:43:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B70364C257;
	Mon, 16 Nov 2020 15:43:39 -0500 (EST)
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
	with ESMTP id 6Fa-lupt9hNq; Mon, 16 Nov 2020 15:43:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B51904C25A;
	Mon, 16 Nov 2020 15:43:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D6C1B4C246
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 15:43:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YjjaNo7NpyWQ for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 15:43:35 -0500 (EST)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DB2614C24F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 15:43:34 -0500 (EST)
Received: by mail-wr1-f66.google.com with SMTP id p8so20291229wrx.5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 12:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bjd/L/G2RRJSREzHJQoP1g0vINVfsyI8Fcne4wQjdig=;
 b=qwqZWyct9mC77pKffhl9ewXjtbvEoGrUi8si2A11bZr9k90fjqy4CvCiKnuLULg9Xc
 xZsD/v5Iix62RPRCibgZ+tZiv+SAPkZFT0DU1jVhNoCjsPpbzg0xEMZviOo1l2H2yUz8
 I+smY239ch51NxRdHId1zlz51cgAXoskrOxAl+34LkMpkUhax7TjrBGvoGaS7j5SHTuP
 rP+KPKvuViyoxyq+uLMMCi3W/Y9+hT5n3I6Es+ziNVR8puNxmjHXTNM4abQR2ONs8n4Q
 vKE4B6ftz/SWim21pNTXO6NEZmCl9EybGnnBehU1aiXeOinjaFvoX7K4ExASkiniuJ5E
 K2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bjd/L/G2RRJSREzHJQoP1g0vINVfsyI8Fcne4wQjdig=;
 b=gQPrfCmBaO9YgLVLl95ILxLVPzAafDFJsD+JAKyPBLvYTNV5+9kT93fkcel42n6AZQ
 jSXL4xFoMGimS9en5eIQHEPscgcPiPFxQwAzYHj8LsM55xMYM/vm6tIPq3mTrGjidN7o
 RYV8Mnjow6621+cZ+NiWZ1R16xiO0b3aIcVHIOXDo7QzJ0xpPq2RPXiVbQlGyH33vIlL
 ZwSbHzP4LK8Sj472aucBo3Kq/BLySY7z8cKsDcycrTOfXVQQz1J0a9PbPOpro00J12lI
 cxKxzFTKgdEpol64h1qsA5/9v7FcaAOLwUdFcUJamJ23HDjfkFaZ/Yssqnkqx4/kIx1p
 LC/g==
X-Gm-Message-State: AOAM533OIyP53/f2wt4LwwOdbmTLXputibVtkBVXWraFZz3J+20+N/dM
 27yXWM9sUQzbkeAyKFAKy6ZQ0wY2VGf2VVummYQ=
X-Google-Smtp-Source: ABdhPJzhp5Qc3VCMl1XdepBsYRbo892rELQDUt+zy3yDaVQOCJPXpDk/FSGa+TxWc6mOuFFKMoZOug==
X-Received: by 2002:adf:f183:: with SMTP id h3mr21954131wro.239.1605559413646; 
 Mon, 16 Nov 2020 12:43:33 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
 by smtp.gmail.com with ESMTPSA id a18sm530393wmm.22.2020.11.16.12.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2020 12:43:32 -0800 (PST)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 05/24] kvm: arm64: Initialize MAIR_EL2 using a constant
Date: Mon, 16 Nov 2020 20:42:59 +0000
Message-Id: <20201116204318.63987-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrew Walbran <qwandor@google.com>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>
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

MAIR_EL2 is currently initialized to the value of MAIR_EL1, which itself
is set to a constant MAIR_ELx_SET.

Initialize MAIR_EL2 to MAIR_ELx_SET directly in preparation of allowing
KVM to start CPU cores itself and not initializing itself before ERETing
to EL1. In that case, MAIR_EL2 will be initialized before MAIR_EL1.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index b11a9d7db677..17b58dbc3a2f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -111,7 +111,7 @@ alternative_else_nop_endif
 
 	msr	tcr_el2, x0
 
-	mrs	x0, mair_el1
+	mov_q	x0, MAIR_ELx_SET
 	msr	mair_el2, x0
 	isb
 
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
