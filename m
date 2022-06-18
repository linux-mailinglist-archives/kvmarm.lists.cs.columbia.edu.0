Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC1550130
	for <lists+kvmarm@lfdr.de>; Sat, 18 Jun 2022 02:16:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5CEF34B38F;
	Fri, 17 Jun 2022 20:16:26 -0400 (EDT)
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
	with ESMTP id pRBF5SOQOfUn; Fri, 17 Jun 2022 20:16:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B8B74B38C;
	Fri, 17 Jun 2022 20:16:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D1564B2A1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 20:16:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BehWYhoGc6IP for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Jun 2022 20:16:23 -0400 (EDT)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0CDB94B091
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 20:16:22 -0400 (EDT)
Received: by mail-pj1-f73.google.com with SMTP id
 c19-20020a17090abf1300b001ec70183c99so2438576pjs.1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:message-id:mime-version:subject:from:to:cc;
 bh=4HlwtKsrcUiP4ezxQu89E9aBkat4STQcCRUlQRJmlM4=;
 b=cqH7RwM35eUa9gSH23Vyp0IXD8rbHQ6iHBYjzqYB4r/ApR3GiB5irQq91CvaOTU2a/
 JbiD+lO3mhGF7Q9VF8Z+RL2N3kcJKkwfgbC11BxFaQhlTH5WcSxRdyy/VhMTgegBEuWE
 m0ICZIKBakq6kG4UrIJM1l7DZgPfrlXNTJzqVOW/b/BDjaQn7NZ1PZDqtivgtVVTA1vf
 J3LNa6ebna+9KeWC2sraxN7xZP7PZA5oz+Ft9ZxR6ro5zNG2FCSpgajvCr+Yw7sr0lRJ
 GloAY8IFUzs+m+0goppunIS/0Ln/zHmwSHJByc2TnvMQ/Qh39U6cvZifZQqRqYSCI5Ep
 Y1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
 :from:to:cc;
 bh=4HlwtKsrcUiP4ezxQu89E9aBkat4STQcCRUlQRJmlM4=;
 b=JAUPDKBFf3m4KZzZkxd7odOwzZ3N37knUtY/gVyObS2l5T6lt37jOF6GwEL96/ng4X
 WktS57N+Y0xe8V/VBbeFwIfGRLHBNRq/vUrXGzxymGOhtPSllGx4dByStqq2b9psiKqs
 Z5aIskV0si5YDToRy2S0mrcYn+1N3e7WepMse28NCiGbLlGlsD8+XIaOW05ym4RiSMSV
 C4YaTYVQawiVa0Q7WjKp3r/Y/yGE2ZI3oqmpazBzYrVE49ou3Cf0DSVbVM7+mEgIviAi
 vgRc/7DjlPHUOxT2jMqHlvtxik5ccjrrVi7dqGwBDTvdJcPxqkPhNP+dYFwXZAlyyWoy
 Rd9Q==
X-Gm-Message-State: AJIora+ndYs4m/2nGiCQlA73nAH2d9S37CKCJblvvt/YDZSzWBPGnXkO
 dPT2nfq2XfzOCECoI0hxFsufweVCR4k=
X-Google-Smtp-Source: AGRyM1u0GdVPlx+Hq/yK0Jw2vZzxWWQDidlftHCsuvnSZKrmnfBPw9OaOWYf8QzYovkEUkJdLG9nTYZRGxE=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:16d2:b0:522:81c0:a635 with SMTP id
 l18-20020a056a0016d200b0052281c0a635mr12877654pfc.0.1655511381838; Fri, 17
 Jun 2022 17:16:21 -0700 (PDT)
Date: Sat, 18 Jun 2022 00:16:15 +0000
Message-Id: <20220618001618.1840806-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH 0/3] KVM: selftests: Consolidate ucall code
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>,
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Consolidate the code for making and getting ucalls.  All architectures pass
the ucall struct via memory, so filling and copying the struct is 100%
generic.  The only per-arch code is sending and receiving the address of
said struct.

Tested on x86 and arm, compile tested on s390 and RISC-V.

Sean Christopherson (3):
  KVM: selftests: Consolidate common code for popuplating ucall struct
  KVM: selftests: Consolidate boilerplate code in get_ucall()
  KVM: selftest: Add __weak stubs for ucall_arch_(un)init()

 tools/testing/selftests/kvm/Makefile          |  1 +
 .../selftests/kvm/include/ucall_common.h      | 17 ++++++-
 .../testing/selftests/kvm/lib/aarch64/ucall.c | 36 +++-----------
 tools/testing/selftests/kvm/lib/riscv/ucall.c | 44 ++---------------
 tools/testing/selftests/kvm/lib/s390x/ucall.c | 41 ++--------------
 .../testing/selftests/kvm/lib/ucall_common.c  | 49 +++++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/ucall.c  | 41 ++--------------
 7 files changed, 87 insertions(+), 142 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/ucall_common.c


base-commit: 8baacf67c76c560fed954ac972b63e6e59a6fba0
-- 
2.37.0.rc0.104.g0611611a94-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
