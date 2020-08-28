Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA40255B9F
	for <lists+kvmarm@lfdr.de>; Fri, 28 Aug 2020 15:53:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B42044C29D;
	Fri, 28 Aug 2020 09:53:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tIPHCdHtSChM; Fri, 28 Aug 2020 09:53:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A51B64C2B1;
	Fri, 28 Aug 2020 09:53:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80F674C1EF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Aug 2020 09:40:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-spUA2jDA+Q for <kvmarm@lists.cs.columbia.edu>;
 Fri, 28 Aug 2020 09:40:22 -0400 (EDT)
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 823DB4C1FF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Aug 2020 09:40:22 -0400 (EDT)
Received: by mail-pf1-f194.google.com with SMTP id 17so675912pfw.9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 28 Aug 2020 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FG3XCoXB/aty+ooJaX6AfmzW3u7+uhF6LOoAHszXFMo=;
 b=klaFOwH0ElHAR7McpnZD67Y7Y2E4ysRVd65Eh0X8Xr9Z5ZyWbIBjWtyCrwOB4Od/DA
 XRJMjfQSPlBZrjbgkR+aWt+dMTPdm3RfYYKFYmMffLNpvXiND2Idjh7oautoaA2MYL+q
 /aMHMhbMTXmSQQM3HOmFP7V4IB7vdF95uncZUymzdTq0dWQt129AmStxuUL6cEE+bT4X
 ToHwNGA6N4Gj9pNw6HzkGUknEsJK+o2/5MFoKW275e2o2HRQHyMHs2gDiU2W4mbgmwCP
 XasIdGHL8WGH0oaEbsJ7Xh/05/Dwf1tS5KwbhE/Qhy1BOMowRz0YOo1D2uxsKLKSaOvR
 A8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FG3XCoXB/aty+ooJaX6AfmzW3u7+uhF6LOoAHszXFMo=;
 b=Mx8I8v/nFR1uTJueoFi/L6pgHMirfi3j42wzBMrPHGlSOEYbBAyPxJt9IAbMRHGafv
 DIe4YyzbPrxzYSDdiObm8lADgVR5sGic4Uc1ZgyyP3YP21DybZ0+qvLfOBr9c/UQnkgV
 FJer+KkKvYveT9qT4Q6B/LLHnLfrmOwKxszYSxjQFz2TrQ8k43sLPepPD2gZK+HDqxCB
 2cEyQuzCS3ezNn1BKfk8aTBwhV8dPhqht4ybp+PxhKRkGKGiRdP/pY+bsxsiexJxlIyM
 L/cBk8IiOuKA7TbJedgNm0f3Lqnae0n4OIZIjPIhlNaf+TzwKJygFdzxAhsji5kgvz+0
 CYDA==
X-Gm-Message-State: AOAM531Jo+GoP8c1oBGl7UekOins/u81Srs2oeiivQz7ILjDZ/wJh/QZ
 /U8E6gWiOsZD1kI8k710mg==
X-Google-Smtp-Source: ABdhPJwM7vdnpfEicNNMs9GsRsbhv34l6T2Wg0n67dn0Hmq86jCu4vPZ+wdNmQARVjSSpiwV50Risw==
X-Received: by 2002:a63:b10a:: with SMTP id r10mr1314017pgf.431.1598622021821; 
 Fri, 28 Aug 2020 06:40:21 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k1sm1806559pfp.86.2020.08.28.06.40.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Aug 2020 06:40:21 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 2/2] Documentation/kvm/arm: improve description of
 HVC_SOFT_RESTART
Date: Fri, 28 Aug 2020 21:39:58 +0800
Message-Id: <1598621998-20563-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1598621998-20563-1-git-send-email-kernelfans@gmail.com>
References: <1598621998-20563-1-git-send-email-kernelfans@gmail.com>
X-Mailman-Approved-At: Fri, 28 Aug 2020 09:53:13 -0400
Cc: Geoff Levand <geoff@infradead.org>, Marc Zyngier <maz@kernel.org>,
 linux-doc@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Besides disabling MMU, HVC_SOFT_RESTART also clears I+D bits. These behaviors
are what kexec-reboot expects, so describe it more precisely.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-doc@vger.kernel.org
Cc: kvmarm@lists.cs.columbia.edu
To: linux-arm-kernel@lists.infradead.org
---
 Documentation/virt/kvm/arm/hyp-abi.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/arm/hyp-abi.rst b/Documentation/virt/kvm/arm/hyp-abi.rst
index d9eba93..83cadd8 100644
--- a/Documentation/virt/kvm/arm/hyp-abi.rst
+++ b/Documentation/virt/kvm/arm/hyp-abi.rst
@@ -54,9 +54,9 @@ these functions (see arch/arm{,64}/include/asm/virt.h):
     x3 = x1's value when entering the next payload (arm64)
     x4 = x2's value when entering the next payload (arm64)
 
-  Mask all exceptions, disable the MMU, move the arguments into place
-  (arm64 only), and jump to the restart address while at HYP/EL2. This
-  hypercall is not expected to return to its caller.
+  Mask all exceptions, disable the MMU, clear I+D bits, move the arguments
+  into place (arm64 only), and jump to the restart address while at HYP/EL2.
+  This hypercall is not expected to return to its caller.
 
 Any other value of r0/x0 triggers a hypervisor-specific handling,
 which is not documented here.
-- 
2.7.5

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
