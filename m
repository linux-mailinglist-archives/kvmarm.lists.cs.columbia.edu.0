Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 432EC444C08
	for <lists+kvmarm@lfdr.de>; Thu,  4 Nov 2021 01:26:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E3F4E4B172;
	Wed,  3 Nov 2021 20:26:34 -0400 (EDT)
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
	with ESMTP id wzvub0Jr1-ZJ; Wed,  3 Nov 2021 20:26:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CEBE34B192;
	Wed,  3 Nov 2021 20:26:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 399484B13E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Nov 2021 20:26:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vMFh91FYo8lO for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Nov 2021 20:26:30 -0400 (EDT)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B849F4B174
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Nov 2021 20:26:28 -0400 (EDT)
Received: by mail-pg1-f201.google.com with SMTP id
 v63-20020a632f42000000b002cc65837088so2421793pgv.1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 03 Nov 2021 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=IsY0WRuuTFV0eCJh4XuxLWgE9EBRjAtittkz8TMTuco=;
 b=O7s96ScNe9nmLZhqPDRepEfehWbch5lSXwuuBFzYiqZgVQsgJRuuGd/HsCCp0bLNu4
 cYQEx19ZWNPAdMz0HClIalz8ml2QbzjuG+kpgnfMKZafKps+5AXiFqHJNbVFhjHTioYL
 tC1EMjtQ3yJ0X06NcpoHHSW6eMNaRj1UY0Egh3hPuOjeGtPjO4DN4XnLvAY2osT6lAMm
 Q868Qm3pLeksx//ppWn43EQZ/TdzYIIwGOwnzwEzdl67hcCGzEJJpjoe2w8tgpCv7e+t
 TP/XmqLrn9P33rNcE9thKpdxIqj+9MZJlkaTX8cqkFRjS/EbxZ7CKKedokkl4MG1CITB
 FVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=IsY0WRuuTFV0eCJh4XuxLWgE9EBRjAtittkz8TMTuco=;
 b=CtxLZfjMbPMxsHmrlgyhOQpqiB/Xcz8dSxfpSWpIfYCUmw4Z8lVWlqHRKq2TcjKfR8
 T78zdHm+g/wqCErujf9MScKHkhsogDTfDoWIrK+cBDzc2MYka2MnGdHAnziHraYKdGJt
 IZ5LgQ0QN2qr5CxmyJMD4Kefczf3dxLDLcGu9I2Uw2RG7+sWvjdbXd1WcYaMQJ8A6M5K
 l0j9Tcf22BOrjmZfrLz/2c0zhjnAZVRJvOcPR+zAX/D4fldE/dDcK2sgGYGXEkdlfWjl
 y6NAWR47TpyXNVVNbv3zLtf0Bbd8+PpPFtK7z9QzOtcYIkdA0F/QspwlKcHCQcWT9Fxf
 TZwQ==
X-Gm-Message-State: AOAM530fmmpTEXX+qh+H6NpOuWJkpuRCpPU36UrJKwEC1cDJtpeO1cQF
 tf2MAl9Xj6uqSwpkeTq+aVsxlK524FY=
X-Google-Smtp-Source: ABdhPJz+o3KGoFfULDwKrO6qcyTUUuzAUo3X1uvau9DDSuCs/3Lm9Kc5uh2iA0skAT+76ch/61YBaYAjQn0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr261386pjh.1.1635985587426; Wed, 03 Nov 2021 17:26:27 -0700 (PDT)
Date: Thu,  4 Nov 2021 00:25:18 +0000
In-Reply-To: <20211104002531.1176691-1-seanjc@google.com>
Message-Id: <20211104002531.1176691-18-seanjc@google.com>
Mime-Version: 1.0
References: <20211104002531.1176691-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v5.5 17/30] KVM: s390: Skip gfn/size sanity checks on memslot
 DELETE or FLAGS_ONLY
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
 Atish Patra <atish.patra@wdc.com>, Ben Gardon <bgardon@google.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-riscv@lists.infradead.org,
 Joerg Roedel <joro@8bytes.org>, kvmarm@lists.cs.columbia.edu,
 kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

Sanity check the hva, gfn, and size of a userspace memory region only if
any of those properties can change, i.e. skip the checks for DELETE and
FLAGS_ONLY.  KVM doesn't allow moving the hva or changing the size, a gfn
change shows up as a MOVE even if flags are being modified, and the
checks are pointless for the DELETE case as userspace_addr and gfn_base
are zeroed by common KVM.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/kvm/kvm-s390.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 81f90891db0f..c4d0ed5f3400 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5020,7 +5020,14 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	gpa_t size = new->npages * PAGE_SIZE;
+	gpa_t size;
+
+	/* When we are protected, we should not change the memory slots */
+	if (kvm_s390_pv_get_handle(kvm))
+		return -EINVAL;
+
+	if (change == KVM_MR_DELETE || change == KVM_MR_FLAGS_ONLY)
+		return 0;
 
 	/* A few sanity checks. We can have memory slots which have to be
 	   located/ended at a segment boundary (1MB). The memory in userland is
@@ -5030,15 +5037,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	if (new->userspace_addr & 0xffffful)
 		return -EINVAL;
 
+	size = new->npages * PAGE_SIZE;
 	if (size & 0xffffful)
 		return -EINVAL;
 
 	if ((new->base_gfn * PAGE_SIZE) + size > kvm->arch.mem_limit)
 		return -EINVAL;
 
-	/* When we are protected, we should not change the memory slots */
-	if (kvm_s390_pv_get_handle(kvm))
-		return -EINVAL;
 	return 0;
 }
 
-- 
2.33.1.1089.g2158813163f-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
