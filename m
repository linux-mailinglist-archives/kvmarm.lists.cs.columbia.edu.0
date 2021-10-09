Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 517F44275ED
	for <lists+kvmarm@lfdr.de>; Sat,  9 Oct 2021 04:13:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3B884B1AC;
	Fri,  8 Oct 2021 22:13:47 -0400 (EDT)
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
	with ESMTP id ye0CeJnea0HF; Fri,  8 Oct 2021 22:13:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BBA884B199;
	Fri,  8 Oct 2021 22:13:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D17A44B178
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:13:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Scvz4ii6zrNe for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Oct 2021 22:13:44 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 09AE04B195
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:13:44 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id
 j193-20020a2523ca000000b005b789d71d9aso14935622ybj.21
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Oct 2021 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=sIQRe0bn32KEKwbOVvtx42Ei92aBPRnG0u1z9yXF7CE=;
 b=L08kypVluCyFKbpY0oUWWIYegtRsmlesq0wNJKsfeI8a+xUhccbxmouLf27lMOIMO9
 m9aDG4U98QItV5Ohy31bYubmFprE/QZuQESLgVJSjhpfU/yNgKP/78Q9UuOg6rzwLHC0
 I4lwz0lK7D60KgROmr99XXMz1SfThZEdbn4DKl+Bq52u94Dtdh0Eotn9sUFXLmNXNTbw
 6AcWYEC/LOtNjiY9B+NbBHy51wS3Qc+ABq6bMsBOBRird64iFAtM2ABnk7IiuRD0HQUk
 sjoVTJNAcXG0HP9OnEd8LwZlRBWZpFzxibDplRt3XRCh0O4+qvRQnekLDqaQSXwlvM/O
 WhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=sIQRe0bn32KEKwbOVvtx42Ei92aBPRnG0u1z9yXF7CE=;
 b=UccwinupwEXCt1CUqjQq6kCa/f/3HM0krfMwjqVQynFgFYO76Z1dd10FlAnrncDPXr
 cY9gTg2rgZV1OX2njbgy05Src2y/e1T0gi64AqWl5ScE1JQWj88RouP36F9qjA3wyPPR
 Cb31vaqSeGRNGynI8X7kxnnwHQu3/ufeJs4yM5Frimx2S38O3yPVzgNqpq7sI6NEu0kU
 Y1ef9CSZhZuQCnLC2eFYOar2BTIJL726nT+M4boUhFzaxtOdnz2cqc3JlG5v0stNQCiy
 dnbP0F5TUTU5TsCwvgAEEQAWLRLClA0UV5EkyoBBMUuq/XmzWS892cakmud1CJg/jh5W
 kVhQ==
X-Gm-Message-State: AOAM5301FoXthrmAkrsR4FM0NSv5YyX4aN6XhUPuidklmSBwoX5XwOdk
 3Q8kMOzK1i+vItSXwnu2WLft/bV6zbY=
X-Google-Smtp-Source: ABdhPJwLBmcqJzHPV5bzQgN7SUGs2wP/5HXQxp4+zEmbtDKAgC6fngbLUg0PIYqYm/p4aFsJ/BNsgFl1S/s=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a25:393:: with SMTP id
 141mr7017004ybd.534.1633745623429; 
 Fri, 08 Oct 2021 19:13:43 -0700 (PDT)
Date: Fri,  8 Oct 2021 19:12:18 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-26-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 25/43] KVM: VMX: Save/restore IRQs (instead of CLI/STI)
 during PI pre/post block
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

Save/restore IRQs when disabling IRQs in posted interrupt pre/post block
in preparation for moving the code into vcpu_put/load(), and thus may be
called with IRQs already disabled.

No functional changed intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 239e0e72a0dd..414ea6972b5c 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -140,6 +140,7 @@ int pi_pre_block(struct kvm_vcpu *vcpu)
 {
 	struct pi_desc old, new;
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	unsigned long flags;
 
 	if (!kvm_arch_has_assigned_device(vcpu->kvm) ||
 	    !irq_remapping_cap(IRQ_POSTING_CAP) ||
@@ -147,8 +148,7 @@ int pi_pre_block(struct kvm_vcpu *vcpu)
 	    vmx_interrupt_blocked(vcpu))
 		return 0;
 
-	WARN_ON(irqs_disabled());
-	local_irq_disable();
+	local_irq_save(flags);
 
 	vcpu->pre_pcpu = vcpu->cpu;
 	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
@@ -171,19 +171,20 @@ int pi_pre_block(struct kvm_vcpu *vcpu)
 	if (pi_test_on(pi_desc))
 		__pi_post_block(vcpu);
 
-	local_irq_enable();
+	local_irq_restore(flags);
 	return (vcpu->pre_pcpu == -1);
 }
 
 void pi_post_block(struct kvm_vcpu *vcpu)
 {
+	unsigned long flags;
+
 	if (vcpu->pre_pcpu == -1)
 		return;
 
-	WARN_ON(irqs_disabled());
-	local_irq_disable();
+	local_irq_save(flags);
 	__pi_post_block(vcpu);
-	local_irq_enable();
+	local_irq_restore(flags);
 }
 
 /*
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
