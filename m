Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 678851AD92D
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 10:55:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DCFAF4B21B;
	Fri, 17 Apr 2020 04:55:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yPPT+pQ1bJtP; Fri, 17 Apr 2020 04:55:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7A904B21C;
	Fri, 17 Apr 2020 04:55:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E9BC4B18E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 04:55:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2r+Rg1awSTNv for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 04:55:28 -0400 (EDT)
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 01B644B1F5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 04:55:27 -0400 (EDT)
Received: by mail-wm1-f73.google.com with SMTP id c196so551276wmd.3
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=y9D7tF64do0Lb1GooeOG7I1r61FSpBWEbjybs9SEJvg=;
 b=jzUFrMn0dAR7wIhx7VVRsW+t9bYFpANWHGRmljUeh52oIuFZW8NauIZMhWkqo/lcyH
 iRT48D45l7kuhOWeLBG0CujntndxMjIm65fqmNTkHavLzhbTI92OGTLPloR8p7H7UDlm
 PMx8Ym3QqOQEcWCOVpockBXJKSGG+r5mz8bSfYVQiakre6X4voVFGcZV5VVpn39GE0Uu
 lhUipBC9KEVprFlfFre08rXVwguRClHt9TpLI9OjHY8QdcBRmcIX01W75t3oTfcIz8fi
 TbTxtGkM+/VXUMx1EGfLMyRpYlIkoFwMYGdXuKxvSa9BemRwk2CyAT6EO0/H6mHg2Gen
 m7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=y9D7tF64do0Lb1GooeOG7I1r61FSpBWEbjybs9SEJvg=;
 b=Mgq7gIGewGPJu+vTA+z67NN3djFaz49uH1GK7huSVuMVYCeG4JleOVaIbv66CQvSNd
 IeoioYjmiDV2vobc9Jbo5Q33WZx/oiBf2LbKN3t6U2cQZZIKh0SMGVObWpWZyOwsKRAQ
 urfEUB8ttqaOzO3rUYgKDMzcdAj2NSiyN2M8XKDlwbjE9BFPDQ7uiHDlL+iEp+Q5hC1G
 4x4Wdtax/Nbhpeh7/SrqqH23w6ENx0/T0pmewJa5A9pekodPSjKygW4JgrFc7Ec1ZTVz
 tFpJDUGEXpel75yoYLiIKekoYweBxVs62IIUCcg479yB8Rx8F+MrvnXTxxxqgdan5Rrh
 f0Vg==
X-Gm-Message-State: AGi0PuabcAOe6l39r8X4K4FH5HO7nryURihkGc+MMGkGzOsgEvA0O6uJ
 njmgUCORQoYr/eowc3v57WUg5VPzRw==
X-Google-Smtp-Source: APiQypKk6uvxYPwOR9R+rGnMyjpLdkvJfRDmfKNV8A8PAo5KPjhq/SUke1d28JOXHgf2Jzw5kSJG+VCKtg==
X-Received: by 2002:a05:6000:f:: with SMTP id
 h15mr2692393wrx.408.1587113726586; 
 Fri, 17 Apr 2020 01:55:26 -0700 (PDT)
Date: Fri, 17 Apr 2020 09:55:18 +0100
Message-Id: <20200417085522.150701-1-tabba@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH 0/4] KVM: arm64: Tidy up arch Kconfig and Makefiles
From: Fuad Tabba <tabba@google.com>
To: catalin.marinas@arm.com, maz@kernel.org, julien.thierry.kdev@gmail.com, 
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu
Cc: will@kernel.org
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


Hi,

This small patch series tidies up the arm64 KVM build system by
rejigging config options, removing some redundant help text, and
consolidating some of the Makefile rules.

The changes are cosmetic, but it seemed worthwhile to send this out
for consideration.

Cheers,
/fuad

Fuad Tabba (1):
  KVM: arm64: Clean up kvm makefiles

Will Deacon (3):
  KVM: arm64: Kill off CONFIG_KVM_ARM_HOST
  KVM: arm64: Update help text
  KVM: arm64: Change CONFIG_KVM to a menuconfig entry

 arch/arm64/kernel/asm-offsets.c |  2 +-
 arch/arm64/kernel/smp.c         |  2 +-
 arch/arm64/kvm/Kconfig          | 22 ++++++++--------
 arch/arm64/kvm/Makefile         | 45 +++++++++++++--------------------
 arch/arm64/kvm/hyp/Makefile     | 16 ++++--------
 5 files changed, 35 insertions(+), 52 deletions(-)


base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
2.26.0.110.g2183baf09c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
