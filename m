Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 64A1333AA53
	for <lists+kvmarm@lfdr.de>; Mon, 15 Mar 2021 05:19:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 87DA04B3B5;
	Mon, 15 Mar 2021 00:19:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hJrnQx3YIEyc; Mon, 15 Mar 2021 00:19:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 56F134B50B;
	Mon, 15 Mar 2021 00:19:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C82CB4B3B5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 00:19:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LS66s-gTpGLS for <kvmarm@lists.cs.columbia.edu>;
 Mon, 15 Mar 2021 00:19:02 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E256D4B3B4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 15 Mar 2021 00:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615781942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aKj/5CA1P2uSnEV3uJxCfOdpLBFnK+/ZnKmjfmOEBg0=;
 b=R5gPGERM2Fy9P+tiBtnKuRwK83jEEy9rq9RvolV5V4H8KPwbZP0GqkZ/N1ax6SfE9FRVKb
 qCOId09mhFfB6V14bFfNQw3gvAldm9M3oEC5ObtrbGr3lOjxYRxYca3mqAzdjFaL/ofJnB
 kaN8XDZwYq9AT73yUNtkdjObrtRIooE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-iehVtjabMYu8qajrojFgkA-1; Mon, 15 Mar 2021 00:18:58 -0400
X-MC-Unique: iehVtjabMYu8qajrojFgkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A8FB801817;
 Mon, 15 Mar 2021 04:18:57 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-175.bne.redhat.com [10.64.54.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 441C7437F;
 Mon, 15 Mar 2021 04:18:54 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 0/4] KVM: arm64: Minor page fault handler improvement
Date: Mon, 15 Mar 2021 12:18:40 +0800
Message-Id: <20210315041844.64915-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: maz@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com
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

The series includes several minior improvements to stage-2 page fault
handler: PATCH[1/2] are cleaning up the code. PATCH[3] fixes the address
range check on adding new memory slot. PATCH[4] don't retrieve the memory
slot again in the page fault handler to save a bit CPU cycles.

Gavin Shan (4):
  KVM: arm64: Hide kvm_mmu_wp_memory_region()
  KVM: arm64: Use find_vma_intersection()
  KVM: arm64: Fix address check for memory slot
  KVM: arm64: Don't retrieve memory slot again in page fault handler

 arch/arm64/include/asm/kvm_host.h |  1 -
 arch/arm64/kvm/mmu.c              | 19 +++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
