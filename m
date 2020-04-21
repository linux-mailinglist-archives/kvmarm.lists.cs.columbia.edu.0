Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 48A231B2767
	for <lists+kvmarm@lfdr.de>; Tue, 21 Apr 2020 15:17:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EE1F34B144;
	Tue, 21 Apr 2020 09:17:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LWyd6Zv1NH+a; Tue, 21 Apr 2020 09:17:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1683E4B15B;
	Tue, 21 Apr 2020 09:17:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E921E4B158
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Apr 2020 09:17:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fl-zPrlVm3U0 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Apr 2020 09:17:44 -0400 (EDT)
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F31164B163
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Apr 2020 09:17:43 -0400 (EDT)
Received: by mail-wr1-f73.google.com with SMTP id d17so7443626wrr.17
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Apr 2020 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=lwK0HdAJdCKsbxnoCrxZknk0C/E2z7FpFXV4+k1wMX8=;
 b=YyumhIFeoqK4JFM+AVVTuuutQYDkQsUSYznTMn671WlhCCm9JOA7SuPyKfuMyMgVu0
 Mtvl2O0USLrMYPMoWgeayNuoNeTNZA+vTrdLxmbDHEXKsI8BFnNuxZObjnYng+jY6O4V
 /3tfi3+9a2NLr2maKY1nBTH5rsrsvilRX8Jqd/JV3SaEj+6VK5I0vFOBTb1AxrjNx32Z
 Ra5CoxgR+knA16A1gUjgaHa6QmPoof5nmbw2KseaTYzBB6n1oAVtvaiOCEKI9c4s8wDz
 Na5YzfjQlt3eNutcUaG7oDSY8M9Amq8Ze6Phrxv0W/5aY+yu1OQiNBT6Qs4QAH8fxJ2a
 0Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=lwK0HdAJdCKsbxnoCrxZknk0C/E2z7FpFXV4+k1wMX8=;
 b=eBGTRm7KfkSlMyLpN2xuhvKES0zyUADek4S8J3lQn/i779wfBIgx/6u2pvfpIEgC0b
 QEfw7UWdUM/ridHPIPjlAekSs4MpX9UUEgFRKtK2qope361m3ZPidkPgWx9ztYzaokxX
 38r+70CyBshhIrHa9ocTLKuKTcVI9CwM1pae9X2ecUGJKolIKInxuQjrZzE79cVpF17q
 jSAVXofYSNupVayIbSFvcB7uCPKhpORf3Z61fwtBnt9KcZcaicUG0nFmV9ltd9oSUH3V
 yJj8AJ+qgkTISpzR++KGY8/TcOBQ53/1iKlo0jx/SqkSo9ATuwa6O1YHi/inKp/QoYOv
 BnzQ==
X-Gm-Message-State: AGi0PubrW4OGHBt9D9uLDhm2/s4YeQ5UUNoAW40FGXkw+hzPXNkFgkVo
 Z1AVHCdzrjugQ3eOMfbLQOrqOdlZBQ==
X-Google-Smtp-Source: APiQypLp+kRoY/GbH4V6p/Q8y7Z8IybWiVcg3RzBNTi50xA9KN1ZS23YolzhSoZBf9XS0NXIPIa73SMKAA==
X-Received: by 2002:adf:e88d:: with SMTP id d13mr23249297wrm.375.1587475062991; 
 Tue, 21 Apr 2020 06:17:42 -0700 (PDT)
Date: Tue, 21 Apr 2020 14:17:32 +0100
In-Reply-To: <20200421131734.141766-1-tabba@google.com>
Message-Id: <20200421131734.141766-3-tabba@google.com>
Mime-Version: 1.0
References: <20200421131734.141766-1-tabba@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v4 2/4] KVM: arm64: Update help text
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, catalin.marinas@arm.com, julien.thierry.kdev@gmail.com, 
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu
Cc: will@kernel.org
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

arm64 KVM supports 16k pages since 02e0b7600f83
("arm64: kvm: Add support for 16K pages"), so update the Kconfig help
text accordingly.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index ce724e526689..d2cf4f099454 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -44,8 +44,6 @@ config KVM
 	select TASK_DELAY_ACCT
 	---help---
 	  Support hosting virtualized guest machines.
-	  We don't support KVM with 16K page tables yet, due to the multiple
-	  levels of fake page tables.
 
 	  If unsure, say N.
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
