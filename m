Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 255E7454157
	for <lists+kvmarm@lfdr.de>; Wed, 17 Nov 2021 07:53:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CC6D44B14D;
	Wed, 17 Nov 2021 01:53:37 -0500 (EST)
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
	with ESMTP id ZHwipej5c1ZR; Wed, 17 Nov 2021 01:53:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D2984B161;
	Wed, 17 Nov 2021 01:53:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A75AE406E7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:53:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QSXXGbDkE5kz for <kvmarm@lists.cs.columbia.edu>;
 Wed, 17 Nov 2021 01:53:33 -0500 (EST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 171C44A7FD
 for <kvmarm@lists.cs.columbia.edu>; Wed, 17 Nov 2021 01:53:33 -0500 (EST)
Received: by mail-pf1-f202.google.com with SMTP id
 x25-20020aa79199000000b0044caf0d1ba8so1142083pfa.1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Nov 2021 22:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=/e/xNL5It/1lgtF/0hW/wqDeGrof7OdzTDTZVLebiuk=;
 b=j8pwdmWpIEuKWCZTRLwhV0+yRYK3NzWzVXsmOkuXQzk/OITLmHs/oBnz8G1QX/wawM
 vs/bKWw6PmUCIDTWmNiky72jPMXuslIt8VIV+XhSIsXueL3rJKxq3aQVwCNkYiS+WskV
 KSFv80YxL2vasMGa26Vxi07q1hIQCE9jdF0u9iYfui/TDeSHIRYjdmEK2M9GYYIa/FZe
 85y6czf4vcPBsfW3i3cPheItf4k/flPl08wAWMmMijyctX3SCjp28ZETpem0wYop5kpl
 9e8t18BWLfV9DVa5XK0CrUpd+qB8wfxyE99Fg55DGuKFJtIgdotQ+TTftSsKefX8RpHb
 y22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/e/xNL5It/1lgtF/0hW/wqDeGrof7OdzTDTZVLebiuk=;
 b=3TQP3X4alIj4KvU95hUhJvzY94fv5th15Uylr+Ojl0s1d82Uu9M+v4xmEIrLO5wkwo
 ax51jEYAeZwKBTOGLcPYk+DV7mXN6Jc5pOk3E42jsvS6oy3dJ+vzsSm0RJ07Pd1KXQYo
 T9XY+W7fmK63xP4K+4vxsjrVOAYRgmxBfMOWP8BUmcFyUH8CU4cAAmiizbL0HoN8yPXE
 yrXHl7gjjpW+Xb9vD37nah4O/yYL1yLnlR27Hdj8G/gbSz1Fr2jX2DKUod3PLtlE+3xl
 VcDx7EAlezVFu11f9sFpwMDEeX8DpMK6nT8HKPjYmY9pMXeE5QGeKwAJmL1DddplqKLc
 cVnw==
X-Gm-Message-State: AOAM532bo5DT87hHVKObmTXaV71jVYeIbfoY8cEZLWmZyiyyLgtHhOEY
 WMCpEfydm2Qx/5mbZZeX+7ihpCJt6Fo=
X-Google-Smtp-Source: ABdhPJx7YvjvD0kd3GLB1QJ2fQn3bsN7bXTUBhqNwC5FXsbEwUxuXuwxajhhtCcErhPR8bvE7NcX2/AhwX8=
X-Received: from reiji-vws-sp.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:3d59])
 (user=reijiw job=sendgmr) by 2002:a17:90b:4d0a:: with SMTP id
 mw10mr6995057pjb.89.1637132012388; Tue, 16 Nov 2021 22:53:32 -0800 (PST)
Date: Tue, 16 Nov 2021 22:43:45 -0800
In-Reply-To: <20211117064359.2362060-1-reijiw@google.com>
Message-Id: <20211117064359.2362060-16-reijiw@google.com>
Mime-Version: 1.0
References: <20211117064359.2362060-1-reijiw@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [RFC PATCH v3 15/29] KVM: arm64: Make ID registers without
 id_reg_info writable
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

Make ID registers that don't have id_reg_info writable.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 659ec880d527..35e458cc1e1d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1886,16 +1886,12 @@ static int __set_id_reg(struct kvm_vcpu *vcpu,
 	if (err)
 		return err;
 
-	/* Don't allow to change the reg unless the reg has id_reg_info */
-	if (val != read_id_reg(vcpu, rd, raz) && !GET_ID_REG_INFO(encoding))
+	/* Don't allow to change the reg after the first KVM_RUN. */
+	if ((val != read_id_reg(vcpu, rd, raz)) && vcpu->arch.has_run_once)
 		return -EINVAL;
 
 	if (raz)
-		return 0;
-
-	/* Don't allow to change the reg after the first KVM_RUN. */
-	if (vcpu->arch.has_run_once)
-		return -EINVAL;
+		return (val == 0) ? 0 : -EINVAL;
 
 	err = validate_id_reg(vcpu, rd, val);
 	if (err)
-- 
2.34.0.rc1.387.gb447b232ab-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
