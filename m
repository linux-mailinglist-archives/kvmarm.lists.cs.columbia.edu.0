Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4029F4E1FCA
	for <lists+kvmarm@lfdr.de>; Mon, 21 Mar 2022 06:08:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 704184B08F;
	Mon, 21 Mar 2022 01:08:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a3G+YIi+Bgj8; Mon, 21 Mar 2022 01:08:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2781549F46;
	Mon, 21 Mar 2022 01:08:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DB1649F01
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Mar 2022 01:08:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N+GTNb+JzzY5 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Mar 2022 01:08:16 -0400 (EDT)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 124AD49EE2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Mar 2022 01:08:16 -0400 (EDT)
Received: by mail-pj1-f74.google.com with SMTP id
 fh22-20020a17090b035600b001c6a163499cso3066590pjb.2
 for <kvmarm@lists.cs.columbia.edu>; Sun, 20 Mar 2022 22:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=cGQsgNjFRYhDeev7uNz7LWwt7GNAQoUSmq7BQTxGuxE=;
 b=QbWh7YTxiSYyD6RXVVXrIEKuySt/Re66x+0XKN3JEQ9LWDEVJ4nhXNX/7X2+4r0ssk
 TWbE/y/86HA3KcljsIZ3ZpGa7K2sRNO3iRkQ3GBEXDYJsz1D8olXJCZXIpjIvtNjapQJ
 YM/FKobD8zF+xqXV6VVv+VaASxr5DAj6264OVGux4V5vvxakSiYRs5R//XsoIs5vrzBe
 yYNEuzF9qWAffWHm9xVDWOGcunMOWIqFNtLkqVVQbHxKJWFjt/yvx9Qr77GQGnbJeu5U
 dQg8GSAyW9zA8z8aqLkX+axB5uUo1CIJ8dkuubePda3RrQG7aKlbyyHHxBUjrgkb7ChU
 rtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=cGQsgNjFRYhDeev7uNz7LWwt7GNAQoUSmq7BQTxGuxE=;
 b=Rw2GqWzzlFkYh9vSH0jNV2DGWMRnzKxOaRIMT8PPBtuiTUf/t+mB4ZJ+pFCBi65J6M
 tr5fJn7AhBQqMJZSswQANst9MJUdLuz8Yg4NQE5gSjNPUcVI2CzX9m4EGrQ22W+STGnA
 oSosDFEdPjIUb0q0XUw2pm26TF50ApILQlyWWwZ2aR5pcZYd91EQ6LCxViadzjj5geAZ
 kzkremWFbOaznDbME23lrpjt8ujwCX8XjIK7WZxl6rN0wclAOiI1TN8/z4HGlXo28Q74
 raN6uTWWMMPy5Qjyb7a/b/QWAum/5kvVgVAblVtMaKm6TK/AE2SNHktEzaAVvLK7/sZW
 qxJA==
X-Gm-Message-State: AOAM5300CJsb8S/aSdRs047E8iBfeaIcmcX1I2MUHxjP+jniwx7kIhro
 Cqp9EpMSiHYC9U94UVcW1tClDSA8c4w=
X-Google-Smtp-Source: ABdhPJx2nPYTXS5zVdFBXtlwohrhTS1zH8bM5qyThixl3/KmV68bmIjNvzrfmY5I61S9Rnn1fvAUTWUHR+E=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a17:90a:858b:b0:1c6:5bc8:781a with SMTP id
 m11-20020a17090a858b00b001c65bc8781amr1265206pjn.0.1647839294798; Sun, 20 Mar
 2022 22:08:14 -0700 (PDT)
Date: Sun, 20 Mar 2022 22:08:02 -0700
Message-Id: <20220321050804.2701035-1-reijiw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v5 0/2] KVM: arm64: mixed-width check should be skipped for
 uninitialized vCPUs
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

KVM allows userspace to configure either all EL1 32bit or 64bit vCPUs
for a guest.  At vCPU reset, vcpu_allowed_register_width() checks
if the vcpu's register width is consistent with all other vCPUs'.
Since the checking is done even against vCPUs that are not initialized
(KVM_ARM_VCPU_INIT has not been done) yet, the uninitialized vCPUs
are erroneously treated as 64bit vCPU, which causes the function to
incorrectly detect a mixed-width VM.

This series will fix this problem by introducing a new VM flag that
indicates the guest needs to be configured with all 32bit or 64bit
vCPUs and checking vcpu's register width against the new flag at
the vcpu's KVM_ARM_VCPU_INIT (instead of against other vCPUs'
register width).

Patch-1 introduces KVM_ARCH_FLAG_EL1_32BIT and
KVM_ARCH_FLAG_REG_WIDTH_CONFIGURED bits for kvm->arch.flags and
uses them to check vcpu's register width to fix the problem.

Patch-2 introduces a selftest that can test non-mixed-width vCPUs (all
64bit vCPUs or all 32bit vcPUs) can be configured, and mixed-width
vCPUs cannot be configured.

The series is based on kvmarm/next's at tag: kvmarm-5.18.

v5:
  - Rebase to kvmarm/next (and drop the patch-1 "KVM: arm64: Generalise
    VM features into a set of flags")
  - Use kernel-doc style comments for kvm_set_vm_width() [Oliver]
  - Change kvm_set_vm_width() to use if/else instead of a ternary
    operator for KVM_ARCH_FLAG_EL1_32BIT check [Oliver]

v4: https://lore.kernel.org/all/20220314061959.3349716-1-reijiw@google.com/
  - Use different implementation of vcpu_el1_is_32bit() depending on
    the context. [Marc]
  - Rename kvm_register_width_check_or_init() to kvm_set_vm_width(), and
    call it from kvm_rest_vcpu() instead of from kvm_vcpu_set_target()
  - Remove vcpu_allowed_register_width(), and does the same checking
    in kvm_set_vm_width() instead.

v3: https://lore.kernel.org/all/20220303035408.3708241-1-reijiw@google.com/
  - Introduced 'flags' to kvm_arch, and use bits of the flags for
    a set of booleans for VM feature.
  - Changed 'el1_reg_width' to two bits of 'flags' of kvm_arch.

v2: https://lore.kernel.org/all/20220118041923.3384602-1-reijiw@google.com/
  - Introduced 'el1_reg_width' for kvm_arch and use it to check vcpu's
    register width against the flag at the vcpu's KVM_ARM_VCPU_INIT.

v1: https://lore.kernel.org/all/20220110054042.1079932-1-reijiw@google.com/

[1] https://lore.kernel.org/all/20210715163159.1480168-2-maz@kernel.org/

Reiji Watanabe (2):
  KVM: arm64: mixed-width check should be skipped for uninitialized
    vCPUs
  KVM: arm64: selftests: Introduce vcpu_width_config

 arch/arm64/include/asm/kvm_emulate.h          |  27 ++--
 arch/arm64/include/asm/kvm_host.h             |  10 ++
 arch/arm64/kvm/reset.c                        |  65 ++++++---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/vcpu_width_config.c | 125 ++++++++++++++++++
 6 files changed, 199 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/vcpu_width_config.c

-- 
2.35.1.894.gb6a874cedc-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
