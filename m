Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA0269346
	for <lists+kvmarm@lfdr.de>; Mon, 14 Sep 2020 19:28:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C79114B5C3;
	Mon, 14 Sep 2020 13:28:33 -0400 (EDT)
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
	with ESMTP id qCS6tnSMewtQ; Mon, 14 Sep 2020 13:28:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EE194B5B4;
	Mon, 14 Sep 2020 13:28:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 39D6A4B170
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 13:28:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fGFk2lCvVmVd for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Sep 2020 13:28:30 -0400 (EDT)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 94C9A4B590
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 13:28:29 -0400 (EDT)
Received: by mail-wr1-f67.google.com with SMTP id k15so476100wrn.10
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g9asLkQ3OEMA9W3/GEGNRUW1iZejtpJzTvLvCBaNFqA=;
 b=L3Rqn405GYhI0a/LIy0yLk69eNTGI09w8kK3GusLAgD2VDqrXLtU0QNtSaL3E2jnJl
 aS9V/1Ro1pV9zT8KpI+i624XrTJBd2gg/r8uQFwVfpXG+MpZa0bIA2MWLSvZK3m7cUlb
 HzbBUvIql160nVCPNlIZEkaeXxZAoh9ib5Wq8qddUg5N8BFHAy3BANe7Ewvg3428P7P5
 0iUqBEhudOH/vLy73PmHEYdX5AmRKrjarZzGyKMseTtOquPD/o6H1j9mgPUQryGi9J6M
 AqxmR2pfAlDQpRKkGpdaofGPTEPO/SXB7XcE2rogZG7gtfQNXkNYutC/7Ds7WU6ZOgU5
 70ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g9asLkQ3OEMA9W3/GEGNRUW1iZejtpJzTvLvCBaNFqA=;
 b=tQFyvZAYNbgSn0Jxpi+jRiiE26ItftyFRAn6v43zTkWhiT4WvWOGfJqRrOiLxWe8dG
 MWMwyjiQFG9PrRkJHfjnkkqDkxTRvQft5FqeMpmmT/p2WNug9wbOPB/7GkNhc6lh+b99
 5Hpdj8mWbwoKsIz8WVlZzQnlKpCUrtuuUti+qEA9XZA9cKeCwfwML5VOq7X2w5ozOocm
 dXFy6X8yqp80WNmmyEwj+Whq3eXToBKsT4+Eavbkt/lvEVDisWb12PzHIBzSV2Gg1sq4
 ORmngRg9/wDDoculsA69xgqFcjIoTjVcJ3vgyGiSWHgLI4noUubCht7lN4kx9TRvugTK
 oWzg==
X-Gm-Message-State: AOAM5325oFXs3vRXVHf/08WhAzDb0pJy3mfRJdPMhM2yLdav99ev6qkp
 WEMMbkjvUvuZvzFUat6RQJtTDA==
X-Google-Smtp-Source: ABdhPJyuPd0Fs24xYDGYgLUyicl3WMGGQSI7fVgvHIQWca5SpyYpUi5fPphE0FqVU4DtkZnfl8xKwA==
X-Received: by 2002:adf:fec7:: with SMTP id q7mr17052167wrs.293.1600104508663; 
 Mon, 14 Sep 2020 10:28:28 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com.
 [34.77.222.49])
 by smtp.gmail.com with ESMTPSA id o6sm22778704wrm.76.2020.09.14.10.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 10:28:27 -0700 (PDT)
From: George-Aurelian Popescu <georgepope@google.com>
To: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 masahiroy@kernel.org, michal.lkml@markovi.net
Subject: [PATCH 14/14] DO NOT MERGE: Enable configs to test the patch series
Date: Mon, 14 Sep 2020 17:27:50 +0000
Message-Id: <20200914172750.852684-15-georgepope@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200914172750.852684-1-georgepope@google.com>
References: <20200914172750.852684-1-georgepope@google.com>
MIME-Version: 1.0
Cc: arnd@arndb.de, elver@google.com, tglx@linutronix.de, keescook@chromium.org,
 maskray@google.com, linux-kbuild@vger.kernel.org, ndesaulniers@google.com,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 clang-built-linux@googlegroups.com, broonie@kernel.org, dvyukov@google.com,
 natechancellor@gmail.com, kvmarm@lists.cs.columbia.edu,
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

From: George Popescu <georgepope@google.com>

Enable configs from Kconfig.ubsan to test the buffer and
the ubsan_handlers.

Signed-off-by: George Popescu <georgepope@google.com>
---
 lib/Kconfig.ubsan | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 774315de555a..f72b8a564a8c 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -1,9 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARCH_HAS_UBSAN_SANITIZE_ALL
 	bool
+	default y
 
 menuconfig UBSAN
 	bool "Undefined behaviour sanity checker"
+	default y
 	help
 	  This option enables the Undefined Behaviour sanity checker.
 	  Compile-time instrumentation is used to detect various undefined
@@ -82,7 +84,8 @@ config UBSAN_ALIGNMENT
 
 config TEST_UBSAN
 	tristate "Module for testing for undefined behavior detection"
-	depends on m
+	depends on UBSAN
+	default m
 	help
 	  This is a test module for UBSAN.
 	  It triggers various undefined behavior, and detect it.
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
