Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0020351E5EC
	for <lists+kvmarm@lfdr.de>; Sat,  7 May 2022 11:14:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6C84410FF;
	Sat,  7 May 2022 05:14:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id akh7RCLyKn0U; Sat,  7 May 2022 05:14:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A2D7B4B2F1;
	Sat,  7 May 2022 05:14:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDDDA4B156
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 May 2022 10:09:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rcp4gO3T9tQp for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 May 2022 10:09:29 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6C6C4B1AF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 May 2022 10:09:28 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A96E01596;
 Fri,  6 May 2022 07:09:28 -0700 (PDT)
Received: from godel.lab.cambridge.arm.com (godel.lab.cambridge.arm.com
 [10.7.66.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E823F885;
 Fri,  6 May 2022 07:09:27 -0700 (PDT)
From: Nikos Nikoleris <nikos.nikoleris@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: [kvm-unit-tests PATCH 23/23] arm64: Add an efi/run script
Date: Fri,  6 May 2022 15:08:55 +0100
Message-Id: <20220506140855.353337-24-nikos.nikoleris@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506140855.353337-1-nikos.nikoleris@arm.com>
References: <20220506140855.353337-1-nikos.nikoleris@arm.com>
MIME-Version: 1.0
X-ARM-No-Footer: FoSSMail
X-Mailman-Approved-At: Sat, 07 May 2022 05:14:38 -0400
Cc: Nikos Nikoleris <nikos.nikoleris@arm.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, jade.alglave@arm.com
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

This change adds a efi/run script inspired by the one in x86. This
script will setup a folder with the test compiled as an EFI app and a
startup.nsh script. The script launches QEMU providing an image with
EDKII and the path to the folder with the test which is executed
automatically.

For example:

$> ./arm/efi/run ./arm/selftest.efi setup smp=2 mem=256

Signed-off-by: Nikos Nikoleris <nikos.nikoleris@arm.com>
---
 scripts/runtime.bash | 14 +++++-----
 arm/efi/run          | 61 ++++++++++++++++++++++++++++++++++++++++++++
 arm/run              |  8 ++++--
 arm/Makefile.common  |  1 +
 arm/dummy.c          |  4 +++
 5 files changed, 78 insertions(+), 10 deletions(-)
 create mode 100755 arm/efi/run
 create mode 100644 arm/dummy.c

diff --git a/scripts/runtime.bash b/scripts/runtime.bash
index 7d0180b..dc28f24 100644
--- a/scripts/runtime.bash
+++ b/scripts/runtime.bash
@@ -131,14 +131,12 @@ function run()
     fi
 
     last_line=$(premature_failure > >(tail -1)) && {
-        skip=true
-        if [ "${CONFIG_EFI}" == "y" ] && [[ "${last_line}" =~ "enabling apic" ]]; then
-            skip=false
-        fi
-        if [ ${skip} == true ]; then
-            print_result "SKIP" $testname "" "$last_line"
-            return 77
-        fi
+        if [ "${CONFIG_EFI}" == "y" ] && [ "${ARCH}" = x86_64 ]; then
+		if ! [[ "${last_line}" =~ "enabling apic" ]]; then
+			print_result "SKIP" $testname "" "$last_line"
+			return 77
+		fi
+	fi
     }
 
     cmdline=$(get_cmdline $kernel)
diff --git a/arm/efi/run b/arm/efi/run
new file mode 100755
index 0000000..dfff717
--- /dev/null
+++ b/arm/efi/run
@@ -0,0 +1,61 @@
+#!/bin/bash
+
+set -e
+
+if [ $# -eq 0 ]; then
+	echo "Usage $0 TEST_CASE [QEMU_ARGS]"
+	exit 2
+fi
+
+if [ ! -f config.mak ]; then
+	echo "run './configure --enable-efi && make' first. See ./configure -h"
+	exit 2
+fi
+source config.mak
+source scripts/arch-run.bash
+source scripts/common.bash
+
+: "${EFI_SRC:=$(realpath "$(dirname "$0")/../")}"
+: "${EFI_UEFI:=/usr/share/qemu-efi-aarch64/QEMU_EFI.fd}"
+: "${EFI_TEST:=efi-tests}"
+: "${EFI_CASE:=$(basename $1 .efi)}"
+
+if [ ! -f "$EFI_UEFI" ]; then
+	echo "UEFI firmware not found: $EFI_UEFI"
+	echo "Please install the UEFI firmware to this path"
+	echo "Or specify the correct path with the env variable EFI_UEFI"
+	exit 2
+fi
+
+# Remove the TEST_CASE from $@
+shift 1
+
+# Fish out the arguments for the test, they should be the next string
+# after the "-append" option
+qemu_args=()
+cmd_args=()
+while (( "$#" )); do
+	if [ "$1" = "-append" ]; then
+		cmd_args=$2
+		shift 2
+	else
+		qemu_args+=("$1")
+		shift 1
+	fi
+done
+
+if [ "$EFI_CASE" = "_NO_FILE_4Uhere_" ]; then
+	EFI_CASE=dummy
+fi
+
+: "${EFI_CASE_DIR:="$EFI_TEST/$EFI_CASE"}"
+mkdir -p "$EFI_CASE_DIR"
+
+cp "$EFI_SRC/$EFI_CASE.efi" "$EFI_TEST/$EFI_CASE/"
+echo "@echo -off" > "$EFI_TEST/$EFI_CASE/startup.nsh"
+echo "$EFI_CASE.efi" "${cmd_args[@]}" >> "$EFI_TEST/$EFI_CASE/startup.nsh"
+
+EFI_RUN=y $TEST_DIR/run \
+       -bios "$EFI_UEFI" \
+       -drive file.dir="$EFI_TEST/$EFI_CASE/",file.driver=vvfat,file.rw=on,format=raw,if=virtio \
+       "${qemu_args[@]}"
diff --git a/arm/run b/arm/run
index 28a0b4a..e96875e 100755
--- a/arm/run
+++ b/arm/run
@@ -67,7 +67,11 @@ fi
 
 A="-accel $ACCEL"
 command="$qemu -nodefaults $M $A -cpu $processor $chr_testdev $pci_testdev"
-command+=" -display none -serial stdio -kernel"
+command+=" -display none -serial stdio"
 command="$(migration_cmd) $(timeout_cmd) $command"
 
-run_qemu $command "$@"
+if [ "$EFI_RUN" = "y" ]; then
+	ENVIRON_DEFAULT=n run_qemu $command "$@"
+else
+	run_qemu $command -kernel "$@"
+fi
diff --git a/arm/Makefile.common b/arm/Makefile.common
index a8007f4..aabd335 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -12,6 +12,7 @@ tests-common += $(TEST_DIR)/gic.$(exe)
 tests-common += $(TEST_DIR)/psci.$(exe)
 tests-common += $(TEST_DIR)/sieve.$(exe)
 tests-common += $(TEST_DIR)/pl031.$(exe)
+tests-common += $(TEST_DIR)/dummy.$(exe)
 
 tests-all = $(tests-common) $(tests)
 all: directories $(tests-all)
diff --git a/arm/dummy.c b/arm/dummy.c
new file mode 100644
index 0000000..5019e79
--- /dev/null
+++ b/arm/dummy.c
@@ -0,0 +1,4 @@
+int main(int argc, char **argv)
+{
+	return 0;
+}
-- 
2.25.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
