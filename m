Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7539F576
	for <lists+kvmarm@lfdr.de>; Tue,  8 Jun 2021 13:45:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8B4B4A003;
	Tue,  8 Jun 2021 07:45:53 -0400 (EDT)
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
	with ESMTP id pVvyLHvcMKQG; Tue,  8 Jun 2021 07:45:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A39C040D0A;
	Tue,  8 Jun 2021 07:45:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3717340016
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Jun 2021 07:45:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rkkVJAE4KB3K for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Jun 2021 07:45:45 -0400 (EDT)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E3FC940874
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Jun 2021 07:45:39 -0400 (EDT)
Received: by mail-qk1-f202.google.com with SMTP id
 n3-20020a378b030000b02903a624ca95adso14793626qkd.17
 for <kvmarm@lists.cs.columbia.edu>; Tue, 08 Jun 2021 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Ht6ZsPME0dKrsaoX0sOEJfkD40JHGHh+tjBgtM1a8+s=;
 b=Qo1Sme4AtGquqBbZ3++fnxMhekv/Q/MZQsj0pdKrYdhOBKiGTd8NVlwwFib6WIoU58
 F/EuzAQZ227O9LOmq4TCiKU/lJ8OrmXe6Y0du8LPrkFaVPb0SGCrPQJv74dFr1t0hqw8
 fy3V1IQhwl0eJmdKIpBflmQh37xHque8Fsm6v0wEp/y/OgDqet2jyq2u4FWH0X8QyMPE
 8EBHAgM2ApfYABHvqv9V/vrHhpzSbPnhcEwwZjjctlPFZTxsppMlccDEn5h8VEiJGS/5
 JaBuvCt6pEeETZ4wx1vNc3NkTiRSK/5Rul/LHPAj4crdEwXvDQar9+UrZw0QonuKMKSv
 EAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Ht6ZsPME0dKrsaoX0sOEJfkD40JHGHh+tjBgtM1a8+s=;
 b=KS8CIzw+aOJKfc1ClNfH+/C1BTdOgxkYpcMPGohPeRNx2BiFjyAleLDkHeY15HNDM2
 wDrmyvY6ODmLduz55ydFLKoOUC2qjGoTJ/i6PMa8XY+bIRBrkOTsIk1JkwxxgPkfUgWZ
 V7Dfc0FEJ6NOkdRIXVPhkVpEXQoLNalmKuSpUXfQ4YL9Vi36Wocbr2P92yhjESiuRA0o
 NJEVC49Q9ZBjJPGBewlA2NsLt+U+sbmoVJW5oLUQbassMZBLO1Pp7AaphvFxRpkqM19l
 ga9fZEDZ3YkcNW3iiKjoF1xLQHYQp767hgj5vYOOOC8VsnqByUxJsYQ7EKSjC2BcXmPn
 NB+g==
X-Gm-Message-State: AOAM532pxHmabWO8s3N+viORZlKByGtz2FwqwdcXq0kw4Tl91GqjfB0g
 JOQwDQw5qqR+ub6r++3wk+lFSgWleT1d
X-Google-Smtp-Source: ABdhPJwKoD8tOLvO/LYUpyfEnSdl9NSUO/u5qM43SN4f3kxfrNxeCZtg5Givdh9sHlYANNlP3HYBgBNwoPfX
X-Received: from r2d2-qp.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:4241:: with SMTP id
 l1mr22892455qvq.2.1623152739555; Tue, 08 Jun 2021 04:45:39 -0700 (PDT)
Date: Tue,  8 Jun 2021 11:45:18 +0000
In-Reply-To: <20210608114518.748712-1-qperret@google.com>
Message-Id: <20210608114518.748712-8-qperret@google.com>
Mime-Version: 1.0
References: <20210608114518.748712-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 7/7] KVM: arm64: Use less bits for hyp_page refcount
From: Quentin Perret <qperret@google.com>
To: maz@kernel.org, will@kernel.org, james.morse@arm.com, 
 alexandru.elisei@arm.com, catalin.marinas@arm.com, suzuki.poulose@arm.com
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

The hyp_page refcount is currently encoded on 4 bytes even though we
never need to count that many objects in a page. Make it 2 bytes to save
some space in the vmemmap.

As overflows are more likely to happen as well, make sure to catch those
with a BUG in the increment function.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/memory.h | 2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 3fe34fa30ea4..592b7edb3edb 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 
 struct hyp_page {
-	unsigned int refcount;
+	unsigned short refcount;
 	unsigned short order;
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index be07055bbc10..41fc25bdfb34 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -146,6 +146,7 @@ static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
 
 static inline void hyp_page_ref_inc(struct hyp_page *p)
 {
+	BUG_ON(p->refcount == USHRT_MAX);
 	p->refcount++;
 }
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
