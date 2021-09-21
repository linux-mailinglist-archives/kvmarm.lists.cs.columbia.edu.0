Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF141381F
	for <lists+kvmarm@lfdr.de>; Tue, 21 Sep 2021 19:11:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3BFF24A19A;
	Tue, 21 Sep 2021 13:11:29 -0400 (EDT)
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
	with ESMTP id DbipEDNcU9RK; Tue, 21 Sep 2021 13:11:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A7E34A193;
	Tue, 21 Sep 2021 13:11:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B91449F6C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 13:11:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4nnpYGslog2l for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Sep 2021 13:11:25 -0400 (EDT)
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com
 [209.85.166.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4505D402DB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 13:11:25 -0400 (EDT)
Received: by mail-il1-f201.google.com with SMTP id
 b18-20020a92dcd2000000b00234edde2da9so51269947ilr.21
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=2WwHnMxfL71q5qYV+BUA5lxnx5JteupLuMVdn6U4PTU=;
 b=aEwnhIyFP9IaWSTElIfZ8AMFpjznSzfegfLjr+adkd9wrEipgEFJlBtbWQ5NJAuR0F
 z7d4mT4kSX9mOV945lduOURu8bJgm4K6oRWx835XZ3ZgLG4UQcMvWcJsCUEjf1Q392B5
 zBcDyYI4ShdLQlbTBN99HqyDwG1Zkfwf8CnHMqlpvNRpvQ+ryq5MUP2IM0/BAROv96Ig
 srjmtDv375Vx+k/bAL6zs1X0t8chbXED/QMMvIcsB9caoGdpgr+hBdpIsW4kJlrOC0xR
 JoLJ5veWD0aswc3BWe/7hzYvQy3Dhc3WrAwN/+TmPhn8ezFoTbhbSnKHhxSbPgcuw0q8
 yGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=2WwHnMxfL71q5qYV+BUA5lxnx5JteupLuMVdn6U4PTU=;
 b=ChpYTflrWtDi2yxBu0Hx3Qu/zz1mR6SGic3PDGlcdrFrYg7d9qVuheXF/fYN/euMWl
 riJ+dSBzkzS9IZwuTcVMCkAWTlAgkgDfEaULog9EBI9sI/bCesZm4SDGkij4Xbudb/z+
 zprEz4zE3uosZpg1s6b6gfLP5HY9oPTbJhFe0cSE/AvPrQc7ukD8V+WZlotP0iaIfsyi
 FaOQVcVeBMlVgm2qOBTC5ZbeR2C+voN+PLjgsTkl6wjz+73wD9Zrh5TaDLKGMOZMdoAc
 jsDEv8A4pqtULpeqVTItDx9N4W5UwK0M/w6amGl6bne7aqlmcH6CcpZwLHgZQPzTcd0y
 jgqg==
X-Gm-Message-State: AOAM530iXkTaIE3d+z5d8nmSvGqaFL587Jz7pNJqFX32zJrCXn6fgy4x
 8McJbdxZCqfzxJO9vT2bB9M/4B0TxLM=
X-Google-Smtp-Source: ABdhPJwd7eZymOGxBpOWau8xHW5PaOuKf1gdGIvDqyp37yR/MO19C0sffJUxUGXJo4bfPDWfL/IZeESa07g=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6e02:12cc:: with SMTP id
 i12mr22545273ilm.273.1632244284627; Tue, 21 Sep 2021 10:11:24 -0700 (PDT)
Date: Tue, 21 Sep 2021 17:11:19 +0000
Message-Id: <20210921171121.2148982-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 0/2] selftests: KVM: Address some bugs caught by clang
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>
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

Building KVM selftests for arm64 using clang throws a couple compiler
warnings. These fixes address a couple of bugs in KVM selftests that
just so happen to also placate the compiler.

Series applies cleanly to 5.15-rc2.

v1 -> v2:
 - Clarify that 1/2 is an actual bugfix, not just an attempt to silence
   clang
 - Adopt Drew's suggested fix, aligning steal_time's SMCCC call with the
   SMC64 convention

Oliver Upton (2):
  selftests: KVM: Fix check for !POLLIN in demand_paging_test
  selftests: KVM: Align SMCCC call with the spec in steal_time

 tools/testing/selftests/kvm/demand_paging_test.c | 2 +-
 tools/testing/selftests/kvm/steal_time.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
