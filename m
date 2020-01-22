Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD6C1453D4
	for <lists+kvmarm@lfdr.de>; Wed, 22 Jan 2020 12:30:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C54EA4A959;
	Wed, 22 Jan 2020 06:30:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gAiyxUaHEb9J; Wed, 22 Jan 2020 06:30:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A4774ACC4;
	Wed, 22 Jan 2020 06:30:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E4EB4AC86
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jan 2020 06:30:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9n6LhJmkPaUd for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jan 2020 06:30:03 -0500 (EST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E6F8C4A959
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jan 2020 06:30:02 -0500 (EST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DCEDA8B92F11E2311C26;
 Wed, 22 Jan 2020 19:29:59 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 19:29:49 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't confuse get_vlpi_map() by
 writing DB config
To: Marc Zyngier <maz@kernel.org>
References: <20200122085609.658-1-yuzenghui@huawei.com>
 <4aaaad3ae7367c5c932c430e18550d9e@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <06a484bd-4f46-6884-1bee-9b7b65fd0856@huawei.com>
Date: Wed, 22 Jan 2020 19:29:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4aaaad3ae7367c5c932c430e18550d9e@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: tglx@linutronix.de, kvmarm@lists.cs.columbia.edu, jason@lakedaemon.net,
 linux-kernel@vger.kernel.org
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

SGkgTWFyYywKCk9uIDIwMjAvMS8yMiAxODo0NCwgTWFyYyBaeW5naWVyIHdyb3RlOgo+IEhpIFpl
bmdodWksCj4gCj4gVGhhbmtzIGZvciB0aGlzLgo+IAo+IE9uIDIwMjAtMDEtMjIgMDg6NTYsIFpl
bmdodWkgWXUgd3JvdGU6Cj4+IFdoZW4gd2UncmUgd3JpdGluZyBjb25maWcgZm9yIHRoZSBkb29y
YmVsbCBpbnRlcnJ1cHQsIGdldF92bHBpX21hcCgpIHdpbGwKPj4gZ2V0IGNvbmZ1c2VkIGJ5IGRv
b3JiZWxsJ3MgZC0+cGFyZW50X2RhdGEgaGFjayBhbmQgZmluZCB0aGUgd3JvbmcgaXRzX2Rldgo+
PiBhcyBjaGlwIGRhdGEgYW5kIHRoZSB3cm9uZyBldmVudC4KPj4KPj4gRml4IHRoaXMgaXNzdWUg
YnkgbWFraW5nIHN1cmUgbm8gZG9vcmJlbGxzIHdpbGwgYmUgaW52b2x2ZWQgYmVmb3JlIAo+PiBp
bnZva2luZwo+PiBnZXRfdmxwaV9tYXAoKSwgd2hpY2ggcmVzdG9yZSBzb21lIG9mIHRoZSBsb2dp
YyBpbiBscGlfd3JpdGVfY29uZmlnKCkuCj4+Cj4+IEZpeGVzOiBjMWQ0ZDVjZDIwM2MgKCJpcnFj
aGlwL2dpYy12My1pdHM6IEFkZCBpdHNfdmxwaV9tYXAgaGVscGVycyIpCj4+IFNpZ25lZC1vZmYt
Ynk6IFplbmdodWkgWXUgPHl1emVuZ2h1aUBodWF3ZWkuY29tPgo+PiAtLS0KPj4KPj4gVGhpcyBp
cyBiYXNlZCBvbiBtYWlubGluZSBhbmQgY2FuJ3QgYmUgZGlyZWN0bHkgYXBwbGllZCB0byB0aGUg
Y3VycmVudAo+PiBpcnFjaGlwLW5leHQuCj4+Cj4+IMKgZHJpdmVycy9pcnFjaGlwL2lycS1naWMt
djMtaXRzLmMgfCA1ICsrKy0tCj4+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2lj
LXYzLWl0cy5jIAo+PiBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy5jCj4+IGluZGV4
IGUwNTY3M2JjZDUyYi4uY2M4YTRmY2JkNmQ2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lycWNo
aXAvaXJxLWdpYy12My1pdHMuYwo+PiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1p
dHMuYwo+PiBAQCAtMTE4MSwxMiArMTE4MSwxMyBAQCBzdGF0aWMgc3RydWN0IGl0c192bHBpX21h
cAo+PiAqZ2V0X3ZscGlfbWFwKHN0cnVjdCBpcnFfZGF0YSAqZCkKPj4KPj4gwqBzdGF0aWMgdm9p
ZCBscGlfd3JpdGVfY29uZmlnKHN0cnVjdCBpcnFfZGF0YSAqZCwgdTggY2xyLCB1OCBzZXQpCj4+
IMKgewo+PiAtwqDCoMKgIHN0cnVjdCBpdHNfdmxwaV9tYXAgKm1hcCA9IGdldF92bHBpX21hcChk
KTsKPj4gwqDCoMKgwqAgaXJxX2h3X251bWJlcl90IGh3aXJxOwo+PiDCoMKgwqDCoCB2b2lkICp2
YTsKPj4gwqDCoMKgwqAgdTggKmNmZzsKPj4KPj4gLcKgwqDCoCBpZiAobWFwKSB7Cj4+ICvCoMKg
wqAgaWYgKGlycWRfaXNfZm9yd2FyZGVkX3RvX3ZjcHUoZCkpIHsKPj4gK8KgwqDCoMKgwqDCoMKg
IHN0cnVjdCBpdHNfdmxwaV9tYXAgKm1hcCA9IGdldF92bHBpX21hcChkKTsKPj4gKwo+PiDCoMKg
wqDCoMKgwqDCoMKgIHZhID0gcGFnZV9hZGRyZXNzKG1hcC0+dm0tPnZwcm9wX3BhZ2UpOwo+PiDC
oMKgwqDCoMKgwqDCoMKgIGh3aXJxID0gbWFwLT52aW50aWQ7Cj4gCj4gU2hvdWxkbid0IHdlIGZp
eCBnZXRfdmxwaV9tYXAoKSBpbnN0ZWFkPyBTb21ldGhpbmcgbGlrZSAodW50ZXN0ZWQpOgo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYyAKPiBiL2RyaXZl
cnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy5jCj4gaW5kZXggZTA1NjczYmNkNTJiLi5iNzA0MjE0
MzkwYzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmMKPiAr
KysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYwo+IEBAIC0xMTcwLDEzICsxMTcw
LDE0IEBAIHN0YXRpYyB2b2lkIGl0c19zZW5kX3ZjbGVhcihzdHJ1Y3QgaXRzX2RldmljZSAKPiAq
ZGV2LCB1MzIgZXZlbnRfaWQpCj4gIMKgICovCj4gIMKgc3RhdGljIHN0cnVjdCBpdHNfdmxwaV9t
YXAgKmdldF92bHBpX21hcChzdHJ1Y3QgaXJxX2RhdGEgKmQpCj4gIMKgewo+IC3CoMKgwqAgc3Ry
dWN0IGl0c19kZXZpY2UgKml0c19kZXYgPSBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkKTsK
PiAtwqDCoMKgIHUzMiBldmVudCA9IGl0c19nZXRfZXZlbnRfaWQoZCk7Cj4gK8KgwqDCoCBpZiAo
aXJxZF9pc19mb3J3YXJkZWRfdG9fdmNwdShkKSkgewo+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
aXRzX2RldmljZSAqaXRzX2RldiA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGQpOwo+ICvC
oMKgwqDCoMKgwqDCoCB1MzIgZXZlbnQgPSBpdHNfZ2V0X2V2ZW50X2lkKGQpOwo+IAo+IC3CoMKg
wqAgaWYgKCFpcnFkX2lzX2ZvcndhcmRlZF90b192Y3B1KGQpKQo+IC3CoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gTlVMTDsKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGRldl9ldmVudF90b192bHBpX21h
cChpdHNfZGV2LCBldmVudCk7Cj4gK8KgwqDCoCB9Cj4gCj4gLcKgwqDCoCByZXR1cm4gZGV2X2V2
ZW50X3RvX3ZscGlfbWFwKGl0c19kZXYsIGV2ZW50KTsKPiArwqDCoMKgIHJldHVybiBOVUxMOwo+
ICDCoH0KPiAKPiAgwqBzdGF0aWMgdm9pZCBscGlfd3JpdGVfY29uZmlnKHN0cnVjdCBpcnFfZGF0
YSAqZCwgdTggY2xyLCB1OCBzZXQpCj4gCj4gCj4gT3IgYW0gSSBtaXNzaW5nIHRoZSBhY3R1YWwg
cHJvYmxlbT8KCk5vLiBJIGFsc28gdGhvdWdodCBhYm91dCBmaXhpbmcgdGhlIGlzc3VlIGJ5IHRo
aXMgd2F5IGFuZCBJJ20gT0sgd2l0aApib3RoIGFwcHJvYWNoZXMuCgo+IAo+IE92ZXJhbGwsIEkn
bSBzdGFydGluZyB0byBoYXRlIHRoYXQgLT5wYXJlbnQgaGFjayBhcyBpdCdzIGJlZW4gdGhlIHNv
dXJjZQo+IG9mIGEgbnVtYmVyIG9mIGJ1Z3MuCgoodGhhbmtmdWxseSBpdCdzIHJhcmVseSB1c2Vk
IGFuZCB3ZSd2ZSBzbyBmYXIgaGFuZGxlZCB0aGVtIGNhcmVmdWxseSwKZXhjZXB0IHRoZSBscGlf
d3JpdGVfY29uZmlnIGlzc3VlIGluIHRoaXMgcGF0Y2guLi4pCgo+IAo+IFRoZSBtYWluIGlzc3Vl
IGlzIHRoYXQgdGhlIFZQRSBoaWVyYXJjaHkgaXMgbWlzc2luZyBvbmUgbGV2ZWwgKGl0IGhhcwo+
IG5vIElUUyBkb21haW4sIGFuZCBnb2VzIGRpcmVjdGx5IGZyb20gdGhlIFZQRSBkb21haW4gdG8g
dGhlIGxvdy1sZXZlbAo+IEdJQyBkb21haW4pLiBJdCBtZWFucyB3ZSBlbmQtdXAgc3BlY2lhbC1j
YXNpbmcgdGhpbmdzLCBhbmQgdGhhdCdzIG5ldmVyCj4gZ29vZC4uLgoKWWVhaCwgdGhpcyBtYXkg
Y29tZXMgZnJvbSB0aGUgZmFjdCB0aGF0IHRoZSBwZXItdlBFIGRvb3JiZWxsIGlzIG5vdApzZXJ2
ZWQgYnkgSVRTIGFuZCBjYW4gYmUgYXNzZXJ0ZWQgYnkgcmVkaXN0cmlidXRvciBkaXJlY3RseS4g
QW5kIHRoZQpzcGVjaWFsIGRvb3JiZWxsIGlzIHByb2dyYW1tZWQgdG9nZXRoZXIgd2l0aCB0aG9z
ZSBub3JtYWwgTFBJCih0cmFuc2xhdGVkIGZyb20gTVNJIGJ5IElUUykuCgoKVGhhbmtzLApaZW5n
aHVpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1h
cm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0
cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
