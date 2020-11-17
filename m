Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB82B6CE0
	for <lists+kvmarm@lfdr.de>; Tue, 17 Nov 2020 19:17:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 48F274B85B;
	Tue, 17 Nov 2020 13:17:14 -0500 (EST)
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
	with ESMTP id 5A20+Ta24GhC; Tue, 17 Nov 2020 13:17:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 53EBE4B710;
	Tue, 17 Nov 2020 13:17:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 049D14B821
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 13:17:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qTk7bymZZEQr for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Nov 2020 13:17:11 -0500 (EST)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 96D464B559
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 13:17:10 -0500 (EST)
Received: by mail-qk1-f201.google.com with SMTP id 198so13838554qkj.7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=ayRqxL4G0sTBj5uvihVXjKdzy9qeF8DDVF1g7AI5ntU=;
 b=q1Y7UuuK4agsFAxmEhSW2c7W+ugWmHqTFkFHYU9uxsHsHtJseCbRf0SQ7qQmqgRH0S
 IJ7WOXz4iTftbE6rNj/KFjacgodQVSpkxUfy87L1meiv0RTeOf2yNb41sch1llaLiN8l
 QJcVAb8dgtRMBXHcZkNOP6wVtXXW2xYp1z/GD3+GA/XjH6FYMBHU3xPpvtCy0VIJ0BtQ
 sEGxtvzteDzBTDjnjh0PUSkWyBWrP9eqltpt89XpKbvqZMDGBqolGqoEZZNhbUJBkAnZ
 jNgMKPq3jNgQD8MMYcnDCDKng1+LvtGR4BfGS2if1J7mwNkJdcBsKq8IyV/2THkKBMO8
 9dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ayRqxL4G0sTBj5uvihVXjKdzy9qeF8DDVF1g7AI5ntU=;
 b=EhcRueuCksOKAkdRrN+/5Zv9f6cbTF5tZScOdFZov+f2xbyJ8PKRVXrPKAJ54Kr9Ih
 vwV6WvJoWSrGSmihQpdoLRsj0jaRrE+2cWitKG+cF3HH+l6FKWeB+9N6gicgqWmLpVDk
 p3OCLi6DJIDiQtT/DwegFGPvufGQoaRRlSAdeyaXfrxZT5Nh5NFnXz9R2RT3F8uVchtU
 jW3zUY5+QFaSLcu6MdMtodl8ErvtEsWlUl/p04d0SkocPKoEmOPytZgeVOXdrZHaZmFx
 cc2g8SndOuC8s3aYLRC0zraEZyFaP+jzPyuIpeKJDSR4oerwtv6SiC9mc3o13R5Bvj/M
 fIpg==
X-Gm-Message-State: AOAM532HZBHAkNBMeU+Qo74/34wNrpW2245lLQ5HNZQzc12CS23fUoTr
 zOmbFgRNtkbGCd/wwdRWrDgqZR9zrsao
X-Google-Smtp-Source: ABdhPJw6vNiywURQRQTe/Th1gnWP0F7Nn6vyTGTOjCETYnBx8vkYHwtVqdL8HyV0Snr2qBKg07hRw7Ypbkm+
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a05:6214:b83:: with SMTP id
 fe3mr531341qvb.24.1605637030158; Tue, 17 Nov 2020 10:17:10 -0800 (PST)
Date: Tue, 17 Nov 2020 18:16:02 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-23-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 22/27] KVM: arm64: Refactor __load_guest_stage2()
From: Quentin Perret <qperret@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, android-kvm@google.com,
 open list <linux-kernel@vger.kernel.org>, kernel-team@android.com,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>
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

Refactor __load_guest_stage2() to introduce __load_stage2() which will
be re-used when loading the host stage 2.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 5a76358e8c7a..96843b7b6eaa 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -321,9 +321,9 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
  * Must be called from hyp code running at EL2 with an updated VTTBR
  * and interrupts disabled.
  */
-static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long vtcr)
 {
-	write_sysreg(kern_hyp_va(mmu->arch)->vtcr, vtcr_el2);
+	write_sysreg(vtcr, vtcr_el2);
 	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
 
 	/*
@@ -334,6 +334,11 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
+static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+{
+	__load_stage2(mmu, kern_hyp_va(mmu->arch)->vtcr);
+}
+
 static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
 {
 	return container_of(mmu->arch, struct kvm, arch);
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
