Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 407C8221490
	for <lists+kvmarm@lfdr.de>; Wed, 15 Jul 2020 20:45:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E890A4B3E0;
	Wed, 15 Jul 2020 14:45:32 -0400 (EDT)
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
	with ESMTP id SHTIrOTjxk-W; Wed, 15 Jul 2020 14:45:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BCE534B3DC;
	Wed, 15 Jul 2020 14:45:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A6274B314
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 14:45:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjzOIKZfYFtA for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Jul 2020 14:45:29 -0400 (EDT)
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2CB1A4B381
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 14:45:29 -0400 (EDT)
Received: by mail-wm1-f74.google.com with SMTP id l5so1750833wml.7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Jul 2020 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=DdxW5bWPjF7WiqULCWM0TFle6+z3CGUtYWg99SV1BbQ=;
 b=o6xqu6jbaRGrjG+6LzgyQV6iRGAw2l9F9hxOvPoxRQ1rzFc4LwpgnVsLWhjbGyVLpB
 yMVz8L9+juyIu/l37oMEZ1r4rx3yZbCV5QkEJotMeyBFXkZPNW63iB5OHCzyFFHTO2aa
 n7JZU6PNmZk0/9M1SLrhVUziWsQJgJwC7EaMxEheSu0+l5qiYpAK6W0YF5Zbk9mFEg5m
 ehWam8DsG2nTiFIPH55CmbMp0UFhlvoC7xmCSkkXS4s6fhho3BE3sNXGSedflZP6Wy1X
 aVdq63YPEPQsVDesJ29Fzi2QUbomotw+6OSBaxvrUsu0l42Rl7TTEvgbmzCQ0mfzKiAP
 uqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DdxW5bWPjF7WiqULCWM0TFle6+z3CGUtYWg99SV1BbQ=;
 b=thE5EOpjf61reac2+HYD0hMRhkrOCCwd6c2jEtj06F7OCN41vH5Lii9AnAbAc0Gmw2
 VUOnstBkxDtnDq/lHu2q1twvCy7L+J2Dgo2rTS8xYJcIOm8DFMn/jbCnt/24lPiyQiXi
 L6GpziM4bG24RTkwucqsKlOPkktluEtt+6sx36CFXl9KCf8fNDKwQUhKYz4WUR/hR2qq
 +nC4BWlTgtxHfTjBmY89PfT8IiNLGqJkGRWfP3dqPgw7ErvRhv69/RGBbkn5uW0z0IHB
 qHO5Zz9b1o9sQZPZGoYp6F52Z196oiCROLZlbjwKbgt/Z8uDZ71vTyR6pgRiOAY83+OD
 ABBg==
X-Gm-Message-State: AOAM5301HhpKXBEGS4d7nhAMaCFYRcm88dEo6xZyiQhDViMzZ6LRmSB0
 f9prEXONPX35ZzEKHgtLJ8ZekIywkneenVvVKEapsV8s47GazSlfFtSq7oWqmkNT19rLixiZJMK
 6gnVz+qkQbla8efVpbnM8XLVTWA4GU9b5DTUM+BQuFHlfvQnuAwhOFw9S9lNqY+swFgwK4g==
X-Google-Smtp-Source: ABdhPJz+AI6jBPWhPt48UgkdIvHQPFShmmtSw1DVZ0H1XIU8MA+t06WJ50cV8OYZgUl+0wRMBaILjA4rzAg=
X-Received: by 2002:adf:81c7:: with SMTP id 65mr686489wra.47.1594838728237;
 Wed, 15 Jul 2020 11:45:28 -0700 (PDT)
Date: Wed, 15 Jul 2020 19:44:19 +0100
In-Reply-To: <20200715184438.1390996-1-ascull@google.com>
Message-Id: <20200715184438.1390996-19-ascull@google.com>
Mime-Version: 1.0
References: <20200715184438.1390996-1-ascull@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH 18/37] KVM: arm64: nVHE: Access pmu_events directly in
 kvm_host_data
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: maz@kernel.org, kernel-team@android.com
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

The assumption that kvm_host_data is the container of the host
kvm_cpu_context will not be true when the migration into kvm_host_vcpu
has completed. Fortunately, a reference to kvm_host_data can easily be
gained as it is a percpu variable.

Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/kvm/hyp/nvhe/switch.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index ac19f98bdb60..8cd280a18dc2 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -119,13 +119,9 @@ static void __hyp_vgic_restore_state(struct kvm_vcpu *vcpu)
 /**
  * Disable host events, enable guest events
  */
-static void __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
+static void __pmu_switch_to_guest(void)
 {
-	struct kvm_host_data *host;
-	struct kvm_pmu_events *pmu;
-
-	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
-	pmu = &host->pmu_events;
+	struct kvm_pmu_events *pmu = &__hyp_this_cpu_ptr(kvm_host_data)->pmu_events;
 
 	if (pmu->events_host)
 		write_sysreg(pmu->events_host, pmcntenclr_el0);
@@ -137,13 +133,9 @@ static void __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
 /**
  * Disable guest events, enable host events
  */
-static void __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
+static void __pmu_switch_to_host(void)
 {
-	struct kvm_host_data *host;
-	struct kvm_pmu_events *pmu;
-
-	host = container_of(host_ctxt, struct kvm_host_data, host_ctxt);
-	pmu = &host->pmu_events;
+	struct kvm_pmu_events *pmu = &__hyp_this_cpu_ptr(kvm_host_data)->pmu_events;
 
 	if (pmu->events_guest)
 		write_sysreg(pmu->events_guest, pmcntenclr_el0);
@@ -169,7 +161,7 @@ static void __kvm_vcpu_switch_to_guest(struct kvm_cpu_context *host_ctxt,
 		pmr_sync();
 	}
 
-	__pmu_switch_to_guest(host_ctxt);
+	__pmu_switch_to_guest();
 
 	__sysreg_save_state_nvhe(&host_vcpu->arch.ctxt);
 
@@ -218,7 +210,7 @@ static void __kvm_vcpu_switch_to_host(struct kvm_cpu_context *host_ctxt,
 	 */
 	__debug_switch_to_host(vcpu);
 
-	__pmu_switch_to_host(host_ctxt);
+	__pmu_switch_to_host();
 
 	/* Returning to host will clear PSR.I, remask PMR if needed */
 	if (system_uses_irq_prio_masking())
-- 
2.27.0.389.gc38d7665816-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
