Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7266413918B
	for <lists+kvmarm@lfdr.de>; Mon, 13 Jan 2020 14:00:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D0CD4AF2A;
	Mon, 13 Jan 2020 08:00:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WV0FCgTEiuKh; Mon, 13 Jan 2020 08:00:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5034F4AF1B;
	Mon, 13 Jan 2020 08:00:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 898E04AEE9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 08:00:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id URpLJ37cS2EK for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Jan 2020 08:00:50 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDAFE4AEDD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 08:00:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578920450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EkS+XB1Ns/9Hyh+RmqcN6uCGCO0+4bXjZaEm/l9P19A=;
 b=aGbuKxr8o29UKrIcoX7kiGF+7dgabeUd2WUdoOoGnsdEV39U3yPWliCbW+yQ5xGOJ7Uahf
 NFlUJHh1SRrYZf7Uwpx7LT+MSV8h3Stxwmy1dtQTHnTmQqWkh6pNYuRlroyi/uPeBNfclG
 uH3d9jy8wUeZJWdIBQQ0JKDVrxmT5Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-VZ-fsZIIMe-6upmb9trs7Q-1; Mon, 13 Jan 2020 08:00:46 -0500
X-MC-Unique: VZ-fsZIIMe-6upmb9trs7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBE2918A6ED1;
 Mon, 13 Jan 2020 13:00:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BAA480F6C;
 Mon, 13 Jan 2020 13:00:44 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH kvm-unit-tests 0/3] arm/arm64: selftest for pabt
Date: Mon, 13 Jan 2020 14:00:40 +0100
Message-Id: <20200113130043.30851-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: pbonzini@redhat.com
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

Patch 3/3 is a rework of Alexandru's pabt test on top of a couple of
framework changes allowing it to be more simply and robustly implemented.

Andrew Jones (3):
  arm/arm64: Improve memory region management
  arm/arm64: selftest: Allow test_exception clobber list to be extended
  arm/arm64: selftest: Add prefetch abort test

 arm/selftest.c      | 199 ++++++++++++++++++++++++++++++++------------
 lib/arm/asm/setup.h |   8 +-
 lib/arm/mmu.c       |  24 ++----
 lib/arm/setup.c     |  56 +++++++++----
 lib/arm64/asm/esr.h |   3 +
 5 files changed, 203 insertions(+), 87 deletions(-)

-- 
2.21.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
