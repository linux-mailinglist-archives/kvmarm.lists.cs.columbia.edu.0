Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 666D534A91B
	for <lists+kvmarm@lfdr.de>; Fri, 26 Mar 2021 14:54:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B39A4B497;
	Fri, 26 Mar 2021 09:54:45 -0400 (EDT)
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
	with ESMTP id daHry64pD+VB; Fri, 26 Mar 2021 09:54:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 515104B4EC;
	Fri, 26 Mar 2021 09:54:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2874F4B46C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Mar 2021 22:20:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KuhIl4cNeS9W for <kvmarm@lists.cs.columbia.edu>;
 Thu, 25 Mar 2021 22:20:52 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2666C4B478
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Mar 2021 22:20:52 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id l83so8333220ybf.22
 for <kvmarm@lists.cs.columbia.edu>; Thu, 25 Mar 2021 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=EpijQ6V8FeVDkD7HX5egdlZ4dc07ENH1xKoxF44zfAY=;
 b=vurensVFR3hrXyY1NMdpbwaru8VIWvzupZGNxIORfKUkaj6cZcAwrW4S7ZbldvFW0e
 1pj7Sjtemz800HdNKoZvFp6F7/aMexhzotPHhhv54wbWGG2b5JKTkMRv9BDbN2E4Ey9T
 8eW4Z03xVOLOX0hzRddgLv1Chs8SDkxnX6z2o6MpxhGggyvr5FcOq858GvWl6ZoPED7P
 ykGFvoJ6wUIWXZYSEL8RaJGkOTiUZy0E1yO+uZS3qT3g2YOPbNYhWH0rLNLhU1rTGhtk
 ls/hhgkUIDYTaauJwhgRarI2uGASQOz/snbsTpI3O7d7JXOpGXiLwzhMRARvAh1o2E/F
 NZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=EpijQ6V8FeVDkD7HX5egdlZ4dc07ENH1xKoxF44zfAY=;
 b=CMt73E6uevIiZmvE4EHYLCuugq2QBK6CGEkl3b7/ZNQtlzSCNIGFR/Te+9vxaL92em
 nQwCN/G4Gfma1laEOXk5YGmec+P1HXvCphAaeuUL40O84N5SVULSvEpkvfGkwnh3mmZu
 mkVXzX6691GSztXqQVQexGRPfjUJEHIaTM5Vrwiq6s7oSJc3cdbzH8sjSzmsEGbmtVDc
 mqQmsVy1MzblZx5XaD7gWJNj1X7NcS6oRe4j0Dkk+DXh7PMc6TA5FZI6ihyF4ZRj1tPz
 YFmGl9tdjut/33prJQMo5CzTuNAuu0IMBROhU0lqOSgVIO11T/ZrfStPkLsTiQ1Cs5sw
 PkPg==
X-Gm-Message-State: AOAM530pKUKXETgHMqLnP/ubcv9M8pT4CubHzWROQjXv2HmqUqTOa9VR
 159UXgYO0UymgeQl6E3GKdStb+Uo8sw=
X-Google-Smtp-Source: ABdhPJzbNsIM618ZsZ/2M+kNXws+VM2rkDgsqZ/Jk+w2Zs+6fUW+W9XFuUI0Kj8VYAgdnJCOOVd45R9L9lU=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:f:10:b1bb:fab2:7ef5:fc7d])
 (user=seanjc job=sendgmr) by 2002:a25:adc5:: with SMTP id
 d5mr15715734ybe.361.1616725251714; 
 Thu, 25 Mar 2021 19:20:51 -0700 (PDT)
Date: Thu, 25 Mar 2021 19:19:57 -0700
In-Reply-To: <20210326021957.1424875-1-seanjc@google.com>
Message-Id: <20210326021957.1424875-19-seanjc@google.com>
Mime-Version: 1.0
References: <20210326021957.1424875-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 18/18] KVM: x86/mmu: Drop trace_kvm_age_page() tracepoint
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, Paolo Bonzini <pbonzini@redhat.com>
X-Mailman-Approved-At: Fri, 26 Mar 2021 09:54:23 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ben Gardon <bgardon@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

Remove x86's trace_kvm_age_page() tracepoint.  It's mostly redundant with
the common trace_kvm_age_hva() tracepoint, and if there is a need for the
extra details, e.g. gfn, referenced, etc... those details should be added
to the common tracepoint so that all architectures and MMUs benefit from
the info.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c     |  1 -
 arch/x86/kvm/mmu/tdp_mmu.c |  2 --
 include/trace/events/kvm.h | 24 ------------------------
 3 files changed, 27 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2070c7a91fdd..9eded46785b5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1467,7 +1467,6 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 	for_each_rmap_spte(rmap_head, &iter, sptep)
 		young |= mmu_spte_age(sptep);
 
-	trace_kvm_age_page(gfn, level, slot, young);
 	return young;
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 21bb8b68a553..2941beb6559a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -949,8 +949,6 @@ static bool age_gfn_range(struct kvm *kvm, struct tdp_iter *iter,
 
 	tdp_mmu_set_spte_no_acc_track(kvm, iter, new_spte);
 
-	trace_kvm_age_page(iter->gfn, iter->level, range->slot, true);
-
 	return true;
 }
 
diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 200eb7465530..37e1e1a2d67d 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -255,30 +255,6 @@ TRACE_EVENT(kvm_fpu,
 	TP_printk("%s", __print_symbolic(__entry->load, kvm_fpu_load_symbol))
 );
 
-TRACE_EVENT(kvm_age_page,
-	TP_PROTO(ulong gfn, int level, struct kvm_memory_slot *slot, int ref),
-	TP_ARGS(gfn, level, slot, ref),
-
-	TP_STRUCT__entry(
-		__field(	u64,	hva		)
-		__field(	u64,	gfn		)
-		__field(	u8,	level		)
-		__field(	u8,	referenced	)
-	),
-
-	TP_fast_assign(
-		__entry->gfn		= gfn;
-		__entry->level		= level;
-		__entry->hva		= ((gfn - slot->base_gfn) <<
-					    PAGE_SHIFT) + slot->userspace_addr;
-		__entry->referenced	= ref;
-	),
-
-	TP_printk("hva %llx gfn %llx level %u %s",
-		  __entry->hva, __entry->gfn, __entry->level,
-		  __entry->referenced ? "YOUNG" : "OLD")
-);
-
 #ifdef CONFIG_KVM_ASYNC_PF
 DECLARE_EVENT_CLASS(kvm_async_get_page_class,
 
-- 
2.31.0.291.g576ba9dcdaf-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
