Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 28F133E48B6
	for <lists+kvmarm@lfdr.de>; Mon,  9 Aug 2021 17:25:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF2644B0FC;
	Mon,  9 Aug 2021 11:25:28 -0400 (EDT)
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
	with ESMTP id sD08vM7m9V7a; Mon,  9 Aug 2021 11:25:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A88294B114;
	Mon,  9 Aug 2021 11:25:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B6D4D4B0FD
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Aug 2021 11:25:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JBYd5TEym99n for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Aug 2021 11:25:25 -0400 (EDT)
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EFB2A4B101
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Aug 2021 11:25:24 -0400 (EDT)
Received: by mail-wm1-f73.google.com with SMTP id
 11-20020a05600c024bb02902e679d663d1so1641655wmj.1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 09 Aug 2021 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=sKHyMUAJ6pCT8dHKiixvyVxL5Tun5Zpw8bNGyjRM47Q=;
 b=bWc7R9nxej9wKPmFw7s2yZ0f0yAf+KeBkNmo6SjyRjbG3l1cLWkJ//rfxcBol1QBM7
 bPkIAEFKVfFoHoK13PoLaqLoJvb6nZ3IXRULnN60HmZseVOfW7IqrDGLo5xPMyCUrFYa
 QNp5B+AsF9CfudlTwOj1BQzPPvVR8mxu0Bizz9YrQIoIl8n/VrGwG34KxyaGSU7CCCg1
 ws45RKPPDGF2xUU2uTgxTbXSiMCwkNafZGCQQq9m57SYZjOC8Q9Sj6QFY5BE4m4nTDdN
 hWUNQ6xQnQ4fYbDe7R/P172LCOSA+nh7JJzs1dGHaL8xRuNJIqL3Qo7NbiHOilWilPRF
 LnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=sKHyMUAJ6pCT8dHKiixvyVxL5Tun5Zpw8bNGyjRM47Q=;
 b=GdBYz+A28UNBE4dXlwEN1NTgXD9TGxU/tu9y3VfGw8wA+/YjBIDAUaAV94YGZP4LaC
 b3RnGOdT0g6hrmPj5ws9CgoM3IaTzba6DpYkWerEBt/NCqlyNa6DOKXkbBs45bhp/tk6
 lboj2RYNcSKvxxKF6SHTHNDhjvAfPtMQPp294eBjSBXHsAHcy2eNsn/4pgoHcAWFqzRZ
 seAh3poJK1s/I+55x6BUSRzdbpRh6I+9H8OTpzJVhcDoUgIvvjgbFNAHv3+MVzwCGVzR
 RkVRIkldvH40Vp4WMbPNzdY/6EEHygLK4D1o7K4KRGtybQvCBnNxiLQSrVikmC5mApu3
 41lA==
X-Gm-Message-State: AOAM53104GocJDJrg3M+euwbSvt7RE6pKpQqG6JnYcSE2Y1d9YzKJ8zE
 K3ioVjXQBjahgtTjCSOIoUfbkUHTaMLl
X-Google-Smtp-Source: ABdhPJwsP/UADjMl4ruQIGRGBcaP9Ad7CMQNtdJiMCBKVwCsIFF2Gv3r4iqTKkuIpNzqlGVjFMa4yXaF8yoo
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:600c:4f46:: with SMTP id
 m6mr17616703wmq.68.1628522724126; Mon, 09 Aug 2021 08:25:24 -0700 (PDT)
Date: Mon,  9 Aug 2021 16:24:42 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-16-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 15/21] KVM: arm64: Introduce addr_is_memory()
From: Quentin Perret <qperret@google.com>
To: maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, 
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc: qwandor@google.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com
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

Introduce a helper usable in nVHE protected mode to check whether a
physical address is in a RAM region or not.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 23316a021880..49db0ec5a606 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -51,6 +51,7 @@ extern const u8 pkvm_hyp_id;
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
+bool addr_is_memory(phys_addr_t phys);
 int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
 int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index ee255171945c..cb023d31666e 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -197,6 +197,13 @@ static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
 	return false;
 }
 
+bool addr_is_memory(phys_addr_t phys)
+{
+	struct kvm_mem_range range;
+
+	return find_mem_range(phys, &range);
+}
+
 static bool range_is_memory(u64 start, u64 end)
 {
 	struct kvm_mem_range r1, r2;
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
