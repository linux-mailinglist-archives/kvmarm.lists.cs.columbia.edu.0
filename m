Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6632819E59E
	for <lists+kvmarm@lfdr.de>; Sat,  4 Apr 2020 16:38:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A8094B1EF;
	Sat,  4 Apr 2020 10:38:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14zka0enpjGD; Sat,  4 Apr 2020 10:38:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C6D664B1E2;
	Sat,  4 Apr 2020 10:37:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 21CD44B1E1
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:37:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3rwLIpTG5lxO for <kvmarm@lists.cs.columbia.edu>;
 Sat,  4 Apr 2020 10:37:56 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2E8454B1CE
 for <kvmarm@lists.cs.columbia.edu>; Sat,  4 Apr 2020 10:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586011076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TH7o6uPii+FVWXIRQDwrHwi8uTL0Zd9SNThpzh1Yhs=;
 b=axxVR5v+RL5nxtCS+ru3FnMTEtQpustGR9fQVFKCglWZqyLQQJTcaxAsqgwqjA4fsWgBB2
 y+9J6UxaJ24KDMMa7BlZQqptjJsr3Y6xPG/OAUMhxhehpEp2e8bUaw66eXWC8+dccjoVdW
 NmLSD/l6TAgWVeA5/xopP4Qyk/CTXyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-jqwY0IBlPfCljN1pw65vkw-1; Sat, 04 Apr 2020 10:37:53 -0400
X-MC-Unique: jqwY0IBlPfCljN1pw65vkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD5B107B113;
 Sat,  4 Apr 2020 14:37:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42CBA9B912;
 Sat,  4 Apr 2020 14:37:35 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: pbonzini@redhat.com
Subject: [PULL kvm-unit-tests 01/39] Makefile: Use no-stack-protector compiler
 options
Date: Sat,  4 Apr 2020 16:36:53 +0200
Message-Id: <20200404143731.208138-2-drjones@redhat.com>
In-Reply-To: <20200404143731.208138-1-drjones@redhat.com>
References: <20200404143731.208138-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, kvmarm@lists.cs.columbia.edu
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

From: Alexandru Elisei <alexandru.elisei@arm.com>

Let's fix the typos so that the -fno-stack-protector and
-fno-stack-protector-all compiler options are actually used.

Tested by compiling for arm64, x86_64 and ppc64 little endian. Before the
patch, the arguments were missing from the gcc invocation; after the patch,
they were present. Also fixes a compilation error that I was seeing with
aarch64 gcc version 9.2.0, where the linker was complaining about an
undefined reference to the symbol __stack_chk_guard.

Fixes: e5c73790f5f0 ("build: don't reevaluate cc-option shell command")
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Drew Jones <drjones@redhat.com>
CC: Laurent Vivier <lvivier@redhat.com>
CC: Thomas Huth <thuth@redhat.com>
CC: David Hildenbrand <david@redhat.com>
CC: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 767b6c6a51d0..754ed65ecd2f 100644
--- a/Makefile
+++ b/Makefile
@@ -55,8 +55,8 @@ COMMON_CFLAGS += -Wignored-qualifiers -Werror
 
 frame-pointer-flag=-f$(if $(KEEP_FRAME_POINTER),no-,)omit-frame-pointer
 fomit_frame_pointer := $(call cc-option, $(frame-pointer-flag), "")
-fnostack_protector := $(call cc-option, -fno-stack-protector, "")
-fnostack_protector_all := $(call cc-option, -fno-stack-protector-all, "")
+fno_stack_protector := $(call cc-option, -fno-stack-protector, "")
+fno_stack_protector_all := $(call cc-option, -fno-stack-protector-all, "")
 wno_frame_address := $(call cc-option, -Wno-frame-address, "")
 fno_pic := $(call cc-option, -fno-pic, "")
 no_pie := $(call cc-option, -no-pie, "")
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
