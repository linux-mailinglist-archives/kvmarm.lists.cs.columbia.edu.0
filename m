Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CE43340BB89
	for <lists+kvmarm@lfdr.de>; Wed, 15 Sep 2021 00:31:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 814C54B127;
	Tue, 14 Sep 2021 18:31:47 -0400 (EDT)
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
	with ESMTP id K9W4beVFzpOl; Tue, 14 Sep 2021 18:31:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD9814B14D;
	Tue, 14 Sep 2021 18:31:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 418E04B118
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 18:31:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9QeCWjdYP3PV for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Sep 2021 18:31:43 -0400 (EDT)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 427964B0DD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 18:31:43 -0400 (EDT)
Received: by mail-pj1-f74.google.com with SMTP id
 e91-20020a17090a6fe400b0019987f5a6f7so2676870pjk.1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Sep 2021 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=wauNwIwmja2q2Jg5bPFVhyVB/9NFZO9dAmOByqwKIHE=;
 b=GxzJdEKoi4NpRi08FJiVjpv24DdGyPJUWcN9gW/uSdAhLxMXXuhGlshuhdAsJd+XCH
 C1RUeXk46jm2J3liTO0ZWgSU4wk16C4LWyjvtoxQSK96FEpWoMuuSpCQ6isi86tGeho5
 icu9UaD+sm3/wKOkzhwl0tju2R7f6yqM4P+yRI2lQDh7mWSd4FDAfeSTJC6ncz9K9pk3
 7aOlXYiEj7dmRldEnnLZQytgtEk4nLw8iTNyN9bAvmfkzSvMqqqwfgScuRYEK3S65cYH
 +IRTfdqQ+l0DdJ7RJ0cp38Quez2Ux0KsGHpD64jaUFzwPVC0jHxDGjKCAwWA1M2pbdKt
 hvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wauNwIwmja2q2Jg5bPFVhyVB/9NFZO9dAmOByqwKIHE=;
 b=wvUJx6H0siyxi0n/Vrgt+T//mKhzO+0r6KUFDo270WdN0owxAIionYmgxTtFS2CWcB
 xuclUoyrVtk66ld5VGxMTOnoPIy9zbt63u9cPwJMCrqf17rIDZVWMjuK1J0ChIxrv3/5
 bCknMes4oukBqsJcPTbTwSEzGQwOkluD8ErwJCJeUIiC67amEamPseYI4kSfOdEPjdUS
 yNdIc5AjHQdgqlHyvgkwqMCwexUlOTxcVbeItb8kt/2NQtOGAjGb3Cl39L7izQZN4WdM
 2vNUC++ZOmpqyk6dVdZhkXAM1C3tt8bQbRPo0XyTM5LZf6S1HYobdK4iV+0NDt3DInWs
 J2cQ==
X-Gm-Message-State: AOAM532qpqFLH8Tecp97hJ0CZZX4xKyeCcjHdhV8tL+dUDJrXBc6Unjt
 sGf8Eus8r1AIrwRNZItGxpAkw2M9NUJ7
X-Google-Smtp-Source: ABdhPJwraibtgDwt+aMWBczNgOCVVTCAtCVQFbLYOLSXu8hvCj2vOUYR+M2U4dlOaah4JO7ydfm+C8fxPZ30
X-Received: from rananta-virt.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90b:3909:: with SMTP id
 ob9mr663472pjb.151.1631658702532; Tue, 14 Sep 2021 15:31:42 -0700 (PDT)
Date: Tue, 14 Sep 2021 22:31:08 +0000
In-Reply-To: <20210914223114.435273-1-rananta@google.com>
Message-Id: <20210914223114.435273-10-rananta@google.com>
Mime-Version: 1.0
References: <20210914223114.435273-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v7 09/15] KVM: arm64: selftests: Maintain consistency for
 vcpuid type
From: Raghavendra Rao Ananta <rananta@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, James Morse <james.morse@arm.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

The prototype of aarch64_vcpu_setup() accepts vcpuid as
'int', while the rest of the aarch64 (and struct vcpu)
carries it as 'uint32_t'. Hence, change the prototype
to make it consistent throughout the board.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/include/aarch64/processor.h | 2 +-
 tools/testing/selftests/kvm/lib/aarch64/processor.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 515d04a3c27d..27d8e1bb5b36 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -63,7 +63,7 @@ static inline void set_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id, uint
 	vcpu_ioctl(vm, vcpuid, KVM_SET_ONE_REG, &reg);
 }
 
-void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *init);
+void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init *init);
 void aarch64_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid,
 			      struct kvm_vcpu_init *init, void *guest_code);
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index db64ee206064..34f6bd47661f 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -212,7 +212,7 @@ void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
 	}
 }
 
-void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *init)
+void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init *init)
 {
 	struct kvm_vcpu_init default_init = { .target = -1, };
 	uint64_t sctlr_el1, tcr_el1;
-- 
2.33.0.309.g3052b89438-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
