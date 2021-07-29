Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84E3DA425
	for <lists+kvmarm@lfdr.de>; Thu, 29 Jul 2021 15:28:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FDB24B0CC;
	Thu, 29 Jul 2021 09:28:45 -0400 (EDT)
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
	with ESMTP id rAdoSQ6VXwF4; Thu, 29 Jul 2021 09:28:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 91E304B0F4;
	Thu, 29 Jul 2021 09:28:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 277B64B0E8
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 09:28:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vIF4O16iJeke for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Jul 2021 09:28:42 -0400 (EDT)
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 35F1A4B0EF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 09:28:42 -0400 (EDT)
Received: by mail-wm1-f73.google.com with SMTP id
 d72-20020a1c1d4b0000b029025164ff3ebfso2176737wmd.7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Jul 2021 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=sBorrifANrV+vpyuatLE9LgyQ9DNiLt3tvLMqd3Pt6A=;
 b=Ut7XM1RBkTI6hICybPUi8KmJxYV9LDmJ+BO6n904mN06Lz6fMB/V/BtKm6hhsuLfZP
 ivNztgGio4ESMLW5q3gVJgBLVveqCae0u3Cf+OKFjx6mnhwTYrhUTBdFbeTTJYOH2Oro
 egeF+yk4HTHuh6YDWWxQ/DlmPg6CLxqWIwkzudNjJzvZNRClSc0OkY+jbq0xqXUU/AJb
 ej+MxueBK07NIyaNgEDhpAQ0F2nwLtPwY0F0IGWM8mD7iwJf9+lNClSNk/EMPe/lAOyx
 FXnhesCTlFKoKTNCnkpafZ7MinyOF/hCThP8HikLHozvU5iFs+Dhw8yEZKqnOzO+cPPS
 ViCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=sBorrifANrV+vpyuatLE9LgyQ9DNiLt3tvLMqd3Pt6A=;
 b=aaNt2DdStUdXoyNM09yRVeyAsS0mVvHvSedBYtv84qrlOwBU26q31kyBOXtpiYXyBI
 P/UD48dB/nmLqOhFXYMhptarkEHzT/33vGb41OTIZU9kGyMX//H/H8Q2ab+0KvOeOenP
 AbUs4TK+SGlHYPvX1aPBsg9//O+5vH+EJSrsrCkuCssXoKuAoUaEg1fwIrBs9vjFdepf
 Ddw3z97IiTmmVI+ZaSXhk0i819vutTtG1N/B+mucT4bbAFcxvMRqSYxiquSMu1wh0Nhw
 TsoC7EpIpjknrfi2JUXMpatKqGOM7cQyyPTASNQ8GbseieMyuuqoKjGzEdV+FJDlmDz3
 Tg5A==
X-Gm-Message-State: AOAM533ANTq1l8xnAzQ/JVVdSpZAE9W/B9kJz/O6xVqcXj5Gn/xeuZ5x
 eulTicmt8BS/TOHsx/CQqjMamRG+RZtB
X-Google-Smtp-Source: ABdhPJwtD68LvsEqvJLyJ+xAUhNDPqjLqDqVmLSO3BaeBLQNVsxniunIN5iAoYlgcySpAt9xikvTGJBkyHkY
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a1c:980e:: with SMTP id
 a14mr4764799wme.123.1627565321434; Thu, 29 Jul 2021 06:28:41 -0700 (PDT)
Date: Thu, 29 Jul 2021 14:28:05 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-9-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 08/21] KVM: arm64: Don't overwrite software bits with owner
 id
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

We will soon start annotating page-tables with new flags to track shared
pages and such, and we will do so in valid mappings using software bits
in the PTEs, as provided by the architecture. However, it is possible
that we will need to use those flags to annotate invalid mappings as
well in the future, similar to what we do to track page ownership in the
host stage-2.

In order to facilitate the annotation of invalid mappings with such
flags, it would be preferable to re-use the same bits as for valid
mappings (bits [58-55]), but these are currently used for ownership
encoding. Since we have plenty of bits left to use in invalid
mappings, move the ownership bits further down the PTE to avoid the
conflict.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 59a394d82de3..1ee1168ac32d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -46,7 +46,7 @@
 					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
 					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
 
-#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(63, 56)
+#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
 #define KVM_MAX_OWNER_ID		1
 
 struct kvm_pgtable_walk_data {
-- 
2.32.0.432.gabb21c7263-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
