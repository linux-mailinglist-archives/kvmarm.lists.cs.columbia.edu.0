Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 99C0D1CF994
	for <lists+kvmarm@lfdr.de>; Tue, 12 May 2020 17:47:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D5464B125;
	Tue, 12 May 2020 11:47:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gsH8h3avuM4; Tue, 12 May 2020 11:47:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0ACDA4B0C5;
	Tue, 12 May 2020 11:47:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F6C54B08C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 May 2020 11:47:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 256ARG8nwS8c for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 May 2020 11:47:21 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 57A034B08B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 May 2020 11:47:21 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7BA71FB;
 Tue, 12 May 2020 08:47:20 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80A763F305;
 Tue, 12 May 2020 08:47:18 -0700 (PDT)
Subject: Re: [PATCH 03/26] KVM: arm64: Factor out stage 2 page table data from
 struct kvm
To: James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-4-maz@kernel.org>
 <a7c8207c-9061-ad0e-c9f8-64c995e928b6@arm.com>
 <76d811eb-b304-c49f-1f21-fe9d95112a28@arm.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <5134e123-18ec-9b69-2e0a-b83798e01507@arm.com>
Date: Tue, 12 May 2020 16:47:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <76d811eb-b304-c49f-1f21-fe9d95112a28@arm.com>
Content-Language: en-US
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

SGksCgpPbiA1LzEyLzIwIDEyOjE3IFBNLCBKYW1lcyBNb3JzZSB3cm90ZToKPiBIaSBBbGV4LCBN
YXJjLAo+Cj4gKGp1c3Qgb24gdGhpcyBsYXN0X3ZjcHVfcmFuIHRoaW5nLi4uKQo+Cj4gT24gMTEv
MDUvMjAyMCAxNzozOCwgQWxleGFuZHJ1IEVsaXNlaSB3cm90ZToKPj4gT24gNC8yMi8yMCAxOjAw
IFBNLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+PiBGcm9tOiBDaHJpc3RvZmZlciBEYWxsIDxjaHJp
c3RvZmZlci5kYWxsQGFybS5jb20+Cj4+Pgo+Pj4gQXMgd2UgYXJlIGFib3V0IHRvIHJldXNlIG91
ciBzdGFnZSAyIHBhZ2UgdGFibGUgbWFuaXB1bGF0aW9uIGNvZGUgZm9yCj4+PiBzaGFkb3cgc3Rh
Z2UgMiBwYWdlIHRhYmxlcyBpbiB0aGUgY29udGV4dCBvZiBuZXN0ZWQgdmlydHVhbGl6YXRpb24s
IHdlCj4+PiBhcmUgZ29pbmcgdG8gbWFuYWdlIG11bHRpcGxlIHN0YWdlIDIgcGFnZSB0YWJsZXMg
Zm9yIGEgc2luZ2xlIFZNLgo+Pj4KPj4+IFRoaXMgcmVxdWlyZXMgc29tZSBwcmV0dHkgaW52YXNp
dmUgY2hhbmdlcyB0byBvdXIgZGF0YSBzdHJ1Y3R1cmVzLAo+Pj4gd2hpY2ggbW92ZXMgdGhlIHZt
aWQgYW5kIHBnZCBwb2ludGVycyBpbnRvIGEgc2VwYXJhdGUgc3RydWN0dXJlIGFuZAo+Pj4gY2hh
bmdlIHByZXR0eSBtdWNoIGFsbCBvZiBvdXIgbW11IGNvZGUgdG8gb3BlcmF0ZSBvbiB0aGlzIHN0
cnVjdHVyZQo+Pj4gaW5zdGVhZC4KPj4+Cj4+PiBUaGUgbmV3IHN0cnVjdHVyZSBpcyBjYWxsZWQg
c3RydWN0IGt2bV9zMl9tbXUuCj4+Pgo+Pj4gVGhlcmUgaXMgbm8gaW50ZW5kZWQgZnVuY3Rpb25h
bCBjaGFuZ2UgYnkgdGhpcyBwYXRjaCBhbG9uZS4KPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0
LmgKPj4+IGluZGV4IDdkZDhmZWZhNmFlY2QuLjY2NGE1ZDkyYWU5YjggMTAwNjQ0Cj4+PiAtLS0g
YS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKPj4+ICsrKyBiL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+Pj4gQEAgLTYzLDE5ICs2MywzMiBAQCBzdHJ1Y3Qga3Zt
X3ZtaWQgewo+Pj4gIAl1MzIgICAgdm1pZDsKPj4+ICB9Owo+Pj4gIAo+Pj4gLXN0cnVjdCBrdm1f
YXJjaCB7Cj4+PiArc3RydWN0IGt2bV9zMl9tbXUgewo+Pj4gIAlzdHJ1Y3Qga3ZtX3ZtaWQgdm1p
ZDsKPj4+ICAKPj4+IC0JLyogc3RhZ2UyIGVudHJ5IGxldmVsIHRhYmxlICovCj4+PiAtCXBnZF90
ICpwZ2Q7Cj4+PiAtCXBoeXNfYWRkcl90IHBnZF9waHlzOwo+Pj4gLQo+Pj4gLQkvKiBWVENSX0VM
MiB2YWx1ZSBmb3IgdGhpcyBWTSAqLwo+Pj4gLQl1NjQgICAgdnRjcjsKPj4+ICsJLyoKPj4+ICsJ
ICogc3RhZ2UyIGVudHJ5IGxldmVsIHRhYmxlCj4+PiArCSAqCj4+PiArCSAqIFR3byBrdm1fczJf
bW11IHN0cnVjdHVyZXMgaW4gdGhlIHNhbWUgVk0gY2FuIHBvaW50IHRvIHRoZSBzYW1lIHBnZAo+
Pj4gKwkgKiBoZXJlLiAgVGhpcyBoYXBwZW5zIHdoZW4gcnVubmluZyBhIG5vbi1WSEUgZ3Vlc3Qg
aHlwZXJ2aXNvciB3aGljaAo+Pj4gKwkgKiB1c2VzIHRoZSBjYW5vbmljYWwgc3RhZ2UgMiBwYWdl
IHRhYmxlIGZvciBib3RoIHZFTDIgYW5kIGZvciB2RUwxLzAKPj4+ICsJICogd2l0aCB2SENSX0VM
Mi5WTSA9PSAwLgo+PiBJdCBtYWtlcyBtb3JlIHNlbnNlIHRvIG1lIHRvIHNheSB0aGF0IGEgbm9u
LVZIRSBndWVzdCBoeXBlcnZpc29yIHdpbGwgdXNlIHRoZQo+PiBjYW5vbmljYWwgc3RhZ2UgKjEq
IHBhZ2UgdGFibGUgd2hlbiBydW5uaW5nIGF0IEVMMgo+IENhbiBLVk0gc2F5IGFueXRoaW5nIGFi
b3V0IHN0YWdlMT8gSXRzIHRvdGFsbHkgdW5kZXIgdGhlIHRoZSBndWVzdHMgY29udHJvbCBldmVu
IGF0IHZFTDIuLi4KCkl0IGlzLiBNeSBpbnRlcnByZXRhdGlvbiBvZiB0aGUgY29tbWVudCB3YXMg
dGhhdCBpZiB0aGUgZ3Vlc3QgZG9lc24ndCBoYXZlIHZpcnR1YWwKc3RhZ2UgMiBlbmFibGVkICh3
ZSdyZSBub3QgcnVubmluZyBhIGd1ZXN0IG9mIHRoZSBMMSBoeXBlcnZpc29yKSwgdGhlbiB0aGUg
TDAgaG9zdApjYW4gdXNlIHRoZSBzYW1lIEwwIHN0YWdlIDIgdGFibGVzIGJlY2F1c2Ugd2UncmUg
cnVubmluZyB0aGUgc2FtZSBndWVzdCAodGhlIEwxClZNKSwgcmVnYXJkbGVzcyBvZiB0aGUgYWN0
dWFsIGV4Y2VwdGlvbiBsZXZlbCBmb3IgdGhlIGd1ZXN0LiBJZiBJIHJlbWVtYmVyCmNvcnJlY3Rs
eSwgS1ZNIGFzc2lnbnMgZGlmZmVyZW50IHZtaWRzIGZvciBndWVzdHMgcnVubmluZyBhdCB2RUwx
LzAgYW5kIHZFTDIgd2l0aAp2SENSX0VMMi5WTSA9PSAwIGJlY2F1c2UgdGhlIHRyYW5zbGF0aW9u
IHJlZ2ltZXMgYXJlIGRpZmZlcmVudCwgYnV0IGtlZXBzIHRoZSBzYW1lCnRyYW5zbGF0aW9uIHRh
Ymxlcy4KCj4KPgo+PiAodGhlICJOb24tc2VjdXJlIEVMMiB0cmFuc2xhdGlvbiByZWdpbWUiIGFz
IEFSTSBEREkgMDQ4N0YuYiBjYWxscyBpdCBvbiBwYWdlIEQ1LTI1NDMpLgo+PiBJIHRoaW5rIHRo
YXQncwo+PiB0aGUgb25seSBzaXR1YXRpb24gd2hlcmUgdkVMMiBhbmQgdkVMMSYwIHdpbGwgdXNl
IHRoZSBzYW1lIEwwIHN0YWdlIDIgdGFibGVzLiBJdCdzCj4+IGJlZW4gcXVpdGUgc29tZSB0aW1l
IHNpbmNlIEkgcmV2aWV3ZWQgdGhlIGluaXRpYWwgdmVyc2lvbiBvZiB0aGUgTlYgcGF0Y2hlcywg
ZGlkIEkKPj4gZ2V0IHRoYXQgd3Jvbmc/Cj4KPj4+ICsJICovCj4+PiArCXBnZF90CQkqcGdkOwo+
Pj4gKwlwaHlzX2FkZHJfdAlwZ2RfcGh5czsKPj4+ICAKPj4+ICAJLyogVGhlIGxhc3QgdmNwdSBp
ZCB0aGF0IHJhbiBvbiBlYWNoIHBoeXNpY2FsIENQVSAqLwo+Pj4gIAlpbnQgX19wZXJjcHUgKmxh
c3RfdmNwdV9yYW47Cj4+IEl0IG1ha2VzIHNlbnNlIGZvciB0aGUgb3RoZXIgZmllbGRzIHRvIGJl
IHBhcnQgb2Yga3ZtX3MyX21tdSwgYnV0IEknbSBzdHJ1Z2dsaW5nCj4+IHRvIGZpZ3VyZSBvdXQg
d2h5IGxhc3RfdmNwdV9yYW4gaXMgaGVyZS4gV291bGQgeW91IG1pbmQgc2hhcmluZyB0aGUgcmF0
aW9uYWxlPyBJCj4+IGRvbid0IHNlZSB0aGlzIGNoYW5nZSBpbiB2MSBvciB2MiBvZiB0aGUgTlYg
c2VyaWVzLgo+IE1hcmMgbWF5IGhhdmUgYSBiZXR0ZXIgcmF0aW9uYWxlLiBNeSB0aGlua2luZyB3
YXMgYmVjYXVzZSBrdm1fdm1pZCBpcyBpbiBoZXJlIHRvby4KPgo+IGxhc3RfdmNwdV9yYW4gZXhp
c3RzIHRvIHByZXZlbnQgS1ZNIGFjY2lkZW50YWxseSBlbXVsYXRpbmcgQ05QIHdpdGhvdXQgdGhl
IG9wdC1pbi4gKHdlCj4gY2FsbCBpdCBkZWZhY3RvIENOUCkuCj4KPiBUaGUgZ3Vlc3QgbWF5IGV4
cGVjdCB0byBiZSBhYmxlIHRvIHVzZSBhc2lkLTQgd2l0aCBkaWZmZXJlbnQgcGFnZSB0YWJsZXMg
b24gZGlmZmVyZW50CgpJJ20gYWZyYWlkIEkgZG9uJ3Qga25vdyB3aGF0IGFzaWQtNCBpcy4KCj4g
dkNQVXMsIGFzc3VtaW5nIHRoZSBUTEIgaXNuJ3Qgc2hhcmVkLiBCdXQgaWYgS1ZNIGlzIHN3aXRj
aGluZyBiZXR3ZWVuIHRob3NlIHZDUFUgb24gb25lCj4gcGh5c2ljYWwgQ1BVLCB0aGUgVExCIGlz
IHNoYXJlZCwgLi4uIHRoZSBWTUlEIGFuZCBBU0lEIGFyZSB0aGUgc2FtZSwgYnV0IHRoZSBwYWdl
IHRhYmxlcwo+IGFyZSBub3QuIE5vdCBmdW4gdG8gZGVidWchCj4KPgo+IE5WIG1ha2VzIHRoaXMg
cHJvYmxlbSBwZXItc3RhZ2UyLCBiZWNhdXNlIGVhY2ggc3RhZ2UyIGhhcyBpdHMgb3duIFZNSUQs
IHdlIG5lZWQgdG8gdHJhY2sKPiB0aGUgdmNwdV9pZCB0aGF0IGxhc3QgcmFuIHRoaXMgc3RhZ2Uy
IG9uIHRoaXMgcGh5c2ljYWwgQ1BVLiBJZiBpdHMgbm90IHRoZSBzYW1lLCB3ZSBuZWVkCj4gdG8g
YmxvdyBhd2F5IHRoaXMgVk1JRHMgVExCIGVudHJpZXMuCj4KPiBUaGUgd29ya2Fyb3VuZCBsaXZl
cyBpbiB2aXJ0L2t2bS9hcm0vYXJtLmM6Omt2bV9hcmNoX3ZjcHVfbG9hZCgpCgpNYWtlcyBzZW5z
ZSwgdGhhbmsgeW91IGZvciBleHBsYWluaW5nIHRoYXQuCgpUaGFua3MsCkFsZXgKPgo+Cj4+IE1v
cmUgYmVsb3cuCj4gKGxpZ2h0bHkgdHJpbW1lZCEpCj4KPiBUaGFua3MsCj4KPiBKYW1lcwo+Cj4K
Pj4+ICAKPj4+ICsJc3RydWN0IGt2bSAqa3ZtOwo+Pj4gK307Cj4gWy4uLl0KPgo+Pj4gZGlmZiAt
LWdpdCBhL3ZpcnQva3ZtL2FybS9hcm0uYyBiL3ZpcnQva3ZtL2FybS9hcm0uYwo+Pj4gaW5kZXgg
NTNiM2JhOTE3M2JhNy4uMDNmMDFmY2ZhMmJkNSAxMDA2NDQKPj4+IC0tLSBhL3ZpcnQva3ZtL2Fy
bS9hcm0uYwo+Pj4gKysrIGIvdmlydC9rdm0vYXJtL2FybS5jCj4+IFRoZXJlJ3MgYSBjb21tZW50
IHRoYXQgc3RpbGwgbWVudGlvbnMgYXJjaC52bWlkIHRoYXQgeW91IG1pc3NlZCBpbiB0aGlzIGZp
bGU6Cj4+Cj4+IHN0YXRpYyBib29sIG5lZWRfbmV3X3ZtaWRfZ2VuKHN0cnVjdCBrdm1fdm1pZCAq
dm1pZCkKPj4gewo+PiDCoMKgwqAgdTY0IGN1cnJlbnRfdm1pZF9nZW4gPSBhdG9taWM2NF9yZWFk
KCZrdm1fdm1pZF9nZW4pOwo+PiDCoMKgwqAgc21wX3JtYigpOyAvKiBPcmRlcnMgcmVhZCBvZiBr
dm1fdm1pZF9nZW4gYW5kIGt2bS0+YXJjaC52bWlkICovCj4+Cj4gWy4uXQo+Cj4+PiBkaWZmIC0t
Z2l0IGEvdmlydC9rdm0vYXJtL21tdS5jIGIvdmlydC9rdm0vYXJtL21tdS5jCj4+PiBpbmRleCBl
M2I5ZWUyNjg4MjNiLi4yZjk5NzQ5MDQ4Mjg1IDEwMDY0NAo+Pj4gLS0tIGEvdmlydC9rdm0vYXJt
L21tdS5jCj4+PiArKysgYi92aXJ0L2t2bS9hcm0vbW11LmMKPj4+IEBAIC04ODYsMjEgKzg5OCwy
MyBAQCBpbnQgY3JlYXRlX2h5cF9leGVjX21hcHBpbmdzKHBoeXNfYWRkcl90IHBoeXNfYWRkciwg
c2l6ZV90IHNpemUsCj4+PiAgfQo+Pj4gIAo+Pj4gIC8qKgo+Pj4gLSAqIGt2bV9hbGxvY19zdGFn
ZTJfcGdkIC0gYWxsb2NhdGUgbGV2ZWwtMSB0YWJsZSBmb3Igc3RhZ2UtMiB0cmFuc2xhdGlvbi4K
Pj4+IC0gKiBAa3ZtOglUaGUgS1ZNIHN0cnVjdCBwb2ludGVyIGZvciB0aGUgVk0uCj4+PiArICog
a3ZtX2luaXRfc3RhZ2UyX21tdSAtIEluaXRpYWxpc2UgYSBTMiBNTVUgc3RydWNydXJlCj4+PiAr
ICogQGt2bToJVGhlIHBvaW50ZXIgdG8gdGhlIEtWTSBzdHJ1Y3R1cmUKPj4+ICsgKiBAbW11OglU
aGUgcG9pbnRlciB0byB0aGUgczIgTU1VIHN0cnVjdHVyZQo+Pj4gICAqCj4+PiAgICogQWxsb2Nh
dGVzIG9ubHkgdGhlIHN0YWdlLTIgSFcgUEdEIGxldmVsIHRhYmxlKHMpIG9mIHNpemUgZGVmaW5l
ZCBieQo+Pj4gLSAqIHN0YWdlMl9wZ2Rfc2l6ZShrdm0pLgo+Pj4gKyAqIHN0YWdlMl9wZ2Rfc2l6
ZShtbXUtPmt2bSkuCj4+PiAgICoKPj4+ICAgKiBOb3RlIHdlIGRvbid0IG5lZWQgbG9ja2luZyBo
ZXJlIGFzIHRoaXMgaXMgb25seSBjYWxsZWQgd2hlbiB0aGUgVk0gaXMKPj4+ICAgKiBjcmVhdGVk
LCB3aGljaCBjYW4gb25seSBiZSBkb25lIG9uY2UuCj4+PiAgICovCj4+PiAtaW50IGt2bV9hbGxv
Y19zdGFnZTJfcGdkKHN0cnVjdCBrdm0gKmt2bSkKPj4+ICtpbnQga3ZtX2luaXRfc3RhZ2UyX21t
dShzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fczJfbW11ICptbXUpCj4+PiAgewo+Pj4gIAlw
aHlzX2FkZHJfdCBwZ2RfcGh5czsKPj4+ICAJcGdkX3QgKnBnZDsKPj4+ICsJaW50IGNwdTsKPj4+
ICAKPj4+IC0JaWYgKGt2bS0+YXJjaC5wZ2QgIT0gTlVMTCkgewo+Pj4gKwlpZiAobW11LT5wZ2Qg
IT0gTlVMTCkgewo+Pj4gIAkJa3ZtX2Vycigia3ZtX2FyY2ggYWxyZWFkeSBpbml0aWFsaXplZD9c
biIpOwo+Pj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4+PiAgCX0KPj4+IEBAIC05MTQsOCArOTI4LDIw
IEBAIGludCBrdm1fYWxsb2Nfc3RhZ2UyX3BnZChzdHJ1Y3Qga3ZtICprdm0pCj4+PiAgCWlmIChX
QVJOX09OKHBnZF9waHlzICYgfmt2bV92dHRicl9iYWRkcl9tYXNrKGt2bSkpKQo+PiBXZSBkb24n
dCBmcmVlIHRoZSBwZ2QgaGVyZSwgYnV0IHdlIGRvIGZyZWUgaXQgaWYgYWxsb2NfcGVyY3B1IGZh
aWxzLiBJcyB0aGF0Cj4+IGludGVudGlvbmFsPwo+Cj4+PiAgCQlyZXR1cm4gLUVJTlZBTDsKPj4+
ICAKPj4+IC0Ja3ZtLT5hcmNoLnBnZCA9IHBnZDsKPj4+IC0Ja3ZtLT5hcmNoLnBnZF9waHlzID0g
cGdkX3BoeXM7Cj4+PiArCW1tdS0+bGFzdF92Y3B1X3JhbiA9IGFsbG9jX3BlcmNwdSh0eXBlb2Yo
Km1tdS0+bGFzdF92Y3B1X3JhbikpOwo+Pj4gKwlpZiAoIW1tdS0+bGFzdF92Y3B1X3Jhbikgewo+
Pj4gKwkJZnJlZV9wYWdlc19leGFjdChwZ2QsIHN0YWdlMl9wZ2Rfc2l6ZShrdm0pKTsKPj4+ICsJ
CXJldHVybiAtRU5PTUVNOwo+Pj4gKwl9Cj4+PiArCj4+PiArCWZvcl9lYWNoX3Bvc3NpYmxlX2Nw
dShjcHUpCj4+PiArCQkqcGVyX2NwdV9wdHIobW11LT5sYXN0X3ZjcHVfcmFuLCBjcHUpID0gLTE7
Cj4+PiArCj4+PiArCW1tdS0+a3ZtID0ga3ZtOwo+Pj4gKwltbXUtPnBnZCA9IHBnZDsKPj4+ICsJ
bW11LT5wZ2RfcGh5cyA9IHBnZF9waHlzOwo+Pj4gKwltbXUtPnZtaWQudm1pZF9nZW4gPSAwOwo+
Pj4gKwo+Pj4gIAlyZXR1cm4gMDsKPj4+ICB9Cj4+PiAgCj4+PiBAQCAtOTg2LDM5ICsxMDEyLDM0
IEBAIHZvaWQgc3RhZ2UyX3VubWFwX3ZtKHN0cnVjdCBrdm0gKmt2bSkKPj4+ICAJc3JjdV9yZWFk
X3VubG9jaygma3ZtLT5zcmN1LCBpZHgpOwo+Pj4gIH0KPj4+ICAKPj4+IC0vKioKPj4+IC0gKiBr
dm1fZnJlZV9zdGFnZTJfcGdkIC0gZnJlZSBhbGwgc3RhZ2UtMiB0YWJsZXMKPj4+IC0gKiBAa3Zt
OglUaGUgS1ZNIHN0cnVjdCBwb2ludGVyIGZvciB0aGUgVk0uCj4+PiAtICoKPj4+IC0gKiBXYWxr
cyB0aGUgbGV2ZWwtMSBwYWdlIHRhYmxlIHBvaW50ZWQgdG8gYnkga3ZtLT5hcmNoLnBnZCBhbmQg
ZnJlZXMgYWxsCj4+PiAtICogdW5kZXJseWluZyBsZXZlbC0yIGFuZCBsZXZlbC0zIHRhYmxlcyBi
ZWZvcmUgZnJlZWluZyB0aGUgYWN0dWFsIGxldmVsLTEgdGFibGUKPj4+IC0gKiBhbmQgc2V0dGlu
ZyB0aGUgc3RydWN0IHBvaW50ZXIgdG8gTlVMTC4KPj4+IC0gKi8KPj4+IC12b2lkIGt2bV9mcmVl
X3N0YWdlMl9wZ2Qoc3RydWN0IGt2bSAqa3ZtKQo+Pj4gK3ZvaWQga3ZtX2ZyZWVfc3RhZ2UyX3Bn
ZChzdHJ1Y3Qga3ZtX3MyX21tdSAqbW11KQo+Pj4gIHsKPj4+ICsJc3RydWN0IGt2bSAqa3ZtID0g
bW11LT5rdm07Cj4+PiAgCXZvaWQgKnBnZCA9IE5VTEw7Cj4+PiAgCj4+PiAgCXNwaW5fbG9jaygm
a3ZtLT5tbXVfbG9jayk7Cj4+PiAtCWlmIChrdm0tPmFyY2gucGdkKSB7Cj4+PiAtCQl1bm1hcF9z
dGFnZTJfcmFuZ2Uoa3ZtLCAwLCBrdm1fcGh5c19zaXplKGt2bSkpOwo+Pj4gLQkJcGdkID0gUkVB
RF9PTkNFKGt2bS0+YXJjaC5wZ2QpOwo+Pj4gLQkJa3ZtLT5hcmNoLnBnZCA9IE5VTEw7Cj4+PiAt
CQlrdm0tPmFyY2gucGdkX3BoeXMgPSAwOwo+Pj4gKwlpZiAobW11LT5wZ2QpIHsKPj4+ICsJCXVu
bWFwX3N0YWdlMl9yYW5nZShtbXUsIDAsIGt2bV9waHlzX3NpemUoa3ZtKSk7Cj4+PiArCQlwZ2Qg
PSBSRUFEX09OQ0UobW11LT5wZ2QpOwo+Pj4gKwkJbW11LT5wZ2QgPSBOVUxMOwo+PiBUaGUga3Zt
LT5hcmNoLnBnZF9waHlzID0gMCBpbnN0cnVjdGlvbiBzZWVtcyB0byBoYXZlIGJlZW4gZHJvcHBl
ZCBoZXJlLiBJcyB0aGF0Cj4+IGludGVudGlvbmFsPwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5j
cy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0
aW5mby9rdm1hcm0K
