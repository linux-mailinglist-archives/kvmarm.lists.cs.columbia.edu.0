Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDD455C2B
	for <lists+kvmarm@lfdr.de>; Thu, 18 Nov 2021 14:05:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A9D044B1AF;
	Thu, 18 Nov 2021 08:05:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CYfGacZqqUZT; Thu, 18 Nov 2021 08:05:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47CAE4B1E3;
	Thu, 18 Nov 2021 08:05:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C437D4B18F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 12:40:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iLaqLotQJNbp for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 12:40:54 -0500 (EST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4469B4B090
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 12:40:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=3olV7ZykWgs87FpuKGwDGy9MT4heqwPH6YtSnLHRz6M=; b=SJcA7ODM6+A+x6HIeoJfeygMTJ
 2a3dABEQ0MK9aGzjFtquhX3/MtnfMXS0drDgbD0MNdCDtVZwukiR20+kZKxQdlFjhbj8YAPPQeeMo
 7ELjjLIW106CwCQSfhZ5pJxPZ98zRY/+YWsxbyuNABRsBeUTi3xPZ3oYe+L/cu6HuYtqRAkeSOFLQ
 PBFEMBzta1jK8H7r19d8hGqZayJK72gLMJBhxOsGudRduyECk8NpoOSilXXf1+mGNBaP5CfMYBaNw
 fTxgzR7FbEKfSGHNSxfotchrRXU1iDlsrhw+iSghhjLKde/VTdmanEwM1FnBoVG8NsFwSqujAR4wm
 wmaNf3YQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnOum-007nnH-9j; Wed, 17 Nov 2021 17:40:09 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mnOum-001Gxp-Gs; Wed, 17 Nov 2021 17:40:08 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm <kvm@vger.kernel.org>
Subject: [PATCH v3 10/12] KVM: x86/xen: Maintain valid mapping of Xen
 shared_info page
Date: Wed, 17 Nov 2021 17:40:01 +0000
Message-Id: <20211117174003.297096-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211117174003.297096-1-dwmw2@infradead.org>
References: <20211117174003.297096-1-dwmw2@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 18 Nov 2021 08:05:18 -0500
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

Use the newly reinstated gfn_to_pfn_cache to maintain a kernel mapping
of the Xen shared_info page so that it can be accessed in atomic context.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/xen.c              | 25 ++++++++++++++-----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6ac61f85e07b..4b2b4ecf3b46 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1014,7 +1014,7 @@ struct msr_bitmap_range {
 struct kvm_xen {
 	bool long_mode;
 	u8 upcall_vector;
-	gfn_t shinfo_gfn;
+	struct gfn_to_pfn_cache shinfo_cache;
 };
 
 enum kvm_irqchip_mode {
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index dff2bdf9507a..32a915a4fe20 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -23,16 +23,21 @@ DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
 static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 {
+	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	gpa_t gpa = gfn_to_gpa(gfn);
 	int wc_ofs, sec_hi_ofs;
 	int ret = 0;
 	int idx = srcu_read_lock(&kvm->srcu);
 
-	if (kvm_is_error_hva(gfn_to_hva(kvm, gfn))) {
-		ret = -EFAULT;
+	if (gfn == GPA_INVALID) {
+		kvm_gfn_to_pfn_cache_destroy(kvm, gpc);
 		goto out;
 	}
-	kvm->arch.xen.shinfo_gfn = gfn;
+
+	ret = kvm_gfn_to_pfn_cache_init(kvm, gpc, NULL, false, true, gpa,
+					PAGE_SIZE, true);
+	if (ret)
+		goto out;
 
 	/* Paranoia checks on the 32-bit struct layout */
 	BUILD_BUG_ON(offsetof(struct compat_shared_info, wc) != 0x900);
@@ -260,15 +265,9 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		break;
 
 	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
-		if (data->u.shared_info.gfn == GPA_INVALID) {
-			kvm->arch.xen.shinfo_gfn = GPA_INVALID;
-			r = 0;
-			break;
-		}
 		r = kvm_xen_shared_info_init(kvm, data->u.shared_info.gfn);
 		break;
 
-
 	case KVM_XEN_ATTR_TYPE_UPCALL_VECTOR:
 		if (data->u.vector && data->u.vector < 0x10)
 			r = -EINVAL;
@@ -299,7 +298,10 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 		break;
 
 	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
-		data->u.shared_info.gfn = kvm->arch.xen.shinfo_gfn;
+		if (kvm->arch.xen.shinfo_cache.active)
+			data->u.shared_info.gfn = gpa_to_gfn(kvm->arch.xen.shinfo_cache.gpa);
+		else
+			data->u.shared_info.gfn = GPA_INVALID;
 		r = 0;
 		break;
 
@@ -661,11 +663,12 @@ int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
 
 void kvm_xen_init_vm(struct kvm *kvm)
 {
-	kvm->arch.xen.shinfo_gfn = GPA_INVALID;
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
 {
+	kvm_gfn_to_pfn_cache_destroy(kvm, &kvm->arch.xen.shinfo_cache);
+
 	if (kvm->arch.xen_hvm_config.msr)
 		static_branch_slow_dec_deferred(&kvm_xen_enabled);
 }
-- 
2.31.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
