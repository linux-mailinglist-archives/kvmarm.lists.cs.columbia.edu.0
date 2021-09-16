Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD040E9A4
	for <lists+kvmarm@lfdr.de>; Thu, 16 Sep 2021 20:15:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 74EDA4B19A;
	Thu, 16 Sep 2021 14:15:53 -0400 (EDT)
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
	with ESMTP id i-a4Tal9YJOA; Thu, 16 Sep 2021 14:15:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 40A804B128;
	Thu, 16 Sep 2021 14:15:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F0E2E4B09C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 14:15:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id We9UdA7We0sG for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Sep 2021 14:15:49 -0400 (EDT)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EDCF04B10C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 14:15:48 -0400 (EDT)
Received: by mail-qk1-f202.google.com with SMTP id
 23-20020a05620a071700b00426392c0e6eso44845723qkc.4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kz3OtxRFyvuoMc+GBdo3WelMyguFcbw6nvQK4NKbTKo=;
 b=WGjrebjRTcERQwIM8hSLM7Nl5SVAOazwDndoUi9mjyNGkCx02qOHis4a1hPszhq0yW
 Hpks5WNyxwB/kMmupaieFv3feod8Wdj0B75fYzVvYKmlfFMCSpPeDxRIS+Aa/ODBqSIE
 hpy6lg5Dx2K7qebKQQ13Fn6X7I55PjoakM4zKMArOaD14HZ/KFbrRTx+vhAhJBeFR4YI
 rJ04K4maFwajOHK2c7o8CmX2izEPYvVchseyrggB+NJRzs7hghKXo7nPzRWu4qIPajs7
 vIDtLSVoJTB9QMBi2AJIevhOF/EgVIob83DLDBKfYj2DEaTzF1zs3va4+qd8WE3NeXba
 uxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kz3OtxRFyvuoMc+GBdo3WelMyguFcbw6nvQK4NKbTKo=;
 b=jZIomstsvt9YkcYdTbP/oDEt74m9F6jPxLHPL18fsRhPyG6jk8NB4/YZmJCKLgIq5R
 kjhSAEvhhV3vrfq2C61I9Tx+Xox69rdc/tfJLzxsWGIM6MmsFYe3b4lJwQKb1PNBA/nf
 SUqtsStkn+D0fjDLlaIvDlH4aBKlrnkJn30c3MqRHgUfn2rHNQhzOut5KmXAKzV7QCrw
 aFKEZs2WnFS+fXfUmwLEwVqJ6iXbIHotC/9OoVVO+QC75Hx0ZpWJttc2Hjs5kd6Nu5X3
 qGbuABcZmF2/ay07TRa5RI09gaoPQkshecALJVwOGKv5hNAF+uNqTctRs6en9wSYrvry
 BC1Q==
X-Gm-Message-State: AOAM5331fy3i5xsE8L+dmoxuhreQKKDKCpaR5P1mIemUAfeGV9tUBuR5
 /WOHfH0Mr5AoVcytnPvJIWXKMKcSfKQ=
X-Google-Smtp-Source: ABdhPJxkIq2pjE4hQkHq1iuBeO8+WA+QPDKfz8Iecr8PSvZkKcaqo8w22TSP1+JhIpwxYCAaCvA+D8YErlY=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a25:1345:: with SMTP id
 66mr8429706ybt.502.1631816148619; 
 Thu, 16 Sep 2021 11:15:48 -0700 (PDT)
Date: Thu, 16 Sep 2021 18:15:37 +0000
In-Reply-To: <20210916181538.968978-1-oupton@google.com>
Message-Id: <20210916181538.968978-7-oupton@google.com>
Mime-Version: 1.0
References: <20210916181538.968978-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 6/7] KVM: x86: Refactor tsc synchronization code
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 Sean Christopherson <seanjc@google.com>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

Refactor kvm_synchronize_tsc to make a new function that allows callers
to specify TSC parameters (offset, value, nanoseconds, etc.) explicitly
for the sake of participating in TSC synchronization.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/x86/kvm/x86.c | 100 ++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 29156c49cd11..1ea65bb2e74d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2447,13 +2447,68 @@ static inline bool kvm_check_tsc_unstable(void)
 	return check_tsc_unstable();
 }
 
+/*
+ * Infers attempts to synchronize the guest's tsc from host writes. Sets the
+ * offset for the vcpu and tracks the TSC matching generation that the vcpu
+ * participates in.
+ */
+static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
+				  u64 ns, bool matched)
+{
+	struct kvm *kvm = vcpu->kvm;
+	bool already_matched;
+
+	lockdep_assert_held(&kvm->arch.tsc_write_lock);
+
+	already_matched =
+	       (vcpu->arch.this_tsc_generation == kvm->arch.cur_tsc_generation);
+
+	/*
+	 * We also track th most recent recorded KHZ, write and time to
+	 * allow the matching interval to be extended at each write.
+	 */
+	kvm->arch.last_tsc_nsec = ns;
+	kvm->arch.last_tsc_write = tsc;
+	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
+
+	vcpu->arch.last_guest_tsc = tsc;
+
+	/* Keep track of which generation this VCPU has synchronized to */
+	vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
+	vcpu->arch.this_tsc_nsec = kvm->arch.cur_tsc_nsec;
+	vcpu->arch.this_tsc_write = kvm->arch.cur_tsc_write;
+
+	kvm_vcpu_write_tsc_offset(vcpu, offset);
+
+	if (!matched) {
+		/*
+		 * We split periods of matched TSC writes into generations.
+		 * For each generation, we track the original measured
+		 * nanosecond time, offset, and write, so if TSCs are in
+		 * sync, we can match exact offset, and if not, we can match
+		 * exact software computation in compute_guest_tsc()
+		 *
+		 * These values are tracked in kvm->arch.cur_xxx variables.
+		 */
+		kvm->arch.cur_tsc_generation++;
+		kvm->arch.cur_tsc_nsec = ns;
+		kvm->arch.cur_tsc_write = tsc;
+		kvm->arch.cur_tsc_offset = offset;
+
+		kvm->arch.nr_vcpus_matched_tsc = 0;
+	} else if (!already_matched) {
+		kvm->arch.nr_vcpus_matched_tsc++;
+	}
+
+	kvm_track_tsc_matching(vcpu);
+}
+
 static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 data)
 {
 	struct kvm *kvm = vcpu->kvm;
 	u64 offset, ns, elapsed;
 	unsigned long flags;
-	bool matched;
-	bool already_matched;
+	bool matched = false;
 	bool synchronizing = false;
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
@@ -2499,48 +2554,9 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 data)
 			offset = kvm_compute_l1_tsc_offset(vcpu, data);
 		}
 		matched = true;
-		already_matched = (vcpu->arch.this_tsc_generation == kvm->arch.cur_tsc_generation);
-	} else {
-		/*
-		 * We split periods of matched TSC writes into generations.
-		 * For each generation, we track the original measured
-		 * nanosecond time, offset, and write, so if TSCs are in
-		 * sync, we can match exact offset, and if not, we can match
-		 * exact software computation in compute_guest_tsc()
-		 *
-		 * These values are tracked in kvm->arch.cur_xxx variables.
-		 */
-		kvm->arch.cur_tsc_generation++;
-		kvm->arch.cur_tsc_nsec = ns;
-		kvm->arch.cur_tsc_write = data;
-		kvm->arch.cur_tsc_offset = offset;
-		matched = false;
 	}
 
-	/*
-	 * We also track th most recent recorded KHZ, write and time to
-	 * allow the matching interval to be extended at each write.
-	 */
-	kvm->arch.last_tsc_nsec = ns;
-	kvm->arch.last_tsc_write = data;
-	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
-
-	vcpu->arch.last_guest_tsc = data;
-
-	/* Keep track of which generation this VCPU has synchronized to */
-	vcpu->arch.this_tsc_generation = kvm->arch.cur_tsc_generation;
-	vcpu->arch.this_tsc_nsec = kvm->arch.cur_tsc_nsec;
-	vcpu->arch.this_tsc_write = kvm->arch.cur_tsc_write;
-
-	kvm_vcpu_write_tsc_offset(vcpu, offset);
-
-	if (!matched) {
-		kvm->arch.nr_vcpus_matched_tsc = 0;
-	} else if (!already_matched) {
-		kvm->arch.nr_vcpus_matched_tsc++;
-	}
-
-	kvm_track_tsc_matching(vcpu);
+	__kvm_synchronize_tsc(vcpu, offset, data, ns, matched);
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 }
 
-- 
2.33.0.309.g3052b89438-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
