Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F08D66171C9
	for <lists+kvmarm@lfdr.de>; Thu,  3 Nov 2022 00:19:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D0A04B7D4;
	Wed,  2 Nov 2022 19:19:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jaGQREgx4H00; Wed,  2 Nov 2022 19:19:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AD024B7ED;
	Wed,  2 Nov 2022 19:19:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DBD6A4B7B5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Nov 2022 19:19:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hX27fUDw-Y7B for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Nov 2022 19:19:43 -0400 (EDT)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 947CC4B7CF
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Nov 2022 19:19:43 -0400 (EDT)
Received: by mail-pl1-f202.google.com with SMTP id
 l1-20020a170902f68100b00187117d8e44so242770plg.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 02 Nov 2022 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=KSp9zIzHXrxcJceHX59wYlpimn2+3DBl6/EkdM22YDo=;
 b=GazJIJPM/pHmiFZ05wEIEUmIWAlYuh2ZlyTopcNekluhV4UHGi1yTDkMNANFS1jscV
 sHaoW06GH/7QoV/u1MZ9MSnC1FGAiLQO/y23W8/5eah4jm88WvvNxPaF2O5WlqNX6AA2
 8Gs4UT7UUi7/ZwHf5DCZWbM2vulQhHbwn2WtGD6rJzl/FOBfxZ8G3NM+geD74+eDAUum
 o1o3demNZa7SFz5SsAwJ7XKog0NdlraaEfYhRzZpffEE3gOpiTfLkShIIvuV3L13yEjN
 xam914sm21iReYi10+r23ej5bJnTbIKx2d2irwZwjp5ibbzs0gCmvLJoawOipg8dYos5
 2Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KSp9zIzHXrxcJceHX59wYlpimn2+3DBl6/EkdM22YDo=;
 b=DBFp+vuX1VzY01nlIsu80T+S/WYL6gH2578fQItWmKuYCAp7MgELWPT57BWsDQLd5b
 gu+7ze+w5LyZ4qPoNoJvp5QBy5DdnDvERWgYpsNjL34PzAxs7MLHMfv+SW1A6mS5mtfs
 ZukG+1GBzuTcUn+X3qvHOgcWWllzXFkex8YzXB22WK1KY3eHdvOkPfYlNlhIEBG7XOyR
 crbx698iv0MomHfXWX4U7ZNWXVZduEqZLgYcycvjXCEoMhSLmi25Zm62yKLScr8kkqfd
 eV/Fdnevole+v8ihnqxDDz2izzx0zHxOp2Kf0mXRA505GkkGfITjSKTK6ouI4/i1JZ+4
 KGHQ==
X-Gm-Message-State: ACrzQf3/QW7LDaA8HXoxd9G0pjouZMp8ZZnT9ulLsOCPA2qCOAJIzZXW
 TyX2WKML2wJWMDPxq6moIxO3GU3ZpNk=
X-Google-Smtp-Source: AMsMyM5Lv2JMFeAlRDTbvWUtcHml4s/PYrbj2uJcHSHWkZsi31gUm2Ed915QDdWGieIzAX5rFOQTrQSszmI=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:e0b:b0:56c:8c13:2a54 with SMTP id
 bq11-20020a056a000e0b00b0056c8c132a54mr27442020pfb.17.1667431182821; Wed, 02
 Nov 2022 16:19:42 -0700 (PDT)
Date: Wed,  2 Nov 2022 23:18:44 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-18-seanjc@google.com>
Subject: [PATCH 17/44] KVM: arm64: Do arm/arch initialiation without bouncing
 through kvm_init()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Chao Gao <chao.gao@intel.com>, Yuan Yao <yuan.yao@intel.com>,
 kvmarm@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, linux-mips@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
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

Move arm/arch specific initialization directly in arm's module_init(),
now called kvm_arm_init(), instead of bouncing through kvm_init() to
reach kvm_arch_init().  Invoking kvm_arch_init() is the very first action
performed by kvm_init(), i.e. this is a glorified nop.

Making kvm_arch_init() a nop will allow dropping it entirely once all
other architectures follow suit.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index f400a8c029dd..bfa2dcd3db11 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2190,7 +2190,7 @@ void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
 /**
  * Initialize Hyp-mode and memory mappings on all CPUs.
  */
-int kvm_arch_init(void *opaque)
+int kvm_arm_init(void)
 {
 	int err;
 	bool in_hyp_mode;
@@ -2264,6 +2264,14 @@ int kvm_arch_init(void *opaque)
 		kvm_info("Hyp mode initialized successfully\n");
 	}
 
+	/*
+	 * FIXME: Do something reasonable if kvm_init() fails after pKVM
+	 * hypervisor protection is finalized.
+	 */
+	err = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (err)
+		goto out_subs;
+
 	return 0;
 
 out_subs:
@@ -2276,10 +2284,15 @@ int kvm_arch_init(void *opaque)
 	return err;
 }
 
+int kvm_arch_init(void *opaque)
+{
+	return 0;
+}
+
 /* NOP: Compiling as a module not supported */
 void kvm_arch_exit(void)
 {
-	kvm_unregister_perf_callbacks();
+
 }
 
 static int __init early_kvm_mode_cfg(char *arg)
@@ -2320,10 +2333,4 @@ enum kvm_mode kvm_get_mode(void)
 	return kvm_mode;
 }
 
-static int arm_init(void)
-{
-	int rc = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-	return rc;
-}
-
-module_init(arm_init);
+module_init(kvm_arm_init);
-- 
2.38.1.431.g37b22c650d-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
