Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1552C5A1D13
	for <lists+kvmarm@lfdr.de>; Fri, 26 Aug 2022 01:25:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0FE2A4E237;
	Thu, 25 Aug 2022 19:25:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZmGdAJtpO9An; Thu, 25 Aug 2022 19:25:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D35234E235;
	Thu, 25 Aug 2022 19:25:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 72B864E229
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Aug 2022 19:25:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eo+AzN5XsgoE for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Aug 2022 19:25:25 -0400 (EDT)
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com
 [209.85.128.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 34A084E224
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Aug 2022 19:25:25 -0400 (EDT)
Received: by mail-yw1-f201.google.com with SMTP id
 00721157ae682-33dbe61eed8so46332367b3.1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Aug 2022 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc;
 bh=y2TyZVHOzKZlb9wECS9yMCNcXCNpwqCPWpTxl29+IMY=;
 b=dkM+A09pjx32V3tjxCAZAaj4iTr2QWwZFTx14MwcUXXnZscAY3fsOcj6h5WXQXxdoD
 pE2ASAcwod4FD0N0sCT4FjUT0tg9Opertqs8xb3KgjTkUGEmN0krLyCYuuqUGRjMcltU
 i55uCtWc8Su1TGA6H/a9JTuhvCJcNgBM50Y1A4ihMCdqTUfplBKQUaiEUX2n1Vh4N710
 3yOt5OJYxOGq7VwXawE8F72ZOkRT8JCFAjGnVJAcUhtb87iwBUwK1cOzoECBWrP6U0Ke
 ZtEkGqxLhvl3GVE9ZNy1Tt1CBoQxoOnHS9H5jY9/byfHRVWvrd+Zhz17D7ZlFyP3ffIM
 c1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:reply-to
 :x-gm-message-state:from:to:cc;
 bh=y2TyZVHOzKZlb9wECS9yMCNcXCNpwqCPWpTxl29+IMY=;
 b=cfv3CgymoXcABujI49OzDLuaNP3bxYiK1BLNGdMZVBcngComuwnnfcPFEllUVd1J8z
 6CrLTfvy7Qpm4hT9GjYu0nfFc91UhM0TUDBqAxTekfCukGCoCzMwMQ53KXIURW2VsIgx
 lDKkVO7OAATQkFoAnyellMX3oe9JVtJaArs7wix6tKmBalDvk38zvwlMZnzo9LHMeShl
 13uHe7P09/uaPC1kQDyfgg18RT106JwEEHmjJm/S3QWq8CJOZ3kqJKRAjrrlw2hzdjMQ
 3jzGZEGML/ignUVpE8pS2nkifJ6qWptKYrbSKINKx0a+nvhuDEK4MFjuA7QhmiA5LKBE
 nb9A==
X-Gm-Message-State: ACgBeo0NIDxCtJYpNey130L7y34rSz5EdVoXFlBQGs1O9T/npN6CmeF9
 qjWb3oo5INA4Qqwe5goQBPXprnb9CqM=
X-Google-Smtp-Source: AA6agR4iAX55dcIo3IUqvlfKkqmyFpPiECgmLWRpTah2t3s+pqlFTA2hJbEvjHCDMn3ntt/fdb4I5rKg3Mw=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:6143:0:b0:335:3076:168e with SMTP id
 v64-20020a816143000000b003353076168emr5851445ywb.460.1661469924695; Thu, 25
 Aug 2022 16:25:24 -0700 (PDT)
Date: Thu, 25 Aug 2022 23:25:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825232522.3997340-1-seanjc@google.com>
Subject: [PATCH v5 0/7] KVM: selftests: Implement ucall "pool" (for SEV)
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: llvm@lists.linux.dev, Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>,
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, Andrew Jones <andrew.jones@linux.dev>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
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

Non-KVM folks, y'all got pulled in because of the atomic_test_and_set_bit()
patch.

Rework the ucall infrastructure to use a pool of ucall structs to pass
memory instead of using the guest's stack.  For confidential VMs with
encrypted memory, e.g. SEV, the guest's stack "needs" to be private memory
and so can't be used to communicate with the host.

Convert all implementations to the pool as all of the complexity is hidden
in common code, and supporting multiple interfaces adds its own kind of
complexity. 

Tested on x86 and ARM, compile tested on s390 and RISC-V.

v5:
 - Use less convoluted method of writing per-VM "globals". [Oliver]
 - Add patch to drop ucall_uninit().

v4: https://lore.kernel.org/all/20220824032115.3563686-1-seanjc@google.com

Peter Gonda (2):
  tools: Add atomic_test_and_set_bit()
  KVM: selftests: Add ucall pool based implementation

Sean Christopherson (5):
  KVM: selftests: Consolidate common code for populating ucall struct
  KVM: selftests: Consolidate boilerplate code in get_ucall()
  KVM: selftests: Automatically do init_ucall() for non-barebones VMs
  KVM: selftests: Make arm64's MMIO ucall multi-VM friendly
  KVM: selftest: Drop now-unnecessary ucall_uninit()

 tools/arch/x86/include/asm/atomic.h           |   7 ++
 tools/include/asm-generic/atomic-gcc.h        |  12 +++
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/arch_timer.c        |   1 -
 .../selftests/kvm/aarch64/debug-exceptions.c  |   1 -
 .../selftests/kvm/aarch64/hypercalls.c        |   1 -
 .../testing/selftests/kvm/aarch64/psci_test.c |   1 -
 .../testing/selftests/kvm/aarch64/vgic_init.c |   2 -
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |   1 -
 tools/testing/selftests/kvm/dirty_log_test.c  |   3 -
 .../selftests/kvm/include/kvm_util_base.h     |  15 +++
 .../selftests/kvm/include/ucall_common.h      |  10 +-
 .../selftests/kvm/kvm_page_table_test.c       |   2 -
 .../testing/selftests/kvm/lib/aarch64/ucall.c | 102 +++---------------
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 ++
 .../selftests/kvm/lib/perf_test_util.c        |   3 -
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  42 ++------
 tools/testing/selftests/kvm/lib/s390x/ucall.c |  39 ++-----
 .../testing/selftests/kvm/lib/ucall_common.c  | 102 ++++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/ucall.c  |  39 ++-----
 .../testing/selftests/kvm/memslot_perf_test.c |   1 -
 tools/testing/selftests/kvm/rseq_test.c       |   1 -
 tools/testing/selftests/kvm/steal_time.c      |   1 -
 .../kvm/system_counter_offset_test.c          |   1 -
 24 files changed, 189 insertions(+), 210 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/ucall_common.c


base-commit: 372d07084593dc7a399bf9bee815711b1fb1bcf2
-- 
2.37.2.672.g94769d06f0-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
