Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 636384C13D9
	for <lists+kvmarm@lfdr.de>; Wed, 23 Feb 2022 14:16:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A84D84C4F9;
	Wed, 23 Feb 2022 08:16:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4VhJR2-RQmAk; Wed, 23 Feb 2022 08:16:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A1B44C4F3;
	Wed, 23 Feb 2022 08:16:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 84A544C4E5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Feb 2022 08:16:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9OzXcFn7lji for <kvmarm@lists.cs.columbia.edu>;
 Wed, 23 Feb 2022 08:16:32 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 56EF54C4C6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 23 Feb 2022 08:16:32 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CEE1F61538;
 Wed, 23 Feb 2022 13:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7F2C340F0;
 Wed, 23 Feb 2022 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645622190;
 bh=7giPPViJQLW4TJDXyefdXReC4DqhaghKKKLPGlhBsrM=;
 h=From:To:Cc:Subject:Date:From;
 b=ECzbP1wI/3YSJF6MmUe3UGA2D7WBtJ3vRxfRg88Q+FKVPGZKv8lK24ZdgcLDIy/2C
 9IajtJyZDAzvL2YNZBuCredpFMYEp1EZMW7JuP1XT7Pz6RxGv9Rujc69qg5Jpvh60F
 JjgnVUQIwn8/8/yVAYg9fXCR3qccSI2s/IpaJqExeOb/Zs1Emk1yck7Z3IAuKek2p0
 nXiVzc+1Cy6gQkYAJNhVdnsToga17j9ybhYu/5lf0s+Q7uWHfrf/9DMcf4yR8FcnnA
 1j6trUyrV6TM55aLLNQGZzfo+b+/QJZ8sMX3Q7O0agycTXQeS4fzUllCz98YQpOQ7B
 W7SdsG1yCSPVQ==
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH RESEND] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Date: Wed, 23 Feb 2022 13:16:24 +0000
Message-Id: <20220223131624.1830351-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; h=from:subject;
 bh=7giPPViJQLW4TJDXyefdXReC4DqhaghKKKLPGlhBsrM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiFZLefp46KmCJ8r9QtbSIALLb0ccj+w6zViEcLhue
 sBAr1k+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhWS3gAKCRAk1otyXVSH0EU8B/
 9Qhx6OjS/ldbA5e8/RMxNzZDT0Lq3o0mI53Mxb2jmZX0b0aw4XLbem1Bc/GSbcF3VHjgwCl7+deMwK
 hvXOwgDkOrjLn208Eomqq1cnul7Iedh9F2xjrzVv+rOU3QsDEi0VO7DXG5T90dC5Wpm8sfmYh0ajNO
 KZ3uwZIzh5qoFyPb5s1e0QPA5k+UOuqpkml5lvzCZ+YFDJggwXDUlWi65gf/tIFPgPhNJQvMNpsAHr
 jnDHgV02r5Wg4njFqONqyYn4aOpkgwcQnCRSZpjbdM0dDt3MpOvVA30Z4AgNzfiKrkl7TfLksK54h2
 VoGU/aRXQ/OHICnpuzUhtetun61gzi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Cc: kvm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

The arch_timer and vgic_irq kselftests assume that they can create a
vgic-v3, using the library function vgic_v3_setup() which aborts with a
test failure if it is not possible to do so. Since vgic-v3 can only be
instantiated on systems where the host has GICv3 this leads to false
positives on older systems where that is not the case.

Fix this by changing vgic_v3_setup() to return an error if the vgic can't
be instantiated and have the callers skip if this happens. We could also
exit flagging a skip in vgic_v3_setup() but this would prevent future test
cases conditionally deciding which GIC to use or generally doing more
complex output.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Ricardo Koller <ricarkol@google.com>
---
 tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
 tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 4 ++++
 tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 4 +++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 9ad38bd360a4..b08d30bf71c5 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -366,6 +366,7 @@ static struct kvm_vm *test_vm_create(void)
 {
 	struct kvm_vm *vm;
 	unsigned int i;
+	int ret;
 	int nr_vcpus = test_args.nr_vcpus;
 
 	vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
@@ -382,7 +383,11 @@ static struct kvm_vm *test_vm_create(void)
 
 	ucall_init(vm, NULL);
 	test_init_timer_irq(vm);
-	vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
+	ret = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
+	if (ret < 0) {
+		print_skip("Failed to create vgic-v3");
+		exit(KSFT_SKIP);
+	}
 
 	/* Make all the test's cmdline args visible to the guest */
 	sync_global_to_guest(vm, test_args);
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index f0230711fbe9..554ca649d470 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -767,6 +767,10 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 
 	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
 			GICD_BASE_GPA, GICR_BASE_GPA);
+	if (gic_fd < 0) {
+		print_skip("Failed to create vgic-v3, skipping");
+		exit(KSFT_SKIP);
+	}
 
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
 		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
index f365c32a7296..5d45046c1b80 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
@@ -52,7 +52,9 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
 			nr_vcpus, nr_vcpus_created);
 
 	/* Distributor setup */
-	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	if (_kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3,
+			       false, &gic_fd) != 0)
+		return -1;
 
 	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
 			0, &nr_irqs, true);
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
