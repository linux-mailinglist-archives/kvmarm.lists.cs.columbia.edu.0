Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB3414A4A
	for <lists+kvmarm@lfdr.de>; Wed, 22 Sep 2021 15:12:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ECB8C4B195;
	Wed, 22 Sep 2021 09:12:23 -0400 (EDT)
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
	with ESMTP id 481+8i13n1LT; Wed, 22 Sep 2021 09:12:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6A2F4B1D7;
	Wed, 22 Sep 2021 09:11:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A3766402DB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 20:06:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3RhycZRLoeWN for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Sep 2021 20:06:14 -0400 (EDT)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BE7EA405A6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 20:06:14 -0400 (EDT)
Received: by mail-qv1-f74.google.com with SMTP id
 cf6-20020a05621403e600b0037a70d2f960so7552312qvb.13
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Sep 2021 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=hykBvrf8DnzH3Q8YHjL/Y0GXRoABX5ADBK+0/12MWfw=;
 b=jKopPzwiybt9fB96grPLhcmov4eHABK3Rn1V3+jC89gDcrIoprd65bnGYY9DP7ju4b
 85kkPs7ZPkL8WlWgMXplyIY3a/z2qIzxH+/FI3XjcdmrliPkx8nPrp2a5kX5Pjc1ywob
 ByTND1+iT+q5EbaKv8lVZV94ko5nNdJrrzXW+BlrNXXtl2FDDO+EPFHPKuUM6DjPG5xB
 A3Kj4DmZiicnBCVFqv70LMvPNdNZybwucvdKO2/8ODrWoNpkysFbo74lUlyrUvFEKlBi
 o1a2jdJRabm/xdF8RFOfzaw+a+ydqqTbWa982xz/HRYZHvnoWhQfVxgfpJMjXOW1pVY7
 0TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=hykBvrf8DnzH3Q8YHjL/Y0GXRoABX5ADBK+0/12MWfw=;
 b=rND1jpZepIqZoy6/BXP5jQEVQWwZCQyP8uGshPCFCtxwpi5aqarQlGA1cw0JqeJ8Ue
 gGpUT8lUNQNVFbyWyx9HV3EI8oQnY4j92tTi8ghGyA2hMG254nAiqglQeY8WH3vArWh0
 6I2iCedUDF5ObO/34B25BCSCjyI6oCi8WO672cmpB9BmD3UCOJ3BTZeS9eHuFCn74Wv5
 TgoEFdN6cNlxi0e8K4ZC+vmXt8NTEfEuKmlPOFocbSxkcv0/7JMqEWfslC56lAluBs3z
 8wmIAFa+H5/iJVUPRD+a492U4UCybuEIB5sJKLQWVoPQofdhm2kyxmafDKgbnL4UvLVY
 ZSpQ==
X-Gm-Message-State: AOAM533RXC0dOC/CPPgHDZmZKiAp8PFyIQ1WizJEHnlh0OTlP011MCAv
 0v/4B+sgYAV7v6sQm93jC52KbxYGpvY=
X-Google-Smtp-Source: ABdhPJy5GySvAYc4kjGUgxPeiS0d5MaL33kPbz4EVAybMqnGUcP/K+XpH6FqRymRPMD4ga0cIEmdn6OzCzE=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1143:: with SMTP id
 p3mr39279294ybu.420.1632269174363; Tue, 21 Sep 2021 17:06:14 -0700 (PDT)
Date: Tue, 21 Sep 2021 17:05:31 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-15-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 14/16] KVM: arm64: Convert to the generic perf callbacks
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
 Nick Hu <nickhu@andestech.com>, 
 Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
X-Mailman-Approved-At: Wed, 22 Sep 2021 09:11:52 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-riscv@lists.infradead.org, Jiri Olsa <jolsa@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Stefano Stabellini <sstabellini@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-csky@vger.kernel.org,
 xen-devel@lists.xenproject.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Artem Kashkanov <artem.kashkanov@intel.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 Like Xu <like.xu.linux@gmail.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

Drop arm64's version of the callbacks in favor of the callbacks provided
by generic KVM, which are semantically identical.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/perf.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 3e99ac4ab2d6..0b902e0d5b5d 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -13,45 +13,15 @@
 
 DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
 
-static unsigned int kvm_guest_state(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-	unsigned int state;
-
-	if (!vcpu)
-		return 0;
-
-	state = PERF_GUEST_ACTIVE;
-	if (!vcpu_mode_priv(vcpu))
-		state |= PERF_GUEST_USER;
-
-	return state;
-}
-
-static unsigned long kvm_get_guest_ip(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	if (WARN_ON_ONCE(!vcpu))
-		return 0;
-
-	return *vcpu_pc(vcpu);
-}
-
-static struct perf_guest_info_callbacks kvm_guest_cbs = {
-	.state		= kvm_guest_state,
-	.get_ip		= kvm_get_guest_ip,
-};
-
 void kvm_perf_init(void)
 {
 	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
 		static_branch_enable(&kvm_arm_pmu_available);
 
-	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_register_perf_callbacks(NULL);
 }
 
 void kvm_perf_teardown(void)
 {
-	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_unregister_perf_callbacks();
 }
-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
