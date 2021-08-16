Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 063173ECBFA
	for <lists+kvmarm@lfdr.de>; Mon, 16 Aug 2021 02:12:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AABE24B103;
	Sun, 15 Aug 2021 20:12:44 -0400 (EDT)
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
	with ESMTP id WNf1yGK-ua5k; Sun, 15 Aug 2021 20:12:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EDCB4B11A;
	Sun, 15 Aug 2021 20:12:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D857B4B0D2
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Aug 2021 20:12:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7lUB4jDKojQH for <kvmarm@lists.cs.columbia.edu>;
 Sun, 15 Aug 2021 20:12:32 -0400 (EDT)
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AF5574B0BF
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Aug 2021 20:12:25 -0400 (EDT)
Received: by mail-io1-f74.google.com with SMTP id
 g14-20020a6be60e000000b005b62a0c2a41so1147548ioh.2
 for <kvmarm@lists.cs.columbia.edu>; Sun, 15 Aug 2021 17:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=E6Kp8VbK7wYZ6N9mrulVFPxuQLG+WCCQs9laQvbnKBA=;
 b=eK7WWUKmJs5BwvM+R2hcGD3Ji+r55jFV4Y/m0xTcQXO98TkC2SBcgDjIkEKOS9I1Dz
 Z+KOH8cQFMH84TGr26zZrToaIDDcz6SXm6LdwgOCkRBlwDQQ5lVdgLyuM5sH5fLSk9fc
 JhMeDb3aUR/SqI4YoPBMrFE4S+q+z+YOsV2INlxYp+KJ0vfmin10q/SkJ/PkzJpd6YF9
 HZXZfIaCHE0BNeGw8ZyDDB0LknniqFmW5oeMGIGzpNd+2D+alqEycIL9pYhyFfyJyI+q
 R19Dnfa2/y4llJ/H8cnGQAjI4S4uO2CP9g91opOsuqp2kVlxEIrFtgU6V7IqCgXM47tr
 unWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=E6Kp8VbK7wYZ6N9mrulVFPxuQLG+WCCQs9laQvbnKBA=;
 b=rz8uXxns6bvT91kEQPnKFDwGweuhEEmA/ib/a6YsO5wDeEaD4u32GlkGQBG4XEC2fS
 DrqyOXrqYDvS1dQhtrCNtnUmaG3+ToZ8+yVlMiRQHtozLdaoGi7lMUktPjPX59RPgqLQ
 oW4C7Wmh5l1YiwJUgfhC2EGVuxbiDec3Zxthasfea3dfncyoXgvcJZJahVP4x+4n0kD0
 ikXc6BZ2PcdnlqwTSXvI9oxskYkyCjpRZ+7oc7M71cFdHAzCAUn7cuY7JVnJnYmS7z3N
 B4PkC//GQOF7L+8Vt0X/VKIKEqJOWaEAvtl95QWx42j4QDLNT3QvWYeon22Rn31on0LO
 5UrQ==
X-Gm-Message-State: AOAM530N9jA34oN7U2XvHS5jqtDNu4ToUSiurA0rll+2gK+kxSewKZi0
 MVtjq4XTWM186hx2xe6BGIEz1cEUn2g=
X-Google-Smtp-Source: ABdhPJxOjPTqr7vVT3cx9Io5XzVFMI5B6VGMeC/E76yIdgKYAKoQGgpGvWdy7jxo2YMnwnmcnxIE8cMv4gU=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6e02:1d1a:: with SMTP id
 i26mr147868ila.96.1629072745284; Sun, 15 Aug 2021 17:12:25 -0700 (PDT)
Date: Mon, 16 Aug 2021 00:12:14 +0000
In-Reply-To: <20210816001217.3063400-1-oupton@google.com>
Message-Id: <20210816001217.3063400-5-oupton@google.com>
Mime-Version: 1.0
References: <20210816001217.3063400-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v7 4/7] arm64: cpufeature: Enumerate support for FEAT_ECV >=
 0x2
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

Introduce a new cpucap to indicate if the system supports full enhanced
counter virtualization (i.e. ID_AA64MMFR0_EL1.ECV>=0x2).

Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/include/asm/sysreg.h |  1 +
 arch/arm64/kernel/cpufeature.c  | 10 ++++++++++
 arch/arm64/tools/cpucaps        |  1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 943d31d92b5b..c7ddf9a71134 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -847,6 +847,7 @@
 #define ID_AA64MMFR0_ASID_SHIFT		4
 #define ID_AA64MMFR0_PARANGE_SHIFT	0
 
+#define ID_AA64MMFR0_ECV_PHYS		0x2
 #define ID_AA64MMFR0_TGRAN4_NI		0xf
 #define ID_AA64MMFR0_TGRAN4_SUPPORTED	0x0
 #define ID_AA64MMFR0_TGRAN64_NI		0xf
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0ead8bfedf20..b44cef8deacc 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2301,6 +2301,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.min_field_value = 1,
 	},
+	{
+		.desc = "Enhanced Counter Virtualization (Physical)",
+		.capability = ARM64_HAS_ECV2,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64MMFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR0_ECV_SHIFT,
+		.matches = has_cpuid_feature,
+		.min_field_value = ID_AA64MMFR0_ECV_PHYS,
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 49305c2e6dfd..f73a30d5fb1c 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -18,6 +18,7 @@ HAS_CRC32
 HAS_DCPODP
 HAS_DCPOP
 HAS_E0PD
+HAS_ECV2
 HAS_EPAN
 HAS_GENERIC_AUTH
 HAS_GENERIC_AUTH_ARCH
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
