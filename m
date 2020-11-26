Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D92C57F0
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 16:17:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D73174C01B;
	Thu, 26 Nov 2020 10:17:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qpau4q79Mwgb; Thu, 26 Nov 2020 10:17:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A4BED4C006;
	Thu, 26 Nov 2020 10:17:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 946134C001
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 10:17:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CLvPXti6thbp for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 10:17:32 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 468EB4BFFB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 10:17:32 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E36CB31B;
 Thu, 26 Nov 2020 07:17:31 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B103F71F;
 Thu, 26 Nov 2020 07:17:31 -0800 (PST)
Subject: Re: [PATCH 6/8] KVM: arm64: Remove dead PMU sysreg decoding code
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20201113182602.471776-1-maz@kernel.org>
 <20201113182602.471776-7-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <1ed6dfd6-4ace-a562-bc2f-054a5c853fa6@arm.com>
Date: Thu, 26 Nov 2020 15:18:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113182602.471776-7-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com
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

SGkgTWFyYywKCkkgY2hlY2tlZCBhbmQgaW5kZWVkIHRoZSByZW1haW5pbmcgY2FzZXMgY292ZXIg
YWxsIHJlZ2lzdGVycyB0aGF0IHVzZSB0aGlzIGFjY2Vzc29yLgoKSG93ZXZlciwgSSdtIGEgYml0
IHRvcm4gaGVyZS4gVGhlIHdhcm5pbmcgdGhhdCBJIGdvdCB3aGVuIHRyeWluZyB0byBydW4gYSBn
dWVzdAp3aXRoIHRoZSBQTVUgZmVhdHVyZSBmbGFnIHNldCwgYnV0IG5vdCBpbml0aWFsaXplZCAo
cmVwb3J0ZWQgYXQgWzFdKSB3YXMgYWxzbyBub3QKc3VwcG9zZWQgdG8gZXZlciBiZSByZWFjaGVk
OgoKc3RhdGljIHUzMiBrdm1fcG11X2V2ZW50X21hc2soc3RydWN0IGt2bSAqa3ZtKQp7CsKgwqDC
oCBzd2l0Y2ggKGt2bS0+YXJjaC5wbXV2ZXIpIHsKwqDCoMKgIGNhc2UgMTrCoMKgwqAgwqDCoMKg
IMKgwqDCoCAvKiBBUk12OC4wICovCsKgwqDCoCDCoMKgwqAgcmV0dXJuIEdFTk1BU0soOSwgMCk7
CsKgwqDCoCBjYXNlIDQ6wqDCoMKgIMKgwqDCoCDCoMKgwqAgLyogQVJNdjguMSAqLwrCoMKgwqAg
Y2FzZSA1OsKgwqDCoCDCoMKgwqAgwqDCoMKgIC8qIEFSTXY4LjQgKi8KwqDCoMKgIGNhc2UgNjrC
oMKgwqAgwqDCoMKgIMKgwqDCoCAvKiBBUk12OC41ICovCsKgwqDCoCDCoMKgwqAgcmV0dXJuIEdF
Tk1BU0soMTUsIDApOwrCoMKgwqAgZGVmYXVsdDrCoMKgwqAgwqDCoMKgIC8qIFNob3VsZG4ndCBi
ZSBoZXJlLCBqdXN0IGZvciBzYW5pdHkgKi8KwqDCoMKgIMKgwqDCoCBXQVJOX09OQ0UoMSwgIlVu
a25vd24gUE1VIHZlcnNpb24gJWRcbiIsIGt2bS0+YXJjaC5wbXV2ZXIpOwrCoMKgwqAgwqDCoMKg
IHJldHVybiAwOwrCoMKgwqAgfQp9CgpJIHJlYWxpemUgaXQncyBub3QgZXhhY3RseSB0aGUgc2Ft
ZSB0aGluZyBhbmQgSSdsbCBsZWF2ZSBpdCB1cCB0byB5b3UgaWYgeW91IHdhbnQKdG8gYWRkIGEg
d2FybmluZyBmb3IgdGhlIGNhc2VzIHRoYXQgc2hvdWxkIG5ldmVyIGhhcHBlbi4gSSdtIGZpbmUg
ZWl0aGVyIHdheToKClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgRWxpc2VpIDxhbGV4YW5kcnUuZWxp
c2VpQGFybS5jb20+CgpbMV0gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvYXJtLWtlcm5l
bC9tc2c4NTc5MjcuaHRtbAoKT24gMTEvMTMvMjAgNjoyNiBQTSwgTWFyYyBaeW5naWVyIHdyb3Rl
Ogo+IFRoZSBoYW5kbGluZyBvZiB0cmFwcyBpbiBhY2Nlc3NfcG11X2V2Y250cigpIGhhcyBhIGNv
dXBsZSBvZgo+IG9tbWlub3VzICJlbHNlIHJldHVybiBmYWxzZTsiIHN0YXRlbWVudHMgdGhhdCBk
b24ndCBtYWtlIGFueSBzZW5zZToKPiB0aGUgZGVjb2RpbmcgdHJlZSBjb3ZlcnNlIGFsbCB0aGUg
cmVnaXN0ZXJzIHRoYXQgdHJhcCB0byB0aGlzIGhhbmRsZXIsCj4gYW5kIHJldHVybmluZyBmYWxz
ZSBpbXBsaWVzIHRoYXQgd2UgY2hhbmdlIFBDLCB3aGljaCB3ZSBkb24ndC4KPgo+IEdldCByaWQg
b2Ygd2hhdCBpcyBldmlkZW50bHkgZGVhZCBjb2RlLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWFyYyBa
eW5naWVyIDxtYXpAa2VybmVsLm9yZz4KPiAtLS0KPiAgYXJjaC9hcm02NC9rdm0vc3lzX3JlZ3Mu
YyB8IDQgLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2t2bS9zeXNfcmVncy5jIGIvYXJjaC9hcm02NC9rdm0vc3lzX3JlZ3Mu
Ywo+IGluZGV4IDNiZDRjYzQwNTM2Yi4uZjg3OGQ3MTQ4NGQ4IDEwMDY0NAo+IC0tLSBhL2FyY2gv
YXJtNjQva3ZtL3N5c19yZWdzLmMKPiArKysgYi9hcmNoL2FybTY0L2t2bS9zeXNfcmVncy5jCj4g
QEAgLTczMyw4ICs3MzMsNiBAQCBzdGF0aWMgYm9vbCBhY2Nlc3NfcG11X2V2Y250cihzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUsCj4gIAkJCQlyZXR1cm4gZmFsc2U7Cj4gIAo+ICAJCQlpZHggPSBBUk1W
OF9QTVVfQ1lDTEVfSURYOwo+IC0JCX0gZWxzZSB7Cj4gLQkJCXJldHVybiBmYWxzZTsKPiAgCQl9
Cj4gIAl9IGVsc2UgaWYgKHItPkNSbiA9PSAwICYmIHItPkNSbSA9PSA5KSB7Cj4gIAkJLyogUE1D
Q05UUiAqLwo+IEBAIC03NDgsOCArNzQ2LDYgQEAgc3RhdGljIGJvb2wgYWNjZXNzX3BtdV9ldmNu
dHIoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAo+ICAJCQlyZXR1cm4gZmFsc2U7Cj4gIAo+ICAJCWlk
eCA9ICgoci0+Q1JtICYgMykgPDwgMykgfCAoci0+T3AyICYgNyk7Cj4gLQl9IGVsc2Ugewo+IC0J
CXJldHVybiBmYWxzZTsKPiAgCX0KPiAgCj4gIAlpZiAoIXBtdV9jb3VudGVyX2lkeF92YWxpZCh2
Y3B1LCBpZHgpKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6
Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
