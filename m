Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 92F704275A1
	for <lists+kvmarm@lfdr.de>; Sat,  9 Oct 2021 04:12:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 40F2E4B0CB;
	Fri,  8 Oct 2021 22:12:48 -0400 (EDT)
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
	with ESMTP id Ypp7ZmCTiy6A; Fri,  8 Oct 2021 22:12:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 50A274B11C;
	Fri,  8 Oct 2021 22:12:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 864374B0EF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:12:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9IKN+lEkY+t for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Oct 2021 22:12:44 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AE46A4B08E
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:12:44 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 i83-20020a252256000000b005b67a878f56so15031346ybi.17
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Oct 2021 19:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=w4L6vXRJ0maktiMAI5s6nCFzv55tjBmh5H3fVwAOt14=;
 b=X+K/y94DG3/b1JwgUiidlr5JeHnupRLaoGF9napckdwupzcFgHo7UhOu+eaY5Q3yog
 XhI0zkKhF5wkPh8Ydk25q+Y6isKLBL2UTcjGlPF0l4wc+szJzZ+JS+y62GUkYFglqcAv
 QEhhm2InfBVgcKeILtjC+nb523rb7ir7sFxAzKbiDvXJe9slv28lGTNA/1i2qVg+2ZxD
 lcB1g1dodHVQwinZspEr86T0h4e/T83A8dtpOzreXMAVzScFVYs7UuuVHgCR8Jaa9rV6
 4SJDFMRK9BqcmV318zbEUoQPsVks4CsIxNiDejukWU0lQBj8XUkGo/6kRljZYzrdrmiZ
 JZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=w4L6vXRJ0maktiMAI5s6nCFzv55tjBmh5H3fVwAOt14=;
 b=WfDPIrkMytJBOZMtlm6kOmGoqrzc/FE4Zz77Y5mfY1YyfO0u1jd/bn7Ebe/8SgNomR
 9VRYrYQcUzST2UmIHUcMsCKnLI1DgAyoZctGjQFadHM/VOkI966oZZZzQR8xV7XBTxEq
 NCsh3ksSI2muD1l5XEWbABJkDmRPsINOwx2WCA/GxOzKJQQQV8e87w2Xk0ELLGS5Kp6R
 MU49ng6wkibjRUwV3q9lXnWbEvaz0ZsMhubG4/1Bfw+D0nZITuBDjwKaLuY1QVFIfR/E
 3p8Vd3F68403hYpB05vTK/zjw6cGXGmB6mM4J5nB6hzA8yAWuvy1VcxdiGwzsPwQYTkS
 2D6A==
X-Gm-Message-State: AOAM533rSIVXEivY6myfNYanXUnbpaA91lCJUc/NSnylf3PjfA0RbgQR
 KoZFyQoqopmHZuwBcttBimwCsui0q/Q=
X-Google-Smtp-Source: ABdhPJy3Pz92yv6yudb/1AOSel+YnYYgSBx0ow80ujr4yl8gW3uR4aG1EcxnBZn7LAuMkH73lWi945jfNwQ=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a25:5ed6:: with SMTP id
 s205mr7850217ybb.31.1633745564156; 
 Fri, 08 Oct 2021 19:12:44 -0700 (PDT)
Date: Fri,  8 Oct 2021 19:11:54 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 01/43] KVM: VMX: Don't unblock vCPU w/ Posted IRQ if IRQs
 are disabled in guest
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Anup Patel <anup.patel@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Joerg Roedel <joro@8bytes.org>, kvm-ppc@vger.kernel.org,
 David Matlack <dmatlack@google.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

Don't configure the wakeup handler when a vCPU is blocking with IRQs
disabled, in which case any IRQ, posted or otherwise, should not be
recognized and thus should not wake the vCPU.

Fixes: bf9f6ac8d749 ("KVM: Update Posted-Interrupts Descriptor when vCPU is blocked")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 5f81ef092bd4..3263056784f5 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -142,8 +142,9 @@ int pi_pre_block(struct kvm_vcpu *vcpu)
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 
 	if (!kvm_arch_has_assigned_device(vcpu->kvm) ||
-		!irq_remapping_cap(IRQ_POSTING_CAP)  ||
-		!kvm_vcpu_apicv_active(vcpu))
+	    !irq_remapping_cap(IRQ_POSTING_CAP) ||
+	    !kvm_vcpu_apicv_active(vcpu) ||
+	    vmx_interrupt_blocked(vcpu))
 		return 0;
 
 	WARN_ON(irqs_disabled());
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
