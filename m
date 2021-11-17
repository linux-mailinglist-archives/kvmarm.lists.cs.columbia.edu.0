Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0E178454164
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 07:53:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B22704B17C;
	Wed, 17 Nov 2021 01:53:57 -0500 (EST)
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
	with ESMTP id Bek81JzLrcdA; Wed, 17 Nov 2021 01:53:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ABD3B4B1C8;
	Wed, 17 Nov 2021 01:53:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D8194B176
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:53:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UzAk0u905cYU for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 01:53:54 -0500 (EST)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C6DFB4B0D7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:53:52 -0500 (EST)
Received: by mail-pl1-f201.google.com with SMTP id
 v23-20020a170902bf9700b001421d86afc4so569367pls.9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Nov 2021 22:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=cOVvD3SNDbIL6lfyzdxlcaoY7rN6G8I+IyW+oD8ignM=;
 b=Xlauq9wTt3xE6BYao1bY0HArMFV6nJ6xH/EuP9kpisaxTdt4ScYKFFQdkG9sKoH42R
 NkptaNYJUssNyX3+a9NogLBRKsc+T4nXMSPu5l6ecIZP9dgrCJ0LRj7ZvOKbho3fYKNy
 PhVcALbMCYQ5Ueoz0h1Zle1j3NxvJu/jDi42xUt/UJknbA+Lqr2OvLzYcpG7zS4LUpWS
 nkauUZlcLVqSJnhSegPKecNwi6FsaKPSVXQ2kuwbCvjFz60gmhYejZ728lE6cGAK8Onu
 SHWWKdpNNpAFDd8jo6+oW+sUESEmaN9xI1ziqCGHwbi6sB/ULtj398r4gUOZBz/AtQOk
 ALuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=cOVvD3SNDbIL6lfyzdxlcaoY7rN6G8I+IyW+oD8ignM=;
 b=bv8/uZVt8/MXMR/c+w1u/XIJFkZhyQPcOTTjedDqLb/G+rYAj7tVFzhbelUh6FLfi5
 WhVKzvIe9cwI1oCuCVtporPP3wTYGkPlkNUdwe9VL6gBgel2WNF5mxz+zciBStQ2jS9W
 BtjWtGoPvXNA7zKZYWE3t+3RycXsbX1Hp6731yYt/QPyxrdAgjZeIk63MemPsZ1zCNbp
 s/YTeWeYFflU/X5DL6lz8RQHo6zO2SKkHJi32liKiMhdKxMOZhOAM2r+lZUdggNVzRBQ
 t07yYn9EpyiKAzBLhbvZOc9N24o3rygWvjOASbzFenhsMhW3jAtdE0ENdro+mSVCtWc0
 iLhg==
X-Gm-Message-State: AOAM530cEDxDCpbL+LBa8Ik3JAzsSO9H0FOjdpoEkDnreXLWK8+kBjtS
 mDGCUmzRIASNc4RARg9lm56zF5+UswU=
X-Google-Smtp-Source: ABdhPJxgZUPAeWfxD6o4eFhxbgg1xva8V+KS7wN7lmBeeEQdyhn13ZRClap0+p1FhSsGVbJnsbUOIWe02Cw=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a17:90a:390c:: with SMTP id
 y12mr314910pjb.0.1637132031567; Tue, 16 Nov 2021 22:53:51 -0800 (PST)
Date: Tue, 16 Nov 2021 22:43:57 -0800
In-Reply-To: <20211117064359.2362060-1-reijiw@google.com>
Message-Id: <20211117064359.2362060-28-reijiw@google.com>
Mime-Version: 1.0
References: <20211117064359.2362060-1-reijiw@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [RFC PATCH v3 27/29] KVM: arm64: Initialize trapping of disabled CPU
 features for the guest
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org
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

Call kvm_vcpu_init_traps() at the first KVM_RUN to initialize trapping
of disabled CPU features for the guest.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/arm.c              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9dc9970a2d46..a53949cd53c6 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -747,6 +747,7 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 				struct kvm_arm_copy_mte_tags *copy_tags);
 
 int kvm_id_regs_consistency_check(const struct kvm_vcpu *vcpu);
+void kvm_vcpu_init_traps(struct kvm_vcpu *vcpu);
 
 /* Guest/host FPSIMD coordination helpers */
 int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 64b104ebee73..25a41ff92aa5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -625,6 +625,8 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	 */
 	if (kvm_vm_is_protected(kvm))
 		kvm_call_hyp_nvhe(__pkvm_vcpu_init_traps, vcpu);
+	else
+		kvm_vcpu_init_traps(vcpu);
 
 	return ret;
 }
-- 
2.34.0.rc1.387.gb447b232ab-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
