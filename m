Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA83C7818
	for <lists+kvmarm@lfdr.de>; Tue, 13 Jul 2021 22:37:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E32E4A524;
	Tue, 13 Jul 2021 16:37:53 -0400 (EDT)
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
	with ESMTP id Pt1ZF4CNlFWr; Tue, 13 Jul 2021 16:37:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 63A574A98B;
	Tue, 13 Jul 2021 16:37:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B20BB4A1A7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 16:37:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Npg1VCo-4dEK for <kvmarm@lists.cs.columbia.edu>;
 Tue, 13 Jul 2021 16:37:50 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B731E4B080
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 16:37:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626208670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3BE+KBwmpKZs3HfTywA3YepA+ZFEmEvW/zZIsH9yzY=;
 b=RSiTasrrkkcUCvGQfgbwbkzahvoA27ma8ujhBPbhvefVc50fb5TSxjRywZo8/wuWdAAbgo
 EMVcVIHTEy+SYfDGSZKJiBpxShpc/MZdEaLj/YR6tfUGsD220o1Mgke55PzpllSzD7janV
 1AQE7Z90ELfUoPmhfCUm8h3ISS/nVLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-OxfjYbIcPK2i_muuum3CcA-1; Tue, 13 Jul 2021 16:37:47 -0400
X-MC-Unique: OxfjYbIcPK2i_muuum3CcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CB3E804145;
 Tue, 13 Jul 2021 20:37:46 +0000 (UTC)
Received: from gator.redhat.com (unknown [10.22.8.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A4581002D71;
 Tue, 13 Jul 2021 20:37:44 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.cs.columbia.edu
Subject: [PATCH 2/2] KVM: arm64: selftests: get-reg-list: actually enable pmu
 regs in pmu sublist
Date: Tue, 13 Jul 2021 22:37:42 +0200
Message-Id: <20210713203742.29680-3-drjones@redhat.com>
In-Reply-To: <20210713203742.29680-1-drjones@redhat.com>
References: <20210713203742.29680-1-drjones@redhat.com>
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

We reworked get-reg-list to make it easier to enable optional register
sublists by parametrizing their vcpu feature flags as well as making
other generalizations. That was all to make sure we enable the PMU
registers when we want to test them. Somehow we forgot to actually
include the PMU feature flag in the PMU sublist description though!
Do that now.

Fixes: 313673bad871 ("KVM: arm64: selftests: get-reg-list: Split base and pmu registers")
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index a16c8f05366c..cc898181faab 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -1019,7 +1019,8 @@ static __u64 sve_rejects_set[] = {
 #define VREGS_SUBLIST \
 	{ "vregs", .regs = vregs, .regs_n = ARRAY_SIZE(vregs), }
 #define PMU_SUBLIST \
-	{ "pmu", .regs = pmu_regs, .regs_n = ARRAY_SIZE(pmu_regs), }
+	{ "pmu", .capability = KVM_CAP_ARM_PMU_V3, .feature = KVM_ARM_VCPU_PMU_V3, \
+	  .regs = pmu_regs, .regs_n = ARRAY_SIZE(pmu_regs), }
 #define SVE_SUBLIST \
 	{ "sve", .capability = KVM_CAP_ARM_SVE, .feature = KVM_ARM_VCPU_SVE, .finalize = true, \
 	  .regs = sve_regs, .regs_n = ARRAY_SIZE(sve_regs), \
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
