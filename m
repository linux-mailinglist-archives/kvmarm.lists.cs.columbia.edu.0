Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5259B1A770F
	for <lists+kvmarm@lfdr.de>; Tue, 14 Apr 2020 11:11:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 039BA4B1F4;
	Tue, 14 Apr 2020 05:11:39 -0400 (EDT)
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
	with ESMTP id xHY6mJnCTHcw; Tue, 14 Apr 2020 05:11:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D4C8E4B1ED;
	Tue, 14 Apr 2020 05:11:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 605B44B1F0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Apr 2020 19:10:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dXqSeFo2GjfE for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Apr 2020 19:10:21 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 405A64B1B4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Apr 2020 19:10:21 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id u187so9886826pgu.14
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Apr 2020 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=vuPWpOEpABdmh/1VI4/up8dAs2XH63GBNImm7d32EIk=;
 b=uuJSa5giC8TYDkne2taIdNZXmrgXcjt5CgpmGdHhNkQ5j9v4VYPqCbuOp/KxDtbpN/
 4cEve/TUCY86wv/6A7knM+8e9X2X26bBtQI1pCE3hfpB0tNpS2C6uuPLmBbXCsDUsLCt
 yGMJ+F5vrbUcoQa3o341Dx9C5iCe89I30q1guImO4DyqZb4diH3XCeHvbcpviNeozcws
 gj+8/im9ix9ynfMpIso42JYQXromt7QpwqYKI74mEYsJhq5j9oGEAXhJZ135kR2imQDD
 3m4Qjg55XxOsQiFJaEkVMAaVkGz41KeMuqSEUp5ld97t/FXZdGOxaDPNmBYTGbIKMZAN
 aCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=vuPWpOEpABdmh/1VI4/up8dAs2XH63GBNImm7d32EIk=;
 b=pu/LZz5FyhMeOKTPOOCdVjwI7Jllyzm5mL2ObA8QGAAHGXTbe+E4RHO0LdIpsAEkv8
 rEAI9IkziKzuTsKAUsQXMgshVNRF2Z57MFHBVIAc0fbXIC24ZX5h+dYxuy9zhW2e5a+x
 U7aySkEioCMkgUfEzqT8wqOsm+GRoZg7k3XBEwld7IM31xFcQM1QX2Aebadp281RV2Vd
 AKZMUuuTsVwBEJi4GOWfeN+Yg9lJJtg/FOfSUQEv8Qg4ReeS8B+WwV2lZFMRF9zkdNaL
 WlIn8P0rgw3sk61/2vgv4dkn05lB+/7llAp9uJXyg6N169TD+T1jPhfH1QQL7fAI1s2Q
 K+iw==
X-Gm-Message-State: AGi0PuahTI0piOMmV/gdZpIL1NUqH1hKg/xUQTHx0u8NpfZF6dS8Uwhy
 f+xecDxA0iH57EXacWPwetHxxFN31F/m
X-Google-Smtp-Source: APiQypLAo/3dWG3aUJ9m8iimrYZneDDZJRDeReO1X+fvoW4FdoVomY39iYtNWeyL4ijSeh5b/qrZUHHF+4CD
X-Received: by 2002:a63:b256:: with SMTP id t22mr18355736pgo.92.1586819420186; 
 Mon, 13 Apr 2020 16:10:20 -0700 (PDT)
Date: Mon, 13 Apr 2020 16:10:16 -0700
Message-Id: <20200413231016.250737-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH] arm64: kvm: Delete duplicated label: in invalid_vector
From: Fangrui Song <maskray@google.com>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org
X-Mailman-Approved-At: Tue, 14 Apr 2020 05:11:35 -0400
Cc: Fangrui Song <maskray@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
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

SYM_CODE_START defines \label , so it is redundant to define \label again.
A redefinition at the same place is accepted by GNU as
(https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=159fbb6088f17a341bcaaac960623cab881b4981)
but rejected by the clang integrated assembler.

Fixes: 617a2f392c92 ("arm64: kvm: Annotate assembly using modern annoations")
Link: https://github.com/ClangBuiltLinux/linux/issues/988
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/arm64/kvm/hyp/hyp-entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index c2a13ab3c471..9c5cfb04170e 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -198,7 +198,6 @@ SYM_CODE_END(__hyp_panic)
 .macro invalid_vector	label, target = __hyp_panic
 	.align	2
 SYM_CODE_START(\label)
-\label:
 	b \target
 SYM_CODE_END(\label)
 .endm
-- 
2.26.0.110.g2183baf09c-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
