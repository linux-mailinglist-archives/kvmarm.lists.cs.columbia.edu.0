Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0964D02C
	for <lists+kvmarm@lfdr.de>; Wed, 14 Dec 2022 20:42:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D27234B99D;
	Wed, 14 Dec 2022 14:42:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VQ-EZF9xx6gr; Wed, 14 Dec 2022 14:42:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DB974B977;
	Wed, 14 Dec 2022 14:42:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B6EDC4B952
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Dec 2022 14:42:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwDYpPHVnt55 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Dec 2022 14:42:36 -0500 (EST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 44A1B4B908
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Dec 2022 14:42:36 -0500 (EST)
Received: by mail-pl1-f182.google.com with SMTP id d3so4430618plr.10
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Dec 2022 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ku5jbuAQtkSIptaPybAlGHrWDUjqz+/sshvQ4yTXVKM=;
 b=gFMFZTb9mro+iD15z0WKOAxzMvbSbzWPvCwsv8UgFNQWpsUuXMnYS1PD3tfN9vh+X7
 TxVm4jwzNUIAZ9XHYIdI0sTAawVhxSLk731/QHHR0cEuSWQT3MUJ5gn4LDqw2kfypG1G
 0bQIwCJGwPZ6AKpAq3T0x0kfjiXwM8lxNtxri7D8qhKTIK3pwuhtPFeLIU9CPCLftyT7
 N4dlul+9Y12mjdb0gPr7ygr3Diy6uRM/rtN0bgjbPYE8emVLaRsMCD/6CMXfynWZUtV8
 FUhysphsdX7xRND/cGG0xWBHmRXb2BmyzX1vpYoDF3NQ54Xr6HVNV1VJIIrs+JDUy6J7
 CZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ku5jbuAQtkSIptaPybAlGHrWDUjqz+/sshvQ4yTXVKM=;
 b=3OpE+pNj8CLRdo6UuvmRaRPtA4G9IkrTRzQXr0+M3q3rN2ozcNICsmwjMAUeE7/6Qs
 Xm+BIIfUt739hP5vYZu3yYORSOiE/IjBntrbR4tp4fkf9sIgrn29eO1m4Xe2Kp67x1n4
 CbjrL4k3AOTYanENCpFzCdoRtumbo+rshahJI5Y1wn+zZIkfhmAIHf6OzIjecNqyrQNR
 IHTw/5pbSFYn5CC4B8GxUBfl8+2eP1Jt7STgkPdlnEnRYxmic9Eh+n+JuwbhAEf+0v9D
 NUnOvTR3lyxnOzFouLqdQdCIom7dDTPTeGtjZdd4mBE4Eu2/TNYBTdQAl1tY8/uHgB7v
 TL2g==
X-Gm-Message-State: ANoB5pkwdD0Vj54/98OYLrTJzvWUwTFeF9K1XS01jW83tyMIwx0LA3K/
 0MZP/CWxRq9iOY8MqsxEvKicNQ==
X-Google-Smtp-Source: AA0mqf475+T6XuYTtV2Re11WEmkxZATJINn1AOgHBS3Ie2ZV2UqJ+on0NpT5StpdHjXPTHMnUH99rA==
X-Received: by 2002:a17:90a:2a4f:b0:219:828e:ba2 with SMTP id
 d15-20020a17090a2a4f00b00219828e0ba2mr871582pjg.0.1671046955097; 
 Wed, 14 Dec 2022 11:42:35 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com.
 [34.168.104.7]) by smtp.gmail.com with ESMTPSA id
 a1-20020a170902710100b0018b025d9a40sm2204215pll.256.2022.12.14.11.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 11:42:33 -0800 (PST)
Date: Wed, 14 Dec 2022 19:42:30 +0000
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC PATCH 01/37] KVM: x86/mmu: Store the address space ID
 directly in kvm_mmu_page_role
Message-ID: <Y5onJulY3UQJNrmW@google.com>
References: <20221208193857.4090582-1-dmatlack@google.com>
 <20221208193857.4090582-2-dmatlack@google.com>
 <22fe2332-497e-fe30-0155-e026b0eded97@intel.com>
 <Y5NvYmxpy6BPkmpW@google.com>
 <CALzav=eju4LYyX=ufNneSww+5sraYJ8cfQSi4LTOHfHWmddX9A@mail.gmail.com>
 <Y5dnWgJ0ine55/hN@google.com>
 <CAJhGHyBbjyKVEv3KcoOcPGQ28753FjR_rc9uNDEF3Dd-gNTRGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJhGHyBbjyKVEv3KcoOcPGQ28753FjR_rc9uNDEF3Dd-gNTRGQ@mail.gmail.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Hugh Dickins <hughd@google.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Yang, Weijiang" <weijiang.yang@intel.com>, "Amit, Nadav" <namit@vmware.com>,
 Colin Cross <ccross@google.com>, Ben Gardon <bgardon@google.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 Yu Zhao <yuzhao@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mingwei Zhang <mizhang@google.com>,
 Albert Ou <aou@eecs.berkeley.edu>, xu xin <cgel.zte@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Atish Patra <atishp@atishpatra.org>, David Matlack <dmatlack@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Dec 14, 2022, Lai Jiangshan wrote:
> On Tue, Dec 13, 2022 at 1:47 AM Sean Christopherson <seanjc@google.com> wrote:
> 
> >
> > My preference would be to leave .smm in x86's page role.  IMO, defining multiple
> > address spaces to support SMM emulation was a mistake that should be contained to
> > SMM, i.e. should never be used for any other feature.  And with CONFIG_KVM_SMM,
> > even x86 can opt out.
> >
> 
> 
> I think the name ASID in kvm/x86 should be used for vmcb's ASID,
> vmcs's VPID, and PCID. Using the name ASID for other purposes
> would only result in unnecessary confusion.

I agree in principle, but at this point fixing the problem would require a lot of
churn since "as_id" is pervasive throughout the memslots code.

It should be possible though, as I don't think anything in KVM's uAPI explicitly
takes an as_id, i.e. it's KVM-internal terminology for the most part.

> There is a bug for shadow paging when it uses two separate sets
> of memslots which are using two sets of rmap and page-tracking.
> 
> When SMM world is writing to a non-SMM page which happens to be
> a guest pagetable in the non-SMM world, the write operation will
> go smoothly without specially handled and the shadow page for the guest
> pagetable is neither unshadowed nor marked unsync.  The shadow paging
> code is unaware that the shadow page has deviated from the guest
> pagetable.

Won't the unsync code work as intended?  for_each_gfn_valid_sp_with_gptes()
doesn't consume the slot and I don't see any explicit filtering on role.smm,
i.e. should unsync all SPTEs for the gfn.

Addressing the page-track case is a bit gross, but doesn't appear to be too
difficult.  I wouldn't be surprised if there are other SMM => non-SMM bugs lurking
though.

---
 arch/x86/include/asm/kvm_page_track.h |  2 +-
 arch/x86/kvm/mmu/mmu.c                |  7 +++---
 arch/x86/kvm/mmu/mmu_internal.h       |  3 ++-
 arch/x86/kvm/mmu/page_track.c         | 32 +++++++++++++++++++--------
 arch/x86/kvm/mmu/spte.c               |  2 +-
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index eb186bc57f6a..fdd9de31e160 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -63,7 +63,7 @@ void kvm_slot_page_track_add_page(struct kvm *kvm,
 void kvm_slot_page_track_remove_page(struct kvm *kvm,
 				     struct kvm_memory_slot *slot, gfn_t gfn,
 				     enum kvm_page_track_mode mode);
-bool kvm_slot_page_track_is_active(struct kvm *kvm,
+bool kvm_slot_page_track_is_active(struct kvm_vcpu *vcpu,
 				   const struct kvm_memory_slot *slot,
 				   gfn_t gfn, enum kvm_page_track_mode mode);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 254bc46234e0..1c2200042133 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2715,9 +2715,10 @@ static void kvm_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
  * were marked unsync (or if there is no shadow page), -EPERM if the SPTE must
  * be write-protected.
  */
-int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
+int mmu_try_to_unsync_pages(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
 			    gfn_t gfn, bool can_unsync, bool prefetch)
 {
+	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_page *sp;
 	bool locked = false;
 
@@ -2726,7 +2727,7 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 	 * track machinery is used to write-protect upper-level shadow pages,
 	 * i.e. this guards the role.level == 4K assertion below!
 	 */
-	if (kvm_slot_page_track_is_active(kvm, slot, gfn, KVM_PAGE_TRACK_WRITE))
+	if (kvm_slot_page_track_is_active(vcpu, slot, gfn, KVM_PAGE_TRACK_WRITE))
 		return -EPERM;
 
 	/*
@@ -4127,7 +4128,7 @@ static bool page_fault_handle_page_track(struct kvm_vcpu *vcpu,
 	 * guest is writing the page which is write tracked which can
 	 * not be fixed by page fault handler.
 	 */
-	if (kvm_slot_page_track_is_active(vcpu->kvm, fault->slot, fault->gfn, KVM_PAGE_TRACK_WRITE))
+	if (kvm_slot_page_track_is_active(vcpu, fault->slot, fault->gfn, KVM_PAGE_TRACK_WRITE))
 		return true;
 
 	return false;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index ac00bfbf32f6..38040ab27986 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -156,7 +156,8 @@ static inline bool kvm_mmu_page_ad_need_write_protect(struct kvm_mmu_page *sp)
 	return kvm_x86_ops.cpu_dirty_log_size && sp->role.guest_mode;
 }
 
-int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
+int mmu_try_to_unsync_pages(struct kvm_vcpu *vcpu,
+			    const struct kvm_memory_slot *slot,
 			    gfn_t gfn, bool can_unsync, bool prefetch);
 
 void kvm_mmu_gfn_disallow_lpage(const struct kvm_memory_slot *slot, gfn_t gfn);
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 2e09d1b6249f..0e9bc837257e 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -18,6 +18,7 @@
 
 #include "mmu.h"
 #include "mmu_internal.h"
+#include "smm.h"
 
 bool kvm_page_track_write_tracking_enabled(struct kvm *kvm)
 {
@@ -171,27 +172,40 @@ void kvm_slot_page_track_remove_page(struct kvm *kvm,
 }
 EXPORT_SYMBOL_GPL(kvm_slot_page_track_remove_page);
 
+static bool __kvm_slot_page_track_is_active(const struct kvm_memory_slot *slot,
+					    gfn_t gfn, enum kvm_page_track_mode mode)
+{
+	int index;
+
+	if (!slot)
+		return false;
+
+	index = gfn_to_index(gfn, slot->base_gfn, PG_LEVEL_4K);
+	return !!READ_ONCE(slot->arch.gfn_track[mode][index]);
+}
+
 /*
  * check if the corresponding access on the specified guest page is tracked.
  */
-bool kvm_slot_page_track_is_active(struct kvm *kvm,
+bool kvm_slot_page_track_is_active(struct kvm_vcpu *vcpu,
 				   const struct kvm_memory_slot *slot,
 				   gfn_t gfn, enum kvm_page_track_mode mode)
 {
-	int index;
-
 	if (WARN_ON(!page_track_mode_is_valid(mode)))
 		return false;
 
-	if (!slot)
-		return false;
-
 	if (mode == KVM_PAGE_TRACK_WRITE &&
-	    !kvm_page_track_write_tracking_enabled(kvm))
+	    !kvm_page_track_write_tracking_enabled(vcpu->kvm))
 		return false;
 
-	index = gfn_to_index(gfn, slot->base_gfn, PG_LEVEL_4K);
-	return !!READ_ONCE(slot->arch.gfn_track[mode][index]);
+	if (__kvm_slot_page_track_is_active(slot, gfn, mode))
+		return true;
+
+	if (!is_smm(vcpu))
+		return false;
+
+	return __kvm_slot_page_track_is_active(gfn_to_memslot(vcpu->kvm, gfn),
+					       gfn, mode);
 }
 
 void kvm_page_track_cleanup(struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index c0fd7e049b4e..89ddd113c1b9 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -220,7 +220,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		 * e.g. it's write-tracked (upper-level SPs) or has one or more
 		 * shadow pages and unsync'ing pages is not allowed.
 		 */
-		if (mmu_try_to_unsync_pages(vcpu->kvm, slot, gfn, can_unsync, prefetch)) {
+		if (mmu_try_to_unsync_pages(vcpu, slot, gfn, can_unsync, prefetch)) {
 			pgprintk("%s: found shadow page for %llx, marking ro\n",
 				 __func__, gfn);
 			wrprot = true;

base-commit: e0ef1f14e97ff65adf6e2157952dbbd1e482065c
-- 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
