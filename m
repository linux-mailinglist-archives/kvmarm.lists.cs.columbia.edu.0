Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3C799388FE6
	for <lists+kvmarm@lfdr.de>; Wed, 19 May 2021 16:07:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA4654B885;
	Wed, 19 May 2021 10:07:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gokFSbVrwiXz; Wed, 19 May 2021 10:07:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A104E4B871;
	Wed, 19 May 2021 10:07:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E32A4B83B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 10:07:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXGUWDNhOjkb for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 May 2021 10:07:45 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C29BC4B522
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 May 2021 10:07:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621433264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2HEEyNX6l3h40q5ftVCT45AT6Z1MSd8AC+HrprJ9ew=;
 b=K9NBd0i0dQmNUXylf0E1nuSjoAF/7LErGkTQv2AHTrXmVqtpnNL8hYCK5OMGueIlyFr0/1
 YR3+9K0FjiKxpp8hlEqn8Ffp9efwk3BSCRvrzy9k1mEkRROkwOvcv+CpuNwiZ/uhlGARD2
 38pjRrWvZrzn3LCxz+syyyNE2MwY0cE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ZTwSZ2XfOLG9IJv5OqjThg-1; Wed, 19 May 2021 10:07:43 -0400
X-MC-Unique: ZTwSZ2XfOLG9IJv5OqjThg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5FA9180FD67;
 Wed, 19 May 2021 14:07:41 +0000 (UTC)
Received: from gator.redhat.com (unknown [10.40.192.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A187C10013C1;
 Wed, 19 May 2021 14:07:39 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 3/5] KVM: arm64: selftests: get-reg-list: Provide config
 selection option
Date: Wed, 19 May 2021 16:07:24 +0200
Message-Id: <20210519140726.892632-4-drjones@redhat.com>
In-Reply-To: <20210519140726.892632-1-drjones@redhat.com>
References: <20210519140726.892632-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: maz@kernel.org, pbonzini@redhat.com
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

Add a new command line option that allows the user to select a specific
configuration, e.g. --config=sve will give the sve config. Also provide
help text and the --help/-h options.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 .../selftests/kvm/aarch64/get-reg-list.c      | 56 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 06f737973511..be1a2877d7fa 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -490,6 +490,52 @@ static void run_test(struct vcpu_config *c)
 	kvm_vm_free(vm);
 }
 
+static void help(void)
+{
+	struct vcpu_config *c;
+	int i;
+
+	printf(
+	"\n"
+	"usage: get-reg-list [--config=<selection>] [--list] [--list-filtered] [--core-reg-fixup]\n\n"
+	" --config=<selection>        Used to select a specific vcpu configuration for the test/listing\n"
+	"                             '<selection>' may be\n");
+
+	for (i = 0; i < vcpu_configs_n; ++i) {
+		c = vcpu_configs[i];
+		printf(
+	"                               '%s'\n", c->name);
+	}
+
+	printf(
+	"\n"
+	" --list                      Print the register list rather than test it (requires --config)\n"
+	" --list-filtered             Print registers that would normally be filtered out (requires --config)\n"
+	" --core-reg-fixup            Needed when running on old kernels with broken core reg listings\n"
+	"\n"
+	);
+}
+
+static struct vcpu_config *parse_config(const char *config)
+{
+	struct vcpu_config *c;
+	int i;
+
+	if (config[8] != '=')
+		help(), exit(1);
+
+	for (i = 0; i < vcpu_configs_n; ++i) {
+		c = vcpu_configs[i];
+		if (strcmp(c->name, &config[9]) == 0)
+			break;
+	}
+
+	if (i == vcpu_configs_n)
+		help(), exit(1);
+
+	return c;
+}
+
 int main(int ac, char **av)
 {
 	struct vcpu_config *c, *sel = NULL;
@@ -498,20 +544,24 @@ int main(int ac, char **av)
 	for (i = 1; i < ac; ++i) {
 		if (strcmp(av[i], "--core-reg-fixup") == 0)
 			fixup_core_regs = true;
+		else if (strncmp(av[i], "--config", 8) == 0)
+			sel = parse_config(av[i]);
 		else if (strcmp(av[i], "--list") == 0)
 			print_list = true;
 		else if (strcmp(av[i], "--list-filtered") == 0)
 			print_filtered = true;
+		else if (strcmp(av[i], "--help") == 0 || strcmp(av[1], "-h") == 0)
+			help(), exit(0);
 		else
-			TEST_FAIL("Unknown option: %s\n", av[i]);
+			help(), exit(1);
 	}
 
 	if (print_list || print_filtered) {
 		/*
 		 * We only want to print the register list of a single config.
-		 * TODO: Add command line support to pick which config.
 		 */
-		sel = vcpu_configs[0];
+		if (!sel)
+			help(), exit(1);
 	}
 
 	for (i = 0; i < vcpu_configs_n; ++i) {
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
