Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A2211568
	for <lists+kvmarm@lfdr.de>; Wed,  1 Jul 2020 23:53:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5F47C4B4B5;
	Wed,  1 Jul 2020 17:53:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nMJM5XY-0fiS; Wed,  1 Jul 2020 17:53:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 50AC74B4A7;
	Wed,  1 Jul 2020 17:53:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 495764B4A3
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 17:53:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IebDuGzXBnyg for <kvmarm@lists.cs.columbia.edu>;
 Wed,  1 Jul 2020 17:53:11 -0400 (EDT)
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 35C914B415
 for <kvmarm@lists.cs.columbia.edu>; Wed,  1 Jul 2020 17:53:11 -0400 (EDT)
Received: by mail-il1-f193.google.com with SMTP id w73so10593777ila.11
 for <kvmarm@lists.cs.columbia.edu>; Wed, 01 Jul 2020 14:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bODbxRcePa9WehuXTPgP2DRtOtKBdWrM4acPOrmDbTc=;
 b=l6EUF5eplb8Pg6j1bGk/xwqTvArkAPLEMGD0MD7/J2uddgoPWcEjMM5PWtxSkTijlW
 oU4ZJAtxSgh93lHUaKdmFLjGmluxp0jCxGrXa+wt2WOYQpic/5BqAyVFXk3a9QXjDXcT
 jMuh+NuHsN+qacFSROE0zHIepWhu9if8itfdxKFKzsPGRmihhl3OgwINoVWkfKsm8toO
 sZnoDiiPC3aNbIF67BoFXKV1/vHY0fPF8LMHnXb5ZeiE+5wYjAO+iy02ARO3HgmB64HB
 4Eo0JLTF9Ob2ob+XHexfXnp+sNyTy6JzDUK8zfn10k2lSwKw7Hv1XaVw7sKijbgLIFWK
 ejng==
X-Gm-Message-State: AOAM530gQba6FCf634rZRauc/PLdRVTn1C1EcgWFqyy4BBYowMIMCZq3
 hLcrReExoHFPH5A/dkaHPw==
X-Google-Smtp-Source: ABdhPJzC7o2GLfSuIgZlNB89IGuxuIca0R5MyxAdNvq9S+BM3ShHOWOl/UfeahrO1xqLEuatejtjbw==
X-Received: by 2002:a92:8b10:: with SMTP id i16mr9724498ild.109.1593640390690; 
 Wed, 01 Jul 2020 14:53:10 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
 by smtp.googlemail.com with ESMTPSA id g1sm3784707ilk.51.2020.07.01.14.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 14:53:10 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 0/3] Cortex-A77 erratum 1508412 work-around
Date: Wed,  1 Jul 2020 15:53:05 -0600
Message-Id: <20200701215308.3715856-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

This series implements the work-around for Cortex-A77 erratum 1508412.
KVM guests which don't implement the work-around can still deadlock the
system. This is also the case with the existing Cortex-A57 erratum 832075,
so we add a warning message if an erratum can cause deadlock.

Rob

v1: https://lore.kernel.org/linux-arm-kernel/20200629213321.2953022-1-robh@kernel.org/

Rob Herring (3):
  KVM: arm64: Print warning when cpu erratum can cause guests to
    deadlock
  arm64: Add part number for Arm Cortex-A77
  arm64: Add workaround for Arm Cortex-A77 erratum 1508412

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 19 +++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 10 ++++++++++
 arch/arm64/kvm/arm.c                   |  5 +++++
 arch/arm64/mm/fault.c                  | 10 ++++++++++
 7 files changed, 50 insertions(+), 1 deletion(-)

--
2.25.1
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
