Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9B28C40E9A0
	for <lists+kvmarm@lfdr.de>; Thu, 16 Sep 2021 20:15:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3BC574B174;
	Thu, 16 Sep 2021 14:15:48 -0400 (EDT)
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
	with ESMTP id 6B+f3tHueRf0; Thu, 16 Sep 2021 14:15:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADE2A4B17B;
	Thu, 16 Sep 2021 14:15:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 299D44B090
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 14:15:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZDN2mtC5rBK7 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Sep 2021 14:15:44 -0400 (EDT)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 27C1D4B0B6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 14:15:44 -0400 (EDT)
Received: by mail-qk1-f201.google.com with SMTP id
 w2-20020a3794020000b02903b54f40b442so44991205qkd.0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Sep 2021 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ompqiNMWI2hga8pPlI1DdLrAhAHA2ErmtWHohcgkDnQ=;
 b=EIa4PYxeIB/jdTr4Bj3rabymZMfiRDUda4Z/1Om5oXzv+tZ0fVo/aVqKHI2InGS1OU
 j9lrVhRl1gkVZxnjRo2Omv6GbaDFwuTFsTyhpJYtmlVggm0E+aaYOkyBo2IY8jh1btCe
 GCVbynojpKzy/F6leYHtS6kaa6OBYmyZ/yg5VpAo7eUg7Ay9lq3XlUxJEOuwtyxYRwM7
 U8r/qmsNggetc0Jtt0lQFuvAKtC4IYRkZQuGIYG8PCS2CcI+gaR0uAWDft1vZecQzTlV
 1E3D6XDkidTe09oTgISDpS3sGZjyIeQ2ZsLL11W4oTK5YDPcDw9j6SfA/hsX0uy5AbmI
 bz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ompqiNMWI2hga8pPlI1DdLrAhAHA2ErmtWHohcgkDnQ=;
 b=sxrbvUAmS2l8ZuBOPfCzu78bAutfbaHeX0l1XRihDZxz99WnaubYMyJfpGTCXxL2ab
 4f69JMIJMX8nnZpgJI6L0rTu+INgKc/hhR/xH+5WuBJ5v1wIJZJ9B625frPjCiX7ejFV
 ZIsNIrYg8PU0il/JpJg8pikwt8wDoE1HYSgzwRniwrLRPRGe3Uy47FGgVzroHU/pldMz
 s+6sAJ0ZKtPHD/oe+nFYzbycDTEjYb2jE4Q6NSgr1HlqAhoPEPo6T2hwMym2KoMVOiyT
 +PERgv1fw07lIG9Llmsp0YXau5o1wS8p/YXi7JV53T2v2IvuCf5Nw160I3rAM02MEc6j
 QY5Q==
X-Gm-Message-State: AOAM530wlwwkaS7BL83MgSIqH599wPaVr+vq937vw4QK7XNdrsQtiG82
 VBJKx5FkFbKWKED2ffMKikwneZENl8U=
X-Google-Smtp-Source: ABdhPJyMtDkmedSBXQ9JneBR51sdoiXY3FTPAb7hN3Y4cUearQHH1ZnZgDcI1O9vcz/G/4rXwSUCJqg2mWg=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6214:13ee:: with SMTP id
 ch14mr6861648qvb.43.1631816143780; Thu, 16 Sep 2021 11:15:43 -0700 (PDT)
Date: Thu, 16 Sep 2021 18:15:33 +0000
In-Reply-To: <20210916181538.968978-1-oupton@google.com>
Message-Id: <20210916181538.968978-3-oupton@google.com>
Mime-Version: 1.0
References: <20210916181538.968978-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v8 2/7] KVM: x86: extract KVM_GET_CLOCK/KVM_SET_CLOCK to
 separate functions
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 Sean Christopherson <seanjc@google.com>, David Matlack <dmatlack@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

no functional change intended.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/x86/kvm/x86.c | 99 ++++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1082b48418c3..c910cf31958f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5829,6 +5829,54 @@ int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state)
 }
 #endif /* CONFIG_HAVE_KVM_PM_NOTIFIER */
 
+static int kvm_vm_ioctl_get_clock(struct kvm *kvm, void __user *argp)
+{
+	struct kvm_clock_data data;
+	u64 now_ns;
+
+	now_ns = get_kvmclock_ns(kvm);
+	user_ns.clock = now_ns;
+	user_ns.flags = kvm->arch.use_master_clock ? KVM_CLOCK_TSC_STABLE : 0;
+	memset(&user_ns.pad, 0, sizeof(user_ns.pad));
+
+	if (copy_to_user(argp, &data, sizeof(data)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_vm_ioctl_set_clock(struct kvm *kvm, void __user *argp)
+{
+	struct kvm_arch *ka = &kvm->arch;
+	struct kvm_clock_data data;
+	u64 now_ns;
+
+	if (copy_from_user(&data, argp, sizeof(data)))
+		return -EFAULT;
+
+	if (data.flags)
+		return -EINVAL;
+
+	kvm_hv_invalidate_tsc_page(kvm);
+	kvm_start_pvclock_update(kvm);
+	pvclock_update_vm_gtod_copy(kvm);
+
+	/*
+	 * This pairs with kvm_guest_time_update(): when masterclock is
+	 * in use, we use master_kernel_ns + kvmclock_offset to set
+	 * unsigned 'system_time' so if we use get_kvmclock_ns() (which
+	 * is slightly ahead) here we risk going negative on unsigned
+	 * 'system_time' when 'data.clock' is very small.
+	 */
+	if (kvm->arch.use_master_clock)
+		now_ns = ka->master_kernel_ns;
+	else
+		now_ns = get_kvmclock_base_ns();
+	ka->kvmclock_offset = data.clock - now_ns;
+	kvm_end_pvclock_update(kvm);
+	return 0;
+}
+
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg)
 {
@@ -6072,55 +6120,12 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-	case KVM_SET_CLOCK: {
-		struct kvm_arch *ka = &kvm->arch;
-		struct kvm_clock_data user_ns;
-		u64 now_ns;
-
-		r = -EFAULT;
-		if (copy_from_user(&user_ns, argp, sizeof(user_ns)))
-			goto out;
-
-		r = -EINVAL;
-		if (user_ns.flags)
-			goto out;
-
-		r = 0;
-
-		kvm_hv_invalidate_tsc_page(kvm);
-		kvm_start_pvclock_update(kvm);
-		pvclock_update_vm_gtod_copy(kvm);
-
-		/*
-		 * This pairs with kvm_guest_time_update(): when masterclock is
-		 * in use, we use master_kernel_ns + kvmclock_offset to set
-		 * unsigned 'system_time' so if we use get_kvmclock_ns() (which
-		 * is slightly ahead) here we risk going negative on unsigned
-		 * 'system_time' when 'user_ns.clock' is very small.
-		 */
-		if (kvm->arch.use_master_clock)
-			now_ns = ka->master_kernel_ns;
-		else
-			now_ns = get_kvmclock_base_ns();
-		ka->kvmclock_offset = user_ns.clock - now_ns;
-		kvm_end_pvclock_update(kvm);
+	case KVM_SET_CLOCK:
+		r = kvm_vm_ioctl_set_clock(kvm, argp);
 		break;
-	}
-	case KVM_GET_CLOCK: {
-		struct kvm_clock_data user_ns;
-		u64 now_ns;
-
-		now_ns = get_kvmclock_ns(kvm);
-		user_ns.clock = now_ns;
-		user_ns.flags = kvm->arch.use_master_clock ? KVM_CLOCK_TSC_STABLE : 0;
-		memset(&user_ns.pad, 0, sizeof(user_ns.pad));
-
-		r = -EFAULT;
-		if (copy_to_user(argp, &user_ns, sizeof(user_ns)))
-			goto out;
-		r = 0;
+	case KVM_GET_CLOCK:
+		r = kvm_vm_ioctl_get_clock(kvm, argp);
 		break;
-	}
 	case KVM_MEMORY_ENCRYPT_OP: {
 		r = -ENOTTY;
 		if (kvm_x86_ops.mem_enc_op)
-- 
2.33.0.309.g3052b89438-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
