Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F374814D1E5
	for <lists+kvmarm@lfdr.de>; Wed, 29 Jan 2020 21:25:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A36B74AC6C;
	Wed, 29 Jan 2020 15:25:22 -0500 (EST)
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
	with ESMTP id ip3fj-AyGmuD; Wed, 29 Jan 2020 15:25:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 942374AC68;
	Wed, 29 Jan 2020 15:25:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6737C4A959
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Jan 2020 15:25:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RITC3cYkOsNl for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Jan 2020 15:25:18 -0500 (EST)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 66FED4A4FC
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Jan 2020 15:25:18 -0500 (EST)
Received: by mail-wr1-f68.google.com with SMTP id d16so1029535wre.10
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Jan 2020 12:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+tZ0YBqhVEsxFXOR05MPD9ATHbI+tc6ggHRmtxE2t3s=;
 b=hmZ6qyaI6/s1G9fnfQJcUMPDpFu9Z3QQVzkxagMyyHwmFeewG3Pom3ubikvAIRvOBU
 VJBypdw++F73MZW0g1YdJR0bfVSWuO4AVnfKlAgdVI34ILKKBKySNiMaLQI/qLUoDIbi
 DgYv3OLEP4Vl3hNRWoYwKTcSl7BDaIuxkZCiw2/4knZX2Bz3RUP6PauRghFz28offnot
 oeuqe1k6Feq8WxWs3IT2hh2kDDJsKce6HlMVZ5+18n43TalBEpQ8OKRrrUgJIEIY0xmj
 08MmPAG4ZH4tTTkxkIdhRy///qnucEDZuhyOzGPGR3c+SGxXMEGI3ZENZTHXDwZOuzFH
 36RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+tZ0YBqhVEsxFXOR05MPD9ATHbI+tc6ggHRmtxE2t3s=;
 b=rzxqLRNi5uINQF1W0cIii2wJK5MpGhZMckqViufeeEExQr9NroSJfnGzouSmbMwSwU
 /Cd4zq2Kq+2LpNDpnfBGw41wtqU4tA214WgyaCgWHVB63OQq2aortCOicbc+ptMq5s5T
 Eb090SKZjWM0Qk96WAoKd6a2Y6EHiNpp2WOSXLpSFD8V+DjQzlZkqwoqFrdZsWPv4Xzt
 51FVt2/Do1bVKOce4VmojrC07GUKPvmFY6U0WDe9iJDBPm7OPHbtOuA08chPPEZSy95G
 Qh9vSYj+LN1/p9hBYZdXEBQpuzz980weJ4KtoxwmcQ6kZN/O6aM4c/N+OwigDoDG4CnN
 rlfw==
X-Gm-Message-State: APjAAAU7VSzofJwIpjf2livpN3mBy3/9hlCL4dSORih39X33+91KkCMM
 dmcC8QdTxg7yM/fm3vACDXQkdw==
X-Google-Smtp-Source: APXvYqxeG+727dSd9hpflWUs37JO+uDRBt85YuaVw/2/qEYgkhJrgszDi4Osfq32YMA7sHZ23onsUw==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr711078wro.56.1580329517572;
 Wed, 29 Jan 2020 12:25:17 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-131-78-194.range86-131.btcentralplus.com. [86.131.78.194])
 by smtp.gmail.com with ESMTPSA id h2sm4377518wrt.45.2020.01.29.12.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 12:25:17 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/arm: kvm: Inject events at the last stage of
 sync
Date: Wed, 29 Jan 2020 20:24:40 +0000
Message-Id: <20200129202441.12745-2-beata.michalska@linaro.org>
In-Reply-To: <20200129202441.12745-1-beata.michalska@linaro.org>
References: <20200129202441.12745-1-beata.michalska@linaro.org>
Cc: qemu-arm@nongnu.org, kvmarm@lists.cs.columbia.edu, pbonzini@redhat.com
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
 target/arm/kvm32.c | 20 ++++++++++----------
 target/arm/kvm64.c | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 32bf8d6..cf2b47f 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -386,17 +386,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
 
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_kvm(cpu);
 
     return ret;
@@ -462,11 +462,6 @@ int kvm_arch_get_registers(CPUState *cs)
     }
     vfp_set_fpscr(env, fpscr);
 
-    ret = kvm_get_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     if (!write_kvmstate_to_list(cpu)) {
         return EINVAL;
     }
@@ -475,6 +470,11 @@ int kvm_arch_get_registers(CPUState *cs)
      */
     write_list_to_cpustate(cpu);
 
+    ret = kvm_get_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_qemu(cpu);
 
     return 0;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6344113..d06fd32 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1043,17 +1043,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
 
+    ret = kvm_put_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_kvm(cpu);
 
     return ret;
@@ -1251,11 +1251,6 @@ int kvm_arch_get_registers(CPUState *cs)
     }
     vfp_set_fpcr(env, fpr);
 
-    ret = kvm_get_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
     if (!write_kvmstate_to_list(cpu)) {
         return -EINVAL;
     }
@@ -1264,6 +1259,11 @@ int kvm_arch_get_registers(CPUState *cs)
      */
     write_list_to_cpustate(cpu);
 
+    ret = kvm_get_vcpu_events(cpu);
+    if (ret) {
+        return ret;
+    }
+
     kvm_arm_sync_mpstate_to_qemu(cpu);
 
     /* TODO: other registers */
-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
