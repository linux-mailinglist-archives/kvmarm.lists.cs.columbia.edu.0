Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B863E490
	for <lists+kvmarm@lfdr.de>; Thu,  1 Dec 2022 00:10:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D8394B75E;
	Wed, 30 Nov 2022 18:10:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qc5WSWtRSpky; Wed, 30 Nov 2022 18:10:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4FEE64B69D;
	Wed, 30 Nov 2022 18:10:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F52040B80
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 18:10:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j-vSmjt8jDPP for <kvmarm@lists.cs.columbia.edu>;
 Wed, 30 Nov 2022 18:10:36 -0500 (EST)
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com
 [209.85.167.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D8DA34B3D1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 18:10:33 -0500 (EST)
Received: by mail-oi1-f201.google.com with SMTP id
 be1-20020a056808218100b0035b89bf17f6so105302oib.17
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 15:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKa4qX4aDdx6gvF0cYN6nETCrhJ4tNYpG1mvb7syK3o=;
 b=hHwMew+JSB9FkzxQMaX/4lXjqBXrsR2HJcdv2uakADxR3kWcZRlQ7C2hYI2R6wh2j+
 soQ37LpW03hcFXp8lJe1iL1E9NkgwaBOnfMN9lm4y4oXg28LND1TqJT1wRbBYqaPal/k
 tCOOIhtq66PSMoAtSgQhsAQ3pRw7PI30nJWGUPRypWo66CD+Gfn2yExb5G/kSSTH+qsi
 vDk8o1GMNBG21DRimYUtdxku+SkaYSkrVg0OW+HosZG84kC5BNrvHX1FxdetpLCfaQGl
 ngY1QSkOkzNCayJ5MpPvpJWGgQ3ZJsUwWjrB9/naUfSCBSqc4tz9oYHVPQdICLf6YKOj
 UOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aKa4qX4aDdx6gvF0cYN6nETCrhJ4tNYpG1mvb7syK3o=;
 b=N4/iYxqf1luy7OEcqSI8CKtRJNnZQNpDYyGvYL+NNZZNqySflaIav58yc0rjAXNGmH
 it+J4H1Mq1Ws1nPIFYmgUVB97viWD743O86+mMqmeS0ws26Y10jJk0FRSgUbZYZfsB7e
 2hM3+NcBGehssUBuN679lWqa0k4Cyz1eZ1vGIAa01dichhegLyHqa+M476aFMrD6ga+Y
 ktsDHKUMxeAC2hTUCF38vpQ+t+rABw0Gw9pqDyeu0pI/2V/D67chVJ9SkBj3hztwYdcP
 /wCp6ZuftISBe90VZgWe5SiagC96b2Byu7Bh4WbHS3t3dOkvteLgJi9hoynKg+gebh78
 /86Q==
X-Gm-Message-State: ANoB5pkmtVktrzHSVTHg4rX5Y5OGT/OjFVzxyWK4L5kjXRbByDhuLcbM
 P3MkSbUl/98ynrjgV1KS0vC+Bk2K250=
X-Google-Smtp-Source: AA0mqf51u5a2rRyiNdjg5YBoKgU3OlNqfaadebl2G6/Q2GTnKp0Tsp1t65U5NTGk3wy62Y7NHB25PAFR6bU=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6870:a78a:b0:13b:c612:b5ae with SMTP id
 x10-20020a056870a78a00b0013bc612b5aemr26861133oao.203.1669849833136; Wed, 30
 Nov 2022 15:10:33 -0800 (PST)
Date: Wed, 30 Nov 2022 23:09:16 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-33-seanjc@google.com>
Subject: [PATCH v2 32/50] KVM: Drop kvm_arch_check_processor_compat() hook
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
 Kai Huang <kai.huang@intel.com>, linux-riscv@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Chao Gao <chao.gao@intel.com>,
 Yuan Yao <yuan.yao@intel.com>, kvmarm@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
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

RHJvcCBrdm1fYXJjaF9jaGVja19wcm9jZXNzb3JfY29tcGF0KCkgYW5kIGl0cyBzdXBwb3J0IGNv
ZGUgbm93IHRoYXQgYWxsCmFyY2hpdGVjdHVyZSBpbXBsZW1lbnRhdGlvbnMgYXJlIG5vcHMuCgpT
aWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4KUmV2
aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2
aWV3ZWQtYnk6IEVyaWMgRmFybWFuIDxmYXJtYW5AbGludXguaWJtLmNvbT4JIyBzMzkwCkFja2Vk
LWJ5OiBBbnVwIFBhdGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPgotLS0KIGFyY2gvYXJtNjQva3Zt
L2FybS5jICAgICAgIHwgIDcgKy0tLS0tLQogYXJjaC9taXBzL2t2bS9taXBzLmMgICAgICAgfCAg
NyArLS0tLS0tCiBhcmNoL3Bvd2VycGMva3ZtL2Jvb2szcy5jICB8ICAyICstCiBhcmNoL3Bvd2Vy
cGMva3ZtL2U1MDAuYyAgICB8ICAyICstCiBhcmNoL3Bvd2VycGMva3ZtL2U1MDBtYy5jICB8ICAy
ICstCiBhcmNoL3Bvd2VycGMva3ZtL3Bvd2VycGMuYyB8ICA1IC0tLS0tCiBhcmNoL3Jpc2N2L2t2
bS9tYWluLmMgICAgICB8ICA3ICstLS0tLS0KIGFyY2gvczM5MC9rdm0va3ZtLXMzOTAuYyAgIHwg
IDcgKy0tLS0tLQogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgfCAgNCArKy0tCiBhcmNoL3g4
Ni9rdm0vdm14L3ZteC5jICAgICB8ICA0ICsrLS0KIGFyY2gveDg2L2t2bS94ODYuYyAgICAgICAg
IHwgIDUgLS0tLS0KIGluY2x1ZGUvbGludXgva3ZtX2hvc3QuaCAgIHwgIDQgKy0tLQogdmlydC9r
dm0va3ZtX21haW4uYyAgICAgICAgfCAyNCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEzIGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDY3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQva3ZtL2FybS5jIGIvYXJjaC9hcm02NC9rdm0vYXJtLmMKaW5kZXggOTM2
ZWY3ZDFlYTk0Li5lOTE1YjFkOWYyY2QgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQva3ZtL2FybS5j
CisrKyBiL2FyY2gvYXJtNjQva3ZtL2FybS5jCkBAIC02MywxMSArNjMsNiBAQCBpbnQga3ZtX2Fy
Y2hfdmNwdV9zaG91bGRfa2ljayhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCiAJcmV0dXJuIGt2bV92
Y3B1X2V4aXRpbmdfZ3Vlc3RfbW9kZSh2Y3B1KSA9PSBJTl9HVUVTVF9NT0RFOwogfQogCi1pbnQg
a3ZtX2FyY2hfY2hlY2tfcHJvY2Vzc29yX2NvbXBhdCh2b2lkICpvcGFxdWUpCi17Ci0JcmV0dXJu
IDA7Ci19Ci0KIGludCBrdm1fdm1faW9jdGxfZW5hYmxlX2NhcChzdHJ1Y3Qga3ZtICprdm0sCiAJ
CQkgICAgc3RydWN0IGt2bV9lbmFibGVfY2FwICpjYXApCiB7CkBAIC0yMjczLDcgKzIyNjgsNyBA
QCBzdGF0aWMgX19pbml0IGludCBrdm1fYXJtX2luaXQodm9pZCkKIAkgKiBGSVhNRTogRG8gc29t
ZXRoaW5nIHJlYXNvbmFibGUgaWYga3ZtX2luaXQoKSBmYWlscyBhZnRlciBwS1ZNCiAJICogaHlw
ZXJ2aXNvciBwcm90ZWN0aW9uIGlzIGZpbmFsaXplZC4KIAkgKi8KLQllcnIgPSBrdm1faW5pdChO
VUxMLCBzaXplb2Yoc3RydWN0IGt2bV92Y3B1KSwgMCwgVEhJU19NT0RVTEUpOworCWVyciA9IGt2
bV9pbml0KHNpemVvZihzdHJ1Y3Qga3ZtX3ZjcHUpLCAwLCBUSElTX01PRFVMRSk7CiAJaWYgKGVy
cikKIAkJZ290byBvdXRfc3ViczsKIApkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2t2bS9taXBzLmMg
Yi9hcmNoL21pcHMva3ZtL21pcHMuYwppbmRleCAzY2FkZTY0ODgyN2EuLjM2Yzg5OTFiNWQzOSAx
MDA2NDQKLS0tIGEvYXJjaC9taXBzL2t2bS9taXBzLmMKKysrIGIvYXJjaC9taXBzL2t2bS9taXBz
LmMKQEAgLTEzNSwxMSArMTM1LDYgQEAgdm9pZCBrdm1fYXJjaF9oYXJkd2FyZV9kaXNhYmxlKHZv
aWQpCiAJa3ZtX21pcHNfY2FsbGJhY2tzLT5oYXJkd2FyZV9kaXNhYmxlKCk7CiB9CiAKLWludCBr
dm1fYXJjaF9jaGVja19wcm9jZXNzb3JfY29tcGF0KHZvaWQgKm9wYXF1ZSkKLXsKLQlyZXR1cm4g
MDsKLX0KLQogZXh0ZXJuIHZvaWQga3ZtX2luaXRfbG9vbmdzb25faXBpKHN0cnVjdCBrdm0gKmt2
bSk7CiAKIGludCBrdm1fYXJjaF9pbml0X3ZtKHN0cnVjdCBrdm0gKmt2bSwgdW5zaWduZWQgbG9u
ZyB0eXBlKQpAQCAtMTYzNiw3ICsxNjMxLDcgQEAgc3RhdGljIGludCBfX2luaXQga3ZtX21pcHNf
aW5pdCh2b2lkKQogCiAJcmVnaXN0ZXJfZGllX25vdGlmaWVyKCZrdm1fbWlwc19jc3JfZGllX25v
dGlmaWVyKTsKIAotCXJldCA9IGt2bV9pbml0KE5VTEwsIHNpemVvZihzdHJ1Y3Qga3ZtX3ZjcHUp
LCAwLCBUSElTX01PRFVMRSk7CisJcmV0ID0ga3ZtX2luaXQoc2l6ZW9mKHN0cnVjdCBrdm1fdmNw
dSksIDAsIFRISVNfTU9EVUxFKTsKIAlpZiAocmV0KSB7CiAJCXVucmVnaXN0ZXJfZGllX25vdGlm
aWVyKCZrdm1fbWlwc19jc3JfZGllX25vdGlmaWVyKTsKIAkJcmV0dXJuIHJldDsKZGlmZiAtLWdp
dCBhL2FyY2gvcG93ZXJwYy9rdm0vYm9vazNzLmMgYi9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szcy5j
CmluZGV4IDg3MjgzYTBlMzNkOC4uNTdmNGU3ODk2ZDY3IDEwMDY0NAotLS0gYS9hcmNoL3Bvd2Vy
cGMva3ZtL2Jvb2szcy5jCisrKyBiL2FyY2gvcG93ZXJwYy9rdm0vYm9vazNzLmMKQEAgLTEwNTIs
NyArMTA1Miw3IEBAIHN0YXRpYyBpbnQga3ZtcHBjX2Jvb2szc19pbml0KHZvaWQpCiB7CiAJaW50
IHI7CiAKLQlyID0ga3ZtX2luaXQoTlVMTCwgc2l6ZW9mKHN0cnVjdCBrdm1fdmNwdSksIDAsIFRI
SVNfTU9EVUxFKTsKKwlyID0ga3ZtX2luaXQoc2l6ZW9mKHN0cnVjdCBrdm1fdmNwdSksIDAsIFRI
SVNfTU9EVUxFKTsKIAlpZiAocikKIAkJcmV0dXJuIHI7CiAjaWZkZWYgQ09ORklHX0tWTV9CT09L
M1NfMzJfSEFORExFUgpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2t2bS9lNTAwLmMgYi9hcmNo
L3Bvd2VycGMva3ZtL2U1MDAuYwppbmRleCAwZWE2MTE5MGVjMDQuLmIwZjY5NTQyODczMyAxMDA2
NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2t2bS9lNTAwLmMKKysrIGIvYXJjaC9wb3dlcnBjL2t2bS9l
NTAwLmMKQEAgLTUzMSw3ICs1MzEsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBrdm1wcGNfZTUwMF9p
bml0KHZvaWQpCiAJZmx1c2hfaWNhY2hlX3JhbmdlKGt2bXBwY19ib29rZV9oYW5kbGVycywga3Zt
cHBjX2Jvb2tlX2hhbmRsZXJzICsKIAkJCSAgIGl2b3JbbWF4X2l2b3JdICsgaGFuZGxlcl9sZW4p
OwogCi0JciA9IGt2bV9pbml0KE5VTEwsIHNpemVvZihzdHJ1Y3Qga3ZtcHBjX3ZjcHVfZTUwMCks
IDAsIFRISVNfTU9EVUxFKTsKKwlyID0ga3ZtX2luaXQoc2l6ZW9mKHN0cnVjdCBrdm1wcGNfdmNw
dV9lNTAwKSwgMCwgVEhJU19NT0RVTEUpOwogCWlmIChyKQogCQlnb3RvIGVycl9vdXQ7CiAJa3Zt
X29wc19lNTAwLm93bmVyID0gVEhJU19NT0RVTEU7CmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMv
a3ZtL2U1MDBtYy5jIGIvYXJjaC9wb3dlcnBjL2t2bS9lNTAwbWMuYwppbmRleCA3OTU2NjdmN2Vi
ZjAuLjYxMTUzMmEwZGVkYyAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2t2bS9lNTAwbWMuYwor
KysgYi9hcmNoL3Bvd2VycGMva3ZtL2U1MDBtYy5jCkBAIC00MDQsNyArNDA0LDcgQEAgc3RhdGlj
IGludCBfX2luaXQga3ZtcHBjX2U1MDBtY19pbml0KHZvaWQpCiAJICovCiAJa3ZtcHBjX2luaXRf
bHBpZChLVk1QUENfTlJfTFBJRFMvdGhyZWFkc19wZXJfY29yZSk7CiAKLQlyID0ga3ZtX2luaXQo
TlVMTCwgc2l6ZW9mKHN0cnVjdCBrdm1wcGNfdmNwdV9lNTAwKSwgMCwgVEhJU19NT0RVTEUpOwor
CXIgPSBrdm1faW5pdChzaXplb2Yoc3RydWN0IGt2bXBwY192Y3B1X2U1MDApLCAwLCBUSElTX01P
RFVMRSk7CiAJaWYgKHIpCiAJCWdvdG8gZXJyX291dDsKIAlrdm1fb3BzX2U1MDBtYy5vd25lciA9
IFRISVNfTU9EVUxFOwpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2t2bS9wb3dlcnBjLmMgYi9h
cmNoL3Bvd2VycGMva3ZtL3Bvd2VycGMuYwppbmRleCAwMWQwZjk5MzVlNmMuLmY1YjRmZjZiZmM4
OSAxMDA2NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2t2bS9wb3dlcnBjLmMKKysrIGIvYXJjaC9wb3dl
cnBjL2t2bS9wb3dlcnBjLmMKQEAgLTQ0MCwxMSArNDQwLDYgQEAgaW50IGt2bV9hcmNoX2hhcmR3
YXJlX2VuYWJsZSh2b2lkKQogCXJldHVybiAwOwogfQogCi1pbnQga3ZtX2FyY2hfY2hlY2tfcHJv
Y2Vzc29yX2NvbXBhdCh2b2lkICpvcGFxdWUpCi17Ci0JcmV0dXJuIDA7Ci19Ci0KIGludCBrdm1f
YXJjaF9pbml0X3ZtKHN0cnVjdCBrdm0gKmt2bSwgdW5zaWduZWQgbG9uZyB0eXBlKQogewogCXN0
cnVjdCBrdm1wcGNfb3BzICprdm1fb3BzID0gTlVMTDsKZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
a3ZtL21haW4uYyBiL2FyY2gvcmlzY3Yva3ZtL21haW4uYwppbmRleCA0NzEwYTY3NTE2ODcuLjM0
YzNkZWNlNjk5MCAxMDA2NDQKLS0tIGEvYXJjaC9yaXNjdi9rdm0vbWFpbi5jCisrKyBiL2FyY2gv
cmlzY3Yva3ZtL21haW4uYwpAQCAtMjAsMTEgKzIwLDYgQEAgbG9uZyBrdm1fYXJjaF9kZXZfaW9j
dGwoc3RydWN0IGZpbGUgKmZpbHAsCiAJcmV0dXJuIC1FSU5WQUw7CiB9CiAKLWludCBrdm1fYXJj
aF9jaGVja19wcm9jZXNzb3JfY29tcGF0KHZvaWQgKm9wYXF1ZSkKLXsKLQlyZXR1cm4gMDsKLX0K
LQogaW50IGt2bV9hcmNoX2hhcmR3YXJlX2VuYWJsZSh2b2lkKQogewogCXVuc2lnbmVkIGxvbmcg
aGlkZWxlZywgaGVkZWxlZzsKQEAgLTExMCw2ICsxMDUsNiBAQCBzdGF0aWMgaW50IF9faW5pdCBy
aXNjdl9rdm1faW5pdCh2b2lkKQogCiAJa3ZtX2luZm8oIlZNSUQgJWxkIGJpdHMgYXZhaWxhYmxl
XG4iLCBrdm1fcmlzY3ZfZ3N0YWdlX3ZtaWRfYml0cygpKTsKIAotCXJldHVybiBrdm1faW5pdChO
VUxMLCBzaXplb2Yoc3RydWN0IGt2bV92Y3B1KSwgMCwgVEhJU19NT0RVTEUpOworCXJldHVybiBr
dm1faW5pdChzaXplb2Yoc3RydWN0IGt2bV92Y3B1KSwgMCwgVEhJU19NT0RVTEUpOwogfQogbW9k
dWxlX2luaXQocmlzY3Zfa3ZtX2luaXQpOwpkaWZmIC0tZ2l0IGEvYXJjaC9zMzkwL2t2bS9rdm0t
czM5MC5jIGIvYXJjaC9zMzkwL2t2bS9rdm0tczM5MC5jCmluZGV4IDI1YjA4Yjk1Njg4OC4uN2Fk
ODI1MmU5MmMyIDEwMDY0NAotLS0gYS9hcmNoL3MzOTAva3ZtL2t2bS1zMzkwLmMKKysrIGIvYXJj
aC9zMzkwL2t2bS9rdm0tczM5MC5jCkBAIC0yNjIsMTEgKzI2Miw2IEBAIGludCBrdm1fYXJjaF9o
YXJkd2FyZV9lbmFibGUodm9pZCkKIAlyZXR1cm4gMDsKIH0KIAotaW50IGt2bV9hcmNoX2NoZWNr
X3Byb2Nlc3Nvcl9jb21wYXQodm9pZCAqb3BhcXVlKQotewotCXJldHVybiAwOwotfQotCiAvKiBm
b3J3YXJkIGRlY2xhcmF0aW9ucyAqLwogc3RhdGljIHZvaWQga3ZtX2dtYXBfbm90aWZpZXIoc3Ry
dWN0IGdtYXAgKmdtYXAsIHVuc2lnbmVkIGxvbmcgc3RhcnQsCiAJCQkgICAgICB1bnNpZ25lZCBs
b25nIGVuZCk7CkBAIC01NzE2LDcgKzU3MTEsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBrdm1fczM5
MF9pbml0KHZvaWQpCiAJaWYgKHIpCiAJCXJldHVybiByOwogCi0JciA9IGt2bV9pbml0KE5VTEws
IHNpemVvZihzdHJ1Y3Qga3ZtX3ZjcHUpLCAwLCBUSElTX01PRFVMRSk7CisJciA9IGt2bV9pbml0
KHNpemVvZihzdHJ1Y3Qga3ZtX3ZjcHUpLCAwLCBUSElTX01PRFVMRSk7CiAJaWYgKHIpIHsKIAkJ
X19rdm1fczM5MF9leGl0KCk7CiAJCXJldHVybiByOwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3Zt
L3N2bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKaW5kZXggZDdlYTFjMTE3NWMyLi5k
OWE1NDU5MDU5MWQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKKysrIGIvYXJj
aC94ODYva3ZtL3N2bS9zdm0uYwpAQCAtNTEwMyw4ICs1MTAzLDggQEAgc3RhdGljIGludCBfX2lu
aXQgc3ZtX2luaXQodm9pZCkKIAkgKiBDb21tb24gS1ZNIGluaXRpYWxpemF0aW9uIF9tdXN0XyBj
b21lIGxhc3QsIGFmdGVyIHRoaXMsIC9kZXYva3ZtIGlzCiAJICogZXhwb3NlZCB0byB1c2Vyc3Bh
Y2UhCiAJICovCi0JciA9IGt2bV9pbml0KE5VTEwsIHNpemVvZihzdHJ1Y3QgdmNwdV9zdm0pLAot
CQkgICAgIF9fYWxpZ25vZl9fKHN0cnVjdCB2Y3B1X3N2bSksIFRISVNfTU9EVUxFKTsKKwlyID0g
a3ZtX2luaXQoc2l6ZW9mKHN0cnVjdCB2Y3B1X3N2bSksIF9fYWxpZ25vZl9fKHN0cnVjdCB2Y3B1
X3N2bSksCisJCSAgICAgVEhJU19NT0RVTEUpOwogCWlmIChyKQogCQlnb3RvIGVycl9rdm1faW5p
dDsKIApkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC92bXguYyBiL2FyY2gveDg2L2t2bS92
bXgvdm14LmMKaW5kZXggOGRlYjFiZDYwYzEwLi5iNmYwOGEwYTE0MzUgMTAwNjQ0Ci0tLSBhL2Fy
Y2gveDg2L2t2bS92bXgvdm14LmMKKysrIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwpAQCAtODU5
Miw4ICs4NTkyLDggQEAgc3RhdGljIGludCBfX2luaXQgdm14X2luaXQodm9pZCkKIAkgKiBDb21t
b24gS1ZNIGluaXRpYWxpemF0aW9uIF9tdXN0XyBjb21lIGxhc3QsIGFmdGVyIHRoaXMsIC9kZXYv
a3ZtIGlzCiAJICogZXhwb3NlZCB0byB1c2Vyc3BhY2UhCiAJICovCi0JciA9IGt2bV9pbml0KE5V
TEwsIHNpemVvZihzdHJ1Y3QgdmNwdV92bXgpLAotCQkgICAgIF9fYWxpZ25vZl9fKHN0cnVjdCB2
Y3B1X3ZteCksIFRISVNfTU9EVUxFKTsKKwlyID0ga3ZtX2luaXQoc2l6ZW9mKHN0cnVjdCB2Y3B1
X3ZteCksIF9fYWxpZ25vZl9fKHN0cnVjdCB2Y3B1X3ZteCksCisJCSAgICAgVEhJU19NT0RVTEUp
OwogCWlmIChyKQogCQlnb3RvIGVycl9rdm1faW5pdDsKIApkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IDM1NzFiYzk2OGNmOC4uNTY2MTU2
YjM0MzE0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYva3Zt
L3g4Ni5jCkBAIC0xMjA3MSwxMSArMTIwNzEsNiBAQCB2b2lkIGt2bV9hcmNoX2hhcmR3YXJlX2Rp
c2FibGUodm9pZCkKIAlkcm9wX3VzZXJfcmV0dXJuX25vdGlmaWVycygpOwogfQogCi1pbnQga3Zt
X2FyY2hfY2hlY2tfcHJvY2Vzc29yX2NvbXBhdCh2b2lkICpvcGFxdWUpCi17Ci0JcmV0dXJuIDA7
Ci19Ci0KIGJvb2wga3ZtX3ZjcHVfaXNfcmVzZXRfYnNwKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkK
IHsKIAlyZXR1cm4gdmNwdS0+a3ZtLT5hcmNoLmJzcF92Y3B1X2lkID09IHZjcHUtPnZjcHVfaWQ7
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmggYi9pbmNsdWRlL2xpbnV4L2t2
bV9ob3N0LmgKaW5kZXggN2RkZTI4MzMzZTdjLi42MTZlOGU5MDU1OGIgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgva3ZtX2hvc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKQEAg
LTk1Myw4ICs5NTMsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQga3ZtX2lycWZkX2V4aXQodm9pZCkK
IHsKIH0KICNlbmRpZgotaW50IGt2bV9pbml0KHZvaWQgKm9wYXF1ZSwgdW5zaWduZWQgdmNwdV9z
aXplLCB1bnNpZ25lZCB2Y3B1X2FsaWduLAotCQkgIHN0cnVjdCBtb2R1bGUgKm1vZHVsZSk7Citp
bnQga3ZtX2luaXQodW5zaWduZWQgdmNwdV9zaXplLCB1bnNpZ25lZCB2Y3B1X2FsaWduLCBzdHJ1
Y3QgbW9kdWxlICptb2R1bGUpOwogdm9pZCBrdm1fZXhpdCh2b2lkKTsKIAogdm9pZCBrdm1fZ2V0
X2t2bShzdHJ1Y3Qga3ZtICprdm0pOwpAQCAtMTQ2MCw3ICsxNDU5LDYgQEAgc3RhdGljIGlubGlu
ZSB2b2lkIGt2bV9jcmVhdGVfdmNwdV9kZWJ1Z2ZzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkge30K
IAogaW50IGt2bV9hcmNoX2hhcmR3YXJlX2VuYWJsZSh2b2lkKTsKIHZvaWQga3ZtX2FyY2hfaGFy
ZHdhcmVfZGlzYWJsZSh2b2lkKTsKLWludCBrdm1fYXJjaF9jaGVja19wcm9jZXNzb3JfY29tcGF0
KHZvaWQgKm9wYXF1ZSk7CiBpbnQga3ZtX2FyY2hfdmNwdV9ydW5uYWJsZShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUpOwogYm9vbCBrdm1fYXJjaF92Y3B1X2luX2tlcm5lbChzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpOwogaW50IGt2bV9hcmNoX3ZjcHVfc2hvdWxkX2tpY2soc3RydWN0IGt2bV92Y3B1ICp2
Y3B1KTsKZGlmZiAtLWdpdCBhL3ZpcnQva3ZtL2t2bV9tYWluLmMgYi92aXJ0L2t2bS9rdm1fbWFp
bi5jCmluZGV4IGE0YTEwYTBiMzIyZi4uMzkwMGJkM2Q3NWNiIDEwMDY0NAotLS0gYS92aXJ0L2t2
bS9rdm1fbWFpbi5jCisrKyBiL3ZpcnQva3ZtL2t2bV9tYWluLmMKQEAgLTU4MzMsMzYgKzU4MzMs
MTQgQEAgdm9pZCBrdm1fdW5yZWdpc3Rlcl9wZXJmX2NhbGxiYWNrcyh2b2lkKQogfQogI2VuZGlm
CiAKLXN0cnVjdCBrdm1fY3B1X2NvbXBhdF9jaGVjayB7Ci0Jdm9pZCAqb3BhcXVlOwotCWludCAq
cmV0OwotfTsKLQotc3RhdGljIHZvaWQgY2hlY2tfcHJvY2Vzc29yX2NvbXBhdCh2b2lkICpkYXRh
KQoraW50IGt2bV9pbml0KHVuc2lnbmVkIHZjcHVfc2l6ZSwgdW5zaWduZWQgdmNwdV9hbGlnbiwg
c3RydWN0IG1vZHVsZSAqbW9kdWxlKQogewotCXN0cnVjdCBrdm1fY3B1X2NvbXBhdF9jaGVjayAq
YyA9IGRhdGE7Ci0KLQkqYy0+cmV0ID0ga3ZtX2FyY2hfY2hlY2tfcHJvY2Vzc29yX2NvbXBhdChj
LT5vcGFxdWUpOwotfQotCi1pbnQga3ZtX2luaXQodm9pZCAqb3BhcXVlLCB1bnNpZ25lZCB2Y3B1
X3NpemUsIHVuc2lnbmVkIHZjcHVfYWxpZ24sCi0JCSAgc3RydWN0IG1vZHVsZSAqbW9kdWxlKQot
ewotCXN0cnVjdCBrdm1fY3B1X2NvbXBhdF9jaGVjayBjOwogCWludCByOwogCWludCBjcHU7CiAK
IAlpZiAoIXphbGxvY19jcHVtYXNrX3ZhcigmY3B1c19oYXJkd2FyZV9lbmFibGVkLCBHRlBfS0VS
TkVMKSkKIAkJcmV0dXJuIC1FTk9NRU07CiAKLQljLnJldCA9ICZyOwotCWMub3BhcXVlID0gb3Bh
cXVlOwotCWZvcl9lYWNoX29ubGluZV9jcHUoY3B1KSB7Ci0JCXNtcF9jYWxsX2Z1bmN0aW9uX3Np
bmdsZShjcHUsIGNoZWNrX3Byb2Nlc3Nvcl9jb21wYXQsICZjLCAxKTsKLQkJaWYgKHIgPCAwKQot
CQkJZ290byBvdXRfZnJlZV8yOwotCX0KLQogCXIgPSBjcHVocF9zZXR1cF9zdGF0ZV9ub2NhbGxz
KENQVUhQX0FQX0tWTV9TVEFSVElORywgImt2bS9jcHU6c3RhcnRpbmciLAogCQkJCSAgICAgIGt2
bV9zdGFydGluZ19jcHUsIGt2bV9keWluZ19jcHUpOwogCWlmIChyKQotLSAKMi4zOC4xLjU4NC5n
MGYzYzU1ZDRjMi1nb29nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUK
aHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
