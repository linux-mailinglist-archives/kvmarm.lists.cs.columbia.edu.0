Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2F44A4EA5E2
	for <lists+kvmarm@lfdr.de>; Tue, 29 Mar 2022 05:20:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B9254B1B7;
	Mon, 28 Mar 2022 23:20:19 -0400 (EDT)
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
	with ESMTP id 8NL6bR6g4fS7; Mon, 28 Mar 2022 23:20:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A78C4B1B4;
	Mon, 28 Mar 2022 23:20:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 331074B1A0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Mar 2022 23:20:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTHMH8IH-XkH for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Mar 2022 23:20:14 -0400 (EDT)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D6F354B137
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Mar 2022 23:20:14 -0400 (EDT)
Received: by mail-pj1-f73.google.com with SMTP id
 j15-20020a17090a2a8f00b001c6d6b729f1so759489pjd.3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Mar 2022 20:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=sAGNmdLtBshVUh/KYJEFMIapacr3RW4pw1K+CiinPIg=;
 b=V/TJBz/iUJlEmkrMTjYoIS6WDNFPx87ejo/7vs1jet6SMwswMc4CzXzDjCkjps9egi
 127Cak4S3T6A/M28y5M1f1Hq86/nSXOBXnoz72c23voqPqxWYFWZnI6jzEb9ALYSAl/O
 eGM1GpOhJqrK/YSjdMpQwtvKFgIf31Cug8pGvOqxfsVfzfQU8QfaPEZNq4phzhj41nvT
 k5hPTFeGQsTKOd4ZJxaWR3C6ZwgDnjG1fyOQNb32py8ITkbMR7b6t6M/rg30q+JVozO0
 4vUgt86FSv6oIZvyLwC5YYTggVgcEthH8FWTKJcsX4HBs8fSrk0+4D3QqCPcYjRtH2bR
 AGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=sAGNmdLtBshVUh/KYJEFMIapacr3RW4pw1K+CiinPIg=;
 b=AEBBcAJACXLBywDGoM1GM8o8fkgU1tnj5L5v5hL6+byp1EVVD1KfHDR0Nx0BSEnVrH
 3fzpsLYeGkU6svvFe4TOim22NzQQQS0WqVtggSndNa4ceE6ocmG+gV6htxwga3kjzkhg
 ba3vV1q83/sLgc7RTgKnqJdpF3pdSHTscs3Zn80CYM/IIo9Zj72FP+upE5fQKVqxoqmJ
 YPRb54djpiN3gUT/i0Wu6D5qVd5aNRTBoNoNcleHty2E89ZuYYT77pQ0eq8800cvxmZ1
 Ga5DKR5nggU8DJL36bbbv3+xpyJLaASHopK+gbBxRC6HsUbmJjc8KS0AuiTNuhxAI0b1
 KL6w==
X-Gm-Message-State: AOAM533viwxkOtCj4LqFlsr4lD9RdJb4KQJ6O3W0QS/b0YYFO+c3ZG+Y
 jhYxorIqDKmfKmoIGL9AAgfeck7rU7I=
X-Google-Smtp-Source: ABdhPJzL7MMvXVrrnBv7niD9JFw1J92Bl4gjNXuXN74eGBsYjblpq85cVrz7O16dqYjfIYwFFLWZVajk8pI=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a05:6a00:2310:b0:4fa:7eb1:e855 with SMTP id
 h16-20020a056a00231000b004fa7eb1e855mr26199966pfh.14.1648524013695; Mon, 28
 Mar 2022 20:20:13 -0700 (PDT)
Date: Mon, 28 Mar 2022 20:19:22 -0700
Message-Id: <20220329031924.619453-1-reijiw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v6 0/2] KVM: arm64: mixed-width check should be skipped for
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

The series is based on kvmarm/fixes at:

  commit 8872d9b3e35a ("KVM: arm64: Drop unneeded minor version check from PSCI v1.x handler")

v6:
  - Fix typo and minor nits in the selftests [Oliver]

v5: https://lore.kernel.org/all/20220321050804.2701035-1-reijiw@google.com/
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
 arch/arm64/kvm/reset.c                        |  65 ++++++----
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/vcpu_width_config.c | 122 ++++++++++++++++++
 6 files changed, 196 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/vcpu_width_config.c

-- 
2.35.1.1021.g381101b075-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
