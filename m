Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 628BA2C565E
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 14:46:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D495A4BD17;
	Thu, 26 Nov 2020 08:46:50 -0500 (EST)
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
	with ESMTP id NZQp-+ZWLwF2; Thu, 26 Nov 2020 08:46:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C16754B9F7;
	Thu, 26 Nov 2020 08:46:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D21264B747
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 08:46:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HI0fUJpgYywY for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 08:46:47 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D434F4B6B1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 08:46:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606398407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jbEexOfgcLFYaQsECYOca5p/Nm1XbLoVmOwp9Ym00nY=;
 b=OxEnoGUFdpw0WcAr0cm9EkzOIEJPOi/Ol3DabfqV3XPhWNprEINjTl8ZV2JnSYA0tq1H33
 KxCI96RaG+wrChGUCmWTGoljHi9bEzyyBPth7qiWKfsenBw/qcbKBsKPdeMpmiLuk5UXwT
 5qsF659//gRc+Fg7gDRp0XGHI5ZRCPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-wUDATl2NOrmSlKJ4D_Pw6Q-1; Thu, 26 Nov 2020 08:46:45 -0500
X-MC-Unique: wUDATl2NOrmSlKJ4D_Pw6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73821805BFA;
 Thu, 26 Nov 2020 13:46:44 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF6B310016F7;
 Thu, 26 Nov 2020 13:46:42 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/2] KVM: arm64: Fix DEMUX register access
Date: Thu, 26 Nov 2020 14:46:39 +0100
Message-Id: <20201126134641.35231-1-drjones@redhat.com>
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

The first patch is a fix, but not one likely to ever truly be needed,
as it's unlikely to find seven levels of cache. The bug was found
while code reading. Writing the second patch was actually why I was
reading the code. The issue being fixed for the get-reg-list test was
found when running it on a different machine than what was used to
develop it.

Thanks,
drew

Andrew Jones (2):
  KVM: arm64: CSSELR_EL1 max is 13
  KVM: selftests: Filter out DEMUX registers

 arch/arm64/kvm/sys_regs.c                     |  2 +-
 .../selftests/kvm/aarch64/get-reg-list.c      | 39 ++++++++++++++-----
 2 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
