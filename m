Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1BDF961D
	for <lists+kvmarm@lfdr.de>; Tue, 12 Nov 2019 17:54:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 347154B1B3;
	Tue, 12 Nov 2019 11:54:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOtwRP4Nnu+U; Tue, 12 Nov 2019 11:54:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A1DF24B1A6;
	Tue, 12 Nov 2019 11:54:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B83D4B0F8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Nov 2019 11:53:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwzo4aGDjScV for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Nov 2019 11:53:57 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A7ED44B0ED
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Nov 2019 11:53:57 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A4EC30E;
 Tue, 12 Nov 2019 08:53:57 -0800 (PST)
Received: from [10.1.196.63] (e123195-lin.cambridge.arm.com [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28E473F534;
 Tue, 12 Nov 2019 08:53:56 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH 03/17] arm: gic: Provide per-IRQ helper
 functions
To: Auger Eric <eric.auger@redhat.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Jones <drjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191108144240.204202-1-andre.przywara@arm.com>
 <20191108144240.204202-4-andre.przywara@arm.com>
 <9cc460d1-c01f-6b0a-c6be-292a63174d68@arm.com>
 <bcdc76b2-3549-94fe-1070-8a8198e22a63@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <21d30cc3-8e97-f5fe-4de1-5672e8707887@arm.com>
Date: Tue, 12 Nov 2019 16:53:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bcdc76b2-3549-94fe-1070-8a8198e22a63@redhat.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
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

SGksCgpPbiAxMS8xMi8xOSAzOjUzIFBNLCBBdWdlciBFcmljIHdyb3RlOgo+IEhpIEFsZXgsCj4K
PiBPbiAxMS8xMi8xOSAxOjUxIFBNLCBBbGV4YW5kcnUgRWxpc2VpIHdyb3RlOgo+PiBIaSwKPj4K
Pj4gT24gMTEvOC8xOSAyOjQyIFBNLCBBbmRyZSBQcnp5d2FyYSB3cm90ZToKPj4+IEEgY29tbW9u
IHRoZW1lIHdoZW4gYWNjZXNzaW5nIHBlci1JUlEgcGFyYW1ldGVycyBpbiB0aGUgR0lDIGRpc3Ry
aWJ1dG9yCj4+PiBpcyB0byBzZXQgZmllbGRzIG9mIGEgY2VydGFpbiBiaXQgd2lkdGggaW4gYSBy
YW5nZSBvZiBNTUlPIHJlZ2lzdGVycy4KPj4+IEV4YW1wbGVzIGFyZSB0aGUgZW5hYmxlZCBzdGF0
dXMgKG9uZSBiaXQgcGVyIElSUSksIHRoZSBsZXZlbC9lZGdlCj4+PiBjb25maWd1cmF0aW9uICgy
IGJpdHMgcGVyIElSUSkgb3IgdGhlIHByaW9yaXR5ICg4IGJpdHMgcGVyIElSUSkuCj4+Pgo+Pj4g
QWRkIGEgZ2VuZXJpYyBoZWxwZXIgZnVuY3Rpb24gd2hpY2ggaXMgYWJsZSB0byBtYXNrIGFuZCBz
ZXQgdGhlCj4+PiByZXNwZWN0aXZlIG51bWJlciBvZiBiaXRzLCBnaXZlbiB0aGUgSVJRIG51bWJl
ciBhbmQgdGhlIE1NSU8gb2Zmc2V0Lgo+Pj4gUHJvdmlkZSB3cmFwcGVycyB1c2luZyB0aGlzIGZ1
bmN0aW9uIHRvIGVhc2lseSBhbGxvdyBjb25maWd1cmluZyBhbiBJUlEuCj4+Pgo+Pj4gRm9yIG5v
dyBhc3N1bWUgdGhhdCBwcml2YXRlIElSUSBudW1iZXJzIGFsd2F5cyByZWZlciB0byB0aGUgY3Vy
cmVudCBDUFUuCj4+PiBJbiBhIEdJQ3YyIGFjY2Vzc2luZyB0aGUgIm90aGVyIiBwcml2YXRlIElS
UXMgaXMgbm90IGVhc2lseSBkb2FibGUgKHRoZQo+Pj4gcmVnaXN0ZXJzIGFyZSBiYW5rZWQgcGVy
IENQVSBvbiB0aGUgc2FtZSBNTUlPIGFkZHJlc3MpLCBzbyB3ZSBpbXBvc2UgdGhlCj4+PiBzYW1l
IGxpbWl0YXRpb24gb24gR0lDdjMsIGV2ZW4gdGhvdWdoIHRob3NlIHJlZ2lzdGVycyBhcmUgbm90
IGJhbmtlZAo+Pj4gdGhlcmUgYW55bW9yZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZSBQ
cnp5d2FyYSA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbT4KPj4+IC0tLQo+Pj4gIGxpYi9hcm0vYXNt
L2dpYy12My5oIHwgIDEgKwo+Pj4gIGxpYi9hcm0vYXNtL2dpYy5oICAgIHwgIDkgKysrKysKPj4+
ICBsaWIvYXJtL2dpYy5jICAgICAgICB8IDkwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKQo+
Pj4KPj4+IGRpZmYgLS1naXQgYS9saWIvYXJtL2FzbS9naWMtdjMuaCBiL2xpYi9hcm0vYXNtL2dp
Yy12My5oCj4+PiBpbmRleCBlZDZhNWFkLi44Y2ZhZWQxIDEwMDY0NAo+Pj4gLS0tIGEvbGliL2Fy
bS9hc20vZ2ljLXYzLmgKPj4+ICsrKyBiL2xpYi9hcm0vYXNtL2dpYy12My5oCj4+PiBAQCAtMjMs
NiArMjMsNyBAQAo+Pj4gICNkZWZpbmUgR0lDRF9DVExSX0VOQUJMRV9HMUEJCSgxVSA8PCAxKQo+
Pj4gICNkZWZpbmUgR0lDRF9DVExSX0VOQUJMRV9HMQkJKDFVIDw8IDApCj4+PiAgCj4+PiArI2Rl
ZmluZSBHSUNEX0lST1VURVIJCQkweDYwMDAKPj4+ICAjZGVmaW5lIEdJQ0RfUElEUjIJCQkweGZm
ZTgKPj4+ICAKPj4+ICAvKiBSZS1EaXN0cmlidXRvciByZWdpc3RlcnMsIG9mZnNldHMgZnJvbSBS
RF9iYXNlICovCj4+PiBkaWZmIC0tZ2l0IGEvbGliL2FybS9hc20vZ2ljLmggYi9saWIvYXJtL2Fz
bS9naWMuaAo+Pj4gaW5kZXggMWZjMTBhMC4uMjFjZGI1OCAxMDA2NDQKPj4+IC0tLSBhL2xpYi9h
cm0vYXNtL2dpYy5oCj4+PiArKysgYi9saWIvYXJtL2FzbS9naWMuaAo+Pj4gQEAgLTE1LDYgKzE1
LDcgQEAKPj4+ICAjZGVmaW5lIEdJQ0RfSUlEUgkJCTB4MDAwOAo+Pj4gICNkZWZpbmUgR0lDRF9J
R1JPVVBSCQkJMHgwMDgwCj4+PiAgI2RlZmluZSBHSUNEX0lTRU5BQkxFUgkJCTB4MDEwMAo+Pj4g
KyNkZWZpbmUgR0lDRF9JQ0VOQUJMRVIJCQkweDAxODAKPj4+ICAjZGVmaW5lIEdJQ0RfSVNQRU5E
UgkJCTB4MDIwMAo+Pj4gICNkZWZpbmUgR0lDRF9JQ1BFTkRSCQkJMHgwMjgwCj4+PiAgI2RlZmlu
ZSBHSUNEX0lTQUNUSVZFUgkJCTB4MDMwMAo+Pj4gQEAgLTczLDUgKzc0LDEzIEBAIGV4dGVybiB2
b2lkIGdpY193cml0ZV9lb2lyKHUzMiBpcnFzdGF0KTsKPj4+ICBleHRlcm4gdm9pZCBnaWNfaXBp
X3NlbmRfc2luZ2xlKGludCBpcnEsIGludCBjcHUpOwo+Pj4gIGV4dGVybiB2b2lkIGdpY19pcGlf
c2VuZF9tYXNrKGludCBpcnEsIGNvbnN0IGNwdW1hc2tfdCAqZGVzdCk7Cj4+PiAgCj4+PiArdm9p
ZCBnaWNfc2V0X2lycV9iaXQoaW50IGlycSwgaW50IG9mZnNldCk7Cj4+PiArdm9pZCBnaWNfZW5h
YmxlX2lycShpbnQgaXJxKTsKPj4+ICt2b2lkIGdpY19kaXNhYmxlX2lycShpbnQgaXJxKTsKPj4+
ICt2b2lkIGdpY19zZXRfaXJxX3ByaW9yaXR5KGludCBpcnEsIHU4IHByaW8pOwo+Pj4gK3ZvaWQg
Z2ljX3NldF9pcnFfdGFyZ2V0KGludCBpcnEsIGludCBjcHUpOwo+Pj4gK3ZvaWQgZ2ljX3NldF9p
cnFfZ3JvdXAoaW50IGlycSwgaW50IGdyb3VwKTsKPj4+ICtpbnQgZ2ljX2dldF9pcnFfZ3JvdXAo
aW50IGlycSk7Cj4+PiArCj4+PiAgI2VuZGlmIC8qICFfX0FTU0VNQkxZX18gKi8KPj4+ICAjZW5k
aWYgLyogX0FTTUFSTV9HSUNfSF8gKi8KPj4+IGRpZmYgLS1naXQgYS9saWIvYXJtL2dpYy5jIGIv
bGliL2FybS9naWMuYwo+Pj4gaW5kZXggOTQzMDExNi4uY2Y0ZTgxMSAxMDA2NDQKPj4+IC0tLSBh
L2xpYi9hcm0vZ2ljLmMKPj4+ICsrKyBiL2xpYi9hcm0vZ2ljLmMKPj4+IEBAIC0xNDYsMyArMTQ2
LDkzIEBAIHZvaWQgZ2ljX2lwaV9zZW5kX21hc2soaW50IGlycSwgY29uc3QgY3B1bWFza190ICpk
ZXN0KQo+Pj4gIAlhc3NlcnQoZ2ljX2NvbW1vbl9vcHMgJiYgZ2ljX2NvbW1vbl9vcHMtPmlwaV9z
ZW5kX21hc2spOwo+Pj4gIAlnaWNfY29tbW9uX29wcy0+aXBpX3NlbmRfbWFzayhpcnEsIGRlc3Qp
Owo+Pj4gIH0KPj4+ICsKPj4+ICtlbnVtIGdpY19iaXRfYWNjZXNzIHsKPj4+ICsJQUNDRVNTX1JF
QUQsCj4+PiArCUFDQ0VTU19TRVQsCj4+PiArCUFDQ0VTU19STVcKPj4+ICt9Owo+Pj4gKwo+Pj4g
K3N0YXRpYyB1OCBnaWNfbWFza2VkX2lycV9iaXRzKGludCBpcnEsIGludCBvZmZzZXQsIGludCBi
aXRzLCB1OCB2YWx1ZSwKPj4+ICsJCQkgICAgICBlbnVtIGdpY19iaXRfYWNjZXNzIGFjY2VzcykK
Pj4+ICt7Cj4+PiArCXZvaWQgKmJhc2U7Cj4+PiArCWludCBzcGxpdCA9IDMyIC8gYml0czsKPj4+
ICsJaW50IHNoaWZ0ID0gKGlycSAlIHNwbGl0KSAqIGJpdHM7Cj4+PiArCXUzMiByZWcsIG1hc2sg
PSAoKDFVIDw8IGJpdHMpIC0gMSkgPDwgc2hpZnQ7Cj4+PiArCj4+PiArCXN3aXRjaCAoZ2ljX3Zl
cnNpb24oKSkgewo+Pj4gKwljYXNlIDI6Cj4+PiArCQliYXNlID0gZ2ljdjJfZGlzdF9iYXNlKCk7
Cj4+PiArCQlicmVhazsKPj4+ICsJY2FzZSAzOgo+Pj4gKwkJaWYgKGlycSA8IDMyKQo+Pj4gKwkJ
CWJhc2UgPSBnaWN2M19zZ2lfYmFzZSgpOwo+Pj4gKwkJZWxzZQo+Pj4gKwkJCWJhc2UgPSBnaWN2
M19kaXN0X2Jhc2UoKTsKPj4+ICsJCWJyZWFrOwo+Pj4gKwlkZWZhdWx0Ogo+Pj4gKwkJcmV0dXJu
IDA7Cj4+PiArCX0KPj4+ICsJYmFzZSArPSBvZmZzZXQgKyAoaXJxIC8gc3BsaXQpICogNDsKPj4g
VGhpcyBpcyBwcm9iYWJseSBub3Qgd2hhdCB5b3UgaW50ZW5kZWQsIGlmIGlycSA9IDQgYW5kIHNw
bGl0ID0gOCwgKGlycSAvIHNwbGl0KSAqCj4+IDQgPSAwLiBPbiB0aGUgb3RoZXIgaGFuZCwgaXJx
ICogNCAvIHNwbGl0ID0gMi4KPiBJIHRoaW5rIHRoYXQncyBjb3JyZWN0LiBpZiBiaXRzID0gNCB0
aGlzIG1lYW5zIHRoZXJlIGFyZSA4IG9mIHN1Y2gKPiBmaWVsZHMgaW4gYSB3b3JkIGFuZCB0aGUg
ZmllbGQgY29ycmVzcG9uZGluZyB0byBpcnE9NCBpcyBpbmRlZWQgbG9jYXRlZAo+IGluIHdvcmQg
MC4KCllvdSdyZSByaWdodCwgSSBnb3QgY29uZnVzZWQgYWJvdXQgdGhlIDQuIE5vdyBJIHJlYWxp
emUgdGhhdCB0aGUgNCByZXByZXNlbnRzIHRoZQpzaXplIG9mIGEgcmVnaXN0ZXIuCgpUaGFua3Ms
CkFsZXgKPiBUaGFua3MKPgo+IEVyaWMKPj4+ICsKPj4+ICsJc3dpdGNoIChhY2Nlc3MpIHsKPj4+
ICsJY2FzZSBBQ0NFU1NfUkVBRDoKPj4+ICsJCXJldHVybiAocmVhZGwoYmFzZSkgJiBtYXNrKSA+
PiBzaGlmdDsKPj4+ICsJY2FzZSBBQ0NFU1NfU0VUOgo+Pj4gKwkJcmVnID0gMDsKPj4+ICsJCWJy
ZWFrOwo+Pj4gKwljYXNlIEFDQ0VTU19STVc6Cj4+PiArCQlyZWcgPSByZWFkbChiYXNlKSAmIH5t
YXNrOwo+Pj4gKwkJYnJlYWs7Cj4+PiArCX0KPj4+ICsKPj4+ICsJd3JpdGVsKHJlZyB8ICgodTMy
KXZhbHVlIDw8IHNoaWZ0KSwgYmFzZSk7Cj4+PiArCj4+PiArCXJldHVybiAwOwo+Pj4gK30KPj4g
VGhpcyBmdW5jdGlvbiBsb29rcyBhIGJpdCBvdXQgb2YgcGxhY2U6Cj4+IC0gdGhlIGZ1bmN0aW9u
IG5hbWUgaGFzIGEgdmVyYiBpbiB0aGUgcGFzdCB0ZW5zZSAoJ21hc2tlZCcpLCB3aGljaCBtYWtl
cyBtZSB0aGluawo+PiBpdCBzaG91bGQgcmV0dXJuIGEgYm9vbCwgYnV0IHRoZSBmdW5jdGlvbiBh
Y3R1YWxseSBwZXJmb3JtcyBhbiBhY2Nlc3MgdG8gYSBHSUMKPj4gcmVnaXN0ZXIuCj4+IC0gdGhl
IHJldHVybiB2YWx1ZSBpcyBhbiB1OCwgYnV0IGl0IHJldHVybnMgYW4gdTMyIG9uIGEgcmVhZCwg
YmVjYXVzZSByZWFkbAo+PiByZXR1cm5zIGFuIHUzMi4KPj4gLSB0aGUgc2VtYW50aWNzIG9mIHRo
ZSBmdW5jdGlvbiBhbmQgdGhlIHJldHVybiB2YWx1ZSBjaGFuZ2UgYmFzZWQgb24gdGhlIGFjY2Vz
cwo+PiBwYXJhbWV0ZXI7IHdvcnNlIHlldCwgdGhlIHJldHVybiB2YWx1ZSBvbiBhIHdyaXRlIGlz
IGNvbXBsZXRlbHkgaWdub3JlZCBieSB0aGUKPj4gY2FsbGVycyBhbmQgdGhlIHZhbHVlIHBhcmFt
ZXRlciBpcyBpZ25vcmVkIG9uIHJlYWRzLgo+Pgo+PiBZb3UgY291bGQgc3BsaXQgaXQgaW50byBz
ZXBhcmF0ZSBmdW5jdGlvbnMgLSBzZWUgYmVsb3cuCj4+Cj4+PiArCj4+PiArdm9pZCBnaWNfc2V0
X2lycV9iaXQoaW50IGlycSwgaW50IG9mZnNldCkKPj4+ICt7Cj4+PiArCWdpY19tYXNrZWRfaXJx
X2JpdHMoaXJxLCBvZmZzZXQsIDEsIDEsIEFDQ0VTU19TRVQpOwo+Pj4gK30KPj4+ICsKPj4+ICt2
b2lkIGdpY19lbmFibGVfaXJxKGludCBpcnEpCj4+PiArewo+Pj4gKwlnaWNfc2V0X2lycV9iaXQo
aXJxLCBHSUNEX0lTRU5BQkxFUik7Cj4+PiArfQo+Pj4gKwo+Pj4gK3ZvaWQgZ2ljX2Rpc2FibGVf
aXJxKGludCBpcnEpCj4+PiArewo+Pj4gKwlnaWNfc2V0X2lycV9iaXQoaXJxLCBHSUNEX0lDRU5B
QkxFUik7Cj4+PiArfQo+Pj4gKwo+Pj4gK3ZvaWQgZ2ljX3NldF9pcnFfcHJpb3JpdHkoaW50IGly
cSwgdTggcHJpbykKPj4+ICt7Cj4+PiArCWdpY19tYXNrZWRfaXJxX2JpdHMoaXJxLCBHSUNEX0lQ
UklPUklUWVIsIDgsIHByaW8sIEFDQ0VTU19STVcpOwo+Pj4gK30KPj4+ICsKPj4+ICt2b2lkIGdp
Y19zZXRfaXJxX3RhcmdldChpbnQgaXJxLCBpbnQgY3B1KQo+Pj4gK3sKPj4+ICsJaWYgKGlycSA8
IDMyKQo+Pj4gKwkJcmV0dXJuOwo+Pj4gKwo+Pj4gKwlpZiAoZ2ljX3ZlcnNpb24oKSA9PSAyKSB7
Cj4+PiArCQlnaWNfbWFza2VkX2lycV9iaXRzKGlycSwgR0lDRF9JVEFSR0VUU1IsIDgsIDFVIDw8
IGNwdSwKPj4+ICsJCQkJICAgIEFDQ0VTU19STVcpOwo+Pj4gKwo+Pj4gKwkJcmV0dXJuOwo+Pj4g
Kwl9Cj4+PiArCj4+PiArCXdyaXRlcShjcHVzW2NwdV0sIGdpY3YzX2Rpc3RfYmFzZSgpICsgR0lD
RF9JUk9VVEVSICsgaXJxICogOCk7Cj4+PiArfQo+Pj4gKwo+Pj4gK3ZvaWQgZ2ljX3NldF9pcnFf
Z3JvdXAoaW50IGlycSwgaW50IGdyb3VwKQo+Pj4gK3sKPj4+ICsJZ2ljX21hc2tlZF9pcnFfYml0
cyhpcnEsIEdJQ0RfSUdST1VQUiwgMSwgZ3JvdXAsIEFDQ0VTU19STVcpOwo+Pj4gK30KPj4+ICsK
Pj4+ICtpbnQgZ2ljX2dldF9pcnFfZ3JvdXAoaW50IGlycSkKPj4+ICt7Cj4+PiArCXJldHVybiBn
aWNfbWFza2VkX2lycV9iaXRzKGlycSwgR0lDRF9JR1JPVVBSLCAxLCAwLCBBQ0NFU1NfUkVBRCk7
Cj4+PiArfQo+PiBUaGUgcGF0dGVybiBmb3IgdGhlIHB1YmxpYyBmdW5jdGlvbnMgaW4gdGhpcyBm
aWxlIGlzIHRvIGNoZWNrIHRoYXQgdGhlIEdJQyBoYXMKPj4gYmVlbiBpbml0aWFsaXplZCAoYXNz
ZXJ0KGdpY19jb21tb25fb3BzKSkuCj4+Cj4+IEkgcHJvcG9zZSB3ZSByZXdyaXRlIHRoZSBmdW5j
dGlvbnMgbGlrZSB0aGlzIChjb21waWxlIHRlc3RlZCBvbmx5KToKPj4KPj4gZGlmZiAtLWdpdCBh
L2xpYi9hcm0vZ2ljLmMgYi9saWIvYXJtL2dpYy5jCj4+IGluZGV4IDk0MzAxMTY5MjE1Yy4uMWY1
YWE3YjQ4ODI4IDEwMDY0NAo+PiAtLS0gYS9saWIvYXJtL2dpYy5jCj4+ICsrKyBiL2xpYi9hcm0v
Z2ljLmMKPj4gQEAgLTE0NiwzICsxNDYsODkgQEAgdm9pZCBnaWNfaXBpX3NlbmRfbWFzayhpbnQg
aXJxLCBjb25zdCBjcHVtYXNrX3QgKmRlc3QpCj4+IMKgwqDCoMKgwqDCoMKgIGFzc2VydChnaWNf
Y29tbW9uX29wcyAmJiBnaWNfY29tbW9uX29wcy0+aXBpX3NlbmRfbWFzayk7Cj4+IMKgwqDCoMKg
wqDCoMKgIGdpY19jb21tb25fb3BzLT5pcGlfc2VuZF9tYXNrKGlycSwgZGVzdCk7Cj4+IMKgfQo+
PiArCj4+ICtzdGF0aWMgdm9pZCAqZ2ljX2dldF9pcnFfcmVnKGludCBpcnEsIGludCBvZmZzZXQs
IGludCB3aWR0aCkKPj4gK3sKPj4gK8KgwqDCoMKgwqDCoCB2b2lkICpiYXNlOwo+PiArCj4+ICvC
oMKgwqDCoMKgwqAgc3dpdGNoIChnaWNfdmVyc2lvbigpKSB7Cj4+ICvCoMKgwqDCoMKgwqAgY2Fz
ZSAyOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiYXNlID0gZ2ljdjJfZGlzdF9i
YXNlKCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiArwqDCoMKg
wqDCoMKgIGNhc2UgMzoKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlycSA8
IDMyKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFz
ZSA9IGdpY3YzX3NnaV9iYXNlKCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVs
c2UKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJhc2Ug
PSBnaWN2M19kaXN0X2Jhc2UoKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJl
YWs7Cj4+ICvCoMKgwqDCoMKgwqAgZGVmYXVsdDoKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIDA7Cj4+ICvCoMKgwqDCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqDCoMKgwqAg
cmV0dXJuIGJhc2UgKyBvZmZzZXQgKyAoaXJxICogd2lkdGggLyAzMik7Cj4+ICt9Cj4+ICsKPj4g
K3N0YXRpYyB2b2lkIGdpY19zZXRfaXJxX2ZpZWxkKGludCBpcnEsIGludCBvZmZzZXQsIGludCB3
aWR0aCwgdTMyIHZhbHVlKQo+PiArewo+PiArwqDCoMKgwqDCoMKgIHZvaWQgKnJlZzsKPj4gK8Kg
wqDCoMKgwqDCoCB1MzIgdmFsOwo+PiArwqDCoMKgwqDCoMKgIGludCBzaGlmdCA9IChpcnEgKiB3
aWR0aCkgJSAzMjsKPj4gK8KgwqDCoMKgwqDCoCB1MzIgbWFzayA9ICgoMVUgPDwgd2lkdGgpIC0g
MSkgPDwgc2hpZnQ7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCByZWcgPSBnaWNfZ2V0X2lycV9yZWco
aXJxLCBvZmZzZXQsIHdpZHRoKTsKPj4gK8KgwqDCoMKgwqDCoCB2YWwgPSByZWFkbChyZWcpOwo+
PiArwqDCoMKgwqDCoMKgIHZhbCA9ICh2YWwgJiB+bWFzaykgfCAodmFsdWUgPDwgc2hpZnQpOwo+
PiArwqDCoMKgwqDCoMKgIHdyaXRlbCh2YWwsIHJlZyk7Cj4+ICt9Cj4+ICsKPj4gK3ZvaWQgZ2lj
X2VuYWJsZV9pcnEoaW50IGlycSkKPj4gK3sKPj4gK8KgwqDCoMKgwqDCoCBhc3NlcnQoZ2ljX2Nv
bW1vbl9vcHMpOwo+PiArwqDCoMKgwqDCoMKgIGdpY19zZXRfaXJxX2ZpZWxkKGlycSwgR0lDRF9J
U0VOQUJMRVIsIDEsIDEpOwo+PiArfQo+PiArCj4+ICt2b2lkIGdpY19kaXNhYmxlX2lycShpbnQg
aXJxKQo+PiArewo+PiArwqDCoMKgwqDCoMKgIGFzc2VydChnaWNfY29tbW9uX29wcyk7Cj4+ICvC
oMKgwqDCoMKgwqAgZ2ljX3NldF9pcnFfZmllbGQoaXJxLCBHSUNEX0lDRU5BQkxFUiwgMSwgMSk7
Cj4+ICt9Cj4+ICsKPj4gK3ZvaWQgZ2ljX3NldF9pcnFfcHJpb3JpdHkoaW50IGlycSwgdTggcHJp
bykKPj4gK3sKPj4gK8KgwqDCoMKgwqDCoCBhc3NlcnQoZ2ljX2NvbW1vbl9vcHMpOwo+PiArwqDC
oMKgwqDCoMKgIGdpY19zZXRfaXJxX2ZpZWxkKGlycSwgR0lDRF9JUFJJT1JJVFlSLCA4LCBwcmlv
KTsKPj4gK30KPj4gKwo+PiArdm9pZCBnaWNfc2V0X2lycV90YXJnZXQoaW50IGlycSwgaW50IGNw
dSkKPj4gK3sKPj4gK8KgwqDCoMKgwqDCoCBhc3NlcnQoZ2ljX2NvbW1vbl9vcHMpOwo+PiArCj4+
ICvCoMKgwqDCoMKgwqAgaWYgKGlycSA8IDMyKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm47Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCBpZiAoZ2ljX3ZlcnNpb24oKSA9PSAy
KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdpY19zZXRfaXJxX2ZpZWxkKGly
cSwgR0lDRF9JVEFSR0VUU1IsIDgsIDFVIDw8IGNwdSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsKPj4gK8KgwqDCoMKgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoMKgwqDC
oCB3cml0ZXEoY3B1c1tjcHVdLCBnaWN2M19kaXN0X2Jhc2UoKSArIEdJQ0RfSVJPVVRFUiArIGly
cSAqIDgpOwo+PiArfQo+PiArCj4+ICt2b2lkIGdpY19zZXRfaXJxX2dyb3VwKGludCBpcnEsIGlu
dCBncm91cCkKPj4gK3sKPj4gK8KgwqDCoMKgwqDCoCBhc3NlcnQoZ2ljX2NvbW1vbl9vcHMpOwo+
PiArwqDCoMKgwqDCoMKgIGdpY19zZXRfaXJxX2ZpZWxkKGlycSwgR0lDRF9JR1JPVVBSLCAxLCAx
KTsKPj4gK30KPj4gKwo+PiAraW50IGdpY19nZXRfaXJxX2dyb3VwKGludCBpcnEpCj4+ICt7Cj4+
ICvCoMKgwqDCoMKgwqAgdm9pZCAqcmVnOwo+PiArwqDCoMKgwqDCoMKgIHUzMiB2YWw7Cj4+ICvC
oMKgwqDCoMKgwqAgaW50IHNoaWZ0ID0gaXJxICUgMzI7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoCBh
c3NlcnQoZ2ljX2NvbW1vbl9vcHMpOwo+PiArwqDCoMKgwqDCoMKgIHJlZyA9IGdpY19nZXRfaXJx
X3JlZyhpcnEsIEdJQ0RfSUdST1VQUiwgMSk7Cj4+ICvCoMKgwqDCoMKgwqAgdmFsID0gcmVhZGwo
cmVnKTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgIHJldHVybiAodmFsID4+IHNoaWZ0KSAmIDB4MTsK
Pj4gK30KPj4KPj4gQSBiaXQgbW9yZSBsaW5lcyBvZiBjb2RlLCBidXQgdG8gbWUgbW9yZSByZWFk
YWJsZS4gV2hhdCBkbyB5b3UgdGhpbms/Cj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+IGt2bWFybSBtYWlsaW5nIGxpc3QKPj4ga3ZtYXJt
QGxpc3RzLmNzLmNvbHVtYmlhLmVkdQo+PiBodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9t
YWlsbWFuL2xpc3RpbmZvL2t2bWFybQo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1
bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9r
dm1hcm0K
