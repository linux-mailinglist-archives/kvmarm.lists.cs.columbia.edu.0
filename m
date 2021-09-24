Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 08BA8417353
	for <lists+kvmarm@lfdr.de>; Fri, 24 Sep 2021 14:55:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ABF404B219;
	Fri, 24 Sep 2021 08:55:08 -0400 (EDT)
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
	with ESMTP id xQklSC36friB; Fri, 24 Sep 2021 08:55:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A2D304B212;
	Fri, 24 Sep 2021 08:55:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 39F424B213
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 08:55:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id piBfZmXG5WVV for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Sep 2021 08:55:05 -0400 (EDT)
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 53BB84B20C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 08:55:05 -0400 (EDT)
Received: by mail-wr1-f73.google.com with SMTP id
 k2-20020adfc702000000b0016006b2da9bso7997754wrg.1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Sep 2021 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=pSU+osLY3SNvsXyTiQYlyo1U/eLzGKvNKDW/e+/rj1k=;
 b=Xi9NRBx5XZozH8rB7huHuBAd6SihWjX6Jrjnf64+NQTSXskvNul2GqBxfiIf7CNmuT
 0iKOKMJ44cK4ZU6Rwz1/SGVVEFbq8t5ri3zkvZ2XFXGbIfk1wobzhlceO01k5FRItErx
 5m5N8vhxsF9ZucNOiJrzQxW+YlmxiRqOMNbZajajDFlgvy9PcYT3txzcp1UEEK+HymzZ
 mZ88QWv7zrABazvTZ2E7mEGuKfuhe+OlDRgTvEyth3hWEwU/z3vdsXhBin4ahImA9ziu
 kvrQd+XmUbwiD6UW0Cszh1IwSROmmsu/e32zONjnwXCme8AzBqfD3Btll6it+ZzXJu+X
 bzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=pSU+osLY3SNvsXyTiQYlyo1U/eLzGKvNKDW/e+/rj1k=;
 b=Fh2kWWkgr+QYi6UHSxh2dAvLGqEr9iszWT+7dc9npKsWvgtXPKodG6oc7p0f65QMVo
 19GaVPalbG2kdRO7kevhlQTSQxDC1RvFwvKjv+GCjZVcl392Ga6bn/FZ07iQ+C0xZ+8j
 dAhLYHSE0skbO4e0uCkdX/Zkj4NA1Y6e5i4W/FfqT8wXoa5/cl+cWuZBS8ETp6coh9cD
 +58s6AmF6pqyKtEToV3kkChQorb4oJeQ++jUbkIVgFF52jA36bNKMNUWjPXuOXgQxJdd
 wUg2lOg5RhcwSdMUPxmSbdRa7n5kBizJLQYpWh5Osj0LH3oPOK5ZUFgE5hIfSAmhsItj
 MrRw==
X-Gm-Message-State: AOAM531XiicoeVoAgeeitC9keeDzg9LU20Jo9UlJs5bkhswbWkuQ6jAM
 6Z2pAMFJg4ULizoSlOEnlZAgzciccrFeSOwPQUbyd+CVlaNp8HyVmQpdS9JqZfnc6mu+jWnhUDc
 LaI8w7WOeOjoMaE1dEN9ei619OsMCrqWzBtrc9kQvtgaEF5mieuERIsqpNmRiBFpQf68=
X-Google-Smtp-Source: ABdhPJyxAytgyRlwjG9Opamr3QJB1iEdrxd/ybpglcgq8dr0JcPPiKb6K3AtAV5QDJY8zF5YOBaDzRTtbA==
X-Received: from tabba.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:482])
 (user=tabba job=sendgmr) by 2002:a1c:a757:: with SMTP id
 q84mr1960176wme.26.1632488104470; 
 Fri, 24 Sep 2021 05:55:04 -0700 (PDT)
Date: Fri, 24 Sep 2021 13:53:59 +0100
In-Reply-To: <20210924125359.2587041-1-tabba@google.com>
Message-Id: <20210924125359.2587041-31-tabba@google.com>
Mime-Version: 1.0
References: <20210924125359.2587041-1-tabba@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [RFC PATCH v1 30/30] [DONOTMERGE] Re-enable warnings
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

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0278bd28bd97..ed669b2d705d 100644
--- a/Makefile
+++ b/Makefile
@@ -504,7 +504,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Werror=return-type -Wno-format-security \
-		   -std=gnu89 -Wno-unused-variable -Wno-unused-function
+		   -std=gnu89
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
-- 
2.33.0.685.g46640cef36-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
