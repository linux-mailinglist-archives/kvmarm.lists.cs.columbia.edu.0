Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF63E48AE
	for <lists+kvmarm@lfdr.de>; Mon,  9 Aug 2021 17:25:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A3AB4B115;
	Mon,  9 Aug 2021 11:25:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nSZC3DvgUjhW; Mon,  9 Aug 2021 11:25:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0AB94B113;
	Mon,  9 Aug 2021 11:25:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80EF64A1FA
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Aug 2021 11:25:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BA52EYAT0Az6 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Aug 2021 11:25:11 -0400 (EDT)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9A3944A19B
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Aug 2021 11:25:11 -0400 (EDT)
Received: by mail-qv1-f73.google.com with SMTP id
 n14-20020a0c9d4e0000b0290354a5f8c800so1374133qvf.17
 for <kvmarm@lists.cs.columbia.edu>; Mon, 09 Aug 2021 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=WndYnCDMOQzlPd71DewOIEPIaBhgx4ZmPbtWCPoDRhI=;
 b=XGuSt0YhxsImBr6msmOACUEnWDe5RjoMRsWfC6joinmJxH/ccrEqwcaqr0K9ea4kDM
 PLHmWbi+Lhh8yLHGdXomBavPSRAVZMAL8cyJlzE7Ayf/3/45f4IoNaWo2Hb4qacFglSJ
 +BJ8TUJOkcwkRMUt0arMJGnO1cL6VjSD/1EiVvMtauBxIazQsTDmLji32PyBKfkGscqY
 O+JEUiGOAV/z1LTCyODiwmScRaa//NHIuIiu2LpdEoVb3iH/ax0Akw30emloxQ5Y3LWh
 H7zcq+JTl/1swFcTt7/katDOOq5zfZrHT4eTqWSmVRKgGfAImEknabYM4aLPjNb8p8J4
 d1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=WndYnCDMOQzlPd71DewOIEPIaBhgx4ZmPbtWCPoDRhI=;
 b=dcbUNFWvccHWbbvI9cmJqAiZIvnSSpVOM14kJ+W1icLNJnDk1ZCIMhe6Y0gm5sjt1/
 16k3vaYs22764oHk1g9frn6U9U5KV+FMaby2t+DpBcOzx9sZbFaYyQo4hg9w0sRG/o32
 eXdNIIZbAVjw4tnTgflxFIPaNsUBv/RlOUVqWhcjlgbx39aR89BRSnx2Z4c18ckwtMfb
 j76ZAT+RMjSFOOU6kUuXzMRpmXdhIhNsmT3qYMulVDIsiifrpybYWRS7NlNAvUcwa+kn
 UV1P65poEcWSQUVNahkCkwMgmM8hfUrMFIyvCakhjTYTdDXTCWWbdcwNrcu9VJvAOc5w
 +biA==
X-Gm-Message-State: AOAM530UGvoR+aorwBhlySvAhEl0dn1vGv+7dQ+adwDM7/xZtaYkugeA
 nLLJ9w3cDJ5RPZZTHcPaMUTLcuf6qOR+
X-Google-Smtp-Source: ABdhPJxKbzxXq3vACntXFb3WeX5U2azY/J4P0m64KOuxC+yq1GUbq1EaY8YQtx4SiagyVZzS09eoTaGzaXW+
X-Received: from luke.lon.corp.google.com
 ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr24444934qvs.58.1628522711297; Mon, 09 Aug 2021 08:25:11 -0700 (PDT)
Date: Mon,  9 Aug 2021 16:24:36 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-10-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 09/21] KVM: arm64: Tolerate re-creating hyp mappings to set
 software bits
From: Quentin Perret <qperret@google.com>
To: maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, 
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc: qwandor@google.com, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com
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

The current hypervisor stage-1 mapping code doesn't allow changing an
existing valid mapping. Relax this condition by allowing changes that
only target software bits, as that will soon be needed to annotate shared
pages.

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 1ee1168ac32d..2689fcb7901d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -362,6 +362,21 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	return 0;
 }
 
+static bool hyp_pte_needs_update(kvm_pte_t old, kvm_pte_t new)
+{
+	/*
+	 * Tolerate KVM recreating the exact same mapping, or changing software
+	 * bits if the existing mapping was valid.
+	 */
+	if (old == new)
+		return false;
+
+	if (!kvm_pte_valid(old))
+		return true;
+
+	return !WARN_ON((old ^ new) & ~KVM_PTE_LEAF_ATTR_HI_SW);
+}
+
 static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				    kvm_pte_t *ptep, struct hyp_map_data *data)
 {
@@ -371,9 +386,8 @@ static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
-	/* Tolerate KVM recreating the exact same mapping */
 	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
-	if (old != new && !WARN_ON(kvm_pte_valid(old)))
+	if (hyp_pte_needs_update(old, new))
 		smp_store_release(ptep, new);
 
 	data->phys += granule;
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
