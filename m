Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA8CF3C7816
	for <lists+kvmarm@lfdr.de>; Tue, 13 Jul 2021 22:37:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A1404AEE2;
	Tue, 13 Jul 2021 16:37:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lRDviZvzjFiw; Tue, 13 Jul 2021 16:37:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2241D4A4BE;
	Tue, 13 Jul 2021 16:37:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D9FEC4A524
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 16:37:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qinqjqQoMDuj for <kvmarm@lists.cs.columbia.edu>;
 Tue, 13 Jul 2021 16:37:46 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CF1344A1A7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 16:37:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626208666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=StjhJZ4vCHXZICLvMdmlRWHHb1Np0k3u9iVCo+f4OO0=;
 b=iXDCW1Oa06FU5xg2PcydsaiF6Eq5Ljz4qBy7ZG7TlERcVKCHpMpADv9vtIV3ZhScaM04UD
 C+FQUtbXnGp2GvCQyQFOA6s2xRVjTO2bX36UOAmMHbbYjT2ZJRuRf+sM0KEjoGlONR6LyR
 6jiZg2NatY57yeDTgFzFBh9uFML8y7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-witzaIkJOcyklM0hiWrgrg-1; Tue, 13 Jul 2021 16:37:45 -0400
X-MC-Unique: witzaIkJOcyklM0hiWrgrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB9D919200C0;
 Tue, 13 Jul 2021 20:37:43 +0000 (UTC)
Received: from gator.redhat.com (unknown [10.22.8.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CF4510016F8;
 Tue, 13 Jul 2021 20:37:43 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/2] KVM: selftests: a couple fixes
Date: Tue, 13 Jul 2021 22:37:40 +0200
Message-Id: <20210713203742.29680-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

The first removes a compiler warning. The second does what a 6 patch
patch series wanted to do, but apparently got too distracted with
the preparation refactoring to actually do...

Andrew Jones (2):
  KVM: selftests: change pthread_yield to sched_yield
  KVM: arm64: selftests: get-reg-list: actually enable pmu regs in pmu
    sublist

 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 3 ++-
 tools/testing/selftests/kvm/steal_time.c           | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
