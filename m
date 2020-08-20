Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AE80224B65A
	for <lists+kvmarm@lfdr.de>; Thu, 20 Aug 2020 12:35:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 614E54B880;
	Thu, 20 Aug 2020 06:35:40 -0400 (EDT)
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
	with ESMTP id 9bPm4o+dw3YX; Thu, 20 Aug 2020 06:35:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3CC2D4B83E;
	Thu, 20 Aug 2020 06:35:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CCD944B888
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Aug 2020 06:35:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zR3AhiA885Yf for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Aug 2020 06:35:37 -0400 (EDT)
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9EF2B4B83E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Aug 2020 06:35:36 -0400 (EDT)
Received: by mail-wm1-f74.google.com with SMTP id d22so636095wmd.2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Aug 2020 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=/QX7EylRJ/FExG7A40+IjYbpo4wIFPAOSGmhSNIkFzQ=;
 b=IHhApn87zJAR0+Rthp+j95Ysv1+rnywvTokZnmx5mS5byQB5tQxxDsWwoYVP+gaKEW
 71Hp7fBOd9rA26IKAxO/yyNGVP+vYsqVLnRlrkk07SWYaFI+mJQWx1RX1sCPCZ32zkND
 gzpoXbdknmPOjj7K9i1YmjSac0jE6klUEMy7NP/QSCe6pwftEpxzN1+wnBR1lLRbcIPa
 KWlL0hBPvAH96noxP47gSGlvos2QhiC/vyZD07hWYzHWZdV2DFPrfD/naCD6Jv1n+2t7
 dk9J0QgazEUaOHGhibDqDKqMjiqxI9BmdrCgKbDMasb/j71Sw3qS/F7OpdzkqOyeUdDX
 RU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/QX7EylRJ/FExG7A40+IjYbpo4wIFPAOSGmhSNIkFzQ=;
 b=Lesa8gDaZLCuo4U4PR6bjR+HOTSppMqvFxdE3V4CLPSwSHfgu7Y4dTc16ssmZaO1N2
 KvwTTFFoBFY1ZhGxg97COWNiqOaHIApkwheyic0Re9PPH/Z1hrIafg8HcBR6u+rvKmin
 Z3NpkHzsIOIdgl5c+/XzBR/6ZVKV6gXewkESuTrrB0yC2fDfCkYkHNoTfbQpxDnm0Xqt
 HLdK7VIKsc8/qEJz9ntME8/WVQov7PyrYy4j7yuM6pkBwGUguG9eL2djcmWQBi2ts4g9
 dK/zlJyIGEkpsvsizo1e5ams0bzv4y+RBeu/HTdx8MDmhqL4nkiDLaWFnst4L1A77hr5
 Dwkw==
X-Gm-Message-State: AOAM5306cUlDSvTUPa8X+09djDvx0ZYjc0VE8g1NS6DjXtSFHwy1LSJD
 X6oz4Y/fohTSqsXzlRvJg+ifWvwQReSJXCOeultYMlC9rxz/3odVEN4eZuy6vnnnwitRYPmZKVd
 6waufUGMl88LYl+AgH3cd32+7V0FUYQOMnq2rPw/GackzMvcd4zdHpx/yG45CljMQeYfC+g==
X-Google-Smtp-Source: ABdhPJzg3Plo66Qc18GYT6LlmTM0ZH2VCTtKR3/KsvG5ZrhyMpf4Y2VYjscneeGBFSBzxXgBGoPlI94x6O8=
X-Received: from ascull.lon.corp.google.com
 ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
 (user=ascull job=sendgmr) by 2002:a5d:540c:: with SMTP id
 g12mr2528159wrv.120.1597919735573; 
 Thu, 20 Aug 2020 03:35:35 -0700 (PDT)
Date: Thu, 20 Aug 2020 11:34:33 +0100
In-Reply-To: <20200820103446.959000-1-ascull@google.com>
Message-Id: <20200820103446.959000-8-ascull@google.com>
Mime-Version: 1.0
References: <20200820103446.959000-1-ascull@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 07/20] KVM: arm64: nVHE: Don't consume host SErrors with ESB
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 maz@kernel.org, Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
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

The ESB at the start of the host vector may cause SErrors to be consumed
to DISR_EL1. However, this is not checked for the host so the SError
could go unhandled.

Remove the ESB so that SErrors are not consumed but are instead left
pending for the host to consume. __guest_enter already defers entry into
a guest if there are any SErrors pending.

Fixes: 0e5b9c085dce ("KVM: arm64: Consume pending SError as early as possible")
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 9c96b9a3b71d..5a7380c342c8 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -24,7 +24,6 @@ SYM_FUNC_END(__hyp_do_panic)
 
 .macro valid_host_el1_sync_vect
 	.align 7
-	esb
 	stp	x0, x1, [sp, #-16]!
 
 	mrs	x0, esr_el2
@@ -77,6 +76,11 @@ SYM_FUNC_END(__hyp_do_panic)
 .endm
 
 /*
+ * The host vector does not use an ESB instruction in order to avoid consuming
+ * SErrors that should only be consumed by the host. Guest entry is deferred by
+ * __guest_enter if there are any pending asynchronous exceptions so hyp will
+ * always return to the host without having consumerd host SErrors.
+ *
  * CONFIG_KVM_INDIRECT_VECTORS is not applied to the host vector because the
  * host already knows the address of hyp by virtue of loading it there.
  */
-- 
2.28.0.220.ged08abb693-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
