Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA33F0CA1
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 22:21:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B65A4B0CC;
	Wed, 18 Aug 2021 16:21:51 -0400 (EDT)
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
	with ESMTP id y0I+dL1j3mVh; Wed, 18 Aug 2021 16:21:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 970524B0E1;
	Wed, 18 Aug 2021 16:21:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 473EA4B0BE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 16:21:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KIVt5zwy4fSk for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 16:21:38 -0400 (EDT)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 403C64A19B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 16:21:38 -0400 (EDT)
Received: by mail-qk1-f201.google.com with SMTP id
 p23-20020a05620a22f700b003d5ac11ac5cso2578401qki.15
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kvKtrAMG5/B2xy9v8H2FiPsJUDywEb7U/VFv10BGAsU=;
 b=S/1pSOiATU/vW+PQwJSN5RtYqU/6D2RUGu3fWtiYYp8duK0t1St5G0FSkM8hD38t5A
 f9fDCXnfnp8xGPLkX17IQ7ZC8VDhmEsePO90TD5QigC63rzKCk95I1PRIT42jJLHKaGR
 iJc+FrUNTpB+Be0WDgVkn+ZZaB2Dwau03J8XcJR7+L3T9VP9NDePahgbyTVe2Ks06hsT
 LLOo+ALm+OJ1oqMXsD323LdSWFT74NExX6nzIzE4uW6ZrzHTf1B0m6X/YvqsGALCbZ+9
 TRl170pakEEhRXhxkNKgGD1iD92gWK77v/cc5TDq0PFlExib1e2yIitemSbHTxLPXlGF
 iTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kvKtrAMG5/B2xy9v8H2FiPsJUDywEb7U/VFv10BGAsU=;
 b=k7+/M1KRsgdF0kS76zcuv0uzQE1w5BHU5HE/IEizmK1mvT6gNJ7sShmHfnhZwfFxPc
 XMggZzg+T6PMRIdJyMQ4tVrKXgHlxHEfCGa2u2IFK2DrgFe77xRZSUgp//ZD2yCJR0TO
 uYNvUpruWKYCFezlI0sc4TgSNbsZtviV3rpTWz+mAccsLD3WDSVedP6JLU8IEHcF06h5
 se0XmEYkGdMCuIWn6pNh02bP+6gr/M0SHJD2iWQr9rFx4B+oOSBytJ2S5nC880MNBcQJ
 JOvaY+GW9sZSVtEYQppupI7mEZoQC/fSO9iXsJNB6LJxjP2K3oB/PgFZUrud489/MVlh
 uk6A==
X-Gm-Message-State: AOAM531/izVmSno4ECXAoHyhGs/QjTDtRhe7MC3dyotnJIPieMFw0JB0
 1vtHUQQAUAaafw8XcViAeaE0Zz73Hsg=
X-Google-Smtp-Source: ABdhPJzeVUqlbjJkSBQ4IlhwKRJxJl7Np7SGxoszuSv8QX+fTbAJgDGS9IB+KhTQDNDEuqystjSZo6XwBgs=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6214:621:: with SMTP id
 a1mr11008909qvx.12.1629318097796; Wed, 18 Aug 2021 13:21:37 -0700 (PDT)
Date: Wed, 18 Aug 2021 20:21:31 +0000
In-Reply-To: <20210818202133.1106786-1-oupton@google.com>
Message-Id: <20210818202133.1106786-3-oupton@google.com>
Mime-Version: 1.0
References: <20210818202133.1106786-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 2/4] KVM: arm64: Handle PSCI resets before userspace
 touches vCPU state
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 Raghavendra Rao Anata <rananta@google.com>
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

The CPU_ON PSCI call takes a payload that KVM uses to configure a
destination vCPU to run. This payload is non-architectural state and not
exposed through any existing UAPI. Effectively, we have a race between
CPU_ON and userspace saving/restoring a guest: if the target vCPU isn't
ran again before the VMM saves its state, the requested PC and context
ID are lost. When restored, the target vCPU will be runnable and start
executing at its old PC.

We can avoid this race by making sure the reset payload is serviced
before userspace can access a vCPU's state.

Fixes: 358b28f09f0a ("arm/arm64: KVM: Allow a VCPU to fully reset itself")
Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/kvm/arm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0ca72f5cda41..a9763db0d27b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1219,6 +1219,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&reg, argp, sizeof(reg)))
 			break;
 
+		/*
+		 * We could owe a reset due to PSCI. Handle the pending reset
+		 * here to ensure userspace register accesses are ordered after
+		 * the reset.
+		 */
+		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
+			kvm_reset_vcpu(vcpu);
+
 		if (ioctl == KVM_SET_ONE_REG)
 			r = kvm_arm_set_reg(vcpu, &reg);
 		else
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
