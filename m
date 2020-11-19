Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 02BDB2B97C1
	for <lists+kvmarm@lfdr.de>; Thu, 19 Nov 2020 17:25:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA01E4B52A;
	Thu, 19 Nov 2020 11:25:56 -0500 (EST)
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
	with ESMTP id csdUrvspn-0q; Thu, 19 Nov 2020 11:25:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D56A4B2EC;
	Thu, 19 Nov 2020 11:25:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ED94E4B2EC
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 11:25:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dzw-QRqN4WE2 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Nov 2020 11:25:52 -0500 (EST)
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C0934B47B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 11:25:51 -0500 (EST)
Received: by mail-ej1-f66.google.com with SMTP id i19so8729830ejx.9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Nov 2020 08:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hj90LCz0D+DQiieyZ6toGkopYRcCnDLmGJUIDeGa0Ro=;
 b=cjerCYQSC57p+Bb2G3ff0Nn0PFg450gFtjyx3NZBzKsAR7gMmdHvvsG4FqIdx/iKn4
 kXd5blgYmionqHxOpYneiVaatHmPngI7+YQzlp4XdB37ModkveOIq7cfC+ScplzfdFfW
 aFxC01KkfYRrppR4b2m5+csRKOx34cUbLsTN3uYQo+sOQCz7Qevc4p+dN38FjJ29fwZU
 M3zFyvj8FGRBTzXS3ZgIHbXCTJ2eHhCqrqjOh+87TLipwgFUEWF6KwrDBAAts8DJmwd/
 VRBOK/tlrVlGeJ/GexMBc9mY3PRbmDnCcGteZilDTPgnRpkltW5O+2s5wwbcGjOL8e5s
 NhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hj90LCz0D+DQiieyZ6toGkopYRcCnDLmGJUIDeGa0Ro=;
 b=OcfrjPG5VBF4ld7wUZK/lbb5iFroj2FnApcfu4JK2MgrBREDLmMmyRQ5xfuqfgdnUq
 1UGkOkKaIRIeOPBQtcSztfK7RB/vDCSK4/DBSeAZjQbIsKW6VtP3XsGZDHPjfJPh/FL3
 a39bszYdr+V+bbNya5AByN1xuIzW0S19ojG4jNLHh+eC/y994qtoZFKk4tyjwoD5Hrmu
 2sWViih+VudXpAg1z2rnR3sULElURgz3Fc4g2AUqI0/YsN2FyfHKzq3Fw01s6krqZ46j
 msTIM3XiY0cAZrNQs4XFn9L4YPTdvZhpCyNrDwmlOQcAP2vuqw09+Csnngpm9kDnwVns
 D8yQ==
X-Gm-Message-State: AOAM531dUrACX9vksHkofnWH2RgDxIz5fkfBc19IIG/KTqyZM7NeSr7H
 pP5eSvvXWURau7ciECl7zKzTqsDu/Hr3/w==
X-Google-Smtp-Source: ABdhPJy3FuEcXWKGxYGEsU2f9+i0XPWJ/SKtOYB+LMp3R8UV2UUxvy5sHXw+rpJ6SPZ9fF73+2ZgfQ==
X-Received: by 2002:a17:906:85c9:: with SMTP id
 i9mr2600538ejy.487.1605803149723; 
 Thu, 19 Nov 2020 08:25:49 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
 by smtp.gmail.com with ESMTPSA id j6sm15435631edy.87.2020.11.19.08.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2020 08:25:48 -0800 (PST)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [RFC PATCH 1/6] kvm: arm64: Set up .hyp.rodata ELF section
Date: Thu, 19 Nov 2020 16:25:38 +0000
Message-Id: <20201119162543.78001-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119162543.78001-1-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

We will need to recognize pointers in .rodata specific to hyp, so
establish a .hyp.rodata ELF section. Merge it with the existing
.hyp.data..ro_after_init as they are treated the same at runtime.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/sections.h | 2 +-
 arch/arm64/kernel/vmlinux.lds.S   | 7 ++++---
 arch/arm64/kvm/arm.c              | 7 +++----
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S | 1 +
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 8ff579361731..a6f3557d1ab2 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -11,7 +11,7 @@ extern char __alt_instructions[], __alt_instructions_end[];
 extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
-extern char __hyp_data_ro_after_init_start[], __hyp_data_ro_after_init_end[];
+extern char __hyp_rodata_start[], __hyp_rodata_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4382b5d0645d..6f2fd9734d63 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -31,10 +31,11 @@ jiffies = jiffies_64;
 	__stop___kvm_ex_table = .;
 
 #define HYPERVISOR_DATA_SECTIONS				\
-	HYP_SECTION_NAME(.data..ro_after_init) : {		\
-		__hyp_data_ro_after_init_start = .;		\
+	HYP_SECTION_NAME(.rodata) : {				\
+		__hyp_rodata_start = .;				\
 		*(HYP_SECTION_NAME(.data..ro_after_init))	\
-		__hyp_data_ro_after_init_end = .;		\
+		*(HYP_SECTION_NAME(.rodata))			\
+		__hyp_rodata_end = .;				\
 	}
 
 #define HYPERVISOR_PERCPU_SECTION				\
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d6d5211653b7..119c97e8900a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1688,11 +1688,10 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
-	err = create_hyp_mappings(kvm_ksym_ref(__hyp_data_ro_after_init_start),
-				  kvm_ksym_ref(__hyp_data_ro_after_init_end),
-				  PAGE_HYP_RO);
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_rodata_start),
+				  kvm_ksym_ref(__hyp_rodata_end), PAGE_HYP_RO);
 	if (err) {
-		kvm_err("Cannot map .hyp.data..ro_after_init section\n");
+		kvm_err("Cannot map .hyp.rodata section\n");
 		goto out_err;
 	}
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 5d76ff2ba63e..b0789183d49d 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -17,4 +17,5 @@ SECTIONS {
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	}
 	HYP_SECTION(.data..ro_after_init)
+	HYP_SECTION(.rodata)
 }
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
