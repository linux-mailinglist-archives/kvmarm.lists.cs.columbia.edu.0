Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7153FD17
	for <lists+kvmarm@lfdr.de>; Tue,  7 Jun 2022 13:12:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AAC104B33E;
	Tue,  7 Jun 2022 07:12:51 -0400 (EDT)
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
	with ESMTP id n8RJZMOnME2C; Tue,  7 Jun 2022 07:12:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 01C704B358;
	Tue,  7 Jun 2022 07:12:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DCCE649ECC
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jun 2022 18:21:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GpZVjyF6goJ2 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  6 Jun 2022 18:21:11 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C329249EF3
 for <kvmarm@lists.cs.columbia.edu>; Mon,  6 Jun 2022 18:21:11 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 n6-20020a654886000000b003fda8768883so2445798pgs.14
 for <kvmarm@lists.cs.columbia.edu>; Mon, 06 Jun 2022 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ZKvJKacIZPpFbnd53bS1EL2rZ1vkQiMgyn6fonmD758=;
 b=Zr9Q8V4nfUck7UMPiqqnChLoKCpFiU004y5VHpcxyH5mWHlhwIzYxUURvWJBq4dUhI
 PEflFN4+yWiPedkxFNguL6KLVrX7tdllycYtTzVDtLTM5fSldbL5YGtSdvQhicV/VqNC
 W9LyO1FZ89oe3glk7cppYh1QOUL7GWHvzV40mkYxY6Ot8nmOdZ1BmyJNi7r9lWo5/W5N
 bMn6eQ26xiiSsDdv1sGuFTHXiFY4OC6CrIrPysYNh3IdjDsmHyydvK25MNicujeQ5HDt
 CqB1bPPFGYC0qLNs/TbMrK22nRwsnULJfjNvc7HFOqj+269yjI72P9tp9IKYvoEk/5A9
 jikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ZKvJKacIZPpFbnd53bS1EL2rZ1vkQiMgyn6fonmD758=;
 b=hqgGLl6Iye+Yd9m2ZKknudlH1H01hSOlVq8unVX3X1pa6thMn/QMIsQpW4hn0UnMJI
 41czyRu6dxc/vunUpWuuz78DUCVjqxyC0f4gKd8rlW8iWVXO+vTLFCLmVZSd5MvyxHm/
 EmWl7RJtszPGb0GzRuNanlf8IHdm9CyOgeGZA8wlSZvScbpOM3UTOP65qmgLfHJ+AzUP
 3Qt12iQow0kP5CWztoPA07SaWffPjTSabydDr9JMR9SSAAmYrAkEr+WHp8KcM2qbl1sE
 Gv69e8vAzTYcple7XrUoiyRzdsOn7OKTrZ9J1GKjvQUW+w4ypE7xaXwSRDtjvTUxVc0I
 O26A==
X-Gm-Message-State: AOAM531k92ODWy89S7/Z8EzT3Q9Fr+xUGUJ4sEKCDyNm3i/dItZWfhCp
 jMoRjh/g0ttmJUp+DO+BMQS28eWLqGFcL9ck
X-Google-Smtp-Source: ABdhPJydFOJZXIlcEjQkgSriWABs0ECYT0csN/ZfxbgjEAFbaZOYZU1KL+PBDU3VaJNjamZ58gakzobgmymrjjXn
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by
 2002:a17:90b:1650:b0:1e4:cff1:5a86 with SMTP
 id il16-20020a17090b165000b001e4cff15a86mr28806822pjb.30.1654554070851; Mon,
 06 Jun 2022 15:21:10 -0700 (PDT)
Date: Mon,  6 Jun 2022 22:20:56 +0000
In-Reply-To: <20220606222058.86688-1-yosryahmed@google.com>
Message-Id: <20220606222058.86688-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220606222058.86688-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v5 2/4] KVM: mmu: add a helper to account memory used by KVM
 MMU.
From: Yosry Ahmed <yosryahmed@google.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zefan Li <lizefan.x@bytedance.com>, Marc Zyngier <maz@kernel.org>, 
 James Morse <james.morse@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, 
 Joerg Roedel <joro@8bytes.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeelb@google.com>, Oliver Upton <oupton@google.com>
X-Mailman-Approved-At: Tue, 07 Jun 2022 07:12:43 -0400
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

Add a helper to account pages used by KVM for page tables in secondary
pagetable stats. This function will be used by subsequent patches in
different archs.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/kvm_host.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 883e86ec8e8c4..645585f3a4bed 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2246,6 +2246,15 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
+/*
+ * If nr > 1, we assume virt is the address of the first page of a block of
+ * pages that were allocated together (i.e accounted together).
+ */
+static inline void kvm_account_pgtable_pages(void *virt, int nr)
+{
+	mod_lruvec_page_state(virt_to_page(virt), NR_SECONDARY_PAGETABLE, nr);
+}
+
 /*
  * This defines how many reserved entries we want to keep before we
  * kick the vcpu to the userspace to avoid dirty ring full.  This
-- 
2.36.1.255.ge46751e96f-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
