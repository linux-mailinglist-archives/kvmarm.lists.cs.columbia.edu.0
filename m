Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D011E1AD8A3
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 10:33:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 83DC44B276;
	Fri, 17 Apr 2020 04:33:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eKjqefVg5y+9; Fri, 17 Apr 2020 04:33:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D38434B24B;
	Fri, 17 Apr 2020 04:33:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CBDF14B0D2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 04:33:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QFrFbBGBibR1 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 04:33:38 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BFC054B0CA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 04:33:38 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ECB9921D95;
 Fri, 17 Apr 2020 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587112418;
 bh=exX30MBHh/JKazRWYTFyi87muy0zveZWPuO12yNLcOs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bsUphSa5EhVomRNPSzWZgVy1RjGUSl45SFjXYEHhDFIWXqPTt6YlJkc4p/mWHOEkK
 GSzixvy9j3t1gEJqmjmB3W1l2gNB3aSZFKL9luPn0+2/6YkXdqPDnf7zAbCbupiutK
 Y8D2fubSodxuCXjfgocWYeuF8r4Q61txv/traUWE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jPMRM-00473f-47; Fri, 17 Apr 2020 09:33:36 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v2 1/6] KVM: arm: vgic: Fix limit condition when writing to
 GICD_I[CS]ACTIVER
Date: Fri, 17 Apr 2020 09:33:14 +0100
Message-Id: <20200417083319.3066217-2-maz@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200417083319.3066217-1-maz@kernel.org>
References: <20200417083319.3066217-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, yuzenghui@huawei.com,
 eric.auger@redhat.com, Andre.Przywara@arm.com, julien@xen.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 stable@vger.kernel.org, andre.przywara@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Julien Grall <julien@xen.org>,
 =?UTF-8?q?Andr=C3=A9=20Przywara?= <andre.przywara@arm.com>,
 stable@vger.kernel.org
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

V2hlbiBkZWNpZGluZyB3aGV0aGVyIGEgZ3Vlc3QgaGFzIHRvIGJlIHN0b3BwZWQgd2UgY2hlY2sg
d2hldGhlciB0aGlzCmlzIGEgcHJpdmF0ZSBpbnRlcnJ1cHQgb3Igbm90LiBVbmZvcnR1bmF0ZWx5
LCB0aGVyZSdzIGFuIG9mZi1ieS1vbmUgYnVnCmhlcmUsIGFuZCB3ZSBmYWlsIHRvIHJlY29nbml6
ZSBhIHdob2xlIHJhbmdlIG9mIGludGVycnVwdHMgYXMgYmVpbmcKZ2xvYmFsIChHSUN2MiBTUElz
IDMyLTYzKS4KCkZpeCB0aGUgY29uZGl0aW9uIGZyb20gPiB0byBiZSA+PS4KCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnCkZpeGVzOiBhYmQ3MjI5NjI2YjkzICgiS1ZNOiBhcm0vYXJtNjQ6IFNp
bXBsaWZ5IGFjdGl2ZV9jaGFuZ2VfcHJlcGFyZSBhbmQgcGx1ZyByYWNlIikKUmVwb3J0ZWQtYnk6
IEFuZHLDqSBQcnp5d2FyYSA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbT4KU2lnbmVkLW9mZi1ieTog
TWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4KLS0tCiB2aXJ0L2t2bS9hcm0vdmdpYy92Z2lj
LW1taW8uYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8uYyBiL3Zp
cnQva3ZtL2FybS92Z2ljL3ZnaWMtbW1pby5jCmluZGV4IDIxOTkzMDI1OTdmYS4uZDA4NWUwNDc5
NTNmIDEwMDY0NAotLS0gYS92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8uYworKysgYi92aXJ0
L2t2bS9hcm0vdmdpYy92Z2ljLW1taW8uYwpAQCAtNDQ0LDcgKzQ0NCw3IEBAIHN0YXRpYyB2b2lk
IHZnaWNfbW1pb19jaGFuZ2VfYWN0aXZlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IHZn
aWNfaXJxICppcnEsCiBzdGF0aWMgdm9pZCB2Z2ljX2NoYW5nZV9hY3RpdmVfcHJlcGFyZShzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUsIHUzMiBpbnRpZCkKIHsKIAlpZiAodmNwdS0+a3ZtLT5hcmNoLnZn
aWMudmdpY19tb2RlbCA9PSBLVk1fREVWX1RZUEVfQVJNX1ZHSUNfVjMgfHwKLQkgICAgaW50aWQg
PiBWR0lDX05SX1BSSVZBVEVfSVJRUykKKwkgICAgaW50aWQgPj0gVkdJQ19OUl9QUklWQVRFX0lS
UVMpCiAJCWt2bV9hcm1faGFsdF9ndWVzdCh2Y3B1LT5rdm0pOwogfQogCkBAIC00NTIsNyArNDUy
LDcgQEAgc3RhdGljIHZvaWQgdmdpY19jaGFuZ2VfYWN0aXZlX3ByZXBhcmUoc3RydWN0IGt2bV92
Y3B1ICp2Y3B1LCB1MzIgaW50aWQpCiBzdGF0aWMgdm9pZCB2Z2ljX2NoYW5nZV9hY3RpdmVfZmlu
aXNoKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIGludGlkKQogewogCWlmICh2Y3B1LT5rdm0t
PmFyY2gudmdpYy52Z2ljX21vZGVsID09IEtWTV9ERVZfVFlQRV9BUk1fVkdJQ19WMyB8fAotCSAg
ICBpbnRpZCA+IFZHSUNfTlJfUFJJVkFURV9JUlFTKQorCSAgICBpbnRpZCA+PSBWR0lDX05SX1BS
SVZBVEVfSVJRUykKIAkJa3ZtX2FybV9yZXN1bWVfZ3Vlc3QodmNwdS0+a3ZtKTsKIH0KIAotLSAK
Mi4yNi4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
dm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9s
aXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
