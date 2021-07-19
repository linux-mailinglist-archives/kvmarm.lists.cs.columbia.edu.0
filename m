Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5DF3CE082
	for <lists+kvmarm@lfdr.de>; Mon, 19 Jul 2021 18:03:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D537C4B0B3;
	Mon, 19 Jul 2021 12:03:57 -0400 (EDT)
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
	with ESMTP id A5yzQV+mLsK5; Mon, 19 Jul 2021 12:03:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BC4FA4B081;
	Mon, 19 Jul 2021 12:03:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8333C49FB7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 12:03:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ErPVozq3wo-w for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Jul 2021 12:03:53 -0400 (EDT)
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9A80C4A5A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 12:03:53 -0400 (EDT)
Received: by mail-wm1-f73.google.com with SMTP id
 v25-20020a1cf7190000b0290197a4be97b7so164657wmh.9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=zOaafQqyYiyHibWQyje/Aynnw7U7p4mRVaT60bMRHgo=;
 b=nWlb7jQnf7aLbh5SVAzsTk/wgS94APyUEE+NCtodxaQ41ISqv64Pg4TTOdKa31klUM
 2IFPHGIdLyBb1r/924z1/CVUfJ6Gbh9MyThu10slfEElIanSTaK2Xrvme76pgvmbSFCH
 N5nni3DLR4raUtJ524bPh8IxjbJL+3zBUV2mUbvmiWkw5MAmQuE1OaDOKDIh57Knac5k
 ft7C1wO51OpA4Fbmn8A5ZC5EVkDZqaUXb7cLz0/gmcHieLgWkokq9ChNC4M8t8wtaMzp
 DjWp23vlGA2BSdE5f7Ci94dCtmP8KdhytQACldFy38d2towoK/fUUMqNhfVSX0RwLwHW
 AmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=zOaafQqyYiyHibWQyje/Aynnw7U7p4mRVaT60bMRHgo=;
 b=Tu/kxIKfgY3KfA5LX20YzD6PPWkc6cK0KzGER4dZXlIiNd2uMpvj6MKPnMa+Tyc11a
 Zf0nqZfMq7hcEzHaFRcX6fP/C8UR2fPdWKMm2xU+qQvwWDviwd/ofg2C12Ha9L6bhB7w
 tMwhxI88e0TEE9Lbm0VgB9T012zcdDB5GaS877z8osYjPGaFMsU9H3du3KL/5DlcJX5y
 ykEryrkTcsWCFLmDGhULdJ4xe3qq2/4sKCcEFdf53C3QEDb69xrMK2etkEJWdwnEPV7F
 +v/CT7XL0s87W8dOh9gHJ5A7q7ZNzgKoQ00p7H8YIobo2oXMEHvF7QhFKoyruUvXSGyA
 KnxA==
X-Gm-Message-State: AOAM531LFnnPRB8UADDqKLcgr8G7oGE8QRJjsZa0DOKz8x59+5Djbtde
 GA32/3Nl7xgduK9IrC8rWJrqlV8Or7gXbbKohCM4D0iFQ4xsjYAIbqqVl6+gyh/0jupUp1RSmDq
 jGN2hpoVHNmKdC0fe8VY2rRnW04olmFlqxQbbhHBL/28IZGd5ka4qZMyQ5cA79rDj5Nk=
X-Google-Smtp-Source: ABdhPJzgAMHslu1b44ODrq5vEN3TN0CYJuhq+aKYnb5flV5+UR/uab1rElFZAm5fgeicP7WXI7gWQnwCFw==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a7b:c083:: with SMTP id
 r3mr26930447wmh.97.1626710632666; 
 Mon, 19 Jul 2021 09:03:52 -0700 (PDT)
Date: Mon, 19 Jul 2021 17:03:33 +0100
In-Reply-To: <20210719160346.609914-1-tabba@google.com>
Message-Id: <20210719160346.609914-3-tabba@google.com>
Mime-Version: 1.0
References: <20210719160346.609914-1-tabba@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v3 02/15] KVM: arm64: Remove trailing whitespace in comment
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Remove trailing whitespace from comment in trap_dbgauthstatus_el1().

No functional change intended.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/sys_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f6f126eb6ac1..80a6e41cadad 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -318,14 +318,14 @@ static bool trap_dbgauthstatus_el1(struct kvm_vcpu *vcpu,
 /*
  * We want to avoid world-switching all the DBG registers all the
  * time:
- * 
+ *
  * - If we've touched any debug register, it is likely that we're
  *   going to touch more of them. It then makes sense to disable the
  *   traps and start doing the save/restore dance
  * - If debug is active (DBG_MDSCR_KDE or DBG_MDSCR_MDE set), it is
  *   then mandatory to save/restore the registers, as the guest
  *   depends on them.
- * 
+ *
  * For this, we use a DIRTY bit, indicating the guest has modified the
  * debug registers, used as follow:
  *
-- 
2.32.0.402.g57bb445576-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
