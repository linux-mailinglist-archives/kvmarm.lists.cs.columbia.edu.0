Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F3FBB390793
	for <lists+kvmarm@lfdr.de>; Tue, 25 May 2021 19:26:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A784C4B0CF;
	Tue, 25 May 2021 13:26:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rPKN2UXSuk3H; Tue, 25 May 2021 13:26:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89CDC4B0D7;
	Tue, 25 May 2021 13:26:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FA084086D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 May 2021 13:26:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4BUMnYuUj0Ad for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 May 2021 13:26:37 -0400 (EDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id F233C4099E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 May 2021 13:26:36 -0400 (EDT)
Received: by mail-wm1-f41.google.com with SMTP id
 f20-20020a05600c4e94b0290181f6edda88so7045845wmq.2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 May 2021 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=67YF8LAkTfMHmF/4xYtvDZYwRzZrAqbRd318422rBrs=;
 b=hAnPW/aujGCGTiMaO633MECpr3iVHFpZ74vutulN+WOw6UBGyXz1GAaCqDy11v/83w
 JuVngu6+qj9Su7GGBaw9lzZT2V+jnbrmRIQ2QPqfC74LIPdh6NoSQift2znc8TncYSJ/
 5WIrp8G4eEpd3baVNrwwPG3T7qYR29ETlcLmvHvNXZIG4TWI6uQZ/WRe4XqQzzUQSazm
 6IBPpj5SyPDcxOHUZ27Kiq7khCjkeEfbJeUbA6BT0DdnPSSHSScNYlJbZsLKWy7Veuaf
 LYpI1sjWu2KxELfeHYiNKrz44tAd7ChLYpR64Wbw9meArxZ0YZxcQqRWkEjFPuAkrWuR
 oK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=67YF8LAkTfMHmF/4xYtvDZYwRzZrAqbRd318422rBrs=;
 b=t5ZCC3jgV6I/MmWokmgORn9+J8n8SX43BOrLpdmMeEJmVmvxCcQHz/re2D4nR6ErwF
 AV3pUNdHBkPTDbFZbrI+jyKWxZzLkVice6pWj9ZscYSVkdBDw9LE21wSJjsXSmVRIafl
 RWaU04i70ilSokeqpd2kSjfURApZZpj3ki/Fp38hL9afZjSLG7Pbk416J9Nol+SYrJo4
 G/oWwNFM1sQCNgEaem0gzNtcqfDM7fK62K/Qjx4KjTtwCCGuUovq86NnXpUkkwlMApJH
 s1+tYTp9NNNhVw+ZRoBVsLhKHPGQrRTeEqC4HLXjfLdGFpLEUM1JpUBUu+wQtrOdhMTu
 vLiA==
X-Gm-Message-State: AOAM531LmPoYkHK7SNcUnMVidlLNcJWRiHkvxFTWgvgPuHJF57Bg4KVt
 45IoY5vP0YrbCusBy8joOXuXCQ==
X-Google-Smtp-Source: ABdhPJyJYp7TsGzqNrotyZGIGuywGHZ+6MdxUnOEr81W2n3xaTYmNh+EG/ECQ+nN4DEwKaeEZHRcUw==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr25588294wmg.184.1621963596208; 
 Tue, 25 May 2021 10:26:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z131sm3621434wmb.30.2021.05.25.10.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 10:26:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EE4C1FF87;
 Tue, 25 May 2021 18:26:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: kvm@vger.kernel.org
Subject: [kvm-unit-tests PATCH v2 1/4] arm64: remove invalid check from
 its-trigger test
Date: Tue, 25 May 2021 18:26:25 +0100
Message-Id: <20210525172628.2088-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525172628.2088-1-alex.bennee@linaro.org>
References: <20210525172628.2088-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Cc: maz@kernel.org, shashi.mallela@linaro.org, qemu-arm@nongnu.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

V2hpbGUgYW4gSVJRIGlzIG5vdCAiZ3VhcmFudGVlZCB0byBiZSB2aXNpYmxlIHVudGlsIGFuIGFw
cHJvcHJpYXRlCmludmFsaWRhdGlvbiIgaXQgZG9lc24ndCBzdG9wIHRoZSBhY3R1YWwgaW1wbGVt
ZW50YXRpb24gZGVsaXZlcmluZyBpdAplYXJsaWVyIGlmIGl0IHdhbnRzIHRvLiBUaGlzIGlzIHRo
ZSBjYXNlIGZvciBRRU1VJ3MgVENHIGFuZCBhcyB0ZXN0cwpzaG91bGQgb25seSBiZSBjaGVja2lu
ZyBhcmNoaXRlY3R1cmFsIGNvbXBsaWFuY2UgdGhpcyBjaGVjayBpcwppbnZhbGlkLgoKU2lnbmVk
LW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPgpDYzogU2hhc2hp
IE1hbGxlbGEgPHNoYXNoaS5tYWxsZWxhQGxpbmFyby5vcmc+Ci0tLQogYXJtL2dpYy5jIHwgMTQg
KysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJtL2dpYy5jIGIvYXJtL2dpYy5jCmluZGV4IDk4MTM1ZWYu
LmJlZjA2MWEgMTAwNjQ0Ci0tLSBhL2FybS9naWMuYworKysgYi9hcm0vZ2ljLmMKQEAgLTczMiwy
MSArNzMyLDE5IEBAIHN0YXRpYyB2b2lkIHRlc3RfaXRzX3RyaWdnZXIodm9pZCkKIAkJCSJkZXYy
L2V2ZW50aWQ9MjAgZG9lcyBub3QgdHJpZ2dlciBhbnkgTFBJIik7CiAKIAkvKgotCSAqIHJlLWVu
YWJsZSB0aGUgTFBJIGJ1dCB3aWxsaW5nbHkgZG8gbm90IGNhbGwgaW52YWxsCi0JICogc28gdGhl
IGNoYW5nZSBpbiBjb25maWcgaXMgbm90IHRha2VuIGludG8gYWNjb3VudC4KLQkgKiBUaGUgTFBJ
IHNob3VsZCBub3QgaGl0CisJICogcmUtZW5hYmxlIHRoZSBMUEkgYnV0IHdpbGxpbmdseSBkbyBu
b3QgY2FsbCBpbnZhbGwgc28gdGhlCisJICogY2hhbmdlIGluIGNvbmZpZyBpcyBub3QgdGFrZW4g
aW50byBhY2NvdW50LiBXaGlsZSAiQSBjaGFuZ2UKKwkgKiB0byB0aGUgTFBJIGNvbmZpZ3VyYXRp
b24gaXMgbm90IGd1YXJhbnRlZWQgdG8gYmUgdmlzaWJsZQorCSAqIHVudGlsIGFuIGFwcHJvcHJp
YXRlIGludmFsaWRhdGlvbiBvcGVyYXRpb24gaGFzIGNvbXBsZXRlZCIKKwkgKiBoYXJkd2FyZSB0
aGF0IGRvZXNuJ3QgaW1wbGVtZW50IGNhY2hlcyBtYXkgaGF2ZSBkZWxpdmVyZWQKKwkgKiB0aGUg
ZXZlbnQgYXQgYW55IHBvaW50IGFmdGVyIHRoZSBlbmFibGluZy4KIAkgKi8KIAlnaWN2M19scGlf
c2V0X2NvbmZpZyg4MTk1LCBMUElfUFJPUF9ERUZBVUxUKTsKIAlzdGF0c19yZXNldCgpOwogCWNw
dW1hc2tfY2xlYXIoJm1hc2spOwogCWl0c19zZW5kX2ludChkZXYyLCAyMCk7Ci0Jd2FpdF9mb3Jf
aW50ZXJydXB0cygmbWFzayk7Ci0JcmVwb3J0KGNoZWNrX2Fja2VkKCZtYXNrLCAtMSwgLTEpLAot
CQkJImRldjIvZXZlbnRpZD0yMCBzdGlsbCBkb2VzIG5vdCB0cmlnZ2VyIGFueSBMUEkiKTsKIAog
CS8qIE5vdyBjYWxsIHRoZSBpbnZhbGwgYW5kIGNoZWNrIHRoZSBMUEkgaGl0cyAqLwotCXN0YXRz
X3Jlc2V0KCk7Ci0JY3B1bWFza19jbGVhcigmbWFzayk7CiAJY3B1bWFza19zZXRfY3B1KDMsICZt
YXNrKTsKIAlpdHNfc2VuZF9pbnZhbGwoY29sMyk7CiAJd2FpdF9mb3JfaW50ZXJydXB0cygmbWFz
ayk7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpo
dHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
