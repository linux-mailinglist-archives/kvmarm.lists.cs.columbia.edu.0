Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF3412A25
	for <lists+kvmarm@lfdr.de>; Tue, 21 Sep 2021 03:01:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A95C94B0FB;
	Mon, 20 Sep 2021 21:01:41 -0400 (EDT)
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
	with ESMTP id r3Ux6jSrC417; Mon, 20 Sep 2021 21:01:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 956134B08E;
	Mon, 20 Sep 2021 21:01:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C1F274A534
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 21:01:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7uqMWKRgN2Gs for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Sep 2021 21:01:37 -0400 (EDT)
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com
 [209.85.166.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B94E349F6C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 21:01:37 -0400 (EDT)
Received: by mail-io1-f74.google.com with SMTP id
 n189-20020a6b8bc6000000b005b92c64b625so46082145iod.20
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=AZxEc7laRqt6V8YHSa5vqSWjCI5HaoGZ4mJ7JHaw6Zc=;
 b=cX0LKE7fT40auep7yCqW5ITglnAAxckVqperzelP1kE2yjjWPnEwOKa2XxUssnw8yb
 WD5SJDXKkO8FUuuGzW1uOKkRDqcvTsAf0pRjUIEyMSaO3PiAtbWd826EGXRErXepOoHo
 /BzV0MmpeIMvRdDXXut1PLDZGgdYSsrt0LyNTTO+KtcusiUMNC+HsAumskEYnWGBqWrx
 R6tCipSjUt2ryLtkwA75ZsQtFJ0+OnDzMix6S1OTtRaGx4PJlcT4PHKL2r0FO/DYxhTd
 a3A+qzPkmNr7rwm+uV6npNsmyuqgxgtxxfefDyTgeA+IsijrziHcTdB01h0QdarPcnNW
 qX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=AZxEc7laRqt6V8YHSa5vqSWjCI5HaoGZ4mJ7JHaw6Zc=;
 b=qWwaaUDKjwrg1hjMiBognhECMiIUYUYHndMTlD6CXXVgmhHqdaDgM8dmU1RAYWWdu7
 2N7VkcOwJgWAGw/X6irIzaLqP/s371LXjej3KejORnLeMOWdaYuTV+IAd3l5wnWxjjzu
 Eqq9smfzUGOs5KlhBCrKB3BhW7LvPSlF3TAJX1902KwCSC8/lCAXvlk48GywDXyAsZcV
 YdAbXJjrX/jJa6qPDxIrzYakouhiUa2XTifL9788Vuioum7pujwwwg6y41MHDItxVDBW
 sxsPJK1jBpJCRF4VFGhuXGZjfKlgHOEog+/Na2tv1nkIl4NHLxbvqiZmLZ4LuQnKMBC1
 UsCA==
X-Gm-Message-State: AOAM531tsUWzCzaNyk9Brodm37m5o1mAqdq+HNTYWLRsWeCXOTntPQwM
 CZDz55DbkU0oGNSqvY6MUCyBJYXXOPE=
X-Google-Smtp-Source: ABdhPJy+6CqPGc9baw+MQq8vlxCxkzBOaf9TIcRw3XWtgq5EF7mdn/4X+ydpnjNH9l2D2xO8RuWumIS+V/M=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a02:9082:: with SMTP id
 x2mr21487329jaf.44.1632186096964; 
 Mon, 20 Sep 2021 18:01:36 -0700 (PDT)
Date: Tue, 21 Sep 2021 01:01:18 +0000
Message-Id: <20210921010120.1256762-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 0/2] selftests: KVM: Fix some compiler warnings
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
warnings. This series addresses the warnings found insofar that
selftests can be built quietly for arm64 with clang.

Series applies cleanly to 5.15-rc2.

Oliver Upton (2):
  selftests: KVM: Fix compiler warning in demand_paging_test
  selftests: KVM: Fix 'asm-operand-width' warnings in steal_time.c

 tools/testing/selftests/kvm/demand_paging_test.c | 2 +-
 tools/testing/selftests/kvm/steal_time.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
