Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A46CF647BA6
	for <lists+kvmarm@lfdr.de>; Fri,  9 Dec 2022 02:53:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B83E4BA24;
	Thu,  8 Dec 2022 20:53:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ckd45Djuc2Xk; Thu,  8 Dec 2022 20:53:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 387354BA13;
	Thu,  8 Dec 2022 20:53:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 703054B9D8
 for <kvmarm@lists.cs.columbia.edu>; Thu,  8 Dec 2022 20:53:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pC2-acxBu62G for <kvmarm@lists.cs.columbia.edu>;
 Thu,  8 Dec 2022 20:53:35 -0500 (EST)
Received: from out-75.mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2953C4BA2B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  8 Dec 2022 20:53:35 -0500 (EST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andrew Jones <andrew.jones@linux.dev>
Subject: [PATCH v2 3/7] KVM: selftests: Mark correct page as mapped in
 virt_map()
Date: Fri,  9 Dec 2022 01:53:02 +0000
Message-Id: <20221209015307.1781352-4-oliver.upton@linux.dev>
In-Reply-To: <20221209015307.1781352-1-oliver.upton@linux.dev>
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
MIME-Version: 1.0
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

The loop marks vaddr as mapped after incrementing it by page size,
thereby marking the *next* page as mapped. Set the bit in vpages_mapped
first instead.

Fixes: 56fc7732031d ("KVM: selftests: Fill in vm->vpages_mapped bitmap in virt_map() too")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e9607eb089be..a256ec67aff6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1411,10 +1411,10 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 
 	while (npages--) {
 		virt_pg_map(vm, vaddr, paddr);
+		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
+
 		vaddr += page_size;
 		paddr += page_size;
-
-		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
 	}
 }
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
