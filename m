Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1218F3B6
	for <lists+kvmarm@lfdr.de>; Mon, 23 Mar 2020 12:32:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B88E04B0C7;
	Mon, 23 Mar 2020 07:32:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id btaB7x8f6mR7; Mon, 23 Mar 2020 07:32:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D84F4B0B5;
	Mon, 23 Mar 2020 07:32:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B2F84B0BB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Mar 2020 07:32:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g1BSIe8FMtji for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Mar 2020 07:32:46 -0400 (EDT)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 75B3C4A4C0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Mar 2020 07:32:46 -0400 (EDT)
Received: by mail-wm1-f68.google.com with SMTP id d198so8487120wmd.0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Mar 2020 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=scdgVshz7sU0Fzpv5iTWYPRCzh314P+7l5wAJHlPMsk=;
 b=JLvAr/BLfGkIUYDk0CdrGwqORp808GVmj/9LS6QzDIqOCdntGOzADShWL7NqnBoHmE
 y9D0qohsyh6Lh+QOYcEnJP3JfSmaRTaN3SaQKQ8JC/gzGza3aRvQFHayw+VQFVUNG8Be
 DEA2UA5WtVgEpMM8/pbvYq7H6tbTUwceliW4g4yGuPWddc/m1NfJ+GR8ih8Nl+Ff044y
 d1SANkvsxWEmBCPwcKwe4BFeDppIKLTOkzKtFtOvibWEscR7KVZmBNCuIfci0XYwK+9A
 WP32f6nfoIvNoxsxfhdYSqelcnl9nPhH/cHbCUPNCn2vLRCMdvRREZQF5JcW6FvhhVUa
 071Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=scdgVshz7sU0Fzpv5iTWYPRCzh314P+7l5wAJHlPMsk=;
 b=s7GmVQZJe7In//S33g+7bPOe6GdmXH6v95TgTnG5LTtoHBHOA4QwcWUD95BkreaMBb
 0NkrgPmv6kj9EBkcHrQPPKcMlxrz/A73BFycrh0MZOK+1R8yTILOIPoIX+9VW50/jXKV
 5IDHqqRxcTqAnYvqYaqL2a5wUsBki1JR/Bo3Al7vFVFdFJTZU9cZZgdy2y7CvECAqP3r
 kG7DrjYVAWXap+/9CUjzJIB5yeGO22Gyf85gCw2TU07VvjGMoH+8G/exyLpychfAijYp
 bRLSAEKWP5hXdUeZra0QVU/5C5wt1OrQ5mUDwLG47QC6ZQFbc3nPwKRM/jpdvM6facmD
 nMMg==
X-Gm-Message-State: ANhLgQ0tEXtxIDWGKD+PRrWJWkgxM0j+wdM5zrP1QMAYvrD8dotXizno
 JozJJw14m5lsOv7LMGA7EHrXuA==
X-Google-Smtp-Source: ADFU+vsS9oZSnx9C/9TqsxjLEO4sPwqD3pfhBeIFf+NsvEqUlgQJTeuJrLKEcxfz5pHB78qSJmSu2w==
X-Received: by 2002:a05:600c:1405:: with SMTP id
 g5mr12270544wmi.90.1584963165596; 
 Mon, 23 Mar 2020 04:32:45 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-177-220-180.range86-177.btcentralplus.com. [86.177.220.180])
 by smtp.gmail.com with ESMTPSA id 98sm23288473wrk.52.2020.03.23.04.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 04:32:45 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
Date: Mon, 23 Mar 2020 11:32:26 +0000
Message-Id: <20200323113227.3169-2-beata.michalska@linaro.org>
In-Reply-To: <20200323113227.3169-1-beata.michalska@linaro.org>
References: <20200323113227.3169-1-beata.michalska@linaro.org>
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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

On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate those instruction which is one of the
(many) reasons why KVM will not even try to do so.

Add support for handling those by requesting KVM to inject external
dabt into the quest.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 11 +++++++++++
 3 files changed, 67 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ffd991..4f834c1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -560,6 +560,8 @@ typedef struct CPUARMState {
         uint64_t esr;
     } serror;
 
+    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
+
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 85860e6..c088589 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
+static bool cap_has_inject_ext_dabt;
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
@@ -244,6 +245,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         ret = -EINVAL;
     }
 
+    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
+            warn_report("Failed to enable DABT NISV cap");
+        } else {
+            /* Set status for supporting the external dabt injection */
+            cap_has_inject_ext_dabt = kvm_check_extension(s,
+                                    KVM_CAP_ARM_INJECT_EXT_DABT);
+        }
+    }
+
     return ret;
 }
 
@@ -703,9 +714,16 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
         events.exception.serror_esr = env->serror.esr;
     }
 
+    if (cap_has_inject_ext_dabt) {
+        events.exception.ext_dabt_pending = env->ext_dabt_pending;
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
     if (ret) {
         error_report("failed to put vcpu events");
+    } else {
+        /* Clear instantly if the call was successful */
+        env->ext_dabt_pending = 0;
     }
 
     return ret;
@@ -819,6 +837,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
+    case KVM_EXIT_ARM_NISV:
+        /* External DABT with no valid iss to decode */
+        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
+                                       run->arm_nisv.fault_ipa);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
@@ -953,3 +976,34 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     return (data - 32) & 0xffff;
 }
+
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+   /*
+    * ISS [23:14] is invalid so there is a limited info
+    * on what has just happened so the only *useful* thing that can
+    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
+    * might be less of a value as well)
+    */
+
+    /*
+     * Set pending ext dabt and trigger SET_EVENTS so that
+     * KVM can inject the abort
+     */
+    if (cap_has_inject_ext_dabt) {
+        kvm_cpu_synchronize_state(cs);
+        env->ext_dabt_pending = 1;
+    } else {
+        error_report("Data abort exception triggered by guest memory access "
+                     "at physical address: 0x"  TARGET_FMT_lx,
+                     (target_ulong)fault_ipa);
+        error_printf("KVM unable to emulate faulting instruction.\n");
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ae9e075..39472d5 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -450,6 +450,17 @@ struct kvm_guest_debug_arch;
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 
 /**
+ * kvm_arm_handle_dabt_nisv:
+ * @cs: CPUState
+ * @esr_iss: ISS encoding (limited) for the exception from Data Abort
+ *           ISV bit set to '0b0' -> no valid instruction syndrome
+ * @fault_ipa: faulting address for the synch data abort
+ *
+ * Returns: 0 if the exception has been handled, < 0 otherwise
+ */
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa);
+/**
  * its_class_name:
  *
  * Return the ITS class name to use depending on whether KVM acceleration
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
