Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3628C27C2C2
	for <lists+kvmarm@lfdr.de>; Tue, 29 Sep 2020 12:50:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA4874B1B4;
	Tue, 29 Sep 2020 06:50:16 -0400 (EDT)
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
	with ESMTP id SmoI+uRBe0BY; Tue, 29 Sep 2020 06:50:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64C814B146;
	Tue, 29 Sep 2020 06:50:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D3DE34B0EB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 06:50:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uRr-m7Vx7k2z for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Sep 2020 06:50:12 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A7C344B112
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 06:50:12 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74AC3207C4;
 Tue, 29 Sep 2020 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601376611;
 bh=+I6vWV6P/qLfkwTM5yFDXU97X8kNtec29ztsEGOJdkI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pfTAeyF0I6swVhhX5Ipfkso18w0joB1zkX5353v8f9nLyFPXnGZ15eBJPKN3sHwMd
 F19mZ62c+2/97x2BqhQwTGlFeDhHY7Fy2B2QqgkGa1nEJzs3NfOiLbN0tpfM2NTcW7
 md0GD5TzXewY0Es6DVpCAJDNYY+H4ZepDQtRtfVc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kNDCz-00FlHa-KA; Tue, 29 Sep 2020 11:50:09 +0100
MIME-Version: 1.0
Date: Tue, 29 Sep 2020 11:50:09 +0100
From: Marc Zyngier <maz@kernel.org>
To: Jingyi Wang <wangjingyi11@huawei.com>
Subject: Re: [RFC PATCH 0/4] Add support for ARMv8.6 TWED feature
In-Reply-To: <20200929091727.8692-1-wangjingyi11@huawei.com>
References: <20200929091727.8692-1-wangjingyi11@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <913250ae919fb9453feadd0527827d55@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangjingyi11@huawei.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 wanghaibin.wang@huawei.com, yezengruan@huawei.com,
 shameerali.kolothum.thodi@huawei.com, fanhenglong@huawei.com,
 prime.zeng@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, fanhenglong@huawei.com,
 prime.zeng@hisilicon.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

T24gMjAyMC0wOS0yOSAxMDoxNywgSmluZ3lpIFdhbmcgd3JvdGU6Cj4gVFdFIERlbGF5IGlzIGFu
IG9wdGlvbmFsIGZlYXR1cmUgaW4gQVJNdjguNiBFeHRlbnRpb25zLiBUaGVyZSBpcyBhCj4gcGVy
Zm9ybWFuY2UgYmVuZWZpdCBpbiB3YWl0aW5nIGZvciBhIHBlcmlvZCBvZiB0aW1lIGZvciBhbiBl
dmVudCB0bwo+IGFycml2ZSBiZWZvcmUgdGFraW5nIHRoZSB0cmFwIGFzIGl0IGlzIGNvbW1vbiB0
aGF0IGV2ZW50IHdpbGwgYXJyaXZlCj4g4oCccXVpdGUgc29vbuKAnSBhZnRlciBleGVjdXRpbmcg
dGhlIFdGRSBpbnN0cnVjdGlvbi4KCkRlZmluZSAicXVpdGUgc29vbiIuIFF1YW50aWZ5ICJwZXJm
b3JtYW5jZSBiZW5lZml0cyIuIFdoaWNoIGFyZSB0aGUKd29ya2xvYWRzIHRoYXQgYWN0dWFsbHkg
YmVuZWZpdCBmcm9tIHRoaXMgaW1pdGF0aW9uIG9mIHRoZSB4ODYgUExFPwoKSSB3YXMgb3Bwb3Nl
ZCB0byB0aGlzIHdoZW4gdGhlIHNwZWMgd2FzIGRyYWZ0ZWQsIGFuZCBJIHN0aWxsIGFtIGdpdmVu
CnRoYXQgdGhlcmUgaXMgemVybyBzdXBwb3J0aW5nIGV2aWRlbmNlIHRoYXQgaXQgYnJpbmcgYW55
IGdhaW4gb3ZlcgppbW1lZGlhdGUgdHJhcHBpbmcgaW4gYW4gb3ZlcnN1YnNjcmliZWQgZW52aXJv
bm1lbnQgKHdoaWNoIGlzIHRoZSBvbmx5CmNhc2Ugd2hlcmUgaXQgbWF0dGVycykuCgpUaGFua3Ms
CgogICAgICAgICBNLgoKPiAKPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIFRXRUQgZmVh
dHVyZSBhbmQgaW1wbGVtZW50cyBUV0UgZGVsYXkKPiB2YWx1ZSBkeW5hbWljIGFkanVzdG1lbnQu
Cj4gCj4gVGhhbmtzIGZvciBTaGFtZWVyJ3MgYWR2aWNlIG9uIHRoaXMgc2VyaWVzLiBUaGUgZnVu
Y3Rpb24gb2YgdGhpcyBwYXRjaAo+IGhhcyBiZWVuIHRlc3RlZCBvbiBUV0VEIHN1cHBvcnRlZCBo
YXJkd2FyZSBhbmQgdGhlIHBlcmZvcm1hbmNlIG9mIGl0IGlzCj4gc3RpbGwgb24gdGVzdCwgYW55
IGFkdmljZSB3aWxsIGJlIHdlbGNvbWVkLgo+IAo+IEppbmd5aSBXYW5nICgyKToKPiAgIEtWTTog
YXJtNjQ6IE1ha2UgdXNlIG9mIFRXRUQgZmVhdHVyZQo+ICAgS1ZNOiBhcm02NDogVXNlIGR5bmFt
aWMgVFdFIERlbGF5IHZhbHVlCj4gCj4gWmVuZ3J1YW4gWWUgKDIpOgo+ICAgYXJtNjQ6IGNwdWZl
YXR1cmU6IFRXRUQgc3VwcG9ydCBkZXRlY3Rpb24KPiAgIEtWTTogYXJtNjQ6IEFkZCB0cmFjZSBm
b3IgVFdFRCB1cGRhdGUKPiAKPiAgYXJjaC9hcm02NC9LY29uZmlnICAgICAgICAgICAgICAgICAg
IHwgMTAgKysrKysKPiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jcHVjYXBzLmggICAgIHwgIDMg
Ky0KPiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1fYXJtLmggICAgIHwgIDUgKysrCj4gIGFy
Y2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2VtdWxhdGUuaCB8IDM4ICsrKysrKysrKysrKysrKysr
Kwo+ICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggICAgfCAxOSArKysrKysrKy0K
PiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS92aXJ0LmggICAgICAgIHwgIDggKysrKwo+ICBhcmNo
L2FybTY0L2tlcm5lbC9jcHVmZWF0dXJlLmMgICAgICAgfCAxMiArKysrKysKPiAgYXJjaC9hcm02
NC9rdm0vYXJtLmMgICAgICAgICAgICAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ICBhcmNoL2FybTY0L2t2bS9oYW5kbGVfZXhpdC5jICAgICAgICAgfCAgMiArCj4gIGFy
Y2gvYXJtNjQva3ZtL3RyYWNlX2FybS5oICAgICAgICAgICB8IDIxICsrKysrKysrKysKPiAgMTAg
ZmlsZXMgY2hhbmdlZCwgMTc0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgotLSAKSmF6
eiBpcyBub3QgZGVhZC4gSXQganVzdCBzbWVsbHMgZnVubnkuLi4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1A
bGlzdHMuY3MuY29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxt
YW4vbGlzdGluZm8va3ZtYXJtCg==
