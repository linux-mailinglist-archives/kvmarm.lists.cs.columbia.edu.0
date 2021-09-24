Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7531B41733D
	for <lists+kvmarm@lfdr.de>; Fri, 24 Sep 2021 14:54:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 249BF4B1CB;
	Fri, 24 Sep 2021 08:54:25 -0400 (EDT)
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
	with ESMTP id PDjajzBqtmqg; Fri, 24 Sep 2021 08:54:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EE6584B1B4;
	Fri, 24 Sep 2021 08:54:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B3DB54B19A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 08:54:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gtPeltea0Oga for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Sep 2021 08:54:19 -0400 (EDT)
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C69E54B089
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 08:54:19 -0400 (EDT)
Received: by mail-wr1-f74.google.com with SMTP id
 h5-20020a5d6885000000b0015e21e37523so7979539wru.10
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=gAyjNp3rW7TPfI7//eqCH4vOMM/PWKliQsJ25oNVe/Q=;
 b=Mtapfc+tk4ahVVDoTy22nyqa+M+lz+QDn+kzdiAfRLfPa2zdGHqMbcoY8BzxnnT4Ce
 cWum2sC4qzxNiAgDgN71HY0fc+KrGPIdKsmx7vvfZMJZsyzXStHuKXPDLgBEQBtzZo1g
 nPsZmTTFPMZ14TmrBHdBoW8H21JEKZa6+PIstkjoUe2sPE8VjIIt/1QrqI1Fyry3T3so
 Y5Ktxzq+xh00yhwaDrMW1n9KcfbArC+SN8UsAc9PskULI7RXut4Jq6alNNq4sbo4IrwU
 NgwauBKAv5Xu2CQoPPkiCDedlkfh/ESAHLGwHqOMNyFIAj6sIFg5yUH+TRCyNYyRwJaO
 EGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=gAyjNp3rW7TPfI7//eqCH4vOMM/PWKliQsJ25oNVe/Q=;
 b=HAAAYMu46e4QXZkwXNXj/J1uR0I6NU7OWvAzQiNTPJCf5Jc0k8AinQLj6VnLhP9oVR
 5E8tOus43sqcm3rhshixS276JB/bZgyrIXum/+q4I6olk9h2TPvEC8E/qdnXsSkzOyR8
 QgZ1hRxSp8HUx1nKGJvP5Zz6mVq0zsQFKw3JFTF9lNYsg/VuSQWhH4Ughz1BE/avwjXh
 pKrPFovkJKWKD4hnsoxzM2xKiDwTf2qx8uO7ck6o0GSYQISNcD+X0XdrLyklVCI3V47a
 2xMDnq2qhHPDgwQhUH8pWAxKM65V5J6IRPLL2vytvLMNhrWC5Bhr3tAyTVASQQEkFsC/
 eSCA==
X-Gm-Message-State: AOAM530suPbI+Bos/rjoMFye0L52pVWV+VXZTKHxvuDesUjoy6IEp5TG
 94y0azJr0nsIoragf/SLpl3cUGtRw7qqkDTrC5xF6OFkZWoWvKw3niRLQUbyiYOsqqVUs1J0Rgg
 YIdxpPQIrDKdObUl+YEIJMnxqb8nTlQdnIvBUU8aBSCqN3u9iQXSvdh5VYGMcPkOYqTA=
X-Google-Smtp-Source: ABdhPJxVUcAxVdEdzqLvk3tG7+vsf8Jt1WEATen5QyS1LkA6oMHpdXD0zU5b5uRnwhULCsb+glF03ab0xA==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a05:600c:4642:: with SMTP id
 n2mr1902362wmo.39.1632488058999; Fri, 24 Sep 2021 05:54:18 -0700 (PDT)
Date: Fri, 24 Sep 2021 13:53:37 +0100
In-Reply-To: <20210924125359.2587041-1-tabba@google.com>
Message-Id: <20210924125359.2587041-9-tabba@google.com>
Mime-Version: 1.0
References: <20210924125359.2587041-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [RFC PATCH v1 08/30] KVM: arm64: add hypervisor state accessors
From: Fuad Tabba <tabba@google.com>
To: kvmarm@lists.cs.columbia.edu
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Part of the state in vcpu_arch is hypervisor-specific. To isolate
that state in future patches, start by creating accessors for
this state rather than by dereferencing vcpu.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 097e5f533af9..280ee23dfc5a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -373,6 +373,13 @@ struct kvm_vcpu_arch {
 	} steal;
 };
 
+/* Accessors for vcpu parameters related to the hypervistor state. */
+#define vcpu_hcr_el2(vcpu) (vcpu)->arch.hcr_el2
+#define vcpu_mdcr_el2(vcpu) (vcpu)->arch.mdcr_el2
+#define vcpu_vsesr_el2(vcpu) (vcpu)->arch.vsesr_el2
+#define vcpu_fault(vcpu) (vcpu)->arch.fault
+#define vcpu_flags(vcpu) (vcpu)->arch.flags
+
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
 #define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
 			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
-- 
2.33.0.685.g46640cef36-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
