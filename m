Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64B182640
	for <lists+kvmarm@lfdr.de>; Thu, 12 Mar 2020 01:35:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E137A4A4C0;
	Wed, 11 Mar 2020 20:34:59 -0400 (EDT)
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
	with ESMTP id pki1B0LmYP5D; Wed, 11 Mar 2020 20:34:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD4EB4A51E;
	Wed, 11 Mar 2020 20:34:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 345724A4A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 20:34:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ryFbqROKKc17 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Mar 2020 20:34:56 -0400 (EDT)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3DDFF4A1B0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 20:34:56 -0400 (EDT)
Received: by mail-wm1-f66.google.com with SMTP id 6so4203781wmi.5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 17:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rXYfzcBdKI5ubAvqSEIb2KdH42aC5HB1minn7mytn4g=;
 b=xddIzZalQNmm/l4Gy0NEAYwaXcrL17gpkIXF++rfjqb/ruGOmFVAKecoP++D7PRuvL
 cAvRDXQO9Xrg+CDrABN5YPbFnDe3rz3lOHwHiXznBXEiNJbIxoTlSZUAtfwd9vbA/TT9
 wsiobf57P7AdMTK4ZQkUA+KGjWxL248jgcjVX9ytdV37ENRv3shVAjaNextivR/QvmC6
 KttoeU/6CMZG+wP48unX91J7j3EH680Jo9GuHk8BPe8R0qfwZfvMl04M3Sqiz776AuQG
 ue83r06V738R0wgVtwy4xO3sXNK81O3SK3Y4okSHrYkmM3ky38at0vNHUE9hWxBitJKl
 0PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rXYfzcBdKI5ubAvqSEIb2KdH42aC5HB1minn7mytn4g=;
 b=sio6eY7qpMDNVcjGNpMcWZvXa4+/HZOXJcRouYBFGWy9xU39QoGYjcDi3BzJ+XHsQf
 B3ug/6qoB8fpkdUNLRLGq9v6DrG4DbPBqHyHktysAombCCUuedtoMIpt7Zm+XRFnthlh
 Lct7Gt4vvXZMG/eLp0eFq0RnjK2K95KNM8Q7t79n3GIC5KTa6wednVgOy6sB5UAHQ7kk
 jBsecVeDJSPd+xSYYi6e5WipxZiM+5MUC5UbLGzbsQTwsmusto9pbGiGr5vWrE5L/A7u
 Rrsq/wagnYtfG454SFFGWCumXXoXkpMah/mmwG6pd1wBjFKhj4crJNpEfZYBYgYQanh+
 9fFQ==
X-Gm-Message-State: ANhLgQ3Bcf6e+ideK7U7R5WPM4Iv4dOTr/t9wpTRvxac635NXWue3rgk
 5hoTyG/2Je6CqWNhlmWjoc3yXQ==
X-Google-Smtp-Source: ADFU+vuOAzDFJuWFD/k+vg7UekR3WmJcRhllQB3RzppJIXyq8+JOmDdDnFIoAxQkCYoPOsWO4dsmog==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr1273688wmi.120.1583973295268; 
 Wed, 11 Mar 2020 17:34:55 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-139-146-66.range86-139.btcentralplus.com. [86.139.146.66])
 by smtp.gmail.com with ESMTPSA id o5sm10909988wmb.8.2020.03.11.17.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 17:34:54 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] target/arm: kvm: Inject events at the last stage of
 sync
Date: Thu, 12 Mar 2020 00:34:00 +0000
Message-Id: <20200312003401.29017-2-beata.michalska@linaro.org>
In-Reply-To: <20200312003401.29017-1-beata.michalska@linaro.org>
References: <20200312003401.29017-1-beata.michalska@linaro.org>
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

KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
As such this should be the last step of sync to avoid potential overwriting
of whatever changes KVM might have done.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/kvm32.c | 15 ++++++++++-----
 target/arm/kvm64.c | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f703c4f..f271181 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -409,17 +409,22 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    ret = kvm_put_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
 
+    /*
+     * Setting VCPU events should be triggered after syncing the registers
+     * to avoid overwriting potential changes made by KVM upon calling
+     * KVM_SET_VCPU_EVENTS ioctl
+     */
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_kvm(cpu);
 
     return ret;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 93ba144..be5b31c 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1094,17 +1094,22 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    ret = kvm_put_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
         return -EINVAL;
     }
 
+   /*
+    * Setting VCPU events should be triggered after syncing the registers
+    * to avoid overwriting potential changes made by KVM upon calling
+    * KVM_SET_VCPU_EVENTS ioctl
+    */
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_kvm(cpu);
 
     return ret;
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
