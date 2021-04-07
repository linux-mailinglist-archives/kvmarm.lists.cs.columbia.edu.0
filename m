Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E1356F23
	for <lists+kvmarm@lfdr.de>; Wed,  7 Apr 2021 16:48:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 823304B89C;
	Wed,  7 Apr 2021 10:48:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k10wGKqosweu; Wed,  7 Apr 2021 10:48:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A1BD74B8D7;
	Wed,  7 Apr 2021 10:48:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EA5BD4B885
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 10:48:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h7x2dossX8H8 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Apr 2021 10:48:42 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 795294B7E3
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 10:48:42 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A73F1435;
 Wed,  7 Apr 2021 07:48:42 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAC663F792;
 Wed,  7 Apr 2021 07:48:40 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 1/2] Documentation: KVM: Document KVM_GUESTDBG_USE_HW
 control flag for arm64
Date: Wed,  7 Apr 2021 15:48:56 +0100
Message-Id: <20210407144857.199746-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407144857.199746-1-alexandru.elisei@arm.com>
References: <20210407144857.199746-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Cc: Paolo Bonzini <pbonzini@redhat.com>
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

Commit 21b6f32f9471 ("KVM: arm64: guest debug, define API headers") added
the arm64 KVM_GUESTDBG_USE_HW flag for the KVM_SET_GUEST_DEBUG ioctl and
commit 834bf88726f0 ("KVM: arm64: enable KVM_CAP_SET_GUEST_DEBUG")
documented and implemented the flag functionality. Since its introduction,
at no point was the flag known by any name other than KVM_GUESTDBG_USE_HW
for the arm64 architecture, so refer to it as such in the documentation.

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 Documentation/virt/kvm/api.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 307f2fcf1b02..ffe15e02caca 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3335,7 +3335,8 @@ The top 16 bits of the control field are architecture specific control
 flags which can include the following:
 
   - KVM_GUESTDBG_USE_SW_BP:     using software breakpoints [x86, arm64]
-  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390, arm64]
+  - KVM_GUESTDBG_USE_HW_BP:     using hardware breakpoints [x86, s390]
+  - KVM_GUESTDBG_USE_HW:        using hardware debug events [arm64]
   - KVM_GUESTDBG_INJECT_DB:     inject DB type exception [x86]
   - KVM_GUESTDBG_INJECT_BP:     inject BP type exception [x86]
   - KVM_GUESTDBG_EXIT_PENDING:  trigger an immediate guest exit [s390]
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
