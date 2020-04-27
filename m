Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 161B41BA61A
	for <lists+kvmarm@lfdr.de>; Mon, 27 Apr 2020 16:17:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 93EC94B15A;
	Mon, 27 Apr 2020 10:17:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lx0GtBwrX1oT; Mon, 27 Apr 2020 10:17:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 472FD4B10E;
	Mon, 27 Apr 2020 10:17:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 694164B0AC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Apr 2020 10:17:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wsy764sIS5zx for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 Apr 2020 10:17:51 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 853B64A95C
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 Apr 2020 10:17:51 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63460206B6;
 Mon, 27 Apr 2020 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587997070;
 bh=CSSnDMC5PzLW9Ty/t6vNkRAXv5DRYOcczqebb1dCB8w=;
 h=From:To:Cc:Subject:Date:From;
 b=pzItXPTziBM5cfmNXO7kDO4LK36WFULj6A7TjQQnL4oRHAcho6MAGywU/VzBc2dPh
 4FQeR5lP2RXyYOKWneuAeGRzQaBrFaATmt9Eun8Qbn6OX0fADcX3ZpLeJbi9UEMRNu
 70GmJmp62lCh+0GfHqpNab9UNF1d11/vl78T4whA=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jT4Zw-006kdf-Qq; Mon, 27 Apr 2020 15:17:48 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	kvm@vger.kernel.org
Subject: [PATCH][kvmtool] kvm: Request VM specific limits instead of
 system-wide ones
Date: Mon, 27 Apr 2020 15:17:38 +0100
Message-Id: <20200427141738.285217-1-maz@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 will@kernel.org, Andre.Przywara@arm.com, ardb@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Andre Przywara <Andre.Przywara@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

On arm64, the maximum number of vcpus is constrained by the type
of interrupt controller that has been selected (GICv2 imposes a
limit of 8 vcpus, while GICv3 currently has a limit of 512).

It is thus important to request this limit on the VM file descriptor
rather than on the one that corresponds to /dev/kvm, as the latter
is likely to return something that doesn't take the constraints into
account.

Reported-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kvm.c b/kvm.c
index e327541..3d5173d 100644
--- a/kvm.c
+++ b/kvm.c
@@ -406,7 +406,7 @@ int kvm__recommended_cpus(struct kvm *kvm)
 {
 	int ret;
 
-	ret = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION, KVM_CAP_NR_VCPUS);
+	ret = ioctl(kvm->vm_fd, KVM_CHECK_EXTENSION, KVM_CAP_NR_VCPUS);
 	if (ret <= 0)
 		/*
 		 * api.txt states that if KVM_CAP_NR_VCPUS does not exist,
@@ -421,7 +421,7 @@ int kvm__max_cpus(struct kvm *kvm)
 {
 	int ret;
 
-	ret = ioctl(kvm->sys_fd, KVM_CHECK_EXTENSION, KVM_CAP_MAX_VCPUS);
+	ret = ioctl(kvm->vm_fd, KVM_CHECK_EXTENSION, KVM_CAP_MAX_VCPUS);
 	if (ret <= 0)
 		ret = kvm__recommended_cpus(kvm);
 
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
