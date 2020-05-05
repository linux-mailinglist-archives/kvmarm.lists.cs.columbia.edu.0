Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 999AE1C5C2E
	for <lists+kvmarm@lfdr.de>; Tue,  5 May 2020 17:45:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B5C54B378;
	Tue,  5 May 2020 11:45:31 -0400 (EDT)
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
	with ESMTP id Is4Uoyl78ajk; Tue,  5 May 2020 11:45:31 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 122964B38B;
	Tue,  5 May 2020 11:45:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 839314B26D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 May 2020 11:45:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wg-7lGDQym6P for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 May 2020 11:45:27 -0400 (EDT)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B70B04B35E
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 May 2020 11:45:27 -0400 (EDT)
Received: by mail-qv1-f74.google.com with SMTP id m20so2597926qvy.13
 for <kvmarm@lists.cs.columbia.edu>; Tue, 05 May 2020 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=xZkMY46MQHUTmYwXbgvsa7D9nZQar5oZ0xdrSMXl1EE=;
 b=vIlT9FOeJe9dKuSAqgfvEMdRFomhGnFi2fh2Yihnu20dipnSDOypjb8F+9lazA/x4/
 MXqAKnMIJ2FyMt6cgEWpR3HWjiwg+NZEhWeSTfeuXhC7zRp7M5TQkHEL1oKdKb1dF0qw
 epN6uVba4fwo7WjrZpmLs4Sd2RaU34PRbWEkeOR7admHGPocnkRdeMhsRTc7u9/vpFUU
 Gbap1JtyCjfW4SAXEjqHjHfXbZUXA4fi/fZ2Ur4RT0Mr8UEp0BY9rNZVlM/01AHCJ8XD
 os7TzXh8Q7b0MhF4rWE+5ee8i8pFixMsledE1TA6egKLkZCra3K8nPRDWKIPylMmaXlq
 tUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=xZkMY46MQHUTmYwXbgvsa7D9nZQar5oZ0xdrSMXl1EE=;
 b=kVxDjJ6rH6QnFqURuIRK1TADPLnnkE/daYONyJxNjGzXNRi6dj5QLhby78AbLRnSxf
 nQgT+bb3pjwqGDoBvvJ9CVK8jjiAskHcdG8m4CJKBJ3nZXXRfZX6WmKDM6oJPCe8tWfC
 7RGBcGuDB4hiZbE5PIKXdHKAGrO4sqUXOj/K0O0m4OSXTkkFFOpByQTfqonBQS8Lg2W+
 jEd6kBYRNRgshxwe3rgG4B1jLw7ebpz0g5mt37BsEmvvyYYGg8hbK+yMaQ/fbm41jwol
 /COHOY7Jn/q3khgCQCjIuIxr8iTPrvNtAMscG1L8XBCatkIC6doxAYnLeLOcRqmxYzPN
 GVTQ==
X-Gm-Message-State: AGi0PuZ3yBr7jHq5puhLxNmnB+td+Hqiv/0ez9qOQrAkx9ljnaU43dw4
 /kI8112pJ3YoNu6vw46uENzT7O81fg==
X-Google-Smtp-Source: APiQypIdESvy121WfBa+ky/85x8D+U3JGSFyZzt31WxNlFLpZdDnubBiUtg7psufWgS5EBIMIqXdMkFIfw==
X-Received: by 2002:a05:6214:16c8:: with SMTP id
 d8mr3284576qvz.93.1588693527297; 
 Tue, 05 May 2020 08:45:27 -0700 (PDT)
Date: Tue,  5 May 2020 16:45:18 +0100
In-Reply-To: <20200505154520.194120-1-tabba@google.com>
Message-Id: <20200505154520.194120-3-tabba@google.com>
Mime-Version: 1.0
References: <20200505154520.194120-1-tabba@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v5 2/4] KVM: arm64: Update help text
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, catalin.marinas@arm.com, julien.thierry.kdev@gmail.com, 
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

From: Will Deacon <will@kernel.org>

arm64 KVM supports 16k pages since 02e0b7600f83
("arm64: kvm: Add support for 16K pages"), so update the Kconfig help
text accordingly.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index ce724e526689..d2cf4f099454 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -44,8 +44,6 @@ config KVM
 	select TASK_DELAY_ACCT
 	---help---
 	  Support hosting virtualized guest machines.
-	  We don't support KVM with 16K page tables yet, due to the multiple
-	  levels of fake page tables.
 
 	  If unsure, say N.
 
-- 
2.26.2.526.g744177e7f7-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
