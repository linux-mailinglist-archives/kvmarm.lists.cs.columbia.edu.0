Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 760D02511F5
	for <lists+kvmarm@lfdr.de>; Tue, 25 Aug 2020 08:19:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8F134BC51;
	Tue, 25 Aug 2020 02:19:15 -0400 (EDT)
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
	with ESMTP id 73fQgvWzPv10; Tue, 25 Aug 2020 02:19:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EA0F74BDD1;
	Tue, 25 Aug 2020 02:19:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F33A4BC63
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 02:19:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OkOzQEf9rNeR for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Aug 2020 02:19:13 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 26A174BBFB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 02:19:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598336352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RvA922pQUGglO3LpWulLD/1UU/DQ6njMXFjJrfBG3U0=;
 b=Ag2s3kB3Mkj/TrylWwwidGwouRuWY9oxNOkLzj07cecKv9y3sjiyLKqVA1Yi3HEYdfm0i+
 NZsPxPTs7TRbh8ceNM7BcVlp86snyIc0yyGD2+rcovd2CZyA/TRlFY3xImGZW15fQc2lj9
 +W8yJxwZCsZ2X6zwGo5hes1NWYA1MUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Jdugw081P1GAPU73QVhPOw-1; Tue, 25 Aug 2020 02:19:10 -0400
X-MC-Unique: Jdugw081P1GAPU73QVhPOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EDD680ED9A;
 Tue, 25 Aug 2020 06:19:09 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-33.bne.redhat.com [10.64.54.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 803AE100AE5B;
 Tue, 25 Aug 2020 06:19:07 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 1/2] arm64/kvm: Drop unnecessary check in
 kvm_vcpu_preferred_target()
Date: Tue, 25 Aug 2020 16:18:55 +1000
Message-Id: <20200825061856.25382-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: maz@kernel.org, linux-kernel@vger.kernel.org
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

Since commit <bca556ac468a> ("arm64/kvm: Add generic v8 KVM target"),
there is no negative number returned from kvm_target_cpu(). So it's
not needed to validate its return value in kvm_vcpu_preferred_target()
and this just drops the unnecessary check.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/guest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index dfb5218137ca..2365449ea32e 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -835,9 +835,6 @@ int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
 {
 	int target = kvm_target_cpu();
 
-	if (target < 0)
-		return -ENODEV;
-
 	memset(init, 0, sizeof(*init));
 
 	/*
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
