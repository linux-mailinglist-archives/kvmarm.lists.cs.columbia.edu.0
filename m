Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2B4562E0
	for <lists+kvmarm@lfdr.de>; Thu, 18 Nov 2021 19:47:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 914834B252;
	Thu, 18 Nov 2021 13:47:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oCiHXj+sluge; Thu, 18 Nov 2021 13:47:14 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB71C4B1F3;
	Thu, 18 Nov 2021 13:47:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 229C24B1E6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Nov 2021 13:47:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xlkmNQpOFshW for <kvmarm@lists.cs.columbia.edu>;
 Thu, 18 Nov 2021 13:47:07 -0500 (EST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 00FD74B215
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Nov 2021 13:47:06 -0500 (EST)
Received: by mail-wr1-f43.google.com with SMTP id d27so13428891wrb.6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 18 Nov 2021 10:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TeU0MZFr7GmLIe9/vyMfDVB2g60J2veSoHkG35ZbNRU=;
 b=Pd/DPYoZYGK6uFSc9H3U7K9hIQHjZYDFGKvzgclPl5DPJTFJduZkFHxkmqN0Q0XVt0
 olajLeeHI5UwCkb0zJPcWDdWWZDbTPtD3wcdYmSOMnsUuptkWs3YhGRjmrHUh7leXPgi
 Pxpoyl7z40zimiERppRyHD/OhSekltv6UZDAkxcqCFGoeY677nqcQS3ArwhBnt8zAl+x
 VF7gnJvvDCnGXNM9cYFlx2GqUAlIe1JGZc3z0PB+b7qAfGGb52SX9QofuY2i7UmTmH3S
 0/+TqS5gao/1ItCgFek6FkU8mP4hZ578ua5WVUzrO5sp+Cd3xf0teZhXkE8h4wah0mtx
 6SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TeU0MZFr7GmLIe9/vyMfDVB2g60J2veSoHkG35ZbNRU=;
 b=lQKNtjRz0e3Uwx6HTA10s4zFVmas6KKGcj7/FOQPoWDnytao3K2D111mL0PNAmPWS1
 s+u4xTddSI0u2O0oCcjP04ik2Of6Wv+UCR3yjqIqc2eCVHSbX1bfFaYWNF7UCYVyuUDN
 urEF+w3kYhfmiY+JMJrml1vUgRWOTpAQz7J5J1l4oj2UWNTGq+zlbNVp7ZicFwURqrDL
 SteZ9Gn117PiC6VXyAAb7iloUI3Ko1CEDziEJkR3G0wqQk+aIS2OdP0gjH7hgQlBD5O6
 zuKaIHP7TNfDswP8ieEqjBUG8YU6+/zHwWrTY44gUF16GHE2xcBhF7itOA668jiZeoLB
 anGA==
X-Gm-Message-State: AOAM5319d00ewgn6hNmzlVUr9biHdlh2tPNHdCBstmal623ypWdFDX3h
 BOXrNPluwyqLpb661ZqzudGw9w==
X-Google-Smtp-Source: ABdhPJyi4lZaV7tRL7lIlmxYB1gYsRbfsC01Ue6vCZmf4ZgD1grz5/bZa1hgQf17fiTmeFj5lxx75w==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr34601005wrv.307.1637261225964; 
 Thu, 18 Nov 2021 10:47:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n32sm537042wms.42.2021.11.18.10.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Nov 2021 10:47:04 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 877EA1FFA6;
 Thu, 18 Nov 2021 18:46:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: kvm@vger.kernel.org
Subject: [kvm-unit-tests PATCH v8 10/10] arm/tcg-test: some basic TCG
 exercising tests
Date: Thu, 18 Nov 2021 18:46:50 +0000
Message-Id: <20211118184650.661575-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118184650.661575-1-alex.bennee@linaro.org>
References: <20211118184650.661575-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Cc: maz@kernel.org, qemu-arm@nongnu.org, idan.horowitz@gmail.com,
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

VGhlc2UgdGVzdHMgYXJlIG5vdCByZWFsbHkgYWltZWQgYXQgS1ZNIGF0IGFsbCBidXQgZXhpc3Qg
dG8gc3RyZXRjaApRRU1VJ3MgVENHIGNvZGUgZ2VuZXJhdG9yLiBJbiBwYXJ0aWN1bGFyIHRoZXNl
IGV4ZXJjaXNlIHRoZSBhYmlsaXR5IG9mCnRoZSBUQ0cgdG86CgogICogQ2hhaW4gVHJhbnNsYXRp
b25CbG9ja3MgdG9nZXRoZXIgKHRpZ2h0KQogICogSGFuZGxlIGhlYXZ5IHVzYWdlIG9mIHRoZSB0
Yl9qdW1wX2NhY2hlIChwYWdlZCkKICAqIFBhdGhvbG9naWNhbCBjYXNlIG9mIGNvbXB1dGVkIGxv
Y2FsIGp1bXBzIChjb21wdXRlZCkKCkluIGFkZGl0aW9uIHRoZSB0ZXN0cyBjYW4gYmUgdmFyaWVk
IGJ5IGFkZGluZyBJUEkgSVJRcyBvciBTTUMgc2VxdWVuY2VzCmludG8gdGhlIG1peCB0byBzdHJl
c3MgdGhlIHRjZ19leGl0IGFuZCBpbnZhbGlkYXRpb24gbWVjaGFuaXNtcy4KClRvIGV4cGxpY2l0
bHkgc3RyZXNzIHRoZSB0Yl9mbHVzaCgpIG1lY2hhbmlzbSB5b3UgY2FuIHVzZSB0aGUgbW9kL3Jv
dW5kcwpwYXJhbWV0ZXJzIHRvIGZvcmNlIG1vcmUgZnJlcXVlbnQgdGIgaW52YWxpZGF0aW9uLiBD
b21iaW5lZCB3aXRoIHNldHRpbmcKLXRiLXNpemUgMSBpbiBRRU1VIHRvIGxpbWl0IHRoZSBjb2Rl
IGdlbmVyYXRpb24gYnVmZmVyIHNpemUuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFs
ZXguYmVubmVlQGxpbmFyby5vcmc+CgotLS0KdjUKICAtIGFkZGVkIGFybXY4IHZlcnNpb24gb2Yg
dGhlIHRjZyB0ZXN0cwogIC0gbWF4IG91dCBhdCAtc21wIDQgaW4gdW5pdHRlc3RzLmNmZwogIC0g
YWRkIHVwIElSUXMgc2VudCBhbmQgZGVsaXZlcmVkIGZvciBQQVNTL0ZBSUwKICAtIHRha2UgaW50
byBhY2NvdW50IGVycm9yIGNvdW50CiAgLSBhZGQgInJvdW5kcz0iIHBhcmFtZXRlcgogIC0gdHdl
YWsgc21jIHRvIHRiLXNpemU9MQogIC0gcHJpbnRmIGZtdCBmaXgKdjcKICAtIG1lcmdlZCBpbiBJ
UlEgbnVtZXJvbG9neQogIC0gdXBkYXRlZCB0byBsYXRlc3QgSVJRIEFQSQp2OAogIC0gZml4IHJl
cG9ydCB1c2FnZQogIC0gZml4IGNoZWNrcGF0Y2ggZXJyb3JzCi0tLQogYXJtL01ha2VmaWxlLmFy
bSAgICAgfCAgIDIgKwogYXJtL01ha2VmaWxlLmFybTY0ICAgfCAgIDIgKwogYXJtL01ha2VmaWxl
LmNvbW1vbiAgfCAgIDEgKwogYXJtL3RjZy10ZXN0LWFzbS5TICAgfCAxNzEgKysrKysrKysrKysr
KysrKysrKysrKwogYXJtL3RjZy10ZXN0LWFzbTY0LlMgfCAxNzAgKysrKysrKysrKysrKysrKysr
KysrKwogYXJtL3RjZy10ZXN0LmMgICAgICAgfCAzMzggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwogYXJtL210dGNndGVzdHMuY2ZnICAgfCAgODQgKysrKysrKysr
KysKIDcgZmlsZXMgY2hhbmdlZCwgNzY4IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcm0vdGNnLXRlc3QtYXNtLlMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcm0vdGNnLXRlc3QtYXNt
NjQuUwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFybS90Y2ctdGVzdC5jCgpkaWZmIC0tZ2l0IGEvYXJt
L01ha2VmaWxlLmFybSBiL2FybS9NYWtlZmlsZS5hcm0KaW5kZXggM2E0Y2M2Yi4uMDVlNDdmMSAx
MDA2NDQKLS0tIGEvYXJtL01ha2VmaWxlLmFybQorKysgYi9hcm0vTWFrZWZpbGUuYXJtCkBAIC0z
MSw0ICszMSw2IEBAIHRlc3RzID0KIAogaW5jbHVkZSAkKFNSQ0RJUikvJChURVNUX0RJUikvTWFr
ZWZpbGUuY29tbW9uCiAKKyQoVEVTVF9ESVIpL3RjZy10ZXN0LmVsZjogJChjc3RhcnQubykgJChU
RVNUX0RJUikvdGNnLXRlc3QubyAkKFRFU1RfRElSKS90Y2ctdGVzdC1hc20ubworCiBhcmNoX2Ns
ZWFuOiBhcm1fY2xlYW4KZGlmZiAtLWdpdCBhL2FybS9NYWtlZmlsZS5hcm02NCBiL2FybS9NYWtl
ZmlsZS5hcm02NAppbmRleCBlOGEzOGQ3Li5hYzk0ZjhlIDEwMDY0NAotLS0gYS9hcm0vTWFrZWZp
bGUuYXJtNjQKKysrIGIvYXJtL01ha2VmaWxlLmFybTY0CkBAIC0zNCw1ICszNCw3IEBAIHRlc3Rz
ICs9ICQoVEVTVF9ESVIpL2NhY2hlLmZsYXQKIAogaW5jbHVkZSAkKFNSQ0RJUikvJChURVNUX0RJ
UikvTWFrZWZpbGUuY29tbW9uCiAKKyQoVEVTVF9ESVIpL3RjZy10ZXN0LmVsZjogJChjc3RhcnQu
bykgJChURVNUX0RJUikvdGNnLXRlc3QubyAkKFRFU1RfRElSKS90Y2ctdGVzdC1hc202NC5vCisK
IGFyY2hfY2xlYW46IGFybV9jbGVhbgogCSQoUk0pIGxpYi9hcm02NC8uKi5kCmRpZmYgLS1naXQg
YS9hcm0vTWFrZWZpbGUuY29tbW9uIGIvYXJtL01ha2VmaWxlLmNvbW1vbgppbmRleCA4NjFlNWM3
Li5hYmI2OTQ4IDEwMDY0NAotLS0gYS9hcm0vTWFrZWZpbGUuY29tbW9uCisrKyBiL2FybS9NYWtl
ZmlsZS5jb21tb24KQEAgLTE0LDYgKzE0LDcgQEAgdGVzdHMtY29tbW9uICs9ICQoVEVTVF9ESVIp
L3BsMDMxLmZsYXQKIHRlc3RzLWNvbW1vbiArPSAkKFRFU1RfRElSKS90bGJmbHVzaC1jb2RlLmZs
YXQKIHRlc3RzLWNvbW1vbiArPSAkKFRFU1RfRElSKS9sb2NraW5nLXRlc3QuZmxhdAogdGVzdHMt
Y29tbW9uICs9ICQoVEVTVF9ESVIpL2JhcnJpZXItbGl0bXVzLXRlc3QuZmxhdAordGVzdHMtY29t
bW9uICs9ICQoVEVTVF9ESVIpL3RjZy10ZXN0LmZsYXQKIAogdGVzdHMtYWxsID0gJCh0ZXN0cy1j
b21tb24pICQodGVzdHMpCiBhbGw6IGRpcmVjdG9yaWVzICQodGVzdHMtYWxsKQpkaWZmIC0tZ2l0
IGEvYXJtL3RjZy10ZXN0LWFzbS5TIGIvYXJtL3RjZy10ZXN0LWFzbS5TCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAuLjRlYzQ5NzgKLS0tIC9kZXYvbnVsbAorKysgYi9hcm0vdGNn
LXRlc3QtYXNtLlMKQEAgLTAsMCArMSwxNzEgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyICovCisvKgorICogVENHIFRlc3QgYXNzZW1ibGVyIGZ1bmN0aW9u
cyBmb3IgYXJtdjcgdGVzdHMuCisgKgorICogQ29weXJpZ2h0IChDKSAyMDE2LCBMaW5hcm8gTHRk
LCBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+CisgKgorICogVGhpcyB3b3Jr
IGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIExHUEwsIHZlcnNpb24gMi4K
KyAqCisgKiBUaGVzZSBoZWxwZXIgZnVuY3Rpb25zIGFyZSB3cml0dGVuIGluIHB1cmUgYXNtIHRv
IGNvbnRyb2wgdGhlIHNpemUKKyAqIG9mIHRoZSBiYXNpYyBibG9ja3MgYW5kIGVuc3VyZSB0aGV5
IGZpdCBuZWF0bHkgaW50byBwYWdlCisgKiBhbGlnbmVkIGNodW5rcy4gVGhlIHBhdHRlcm4gb2Yg
YnJhbmNoZXMgdGhleSBmb2xsb3cgaXMgZGV0ZXJtaW5lZCBieQorICogdGhlIDMyIGJpdCBzZWVk
IHRoZXkgYXJlIHBhc3NlZC4gSXQgc2hvdWxkIGJlIHRoZSBzYW1lIGZvciBlYWNoIHNldC4KKyAq
CisgKiBDYWxsaW5nIGNvbnZlbnRpb24KKyAqICAtIHIwLCBpdGVyYXRpb25zCisgKiAgLSByMSwg
anVtcCBwYXR0ZXJuCisgKiAgLSByMi1yMywgc2NyYXRjaAorICoKKyAqIFJldHVybnMgcjAKKyAq
LworCisuYXJtCisKKy5zZWN0aW9uIC50ZXh0CisKKy8qIFRpZ2h0IC0gYWxsIGJsb2NrcyBzaG91
bGQgcXVpY2tseSBiZSBwYXRjaGVkIGFuZCBzaG91bGQgcnVuCisgKiB2ZXJ5IGZhc3QgdW5sZXNz
IGlycXMgb3Igc21jIGdldHMgaW4gdGhlIHdheQorICovCisKKy5nbG9iYWwgdGlnaHRfc3RhcnQK
K3RpZ2h0X3N0YXJ0OgorICAgICAgICBzdWJzICAgIHIwLCByMCwgIzEKKyAgICAgICAgYmVxICAg
ICB0aWdodF9lbmQKKworICAgICAgICByb3IgICAgIHIxLCByMSwgIzEKKyAgICAgICAgdHN0ICAg
ICByMSwgIzEKKyAgICAgICAgYmVxICAgICB0aWdodEEKKyAgICAgICAgYiAgICAgICB0aWdodF9z
dGFydAorCit0aWdodEE6CisgICAgICAgIHN1YnMgICAgcjAsIHIwLCAjMQorICAgICAgICBiZXEg
ICAgIHRpZ2h0X2VuZAorCisgICAgICAgIHJvciAgICAgcjEsIHIxLCAjMQorICAgICAgICB0c3Qg
ICAgIHIxLCAjMQorICAgICAgICBiZXEgICAgIHRpZ2h0QgorICAgICAgICBiICAgICAgIHRpZ2h0
X3N0YXJ0CisKK3RpZ2h0QjoKKyAgICAgICAgc3VicyAgICByMCwgcjAsICMxCisgICAgICAgIGJl
cSAgICAgdGlnaHRfZW5kCisKKyAgICAgICAgcm9yICAgICByMSwgcjEsICMxCisgICAgICAgIHRz
dCAgICAgcjEsICMxCisgICAgICAgIGJlcSAgICAgdGlnaHRfc3RhcnQKKyAgICAgICAgYiAgICAg
ICB0aWdodEEKKworLmdsb2JhbCB0aWdodF9lbmQKK3RpZ2h0X2VuZDoKKyAgICAgICAgbW92ICAg
ICBwYywgbHIKKworLyoKKyAqIENvbXB1dGVkIGp1bXBzIGNhbm5vdCBiZSBoYXJkd2lyZWQgaW50
byB0aGUgYmFzaWMgYmxvY2tzIHNvIGVhY2ggb25lCisgKiB3aWxsIGNhdXNlIGFuIGV4aXQgZm9y
IHRoZSBtYWluIGV4ZWN1dGlvbiBsb29wIHRvIGxvb2sgdXAgdGhlIG5leHQgYmxvY2suCisgKgor
ICogVGhlcmUgaXMgc29tZSBjYWNoaW5nIHdoaWNoIHNob3VsZCBhbWVsaW9yYXRlIHRoZSBjb3N0
IGEgbGl0dGxlLgorICovCisKKyAgICAgICAgLyogQWxpZ24gPDwgMTMgPT0gNDA5NiBieXRlIGFs
aWdubWVudCAqLworICAgICAgICAuYWxpZ24gMTMKKyAgICAgICAgLmdsb2JhbCBjb21wdXRlZF9z
dGFydAorY29tcHV0ZWRfc3RhcnQ6CisgICAgICAgIHN1YnMgICAgcjAsIHIwLCAjMQorICAgICAg
ICBiZXEgICAgIGNvbXB1dGVkX2VuZAorCisgICAgICAgIC8qIEp1bXAgdGFibGUgKi8KKyAgICAg
ICAgcm9yICAgICByMSwgcjEsICMxCisgICAgICAgIGFuZCAgICAgcjIsIHIxLCAjMQorICAgICAg
ICBhZHIgICAgIHIzLCBjb21wdXRlZF9qdW1wX3RhYmxlCisgICAgICAgIGxkciAgICAgcjIsIFty
MywgcjIsIGxzbCAjMl0KKyAgICAgICAgbW92ICAgICBwYywgcjIKKworICAgICAgICBiICAgICAg
IGNvbXB1dGVkX2VycgorCitjb21wdXRlZF9qdW1wX3RhYmxlOgorICAgICAgICAud29yZCAgIGNv
bXB1dGVkX3N0YXJ0CisgICAgICAgIC53b3JkICAgY29tcHV0ZWRBCisKK2NvbXB1dGVkQToKKyAg
ICAgICAgc3VicyAgICByMCwgcjAsICMxCisgICAgICAgIGJlcSAgICAgY29tcHV0ZWRfZW5kCisK
KyAgICAgICAgLyogSnVtcCBpbnRvIGNvZGUgKi8KKyAgICAgICAgcm9yICAgICByMSwgcjEsICMx
CisgICAgICAgIGFuZCAgICAgcjIsIHIxLCAjMQorICAgICAgICBhZHIgICAgIHIzLCAxZgorICAg
ICAgICBhZGQJcjMsIHIyLCBsc2wgIzIKKyAgICAgICAgbW92ICAgICBwYywgcjMKKzE6ICAgICAg
YiAgICAgICBjb21wdXRlZF9zdGFydAorICAgICAgICBiICAgICAgIGNvbXB1dGVkQgorCisgICAg
ICAgIGIgICAgICAgY29tcHV0ZWRfZXJyCisKKworY29tcHV0ZWRCOgorICAgICAgICBzdWJzICAg
IHIwLCByMCwgIzEKKyAgICAgICAgYmVxICAgICBjb21wdXRlZF9lbmQKKyAgICAgICAgcm9yICAg
ICByMSwgcjEsICMxCisKKyAgICAgICAgLyogQ29uZGl0aW9uYWwgcmVnaXN0ZXIgbG9hZCAqLwor
ICAgICAgICBhZHIgICAgIHIzLCBjb21wdXRlZEEKKyAgICAgICAgdHN0ICAgICByMSwgIzEKKyAg
ICAgICAgYWRyZXEgICByMywgY29tcHV0ZWRfc3RhcnQKKyAgICAgICAgbW92ICAgICBwYywgcjMK
KworICAgICAgICBiICAgICAgIGNvbXB1dGVkX2VycgorCitjb21wdXRlZF9lcnI6CisgICAgICAg
IG1vdiAgICAgcjAsICMxCisgICAgICAgIC5nbG9iYWwgY29tcHV0ZWRfZW5kCitjb21wdXRlZF9l
bmQ6CisgICAgICAgIG1vdiAgICAgcGMsIGxyCisKKworLyoKKyAqIFBhZ2UgaG9waW5nCisgKgor
ICogRWFjaCBibG9jayBpcyBpbiBhIGRpZmZlcmVudCBwYWdlLCBoZW5jZSB0aGUgYmxvY2tzIG5l
dmVyIGdldCBqb2luZWQKKyAqLworICAgICAgICAvKiBBbGlnbiA8PCAxMyA9PSA0MDk2IGJ5dGUg
YWxpZ25tZW50ICovCisgICAgICAgIC5hbGlnbiAxMworICAgICAgICAuZ2xvYmFsIHBhZ2VkX3N0
YXJ0CitwYWdlZF9zdGFydDoKKyAgICAgICAgc3VicyAgICByMCwgcjAsICMxCisgICAgICAgIGJl
cSAgICAgcGFnZWRfZW5kCisKKyAgICAgICAgcm9yICAgICByMSwgcjEsICMxCisgICAgICAgIHRz
dCAgICAgcjEsICMxCisgICAgICAgIGJlcSAgICAgcGFnZWRBCisgICAgICAgIGIgICAgICAgcGFn
ZWRfc3RhcnQKKworICAgICAgICAvKiBBbGlnbiA8PCAxMyA9PSA0MDk2IGJ5dGUgYWxpZ25tZW50
ICovCisgICAgICAgIC5hbGlnbiAxMworcGFnZWRBOgorICAgICAgICBzdWJzICAgIHIwLCByMCwg
IzEKKyAgICAgICAgYmVxICAgICBwYWdlZF9lbmQKKworICAgICAgICByb3IgICAgIHIxLCByMSwg
IzEKKyAgICAgICAgdHN0ICAgICByMSwgIzEKKyAgICAgICAgYmVxICAgICBwYWdlZEIKKyAgICAg
ICAgYiAgICAgICBwYWdlZF9zdGFydAorCisgICAgICAgIC8qIEFsaWduIDw8IDEzID09IDQwOTYg
Ynl0ZSBhbGlnbm1lbnQgKi8KKyAgICAgICAgLmFsaWduIDEzCitwYWdlZEI6CisgICAgICAgIHN1
YnMgICAgcjAsIHIwLCAjMQorICAgICAgICBiZXEgICAgIHBhZ2VkX2VuZAorCisgICAgICAgIHJv
ciAgICAgcjEsIHIxLCAjMQorICAgICAgICB0c3QgICAgIHIxLCAjMQorICAgICAgICBiZXEgICAg
IHBhZ2VkX3N0YXJ0CisgICAgICAgIGIgICAgICAgcGFnZWRBCisKKyAgICAgICAgLyogQWxpZ24g
PDwgMTMgPT0gNDA5NiBieXRlIGFsaWdubWVudCAqLworICAgICAgICAuYWxpZ24gMTMKKy5nbG9i
YWwgcGFnZWRfZW5kCitwYWdlZF9lbmQ6CisgICAgICAgIG1vdiAgICAgcGMsIGxyCisKKy5nbG9i
YWwgdGVzdF9jb2RlX2VuZAordGVzdF9jb2RlX2VuZDoKZGlmZiAtLWdpdCBhL2FybS90Y2ctdGVz
dC1hc202NC5TIGIvYXJtL3RjZy10ZXN0LWFzbTY0LlMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMC4uMjc4MWVlYgotLS0gL2Rldi9udWxsCisrKyBiL2FybS90Y2ctdGVzdC1hc202
NC5TCkBAIC0wLDAgKzEsMTcwIEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlciAqLworLyoKKyAqIFRDRyBUZXN0IGFzc2VtYmxlciBmdW5jdGlvbnMgZm9yIGFy
bXY4IHRlc3RzLgorICoKKyAqIENvcHlyaWdodCAoQykgMjAxNiwgTGluYXJvIEx0ZCwgQWxleCBC
ZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPgorICoKKyAqIFRoaXMgd29yayBpcyBsaWNl
bnNlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBMR1BMLCB2ZXJzaW9uIDIuCisgKgorICog
VGhlc2UgaGVscGVyIGZ1bmN0aW9ucyBhcmUgd3JpdHRlbiBpbiBwdXJlIGFzbSB0byBjb250cm9s
IHRoZSBzaXplCisgKiBvZiB0aGUgYmFzaWMgYmxvY2tzIGFuZCBlbnN1cmUgdGhleSBmaXQgbmVh
dGx5IGludG8gcGFnZQorICogYWxpZ25lZCBjaHVua3MuIFRoZSBwYXR0ZXJuIG9mIGJyYW5jaGVz
IHRoZXkgZm9sbG93IGlzIGRldGVybWluZWQgYnkKKyAqIHRoZSAzMiBiaXQgc2VlZCB0aGV5IGFy
ZSBwYXNzZWQuIEl0IHNob3VsZCBiZSB0aGUgc2FtZSBmb3IgZWFjaCBzZXQuCisgKgorICogQ2Fs
bGluZyBjb252ZW50aW9uCisgKiAgLSB4MCwgaXRlcmF0aW9ucworICogIC0geDEsIGp1bXAgcGF0
dGVybgorICogIC0geDIteDMsIHNjcmF0Y2gKKyAqCisgKiBSZXR1cm5zIHgwCisgKi8KKworLnNl
Y3Rpb24gLnRleHQKKworLyogVGlnaHQgLSBhbGwgYmxvY2tzIHNob3VsZCBxdWlja2x5IGJlIHBh
dGNoZWQgYW5kIHNob3VsZCBydW4KKyAqIHZlcnkgZmFzdCB1bmxlc3MgaXJxcyBvciBzbWMgZ2V0
cyBpbiB0aGUgd2F5CisgKi8KKworLmdsb2JhbCB0aWdodF9zdGFydAordGlnaHRfc3RhcnQ6Cisg
ICAgICAgIHN1YnMgICAgeDAsIHgwLCAjMQorICAgICAgICBiZXEgICAgIHRpZ2h0X2VuZAorCisg
ICAgICAgIHJvciAgICAgeDEsIHgxLCAjMQorICAgICAgICB0c3QgICAgIHgxLCAjMQorICAgICAg
ICBiZXEgICAgIHRpZ2h0QQorICAgICAgICBiICAgICAgIHRpZ2h0X3N0YXJ0CisKK3RpZ2h0QToK
KyAgICAgICAgc3VicyAgICB4MCwgeDAsICMxCisgICAgICAgIGJlcSAgICAgdGlnaHRfZW5kCisK
KyAgICAgICAgcm9yICAgICB4MSwgeDEsICMxCisgICAgICAgIHRzdCAgICAgeDEsICMxCisgICAg
ICAgIGJlcSAgICAgdGlnaHRCCisgICAgICAgIGIgICAgICAgdGlnaHRfc3RhcnQKKwordGlnaHRC
OgorICAgICAgICBzdWJzICAgIHgwLCB4MCwgIzEKKyAgICAgICAgYmVxICAgICB0aWdodF9lbmQK
KworICAgICAgICByb3IgICAgIHgxLCB4MSwgIzEKKyAgICAgICAgdHN0ICAgICB4MSwgIzEKKyAg
ICAgICAgYmVxICAgICB0aWdodF9zdGFydAorICAgICAgICBiICAgICAgIHRpZ2h0QQorCisuZ2xv
YmFsIHRpZ2h0X2VuZAordGlnaHRfZW5kOgorICAgICAgICByZXQKKworLyoKKyAqIENvbXB1dGVk
IGp1bXBzIGNhbm5vdCBiZSBoYXJkd2lyZWQgaW50byB0aGUgYmFzaWMgYmxvY2tzIHNvIGVhY2gg
b25lCisgKiB3aWxsIGNhdXNlIGFuIGV4aXQgZm9yIHRoZSBtYWluIGV4ZWN1dGlvbiBsb29wIHRv
IGxvb2sgdXAgdGhlIG5leHQgYmxvY2suCisgKgorICogVGhlcmUgaXMgc29tZSBjYWNoaW5nIHdo
aWNoIHNob3VsZCBhbWVsaW9yYXRlIHRoZSBjb3N0IGEgbGl0dGxlLgorICovCisKKyAgICAgICAg
LyogQWxpZ24gPDwgMTMgPT0gNDA5NiBieXRlIGFsaWdubWVudCAqLworICAgICAgICAuYWxpZ24g
MTMKKyAgICAgICAgLmdsb2JhbCBjb21wdXRlZF9zdGFydAorY29tcHV0ZWRfc3RhcnQ6CisgICAg
ICAgIHN1YnMgICAgeDAsIHgwLCAjMQorICAgICAgICBiZXEgICAgIGNvbXB1dGVkX2VuZAorCisg
ICAgICAgIC8qIEp1bXAgdGFibGUgKi8KKyAgICAgICAgcm9yICAgICB4MSwgeDEsICMxCisgICAg
ICAgIGFuZCAgICAgeDIsIHgxLCAjMQorICAgICAgICBhZHIgICAgIHgzLCBjb21wdXRlZF9qdW1w
X3RhYmxlCisgICAgICAgIGxkciAgICAgeDIsIFt4MywgeDIsIGxzbCAjM10KKyAgICAgICAgYnIg
ICAgICB4MgorCisgICAgICAgIGIgICAgICAgY29tcHV0ZWRfZXJyCisKK2NvbXB1dGVkX2p1bXBf
dGFibGU6CisgICAgICAgIC5xdWFkICAgY29tcHV0ZWRfc3RhcnQKKyAgICAgICAgLnF1YWQgICBj
b21wdXRlZEEKKworY29tcHV0ZWRBOgorICAgICAgICBzdWJzICAgIHgwLCB4MCwgIzEKKyAgICAg
ICAgYmVxICAgICBjb21wdXRlZF9lbmQKKworICAgICAgICAvKiBKdW1wIGludG8gY29kZSAqLwor
ICAgICAgICByb3IgICAgIHgxLCB4MSwgIzEKKyAgICAgICAgYW5kICAgICB4MiwgeDEsICMxCisg
ICAgICAgIGFkciAgICAgeDMsIDFmCisgICAgICAgIGFkZAl4MywgeDMsIHgyLCBsc2wgIzIKKyAg
ICAgICAgYnIgICAgICB4MworMTogICAgICBiICAgICAgIGNvbXB1dGVkX3N0YXJ0CisgICAgICAg
IGIgICAgICAgY29tcHV0ZWRCCisKKyAgICAgICAgYiAgICAgICBjb21wdXRlZF9lcnIKKworCitj
b21wdXRlZEI6CisgICAgICAgIHN1YnMgICAgeDAsIHgwLCAjMQorICAgICAgICBiZXEgICAgIGNv
bXB1dGVkX2VuZAorICAgICAgICByb3IgICAgIHgxLCB4MSwgIzEKKworICAgICAgICAvKiBDb25k
aXRpb25hbCByZWdpc3RlciBsb2FkICovCisgICAgICAgIGFkciAgICAgeDIsIGNvbXB1dGVkQQor
ICAgICAgICBhZHIgICAgIHgzLCBjb21wdXRlZF9zdGFydAorICAgICAgICB0c3QgICAgIHgxLCAj
MQorICAgICAgICBjc2VsICAgIHgyLCB4MywgeDIsIGVxCisgICAgICAgIGJyICAgICAgeDIKKwor
ICAgICAgICBiICAgICAgIGNvbXB1dGVkX2VycgorCitjb21wdXRlZF9lcnI6CisgICAgICAgIG1v
diAgICAgeDAsICMxCisgICAgICAgIC5nbG9iYWwgY29tcHV0ZWRfZW5kCitjb21wdXRlZF9lbmQ6
CisgICAgICAgIHJldAorCisKKy8qCisgKiBQYWdlIGhvcGluZworICoKKyAqIEVhY2ggYmxvY2sg
aXMgaW4gYSBkaWZmZXJlbnQgcGFnZSwgaGVuY2UgdGhlIGJsb2NrcyBuZXZlciBnZXQgam9pbmVk
CisgKi8KKyAgICAgICAgLyogQWxpZ24gPDwgMTMgPT0gNDA5NiBieXRlIGFsaWdubWVudCAqLwor
ICAgICAgICAuYWxpZ24gMTMKKyAgICAgICAgLmdsb2JhbCBwYWdlZF9zdGFydAorcGFnZWRfc3Rh
cnQ6CisgICAgICAgIHN1YnMgICAgeDAsIHgwLCAjMQorICAgICAgICBiZXEgICAgIHBhZ2VkX2Vu
ZAorCisgICAgICAgIHJvciAgICAgeDEsIHgxLCAjMQorICAgICAgICB0c3QgICAgIHgxLCAjMQor
ICAgICAgICBiZXEgICAgIHBhZ2VkQQorICAgICAgICBiICAgICAgIHBhZ2VkX3N0YXJ0CisKKyAg
ICAgICAgLyogQWxpZ24gPDwgMTMgPT0gNDA5NiBieXRlIGFsaWdubWVudCAqLworICAgICAgICAu
YWxpZ24gMTMKK3BhZ2VkQToKKyAgICAgICAgc3VicyAgICB4MCwgeDAsICMxCisgICAgICAgIGJl
cSAgICAgcGFnZWRfZW5kCisKKyAgICAgICAgcm9yICAgICB4MSwgeDEsICMxCisgICAgICAgIHRz
dCAgICAgeDEsICMxCisgICAgICAgIGJlcSAgICAgcGFnZWRCCisgICAgICAgIGIgICAgICAgcGFn
ZWRfc3RhcnQKKworICAgICAgICAvKiBBbGlnbiA8PCAxMyA9PSA0MDk2IGJ5dGUgYWxpZ25tZW50
ICovCisgICAgICAgIC5hbGlnbiAxMworcGFnZWRCOgorICAgICAgICBzdWJzICAgIHgwLCB4MCwg
IzEKKyAgICAgICAgYmVxICAgICBwYWdlZF9lbmQKKworICAgICAgICByb3IgICAgIHgxLCB4MSwg
IzEKKyAgICAgICAgdHN0ICAgICB4MSwgIzEKKyAgICAgICAgYmVxICAgICBwYWdlZF9zdGFydAor
ICAgICAgICBiICAgICAgIHBhZ2VkQQorCisgICAgICAgIC8qIEFsaWduIDw8IDEzID09IDQwOTYg
Ynl0ZSBhbGlnbm1lbnQgKi8KKyAgICAgICAgLmFsaWduIDEzCisuZ2xvYmFsIHBhZ2VkX2VuZAor
cGFnZWRfZW5kOgorICAgICAgICByZXQKKworLmdsb2JhbCB0ZXN0X2NvZGVfZW5kCit0ZXN0X2Nv
ZGVfZW5kOgpkaWZmIC0tZ2l0IGEvYXJtL3RjZy10ZXN0LmMgYi9hcm0vdGNnLXRlc3QuYwpuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5mZGRhYjdiCi0tLSAvZGV2L251bGwKKysr
IGIvYXJtL3RjZy10ZXN0LmMKQEAgLTAsMCArMSwzMzggQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisvKgorICogQVJNIFRDRyBUZXN0cworICoKKyAqIFRo
ZXNlIHRlc3RzIGFyZSBleHBsaWNpdGx5IGFpbWVkIGF0IHN0cmV0Y2hpbmcgdGhlIFFFTVUgVENH
IGVuZ2luZS4KKyAqLworCisjaW5jbHVkZSA8bGliY2ZsYXQuaD4KKyNpbmNsdWRlIDxhc20vcHJv
Y2Vzc29yLmg+CisjaW5jbHVkZSA8YXNtL3NtcC5oPgorI2luY2x1ZGUgPGFzbS9jcHVtYXNrLmg+
CisjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4KKyNpbmNsdWRlIDxhc20vbW11Lmg+CisjaW5jbHVk
ZSA8YXNtL2dpYy5oPgorCisjaW5jbHVkZSA8cHJuZy5oPgorCisjZGVmaW5lIE1BWF9DUFVTIDgK
KworLyogVGhlc2UgZW50cnkgcG9pbnRzIGFyZSBpbiB0aGUgYXNzZW1ibHkgY29kZSAqLworZXh0
ZXJuIGludCB0aWdodF9zdGFydCh1aW50MzJfdCBjb3VudCwgdWludDMyX3QgcGF0dGVybik7Citl
eHRlcm4gaW50IGNvbXB1dGVkX3N0YXJ0KHVpbnQzMl90IGNvdW50LCB1aW50MzJfdCBwYXR0ZXJu
KTsKK2V4dGVybiBpbnQgcGFnZWRfc3RhcnQodWludDMyX3QgY291bnQsIHVpbnQzMl90IHBhdHRl
cm4pOworZXh0ZXJuIHVpbnQzMl90IHRpZ2h0X2VuZDsKK2V4dGVybiB1aW50MzJfdCBjb21wdXRl
ZF9lbmQ7CitleHRlcm4gdWludDMyX3QgcGFnZWRfZW5kOworZXh0ZXJuIHVuc2lnbmVkIGxvbmcg
dGVzdF9jb2RlX2VuZDsKKwordHlwZWRlZiBpbnQgKCp0ZXN0X2ZuKSh1aW50MzJfdCBjb3VudCwg
dWludDMyX3QgcGF0dGVybik7CisKK3R5cGVkZWYgc3RydWN0IHsKKwljb25zdCBjaGFyICp0ZXN0
X25hbWU7CisJYm9vbCAgICAgICBzaG91bGRfcGFzczsKKwl0ZXN0X2ZuICAgIHN0YXJ0X2ZuOwor
CXVpbnQzMl90ICAgKmNvZGVfZW5kOworfSB0ZXN0X2Rlc2NyX3Q7CisKKy8qIFRlc3QgYXJyYXkg
Ki8KK3N0YXRpYyB0ZXN0X2Rlc2NyX3QgdGVzdHNbXSA9IHsKKyAgICAgICAvKgorCSogVGlnaHQg
Y2hhaW4uCisJKgorCSogVGhlc2UgYXJlIGEgYnVuY2ggb2YgYmFzaWMgYmxvY2tzIHRoYXQgaGF2
ZSBmaXhlZCBicmFuY2hlcyBpbgorCSogYSBwYWdlIGFsaWduZWQgc3BhY2UuIFRoZSBicmFuY2hl
cyB0YWtlbiBhcmUgZGVjaWRlZCBieSBhCisJKiBwc3VlZG8tcmFuZG9tIGJpdG1hcCBmb3IgZWFj
aCBDUFUuCisJKgorCSogT25jZSB0aGUgYmFzaWMgYmxvY2tzIGhhdmUgYmVlbiBjaGFpbmVkIHRv
Z2V0aGVyIGJ5IHRoZSBUQ0cgdGhleQorCSogc2hvdWxkIHJ1biB1bnRpbCB0aGV5IHJlYWNoIHRo
ZWlyIGJsb2NrIGNvdW50LiBUaGlzIHdpbGwgYmUgdGhlCisJKiBtb3N0IGVmZmljaWVudCBtb2Rl
IGluIHdoaWNoIGdlbmVyYXRlZCBjb2RlIGlzIHJ1bi4gVGhlIG9ubHkgb3RoZXIKKwkqIGV4aXRz
IHdpbGwgYmUgY2F1c2VkIGJ5IGludGVycnVwdHMgb3IgVEIgaW52YWxpZGF0aW9uLgorCSovCisJ
eyAidGlnaHQiLCB0cnVlLCB0aWdodF9zdGFydCwgJnRpZ2h0X2VuZCB9LAorCS8qCisJICogQ29t
cHV0ZWQganVtcHMuCisJICoKKwkgKiBBIGJ1bmNoIG9mIGJhc2ljIGJsb2NrcyB3aGljaCBqdXN0
IGRvIGNvbXB1dGVkIGp1bXBzIHNvIHRoZSBiYXNpYworCSAqIGJsb2NrIGlzIG5ldmVyIGNoYWlu
ZWQgYnV0IHRoZXkgYXJlIGFsbCB3aXRoaW4gYSBwYWdlIChtYXliZSBub3QKKwkgKiByZXF1aXJl
ZCkuIFRoaXMgd2lsbCBleGVyY2lzZSB0aGUgY2FjaGUgbG9va3VwIGJ1dCBub3QgdGhlIG5ldwor
CSAqIGdlbmVyYXRpb24uCisJICovCisJeyAiY29tcHV0ZWQiLCB0cnVlLCBjb21wdXRlZF9zdGFy
dCwgJmNvbXB1dGVkX2VuZCB9LAorCS8qCisJICogUGFnZSBwaW5nIHBvbmcuCisJICoKKwkgKiBI
YXZlIHRoZSBibG9ja3MgYXJlIHNlcGFyYXRlZCBieSBQQUdFX1NJWkUgc28gdGhleSBjYW4gbmV2
ZXIKKwkgKiBiZSBjaGFpbmVkIHRvZ2V0aGVyLgorCSAqCisJICovCisJeyAicGFnZWQiLCB0cnVl
LCBwYWdlZF9zdGFydCwgJnBhZ2VkX2VuZH0KK307CisKK3N0YXRpYyB0ZXN0X2Rlc2NyX3QgKnRl
c3Q7CisKK3N0YXRpYyBpbnQgaXRlcmF0aW9ucyA9IDEwMDAwMDA7CitzdGF0aWMgaW50IHJvdW5k
cyA9IDEwMDA7CitzdGF0aWMgaW50IG1vZF9mcmVxID0gNTsKK3N0YXRpYyB1aW50MzJfdCBwYXR0
ZXJuW01BWF9DUFVTXTsKKworLyogY29udHJvbCBmbGFncyAqLworc3RhdGljIGludCBzbWM7Citz
dGF0aWMgaW50IGlycTsKK3N0YXRpYyBpbnQgY2hlY2tfaXJxOworCisvKiBJUlEgYWNjb3VudGlu
ZyAqLworI2RlZmluZSBNQVhfSVJRX0lEUyAxNgorc3RhdGljIGludCBpcnF2Oworc3RhdGljIHVu
c2lnbmVkIGxvbmcgaXJxX3NlbnRfdHNbTUFYX0NQVVNdW01BWF9DUFVTXVtNQVhfSVJRX0lEU107
CisKK3N0YXRpYyBpbnQgaXJxX3JlY3ZbTUFYX0NQVVNdOworc3RhdGljIGludCBpcnFfc2VudFtN
QVhfQ1BVU107CitzdGF0aWMgaW50IGlycV9vdmVybGFwW01BWF9DUFVTXTsgIC8qIGlmIHRzID4g
bm93LCBpLmUgYSByYWNlICovCitzdGF0aWMgaW50IGlycV9zbG93W01BWF9DUFVTXTsgIC8qIGlm
IGRlbGF5ID4gdGhyZXNob2xkICovCitzdGF0aWMgdW5zaWduZWQgbG9uZyBpcnFfbGF0ZW5jeVtN
QVhfQ1BVU107IC8qIGN1bXVsYXRpdmUgdGltZSAqLworCitzdGF0aWMgaW50IGVycm9yc1tNQVhf
Q1BVU107CisKK3N0YXRpYyBjcHVtYXNrX3Qgc21wX3Rlc3RfY29tcGxldGU7CisKK3N0YXRpYyBj
cHVtYXNrX3QgcmVhZHk7CisKK3N0YXRpYyB2b2lkIHdhaXRfb25fcmVhZHkodm9pZCkKK3sKKwlj
cHVtYXNrX3NldF9jcHUoc21wX3Byb2Nlc3Nvcl9pZCgpLCAmcmVhZHkpOworCXdoaWxlICghY3B1
bWFza19mdWxsKCZyZWFkeSkpCisJCWNwdV9yZWxheCgpOworfQorCisvKiBUaGlzIHRyaWdnZXJz
IFRDR3MgU01DIGRldGVjdGlvbiBieSB3cml0aW5nIHZhbHVlcyB0byB0aGUgZXhlY3V0aW5nCisg
KiBjb2RlIHBhZ2VzLiBXZSBhcmUgbm90IGFjdHVhbGx5IG1vZGlmeWluZyB0aGUgaW5zdHJ1Y3Rp
b25zIGFuZCB0aGUKKyAqIHVuZGVybHlpbmcgY29kZSB3aWxsIHJlbWFpbiB1bmNoYW5nZWQuIEhv
d2V2ZXIgdGhpcyBzaG91bGQgdHJpZ2dlcgorICogaW52YWxpZGF0aW9uIG9mIHRoZSBUcmFuc2xh
dGlvbiBCbG9ja3MKKyAqLworCitzdGF0aWMgdm9pZCB0cmlnZ2VyX3NtY19kZXRlY3Rpb24odWlu
dDMyX3QgKnN0YXJ0LCB1aW50MzJfdCAqZW5kKQoreworCXZvbGF0aWxlIHVpbnQzMl90ICpwdHIg
PSBzdGFydDsKKworCXdoaWxlIChwdHIgPCBlbmQpIHsKKwkJdWludDMyX3QgaW5zdCA9ICpwdHI7
CisJCSpwdHIrKyA9IGluc3Q7CisJfQorfQorCisvKiBIYW5kbGVyIGZvciByZWNlaXZpbmcgSVJR
cyAqLworCitzdGF0aWMgdm9pZCBpcnFfaGFuZGxlcihzdHJ1Y3QgcHRfcmVncyAqcmVncyBfX3Vu
dXNlZCkKK3sKKwl1bnNpZ25lZCBsb25nIHRoZW4sIG5vdyA9IGdldF9jbnR2Y3QoKTsKKwlpbnQg
Y3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOworCXUzMiBpcnFzdGF0ID0gZ2ljX3JlYWRfaWFyKCk7
CisJdTMyIGlycW5yID0gZ2ljX2lhcl9pcnFucihpcnFzdGF0KTsKKworCWlmIChpcnFuciAhPSBH
SUNDX0lOVF9TUFVSSU9VUykgeworCQl1bnNpZ25lZCBpbnQgc3JjX2NwdSA9IChpcnFzdGF0ID4+
IDEwKSAmIDB4NzsKKworCQlnaWNfd3JpdGVfZW9pcihpcnFzdGF0KTsKKwkJaXJxX3JlY3ZbY3B1
XSsrOworCisJCXRoZW4gPSBpcnFfc2VudF90c1tzcmNfY3B1XVtjcHVdW2lycW5yXTsKKworCQlp
ZiAodGhlbiA+IG5vdykgeworCQkJaXJxX292ZXJsYXBbY3B1XSsrOworCQl9IGVsc2UgeworCQkJ
dW5zaWduZWQgbG9uZyBsYXRlbmN5ID0gKG5vdyAtIHRoZW4pOworCisJCQlpZiAobGF0ZW5jeSA+
IDMwMDAwKQorCQkJCWlycV9zbG93W2NwdV0rKzsKKwkJCWVsc2UKKwkJCQlpcnFfbGF0ZW5jeVtj
cHVdICs9IGxhdGVuY3k7CisJCX0KKwl9Cit9CisKKy8qIFRoaXMgdHJpZ2dlcnMgY3Jvc3MtQ1BV
IElSUXMuIEVhY2ggSVJRIHNob3VsZCBjYXVzZSB0aGUgYmFzaWMgYmxvY2sKKyAqIGV4ZWN1dGlv
biB0byBmaW5pc2ggdGhlIG1haW4gcnVuLWxvb3AgZ2V0IGVudGVyZWQgYWdhaW4uCisgKi8KK3N0
YXRpYyBpbnQgc2VuZF9jcm9zc19jcHVfaXJxcyhpbnQgdGhpc19jcHUsIGludCBpcnEpCit7CisJ
aW50IGNwdSwgc2VudCA9IDA7CisJY3B1bWFza190IG1hc2s7CisKKwljcHVtYXNrX2NvcHkoJm1h
c2ssICZjcHVfcHJlc2VudF9tYXNrKTsKKworCWZvcl9lYWNoX3ByZXNlbnRfY3B1KGNwdSkgewor
CQlpZiAoY3B1ICE9IHRoaXNfY3B1KSB7CisJCQlpcnFfc2VudF90c1t0aGlzX2NwdV1bY3B1XVtp
cnFdID0gZ2V0X2NudHZjdCgpOworCQkJY3B1bWFza19jbGVhcl9jcHUoY3B1LCAmbWFzayk7CisJ
CQlzZW50Kys7CisJCX0KKwl9CisKKwlnaWNfaXBpX3NlbmRfbWFzayhpcnEsICZtYXNrKTsKKwor
CXJldHVybiBzZW50OworfQorCitzdGF0aWMgdm9pZCBkb190ZXN0KHZvaWQpCit7CisJaW50IGNw
dSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKKwlpbnQgaSwgaXJxX2lkID0gMDsKKworCXByaW50Zigi
Q1BVJWQ6IG9ubGluZSBhbmQgc2V0dGluZyB1cCB3aXRoIHBhdHRlcm4gMHglIlBSSXgzMiJcbiIs
CisJICAgICAgIGNwdSwgcGF0dGVybltjcHVdKTsKKworCWlmIChpcnEpIHsKKwkJZ2ljX2VuYWJs
ZV9kZWZhdWx0cygpOworI2lmZGVmIF9fYXJtX18KKwkJaW5zdGFsbF9leGNlcHRpb25faGFuZGxl
cihFWENQVE5fSVJRLCBpcnFfaGFuZGxlcik7CisjZWxzZQorCQlpbnN0YWxsX2lycV9oYW5kbGVy
KEVMMUhfSVJRLCBpcnFfaGFuZGxlcik7CisjZW5kaWYKKwkJbG9jYWxfaXJxX2VuYWJsZSgpOwor
CisJCXdhaXRfb25fcmVhZHkoKTsKKwl9CisKKwlmb3IgKGkgPSAwOyBpIDwgcm91bmRzOyBpKysp
IHsKKwkJLyogRW50ZXIgdGhlIGJsb2NrcyAqLworCQllcnJvcnNbY3B1XSArPSB0ZXN0LT5zdGFy
dF9mbihpdGVyYXRpb25zLCBwYXR0ZXJuW2NwdV0pOworCisJCWlmICgoaSArIGNwdSkgJSBtb2Rf
ZnJlcSA9PSAwKSB7CisJCQlpZiAoc21jKQorCQkJCXRyaWdnZXJfc21jX2RldGVjdGlvbigodWlu
dDMyX3QgKikgdGVzdC0+c3RhcnRfZm4sCisJCQkJCQkgICAgICB0ZXN0LT5jb2RlX2VuZCk7CisK
KwkJCWlmIChpcnEpIHsKKwkJCQlpcnFfc2VudFtjcHVdICs9IHNlbmRfY3Jvc3NfY3B1X2lycXMo
Y3B1LCBpcnFfaWQpOworCQkJCWlycV9pZCsrOworCQkJCWlycV9pZCA9IGlycV9pZCAlIDE1Owor
CQkJfQorCQl9CisJfQorCisJLyogZW5zdXJlIGV2ZXJ5dGhpbmcgY29tcGxldGUgYmVmb3JlIHdl
IGZpbmlzaCAqLworCXNtcF93bWIoKTsKKworCWNwdW1hc2tfc2V0X2NwdShjcHUsICZzbXBfdGVz
dF9jb21wbGV0ZSk7CisJaWYgKGNwdSAhPSAwKQorCQloYWx0KCk7Cit9CisKK3N0YXRpYyB2b2lk
IHJlcG9ydF9pcnFfc3RhdHMoaW50IGNwdSkKK3sKKwlpbnQgcmVjdiA9IGlycV9yZWN2W2NwdV07
CisJaW50IHJhY2UgPSBpcnFfb3ZlcmxhcFtjcHVdOworCWludCBzbG93ID0gaXJxX3Nsb3dbY3B1
XTsKKworCXVuc2lnbmVkIGxvbmcgYXZnX2xhdGVuY3kgPSBpcnFfbGF0ZW5jeVtjcHVdIC8gKHJl
Y3YgLSAocmFjZSArIHNsb3cpKTsKKworCXByaW50ZigiQ1BVJWQ6ICVkIGlycXMgKCVkIHJhY2Vz
LCAlZCBzbG93LCAgJWxkIHRpY2tzIGF2ZyBsYXRlbmN5KVxuIiwKKwkJY3B1LCByZWN2LCByYWNl
LCBzbG93LCBhdmdfbGF0ZW5jeSk7Cit9CisKKworc3RhdGljIHZvaWQgc2V0dXBfYW5kX3J1bl90
Y2dfdGVzdCh2b2lkKQoreworCXN0YXRpYyBjb25zdCB1bnNpZ25lZCBjaGFyIHNlZWRbXSA9ICJ0
Y2ctdGVzdCI7CisJc3RydWN0IGlzYWFjX2N0eCBwcm5nX2NvbnRleHQ7CisJaW50IGNwdTsKKwlp
bnQgdG90YWxfZXJyID0gMCwgdG90YWxfc2VudCA9IDAsIHRvdGFsX3JlY3YgPSAwOworCisJaXNh
YWNfaW5pdCgmcHJuZ19jb250ZXh0LCAmc2VlZFswXSwgc2l6ZW9mKHNlZWQpKTsKKworCS8qIGJv
b3Qgb3RoZXIgQ1BVcyAqLworCWZvcl9lYWNoX3ByZXNlbnRfY3B1KGNwdSkgeworCQlwYXR0ZXJu
W2NwdV0gPSBpc2FhY19uZXh0X3VpbnQzMigmcHJuZ19jb250ZXh0KTsKKworCQlpZiAoY3B1ID09
IDApCisJCQljb250aW51ZTsKKworCQlzbXBfYm9vdF9zZWNvbmRhcnkoY3B1LCBkb190ZXN0KTsK
Kwl9CisKKwlkb190ZXN0KCk7CisKKwl3aGlsZSAoIWNwdW1hc2tfZnVsbCgmc21wX3Rlc3RfY29t
cGxldGUpKQorCQljcHVfcmVsYXgoKTsKKworCS8qIEVuc3VyZSBldmVyeXRoaW5nIGNvbXBsZXRl
cyBiZWZvcmUgd2UgY2hlY2sgdGhlIGRhdGEgKi8KKwlzbXBfbWIoKTsKKworCS8qIE5vdyB0b3Rh
bCB1cCBlcnJvcnMgYW5kIGlycXMgKi8KKwlmb3JfZWFjaF9wcmVzZW50X2NwdShjcHUpIHsKKwkJ
dG90YWxfZXJyICs9IGVycm9yc1tjcHVdOworCQl0b3RhbF9zZW50ICs9IGlycV9zZW50W2NwdV07
CisJCXRvdGFsX3JlY3YgKz0gaXJxX3JlY3ZbY3B1XTsKKworCQlpZiAoY2hlY2tfaXJxKQorCQkJ
cmVwb3J0X2lycV9zdGF0cyhjcHUpOworCX0KKworCWlmIChjaGVja19pcnEpCisJCXJlcG9ydCh0
b3RhbF9zZW50ID09IHRvdGFsX3JlY3YgJiYgdG90YWxfZXJyID09IDAsCisJCSAgICAgICAiJWQg
SVJRcyBzZW50LCAlZCByZWNlaXZlZCwgJWQgZXJyb3JzXG4iLAorCQkgICAgICAgdG90YWxfc2Vu
dCwgdG90YWxfcmVjdiwgdG90YWxfZXJyID09IDApOworCWVsc2UKKwkJcmVwb3J0KHRvdGFsX2Vy
ciA9PSAwLCAiJWQgZXJyb3JzLCBJUlFzIG5vdCBjaGVja2VkIiwgdG90YWxfZXJyKTsKK30KKwor
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQoreworCWludCBpOworCXVuc2lnbmVkIGlu
dCBqOworCisJZm9yIChpID0gMDsgaSA8IGFyZ2M7IGkrKykgeworCQljaGFyICphcmcgPSBhcmd2
W2ldOworCisJCWZvciAoaiA9IDA7IGogPCBBUlJBWV9TSVpFKHRlc3RzKTsgaisrKSB7CisJCQlp
ZiAoc3RyY21wKGFyZywgdGVzdHNbal0udGVzdF9uYW1lKSA9PSAwKQorCQkJCXRlc3QgPSAmdGVz
dHNbal07CisJCX0KKworCQkvKiBUZXN0IG1vZGlmaWVycyAqLworCQlpZiAoc3Ryc3RyKGFyZywg
Im1vZD0iKSAhPSBOVUxMKSB7CisJCQljaGFyICpwID0gc3Ryc3RyKGFyZywgIj0iKTsKKworCQkJ
bW9kX2ZyZXEgPSBhdG9sKHArMSk7CisJCX0KKworCQlpZiAoc3Ryc3RyKGFyZywgInJvdW5kcz0i
KSAhPSBOVUxMKSB7CisJCQljaGFyICpwID0gc3Ryc3RyKGFyZywgIj0iKTsKKworCQkJcm91bmRz
ID0gYXRvbChwKzEpOworCQl9CisKKwkJaWYgKHN0cmNtcChhcmcsICJzbWMiKSA9PSAwKSB7CisJ
CQl1bnNpZ25lZCBsb25nIHRlc3Rfc3RhcnQgPSAodW5zaWduZWQgbG9uZykgJnRpZ2h0X3N0YXJ0
OworCQkJdW5zaWduZWQgbG9uZyB0ZXN0X2VuZCA9ICh1bnNpZ25lZCBsb25nKSAmdGVzdF9jb2Rl
X2VuZDsKKworCQkJc21jID0gMTsKKwkJCW1tdV9zZXRfcmFuZ2VfcHRlcyhtbXVfaWRtYXAsIHRl
c3Rfc3RhcnQsIHRlc3Rfc3RhcnQsIHRlc3RfZW5kLAorCQkJCQlfX3BncHJvdChQVEVfV0JXQSkp
OworCisJCQlyZXBvcnRfcHJlZml4X3B1c2goInNtYyIpOworCQl9CisKKwkJaWYgKHN0cmNtcChh
cmcsICJpcnEiKSA9PSAwKSB7CisJCQlpcnEgPSAxOworCQkJaWYgKCFnaWNfaW5pdCgpKQorCQkJ
CXJlcG9ydF9hYm9ydCgiTm8gc3VwcG9ydGVkIGdpYyBwcmVzZW50ISIpOworCQkJaXJxdiA9IGdp
Y192ZXJzaW9uKCk7CisJCQlyZXBvcnRfcHJlZml4X3B1c2goImlycSIpOworCQl9CisKKwkJaWYg
KHN0cmNtcChhcmcsICJjaGVja19pcnEiKSA9PSAwKQorCQkJY2hlY2tfaXJxID0gMTsKKwl9CisK
KwlpZiAodGVzdCkgeworCQkvKiBlbnN1cmUgYXJncyB2aXNpYmxlIHRvIGFsbCBjb3JlcyAqLwor
CQlzbXBfbWIoKTsKKwkJc2V0dXBfYW5kX3J1bl90Y2dfdGVzdCgpOworCX0gZWxzZSB7CisJCXJl
cG9ydChmYWxzZSwgIlVua25vd24gdGVzdCIpOworCX0KKworCXJldHVybiByZXBvcnRfc3VtbWFy
eSgpOworfQpkaWZmIC0tZ2l0IGEvYXJtL210dGNndGVzdHMuY2ZnIGIvYXJtL210dGNndGVzdHMu
Y2ZnCmluZGV4IDJiNDY3NTYuLjA0NmE1OWMgMTAwNjQ0Ci0tLSBhL2FybS9tdHRjZ3Rlc3RzLmNm
ZworKysgYi9hcm0vbXR0Y2d0ZXN0cy5jZmcKQEAgLTkwLDMgKzkwLDg3IEBAIHNtcCA9IDIKIGV4
dHJhX3BhcmFtcyA9IC1hcHBlbmQgJ3NhbF9iYXJyaWVyJwogZ3JvdXBzID0gYmFycmllcgogCisj
IFRDRyBUZXN0cworW3RjZzo6dGlnaHRdCitmaWxlID0gdGNnLXRlc3QuZmxhdAorc21wID0gJCgo
JE1BWF9TTVA+ND80OiRNQVhfU01QKSkKK2V4dHJhX3BhcmFtcyA9IC1hcHBlbmQgJ3RpZ2h0Jwor
Z3JvdXBzID0gdGNnCithY2NlbCA9IHRjZworCitbdGNnOjp0aWdodC1zbWNdCitmaWxlID0gdGNn
LXRlc3QuZmxhdAorc21wID0gJCgoJE1BWF9TTVA+ND80OiRNQVhfU01QKSkKK2V4dHJhX3BhcmFt
cyA9IC1hcHBlbmQgJ3RpZ2h0IHNtYycgLWFjY2VsIHRjZyx0Yi1zaXplPTEKK2dyb3VwcyA9IHRj
ZworYWNjZWwgPSB0Y2cKKworW3RjZzo6dGlnaHQtaXJxXQorZmlsZSA9IHRjZy10ZXN0LmZsYXQK
K3NtcCA9ICQoKCRNQVhfU01QPjQ/NDokTUFYX1NNUCkpCitleHRyYV9wYXJhbXMgPSAtYXBwZW5k
ICd0aWdodCBpcnEnCitncm91cHMgPSB0Y2cKK2FjY2VsID0gdGNnCisKK1t0Y2c6OnRpZ2h0LXNt
Yy1pcnFdCitmaWxlID0gdGNnLXRlc3QuZmxhdAorc21wID0gJCgoJE1BWF9TTVA+ND80OiRNQVhf
U01QKSkKK2V4dHJhX3BhcmFtcyA9IC1hcHBlbmQgJ3RpZ2h0IHNtYyBpcnEnCitncm91cHMgPSB0
Y2cKK2FjY2VsID0gdGNnCisKK1t0Y2c6OmNvbXB1dGVkXQorZmlsZSA9IHRjZy10ZXN0LmZsYXQK
K3NtcCA9ICQoKCRNQVhfU01QPjQ/NDokTUFYX1NNUCkpCitleHRyYV9wYXJhbXMgPSAtYXBwZW5k
ICdjb21wdXRlZCcKK2dyb3VwcyA9IHRjZworYWNjZWwgPSB0Y2cKKworW3RjZzo6Y29tcHV0ZWQt
c21jXQorZmlsZSA9IHRjZy10ZXN0LmZsYXQKK3NtcCA9ICQoKCRNQVhfU01QPjQ/NDokTUFYX1NN
UCkpCitleHRyYV9wYXJhbXMgPSAtYXBwZW5kICdjb21wdXRlZCBzbWMnCitncm91cHMgPSB0Y2cK
K2FjY2VsID0gdGNnCisKK1t0Y2c6OmNvbXB1dGVkLWlycV0KK2ZpbGUgPSB0Y2ctdGVzdC5mbGF0
CitzbXAgPSAkKCgkTUFYX1NNUD40PzQ6JE1BWF9TTVApKQorZXh0cmFfcGFyYW1zID0gLWFwcGVu
ZCAnY29tcHV0ZWQgaXJxJworZ3JvdXBzID0gdGNnCithY2NlbCA9IHRjZworCitbdGNnOjpjb21w
dXRlZC1zbWMtaXJxXQorZmlsZSA9IHRjZy10ZXN0LmZsYXQKK3NtcCA9ICQoKCRNQVhfU01QPjQ/
NDokTUFYX1NNUCkpCitleHRyYV9wYXJhbXMgPSAtYXBwZW5kICdjb21wdXRlZCBzbWMgaXJxJwor
Z3JvdXBzID0gdGNnCithY2NlbCA9IHRjZworCitbdGNnOjpwYWdlZF0KK2ZpbGUgPSB0Y2ctdGVz
dC5mbGF0CitzbXAgPSAkKCgkTUFYX1NNUD40PzQ6JE1BWF9TTVApKQorZXh0cmFfcGFyYW1zID0g
LWFwcGVuZCAncGFnZWQnCitncm91cHMgPSB0Y2cKK2FjY2VsID0gdGNnCisKK1t0Y2c6OnBhZ2Vk
LXNtY10KK2ZpbGUgPSB0Y2ctdGVzdC5mbGF0CitzbXAgPSAkKCgkTUFYX1NNUD40PzQ6JE1BWF9T
TVApKQorZXh0cmFfcGFyYW1zID0gLWFwcGVuZCAncGFnZWQgc21jJworZ3JvdXBzID0gdGNnCith
Y2NlbCA9IHRjZworCitbdGNnOjpwYWdlZC1pcnFdCitmaWxlID0gdGNnLXRlc3QuZmxhdAorc21w
ID0gJCgoJE1BWF9TTVA+ND80OiRNQVhfU01QKSkKK2V4dHJhX3BhcmFtcyA9IC1hcHBlbmQgJ3Bh
Z2VkIGlycScKK2dyb3VwcyA9IHRjZworYWNjZWwgPSB0Y2cKKworW3RjZzo6cGFnZWQtc21jLWly
cV0KK2ZpbGUgPSB0Y2ctdGVzdC5mbGF0CitzbXAgPSAkKCgkTUFYX1NNUD40PzQ6JE1BWF9TTVAp
KQorZXh0cmFfcGFyYW1zID0gLWFwcGVuZCAncGFnZWQgc21jIGlycScKK2dyb3VwcyA9IHRjZwor
YWNjZWwgPSB0Y2cKLS0gCjIuMzAuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1AbGlzdHMuY3MuY29sdW1i
aWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGluZm8va3Zt
YXJtCg==
