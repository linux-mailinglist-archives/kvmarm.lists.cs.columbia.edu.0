Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 81DEA605801
	for <lists+kvmarm@lfdr.de>; Thu, 20 Oct 2022 09:13:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 00E7B4B935;
	Thu, 20 Oct 2022 03:13:04 -0400 (EDT)
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
	with ESMTP id IY4-VZP90YD5; Thu, 20 Oct 2022 03:13:03 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3CF34B91E;
	Thu, 20 Oct 2022 03:13:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 34C3C4B887
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 03:13:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FeIrZtpVFtK4 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Oct 2022 03:13:00 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 487634B92D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Oct 2022 03:13:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666249980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9FjkKJ4RB0wBhJUFjtqAZ3VQdnrJF4akYRPmacZ3lG8=;
 b=BZzP5HkwJ8qN2wmRU0SEf5YAXbEUGNHGyX1wVzR8pock7pNJLR3jPYpNolnlz96N6QuLHJ
 a4MQSERIu1yCTPfWydSmkxTa+RavovMA+VhSB9vSlouNeBMZrsnzLrVgxndqfYOcqzvGlj
 qUcbLEdJL0tnVOHKEQSMCV11Qdmqgeg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-n3h-O6ciMHaqmna_rDKDRg-1; Thu, 20 Oct 2022 03:12:55 -0400
X-MC-Unique: n3h-O6ciMHaqmna_rDKDRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E665E800186;
 Thu, 20 Oct 2022 07:12:54 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D17E540C6EC2;
 Thu, 20 Oct 2022 07:12:49 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.linux.dev
Subject: [PATCH v3 2/6] KVM: selftests: memslot_perf_test: Consolidate loop
 conditions in prepare_vm()
Date: Thu, 20 Oct 2022 15:12:05 +0800
Message-Id: <20221020071209.559062-3-gshan@redhat.com>
In-Reply-To: <20221020071209.559062-1-gshan@redhat.com>
References: <20221020071209.559062-1-gshan@redhat.com>
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

There are two loops in prepare_vm(), which have different conditions.
'slot' is treated as meory slot index in the first loop, but index of
the host virtual address array in the second loop. It makes it a bit
hard to understand the code.

Change the usage of 'slot' in the second loop, to treat it as the
memory slot index either.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/memslot_perf_test.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 231cc8449c2e..dcb492b3f27b 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -297,21 +297,20 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
 	}
 	*slot_runtime = timespec_elapsed(tstart);
 
-	for (slot = 0, guest_addr = MEM_GPA; slot < data->nslots; slot++) {
+	for (slot = 1, guest_addr = MEM_GPA; slot <= data->nslots; slot++) {
 		uint64_t npages;
 		uint64_t gpa;
 
 		npages = data->pages_per_slot;
-		if (slot == data->nslots - 1)
+		if (slot == data->nslots)
 			npages += rempages;
 
-		gpa = vm_phy_pages_alloc(data->vm, npages, guest_addr,
-					 slot + 1);
+		gpa = vm_phy_pages_alloc(data->vm, npages, guest_addr, slot);
 		TEST_ASSERT(gpa == guest_addr,
 			    "vm_phy_pages_alloc() failed\n");
 
-		data->hva_slots[slot] = addr_gpa2hva(data->vm, guest_addr);
-		memset(data->hva_slots[slot], 0, npages * 4096);
+		data->hva_slots[slot - 1] = addr_gpa2hva(data->vm, guest_addr);
+		memset(data->hva_slots[slot - 1], 0, npages * 4096);
 
 		guest_addr += npages * 4096;
 	}
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
