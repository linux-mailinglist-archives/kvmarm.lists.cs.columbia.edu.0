Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 129693C2189
	for <lists+kvmarm@lfdr.de>; Fri,  9 Jul 2021 11:25:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DAB94A4CD;
	Fri,  9 Jul 2021 05:25:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@chromium.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y6HI6c+pxxF9; Fri,  9 Jul 2021 05:25:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FD274A2E5;
	Fri,  9 Jul 2021 05:25:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B17240870
 for <kvmarm@lists.cs.columbia.edu>; Fri,  9 Jul 2021 00:37:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yYmDEJeduzXC for <kvmarm@lists.cs.columbia.edu>;
 Fri,  9 Jul 2021 00:37:34 -0400 (EDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 59BA440808
 for <kvmarm@lists.cs.columbia.edu>; Fri,  9 Jul 2021 00:37:34 -0400 (EDT)
Received: by mail-pl1-f172.google.com with SMTP id x16so3493811plg.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 08 Jul 2021 21:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H/LklQaJdTOXWeUT+mprxaDKrVkD8A9UO7oJUzmViNQ=;
 b=BG8tocLa4Fc6GVIjbj/83MmQ562w43ne1yivFCQz30vkd1c2tWv5D71ctj9JMn0a/s
 3wZbh/hEhgz+vSrVvnrhuxUH9Rizx7klC2gPGSSX658M5KU/uGIgxQsLZ4tLgMU56Apd
 b3soeKez7tuOdGuGTWH0hrCgVZXgsByXKESZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H/LklQaJdTOXWeUT+mprxaDKrVkD8A9UO7oJUzmViNQ=;
 b=tjP64mEXu61oS2otobt+0GMRbtVUtEjEx1WApN8ikGwDmVQ9nujzUnfDl5fW/JDzpD
 AC2+JSgt3cNqz1Yr4zEq/N8zlVq6UJ3SutYgeksurPq/zT9C0PCTu704fX5wQupqT4vN
 z/fxI87+D3SEyKi8re+iYmsOKvcfpt9idbRfHkeWv95k+UyehiDXzBFdpGB68+8j30CX
 K1C9tj7BjE4x88JQNLZwOvw2wpzCR0Hxo+GUB50Jza2+Vg1SFSpSf98Nv0gnlYrvi20t
 L91Eep2im7X+PietCLEVmeG1W/dyocBaVavs8RNXPFa0PjfyWhFcjk0x4xisiwVW56eS
 R2qQ==
X-Gm-Message-State: AOAM530FYevpLMBq8hOWSycGfA158nIjI3eBa5lmo571+wyetDW+POXk
 sFpXF5YwR0+ObNjAv2YwrCWdfg==
X-Google-Smtp-Source: ABdhPJwQ4+9mQudHLFskGBug4FzGh1FHXv+U9yzd3L1gcLu6YE9FOXHurMSqd0ktQwQkYJA/TWJ0/Q==
X-Received: by 2002:a17:90a:ff0d:: with SMTP id
 ce13mr2922178pjb.157.1625805453217; 
 Thu, 08 Jul 2021 21:37:33 -0700 (PDT)
Received: from senozhatsky.flets-east.jp
 ([2409:10:2e40:5100:a30d:fc4:7834:ee08])
 by smtp.gmail.com with ESMTPSA id y4sm4420760pfa.14.2021.07.08.21.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jul 2021 21:37:32 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCHv2 0/4] arm64:kvm: teach guest sched that VCPUs can be preempted
Date: Fri,  9 Jul 2021 13:37:09 +0900
Message-Id: <20210709043713.887098-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 09 Jul 2021 05:25:42 -0400
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Suleiman Souhlal <suleiman@google.com>, kvmarm@lists.cs.columbia.edu,
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

Hello,

This patch set adds a simple vcpu_is_preempted() implementation so
that scheduler can make better decisions when it search for the idle
(v)CPU.

For sched benchmarks please refer to [0].

[0] https://github.com/sergey-senozhatsky/arm64-vcpu_is_preempted

v2:
- 5.13 rebase (static calls, etc)
- simplified and reworked some bits

Sergey Senozhatsky (4):
  arm64: smccc: Add SMCCC pv-vcpu-state function call IDs
  arm64: add guest pvstate support
  arm64: do not use dummy vcpu_is_preempted()
  arm64: add host pv-vcpu-state support

 arch/arm64/include/asm/kvm_host.h | 23 ++++++++
 arch/arm64/include/asm/paravirt.h | 19 +++++++
 arch/arm64/include/asm/spinlock.h | 18 +++---
 arch/arm64/kernel/paravirt.c      | 94 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/smp.c           |  4 ++
 arch/arm64/kvm/Makefile           |  3 +-
 arch/arm64/kvm/arm.c              |  3 +
 arch/arm64/kvm/hypercalls.c       | 11 ++++
 arch/arm64/kvm/pv-vcpu-state.c    | 64 +++++++++++++++++++++
 include/linux/arm-smccc.h         | 18 ++++++
 10 files changed, 248 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/kvm/pv-vcpu-state.c

-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
