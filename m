Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D30AB368BC7
	for <lists+kvmarm@lfdr.de>; Fri, 23 Apr 2021 06:04:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A4D64B4FD;
	Fri, 23 Apr 2021 00:04:02 -0400 (EDT)
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
	with ESMTP id dA87CXtMOZBh; Fri, 23 Apr 2021 00:04:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED6824B4E4;
	Fri, 23 Apr 2021 00:04:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 62CBA4B457
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Apr 2021 00:03:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D1fBqFP8d+wB for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Apr 2021 00:03:58 -0400 (EDT)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 58BC64B3BD
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Apr 2021 00:03:58 -0400 (EDT)
Received: by mail-pl1-f202.google.com with SMTP id
 y20-20020a170902ed54b02900ec7c5f84e4so11423675plb.21
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 21:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=X+DkTW1449q6fKkD8wwhLKFk8s0Ll4r+obcvc3w7AoY=;
 b=OEV2E0v7G6MTuZNr6BG8lG5sW3RKvFodkb/XgGwjBktiRnkXbRKMRqYz/lzohVAI/E
 r0/P7Urx2zN0iq9Jdq1FmN1WGG1A5vrWPFfQUPwM4XG2URDsvLGMfF7S28OSkRSjzps3
 04lQmvsAPgbiSzxoWjwXj140V2pmVwFbjk+ghVUQKxCl08oYu6FnI7a1a5DZCRi+mQIY
 O5I4ztfWmfkqO6XXsiGqHZYAxikvGeNU+p0DymtFax1b+HaddNSHuf+bdzBbPPSaDLp2
 ii0FukZCzTcycFtCxy8Fx5BYQtUh1pfkcX/t6pmuyfORPa3PyGh+9eN6IuKUc4jojNNb
 XqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=X+DkTW1449q6fKkD8wwhLKFk8s0Ll4r+obcvc3w7AoY=;
 b=l/W9Y7MEXFP7+Ha5UivK4uAwutJCCbmZM4EzkgHufq+2heYk3Ca4PSkXgY/38sziXy
 fQFrWb50o+JFVUker5GpMTolJji00dUedDWMbClA51Mc090Bt2V7c7t+obpmnHf2/hpo
 2G/2X+mq6QG2+2ZO2A1QNDpilWNAgDW1yz6tYrlY1bultoOJjlJQADrnBmzpyS3dmt4k
 /PpELi9z7VIjKXej4Ri8pe79mkfKdMzriVtxfCKvIp8EfszyXsTt0Dxs8Z1zJNG6x/Zs
 NGY1ZITx8yT/EBqoNIpimGJgDsEU/NGj9JzBUDIOlNFD4JKoVS9IcR/ysWeJipfT7oai
 2CJg==
X-Gm-Message-State: AOAM533/9D0o6X1JN7dZjSaxhNIm23dHvlDIMXqS3zkOXYM9cicYt2BG
 7jhYy7IsTt09zMu+v6HbgDRyzomq3HUr3A==
X-Google-Smtp-Source: ABdhPJzAqfVay/TiQ2no35LKS+c6fnp/vF6u7i0f38OpLvhcyqzJZ1aTWQmi2aj2SkJiYTFhn+EdPXPQ/sludw==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:10:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a17:90b:19d1:: with SMTP id
 nm17mr3454828pjb.218.1619150637213; Thu, 22 Apr 2021 21:03:57 -0700 (PDT)
Date: Thu, 22 Apr 2021 21:03:48 -0700
Message-Id: <20210423040351.1132218-1-ricarkol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 0/3] KVM: selftests: arm64 exception handling and debug test
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, pbonzini@redhat.com
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

Hi,

These patches add a debug exception test in aarch64 KVM selftests while
also adding basic exception handling support.

The structure of the exception handling is based on its x86 counterpart.
Tests use the same calls to initialize exception handling.  And both
architectures use vm_handle_exception() to override the handler for a
particular vector, or (vector, ec) in the arm64 case.

The debug test is similar to x86_64/debug_regs, except that the x86 one
controls the debugging from outside the VM. This proposed arm64 test
controls and handles debug exceptions from the inside.

The final patch adapts the x86 unhandled-vector reporting to use the
same mechanism as the one introduced for arm64 (UCALL_UNHANDLED instead
of direct x86 port IO).

Thanks,
Ricardo

Ricardo Koller (3):
  KVM: selftests: Add exception handling support for aarch64
  KVM: selftests: Add aarch64/debug-exceptions test
  KVM: selftests: Use a ucall for x86 unhandled vector reporting

 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +-
 .../selftests/kvm/aarch64/debug-exceptions.c  | 250 ++++++++++++++++++
 .../selftests/kvm/include/aarch64/processor.h |  86 ++++++
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../selftests/kvm/include/x86_64/processor.h  |   2 -
 .../selftests/kvm/lib/aarch64/handlers.S      | 104 ++++++++
 .../selftests/kvm/lib/aarch64/processor.c     |  56 ++++
 .../selftests/kvm/lib/x86_64/processor.c      |  15 +-
 9 files changed, 506 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/debug-exceptions.c
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/handlers.S

-- 
2.31.1.498.g6c1eba8ee3d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
