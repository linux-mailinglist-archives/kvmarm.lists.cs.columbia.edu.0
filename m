Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7554B9E7D
	for <lists+kvmarm@lfdr.de>; Thu, 17 Feb 2022 12:21:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 898DA49E0E;
	Thu, 17 Feb 2022 06:21:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hp5dZ+MtVt5n; Thu, 17 Feb 2022 06:21:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EEF2649E35;
	Thu, 17 Feb 2022 06:21:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8741249E1B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Feb 2022 05:28:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LH2yCI3yzTYI for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Feb 2022 05:28:19 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4209649DE3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Feb 2022 05:28:19 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C3B3D6E;
 Thu, 17 Feb 2022 02:28:18 -0800 (PST)
Received: from Q2TWYV475D.emea.arm.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DAE83F718;
 Thu, 17 Feb 2022 02:28:17 -0800 (PST)
From: Nikos Nikoleris <nikos.nikoleris@arm.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, drjones@redhat.com,
 pbonzini@redhat.com, thuth@redhat.com
Subject: [kvm-unit-tests PATCH] configure: arm: Fixes to build and run tests
 on Apple Silicon
Date: Thu, 17 Feb 2022 10:28:06 +0000
Message-Id: <20220217102806.28749-1-nikos.nikoleris@arm.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 17 Feb 2022 06:21:51 -0500
Cc: Nikos Nikoleris <nikos.nikoleris@arm.com>, jade.alglave@arm.com
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

On MacOS:

$> uname -m

returns:

arm64

To unify how we handle the achitecture detection across different
systems, sed it to aarch64 which is what's typically reported on
Linux.

In addition, when HVF is the acceleration method on aarch64, make sure
we select the right processor when invoking qemu.

Signed-off-by: Nikos Nikoleris <nikos.nikoleris@arm.com>
---
 arm/run   | 3 +++
 configure | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arm/run b/arm/run
index 2153bd3..0629b69 100755
--- a/arm/run
+++ b/arm/run
@@ -27,6 +27,9 @@ if [ "$ACCEL" = "kvm" ]; then
 	if $qemu $M,\? 2>&1 | grep gic-version > /dev/null; then
 		M+=',gic-version=host'
 	fi
+fi
+
+if [ "$ACCEL" = "kvm" ] || [ "$ACCEL" = "hvf" ]; then
 	if [ "$HOST" = "aarch64" ] || [ "$HOST" = "arm" ]; then
 		processor="host"
 		if [ "$ARCH" = "arm" ] && [ "$HOST" = "aarch64" ]; then
diff --git a/configure b/configure
index 2d9c3e0..ff840c1 100755
--- a/configure
+++ b/configure
@@ -14,7 +14,7 @@ objcopy=objcopy
 objdump=objdump
 ar=ar
 addr2line=addr2line
-arch=$(uname -m | sed -e 's/i.86/i386/;s/arm.*/arm/;s/ppc64.*/ppc64/')
+arch=$(uname -m | sed -e 's/i.86/i386/;s/arm64/aarch64/;s/arm.*/arm/;s/ppc64.*/ppc64/')
 host=$arch
 cross_prefix=
 endian=""
-- 
2.32.0 (Apple Git-132)

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
