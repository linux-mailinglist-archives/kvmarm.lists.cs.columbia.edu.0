Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BD5CE2E9198
	for <lists+kvmarm@lfdr.de>; Mon,  4 Jan 2021 09:17:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 721CC4B2E9;
	Mon,  4 Jan 2021 03:17:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNvDwOt0uMN6; Mon,  4 Jan 2021 03:17:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 727E24B2A0;
	Mon,  4 Jan 2021 03:17:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 80F324B2FA
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 03:17:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KTfg2J9yo51B for <kvmarm@lists.cs.columbia.edu>;
 Mon,  4 Jan 2021 03:17:06 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 71D4E4B202
 for <kvmarm@lists.cs.columbia.edu>; Mon,  4 Jan 2021 03:17:05 -0500 (EST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D8T3G2fdKzMF8b;
 Mon,  4 Jan 2021 16:15:54 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.196) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 4 Jan 2021 16:16:54 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Eric Auger <eric.auger@redhat.com>, "Will
 Deacon" <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 3/4] KVM: arm64: GICv4.1: Restore VLPI's pending state
 to physical side
Date: Mon, 4 Jan 2021 16:16:12 +0800
Message-ID: <20210104081613.100-4-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210104081613.100-1-lushenming@huawei.com>
References: <20210104081613.100-1-lushenming@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.196]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>
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

RnJvbTogWmVuZ2h1aSBZdSA8eXV6ZW5naHVpQGh1YXdlaS5jb20+CgpXaGVuIHNldHRpbmcgdGhl
IGZvcndhcmRpbmcgcGF0aCBvZiBhIFZMUEkgKHN3aXRjaCB0byB0aGUgSFcgbW9kZSksCndlIGNv
dWxkIGFsc28gdHJhbnNmZXIgdGhlIHBlbmRpbmcgc3RhdGUgZnJvbSBpcnEtPnBlbmRpbmdfbGF0
Y2ggdG8KVlBUIChlc3BlY2lhbGx5IGluIG1pZ3JhdGlvbiwgdGhlIHBlbmRpbmcgc3RhdGVzIG9m
IFZMUElzIGFyZSByZXN0b3JlZAppbnRvIGt2beKAmXMgdmdpYyBmaXJzdCkuIEFuZCB3ZSBjdXJy
ZW50bHkgc2VuZCAiSU5UK1ZTWU5DIiB0byB0cmlnZ2VyCmEgVkxQSSB0byBwZW5kaW5nLgoKU2ln
bmVkLW9mZi1ieTogWmVuZ2h1aSBZdSA8eXV6ZW5naHVpQGh1YXdlaS5jb20+ClNpZ25lZC1vZmYt
Ynk6IFNoZW5taW5nIEx1IDxsdXNoZW5taW5nQGh1YXdlaS5jb20+Ci0tLQogYXJjaC9hcm02NC9r
dm0vdmdpYy92Z2ljLXY0LmMgfCAxMiArKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rdm0vdmdpYy92Z2ljLXY0LmMg
Yi9hcmNoL2FybTY0L2t2bS92Z2ljL3ZnaWMtdjQuYwppbmRleCBmMjExYTdjMzI3MDQuLjc5NDVk
NmQwOWNkZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9rdm0vdmdpYy92Z2ljLXY0LmMKKysrIGIv
YXJjaC9hcm02NC9rdm0vdmdpYy92Z2ljLXY0LmMKQEAgLTQ1NCw2ICs0NTQsMTggQEAgaW50IGt2
bV92Z2ljX3Y0X3NldF9mb3J3YXJkaW5nKHN0cnVjdCBrdm0gKmt2bSwgaW50IHZpcnEsCiAJaXJx
LT5ob3N0X2lycQk9IHZpcnE7CiAJYXRvbWljX2luYygmbWFwLnZwZS0+dmxwaV9jb3VudCk7CiAK
KwkvKiBUcmFuc2ZlciBwZW5kaW5nIHN0YXRlICovCisJcmV0ID0gaXJxX3NldF9pcnFjaGlwX3N0
YXRlKGlycS0+aG9zdF9pcnEsCisJCQkJICAgIElSUUNISVBfU1RBVEVfUEVORElORywKKwkJCQkg
ICAgaXJxLT5wZW5kaW5nX2xhdGNoKTsKKwlXQVJOX1JBVEVMSU1JVChyZXQsICJJUlEgJWQiLCBp
cnEtPmhvc3RfaXJxKTsKKworCS8qCisJICogTGV0IGl0IGJlIHBydW5lZCBmcm9tIGFwX2xpc3Qg
bGF0ZXIgYW5kIGRvbid0IGJvdGhlcgorCSAqIHRoZSBMaXN0IFJlZ2lzdGVyLgorCSAqLworCWly
cS0+cGVuZGluZ19sYXRjaCA9IGZhbHNlOworCiBvdXQ6CiAJbXV0ZXhfdW5sb2NrKCZpdHMtPml0
c19sb2NrKTsKIAlyZXR1cm4gcmV0OwotLSAKMi4xOS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0
cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9s
aXN0aW5mby9rdm1hcm0K
