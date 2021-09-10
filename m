Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E1406386
	for <lists+kvmarm@lfdr.de>; Fri, 10 Sep 2021 02:49:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 949184B1F1;
	Thu,  9 Sep 2021 20:49:27 -0400 (EDT)
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
	with ESMTP id ltVd2ossItUX; Thu,  9 Sep 2021 20:49:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B6FC4B1F3;
	Thu,  9 Sep 2021 20:49:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 72A9E4B126
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 20:49:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B6OOwAKBmXMh for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 20:49:23 -0400 (EDT)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 194204B106
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 20:49:23 -0400 (EDT)
Received: by mail-pl1-f201.google.com with SMTP id
 k9-20020a170902c40900b0013a41f4fee5so48766plk.9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Sep 2021 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=dEdxgR+gW3CA1xQLb38rytPzrES1DL67Ux6A5LMF1hE=;
 b=M5VNWAyB8m19PEM6kIY9iuTeb1Xx80xAZbeYJcIhWPCTh6WRfOB109DGID2/XjRrq0
 lNfXAfaWumtKxg6frGyZOUE3Ti/1bXxS63hAFzKK3vzMWMXFvvXcHswdVCnbSQ4FSVmz
 7xPxcBXufl3zRO6rH2JwBa430gIC4+I9fL2KOkI8azT/p5yLhmvAm3II8j3f6Tzmbdgv
 ib3W1twjR+vmqRt7Td9uaD40H/e+f23ce8Gg21a4knrCwVns02a/SucIaCvZxVe+O4vN
 3pdnKub0f6wG/k3OzlM9KLPGT395AUcP2XHyK8eMmqoYhDZGqps0W5TK2ZPR6miwYUeD
 dK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=dEdxgR+gW3CA1xQLb38rytPzrES1DL67Ux6A5LMF1hE=;
 b=g/ye7RSsA/3caVc8rsrhCFiw99nWhh0M5GLslQmpTOszeVFhCUdHQ2lvhzbuVy37DL
 2LDk6g29Hi6wzT3qNGwJwz2j5ck33aU9UabfLxl+P5yVsxGXDnyG1XsbtigshNSZWKD+
 j+k9wAXje6TD8qShSln1kRMkb/DShZdPlrLJZAoBkyFWg6GFHdT9ejK47YgiqfUhybGv
 HlW6k4AwOaseSnSIYff3Op4VsxMf7oLTUVHdd5Ws7XrCuVUnEKJCFQndjY/Y86KmF7Le
 q5ZThnPRPDyKyzZPIkv0tRaSyHBsfmBUaXlWu1r8Ph/XsS/u3DbOsDlAxGGBTW7EMx5/
 +NyQ==
X-Gm-Message-State: AOAM5304vcYniB4CujXF1TbNuvrpPkKAxrn96VFyJESR8ucJyq+3Kdvd
 nvwHthR4800EAKuXs7ug0Zmog0PY800Kxw==
X-Google-Smtp-Source: ABdhPJx2dtSeD1rpEMeeTCoYm9lmfTiEVNC3xqi2+/nX82mrsrKK906Uu6TqTvZRHtZHYiRDV8rjHO8nHGBf+w==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:aa7:83c6:0:b029:3e0:1f64:6f75 with SMTP
 id j6-20020aa783c60000b02903e01f646f75mr5657228pfn.69.1631234961995; Thu, 09
 Sep 2021 17:49:21 -0700 (PDT)
Date: Thu,  9 Sep 2021 17:49:17 -0700
Message-Id: <20210910004919.1610709-1-ricarkol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 0/2] KVM: arm64: vgic-v3: Missing check for redist region
 above the VM IPA size
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu, 
 drjones@redhat.com, eric.auger@redhat.com, alexandru.elisei@arm.com
Cc: pshier@google.com, Paolo Bonzini <pbonzini@redhat.com>, shuah@kernel.org
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

KVM doesn't check for redist regions that extend partially above the
VM-specified IPA (phys_size).  This can happen when using the
KVM_VGIC_V3_ADDR_TYPE_REDIST or KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attribute
to set a new region that extends partially above phys_size (with the base below
phys_size).  The issue is that vcpus can potentially run into a situation where
some redistributors are addressable and others are not.

Patch 1 adds the missing checks, and patch 2 adds a test into aarch64/vgic_init.

Changes:
v2: adding a test for KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, and returning E2BIG
    instead of EINVAL (thanks Alexandru and Eric).

Ricardo Koller (2):
  KVM: arm64: vgic: check redist region is not above the VM IPA size
  KVM: arm64: selftests: tests for vgic redist regions above the VM IPA
    size

 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |  7 ++-
 arch/arm64/kvm/vgic/vgic-v3.c                 |  4 ++
 .../testing/selftests/kvm/aarch64/vgic_init.c | 52 +++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

-- 
2.33.0.309.g3052b89438-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
