Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5F517458679
	for <lists+kvmarm@lfdr.de>; Sun, 21 Nov 2021 22:13:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D2F04B132;
	Sun, 21 Nov 2021 16:13:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I8aRKLCvGbbc; Sun, 21 Nov 2021 16:13:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B0E64B1E3;
	Sun, 21 Nov 2021 16:13:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A0E8E4B1AB
 for <kvmarm@lists.cs.columbia.edu>; Sun, 21 Nov 2021 07:55:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TSPL66d+Jdqs for <kvmarm@lists.cs.columbia.edu>;
 Sun, 21 Nov 2021 07:55:49 -0500 (EST)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 965F84B1B0
 for <kvmarm@lists.cs.columbia.edu>; Sun, 21 Nov 2021 07:55:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=G37/BXwBbO12qoWQX4NnszYh9zVH3UVeyBIJn+2R4aE=; b=JD9cQyYlj+W5TB6WMpsgkdF1A3
 lckDprksXoBNRjXhASB/77BiS5aIQMdJsqFZAM2r2V50z/AxsKbwPrH1068TV0RnchaLQrnzToD91
 M60FWV/dEiuXe+jPs9vHPU8j0LHQCIL8QLO12sWstP+R+TkFi3jVusg4+izng5PA5uhgUGdYD0Tun
 /PJtQGs/UgmdJ67BWKd9m1JI0R40I66od2U4SDlu9kyBveyZI/eZLbf02yIorr10DC7Am7C0KX3q4
 NJa8QlqM2dw89VT3gFnRWHs5whZXWS598sT3cLBv1CFA2ieI1sIyNhm/ad4OKba5de8DJjP667znA
 RKYPPrhQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1momMx-00HIgM-AJ; Sun, 21 Nov 2021 12:54:55 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1momMw-0002XY-VB; Sun, 21 Nov 2021 12:54:54 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm <kvm@vger.kernel.org>
Subject: [PATCH v5 11/12] KVM: x86: Fix wall clock writes in Xen shared_info
 not to mark page dirty
Date: Sun, 21 Nov 2021 12:54:50 +0000
Message-Id: <20211121125451.9489-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211121125451.9489-1-dwmw2@infradead.org>
References: <20211121125451.9489-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Sun, 21 Nov 2021 16:13:30 -0500
Cc: Anup Patel <anup.patel@wdc.com>,
 "wanpengli @ tencent . com" <wanpengli@tencent.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Joao Martins <joao.m.martins@oracle.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, "joro @ 8bytes . org" <joro@8bytes.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, karahmed@amazon.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 butt3rflyh4ck <butterflyhuangxx@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "jmattson @ google . com" <jmattson@google.com>,
 "mtosatti @ redhat . com" <mtosatti@redhat.com>, linux-mips@vger.kernel.org,
 kvm-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 "vkuznets @ redhat . com" <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
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

From: David Woodhouse <dwmw@amazon.co.uk>

When dirty ring logging is enabled, any dirty logging without an active
vCPU context will cause a kernel oops. But we've already declared that
the shared_info page doesn't get dirty tracking anyway, since it would
be kind of insane to mark it dirty every time we deliver an event channel
interrupt. Userspace is supposed to just assume it's always dirty any
time a vCPU can run or event channels are routed.

So stop using the generic kvm_write_wall_clock() and just write directly
through the gfn_to_pfn_cache that we already have set up.

We can make kvm_write_wall_clock() static in x86.c again now, but let's
not remove the 'sec_hi_ofs' argument even though it's not used yet. At
some point we *will* want to use that for KVM guests too.

Fixes: 629b5348841a ("KVM: x86/xen: update wallclock region")
Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c |  2 +-
 arch/x86/kvm/x86.h |  1 -
 arch/x86/kvm/xen.c | 62 +++++++++++++++++++++++++++++++++++-----------
 3 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fa56c590d8db..6cb022d0afab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2118,7 +2118,7 @@ static s64 get_kvmclock_base_ns(void)
 }
 #endif
 
-void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
+static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
 {
 	int version;
 	int r;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 997669ae9caa..0260836b42ff 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -306,7 +306,6 @@ static inline bool kvm_vcpu_latch_init(struct kvm_vcpu *vcpu)
 	return is_smm(vcpu) || static_call(kvm_x86_apic_init_signal_blocked)(vcpu);
 }
 
-void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs);
 void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
 
 u64 get_kvmclock_ns(struct kvm *kvm);
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index ceddabd1f5c6..0e3f7d6e9fd7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -25,8 +25,11 @@ DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
+	struct pvclock_wall_clock *wc;
 	gpa_t gpa = gfn_to_gpa(gfn);
-	int wc_ofs, sec_hi_ofs;
+	u32 *wc_sec_hi;
+	u32 wc_version;
+	u64 wall_nsec;
 	int ret = 0;
 	int idx = srcu_read_lock(&kvm->srcu);
 
@@ -35,32 +38,63 @@ static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 		goto out;
 	}
 
-	ret = kvm_gfn_to_pfn_cache_init(kvm, gpc, NULL, false, true, gpa,
-					PAGE_SIZE, false);
-	if (ret)
-		goto out;
+	do {
+		ret = kvm_gfn_to_pfn_cache_init(kvm, gpc, NULL, false, true,
+						gpa, PAGE_SIZE, false);
+		if (ret)
+			goto out;
+
+		/*
+		 * This code mirrors kvm_write_wall_clock() except that it writes
+		 * directly through the pfn cache and doesn't mark the page dirty.
+		 */
+		wall_nsec = ktime_get_real_ns() - get_kvmclock_ns(kvm);
+
+		/* It could be invalid again already, so we need to check */
+		read_lock_irq(&gpc->lock);
+
+		if (gpc->valid)
+			break;
+
+		read_unlock_irq(&gpc->lock);
+	} while (1);
 
 	/* Paranoia checks on the 32-bit struct layout */
 	BUILD_BUG_ON(offsetof(struct compat_shared_info, wc) != 0x900);
 	BUILD_BUG_ON(offsetof(struct compat_shared_info, arch.wc_sec_hi) != 0x924);
 	BUILD_BUG_ON(offsetof(struct pvclock_vcpu_time_info, version) != 0);
 
-	/* 32-bit location by default */
-	wc_ofs = offsetof(struct compat_shared_info, wc);
-	sec_hi_ofs = offsetof(struct compat_shared_info, arch.wc_sec_hi);
-
 #ifdef CONFIG_X86_64
 	/* Paranoia checks on the 64-bit struct layout */
 	BUILD_BUG_ON(offsetof(struct shared_info, wc) != 0xc00);
 	BUILD_BUG_ON(offsetof(struct shared_info, wc_sec_hi) != 0xc0c);
 
-	if (kvm->arch.xen.long_mode) {
-		wc_ofs = offsetof(struct shared_info, wc);
-		sec_hi_ofs = offsetof(struct shared_info, wc_sec_hi);
-	}
+	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
+		struct shared_info *shinfo = gpc->khva;
+
+		wc_sec_hi = &shinfo->wc_sec_hi;
+		wc = &shinfo->wc;
+	} else
 #endif
+	{
+		struct compat_shared_info *shinfo = gpc->khva;
+
+		wc_sec_hi = &shinfo->arch.wc_sec_hi;
+		wc = &shinfo->wc;
+	}
+
+	/* Increment and ensure an odd value */
+	wc_version = wc->version = (wc->version + 1) | 1;
+	smp_wmb();
+
+	wc->nsec = do_div(wall_nsec,  1000000000);
+	wc->sec = (u32)wall_nsec;
+	*wc_sec_hi = wall_nsec >> 32;
+	smp_wmb();
+
+	wc->version = wc_version + 1;
+	read_unlock_irq(&gpc->lock);
 
-	kvm_write_wall_clock(kvm, gpa + wc_ofs, sec_hi_ofs - wc_ofs);
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
 
 out:
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
