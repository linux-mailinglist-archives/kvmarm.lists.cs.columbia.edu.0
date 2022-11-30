Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5175963E47D
	for <lists+kvmarm@lfdr.de>; Thu,  1 Dec 2022 00:10:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EE4E94B4D7;
	Wed, 30 Nov 2022 18:10:28 -0500 (EST)
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
	with ESMTP id p4WccFXZXn+C; Wed, 30 Nov 2022 18:10:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C2E84B3DE;
	Wed, 30 Nov 2022 18:10:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8883C4B3E8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 18:10:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b+mP8G9NTYx4 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 30 Nov 2022 18:10:20 -0500 (EST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9F1D94B3F6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 18:10:17 -0500 (EST)
Received: by mail-pf1-f202.google.com with SMTP id
 y11-20020a056a00190b00b005749340b8a8so179717pfi.11
 for <kvmarm@lists.cs.columbia.edu>; Wed, 30 Nov 2022 15:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2E/ZNfNVjTWUDx7EclAA9RDMNJ28SDYbq0FBSTNkEW0=;
 b=YOeUjr5k1nRXALq3v0KKdNU/RoNOZHvdJ287PzEh8mewFol14vSXSy8/3fYRK98ogf
 DM6/FhXti4G1BKHQNvzjRV1tWyFhTyxYu+zxNSNi9IlHcolXKLZsPssVX0dsnM50iavV
 x2ODcftM6fP7S5M9f/kxN+kBZaYtyIW+z4R08Rc0Nfjpphi6e+XsI1tHwJnKWXkQaHpN
 Fvd9/AR9wQma2szpaVgVzc80G2d6HwNcimfP60MChrBcVuLXdfKe+wSSxLqRYu4pvEyL
 hD29cSFZ9nNlD/40iFEC/0Ct0+nb0Drk9Ewou2J1g8F1lSQpSFp12LOPbSOpy+zVepWe
 HB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2E/ZNfNVjTWUDx7EclAA9RDMNJ28SDYbq0FBSTNkEW0=;
 b=JRxT8QezGUMKTajRpWL57BhjvuIy6RnnPbZmcCKDi3l1xdplWIbbCbIkVByqKgowPc
 trDQ9vbj50dUuhUp2Xs7VpqbPqYoAVg2sKPQRhX61rLDTv+fZBgp+4lyFSp1Pq1eX9GI
 0SVInEEXWZHxWbPaQoPWh7qcrFpz+yGSwyI2d/5V8dCl5h5JYNbstWBfuUKYoF55xO5e
 bhQhInZispjCpwezBGezn4JUePIdnZJGqsj3RHKgq0RSEmlhBKqBi2tpr/BE9Ty2j/l2
 P0ocLsfxE/uPo/HAypqOhgP/+tBKcfwLMkDhhelfnasn8oq+6YKJRanmLILY2o7im5Ht
 /BdQ==
X-Gm-Message-State: ANoB5pk6jxN+VsKEjqDa1QIA7u4DWbzmSnFRFDNXDeAzZcIE7iHsOJAP
 CaVGjGFn+T+CuKk7lJUgADI9IfteA2I=
X-Google-Smtp-Source: AA0mqf6fouTIX68sTKIWP0zUhpW+UmWGK5D4PKuHk4dF0PG0spJwJY42lnPZuN8WAPveTbTZZSc8FEJYBlE=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:6045:0:b0:575:f66b:75a9 with SMTP id
 u66-20020a626045000000b00575f66b75a9mr3406091pfb.2.1669849816681; Wed, 30 Nov
 2022 15:10:16 -0800 (PST)
Date: Wed, 30 Nov 2022 23:09:07 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-24-seanjc@google.com>
Subject: [PATCH v2 23/50] KVM: MIPS: Register die notifier prior to kvm_init()
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

Q2FsbCBrdm1faW5pdCgpIG9ubHkgYWZ0ZXIgX2FsbF8gc2V0dXAgaXMgY29tcGxldGUsIGFzIGt2
bV9pbml0KCkgZXhwb3NlcwovZGV2L2t2bSB0byB1c2Vyc3BhY2UgYW5kIHRodXMgYWxsb3dzIHVz
ZXJzcGFjZSB0byBjcmVhdGUgVk1zIChhbmQgY2FsbApvdGhlciBpb2N0bHMpLgoKU2lnbmVkLW9m
Zi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+ClJldmlld2VkLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+Ci0tLQogYXJjaC9t
aXBzL2t2bS9taXBzLmMgfCA5ICsrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL21pcHMva3ZtL21pcHMuYyBi
L2FyY2gvbWlwcy9rdm0vbWlwcy5jCmluZGV4IDc1NjgxMjgxZTJkZi4uYWU3YTI0MzQyZmRmIDEw
MDY0NAotLS0gYS9hcmNoL21pcHMva3ZtL21pcHMuYworKysgYi9hcmNoL21pcHMva3ZtL21pcHMu
YwpAQCAtMTY0MCwxNiArMTY0MCwxNyBAQCBzdGF0aWMgaW50IF9faW5pdCBrdm1fbWlwc19pbml0
KHZvaWQpCiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAotCXJldCA9IGt2bV9pbml0KE5VTEws
IHNpemVvZihzdHJ1Y3Qga3ZtX3ZjcHUpLCAwLCBUSElTX01PRFVMRSk7Ci0KLQlpZiAocmV0KQot
CQlyZXR1cm4gcmV0OwogCiAJaWYgKGJvb3RfY3B1X3R5cGUoKSA9PSBDUFVfTE9PTkdTT042NCkK
IAkJa3ZtX3ByaW9yaXR5X3RvX2lycSA9IGt2bV9sb29uZ3NvbjNfcHJpb3JpdHlfdG9faXJxOwog
CiAJcmVnaXN0ZXJfZGllX25vdGlmaWVyKCZrdm1fbWlwc19jc3JfZGllX25vdGlmaWVyKTsKIAor
CXJldCA9IGt2bV9pbml0KE5VTEwsIHNpemVvZihzdHJ1Y3Qga3ZtX3ZjcHUpLCAwLCBUSElTX01P
RFVMRSk7CisJaWYgKHJldCkgeworCQl1bnJlZ2lzdGVyX2RpZV9ub3RpZmllcigma3ZtX21pcHNf
Y3NyX2RpZV9ub3RpZmllcik7CisJCXJldHVybiByZXQ7CisJfQogCXJldHVybiAwOwogfQogCi0t
IAoyLjM4LjEuNTg0LmcwZjNjNTVkNGMyLWdvb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNz
LmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3Rp
bmZvL2t2bWFybQo=
