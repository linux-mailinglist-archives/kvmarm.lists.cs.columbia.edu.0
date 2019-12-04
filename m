Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E68191136A5
	for <lists+kvmarm@lfdr.de>; Wed,  4 Dec 2019 21:44:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3487B4AF03;
	Wed,  4 Dec 2019 15:44:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvW7Tj7MSm81; Wed,  4 Dec 2019 15:44:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 28F3B4AF00;
	Wed,  4 Dec 2019 15:44:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B6AF84AEDC
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Dec 2019 15:44:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UrrUyJeXoz9r for <kvmarm@lists.cs.columbia.edu>;
 Wed,  4 Dec 2019 15:44:43 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D6F04AC07
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Dec 2019 15:44:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575492283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JalwGvumE/sV/vESkSXmSu1R1FZ9zcdLVGm8RXkwmcM=;
 b=U/0yUxiZkwtg6oRY0EPhGcRplDUNemCU6KWPAiAco3Tb8mBlUE99fGOhwoYTAX5DYcVfaH
 gsj5/cEfLoUhkSM0tektjfwb/tyJ6TaWNUqYE+bq4KAPr9IVPMMByW1552S6aqw3zcZ60U
 41CUmxYOu5J23Iks3aajgIyNHSV2lUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-A2O5sKfkP7um__t8PatHgw-1; Wed, 04 Dec 2019 15:44:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B75B800D5E;
 Wed,  4 Dec 2019 20:44:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF055691B3;
 Wed,  4 Dec 2019 20:44:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [RFC 0/3] KVM/ARM: Misc PMU fixes
Date: Wed,  4 Dec 2019 21:44:23 +0100
Message-Id: <20191204204426.9628-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: A2O5sKfkP7um__t8PatHgw-1
X-Mimecast-Spam-Score: 0
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

While writing new PMUv3 event counter KVM unit tests I found 3
things that do not seem to comply with the specification and at
least need to be confirmed.

Two are related to SW_INCR implementation: no check of the
PMCR.E bit, no support of 64b (CHAIN). From the spec,
I do not understand the SW_INCR behaves differently from
other events but I may be wrong.

The last minor thing is about the PMEVTYPER read-only bits.
On Seattle we have an 8.0 implementation which I understand
is supposed to implement only 10-bit evtCount field which is
not enforced.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v5.4-pmu-kut-fixes-v1

Eric Auger (3):
  KVM: arm64: pmu: Don't increment SW_INCR if PMCR.E is unset
  KVM: arm64: pmu: Fix chained SW_INCR counters
  KVM: arm64: pmu: Enforce PMEVTYPER evtCount size

 arch/arm64/include/asm/perf_event.h |  5 ++++-
 arch/arm64/include/asm/sysreg.h     |  5 +++++
 arch/arm64/kernel/perf_event.c      |  2 +-
 arch/arm64/kvm/sys_regs.c           | 14 ++++++++++----
 virt/kvm/arm/pmu.c                  | 19 ++++++++++++++++++-
 5 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.20.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
