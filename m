Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D861158F328
	for <lists+kvmarm@lfdr.de>; Wed, 10 Aug 2022 21:30:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 552754DA49;
	Wed, 10 Aug 2022 15:30:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmRkD7uHklfb; Wed, 10 Aug 2022 15:30:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 29C3E4DA59;
	Wed, 10 Aug 2022 15:30:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 753FC4DA59
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 15:30:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o25shrmn9vWE for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Aug 2022 15:30:52 -0400 (EDT)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 413FB4DA70
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 15:30:51 -0400 (EDT)
Received: by mail-pj1-f74.google.com with SMTP id
 w12-20020a17090a780c00b001f76ed0a1easo3495590pjk.0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Aug 2022 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc;
 bh=ISyf//eKqE0iV9Jad3fzzOnB3Q21JHgqLZOFoVPjKMI=;
 b=Rpt4p2M0H/10ExEF5hENxTIqXeEe2mpTkCUkrm5mtB5m2DgJTHM9DgTYaYdVWE1t70
 Ibz1PyMQMU+JQzBpHh8y77NSSLzNoDgdyNwu4bKW/LeONh1O27Fnef3UG+NqKSxvPOuI
 7K5fxKaOkDXvsux3jkaLsMXNVuVmWuNRkWnfsR63ijxZRE5cHQ/nyYoJ1XnGvlI58xWk
 kt3Niw42xbj0USCsk5HkRyo8Ah6LIVH1L+LqjR6TfQ2sF15B6Vu3JZpCDOCHmf3+oBSB
 JHz7f6lZgjxsPK+fZKVWj/4jKrUcP23UzygWOTRSqFOKGgDwvFbc7eOYYLCGaghgxPf+
 gcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc;
 bh=ISyf//eKqE0iV9Jad3fzzOnB3Q21JHgqLZOFoVPjKMI=;
 b=JS8/BYqYNO6BLrpn2CvkEcXfKwMPx87O4Pl3aUG3xyEr6JwCfMd3NzEnZpZAEs+0Pu
 cHDzAcqhq3gxrnwirUcL+1bwbWXtvX8E3qnaFWjL17Mfqll3+Moa0NsPSdqTTGcEKTgE
 D0Ah9ezktmV8nngQXEiRpd4+Dz2wwly4Onn+u50zhbmIpgblmymfq/lqUyn1B+AR7kph
 UPMYloo9Fjh69YY3VLqtqEXm9HOTvIhiY15ucL31qEQJkz7FfNLlKfxTuUrnokt/CeoM
 C+PIRg8PSin1OAnOe8Lg9qFALUeR2AH4bGNxTDuatlhCUf262af3IPMSloPqtTne8d/O
 bNUw==
X-Gm-Message-State: ACgBeo1SOsWa63/ZpYTcchYGipeUrDfGhDzFx09RgcO5nkVJqLLzckZa
 +plTNoKIUXIXysQo2TXAjWEA4Jo=
X-Google-Smtp-Source: AA6agR4gQa4UYbSdbQyWQV6Bwq7wnb+1/ubEBVorjvVta/rIBUuFcRv4Qi6HBrOfdJr722FFyo+zG5I=
X-Received: from pcc-desktop.svl.corp.google.com
 ([2620:15c:2ce:200:4d8b:fb2a:2ecb:c2bb])
 (user=pcc job=sendgmr) by 2002:a17:902:d54c:b0:170:9ba1:f38f with SMTP id
 z12-20020a170902d54c00b001709ba1f38fmr17494564plf.32.1660159850191; Wed, 10
 Aug 2022 12:30:50 -0700 (PDT)
Date: Wed, 10 Aug 2022 12:30:31 -0700
In-Reply-To: <20220810193033.1090251-1-pcc@google.com>
Message-Id: <20220810193033.1090251-6-pcc@google.com>
Mime-Version: 1.0
References: <20220810193033.1090251-1-pcc@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 5/7] KVM: arm64: unify the tests for VMAs in memslots when
 MTE is enabled
From: Peter Collingbourne <pcc@google.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 Steven Price <steven.price@arm.com>, Marc Zyngier <maz@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>, Evgenii Stepanov <eugenis@google.com>
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

Previously we allowed creating a memslot containing a private mapping that
was not VM_MTE_ALLOWED, but would later reject KVM_RUN with -EFAULT. Now
we reject the memory region at memslot creation time.

Since this is a minor tweak to the ABI (a VMM that created one of
these memslots would fail later anyway), no VMM to my knowledge has
MTE support yet, and the hardware with the necessary features is not
generally available, we can probably make this ABI change at this point.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 arch/arm64/kvm/mmu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 750a69a97994..d54be80e31dd 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1073,6 +1073,19 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 	}
 }
 
+static bool kvm_vma_mte_allowed(struct vm_area_struct *vma)
+{
+	/*
+	 * VM_SHARED mappings are not allowed with MTE to avoid races
+	 * when updating the PG_mte_tagged page flag, see
+	 * sanitise_mte_tags for more details.
+	 */
+	if (vma->vm_flags & VM_SHARED)
+		return false;
+
+	return vma->vm_flags & VM_MTE_ALLOWED;
+}
+
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_memory_slot *memslot, unsigned long hva,
 			  unsigned long fault_status)
@@ -1249,9 +1262,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	}
 
 	if (fault_status != FSC_PERM && !device && kvm_has_mte(kvm)) {
-		/* Check the VMM hasn't introduced a new VM_SHARED VMA */
-		if ((vma->vm_flags & VM_MTE_ALLOWED) &&
-		    !(vma->vm_flags & VM_SHARED)) {
+		/* Check the VMM hasn't introduced a new disallowed VMA */
+		if (kvm_vma_mte_allowed(vma)) {
 			sanitise_mte_tags(kvm, pfn, vma_pagesize);
 		} else {
 			ret = -EFAULT;
@@ -1695,12 +1707,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		if (!vma)
 			break;
 
-		/*
-		 * VM_SHARED mappings are not allowed with MTE to avoid races
-		 * when updating the PG_mte_tagged page flag, see
-		 * sanitise_mte_tags for more details.
-		 */
-		if (kvm_has_mte(kvm) && vma->vm_flags & VM_SHARED) {
+		if (kvm_has_mte(kvm) && !kvm_vma_mte_allowed(vma)) {
 			ret = -EINVAL;
 			break;
 		}
-- 
2.37.1.559.g78731f0fdb-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
