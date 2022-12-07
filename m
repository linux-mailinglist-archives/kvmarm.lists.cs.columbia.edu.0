Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29064636E
	for <lists+kvmarm@lfdr.de>; Wed,  7 Dec 2022 22:48:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25CB14B859;
	Wed,  7 Dec 2022 16:48:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lhTwj9qPDFgW; Wed,  7 Dec 2022 16:48:40 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B08D94B811;
	Wed,  7 Dec 2022 16:48:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C45024B7F6
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Dec 2022 16:48:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SsMkcCegI7Yu for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Dec 2022 16:48:35 -0500 (EST)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 968204B84B
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Dec 2022 16:48:35 -0500 (EST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1670449714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DyLxs3HyIoF5wx9VX+BHFSEjjnbDaZ4BqGRsxySYTU=;
 b=ezeBgIrapc0Yr+sy6EGzPWIC5Jvm36lxzF1ASa6A4Z3hmSRNYzMMaQSam4w8KPu85HkMXB
 fnAOl2c3FSG9VrCYbXt/O0Y1yj0US4HOM9g+eBr1nabRFom+i0iPi0WNhgUHF32YNirkYn
 B1AafIwUyT0gRbFNqHcwh/v+ZOnK/1A=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Jones <andrew.jones@linux.dev>,
 Sean Christopherson <seanjc@google.com>, Peter Gonda <pgonda@google.com>
Subject: [PATCH 4/4] KVM: selftests: Allocate ucall pool from MEM_REGION_DATA
Date: Wed,  7 Dec 2022 21:48:08 +0000
Message-Id: <20221207214809.489070-5-oliver.upton@linux.dev>
In-Reply-To: <20221207214809.489070-1-oliver.upton@linux.dev>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

MEM_REGION_TEST_DATA is meant to hold data explicitly used by a
selftest, not implicit allocations due to the selftests infrastructure.
Allocate the ucall pool from MEM_REGION_DATA much like the rest of the
selftests library allocations.

Fixes: 426729b2cf2e ("KVM: selftests: Add ucall pool based implementation")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/lib/ucall_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 820ce6c82829..0cc0971ce60e 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -22,7 +22,7 @@ void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa)
 	vm_vaddr_t vaddr;
 	int i;
 
-	vaddr = vm_vaddr_alloc(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR);
+	vaddr = __vm_vaddr_alloc(vm, sizeof(*hdr), KVM_UTIL_MIN_VADDR, MEM_REGION_DATA);
 	hdr = (struct ucall_header *)addr_gva2hva(vm, vaddr);
 	memset(hdr, 0, sizeof(*hdr));
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
