Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 46819388F6
	for <lists+kvmarm@lfdr.de>; Fri,  7 Jun 2019 13:27:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E89224A521;
	Fri,  7 Jun 2019 07:27:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qeh6BNV8b8Ev; Fri,  7 Jun 2019 07:27:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B11654A3B2;
	Fri,  7 Jun 2019 07:27:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D4B454A50C
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jun 2019 07:27:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLm7hHrxVnpv for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Jun 2019 07:27:20 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 930F04A50A
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Jun 2019 07:27:19 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42DA33EF;
 Fri,  7 Jun 2019 04:27:19 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D9413F246;
 Fri,  7 Jun 2019 04:28:58 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH kvmtool v4 3/8] update_headers.sh: arm64: Copy sve_context.h
 if available
Date: Fri,  7 Jun 2019 12:26:24 +0100
Message-Id: <1559906789-20936-4-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1559906789-20936-1-git-send-email-Dave.Martin@arm.com>
References: <1559906789-20936-1-git-send-email-Dave.Martin@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Zhang Lei <zhang.lei@jp.fujitsu.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

The SVE KVM support for arm64 includes the additional backend
header <asm/sve_context.h> from <asm/kvm.h>.

So update this header if it is available.

To avoid creating a sudden dependency on a specific minimum kernel
version, ignore such optional headers if the source kernel tree
doesn't have them.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes since v3:

 * [Andre Przywara]: Quote argument to local (it turns out that some
   shells, including dash, require this).

 * [Andre Przywara]: Factor out copying of possibly-absent arch headers
   as optional_arch, for easier reuse later.
---
 util/update_headers.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/util/update_headers.sh b/util/update_headers.sh
index a7e21b8..bf87ef6 100755
--- a/util/update_headers.sh
+++ b/util/update_headers.sh
@@ -25,11 +25,23 @@ fi
 
 cp -- "$LINUX_ROOT/include/uapi/linux/kvm.h" include/linux
 
+unset KVMTOOL_PATH
+
+copy_optional_arch () {
+	local src="$LINUX_ROOT/arch/$arch/include/uapi/$1"
+
+	if [ -r "$src" ]
+	then
+		cp -- "$src" "$KVMTOOL_PATH/include/asm/"
+	fi
+}
+
 for arch in arm arm64 mips powerpc x86
 do
 	case "$arch" in
 		arm) KVMTOOL_PATH=arm/aarch32 ;;
-		arm64) KVMTOOL_PATH=arm/aarch64 ;;
+		arm64)	KVMTOOL_PATH=arm/aarch64
+			copy_optional_arch asm/sve_context.h ;;
 		*) KVMTOOL_PATH=$arch ;;
 	esac
 	cp -- "$LINUX_ROOT/arch/$arch/include/uapi/asm/kvm.h" \
-- 
2.1.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
