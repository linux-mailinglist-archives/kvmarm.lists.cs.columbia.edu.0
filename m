Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AA35C31CFD6
	for <lists+kvmarm@lfdr.de>; Tue, 16 Feb 2021 19:06:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 26B5B4B50C;
	Tue, 16 Feb 2021 13:06:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ACVinPvyk97l; Tue, 16 Feb 2021 13:06:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 520C14B503;
	Tue, 16 Feb 2021 13:06:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 69C844B4B4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Feb 2021 13:06:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jw68yoo7K-pn for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Feb 2021 13:06:01 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 736824B4AD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Feb 2021 13:06:01 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1E79101E;
 Tue, 16 Feb 2021 10:06:00 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16F33F73B;
 Tue, 16 Feb 2021 10:05:59 -0800 (PST)
Date: Tue, 16 Feb 2021 18:04:48 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests PATCH v2 08/12] arm/arm64: gic: Split
 check_acked() into two functions
Message-ID: <20210216180448.20fe4e59@slackpad.fritz.box>
In-Reply-To: <b4c0b997-bb96-6ee9-c959-ec9c1bd2258f@arm.com>
References: <20201217141400.106137-1-alexandru.elisei@arm.com>
 <20201217141400.106137-9-alexandru.elisei@arm.com>
 <3539c229-fd05-2e1c-2159-995e51e2dcc4@arm.com>
 <857a3c2d-772b-0d29-536c-41a829ab8954@arm.com>
 <20210127151051.3e4298f9@slackpad.fritz.box>
 <b4c0b997-bb96-6ee9-c959-ec9c1bd2258f@arm.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

T24gV2VkLCAyNyBKYW4gMjAyMSAxNjowMDo0NiArMDAwMApBbGV4YW5kcnUgRWxpc2VpIDxhbGV4
YW5kcnUuZWxpc2VpQGFybS5jb20+IHdyb3RlOgoKSGkgQWxleCwKCj4gT24gMS8yNy8yMSAzOjEw
IFBNLCBBbmRyZSBQcnp5d2FyYSB3cm90ZToKPiA+IE9uIE1vbiwgMjUgSmFuIDIwMjEgMTc6Mjc6
MzUgKzAwMDAKPiA+IEFsZXhhbmRydSBFbGlzZWkgPGFsZXhhbmRydS5lbGlzZWlAYXJtLmNvbT4g
d3JvdGU6Cj4gPgo+ID4gSGkgQWxleCwKPiA+ICAKPiA+PiBPbiAxMi8xOC8yMCAzOjUyIFBNLCBB
bmRyw6kgUHJ6eXdhcmEgd3JvdGU6ICAKPiA+Pj4gT24gMTcvMTIvMjAyMCAxNDoxMywgQWxleGFu
ZHJ1IEVsaXNlaSB3cm90ZTogICAgCj4gPj4+PiBjaGVja19hY2tlZCgpIGhhcyBzZXZlcmFsIHBl
Y3VsaWFyaXRpZXM6IGlzIHRoZSBvbmx5IGZ1bmN0aW9uIGFtb25nIHRoZQo+ID4+Pj4gY2hlY2tf
KiBmdW5jdGlvbnMgd2hpY2ggY2FsbHMgcmVwb3J0KCkgZGlyZWN0bHksIGl0IGRvZXMgdHdvIHRo
aW5ncwo+ID4+Pj4gKHdhaXRzIGZvciBpbnRlcnJ1cHRzIGFuZCBjaGVja3MgZm9yIG1pc2ZpcmVk
IGludGVycnVwdHMpIGFuZCBpdCBhbHNvCj4gPj4+PiBtaXhlcyBwcmludGYsIHJlcG9ydF9pbmZv
IGFuZCByZXBvcnQgY2FsbHMuCj4gPj4+Pgo+ID4+Pj4gY2hlY2tfYWNrZWQoKSBhbHNvIHJlcG9y
dHMgYSBwYXNzIGFuZCByZXR1cm5zIGFzIHNvb24gYWxsIHRoZSB0YXJnZXQgQ1BVcwo+ID4+Pj4g
aGF2ZSByZWNlaXZlZCBpbnRlcnJ1cHRzLCBIb3dldmVyLCBhIENQVSBub3QgaGF2aW5nIHJlY2Vp
dmVkIGFuIGludGVycnVwdAo+ID4+Pj4gKm5vdyogZG9lcyBub3QgZ3VhcmFudGVlIG5vdCByZWNl
aXZpbmcgYW4gZXJyb25lb3VzIGludGVycnVwdCBpZiB3ZSB3YWl0Cj4gPj4+PiBsb25nIGVub3Vn
aC4KPiA+Pj4+Cj4gPj4+PiBSZXdvcmsgdGhlIGZ1bmN0aW9uIGJ5IHNwbGl0dGluZyBpdCBpbnRv
IHR3byBzZXBhcmF0ZSBmdW5jdGlvbnMsIGVhY2ggd2l0aAo+ID4+Pj4gYSBzaW5nbGUgcmVzcG9u
c2liaWxpdHk6IHdhaXRfZm9yX2ludGVycnVwdHMoKSwgd2hpY2ggd2FpdHMgZm9yIHRoZQo+ID4+
Pj4gZXhwZWN0ZWQgaW50ZXJydXB0cyB0byBmaXJlLCBhbmQgY2hlY2tfYWNrZWQoKSB3aGljaCBj
aGVja3MgdGhhdCBpbnRlcnJ1cHRzCj4gPj4+PiBoYXZlIGJlZW4gcmVjZWl2ZWQgYXMgZXhwZWN0
ZWQuCj4gPj4+Pgo+ID4+Pj4gd2FpdF9mb3JfaW50ZXJydXB0cygpIGFsc28gd2FpdHMgYW4gZXh0
cmEgMTAwIG1pbGxpc2Vjb25kcyBhZnRlciB0aGUKPiA+Pj4+IGV4cGVjdGVkIGludGVycnVwdHMg
aGF2ZSBiZWVuIHJlY2VpdmVkIGluIGFuIGVmZm9ydCB0byBtYWtlIHN1cmUgd2UgZG9uJ3QKPiA+
Pj4+IG1pc3MgbWlzZmlyaW5nIGludGVycnVwdHMuCj4gPj4+Pgo+ID4+Pj4gU3BsaXR0aW5nIGNo
ZWNrX2Fja2VkKCkgaW50byB0d28gZnVuY3Rpb25zIHdpbGwgYWxzbyBhbGxvdyB1cyB0bwo+ID4+
Pj4gY3VzdG9taXplIHRoZSBiZWhhdmlvciBvZiBlYWNoIGZ1bmN0aW9uIGluIHRoZSBmdXR1cmUg
bW9yZSBlYXNpbHkKPiA+Pj4+IHdpdGhvdXQgdXNpbmcgYW4gdW5uZWNlc3NhcmlseSBsb25nIGxp
c3Qgb2YgYXJndW1lbnRzIGZvciBjaGVja19hY2tlZCgpLiAgICAKPiA+Pj4gWWVzLCBzcGxpdHRp
bmcgdGhpcyB1cCBsb29rcyBtdWNoIGJldHRlciwgaW4gZ2VuZXJhbCB0aGlzIGlzIGEgbmljZQo+
ID4+PiBjbGVhbnVwLCB0aGFuayB5b3UhCj4gPj4+Cj4gPj4+IFNvbWUgY29tbWVudHMgYmVsb3c6
Cj4gPj4+ICAgIAo+ID4+Pj4gQ0M6IEFuZHJlIFByenl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0u
Y29tPgo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEVsaXNlaSA8YWxleGFuZHJ1LmVs
aXNlaUBhcm0uY29tPgo+ID4+Pj4gLS0tCj4gPj4+PiAgYXJtL2dpYy5jIHwgNzMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4+Pj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKPiA+Pj4+Cj4g
Pj4+PiBkaWZmIC0tZ2l0IGEvYXJtL2dpYy5jIGIvYXJtL2dpYy5jCj4gPj4+PiBpbmRleCBlYzcz
MzcxOWM3NzYuLmE5ZWYxYTVkZWY1NiAxMDA2NDQKPiA+Pj4+IC0tLSBhL2FybS9naWMuYwo+ID4+
Pj4gKysrIGIvYXJtL2dpYy5jCj4gPj4+PiBAQCAtNjIsNDEgKzYyLDQyIEBAIHN0YXRpYyB2b2lk
IHN0YXRzX3Jlc2V0KHZvaWQpCj4gPj4+PiAgCX0KPiA+Pj4+ICB9Cj4gPj4+PiAgCj4gPj4+PiAt
c3RhdGljIHZvaWQgY2hlY2tfYWNrZWQoY29uc3QgY2hhciAqdGVzdG5hbWUsIGNwdW1hc2tfdCAq
bWFzaykKPiA+Pj4+ICtzdGF0aWMgdm9pZCB3YWl0X2Zvcl9pbnRlcnJ1cHRzKGNwdW1hc2tfdCAq
bWFzaykKPiA+Pj4+ICB7Cj4gPj4+PiAtCWludCBtaXNzaW5nID0gMCwgZXh0cmEgPSAwLCB1bmV4
cGVjdGVkID0gMDsKPiA+Pj4+ICAJaW50IG5yX3Bhc3MsIGNwdSwgaTsKPiA+Pj4+IC0JYm9vbCBi
YWQgPSBmYWxzZTsKPiA+Pj4+ICAKPiA+Pj4+ICAJLyogV2FpdCB1cCB0byA1cyBmb3IgYWxsIGlu
dGVycnVwdHMgdG8gYmUgZGVsaXZlcmVkICovCj4gPj4+PiAtCWZvciAoaSA9IDA7IGkgPCA1MDsg
KytpKSB7Cj4gPj4+PiArCWZvciAoaSA9IDA7IGkgPCA1MDsgaSsrKSB7Cj4gPj4+PiAgCQltZGVs
YXkoMTAwKTsKPiA+Pj4+ICAJCW5yX3Bhc3MgPSAwOwo+ID4+Pj4gIAkJZm9yX2VhY2hfcHJlc2Vu
dF9jcHUoY3B1KSB7Cj4gPj4+PiArCQkJLyoKPiA+Pj4+ICsJCQkgKiBBIENQVSBoYXZpbmcgcmVj
ZWl2ZWQgbW9yZSB0aGFuIG9uZSBpbnRlcnJ1cHRzIHdpbGwKPiA+Pj4+ICsJCQkgKiBzaG93IHVw
IGluIGNoZWNrX2Fja2VkKCksIGFuZCBubyBtYXR0ZXIgaG93IGxvbmcgd2UKPiA+Pj4+ICsJCQkg
KiB3YWl0IGl0IGNhbm5vdCB1bi1yZWNlaXZlIGl0LiBDb25zaWRlciBhdCBsZWFzdCBvbmUKPiA+
Pj4+ICsJCQkgKiBpbnRlcnJ1cHQgYXMgYSBwYXNzLgo+ID4+Pj4gKwkJCSAqLwo+ID4+Pj4gIAkJ
CW5yX3Bhc3MgKz0gY3B1bWFza190ZXN0X2NwdShjcHUsIG1hc2spID8KPiA+Pj4+IC0JCQkJYWNr
ZWRbY3B1XSA9PSAxIDogYWNrZWRbY3B1XSA9PSAwOwo+ID4+Pj4gLQkJCXNtcF9ybWIoKTsgLyog
cGFpcnMgd2l0aCBzbXBfd21iIGluIGlwaV9oYW5kbGVyICovCj4gPj4+PiAtCj4gPj4+PiAtCQkJ
aWYgKGJhZF9zZW5kZXJbY3B1XSAhPSAtMSkgewo+ID4+Pj4gLQkJCQlwcmludGYoImNwdSVkIHJl
Y2VpdmVkIElQSSBmcm9tIHdyb25nIHNlbmRlciAlZFxuIiwKPiA+Pj4+IC0JCQkJCWNwdSwgYmFk
X3NlbmRlcltjcHVdKTsKPiA+Pj4+IC0JCQkJYmFkID0gdHJ1ZTsKPiA+Pj4+IC0JCQl9Cj4gPj4+
PiAtCj4gPj4+PiAtCQkJaWYgKGJhZF9pcnFbY3B1XSAhPSAtMSkgewo+ID4+Pj4gLQkJCQlwcmlu
dGYoImNwdSVkIHJlY2VpdmVkIHdyb25nIGlycSAlZFxuIiwKPiA+Pj4+IC0JCQkJCWNwdSwgYmFk
X2lycVtjcHVdKTsKPiA+Pj4+IC0JCQkJYmFkID0gdHJ1ZTsKPiA+Pj4+IC0JCQl9Cj4gPj4+PiAr
CQkJCWFja2VkW2NwdV0gPj0gMSA6IGFja2VkW2NwdV0gPT0gMDsgICAgCj4gPj4+IEkgd29uZGVy
IGlmIHRoaXMgbG9naWMgd2FzIGFscmVhZHkgZmxhd2VkIHRvIGJlZ2luIHdpdGg6IEZvciBpbnRl
cnJ1cHRzCj4gPj4+IHdlIGV4cGVjdCB0byBmaXJlLCB3ZSB3YWl0IGZvciB1cCB0byA1IHNlY29u
ZHMgKHJlYWxseSB0aGF0IGxvbmc/KSwgYnV0Cj4gPj4+IGZvciBpbnRlcnJ1cHRzIHdlIGV4cGVj
dCAqbm90KiB0byBmaXJlIHdlIGFyZSBPSyBpZiB0aGV5IGRvbid0IHNob3cgdXAKPiA+Pj4gaW4g
dGhlIGZpcnN0IDEwMCBtcy4gVGhhdCBkb2VzIG5vdCBzb3VuZCBjb25zaXN0ZW50LiAgICAKPiA+
PiBUaGVyZSBhcmUgdHdvIHdheXMgdGhhdCBJIHNlZSB0byBmaXggdGhpczoKPiA+Pgo+ID4+IC0g
SGF2ZSB0aGUgY2FsbGVyIHdhaXQgZm9yIGhvd2V2ZXIgbG9uZyBpdCBzZWVzIGZpdCwgYW5kICph
ZnRlciogdGhhdCB3YWl0aW5nCj4gPj4gcGVyaW9kIGNhbGwgd2FpdF9mb3JfaW50ZXJydXB0cygp
Lgo+ID4+Cj4gPj4gLSBQYXNzIGEgZmxhZyB0byB3YWl0X2Zvcl9pbnRlcnJ1cHRzKCkgdG8gc3Bl
Y2lmeSB0aGF0IHRoZSBiZWhhdmlvdXIgc2hvdWxkIGJlIHRvCj4gPj4gd2FpdCBmb3IgdGhlIGVu
dGlyZSBkdXJhdGlvbiBpbnN0ZWFkIG9mIHVudGlsIHRoZSBleHBlY3RlZCBpbnRlcnJ1cHRzIGhh
dmUgYmVlbgo+ID4+IHJlY2VpdmVkLgo+ID4+Cj4gPj4gTmVpdGhlciBzb3VuZHMgYXBwZWFsaW5n
IHRvIG1lIGZvciBpbmNsdXNpb24gaW4gdGhpcyBwYXRjaCBzZXQsIHNpbmNlIEkgd2FudCB0bwo+
ID4+IGNvbmNlbnRyYXRlIG9uIHJld29ya2luZyBjaGVja19hY2tlZCgpIHdoaWxlIGtlZXBpbmcg
bXVjaCBvZiB0aGUgY3VycmVudCBiZWhhdmlvdXIKPiA+PiBpbnRhY3QuCj4gPj4gIAo+ID4+PiBJ
IGFtIHdvbmRlcmluZyBpZiB3ZSBzaG91bGQgKm5vdCogaGF2ZSB0aGUgaW5pdGlhbCAxMDBtcyB3
YWl0IGF0IGFsbCwKPiA+Pj4gc2luY2UgbW9zdCBpbnRlcnJ1cHRzIHdpbGwgZmlyZSBpbW1lZGlh
dGVseSAoZXNwZWNpYWxseSBpbiBLVk0pLiBBbmQKPiA+Pj4gdGhlbiBoYXZlICpvbmUqIGV4dHJh
IHdhaXQgZm9yLCBzYXkgMTAwbXMsIHRvIGNvdmVyIGxhdGVjb21lcnMgYW5kCj4gPj4+IHNwdXJp
b3VzIGludGVycnVwdHMuICAgIAo+ID4+IEkgZG9uJ3QgdGhpbmsgaXQgcmVhbGx5IG1hdHRlcnMg
d2hlcmUgdGhlIDEwMCBtaWxsaXNlY29uZCBkZWxheSBpcyBpbiB0aGUgbG9vcC4gIAo+ID4gSSB0
aGluayBpdCBkb2VzLiBJIHJhbiB0ZXN0cyB3aXRoIDI1NiB2Q1BVcywgSSB0aGluayB3ZSBzdXBw
b3J0IGV2ZW4KPiA+IG1vcmUsIGFuZCBydW5uaW5nIGstdS10IG9uIHRob3NlIHNldHVwcyBpcyBv
bmUgb2YgdGhlIGNhc2VzIHdoZXJlIGl0Cj4gPiByZWFsbHkgbWF0dGVycyBhbmQgd2UgY2FuIGZp
bmQgcmVhbCBidWdzLgo+ID4gU28gMTAwbXMgb24gdGhlaXIgb3duIGRvZXMgbm90IHNvdW5kIG11
Y2gsIGJ1dCBpdCBtZWFucyB3ZSB3YWl0IGF0IGxlYXN0Cj4gPiAyNS42IHNlY29uZHMsIGV2ZW4g
aWYgZXZlcnl0aGluZyBpcyBmaW5lLiBJIGZvdW5kIHRoaXMgc2NhcnksIGNvbmZ1c2luZwo+ID4g
YW5kIGFubm95aW5nIChpbiB0aGF0IG9yZGVyKSwgc28gd2FzIHdvbmRlcmluZyBpZiB3ZSBjYW4g
YXZvaWQgdGhhdC4gIAo+IAo+IEknbSBub3Qgc3VyZSB3aGVyZSB0aGF0IDI1LjYgc2Vjb25kIGRl
bGF5IGlzIGNvbWluZyBmcm9tLiBUaGUgbWRlbGF5KCkgaXMgYXQgdGhlCj4gc3RhcnQgb2YgdGhl
IGZvciBsb29wLCAqYmVmb3JlKiB0aGUgZm9yX2VhY2hfY3B1KCkgbG9vcCwgc28gaXQncyBub3Qg
ZXhlY3V0ZWQgZm9yCj4gZWFjaCBWQ1BVLgoKSSB0aGluayB0aGF0IGNvbWVzIGZyb20gc29tZSBv
dGhlciBwYXRjaGVzIG9mIG1pbmUsIHdoaWNoIGNhbGwgdGhlIHRlc3QKb24gKmVhY2gqIFZDUFUu
IFRoZXJlIHRoaXMgc21hbGwgZGVsYXkgYWRkcyB1cC4KCj4gSSd2ZSBhbHNvIHJ1biB0aGUgaXBp
IHRlc3Qgb24gbXkgcm9ja3BybzY0IHdpdGggMjU2IHZjcHVzIHdpdGgga3ZtdG9vbCBhbmQgSQo+
IGRpZG4ndCBub3RpY2UgYW55IHVuZXhwZWN0ZWQgZGVsYXlzLgoKVGhhbmtzIGZvciBkb2luZyB0
aGF0LgoKPiA+PiBJZgo+ID4+IHdlIGNhbGwgd2FpdF9mb3JfaW50ZXJydXB0cygpIHRvIGFjdHVh
bGx5IGNoZWNrIHRoYXQgaW50ZXJydXB0cyBoYXZlIGZpcmVkIChhcwo+ID4+IG9wcG9zZWQgdG8g
Y2hlY2tpbmcgdGhhdCB0aGV5IGhhdmVuJ3QgYmVlbiBhc3NlcnRlZCksIHRoZW4gYXQgbW9zdCB3
ZSBzYXZlIDEwMG1zCj4gPj4gd2hlbiB0aGV5IGFyZSBhc3NlcnRlZCBiZWZvcmUgdGhlIHN0YXJ0
IG9mIHRoZSBsb29wLiBJIGRvbid0IHRoaW5rIHRoZSBHSUMgc3BlYwo+ID4+IGd1YXJhbnRlZXMg
dGhhdCBpbnRlcnJ1cHRzIHdyaXR0ZW4gdG8gdGhlIExSIHJlZ2lzdGVycyB3aWxsIGJlIHByZXNl
bnRlZCB0byB0aGUKPiA+PiBDUFUgYWZ0ZXIgdGhlIGd1ZXN0IHJlc3VtZXMsICAKPiA+IEkgZG9u
J3Qga25vdyBpZiB0aGUgc3BlYyBzYXlzIGFueXRoaW5nIGFib3V0IGl0LCBJIGd1ZXNzIGl0IHdv
dWxkIGJlCj4gPiBvdXQgb2Ygc2NvcGUgdG8gZG8gc28gdGhlcmUgYW55d2F5LCBidXQgQUZBSUsg
dGhpcyBpcyBleGFjdGx5IGhvdyBpdCdzCj4gPiBpbXBsZW1lbnRlZDogd2hlbiB3ZSBkcm9wIHRv
IEVMMSB3aXRoIHRoZSBWR0lDIGFybWVkLCB0aGUgR0lDIGp1bXBzIGluCj4gPiBiZWZvcmUgdGhl
IGd1ZXN0IGV4ZWN1dGVzIHRoZSBmaXJzdCBpbnN0cnVjdGlvbiAodGhhdCBFTFJfRUwyIHBvaW50
cwo+ID4gdG8pLCBhbmQgcmFpc2VzIHRoZSBJUlEgZXhjZXB0aW9uIGluIEVMMS4KPiA+ICAKPiA+
PiBzbyBpdCBpcyBjb25jZWl2YWJsZSB0aGF0IHRoZXJlIG1pZ2h0IGJlIGEgZGVsYXksICAKPiA+
IFRoZSBvbmx5IHByYWN0aWNhbCByZWFzb24gZm9yIGEgZGVsYXkgd291bGQgYmUgUFNUQVRFLkkg
YmVpbmcgc2V0LCBvcgo+ID4gdGhlIEdJQ1YgYmVpbmcgZGlzYWJsZWQsIEkgdGhpbmsuCj4gPgo+
ID4gSSB3b3VsZCBzYXkgb25lIHdvdWxkIGV4cGVjdCBpbnRlcnJ1cHRzIHRvIGZpcmUgKmltbWVk
aWF0ZWx5KiwgYW5kCj4gPiBhbGxvd2luZyB0aGVtIDEwMG1zIHNsYWNrIGRvZXMgbm90IHNvdW5k
IGxpa2UgdGhlIHJpZ2h0IHRoaW5nLiBJZiB0aGVyZQo+ID4gaXMgc29tZSBkZWxheSwgSSB3b3Vs
ZCBhdCBsZWFzdCBsaWtlIHRvIGtub3cgYWJvdXQgaXQuIEFuZCBJIHdvdWxkCj4gPiBncmFudCB0
aGVtIGEgZmV3IGluc3RydWN0aW9ucyBkZWxheSwgYXQgYmVzdC4gIAo+IAo+IEkgdGhpbmsgeW91
J3JlIGZvcmdldHRpbmcgdGhlIGZhY3QgdGhhdCB0aGUgaW50ZXJydXB0cyBhcmUgZGVsaXZlcmVk
IHRvIHRoZSBvdGhlcgo+IFZDUFVzLCBub3QgdG8gdGhlIFZDUFUgdGhhdCBpcyBjYWxsaW5nIHdh
aXRfZm9yX2ludGVycnVwdHMoKS4KClRoYXQgaXMgb25lIHVzZSBjYXNlLCBidXQgZm9yIHRoZSBJ
UEkgc2VsZiB0ZXN0IHdlIGRvIHRoaXMgb24gdGhlCnNhbWUgVkNQVS4gTXkgY29uY2VybiB3YXMg
anVzdCB0aGF0IHRob3NlIGZ1bmN0aW9ucyBhcmUgZ2VuZXJpYywgc28Kc2hvdWxkIGNhdGVyIGZv
ciBhbnkga2luZCBvZiBpbnRlcnJ1cHQgdGVzdHMgdGhyb3duIGF0IHRoZW0uIEFuZCBhcwptZW50
aW9uZWQgYWJvdmUsIEkgaGFkIHRlc3RzIHdoaWNoIGdvdCBkZWxheWVkIGJ5IHRoZSBtYW5kYXRv
cnkgd2FpdC4KCkZvciB0aGUgcmVjb3JkczogSSB3YXMgY29taW5nIGZyb20gbXkgbWFudWFsIHRl
c3RpbmcgZHVyaW5nIHRoZSBWR0lDCmRldmVsb3BtZW50L3Jld29yayBhIGZldyB5ZWFycyBiYWNr
LCB3aGVyZSBzb21lIGJ1Z3Mgb25seSBzaG93ZWQgdW5kZXIKKGhlYXZ5KSAqcGFyYWxsZWwqIGlu
dGVycnVwdCBsb2FkLiBTbyBJIGd1ZXNzIEkgYW0gYSBiaXQgYmlhc2VkIHdoZW4gaXQKY29tZXMg
dG8gdGhhdC4KCkJ1dCB0aGlzIGlzIGluZGVlZCBvZiBubyBjb25jZXJuIGZvciB3aGF0IHdlIGN1
cnJlbnRseSBoYXZlLCBzbyBJIGd1ZXNzCkkgd2lsbCBqdXN0IHJldmlzaXQgdGhpcyBhcyBuZWVk
ZWQsIHNob3VsZCB3ZSBnZXQgbW9yZSBzb3BoaXN0aWNhdGVkCnRlc3RzLgoKV2hpY2ggbWVhbnMg
dGhlIGNoYW5nZXMgaGVyZSBhcmUgZmluZSBvbiB0aGVpciBvd24gYW5kIGFyZSBkZWZpbml0ZWx5
CmFuIGltcHJvdmVtZW50LCBzbyB3ZSBzaG91bGQgZ28gYWhlYWQgd2l0aCB0aGF0LgoKQ2hlZXJz
LApBbmRyZQoKCj4gU28gaXQncyB0aGUKPiBpbnRlcnJ1cHQgaGFuZGxlcnMgcnVubmluZyBvbiB0
aGUgb3RoZXIgVkNQVXMgdGhhdCB1cGRhdGUgYWNrZWQsIHdoaWNoIGFmdGVyd2FyZHMKPiBpcyBy
ZWFkIGluIHdhaXRfZm9yX2ludGVycnVwdHMoKS4KPiAKPiBBcyBhbiBleHBlcmltZW50LCBJIG1v
dmVkIHRoZSBtZGVsYXkoKSBhdCB0aGUgZW5kIG9mIHRoZSBsb29wIGFuZCBJIHRyaWVkIHJ1bm5p
bmcKPiB0aGUgSVBJIHRlc3Qgd2l0aCAyIGFuZCAyNTYgVkNQVXM6Cj4gCj4gJCB0YXNrc2V0IC1j
IDQsNSB+L2xrdm0tc3RhdGljIHJ1biAtYzIgLW0xMjggLWYgYXJtL2dpYy5mbGF0IC1wICdpcGkn
Cj4gwqAgIyBsa3ZtIHJ1biAtLWZpcm13YXJlIGFybS9naWMuZmxhdCAtbSAxMjggLWMgMiAtLW5h
bWUgZ3Vlc3QtMTcyMAo+IMKgIEluZm86IFBsYWNpbmcgZmR0IGF0IDB4ODAyMDAwMDAgLSAweDgw
MjEwMDAwCj4gY2hyX3Rlc3RkZXZfaW5pdDogY2hyLXRlc3RkZXY6IGNhbid0IGZpbmQgYSB2aXJ0
aW8tY29uc29sZQo+IFBBU1M6IGdpY3YzOiBpcGk6IHNlbGY6IEludGVycnVwdHMgcmVjZWl2ZWQK
PiBJTkZPOiBnaWN2MzogaXBpOiB0YXJnZXQtbGlzdDogaW50ZXJydXB0cyB0b29rIG1vcmUgdGhh
biAxMDAgbXMKPiBQQVNTOiBnaWN2MzogaXBpOiB0YXJnZXQtbGlzdDogSW50ZXJydXB0cyByZWNl
aXZlZAo+IElORk86IGdpY3YzOiBpcGk6IGJyb2FkY2FzdDogaW50ZXJydXB0cyB0b29rIG1vcmUg
dGhhbiAxMDAgbXMKPiBQQVNTOiBnaWN2MzogaXBpOiBicm9hZGNhc3Q6IEludGVycnVwdHMgcmVj
ZWl2ZWQKPiBTVU1NQVJZOiAzIHRlc3RzCj4gCj4gJCB0YXNrc2V0IC1jIDQsNSB+L2xrdm0tc3Rh
dGljIHJ1biAtYzI1NiAtbTEyOCAtZiBhcm0vZ2ljLmZsYXQgLXAgJ2lwaScKPiDCoCAjIGxrdm0g
cnVuIC0tZmlybXdhcmUgYXJtL2dpYy5mbGF0IC1tIDEyOCAtYyAyNTYgLS1uYW1lIGd1ZXN0LTIw
MDAKPiDCoCBJbmZvOiBQbGFjaW5nIGZkdCBhdCAweDgwMjAwMDAwIC0gMHg4MDIxMDAwMAo+IMKg
ICMgV2FybmluZzogVGhlIG1heGltdW0gcmVjb21tZW5kZWQgYW1vdW50IG9mIFZDUFVzIGlzIDYK
PiBjaHJfdGVzdGRldl9pbml0OiBjaHItdGVzdGRldjogY2FuJ3QgZmluZCBhIHZpcnRpby1jb25z
b2xlCj4gUEFTUzogZ2ljdjM6IGlwaTogc2VsZjogSW50ZXJydXB0cyByZWNlaXZlZAo+IElORk86
IGdpY3YzOiBpcGk6IHRhcmdldC1saXN0OiBpbnRlcnJ1cHRzIHRvb2sgbW9yZSB0aGFuIDEwMCBt
cwo+IFBBU1M6IGdpY3YzOiBpcGk6IHRhcmdldC1saXN0OiBJbnRlcnJ1cHRzIHJlY2VpdmVkCj4g
SU5GTzogZ2ljdjM6IGlwaTogYnJvYWRjYXN0OiBpbnRlcnJ1cHRzIHRvb2sgbW9yZSB0aGFuIDEw
MCBtcwo+IFBBU1M6IGdpY3YzOiBpcGk6IGJyb2FkY2FzdDogSW50ZXJydXB0cyByZWNlaXZlZAo+
IFNVTU1BUlk6IDMgdGVzdHMKPiAKPiBGb3IgdGhlIDI1NiBWQ1BVcyB0ZXN0LCBvbiB0d28gcnVu
cyBJIGdvdCB0aGUgImludGVycnVwdHMgdG9vayBtb3JlIHRoYW4gMTAwIG1zIgo+IG1lc3NhZ2Ug
Zm9yIHRhcmdldC1saXN0LCBvbiBvbmUgdGVzdCBJIGRpZG4ndCAoYnV0IGZvciBicm9hZGNhc3Qg
SSBhbHdheXMgZ290IHRoZQo+IG1lc3NhZ2UpLgo+IAo+IEZvciB0aGUgMiBWQ1BVcyB0ZXN0LCBJ
IGFsd2F5cyBnb3QgdGhlIG1lc3NhZ2UgKHRyaWVkIGl0IDUgdGltZXMpLgo+IAo+IFRoYW5rcywK
PiBBbGV4Cj4gPgo+ID4gSWYgeW91IHN0aWxsIHRoaW5rIHlvdSBuZWVkIHRoYXQgZGVsYXksIGJl
Y2F1c2UgZXZlcnl0aGluZyBlbHNlIHdvdWxkCj4gPiBiZSB0b28gY29tcGxpY2F0ZWQgKGF0IGxl
YXN0IGZvciB0aGlzIGl0ZXJhdGlvbiksIHRoZW4gcGxlYXNlIG1ha2UgaXQKPiA+ICptdWNoKiBz
bWFsbGVyICg8IDF1cykuCj4gPgo+ID4gQ2hlZXJzLAo+ID4gQW5kcmUKPiA+Cj4gPiAgCj4gPj4g
dGh1cyBlbmRpbmcgdXAgaW4gd2FpdGluZyB0aGUgZXh0cmEgMTAwbXMgZXZlbiBpZiB0aGUgZGVs
YXkgaXMgYXQgdGhlIGVuZCBvZiB0aGUgbG9vcC4KPiA+Pgo+ID4+IFRoZXJlIGFyZSB0d28gcmVh
c29ucyBJIGNob3NlIHRoZSBhcHByb2FjaCBvZiBoYXZpbmcgdGhlIGRlbGF5IGF0IHRoZSBzdGFy
dCBvZiB0aGUKPiA+PiBsb29wOgo+ID4+Cj4gPj4gMS4gVG8gcHJlc2VydmUgdGhlIGN1cnJlbnQg
YmVoYXZpb3VyLgo+ID4+Cj4gPj4gMi4gVG8gbWF0Y2ggd2hhdCB0aGUgdGltZXIgdGVzdCB0aG9z
ZSAoc2VlIGdpY190aW1lcl9jaGVja19zdGF0ZSgpKS4gSSBhbSBhbHNvCj4gPj4gdGhpbmtpbmcg
dGhhdCBtYXliZSBhdCBzb21lIHBvaW50IHdlIGNvdWxkIHVuaWZ5IHRoZXNlIHRlc3QtaW5kZXBl
bmRlbnQgZnVuY3Rpb25zCj4gPj4gaW4gdGhlIGdpYyBkcml2ZXIuCj4gPj4KPiA+PiBBcyBmb3Ig
dGhlIDUgc2Vjb25kcyBkZWxheSwgSSB0aGluayB3ZSBjYW4gY29tZSB1cCB3aXRoIGEgcGF0Y2gg
dG8gcGFzcyB0aGUgZGVsYXkKPiA+PiBhcyBhIHBhcmFtZXRlciB0byB0aGUgZnVuY3Rpb24gaWYg
bmVlZGVkIChpZiBJIHJlbWVtYmVyIGNvcnJlY3RseSwgeW91IG5lZWRlZCBhCj4gPj4gc2hvcnRl
ciB3YWl0aW5nIHBlcmlvZCBmb3IgeW91ciBHSUMgdGVzdHMpLgo+ID4+ICAKPiA+Pj4gQnV0IHRo
aXMgbWlnaHQgYmUgYSB0b3BpYyBmb3Igc29tZSBleHRyYSB3b3JrL3BhdGNoPyAgICAKPiA+PiBZ
ZXMsIEkgd291bGQgcmF0aGVyIG1ha2UgdGhpcyBjaGFuZ2VzIHdoZW4gd2UgaGF2ZSBhbiBhY3R1
YWwgdGVzdCB0aGF0IG5lZWRzIHRoZW0uCj4gPj4gIAo+ID4+PiAgICAKPiA+Pj4+ICAJCX0KPiA+
Pj4+ICsKPiA+Pj4+ICAJCWlmIChucl9wYXNzID09IG5yX2NwdXMpIHsKPiA+Pj4+IC0JCQlyZXBv
cnQoIWJhZCwgIiVzIiwgdGVzdG5hbWUpOwo+ID4+Pj4gIAkJCWlmIChpKQo+ID4+Pj4gLQkJCQly
ZXBvcnRfaW5mbygidG9vayBtb3JlIHRoYW4gJWQgbXMiLCBpICogMTAwKTsKPiA+Pj4+ICsJCQkJ
cmVwb3J0X2luZm8oImludGVycnVwdHMgdG9vayBtb3JlIHRoYW4gJWQgbXMiLCBpICogMTAwKTsK
PiA+Pj4+ICsJCQltZGVsYXkoMTAwKTsgICAgCj4gPj4+IFNvIHRoaXMgaXMgdGhlIGV4dHJhIDEw
MG1zIHlvdSBtZW50aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZT8gSSBhbSBub3QKPiA+Pj4gY29u
dmluY2VkIHRoaXMgaXMgdGhlIHJpZ2h0IHdheSAoc2VlIGFib3ZlKSBvciBldmVuIHRoZSByaWdo
dCBwbGFjZQo+ID4+PiAocmF0aGVyIGF0IHRoZSBjYWxsIHNpdGU/KSB0byB3YWl0LiBCdXQgYXQg
bGVhc3QgaXQgZGVzZXJ2ZXMgYSBjb21tZW50LAo+ID4+PiBJIGJlbGlldmUuICAgIAo+ID4+IEkn
bSBub3Qgc3VyZSBtb3ZpbmcgaXQgaW50byB0aGUgY2FsbGVyIGlzIHRoZSByaWdodCB0aGluZyB0
byBkby4gVGhpcyBpcyBzb21ldGhpbmcKPiA+PiB0aGF0IGhhcyB0byBkbyB3aXRoIGhvdyBpbnRl
cnJ1cHRzIGFyZSBhc3NlcnRlZCwgbm90IHNvbWV0aGluZyB0aGF0IGlzIHNwZWNpZmljIHRvCj4g
Pj4gb25lIHRlc3QuCj4gPj4KPiA+PiBZb3UgYXJlIHJpZ2h0IGFib3V0IHRoZSBjb21tZW50LCBJ
J2xsIGFkZCBvbmUuCj4gPj4KPiA+PiBUaGFua3MsCj4gPj4gQWxleCAgCj4gPj4+PiAgCQkJcmV0
dXJuOwo+ID4+Pj4gIAkJfQo+ID4+Pj4gIAl9Cj4gPj4+PiAgCj4gPj4+PiArCXJlcG9ydF9pbmZv
KCJpbnRlcnJ1cHRzIHRpbWVkLW91dCAoNXMpIik7Cj4gPj4+PiArfQo+ID4+Pj4gKwo+ID4+Pj4g
K3N0YXRpYyBib29sIGNoZWNrX2Fja2VkKGNwdW1hc2tfdCAqbWFzaykKPiA+Pj4+ICt7Cj4gPj4+
PiArCWludCBtaXNzaW5nID0gMCwgZXh0cmEgPSAwLCB1bmV4cGVjdGVkID0gMDsKPiA+Pj4+ICsJ
Ym9vbCBwYXNzID0gdHJ1ZTsKPiA+Pj4+ICsJaW50IGNwdTsKPiA+Pj4+ICsKPiA+Pj4+ICAJZm9y
X2VhY2hfcHJlc2VudF9jcHUoY3B1KSB7Cj4gPj4+PiAgCQlpZiAoY3B1bWFza190ZXN0X2NwdShj
cHUsIG1hc2spKSB7Cj4gPj4+PiAgCQkJaWYgKCFhY2tlZFtjcHVdKQo+ID4+Pj4gQEAgLTEwNywx
MSArMTA4LDI4IEBAIHN0YXRpYyB2b2lkIGNoZWNrX2Fja2VkKGNvbnN0IGNoYXIgKnRlc3RuYW1l
LCBjcHVtYXNrX3QgKm1hc2spCj4gPj4+PiAgCQkJaWYgKGFja2VkW2NwdV0pCj4gPj4+PiAgCQkJ
CSsrdW5leHBlY3RlZDsKPiA+Pj4+ICAJCX0KPiA+Pj4+ICsJCXNtcF9ybWIoKTsgLyogcGFpcnMg
d2l0aCBzbXBfd21iIGluIGlwaV9oYW5kbGVyICovCj4gPj4+PiArCj4gPj4+PiArCQlpZiAoYmFk
X3NlbmRlcltjcHVdICE9IC0xKSB7Cj4gPj4+PiArCQkJcmVwb3J0X2luZm8oImNwdSVkIHJlY2Vp
dmVkIElQSSBmcm9tIHdyb25nIHNlbmRlciAlZCIsCj4gPj4+PiArCQkJCQljcHUsIGJhZF9zZW5k
ZXJbY3B1XSk7Cj4gPj4+PiArCQkJcGFzcyA9IGZhbHNlOwo+ID4+Pj4gKwkJfQo+ID4+Pj4gKwo+
ID4+Pj4gKwkJaWYgKGJhZF9pcnFbY3B1XSAhPSAtMSkgewo+ID4+Pj4gKwkJCXJlcG9ydF9pbmZv
KCJjcHUlZCByZWNlaXZlZCB3cm9uZyBpcnEgJWQiLAo+ID4+Pj4gKwkJCQkJY3B1LCBiYWRfaXJx
W2NwdV0pOwo+ID4+Pj4gKwkJCXBhc3MgPSBmYWxzZTsKPiA+Pj4+ICsJCX0KPiA+Pj4+ICsJfQo+
ID4+Pj4gKwo+ID4+Pj4gKwlpZiAobWlzc2luZyB8fCBleHRyYSB8fCB1bmV4cGVjdGVkKSB7Cj4g
Pj4+PiArCQlyZXBvcnRfaW5mbygiQUNLUzogbWlzc2luZz0lZCBleHRyYT0lZCB1bmV4cGVjdGVk
PSVkIiwKPiA+Pj4+ICsJCQkJbWlzc2luZywgZXh0cmEsIHVuZXhwZWN0ZWQpOwo+ID4+Pj4gKwkJ
cGFzcyA9IGZhbHNlOyAgICAKPiA+Pj4gVGhhbmtzLCB0aGF0IHNvIG11Y2ggZWFzaWVyIHRvIHJl
YWQgbm93Lgo+ID4+Pgo+ID4+PiBDaGVlcnMsCj4gPj4+IEFuZHJlCj4gPj4+ICAgIAo+ID4+Pj4g
IAl9Cj4gPj4+PiAgCj4gPj4+PiAtCXJlcG9ydChmYWxzZSwgIiVzIiwgdGVzdG5hbWUpOwo+ID4+
Pj4gLQlyZXBvcnRfaW5mbygiVGltZWQtb3V0ICg1cykuIEFDS1M6IG1pc3Npbmc9JWQgZXh0cmE9
JWQgdW5leHBlY3RlZD0lZCIsCj4gPj4+PiAtCQkgICAgbWlzc2luZywgZXh0cmEsIHVuZXhwZWN0
ZWQpOwo+ID4+Pj4gKwlyZXR1cm4gcGFzczsKPiA+Pj4+ICB9Cj4gPj4+PiAgCj4gPj4+PiAgc3Rh
dGljIHZvaWQgY2hlY2tfc3B1cmlvdXModm9pZCkKPiA+Pj4+IEBAIC0zMDMsNyArMzIxLDggQEAg
c3RhdGljIHZvaWQgaXBpX3Rlc3Rfc2VsZih2b2lkKQo+ID4+Pj4gIAljcHVtYXNrX2NsZWFyKCZt
YXNrKTsKPiA+Pj4+ICAJY3B1bWFza19zZXRfY3B1KHNtcF9wcm9jZXNzb3JfaWQoKSwgJm1hc2sp
Owo+ID4+Pj4gIAlnaWMtPmlwaS5zZW5kX3NlbGYoKTsKPiA+Pj4+IC0JY2hlY2tfYWNrZWQoIklQ
STogc2VsZiIsICZtYXNrKTsKPiA+Pj4+ICsJd2FpdF9mb3JfaW50ZXJydXB0cygmbWFzayk7Cj4g
Pj4+PiArCXJlcG9ydChjaGVja19hY2tlZCgmbWFzayksICJJbnRlcnJ1cHRzIHJlY2VpdmVkIik7
Cj4gPj4+PiAgCXJlcG9ydF9wcmVmaXhfcG9wKCk7Cj4gPj4+PiAgfQo+ID4+Pj4gIAo+ID4+Pj4g
QEAgLTMxOCw3ICszMzcsOCBAQCBzdGF0aWMgdm9pZCBpcGlfdGVzdF9zbXAodm9pZCkKPiA+Pj4+
ICAJZm9yIChpID0gc21wX3Byb2Nlc3Nvcl9pZCgpICYgMTsgaSA8IG5yX2NwdXM7IGkgKz0gMikK
PiA+Pj4+ICAJCWNwdW1hc2tfY2xlYXJfY3B1KGksICZtYXNrKTsKPiA+Pj4+ICAJZ2ljX2lwaV9z
ZW5kX21hc2soSVBJX0lSUSwgJm1hc2spOwo+ID4+Pj4gLQljaGVja19hY2tlZCgiSVBJOiBkaXJl
Y3RlZCIsICZtYXNrKTsKPiA+Pj4+ICsJd2FpdF9mb3JfaW50ZXJydXB0cygmbWFzayk7Cj4gPj4+
PiArCXJlcG9ydChjaGVja19hY2tlZCgmbWFzayksICJJbnRlcnJ1cHRzIHJlY2VpdmVkIik7Cj4g
Pj4+PiAgCXJlcG9ydF9wcmVmaXhfcG9wKCk7Cj4gPj4+PiAgCj4gPj4+PiAgCXJlcG9ydF9wcmVm
aXhfcHVzaCgiYnJvYWRjYXN0Iik7Cj4gPj4+PiBAQCAtMzI2LDcgKzM0Niw4IEBAIHN0YXRpYyB2
b2lkIGlwaV90ZXN0X3NtcCh2b2lkKQo+ID4+Pj4gIAljcHVtYXNrX2NvcHkoJm1hc2ssICZjcHVf
cHJlc2VudF9tYXNrKTsKPiA+Pj4+ICAJY3B1bWFza19jbGVhcl9jcHUoc21wX3Byb2Nlc3Nvcl9p
ZCgpLCAmbWFzayk7Cj4gPj4+PiAgCWdpYy0+aXBpLnNlbmRfYnJvYWRjYXN0KCk7Cj4gPj4+PiAt
CWNoZWNrX2Fja2VkKCJJUEk6IGJyb2FkY2FzdCIsICZtYXNrKTsKPiA+Pj4+ICsJd2FpdF9mb3Jf
aW50ZXJydXB0cygmbWFzayk7Cj4gPj4+PiArCXJlcG9ydChjaGVja19hY2tlZCgmbWFzayksICJJ
bnRlcnJ1cHRzIHJlY2VpdmVkIik7Cj4gPj4+PiAgCXJlcG9ydF9wcmVmaXhfcG9wKCk7Cj4gPj4+
PiAgfQo+ID4+Pj4gIAo+ID4+Pj4gICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1
bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9r
dm1hcm0K
