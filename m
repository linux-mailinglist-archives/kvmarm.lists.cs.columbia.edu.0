Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE5D41497A
	for <lists+kvmarm@lfdr.de>; Wed, 22 Sep 2021 14:47:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF7634A5A0;
	Wed, 22 Sep 2021 08:47:22 -0400 (EDT)
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
	with ESMTP id 6+DWGh5OmdGS; Wed, 22 Sep 2021 08:47:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 965E04B0CB;
	Wed, 22 Sep 2021 08:47:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DEF64A19A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 08:47:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y7y9eLOpSBBc for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Sep 2021 08:47:15 -0400 (EDT)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9ED804B0AC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 08:47:15 -0400 (EDT)
Received: by mail-qt1-f202.google.com with SMTP id
 z16-20020ac86b90000000b0029eec160182so8945104qts.9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Sep 2021 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=vKd/FRP6xsxd1NyZwlcpU67d7iFrsPIxsqbAVx8bTdw=;
 b=aoIrsXHec9SBUmB+2mcUIKsJUltZUnhZAmwED91yXvPDDH0hn387xceQEQTJMcldNT
 2/Yjz04rygS5eguuM37aCW/UMofNUEYKQKeP2SjXwr08kQ3ncvFkQ5JQeH41ty2yU46R
 rGtvzSwn4DeRWawKnVMIpy436eIkv1KWDE4Y62bEBmV6HAL1e1Kel099zJP8AIObK+d6
 Xi0nagwlCUrhFZ7EW0HgoNJgH32UGaxb+pykycp/hk/wSSAVzoulC84CUgvvOLjgCr4a
 0zSLJuvf+ceTqnNHfqlUoL/CBh9gJXMITqMt58WAlHud/B13nefjnyxrAdFViTNlC9g/
 C8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=vKd/FRP6xsxd1NyZwlcpU67d7iFrsPIxsqbAVx8bTdw=;
 b=zD3rHatcfZZ2KrBPazSWPjLvml3tRFLaeJpo04vNU+pACkveeUdQZZVrk3LHYCQu0C
 ktgSzpSr38CbyNwerSkadcT1tWNGPZ5uQ6TrwrYkje5aN/g1ViSgbEDIl521MEQvHY+j
 XM1czIMtGtwX5QWgY3/ZrbKWZPk49oNeowsjIR/c5rUGcsXA3AHUaxKSVx4YL7JXzoh/
 ik5LEsA/gfH15XMW0fXb1UfI/b978GbkEWz+lsdX9Jhr99ANd8LZa7eg/p9At8PvjXGk
 b2Irn0oIsBw17Dx67jC75kkZ8d3KPJyfrfmDGK6SVb0St8gF/tpk6VBjneeaMvsuuvtE
 gPdw==
X-Gm-Message-State: AOAM530sMQP0v9iednr+3o8qMkRXARe2kBSbAr5fTJO9QzZc3eT54zF1
 GuPc+IKU33O+Y+geZZyAhQR3Qo/+xJ4J6a77QtV9KeDXcOfv7vKoAS23K+UyvpJDlMlzq+WSmdp
 bHtYMD/rMd06ZY+vb2yd694xhcFSkBv7NQvtKyZUEd3zoD6nHECjqdnGlAXaFYz5xMlQ=
X-Google-Smtp-Source: ABdhPJxK+J/4nEIn+GrBuqd/cPmlWnyMGlRJcdSlgCB8WvLAhxMnGsnFlZ1r4pp0DunJBFb+U7LxVLudDA==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:ad4:55b3:: with SMTP id
 f19mr36952746qvx.16.1632314835185; 
 Wed, 22 Sep 2021 05:47:15 -0700 (PDT)
Date: Wed, 22 Sep 2021 13:46:56 +0100
In-Reply-To: <20210922124704.600087-1-tabba@google.com>
Message-Id: <20210922124704.600087-5-tabba@google.com>
Mime-Version: 1.0
References: <20210922124704.600087-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v6 04/12] KVM: arm64: Add missing FORCE prerequisite in
 Makefile
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

Add missing FORCE prerequisite for hyp relocation target.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 5df6193fc430..8d741f71377f 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -54,7 +54,7 @@ $(obj)/kvm_nvhe.tmp.o: $(obj)/hyp.lds $(addprefix $(obj)/,$(hyp-obj)) FORCE
 #    runtime. Because the hypervisor is part of the kernel binary, relocations
 #    produce a kernel VA. We enumerate relocations targeting hyp at build time
 #    and convert the kernel VAs at those positions to hyp VAs.
-$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel
+$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel FORCE
 	$(call if_changed,hyprel)
 
 # 5) Compile hyp-reloc.S and link it into the existing partially linked object.
-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
