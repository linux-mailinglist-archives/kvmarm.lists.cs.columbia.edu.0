Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D053833BCD8
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 15:36:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83C624B607;
	Mon, 15 Mar 2021 10:36:04 -0400 (EDT)
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
	with ESMTP id Oq2Z4bfUkcDW; Mon, 15 Mar 2021 10:36:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF1CD4B5AA;
	Mon, 15 Mar 2021 10:36:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C9B34B611
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 10:36:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i1Kf3CxGN+7E for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 10:36:01 -0400 (EDT)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 941AF4B35D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 10:35:59 -0400 (EDT)
Received: by mail-qt1-f202.google.com with SMTP id b18so7496767qte.21
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=5gECdo6+gVpy2qvozqlXR6PUtKBMsle+/Zgc7UvkHv0=;
 b=F6uMc+hMpw4VLGPF9NTRDu+LdGxIDc5HjtcM8WRnxh3ScSrimxPFJ8sROFX45P4pg1
 JmKpv4t3OdhMMD1rD42FdVpY0nEJAoRijZeuc6XU4OQvA59ZyQxfyr0qDRKD/308XlSu
 GtE3wxUSyfb25W4uzOCsrOe5Gz8y99R58gB7S8UUDaBldWuJIXLaBmhNPaJ/vKydMMY8
 zwb7ZyKBCvbdIzU6JlCaKl+MWnelk9vD079p4XknDargVMkyKtys5O6uF8B/DFtO5GoX
 flMCr2I5LT93MAOZ2Tk6x0IVz3I51BnGEi+d4LeZo/e2ZL6cBxPmFQHbgFvYR5rSsdkk
 Cmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=5gECdo6+gVpy2qvozqlXR6PUtKBMsle+/Zgc7UvkHv0=;
 b=hiN/IyLwEsRa+TCasogu9A/wc18JlRCZ3HyicM1Oi8/X09P9BOCH2U3pshWo4CgiNN
 zDFw3M3FtIlWYdRbdsxSBlQKtXeT/+6ThdKscMxBPD0sIPNB+iY2fjTDnKa2frImCBNP
 fDBR8U4LAJayAAm2cmMsS9Qvocw+egllUG23FKwm09sGsFl/5Rh9XuqrY/fqzPgQU7XJ
 eehUf1iBo42GF1sO/1soaEWzbtiIXX5sGPhDlSQZzs7GCcLefH68YK4irfiBmqtQaqK5
 1YNht+A2GilMFD2pSkTsljCmTiWkLehDeBD+52nez+NnwYjvBNd7DEXvfh6fDPic6AsW
 1zQA==
X-Gm-Message-State: AOAM533DzKVLbQeEw8F916lKlvjI6ROxNeKT9s/Wha1M8gv0KtNXcFcl
 aW9YelJJnhgF9DKYs6okjG3qsSEdxnOJ
X-Google-Smtp-Source: ABdhPJzILFMnnIcNzXWLGq9AyilWMOsS/EW0A6wAdtIdRIIp52i92tMZijgx57Eo/Cv4bAqU/TEpxiSbd/MZ
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:5144:: with SMTP id
 g4mr25100542qvq.26.1615818959065; Mon, 15 Mar 2021 07:35:59 -0700 (PDT)
Date: Mon, 15 Mar 2021 14:35:09 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-10-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 09/36] KVM: arm64: Allow using kvm_nvhe_sym() in hyp code
From: Quentin Perret <qperret@google.com>
To: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
Cc: android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, tabba@google.com,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

In order to allow the usage of code shared by the host and the hyp in
static inline library functions, allow the usage of kvm_nvhe_sym() at
EL2 by defaulting to the raw symbol name.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index 78cd77990c9c..b4b3076a76fb 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -10,11 +10,15 @@
 #define __HYP_CONCAT(a, b)	a ## b
 #define HYP_CONCAT(a, b)	__HYP_CONCAT(a, b)
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
  * to separate it from the kernel proper.
  */
 #define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+#else
+#define kvm_nvhe_sym(sym)	sym
+#endif
 
 #ifdef LINKER_SCRIPT
 
-- 
2.31.0.rc2.261.g7f71774620-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
