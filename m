Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DBA5C27C0D1
	for <lists+kvmarm@lfdr.de>; Tue, 29 Sep 2020 11:18:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F0D74B33A;
	Tue, 29 Sep 2020 05:18:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eOeAyBZ98tan; Tue, 29 Sep 2020 05:18:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 674CC4B336;
	Tue, 29 Sep 2020 05:17:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 34E6B4B324
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 05:17:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgH1B1lbTWMV for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Sep 2020 05:17:56 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0A8584B311
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 05:17:56 -0400 (EDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 545B0E38F9F3F29BB102;
 Tue, 29 Sep 2020 17:17:52 +0800 (CST)
Received: from DESKTOP-FPN2511.china.huawei.com (10.174.187.69) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 17:17:45 +0800
From: Jingyi Wang <wangjingyi11@huawei.com>
To: <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 0/4] Add support for ARMv8.6 TWED feature
Date: Tue, 29 Sep 2020 17:17:23 +0800
Message-ID: <20200929091727.8692-1-wangjingyi11@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.187.69]
X-CFilter-Loop: Reflected
Cc: catalin.marinas@arm.com, fanhenglong@huawei.com, prime.zeng@hisilicon.com,
 maz@kernel.org, will@kernel.org
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

VFdFIERlbGF5IGlzIGFuIG9wdGlvbmFsIGZlYXR1cmUgaW4gQVJNdjguNiBFeHRlbnRpb25zLiBU
aGVyZSBpcyBhCnBlcmZvcm1hbmNlIGJlbmVmaXQgaW4gd2FpdGluZyBmb3IgYSBwZXJpb2Qgb2Yg
dGltZSBmb3IgYW4gZXZlbnQgdG8KYXJyaXZlIGJlZm9yZSB0YWtpbmcgdGhlIHRyYXAgYXMgaXQg
aXMgY29tbW9uIHRoYXQgZXZlbnQgd2lsbCBhcnJpdmUK4oCccXVpdGUgc29vbuKAnSBhZnRlciBl
eGVjdXRpbmcgdGhlIFdGRSBpbnN0cnVjdGlvbi4KClRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBm
b3IgVFdFRCBmZWF0dXJlIGFuZCBpbXBsZW1lbnRzIFRXRSBkZWxheQp2YWx1ZSBkeW5hbWljIGFk
anVzdG1lbnQuCgpUaGFua3MgZm9yIFNoYW1lZXIncyBhZHZpY2Ugb24gdGhpcyBzZXJpZXMuIFRo
ZSBmdW5jdGlvbiBvZiB0aGlzIHBhdGNoCmhhcyBiZWVuIHRlc3RlZCBvbiBUV0VEIHN1cHBvcnRl
ZCBoYXJkd2FyZSBhbmQgdGhlIHBlcmZvcm1hbmNlIG9mIGl0IGlzCnN0aWxsIG9uIHRlc3QsIGFu
eSBhZHZpY2Ugd2lsbCBiZSB3ZWxjb21lZC4KCkppbmd5aSBXYW5nICgyKToKICBLVk06IGFybTY0
OiBNYWtlIHVzZSBvZiBUV0VEIGZlYXR1cmUKICBLVk06IGFybTY0OiBVc2UgZHluYW1pYyBUV0Ug
RGVsYXkgdmFsdWUKClplbmdydWFuIFllICgyKToKICBhcm02NDogY3B1ZmVhdHVyZTogVFdFRCBz
dXBwb3J0IGRldGVjdGlvbgogIEtWTTogYXJtNjQ6IEFkZCB0cmFjZSBmb3IgVFdFRCB1cGRhdGUK
CiBhcmNoL2FybTY0L0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKwogYXJjaC9h
cm02NC9pbmNsdWRlL2FzbS9jcHVjYXBzLmggICAgIHwgIDMgKy0KIGFyY2gvYXJtNjQvaW5jbHVk
ZS9hc20va3ZtX2FybS5oICAgICB8ICA1ICsrKwogYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1f
ZW11bGF0ZS5oIHwgMzggKysrKysrKysrKysrKysrKysrCiBhcmNoL2FybTY0L2luY2x1ZGUvYXNt
L2t2bV9ob3N0LmggICAgfCAxOSArKysrKysrKy0KIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vdmly
dC5oICAgICAgICB8ICA4ICsrKysKIGFyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYyAgICAg
ICB8IDEyICsrKysrKwogYXJjaC9hcm02NC9rdm0vYXJtLmMgICAgICAgICAgICAgICAgIHwgNTgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogYXJjaC9hcm02NC9rdm0vaGFuZGxlX2V4aXQu
YyAgICAgICAgIHwgIDIgKwogYXJjaC9hcm02NC9rdm0vdHJhY2VfYXJtLmggICAgICAgICAgIHwg
MjEgKysrKysrKysrKwogMTAgZmlsZXMgY2hhbmdlZCwgMTc0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgotLSAKMi4xOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJp
YS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1h
cm0K
