Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8037C42C577
	for <lists+kvmarm@lfdr.de>; Wed, 13 Oct 2021 17:58:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F02C4B101;
	Wed, 13 Oct 2021 11:58:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQzSJSTFGFJe; Wed, 13 Oct 2021 11:58:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 161F84B15D;
	Wed, 13 Oct 2021 11:58:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 08E4E4B11F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Oct 2021 11:58:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jYpmCeuG2m84 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 13 Oct 2021 11:58:55 -0400 (EDT)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3A1E64B0D9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Oct 2021 11:58:55 -0400 (EDT)
Received: by mail-qv1-f74.google.com with SMTP id
 u9-20020a0cf889000000b003834c01c6e8so2998520qvn.4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 13 Oct 2021 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kINe0IWr90RBHgOAjYvlhVKzPYz79JHCEDd5CCbeejk=;
 b=OsS0vN4gyNtNRBwMG8bFigYCqkq3NooTKR7YjqqinRU1RPJxKLUz47JA1C3v8vh/1I
 yfLpGr6j0uvRc5U+NVL8ceUMekYzc6PXHJPkoBCbo1LcBSWP61RnabYuvsYnc/ELrilQ
 u1wd9tD4HSNnUO/mKylza3pmeVGPserwu8e5b/QisNp5m8+YGH/CKaDdVOS8tLMBDbgt
 MpYKA1gHhlXQUV9f7nJf/mP68j2oIb0ukvdNI9FTnhBF2i3H4OLN/A8vej7da8eZuWaI
 wwUjRR5U0HVYHzA3Xes9MbWGfxBccnUtmJ2XCEdoCqEeznbLJ/RjkfghxkDOCf3POi/I
 wnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kINe0IWr90RBHgOAjYvlhVKzPYz79JHCEDd5CCbeejk=;
 b=cScscXEYL2mqfpXe/r1zSqqFRaXsTx9BEQS9U11mbQqkhstiTeFw6YK4Jsb6Un4/pN
 anuVHYpm/U24N7jW1V1Jzy6VGAi7xJJNGhgHqstKyZTwrxqX3RvyHkNlGibgXVBpwACA
 QNpz9/YlJ06wL3uL6IqKIQ6aqvcTis9iP0sfWrNJwi+9nIzimdkS4QMgwgUw9wUBG5qo
 giszWZKdZpmqUH/r1lrALz4VXwSaS/Dmnjc0XaJXu66BPweT+ZRG/qXYs3qVOvJZ/jc3
 41uR7Z/PpmANOA5My/HmRXStOuq3OyKt3aLpVEuF1BDt4RpFBBr6E3bMzlsHnbUHQ+wz
 zE5w==
X-Gm-Message-State: AOAM531+2suGkwFWOzzcQH0HhsmIey/VbgQN49mBpaol8N7J7mKi2fjy
 eDaj1TqJpb28NNM45s7NmWPsywU2F27W
X-Google-Smtp-Source: ABdhPJzDyz3x0TsxSS86fGtgHfDEAddB8Qdemu3K02NrgNa0NMLZw6aQqeBbr2Pk48QMxkVNxj6evJ7yA3g9
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:65b5:73d3:1558:b9ae])
 (user=qperret job=sendgmr) by 2002:ac8:5994:: with SMTP id
 e20mr43717qte.331.1634140734872; Wed, 13 Oct 2021 08:58:54 -0700 (PDT)
Date: Wed, 13 Oct 2021 16:58:24 +0100
In-Reply-To: <20211013155831.943476-1-qperret@google.com>
Message-Id: <20211013155831.943476-10-qperret@google.com>
Mime-Version: 1.0
References: <20211013155831.943476-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 09/16] KVM: arm64: Hook up ->page_count() for hypervisor
 stage-1 page-table
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Fuad Tabba <tabba@google.com>, David Brazdil <dbrazdil@google.com>
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

From: Will Deacon <will@kernel.org>

kvm_pgtable_hyp_unmap() relies on the ->page_count() function callback
being provided by the memory-management operations for the page-table.

Wire up this callback for the hypervisor stage-1 page-table.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index ad89801dfed7..98b39facae04 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -246,6 +246,7 @@ void __noreturn __pkvm_init_finalise(void)
 		.virt_to_phys	= hyp_virt_to_phys,
 		.get_page	= hpool_get_page,
 		.put_page	= hpool_put_page,
+		.page_count	= hyp_page_count,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
