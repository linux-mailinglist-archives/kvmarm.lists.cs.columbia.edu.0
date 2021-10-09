Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3141F427605
	for <lists+kvmarm@lfdr.de>; Sat,  9 Oct 2021 04:14:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D37B54B1BD;
	Fri,  8 Oct 2021 22:14:08 -0400 (EDT)
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
	with ESMTP id FblfwFg1SfCE; Fri,  8 Oct 2021 22:14:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D01514B093;
	Fri,  8 Oct 2021 22:14:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A1F6E4B199
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:14:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zVi4z7F3ga+a for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Oct 2021 22:14:04 -0400 (EDT)
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id ADA084B1C0
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:14:03 -0400 (EDT)
Received: by mail-yb1-f202.google.com with SMTP id
 i83-20020a256d56000000b005b706d1417bso15032954ybc.6
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Oct 2021 19:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=C2PBzYfpswTkvsOYeskWQEML51RRougebHfj0Alyx5A=;
 b=WYMPTsMzDt+AsjiCyZJ1B4+ZpYxh2OtDt82Ju6kAg5cXo6tqXm1ZgRYGEPixBeGSUX
 csu0nnUcxqKDiQ1eAmAeGes+LUQg2mXWzAyCEZN0ncq8JRJRFlJFF87rnbemqyBf6tBd
 V9ViKRAH1hB1quUnaDowk1/9kTi2JyNnkHWTKfzzmhY7AxslA7BLbxo1ZA8eLcYWLnjz
 YbQ0w447PhslHJ3ZxBNJRnTcGLYtNfmZQAOeWXXJuualGN4NlLQe9GK7rEtrWgH0mtsp
 VqsmagApekmgICqy79O2umIOGpnKlEqjA71PkSs0Bk91M4cBLEAn1bGCQe9gx+1d5Zvx
 1xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=C2PBzYfpswTkvsOYeskWQEML51RRougebHfj0Alyx5A=;
 b=cdP99tdU+S7Vnfa9zw7IJ6ZvkMS/z5yeqMv+IV3mnntczcB5iXYWVjl/WZ2mTfp4O9
 IxhxktKz+IRSAXhfRFz6qOKAj1AE2sxEdb4q3FRLBhoQhwjnYdUFIx8LVBVCT9lvp9c4
 xgZKQGztpMTZY1sSOvHQ7zQ0+/FC7skU2iF5/gUwuiFyBXHa+xjjtTPr0LghASZ+mJ9n
 7ykhoC85ulc2ErvrK3FSY1oXwFtjF/BsXVBpGi0eAfXtWz2oU5r+6eKIm7As68FAwzmi
 BoFmkXMheboXNuvTD+VfEossjDhLw0HPCwxemAIqykwRHQS7NtKpelAtEUxfAbWU7EPI
 rRJA==
X-Gm-Message-State: AOAM532QnI7Yonjvpq3l+A7oTTKkCc+ajp7SpZ5HTteWKmlmdgYMhhiB
 7SYjbT9LQbv7hHha2Tx6XSNBxK2bal0=
X-Google-Smtp-Source: ABdhPJzcpn5DTPQuPSfZUPDLuPAfkBrPTcc8cEPmAKwjDwkk0IcaBIdBFMmznx5JjVGnWgQQ1Ay+qs9Sp8s=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a25:5954:: with SMTP id
 n81mr7136674ybb.435.1633745643213; 
 Fri, 08 Oct 2021 19:14:03 -0700 (PDT)
Date: Fri,  8 Oct 2021 19:12:26 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-34-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 33/43] KVM: x86: Unexport LAPIC's switch_to_{hv,
 sw}_timer() helpers
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

Unexport switch_to_{hv,sw}_timer() now that common x86 handles the
transitions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0cd7ed21b205..cfb64bd4a1c1 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1948,7 +1948,6 @@ void kvm_lapic_switch_to_hv_timer(struct kvm_vcpu *vcpu)
 {
 	restart_apic_timer(vcpu->arch.apic);
 }
-EXPORT_SYMBOL_GPL(kvm_lapic_switch_to_hv_timer);
 
 void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu)
 {
@@ -1960,7 +1959,6 @@ void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu)
 		start_sw_timer(apic);
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(kvm_lapic_switch_to_sw_timer);
 
 void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu)
 {
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
