Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1B6057FD
	for <lists+kvmarm@lfdr.de>; Thu, 20 Oct 2022 09:12:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C4AC74B935;
	Thu, 20 Oct 2022 03:12:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UnD16M1E7pxV; Thu, 20 Oct 2022 03:12:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 78A364B8D8;
	Thu, 20 Oct 2022 03:12:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C93CA4B87E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 03:12:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06i0PAUE67tW for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 03:12:48 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A08424B869
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 03:12:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666249968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iSbqsg4g0J+uDTur4nOLOrDlqWhjBL7zIdyxmPl56wI=;
 b=JBb5P3wSgMJfLi30+oCzV1VB7373nMV1LjGrmE5PySTrSnLcUDznAXSMJLqhevPvEPh+04
 y9A3rU8jSCrwd9X1/MrTdg+TqatO0kLy92WBGYgB92zwUCbJgd23V29Mxkv7XwDMvelXwS
 IOiTvgrqdg7L/pfQiPWFlt8kj0dfamk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-Va38NGliOg6Us14EzfvzXA-1; Thu, 20 Oct 2022 03:12:44 -0400
X-MC-Unique: Va38NGliOg6Us14EzfvzXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C45BE101A52A;
 Thu, 20 Oct 2022 07:12:43 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7703C40C6EC2;
 Thu, 20 Oct 2022 07:12:38 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.linux.dev
Subject: [PATCH v3 0/6] KVM: selftests: memslot_perf_test: aarch64
 cleanup/fixes
Date: Thu, 20 Oct 2022 15:12:03 +0800
Message-Id: <20221020071209.559062-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: mail@maciej.szmigiero.name, kvm@vger.kernel.org, maz@kernel.org,
 linux-kernel@vger.kernel.org, zhenyzha@redhat.com, shan.gavin@gmail.com,
 pbonzini@redhat.com, shuah@kernel.org, kvmarm@lists.cs.columbia.edu,
 ajones@ventanamicro.com
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

kvm/selftests/memslots_perf_test doesn't work with 64KB-page-size-host
and 4KB-page-size-guest on aarch64. In the implementation, the host and
guest page size have been hardcoded to 4KB. It's ovbiously not working
on aarch64 which supports 4KB, 16KB, 64KB individually on host and guest.

This series tries to fix it. After the series is applied, the test runs
successfully with 64KB-page-size-host and 4KB-page-size-guest.

   # ./memslots_perf_tests -v -s 512

Since we're here, the code is cleaned up a bit as PATCH[1-3] do. The
other patches are fixes to handle the mismatched host/guest page
sized.

v1: https://lore.kernel.org/kvmarm/20221014071914.227134-1-gshan@redhat.com/T/#t
v2: https://lore.kernel.org/kvmarm/20221018040454.405719-1-gshan@redhat.com/T/#t

Changelog
=========
v3:
  * Improved comments about MEM_TEST_MOVE_SIZE, which is set
    to 64KB in PATCH[v3 4/6] and finally fixed to 192KB in
    PATCH[v3 5/6].                                              (Maciej)
  * Use size instead of pages to do the comparison in
    test_memslot_move_prepare()                                 (Maciej)
  * Use tools/include/linux/sizes.h instead of inventing
    our own macros.                                             (Oliver)
v2:
  * Pick the smaller value between the ones specified by
    user or probed from KVM_CAP_NR_MEMSLOTS in PATCH[v2 3/6]    (Maciej)
  * Improved comments about MEM_TEST_MOVE_SIZE in
    PATCH[v2 4/6]                                               (Maciej)
  * Avoid mismatched guest page size after VM is started in
    prepare_vm() in PATCH[v2 4/6]                               (Maciej)
  * Fix condition to check MEM_TEST_{UNMAP, UNMAP_CHUNK}_SIZE
    in check_memory_size() in PATCH[v2 4/6]                     (Maciej)
  * Define base and huge page size in kvm_util_base.h in
    PATCH[v2 5/6]                                               (Sean)
  * Add checks on host/guest page size in check_memory_size()
    and fail early if any of them exceeds 64KB in PATCH[v2 5/6] (Maciej)


Gavin Shan (6):
  KVM: selftests: memslot_perf_test: Use data->nslots in prepare_vm()
  KVM: selftests: memslot_perf_test: Consolidate loop conditions in
    prepare_vm()
  KVM: selftests: memslot_perf_test: Probe memory slots for once
  KVM: selftests: memslot_perf_test: Support variable guest page size
  KVM: selftests: memslot_perf_test: Consolidate memory
  KVM: selftests: memslot_perf_test: Report optimal memory slots

 .../testing/selftests/kvm/memslot_perf_test.c | 317 ++++++++++++------
 1 file changed, 208 insertions(+), 109 deletions(-)

-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
