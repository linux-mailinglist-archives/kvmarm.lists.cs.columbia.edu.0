Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1224B656
	for <lists+kvmarm@lfdr.de>; Thu, 20 Aug 2020 12:35:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE7DE4B364;
	Thu, 20 Aug 2020 06:35:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yb7ayyYb1a-4; Thu, 20 Aug 2020 06:35:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A9F104B86D;
	Thu, 20 Aug 2020 06:35:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 96EE14B364
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Aug 2020 06:35:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XyL70BHHrhZU for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Aug 2020 06:35:28 -0400 (EDT)
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DB4AE4B852
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Aug 2020 06:35:27 -0400 (EDT)
Received: by mail-wm1-f73.google.com with SMTP id k204so812506wmb.3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Aug 2020 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=NpTWAfUuaBrqvL5WoiOglVAHXJmeF/kvgd4T1sm4uCk=;
 b=OL1FdvQ06po5dRDgFoBC/jhuI9HcHJKKWdkz/lBUsb9qgzZ/ePBm+EmvUdZApEWkJl
 DEioStqoOMXFtmrk1ZntjTWn3Mq2+/KxLIdjT1OUh3v5kYt9ck8JEqKVjhJZRTYRltH/
 90/p3dMMbiTts6AcHML6rMoWC/lgWvl5NKbUbsLhEUZV9Ud3KOkWj3kEmzPz2KCbUSvR
 oj+XwjW2BhO/TtksYSGgW4TCo/fkTpp/4HbGmrJNm6oH3/Hut+BtZnEDVZgs13VvLj7m
 tjUPnZ/Jt/R3+8sRMEzzuY8sZtdHTOT8r1Q/KZNS47k4/BTsFY1ex9HL3p/4HOpgv8F8
 AjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=NpTWAfUuaBrqvL5WoiOglVAHXJmeF/kvgd4T1sm4uCk=;
 b=Y9KnsBMbDVe0x83WyJzvfS/AHQ58nTTgiYzjHHOI6UkHkkRXH1FrnmHMHbVU+arnoY
 WTvNXlJPxCRI8q1qCQbAzhFdQzCJRb7Pxh2Q0XNfwgWZEwmK03VbzF4EFx8q6xC8WIE1
 BtU8SAosujzTCG4ZrX6lO+3+jxMaSA+dTb7JsJMfr1NFvfRNEa1hVxAJdp+3/Lksm2bQ
 0mzEiMYmZe9Bjq0Nor0t/LcpMviGJb16U/ppvl50HjwNt/c4cfUo+asHXB+JDa0vIn6r
 DigC35JkfJYNfPpqoCjf/v3UA1GXRVNQ1hOu+fklK+dDPn8wtqMHe5iY3IZj9KnsI6hC
 oRPg==
X-Gm-Message-State: AOAM533IzLFh9fv10WeHxtGy4GWl7YHk/T9L2vCl8cDMG0rFBt/4vO2V
 52Kj9NWmbIj9ohcbDk0tPEdPF8J7O+k7hoNsQfFbb99A7aqiX83xbHAW+vmDm4u6aekMeJlh8Tf
 AII3YkWiDNBbebBd4hs4g9pgdzl0q7AnKTFxMHurXETBT3lXaCmvXQE1hUZJck9C5GPVHXw==
X-Google-Smtp-Source: ABdhPJzbph0gXnRJBKxFt0tc/NsFuKkkl/5TPKx7o/izNImFpUzaCaoSh4wqoPNsXOB90sybT/1JE7x91o4=
X-Received: from ascull.lon.corp.google.com
 ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
 (user=ascull job=sendgmr) by 2002:adf:bb83:: with SMTP id
 q3mr2798288wrg.58.1597919726837; 
 Thu, 20 Aug 2020 03:35:26 -0700 (PDT)
Date: Thu, 20 Aug 2020 11:34:29 +0100
In-Reply-To: <20200820103446.959000-1-ascull@google.com>
Message-Id: <20200820103446.959000-4-ascull@google.com>
Mime-Version: 1.0
References: <20200820103446.959000-1-ascull@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 03/20] KVM: arm64: Remove kvm_host_data_t typedef
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 maz@kernel.org, Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
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

The kvm_host_data_t typedef is used inconsistently and goes against the
kernel's coding style. Remove it in favour of the full struct specifier.

Signed-off-by: Andrew Scull <ascull@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 4 +---
 arch/arm64/kvm/arm.c              | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 65568b23868a..ec1a80796999 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -262,8 +262,6 @@ struct kvm_host_data {
 	struct kvm_pmu_events pmu_events;
 };
 
-typedef struct kvm_host_data kvm_host_data_t;
-
 struct vcpu_reset_state {
 	unsigned long	pc;
 	unsigned long	r0;
@@ -565,7 +563,7 @@ void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-DECLARE_PER_CPU(kvm_host_data_t, kvm_host_data);
+DECLARE_PER_CPU(struct kvm_host_data, kvm_host_data);
 
 static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 {
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 691d21e4c717..6b09c0f3365c 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -46,7 +46,7 @@
 __asm__(".arch_extension	virt");
 #endif
 
-DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
+DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 
 /* The VMID used in the VTTBR */
@@ -1538,7 +1538,7 @@ static int init_hyp_mode(void)
 	}
 
 	for_each_possible_cpu(cpu) {
-		kvm_host_data_t *cpu_data;
+		struct kvm_host_data *cpu_data;
 
 		cpu_data = per_cpu_ptr(&kvm_host_data, cpu);
 		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
-- 
2.28.0.220.ged08abb693-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
