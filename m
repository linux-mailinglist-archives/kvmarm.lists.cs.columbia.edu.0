Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7114D444BFD
	for <lists+kvmarm@lfdr.de>; Thu,  4 Nov 2021 01:26:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 13B704B172;
	Wed,  3 Nov 2021 20:26:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IHxUsjd7sHBN; Wed,  3 Nov 2021 20:26:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 642164B0B3;
	Wed,  3 Nov 2021 20:26:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 540A84B1D4
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Nov 2021 20:26:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vXYEKnRlfrQp for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Nov 2021 20:26:08 -0400 (EDT)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EE3734B093
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Nov 2021 20:26:07 -0400 (EDT)
Received: by mail-pf1-f201.google.com with SMTP id
 m26-20020a62a21a000000b0041361973ba7so2330373pff.15
 for <kvmarm@lists.cs.columbia.edu>; Wed, 03 Nov 2021 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=d5eBGhjOdraOb8ROBhsskw4veY1ejlVUg/ty/xkC83c=;
 b=L0C1v+L5WkKOg/1UpzG68qTukZN83qwmMd/ueUN7ewuot9u43aTlXxZMHBpBnaC7/S
 e6lXD4GKbCtYx2tBTmg/D1dxn24ATg3EXOzk/ufgGhsCdxjkWD3S/Oet9+81xR7BjiXX
 KsSER1qqH3/ReOXKXEOMxEw+ZWZNMNrHAG+1wsXmgAmQGJdPsauAqWgxGa2bXM3eqrsd
 MHAblvb9KsqWTWqMYMO09zCzubyhjCK3PZcX9W1VDJfzaXxKjt1+UDPCWwyzZTqBxXQG
 LYMbx+aWi+q//Eh8G56e8rXxUsD7RwW0EkMLPRzsJeTaMSzf+hbvycjlYJ8jReWzoeCU
 NYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=d5eBGhjOdraOb8ROBhsskw4veY1ejlVUg/ty/xkC83c=;
 b=AEkKvaJMnUeoBteqAIZGgJCvCE9B+qlsBx0STGFin3U9LJCzwCuW9Gp+OZ/PN1H/S3
 JsXZTR/WtMu46Na0GqIp2+COnQ8zpf5JMtxTB9NN9QgC2wtARfEwdua2Tp4s+U3kiab8
 +b7trCG/8DSFlTToDh0DGJOSkaNu1S7l+g5wWkDdShhtgcQAiAv2GO99IJqDdhYlCDXT
 MZS4CWhbMphsXti4aYAtPGBL67FtTXi9K7ovEpFqoldPOTQaFRcWzx8+PLus0nIkHJu9
 RvyUgiipWOXrUHb42J1dsyUXr0PPB1esIK69A+vkUQWL5oK+E/63DihuBC9XB581eiM5
 Ox2A==
X-Gm-Message-State: AOAM533Arex44vj/ou3WQdhuBB2NJNERuY/h1Wb6p8fippKVHz1CfTqq
 +t5b+ktX/wSi7xfFKwaLCDNToheipDA=
X-Google-Smtp-Source: ABdhPJwR/8S2bf9OYImnNTGTvQtJKx+tPqKxegkkAxc8UN7P/Djj1xJRY5WUZbtpalPRRv4cuF26HKA4p5A=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr261267pjh.1.1635985566550; Wed, 03 Nov 2021 17:26:06 -0700 (PDT)
Date: Thu,  4 Nov 2021 00:25:06 +0000
In-Reply-To: <20211104002531.1176691-1-seanjc@google.com>
Message-Id: <20211104002531.1176691-6-seanjc@google.com>
Mime-Version: 1.0
References: <20211104002531.1176691-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v5.5 05/30] KVM: Resync only arch fields when slots_arch_lock
 gets reacquired
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

From: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

There is no need to copy the whole memslot data after releasing
slots_arch_lock for a moment to install temporary memslots copy in
kvm_set_memslot() since this lock only protects the arch field of each
memslot.

Just resync this particular field after reacquiring slots_arch_lock.

Note, this also eliminates the need to manually clear the INVALID flag
when restoring memslots; the "setting" of the INVALID flag was an
unwanted side effect of copying the entire memslots.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
[sean: tweak shortlog, note INVALID flag in changelog, revert comment]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6171ddb3e31c..e5c2d10f6111 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1500,12 +1500,6 @@ static size_t kvm_memslots_size(int slots)
 	       (sizeof(struct kvm_memory_slot) * slots);
 }
 
-static void kvm_copy_memslots(struct kvm_memslots *to,
-			      struct kvm_memslots *from)
-{
-	memcpy(to, from, kvm_memslots_size(from->used_slots));
-}
-
 /*
  * Note, at a minimum, the current number of used slots must be allocated, even
  * when deleting a memslot, as we need a complete duplicate of the memslots for
@@ -1524,11 +1518,22 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
 
 	slots = kvzalloc(new_size, GFP_KERNEL_ACCOUNT);
 	if (likely(slots))
-		kvm_copy_memslots(slots, old);
+		memcpy(slots, old, kvm_memslots_size(old->used_slots));
 
 	return slots;
 }
 
+static void kvm_copy_memslots_arch(struct kvm_memslots *to,
+				   struct kvm_memslots *from)
+{
+	int i;
+
+	WARN_ON_ONCE(to->used_slots != from->used_slots);
+
+	for (i = 0; i < from->used_slots; i++)
+		to->memslots[i].arch = from->memslots[i].arch;
+}
+
 static int kvm_set_memslot(struct kvm *kvm,
 			   const struct kvm_userspace_memory_region *mem,
 			   struct kvm_memory_slot *new, int as_id,
@@ -1569,9 +1574,10 @@ static int kvm_set_memslot(struct kvm *kvm,
 		slot->flags |= KVM_MEMSLOT_INVALID;
 
 		/*
-		 * We can re-use the memory from the old memslots.
-		 * It will be overwritten with a copy of the new memslots
-		 * after reacquiring the slots_arch_lock below.
+		 * We can re-use the old memslots, the only difference from the
+		 * newly installed memslots is the invalid flag, which will get
+		 * dropped by update_memslots anyway.  We'll also revert to the
+		 * old memslots if preparing the new memory region fails.
 		 */
 		slots = install_new_memslots(kvm, as_id, slots);
 
@@ -1588,12 +1594,14 @@ static int kvm_set_memslot(struct kvm *kvm,
 		mutex_lock(&kvm->slots_arch_lock);
 
 		/*
-		 * The arch-specific fields of the memslots could have changed
-		 * between releasing the slots_arch_lock in
-		 * install_new_memslots and here, so get a fresh copy of the
-		 * slots.
+		 * The arch-specific fields of the now-active memslots could
+		 * have been modified between releasing slots_arch_lock in
+		 * install_new_memslots and re-acquiring slots_arch_lock above.
+		 * Copy them to the inactive memslots.  Arch code is required
+		 * to retrieve memslots *after* acquiring slots_arch_lock, thus
+		 * the active memslots are guaranteed to be fresh.
 		 */
-		kvm_copy_memslots(slots, __kvm_memslots(kvm, as_id));
+		kvm_copy_memslots_arch(slots, __kvm_memslots(kvm, as_id));
 	}
 
 	/*
@@ -1642,13 +1650,10 @@ static int kvm_set_memslot(struct kvm *kvm,
 	return 0;
 
 out_slots:
-	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
-		slot = id_to_memslot(slots, new->id);
-		slot->flags &= ~KVM_MEMSLOT_INVALID;
+	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
 		slots = install_new_memslots(kvm, as_id, slots);
-	} else {
+	else
 		mutex_unlock(&kvm->slots_arch_lock);
-	}
 	kvfree(slots);
 	return r;
 }
-- 
2.33.1.1089.g2158813163f-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
