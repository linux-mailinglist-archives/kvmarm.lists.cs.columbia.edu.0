Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D7F652B52EE
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 21:44:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8DE1E4C269;
	Mon, 16 Nov 2020 15:44:05 -0500 (EST)
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
	with ESMTP id tsIj8phprbHc; Mon, 16 Nov 2020 15:44:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 679D24C280;
	Mon, 16 Nov 2020 15:44:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B715E4C269
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 15:44:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P7FEeTYqGQ1j for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 15:44:02 -0500 (EST)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AD26F4B87F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 15:44:02 -0500 (EST)
Received: by mail-wm1-f65.google.com with SMTP id c9so585831wml.5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xKNCvRo+cWBEwv+iG/MqOVO9vnc8V12glB7ZKcx5VKU=;
 b=uvtq0SJM5qXrnU0ME9zmBaFSQlas8lUR7tXAjYQxsKCnU6Mv96yccWofgGjWu+D1mh
 mWB1poN3vE8wxaPrJkGniVj8DLW7wtyKzrW7pB0S2nrlEW7mmubhnTLbq12562XJlBnS
 NqyXt56AkUb0nSpz1xXjKNLpTQH/grHJMSQnDMLeFaQdzTuCAXGjfX1R50mMBgpmT8vN
 c+p8mqjYRZVp/LLUZS8+VAl+5VlGbGx+dETtuUiK5ziqTTCDt5AmCF5XhZcF1NsSuQyb
 KLASGz2sR/NGVL3uSGy4PgyqPt60UjINx4oNeJ69y4LjYxz+AgSt1IHhCe1qEiq1j7QD
 Pcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xKNCvRo+cWBEwv+iG/MqOVO9vnc8V12glB7ZKcx5VKU=;
 b=swQKy+Vbv83h1yLKUOo1mYxaBL9sDF39RqdpR+1dejGtN2xQKLJRwEv69v9k9/AX92
 4w6J2AnOabWe0qyeeK8j43kvimkbQss0ZqUL1glfoDecryYsrgwDY6QUYgwV5Ugv3u+a
 cGZIr2chLyEIHzUzB7YTb3Pn3UOVv1bIxOnS0FBPP3IO6NoW2GuwxZVZGLYiL2S0YaqU
 Y9uXAhsvuLspnb5VEFNuuP3Z5wjTqqFPXo2rHaES4lvq5vQ0yAfigW1WvBzVv++OaESe
 Daoe3T/gYWTt4mGOUwoW51liY1zzir5pWvkqjbwy9w6IHhRLbRUegs3xQGxk98KHdvfO
 h0tw==
X-Gm-Message-State: AOAM531DN3aTpITWNrihsCasrfX3juO94yiFHdIJk2VxFQJxGQM2VpVr
 9KrS5O7RAaKSF70/oxm95/fpXMm1wywRMDOBFvg=
X-Google-Smtp-Source: ABdhPJyIANBejihi3jGdjfX3z634hE2xrtyZytrb2OvyN3PLZZcUButBGlO29at3MIhqZkdG/pkKGA==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr718274wmf.111.1605559441419; 
 Mon, 16 Nov 2020 12:44:01 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
 by smtp.gmail.com with ESMTPSA id 18sm557066wmo.3.2020.11.16.12.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2020 12:44:00 -0800 (PST)
From: David Brazdil <dbrazdil@google.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2 18/24] kvm: arm64: Add function to enter host from KVM nVHE
 hyp code
Date: Mon, 16 Nov 2020 20:43:12 +0000
Message-Id: <20201116204318.63987-19-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Cc: kernel-team@android.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrew Walbran <qwandor@google.com>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>
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

All nVHE hyp code is currently executed as handlers of host's HVCs. This
will change as nVHE starts intercepting host's PSCI CPU_ON SMCs. The
newly booted CPU will need to initialize EL2 state and then enter the
host. Add __host_enter function that branches into the existing
host state-restoring code after the trap handler would have returned.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/host.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 52dae5cd5a28..170d6f6376ae 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -41,6 +41,7 @@ SYM_FUNC_START(__host_exit)
 	bl	handle_trap
 
 	/* Restore host regs x0-x17 */
+__host_enter_restore_full:
 	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
 	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
 	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
@@ -63,6 +64,14 @@ __host_enter_without_restoring:
 	sb
 SYM_FUNC_END(__host_exit)
 
+/*
+ * void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
+ */
+SYM_FUNC_START(__host_enter)
+	mov	x29, x0
+	b	__host_enter_restore_full
+SYM_FUNC_END(__host_enter)
+
 /*
  * void __noreturn __hyp_do_panic(bool restore_host, u64 spsr, u64 elr, u64 par);
  */
-- 
2.29.2.299.gdc1121823c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
