Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3985F1CF333
	for <lists+kvmarm@lfdr.de>; Tue, 12 May 2020 13:17:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B64994B137;
	Tue, 12 May 2020 07:17:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-6+c5zms10l; Tue, 12 May 2020 07:17:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B99D4B12B;
	Tue, 12 May 2020 07:17:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D6D884B0E7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 May 2020 07:17:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SHLRjZXJ0C5U for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 May 2020 07:17:34 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6BE634B0C8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 May 2020 07:17:34 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1524630E;
 Tue, 12 May 2020 04:17:34 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1108F3F71E;
 Tue, 12 May 2020 04:17:31 -0700 (PDT)
Subject: Re: [PATCH 03/26] KVM: arm64: Factor out stage 2 page table data from
 struct kvm
To: Alexandru Elisei <alexandru.elisei@arm.com>, Marc Zyngier <maz@kernel.org>
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-4-maz@kernel.org>
 <a7c8207c-9061-ad0e-c9f8-64c995e928b6@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <76d811eb-b304-c49f-1f21-fe9d95112a28@arm.com>
Date: Tue, 12 May 2020 12:17:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a7c8207c-9061-ad0e-c9f8-64c995e928b6@arm.com>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 kvmarm@lists.cs.columbia.edu, George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
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

SGkgQWxleCwgTWFyYywKCihqdXN0IG9uIHRoaXMgbGFzdF92Y3B1X3JhbiB0aGluZy4uLikKCk9u
IDExLzA1LzIwMjAgMTc6MzgsIEFsZXhhbmRydSBFbGlzZWkgd3JvdGU6Cj4gT24gNC8yMi8yMCAx
OjAwIFBNLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+IEZyb206IENocmlzdG9mZmVyIERhbGwgPGNo
cmlzdG9mZmVyLmRhbGxAYXJtLmNvbT4KPj4KPj4gQXMgd2UgYXJlIGFib3V0IHRvIHJldXNlIG91
ciBzdGFnZSAyIHBhZ2UgdGFibGUgbWFuaXB1bGF0aW9uIGNvZGUgZm9yCj4+IHNoYWRvdyBzdGFn
ZSAyIHBhZ2UgdGFibGVzIGluIHRoZSBjb250ZXh0IG9mIG5lc3RlZCB2aXJ0dWFsaXphdGlvbiwg
d2UKPj4gYXJlIGdvaW5nIHRvIG1hbmFnZSBtdWx0aXBsZSBzdGFnZSAyIHBhZ2UgdGFibGVzIGZv
ciBhIHNpbmdsZSBWTS4KPj4KPj4gVGhpcyByZXF1aXJlcyBzb21lIHByZXR0eSBpbnZhc2l2ZSBj
aGFuZ2VzIHRvIG91ciBkYXRhIHN0cnVjdHVyZXMsCj4+IHdoaWNoIG1vdmVzIHRoZSB2bWlkIGFu
ZCBwZ2QgcG9pbnRlcnMgaW50byBhIHNlcGFyYXRlIHN0cnVjdHVyZSBhbmQKPj4gY2hhbmdlIHBy
ZXR0eSBtdWNoIGFsbCBvZiBvdXIgbW11IGNvZGUgdG8gb3BlcmF0ZSBvbiB0aGlzIHN0cnVjdHVy
ZQo+PiBpbnN0ZWFkLgo+Pgo+PiBUaGUgbmV3IHN0cnVjdHVyZSBpcyBjYWxsZWQgc3RydWN0IGt2
bV9zMl9tbXUuCj4+Cj4+IFRoZXJlIGlzIG5vIGludGVuZGVkIGZ1bmN0aW9uYWwgY2hhbmdlIGJ5
IHRoaXMgcGF0Y2ggYWxvbmUuCgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9rdm1faG9zdC5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCj4+IGluZGV4
IDdkZDhmZWZhNmFlY2QuLjY2NGE1ZDkyYWU5YjggMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+PiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2
bV9ob3N0LmgKPj4gQEAgLTYzLDE5ICs2MywzMiBAQCBzdHJ1Y3Qga3ZtX3ZtaWQgewo+PiAgCXUz
MiAgICB2bWlkOwo+PiAgfTsKPj4gIAo+PiAtc3RydWN0IGt2bV9hcmNoIHsKPj4gK3N0cnVjdCBr
dm1fczJfbW11IHsKPj4gIAlzdHJ1Y3Qga3ZtX3ZtaWQgdm1pZDsKPj4gIAo+PiAtCS8qIHN0YWdl
MiBlbnRyeSBsZXZlbCB0YWJsZSAqLwo+PiAtCXBnZF90ICpwZ2Q7Cj4+IC0JcGh5c19hZGRyX3Qg
cGdkX3BoeXM7Cj4+IC0KPj4gLQkvKiBWVENSX0VMMiB2YWx1ZSBmb3IgdGhpcyBWTSAqLwo+PiAt
CXU2NCAgICB2dGNyOwo+PiArCS8qCj4+ICsJICogc3RhZ2UyIGVudHJ5IGxldmVsIHRhYmxlCj4+
ICsJICoKPj4gKwkgKiBUd28ga3ZtX3MyX21tdSBzdHJ1Y3R1cmVzIGluIHRoZSBzYW1lIFZNIGNh
biBwb2ludCB0byB0aGUgc2FtZSBwZ2QKPj4gKwkgKiBoZXJlLiAgVGhpcyBoYXBwZW5zIHdoZW4g
cnVubmluZyBhIG5vbi1WSEUgZ3Vlc3QgaHlwZXJ2aXNvciB3aGljaAo+PiArCSAqIHVzZXMgdGhl
IGNhbm9uaWNhbCBzdGFnZSAyIHBhZ2UgdGFibGUgZm9yIGJvdGggdkVMMiBhbmQgZm9yIHZFTDEv
MAo+PiArCSAqIHdpdGggdkhDUl9FTDIuVk0gPT0gMC4KPiAKPiBJdCBtYWtlcyBtb3JlIHNlbnNl
IHRvIG1lIHRvIHNheSB0aGF0IGEgbm9uLVZIRSBndWVzdCBoeXBlcnZpc29yIHdpbGwgdXNlIHRo
ZQo+IGNhbm9uaWNhbCBzdGFnZSAqMSogcGFnZSB0YWJsZSB3aGVuIHJ1bm5pbmcgYXQgRUwyCgpD
YW4gS1ZNIHNheSBhbnl0aGluZyBhYm91dCBzdGFnZTE/IEl0cyB0b3RhbGx5IHVuZGVyIHRoZSB0
aGUgZ3Vlc3RzIGNvbnRyb2wgZXZlbiBhdCB2RUwyLi4uCgoKPiAodGhlICJOb24tc2VjdXJlIEVM
MiB0cmFuc2xhdGlvbiByZWdpbWUiIGFzIEFSTSBEREkgMDQ4N0YuYiBjYWxscyBpdCBvbiBwYWdl
IEQ1LTI1NDMpLgoKPiBJIHRoaW5rIHRoYXQncwo+IHRoZSBvbmx5IHNpdHVhdGlvbiB3aGVyZSB2
RUwyIGFuZCB2RUwxJjAgd2lsbCB1c2UgdGhlIHNhbWUgTDAgc3RhZ2UgMiB0YWJsZXMuIEl0J3MK
PiBiZWVuIHF1aXRlIHNvbWUgdGltZSBzaW5jZSBJIHJldmlld2VkIHRoZSBpbml0aWFsIHZlcnNp
b24gb2YgdGhlIE5WIHBhdGNoZXMsIGRpZCBJCj4gZ2V0IHRoYXQgd3Jvbmc/CgoKPj4gKwkgKi8K
Pj4gKwlwZ2RfdAkJKnBnZDsKPj4gKwlwaHlzX2FkZHJfdAlwZ2RfcGh5czsKPj4gIAo+PiAgCS8q
IFRoZSBsYXN0IHZjcHUgaWQgdGhhdCByYW4gb24gZWFjaCBwaHlzaWNhbCBDUFUgKi8KPj4gIAlp
bnQgX19wZXJjcHUgKmxhc3RfdmNwdV9yYW47Cj4gCj4gSXQgbWFrZXMgc2Vuc2UgZm9yIHRoZSBv
dGhlciBmaWVsZHMgdG8gYmUgcGFydCBvZiBrdm1fczJfbW11LCBidXQgSSdtIHN0cnVnZ2xpbmcK
PiB0byBmaWd1cmUgb3V0IHdoeSBsYXN0X3ZjcHVfcmFuIGlzIGhlcmUuIFdvdWxkIHlvdSBtaW5k
IHNoYXJpbmcgdGhlIHJhdGlvbmFsZT8gSQo+IGRvbid0IHNlZSB0aGlzIGNoYW5nZSBpbiB2MSBv
ciB2MiBvZiB0aGUgTlYgc2VyaWVzLgoKTWFyYyBtYXkgaGF2ZSBhIGJldHRlciByYXRpb25hbGUu
IE15IHRoaW5raW5nIHdhcyBiZWNhdXNlIGt2bV92bWlkIGlzIGluIGhlcmUgdG9vLgoKbGFzdF92
Y3B1X3JhbiBleGlzdHMgdG8gcHJldmVudCBLVk0gYWNjaWRlbnRhbGx5IGVtdWxhdGluZyBDTlAg
d2l0aG91dCB0aGUgb3B0LWluLiAod2UKY2FsbCBpdCBkZWZhY3RvIENOUCkuCgpUaGUgZ3Vlc3Qg
bWF5IGV4cGVjdCB0byBiZSBhYmxlIHRvIHVzZSBhc2lkLTQgd2l0aCBkaWZmZXJlbnQgcGFnZSB0
YWJsZXMgb24gZGlmZmVyZW50CnZDUFVzLCBhc3N1bWluZyB0aGUgVExCIGlzbid0IHNoYXJlZC4g
QnV0IGlmIEtWTSBpcyBzd2l0Y2hpbmcgYmV0d2VlbiB0aG9zZSB2Q1BVIG9uIG9uZQpwaHlzaWNh
bCBDUFUsIHRoZSBUTEIgaXMgc2hhcmVkLCAuLi4gdGhlIFZNSUQgYW5kIEFTSUQgYXJlIHRoZSBz
YW1lLCBidXQgdGhlIHBhZ2UgdGFibGVzCmFyZSBub3QuIE5vdCBmdW4gdG8gZGVidWchCgoKTlYg
bWFrZXMgdGhpcyBwcm9ibGVtIHBlci1zdGFnZTIsIGJlY2F1c2UgZWFjaCBzdGFnZTIgaGFzIGl0
cyBvd24gVk1JRCwgd2UgbmVlZCB0byB0cmFjawp0aGUgdmNwdV9pZCB0aGF0IGxhc3QgcmFuIHRo
aXMgc3RhZ2UyIG9uIHRoaXMgcGh5c2ljYWwgQ1BVLiBJZiBpdHMgbm90IHRoZSBzYW1lLCB3ZSBu
ZWVkCnRvIGJsb3cgYXdheSB0aGlzIFZNSURzIFRMQiBlbnRyaWVzLgoKVGhlIHdvcmthcm91bmQg
bGl2ZXMgaW4gdmlydC9rdm0vYXJtL2FybS5jOjprdm1fYXJjaF92Y3B1X2xvYWQoKQoKCj4gTW9y
ZSBiZWxvdy4KCihsaWdodGx5IHRyaW1tZWQhKQoKVGhhbmtzLAoKSmFtZXMKCgo+PiAgCj4+ICsJ
c3RydWN0IGt2bSAqa3ZtOwo+PiArfTsKClsuLi5dCgo+PiBkaWZmIC0tZ2l0IGEvdmlydC9rdm0v
YXJtL2FybS5jIGIvdmlydC9rdm0vYXJtL2FybS5jCj4+IGluZGV4IDUzYjNiYTkxNzNiYTcuLjAz
ZjAxZmNmYTJiZDUgMTAwNjQ0Cj4+IC0tLSBhL3ZpcnQva3ZtL2FybS9hcm0uYwo+PiArKysgYi92
aXJ0L2t2bS9hcm0vYXJtLmMKPiAKPiBUaGVyZSdzIGEgY29tbWVudCB0aGF0IHN0aWxsIG1lbnRp
b25zIGFyY2gudm1pZCB0aGF0IHlvdSBtaXNzZWQgaW4gdGhpcyBmaWxlOgo+IAo+IHN0YXRpYyBi
b29sIG5lZWRfbmV3X3ZtaWRfZ2VuKHN0cnVjdCBrdm1fdm1pZCAqdm1pZCkKPiB7Cj4gwqDCoMKg
IHU2NCBjdXJyZW50X3ZtaWRfZ2VuID0gYXRvbWljNjRfcmVhZCgma3ZtX3ZtaWRfZ2VuKTsKPiDC
oMKgwqAgc21wX3JtYigpOyAvKiBPcmRlcnMgcmVhZCBvZiBrdm1fdm1pZF9nZW4gYW5kIGt2bS0+
YXJjaC52bWlkICovCj4gCgpbLi5dCgo+PiBkaWZmIC0tZ2l0IGEvdmlydC9rdm0vYXJtL21tdS5j
IGIvdmlydC9rdm0vYXJtL21tdS5jCj4+IGluZGV4IGUzYjllZTI2ODgyM2IuLjJmOTk3NDkwNDgy
ODUgMTAwNjQ0Cj4+IC0tLSBhL3ZpcnQva3ZtL2FybS9tbXUuYwo+PiArKysgYi92aXJ0L2t2bS9h
cm0vbW11LmMKCj4+IEBAIC04ODYsMjEgKzg5OCwyMyBAQCBpbnQgY3JlYXRlX2h5cF9leGVjX21h
cHBpbmdzKHBoeXNfYWRkcl90IHBoeXNfYWRkciwgc2l6ZV90IHNpemUsCj4+ICB9Cj4+ICAKPj4g
IC8qKgo+PiAtICoga3ZtX2FsbG9jX3N0YWdlMl9wZ2QgLSBhbGxvY2F0ZSBsZXZlbC0xIHRhYmxl
IGZvciBzdGFnZS0yIHRyYW5zbGF0aW9uLgo+PiAtICogQGt2bToJVGhlIEtWTSBzdHJ1Y3QgcG9p
bnRlciBmb3IgdGhlIFZNLgo+PiArICoga3ZtX2luaXRfc3RhZ2UyX21tdSAtIEluaXRpYWxpc2Ug
YSBTMiBNTVUgc3RydWNydXJlCj4+ICsgKiBAa3ZtOglUaGUgcG9pbnRlciB0byB0aGUgS1ZNIHN0
cnVjdHVyZQo+PiArICogQG1tdToJVGhlIHBvaW50ZXIgdG8gdGhlIHMyIE1NVSBzdHJ1Y3R1cmUK
Pj4gICAqCj4+ICAgKiBBbGxvY2F0ZXMgb25seSB0aGUgc3RhZ2UtMiBIVyBQR0QgbGV2ZWwgdGFi
bGUocykgb2Ygc2l6ZSBkZWZpbmVkIGJ5Cj4+IC0gKiBzdGFnZTJfcGdkX3NpemUoa3ZtKS4KPj4g
KyAqIHN0YWdlMl9wZ2Rfc2l6ZShtbXUtPmt2bSkuCj4+ICAgKgo+PiAgICogTm90ZSB3ZSBkb24n
dCBuZWVkIGxvY2tpbmcgaGVyZSBhcyB0aGlzIGlzIG9ubHkgY2FsbGVkIHdoZW4gdGhlIFZNIGlz
Cj4+ICAgKiBjcmVhdGVkLCB3aGljaCBjYW4gb25seSBiZSBkb25lIG9uY2UuCj4+ICAgKi8KPj4g
LWludCBrdm1fYWxsb2Nfc3RhZ2UyX3BnZChzdHJ1Y3Qga3ZtICprdm0pCj4+ICtpbnQga3ZtX2lu
aXRfc3RhZ2UyX21tdShzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fczJfbW11ICptbXUpCj4+
ICB7Cj4+ICAJcGh5c19hZGRyX3QgcGdkX3BoeXM7Cj4+ICAJcGdkX3QgKnBnZDsKPj4gKwlpbnQg
Y3B1Owo+PiAgCj4+IC0JaWYgKGt2bS0+YXJjaC5wZ2QgIT0gTlVMTCkgewo+PiArCWlmIChtbXUt
PnBnZCAhPSBOVUxMKSB7Cj4+ICAJCWt2bV9lcnIoImt2bV9hcmNoIGFscmVhZHkgaW5pdGlhbGl6
ZWQ/XG4iKTsKPj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4+ICAJfQo+PiBAQCAtOTE0LDggKzkyOCwy
MCBAQCBpbnQga3ZtX2FsbG9jX3N0YWdlMl9wZ2Qoc3RydWN0IGt2bSAqa3ZtKQo+PiAgCWlmIChX
QVJOX09OKHBnZF9waHlzICYgfmt2bV92dHRicl9iYWRkcl9tYXNrKGt2bSkpKQoKPiBXZSBkb24n
dCBmcmVlIHRoZSBwZ2QgaGVyZSwgYnV0IHdlIGRvIGZyZWUgaXQgaWYgYWxsb2NfcGVyY3B1IGZh
aWxzLiBJcyB0aGF0Cj4gaW50ZW50aW9uYWw/CgoKPj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4+ICAK
Pj4gLQlrdm0tPmFyY2gucGdkID0gcGdkOwo+PiAtCWt2bS0+YXJjaC5wZ2RfcGh5cyA9IHBnZF9w
aHlzOwo+PiArCW1tdS0+bGFzdF92Y3B1X3JhbiA9IGFsbG9jX3BlcmNwdSh0eXBlb2YoKm1tdS0+
bGFzdF92Y3B1X3JhbikpOwo+PiArCWlmICghbW11LT5sYXN0X3ZjcHVfcmFuKSB7Cj4+ICsJCWZy
ZWVfcGFnZXNfZXhhY3QocGdkLCBzdGFnZTJfcGdkX3NpemUoa3ZtKSk7Cj4+ICsJCXJldHVybiAt
RU5PTUVNOwo+PiArCX0KPj4gKwo+PiArCWZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpCj4+ICsJ
CSpwZXJfY3B1X3B0cihtbXUtPmxhc3RfdmNwdV9yYW4sIGNwdSkgPSAtMTsKPj4gKwo+PiArCW1t
dS0+a3ZtID0ga3ZtOwo+PiArCW1tdS0+cGdkID0gcGdkOwo+PiArCW1tdS0+cGdkX3BoeXMgPSBw
Z2RfcGh5czsKPj4gKwltbXUtPnZtaWQudm1pZF9nZW4gPSAwOwo+PiArCj4+ICAJcmV0dXJuIDA7
Cj4+ICB9Cj4+ICAKCj4+IEBAIC05ODYsMzkgKzEwMTIsMzQgQEAgdm9pZCBzdGFnZTJfdW5tYXBf
dm0oc3RydWN0IGt2bSAqa3ZtKQo+PiAgCXNyY3VfcmVhZF91bmxvY2soJmt2bS0+c3JjdSwgaWR4
KTsKPj4gIH0KPj4gIAo+PiAtLyoqCj4+IC0gKiBrdm1fZnJlZV9zdGFnZTJfcGdkIC0gZnJlZSBh
bGwgc3RhZ2UtMiB0YWJsZXMKPj4gLSAqIEBrdm06CVRoZSBLVk0gc3RydWN0IHBvaW50ZXIgZm9y
IHRoZSBWTS4KPj4gLSAqCj4+IC0gKiBXYWxrcyB0aGUgbGV2ZWwtMSBwYWdlIHRhYmxlIHBvaW50
ZWQgdG8gYnkga3ZtLT5hcmNoLnBnZCBhbmQgZnJlZXMgYWxsCj4+IC0gKiB1bmRlcmx5aW5nIGxl
dmVsLTIgYW5kIGxldmVsLTMgdGFibGVzIGJlZm9yZSBmcmVlaW5nIHRoZSBhY3R1YWwgbGV2ZWwt
MSB0YWJsZQo+PiAtICogYW5kIHNldHRpbmcgdGhlIHN0cnVjdCBwb2ludGVyIHRvIE5VTEwuCj4+
IC0gKi8KPj4gLXZvaWQga3ZtX2ZyZWVfc3RhZ2UyX3BnZChzdHJ1Y3Qga3ZtICprdm0pCj4+ICt2
b2lkIGt2bV9mcmVlX3N0YWdlMl9wZ2Qoc3RydWN0IGt2bV9zMl9tbXUgKm1tdSkKPj4gIHsKPj4g
KwlzdHJ1Y3Qga3ZtICprdm0gPSBtbXUtPmt2bTsKPj4gIAl2b2lkICpwZ2QgPSBOVUxMOwo+PiAg
Cj4+ICAJc3Bpbl9sb2NrKCZrdm0tPm1tdV9sb2NrKTsKPj4gLQlpZiAoa3ZtLT5hcmNoLnBnZCkg
ewo+PiAtCQl1bm1hcF9zdGFnZTJfcmFuZ2Uoa3ZtLCAwLCBrdm1fcGh5c19zaXplKGt2bSkpOwo+
PiAtCQlwZ2QgPSBSRUFEX09OQ0Uoa3ZtLT5hcmNoLnBnZCk7Cj4+IC0JCWt2bS0+YXJjaC5wZ2Qg
PSBOVUxMOwo+PiAtCQlrdm0tPmFyY2gucGdkX3BoeXMgPSAwOwo+PiArCWlmIChtbXUtPnBnZCkg
ewo+PiArCQl1bm1hcF9zdGFnZTJfcmFuZ2UobW11LCAwLCBrdm1fcGh5c19zaXplKGt2bSkpOwo+
PiArCQlwZ2QgPSBSRUFEX09OQ0UobW11LT5wZ2QpOwo+PiArCQltbXUtPnBnZCA9IE5VTEw7Cj4g
Cj4gVGhlIGt2bS0+YXJjaC5wZ2RfcGh5cyA9IDAgaW5zdHJ1Y3Rpb24gc2VlbXMgdG8gaGF2ZSBi
ZWVuIGRyb3BwZWQgaGVyZS4gSXMgdGhhdAo+IGludGVudGlvbmFsPwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFy
bUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFp
bG1hbi9saXN0aW5mby9rdm1hcm0K
