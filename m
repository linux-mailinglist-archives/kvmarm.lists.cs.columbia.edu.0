Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE7413822
	for <lists+kvmarm@lfdr.de>; Tue, 21 Sep 2021 19:11:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9276B4A500;
	Tue, 21 Sep 2021 13:11:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWVCch-hqUjP; Tue, 21 Sep 2021 13:11:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 724304B08A;
	Tue, 21 Sep 2021 13:11:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 129D449F6C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 13:11:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wMBbPFhEXVFE for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Sep 2021 13:11:27 -0400 (EDT)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 263944A193
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 13:11:27 -0400 (EDT)
Received: by mail-qv1-f74.google.com with SMTP id
 h18-20020ad446f2000000b0037a7b48ba05so167101qvw.19
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jbjtkKJClRIdxDxc/X394uGXktg3U8/Y+QRIQienfdo=;
 b=mWyNrrEh7r2ySTiW4Dae4QnrEPDgY8hXI/P5NufdPFUir6Y5L1t9mujB8p860FHuh1
 SkaMHh2ZuA1gBH/UCa5MOFmkQh4d6dDm9uxwx/G2ArlH+4Oim4gB5YUHp83i4cMlNyIK
 18rU1nqfj0abE/L6uEOAHDD27ah2ztfzg9ixYn08nweN6UI9yBG2sX3EFrUH/vRUJRT+
 mYKQYyPIk7W0nOqEqZGnfNAakiuSl4Myn4dFO9vmOUe0ckxXrfENjdZuPxFYuDZQ4kV1
 KcfN2jvnXwIQnQ0MkHp9bYrkYsS9+EMUpup7y93HrhHcrN5jcH7ADq655ZTZFj4qScZH
 xDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jbjtkKJClRIdxDxc/X394uGXktg3U8/Y+QRIQienfdo=;
 b=tQMYIpwT7xYMpxloMOyCrfpf42NFnlNGH3X7wTiA3kd0d2EQ2quU1zu9llOWuVSaBg
 CpTB8uvWSabR3NLR2IknzhaSjgePbZTZ5jlRT8yd1V3A3LX9v4sQ2LWRjMEWUV0zm5Um
 cDdDUuvfgCOglmWYcak41g9OW4msq+jsfFjvhrJQKmN80QIC15QfAbWGqiA2qrXIkT05
 VCpQgENJVms5el8t1e6QbR+wpoMetBLdjpFQ455MqOSgszYAZK4QJEdtbqnc3Y5gC8C+
 CxFfwHeC4SbGHVZaJHf0idktaH6pk3+BUlAG4Tcls65KYcrb5whV3FqgMkrlSvdztV3B
 mmZw==
X-Gm-Message-State: AOAM530DtmBEpl+IhQZOzIKSi7K6BtPBDHLz3gHwZGfklp3DlKqxpjhA
 eQ0bIZFCCgkmWUe+RulNUDOqz/dy5EE=
X-Google-Smtp-Source: ABdhPJwfa7oXjKMcTr6hpyAwdrgF4UuepCosJxs3eddjQEmY8Byeb5DZI6myHOWAQLWj8DDqFVtOMt3A/Zw=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a25:424a:: with SMTP id
 p71mr41188110yba.243.1632244286770; 
 Tue, 21 Sep 2021 10:11:26 -0700 (PDT)
Date: Tue, 21 Sep 2021 17:11:21 +0000
In-Reply-To: <20210921171121.2148982-1-oupton@google.com>
Message-Id: <20210921171121.2148982-3-oupton@google.com>
Mime-Version: 1.0
References: <20210921171121.2148982-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 2/2] selftests: KVM: Align SMCCC call with the spec in
 steal_time
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>
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

The SMC64 calling convention passes a function identifier in w0 and its
parameters in x1-x17. Given this, there are two deviations in the
SMC64 call performed by the steal_time test: the function identifier is
assigned to a 64 bit register and the parameter is only 32 bits wide.

Align the call with the SMCCC by using a 32 bit register to handle the
function identifier and increasing the parameter width to 64 bits.

Suggested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
 tools/testing/selftests/kvm/steal_time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index ecec30865a74..aafaa8e38b7c 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -118,12 +118,12 @@ struct st_time {
 	uint64_t st_time;
 };
 
-static int64_t smccc(uint32_t func, uint32_t arg)
+static int64_t smccc(uint32_t func, uint64_t arg)
 {
 	unsigned long ret;
 
 	asm volatile(
-		"mov	x0, %1\n"
+		"mov	w0, %w1\n"
 		"mov	x1, %2\n"
 		"hvc	#0\n"
 		"mov	%0, x0\n"
-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
