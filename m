Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D190A269333
	for <lists+kvmarm@lfdr.de>; Mon, 14 Sep 2020 19:28:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 86A694B5AA;
	Mon, 14 Sep 2020 13:28:18 -0400 (EDT)
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
	with ESMTP id U-x-aLjQ8Ybj; Mon, 14 Sep 2020 13:28:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DCC44B58F;
	Mon, 14 Sep 2020 13:28:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C450B4B58D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 13:28:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSAKA1avR6NC for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Sep 2020 13:28:15 -0400 (EDT)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7D5B54B5B8
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 13:28:14 -0400 (EDT)
Received: by mail-wm1-f67.google.com with SMTP id w2so821585wmi.1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Sep 2020 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ev8PHeG2wBS2zSKo7R1VQ4GKo6oUzjZvdtqCLwJ3pDs=;
 b=Ihcd/I42/8bqTmauvPs6wDsvnxOAZx+wYOevPiQvp+xJchPV5GVJkIShVJHhNU2FjO
 Zf1FpuxhmFlq6/3mUCs6IS98Ps2pku3dV/3fh5ECJ4gDZPm9+Ct13ppA30R3IhTtGzSd
 KyjRpOxXeBwr5vS+ttAyiOJy1txvnpeI7w+7wvzy7JfFhvY/m6Hyiw0ksxJxvBH1TKmw
 CpSNjsUVu0fP6g5CeuWF6cI5+zgTBD8gSJA/WEILjUZoiAXavXc7DnpojnXNHupGQsvG
 s7eZ41WyrXa0IMZ4lhH1LzLbNKcQgdbq0M8s5dYCdEOag6uxg2zPjBYciaEkq0N6363O
 Svhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ev8PHeG2wBS2zSKo7R1VQ4GKo6oUzjZvdtqCLwJ3pDs=;
 b=Yw1SVnwf4HeKnxFnJdla3jbzZBSN5CToSKxSsDDSTqutCHIBF99/HNFxSBy3SmCMZP
 cDr1yB+7JxxeccNnSv0Zs+/cd0aKhcEHQw3ZqZ4oT5hSDZKQNF681Oyq+Xtn7nszG8vu
 LhONXveZhz0SeZd24jVAsuz0DAoG1RwNAdgz1XWKnSriAgGr6BnUfssR0SLjvT1vsCKr
 ouTNfC/okyI3MD/1V7QK1u9+8e/HxWnGC/W+P8tuuK9IfqhL29vGOSm++ZYHoBg+eg4a
 2AHcFiobH2X5An4DsAS/47v6d0FGrdhyes8/th3KsD3VNNyV2OWbXz/0uL/ktVMkChK+
 10bw==
X-Gm-Message-State: AOAM531CGLWCtMkD+sr95GtJaHDflqclO7Arq4FIuHaKxDfx0bgvWqyt
 H0E+06He0MII76BfrXHl0zm6fw==
X-Google-Smtp-Source: ABdhPJwtapIR59wfa+PjunnI9DEEbaEmNaoIsHmxwFfZkq+7/rS32R8lqozJpnsFIN4Urr9dofZ6Kw==
X-Received: by 2002:a1c:f619:: with SMTP id w25mr459880wmc.62.1600104493518;
 Mon, 14 Sep 2020 10:28:13 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com.
 [34.77.222.49])
 by smtp.gmail.com with ESMTPSA id s12sm13377783wmd.20.2020.09.14.10.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 10:28:12 -0700 (PDT)
From: George-Aurelian Popescu <georgepope@google.com>
To: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 masahiroy@kernel.org, michal.lkml@markovi.net
Subject: [PATCH 06/14] Fix CFLAGS for UBSAN_BOUNDS on Clang
Date: Mon, 14 Sep 2020 17:27:42 +0000
Message-Id: <20200914172750.852684-7-georgepope@google.com>
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

When the kernel is compiled with Clang, UBSAN_BOUNDS inserts a brk after
the handler call, preventing it from printing any information processed
inside the buffer.
For Clang -fsanitize=bounds expands to -fsanitize=array-bounds and
-fsanitize=local-bounds, and the latter adds a brk after the handler
call

Signed-off-by: George Popescu <georgepope@google.com>
---
 scripts/Makefile.ubsan | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 27348029b2b8..3d15ac346c97 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -4,7 +4,14 @@ ifdef CONFIG_UBSAN_ALIGNMENT
 endif
 
 ifdef CONFIG_UBSAN_BOUNDS
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
+      # For Clang -fsanitize=bounds translates to -fsanitize=array-bounds and
+      # -fsanitize=local-bounds; the latter adds a brk right after the
+      # handler is called.
+      ifdef CONFIG_CC_IS_CLANG
+            CFLAGS_UBSAN += $(call cc-option, -fsanitize=array-bounds)
+      else
+            CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
+      endif
 endif
 
 ifdef CONFIG_UBSAN_MISC
-- 
2.28.0.618.gf4bc123cb7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
