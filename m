Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC2765F2
	for <lists+kvmarm@lfdr.de>; Fri, 26 Jul 2019 14:35:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B4014A62B;
	Fri, 26 Jul 2019 08:35:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxP+-vt0fkLT; Fri, 26 Jul 2019 08:35:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C8394A61F;
	Fri, 26 Jul 2019 08:35:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 146554A605
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Jul 2019 08:35:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vsoqcz9IyEEa for <kvmarm@lists.cs.columbia.edu>;
 Fri, 26 Jul 2019 08:35:39 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7B5004A5F9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Jul 2019 08:35:39 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0119DAA1901A5B2FF040;
 Fri, 26 Jul 2019 20:35:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.122) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 20:35:30 +0800
Subject: Re: [PATCH 1/3] KVM: arm/arm64: vgic-its: Introduce multiple LPI
 translation caches
To: Marc Zyngier <marc.zyngier@arm.com>
References: <20190724090437.49952-1-xiexiangyou@huawei.com>
 <20190724090437.49952-2-xiexiangyou@huawei.com>
 <a8b74b25-8c92-4aad-f94d-8371126798ef@arm.com>
From: Xiangyou Xie <xiexiangyou@huawei.com>
Message-ID: <c0f441b5-2ba2-0482-6736-eb7835a24f0a@huawei.com>
Date: Fri, 26 Jul 2019 20:35:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a8b74b25-8c92-4aad-f94d-8371126798ef@arm.com>
Content-Language: en-US
X-Originating-IP: [10.177.19.122]
X-CFilter-Loop: Reflected
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
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

SGkgTWFyYywKClNvcnJ5LCB0aGUgdGVzdCBkYXRhIHdhcyBub3QgcG9zdGVkIGluIHRoZSBwcmV2
aW91cyBlbWFpbC4KCkkgdGVzdGVkIHRoZSBpbXBhY3Qgb2YgdmlydHVhbCBpbnRlcnJ1cHQgaW5q
ZWN0aW9uIHRpbWUtY29uc3VtaW5n77yaClJ1biB0aGUgaXBlcmYgY29tbWFuZCB0byBzZW5kIFVE
UCBwYWNrZXRzIHRvIHRoZSBWTToKCWlwZXJmIC1jICRJUCAtdSAtYiA0MG0gLWwgNjQgLXQgNjAw
MCYKVGhlIHZtIGp1c3QgcmVjZWl2ZSBVRFAgdHJhZmZpYy4gV2hlbiBjb25maWd1cmUgbXVsdGlw
bGUgTklDcywgZWFjaCBOSUMgCnJlY2VpdmVzIHRoZSBhYm92ZSBpcGVyZiBVRFAgdHJhZmZpYywg
VGhpcyBtYXkgcmVmbGVjdCB0aGUgcGVyZm9ybWFuY2UgCmltcGFjdCBvZiBzaGFyZWQgcmVzb3Vy
Y2UgY29tcGV0aXRpb24sIHN1Y2ggYXMgbG9jay4KCk9ic2VydmluZyB0aGUgZGVsYXkgb2Ygdmly
dHVhbCBpbnRlcnJ1cHQgaW5qZWN0aW9uOiB0aGUgdGltZSBzcGVudCBieSAKdGhlICJpcnFmZF93
YWtldXAiLCAiaXJxZmRfaW5qZWN0IiBmdW5jdGlvbiwgYW5kIGt3b3JrZXIgY29udGV4dCBzd2l0
Y2guClRoZSBsZXNzIHRoZSBiZXR0ZXIuCgpJVFMgdHJhbnNsYXRpb24gY2FjaGUgZ3JlYXRseSBy
ZWR1Y2VzIHRoZSBkZWxheSBvZiBpbnRlcnJ1cHQgaW5qZWN0aW9uIApjb21wYXJlZCB0byBrd29y
a2VyIHRocmVhZCwgYmVjYXVzZSBpdCBlbGltaW5hdGUgd2FrZXVwIGFuZCB1bmNlcnRhaW4gCnNj
aGVkdWxpbmcgZGVsYXk6CiAgICAgICAgICAgICAgICAgICBrd29ya2VyICAgICAgICAgICAgICBJ
VFMgdHJhbnNsYXRpb24gY2FjaGUgICAgaW1wcm92ZWQKICAgMSBOSUMgICAgICAgICAgIDYuNjky
IHVzICAgICAgICAgICAgICAgICAxLjc2NiB1cyAgICAgICAgICAgICAgIDczLjYlIAoKICAxMCBO
SUNzICAgICAgICAgIDcuNTM2IHVzICAgICAgICAgICAgICAgICAyLjU3NCB1cyAgICAgICAgICAg
ICAgIDY1LjglIAoKCkluY3JlYXNlcyB0aGUgbnVtYmVyIG9mIGxwaV90cmFuc2xhdGlvbl9jYWNo
ZSByZWR1Y2UgbG9jayBjb21wZXRpdGlvbi4KTXVsdGktaW50ZXJydXB0IGNvbmN1cnJlbnQgaW5q
ZWN0aW9ucyBwZXJmb3JtIGJldHRlcjoKCiAgICAgICAgICAgICBJVFMgdHJhbnNsYXRpb24gY2Fj
aGUgICAgICB3aXRoIHBhdGNoICAgICAgICAgICAgIGltcHJvdmVkCiAgICAxIE5JQyAgICAgICAg
MS43NjYgdXMgICAgICAgICAgICAgICAgIDEuNjk0IHVzICAgICAgICAgICAgICAgIDQuMSUKICAx
MCBOSUNzICAgICAgICAyLjU3NCB1cyAgICAgICAgICAgICAgICAgMS44NDggdXMgICAgICAgICAg
ICAgICAyOC4yJQoKUmVnYXJkcywKClhpYW5neW91CgpPbiAyMDE5LzcvMjQgMTk6MDksIE1hcmMg
WnluZ2llciB3cm90ZToKPiBIaSBYaWFuZ3lvdSwKPiAKPiBPbiAyNC8wNy8yMDE5IDEwOjA0LCBY
aWFuZ3lvdSBYaWUgd3JvdGU6Cj4+IEJlY2F1c2UgZGlzdC0+bHBpX2xpc3RfbG9jayBpcyBhIHBl
clZNIGxvY2ssIHdoZW4gYSB2aXJ0dWFsIG1hY2hpbmUKPj4gaXMgY29uZmlndXJlZCB3aXRoIG11
bHRpcGxlIHZpcnR1YWwgTklDIGRldmljZXMgYW5kIHJlY2VpdmVzCj4+IG5ldHdvcmsgcGFja2V0
cyBhdCB0aGUgc2FtZSB0aW1lLCBkaXN0LT5scGlfbGlzdF9sb2NrIHdpbGwgYmVjb21lCj4+IGEg
cGVyZm9ybWFuY2UgYm90dGxlbmVjay4KPiAKPiBJJ20gc29ycnksIGJ1dCB5b3UnbGwgaGF2ZSB0
byBzaG93IG1lIHNvbWUgcmVhbCBudW1iZXJzIGJlZm9yZSBJCj4gY29uc2lkZXIgYW55IG9mIHRo
aXMuIFRoZXJlIGlzIGEgcmVhc29uIHdoeSB0aGUgb3JpZ2luYWwgc2VyaWVzIHN0aWxsCj4gaXNu
J3QgaW4gbWFpbmxpbmUsIGFuZCB0aGF0J3MgYmVjYXVzZSBwZW9wbGUgZG9uJ3QgcG9zdCBhbnkg
bnVtYmVycy4KPiBBZGRpbmcgbW9yZSBwYXRjaGVzIGlzIG5vdCBnb2luZyB0byBjaGFuZ2UgdGhh
dCBzbWFsbCBmYWN0Lgo+IAo+PiBUaGlzIHBhdGNoIGluY3JlYXNlcyB0aGUgbnVtYmVyIG9mIGxw
aV90cmFuc2xhdGlvbl9jYWNoZSB0byBlaWdodCwKPj4gaGFzaGVzIHRoZSBjcHVpZCB0aGF0IGV4
ZWN1dGVzIGlycWZkX3dha2V1cCwgYW5kIGNob29zZXMgd2hpY2gKPj4gbHBpX3RyYW5zbGF0aW9u
X2NhY2hlIHRvIHVzZS4KPiAKPiBTbyB5b3UndmUgbm93IHN3aXRjaGVkIHRvIGEgcGVyLWNhY2hl
IGxvY2ssIG1lYW5pbmcgdGhhdCB0aGUgcmVzdCBvZiB0aGUKPiBJVFMgY29kZSBjYW4gbWFuaXB1
bGF0ZSB0aGUgdGhlIGxwaV9saXN0IHdpdGhvdXQgc3luY2hyb25pemF0aW9uIHdpdGgKPiB0aGUg
Y2FjaGVzLiBIYXZlIHlvdSB3b3JrZWQgb3V0IGFsbCB0aGUgcG9zc2libGUgcmFjZXM/IEFsc28s
IGhvdyBkb2VzCj4gdGhpcyBuZXcgbG9jayBjbGFzcyBmaXRzIGluIHRoZSB3aG9sZSBsb2NraW5n
IGhpZXJhcmNoeT8KPiAKPiBJZiB5b3Ugd2FudCBzb21ldGhpbmcgdGhhdCBpcyBhY3R1YWxseSBz
Y2FsYWJsZSwgZG8gaXQgdGhlIHJpZ2h0IHdheS4KPiBVc2UgYSBiZXR0ZXIgZGF0YSBzdHJ1Y3R1
cmUgdGhhbiBhIGxpc3QsIHN3aXRjaCB0byB1c2luZyBSQ1UgcmF0aGVyIHRoYW4KPiB0aGUgY3Vy
cmVudCBsb2NraW5nIHN0cmF0ZWd5LiBCdXQgeW91ciBjdXJyZW50IGFwcHJvYWNoIGxvb2tzIHF1
aXRlIGZyYWdpbGUuCj4gCj4gVGhhbmtzLAo+IAo+IAlNLgo+IAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1A
bGlzdHMuY3MuY29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxt
YW4vbGlzdGluZm8va3ZtYXJtCg==
