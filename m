Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D95CC2C6F6D
	for <lists+kvmarm@lfdr.de>; Sat, 28 Nov 2020 11:38:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 70B584D7BC;
	Sat, 28 Nov 2020 05:38:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogi-TPnvA0tk; Sat, 28 Nov 2020 05:38:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 950894D7C4;
	Sat, 28 Nov 2020 05:38:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1FFDB4F017
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Nov 2020 21:38:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jRha5EhMRO1n for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Nov 2020 21:38:15 -0500 (EST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C77784F001
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Nov 2020 21:38:14 -0500 (EST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CjbJ51R0yzkhWs;
 Sat, 28 Nov 2020 10:37:41 +0800 (CST)
Received: from [10.174.187.74] (10.174.187.74) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 10:38:01 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Optimize the wait for the completion of
 the analysis of the VPT
To: Marc Zyngier <maz@kernel.org>
References: <20200923063543.1920-1-lushenming@huawei.com>
 <7d0c6bfe7485094154a05bfb2de03640@kernel.org>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <6713e563-f037-f512-a3ce-801599114776@huawei.com>
Date: Sat, 28 Nov 2020 10:38:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <7d0c6bfe7485094154a05bfb2de03640@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.187.74]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sat, 28 Nov 2020 05:38:32 -0500
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

T24gMjAyMC8xMS8yOCAzOjM1LCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gU2hlbm1pbmcsCj4gCj4g
U29tZWhvdyB0aGlzIHBhdGNoIGVuZGVkIHVwIGluIHRoZSB3cm9uZyBmb2xkZXIuCj4gQXBvbG9n
aWVzIGZvciB0aGUgZGVsYXkgcmV2aWV3aW5nIGl0Lj4KPiBPbiAyMDIwLTA5LTIzIDA3OjM1LCBT
aGVubWluZyBMdSB3cm90ZToKPj4gUmlnaHQgYWZ0ZXIgYSB2UEUgaXMgbWFkZSByZXNpZGVudCwg
dGhlIGNvZGUgc3RhcnRzIHBvbGxpbmcgdGhlCj4+IEdJQ1JfVlBFTkRCQVNFUi5EaXJ0eSBiaXQg
dW50aWwgaXQgYmVjb21lcyAwLCB3aGVyZSB0aGUgZGVsYXlfdXMKPj4gaXMgc2V0IHRvIDEwLiBC
dXQgaW4gb3VyIG1lYXN1cmVtZW50LCBpdCB0YWtlcyBvbmx5IGh1bmRyZWRzIG9mCj4+IG5hbm9z
ZWNvbmRzLCBvciAxfjIgbWljcm9zZWNvbmRzLCB0byBmaW5pc2ggcGFyc2luZyB0aGUgVlBUIGlu
IG1vc3QKPj4gY2FzZXMuIEFuZCB3ZSBhbHNvIG1lYXN1cmVkIHRoZSB0aW1lIGZyb20gdmNwdV9s
b2FkKCkgKGluY2x1ZGUgaXQpCj4+IHRvIF9fZ3Vlc3RfZW50ZXIoKSBvbiBLdW5wZW5nIDkyMC4g
T24gYXZlcmFnZSwgaXQgdGFrZXMgMi41NSBtaWNyb3NlY29uZHMKPj4gKG5vdCBmaXJzdCBydW4g
JiYgdGhlIFZQVCBpcyBlbXB0eSkuIFNvIDEwIG1pY3Jvc2Vjb25kcyBkZWxheSBtaWdodAo+PiBy
ZWFsbHkgaHVydCBwZXJmb3JtYW5jZS4KPj4KPj4gVG8gYXZvaWQgdGhpcywgd2UgY2FuIHNldCB0
aGUgZGVsYXlfdXMgdG8gMSwgd2hpY2ggaXMgbW9yZSBhcHByb3ByaWF0ZQo+PiBpbiB0aGlzIHNp
dHVhdGlvbiBhbmQgdW5pdmVyc2FsLiBCZXNpZGVzLCB3ZSBjYW4gZGVsYXkgdGhlIGV4ZWN1dGlv
bgo+PiBvZiBpdHNfd2FpdF92cHRfcGFyc2VfY29tcGxldGUoKSAoY2FsbCBpdCBmcm9tIGt2bV92
Z2ljX2ZsdXNoX2h3c3RhdGUoKQo+PiBjb3JyZXNwb25kaW5nIHRvIHZQRSByZXNpZGVudCksIGdp
dmluZyB0aGUgR0lDIGEgY2hhbmNlIHRvIHdvcmsgaW4KPj4gcGFyYWxsZWwgd2l0aCB0aGUgQ1BV
IG9uIHRoZSBlbnRyeSBwYXRoLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTaGVubWluZyBMdSA8bHVz
aGVubWluZ0BodWF3ZWkuY29tPgo+PiAtLS0KPj4gwqBhcmNoL2FybTY0L2t2bS92Z2ljL3ZnaWMt
djQuY8KgwqDCoMKgwqAgfCAxOCArKysrKysrKysrKysrKysrKysKPj4gwqBhcmNoL2FybTY0L2t2
bS92Z2ljL3ZnaWMuY8KgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKysKPj4gwqBkcml2ZXJzL2lycWNo
aXAvaXJxLWdpYy12My1pdHMuY8KgwqAgfCAxNCArKysrKysrKysrKy0tLQo+PiDCoGRyaXZlcnMv
aXJxY2hpcC9pcnEtZ2ljLXY0LmPCoMKgwqDCoMKgwqAgfCAxMSArKysrKysrKysrKwo+PiDCoGlu
Y2x1ZGUva3ZtL2FybV92Z2ljLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysrCj4+
IMKgaW5jbHVkZS9saW51eC9pcnFjaGlwL2FybS1naWMtdjQuaCB8wqAgNCArKysrCj4+IMKgNiBm
aWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9rdm0vdmdpYy92Z2ljLXY0LmMgYi9hcmNoL2FybTY0L2t2bS92
Z2ljL3ZnaWMtdjQuYwo+PiBpbmRleCBiNWZhNzNjOWZkMzUuLjFkNWQyZDY4OTRkMyAxMDA2NDQK
Pj4gLS0tIGEvYXJjaC9hcm02NC9rdm0vdmdpYy92Z2ljLXY0LmMKPj4gKysrIGIvYXJjaC9hcm02
NC9rdm0vdmdpYy92Z2ljLXY0LmMKPj4gQEAgLTM1Myw2ICszNTMsMjQgQEAgaW50IHZnaWNfdjRf
bG9hZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCj4+IMKgwqDCoMKgIHJldHVybiBlcnI7Cj4+IMKg
fQo+Pgo+PiArdm9pZCB2Z2ljX3Y0X3dhaXRfdnB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKPiAK
PiBJJ2QgbGlrZSBzb21ldGhpbmcgYSBiaXQgbW9yZSBhYnN0cmFjdCBhcyBhIG5hbWUuCj4gCj4g
dmdpY192NF9jb21taXQoKSBzZWVtcyBtb3JlIGFwcHJvcHJpYXRlLCBhbmQgY291bGQgYmUgdXNl
ZCBmb3Igb3RoZXIKPiBwdXJwb3Nlcy4KClllcywgaXQgbG9va3MgbW9yZSBhcHByb3ByaWF0ZS4K
Cj4gCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IGl0c192cGUgKnZwZTsKPj4gKwo+PiArwqDCoMKg
IGlmIChrdm1fdmdpY19nbG9iYWxfc3RhdGUudHlwZSA9PSBWR0lDX1YyIHx8Cj4gCj4gV2h5IGRv
IHlvdSB0ZXN0IGZvciBHSUN2Mj8gSXNuJ3QgdGhlIHZnaWNfc3VwcG9ydHNfZGlyZWN0X21zaXMo
KSB0ZXN0IGVub3VnaD8KPiBBbmQgdGhlIHRlc3Qgc2hvdWxkIGJlIG1vdmVkIHRvIGt2bV92Z2lj
X2ZsdXNoX2h3c3RhdGUoKSwgYXMgd2UgYWxyZWFkeSBoYXZlCj4gc2ltaWxhciBjaGVja3MgdGhl
cmUuCgpZZXMsIHRoZSB0ZXN0IGZvciBHSUN2MiBpcyB1bm5lY2Vzc2FyeS4uLi4gSSB3aWxsIGNv
cnJlY3QgaXQuCgo+IAo+PiAhdmdpY19zdXBwb3J0c19kaXJlY3RfbXNpcyh2Y3B1LT5rdm0pKQo+
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+PiArCj4+ICvCoMKgwqAgdnBlID0gJnZjcHUtPmFy
Y2gudmdpY19jcHUudmdpY192My5pdHNfdnBlOwo+PiArCj4+ICvCoMKgwqAgaWYgKHZwZS0+dnB0
X3JlYWR5KQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+PiArCj4+ICvCoMKgwqAgaWYgKGl0
c193YWl0X3ZwdCh2cGUpKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+IAo+IEhvdyBjYW4g
dGhhdCBoYXBwZW4/CgpZZXMsIGl0IHNlZW1zIHRoYXQgaXRzX3dhaXRfdnB0KCkgd291bGQgYWx3
YXlzIHJldHVybiAwLgoKPiAKPj4gKwo+PiArwqDCoMKgIHZwZS0+dnB0X3JlYWR5ID0gdHJ1ZTsK
PiAKPiBUaGlzIGlzIG5hc3R5LiBZb3UgbmVlZCB0byBleHBsYWluIHdoYXQgaGFwcGVucyB3aXRo
IHRoaXMgc3RhdGUgKHlvdSBhcmUKPiB0cnlpbmcgbm90IHRvIGFjY2VzcyBWUEVOREJBU0VSIGFj
cm9zcyBhIHNoYWxsb3cgZXhpdCwgYXMgb25seSBhIHZjcHVfcHV0CgpPaywgSSB3aWxsIGFkZCBh
IGNvbW1lbnQgaGVyZS4KCj4gd2lsbCBpbnZhbGlkYXRlIHRoZSBHSUMgc3RhdGUpLiBBbmQgc29t
ZXRoaW5nIGxpa2UgdnBlX3JlYWR5IGlzIG1vcmUKPiBnZW5lcmljICh3ZSB0cnkgbm90IHRvIGhh
dmUgdG9vIG11Y2ggb2YgdGhlIEdJQ3Y0IGd1bmsgaW4gdGhlIEtWTSBjb2RlKS4KClllcywgdGhh
dCdzIGJldHRlci4KCj4gCj4+ICt9Cj4+ICsKPj4gwqBzdGF0aWMgc3RydWN0IHZnaWNfaXRzICp2
Z2ljX2dldF9pdHMoc3RydWN0IGt2bSAqa3ZtLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGt2bV9rZXJuZWxfaXJxX3JvdXRpbmdfZW50cnkgKmly
cV9lbnRyeSkKPj4gwqB7Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2t2bS92Z2ljL3ZnaWMu
YyBiL2FyY2gvYXJtNjQva3ZtL3ZnaWMvdmdpYy5jCj4+IGluZGV4IGMzNjQzYjdmMTAxYi4uZWQ4
MTBhODBjZGEyIDEwMDY0NAo+PiAtLS0gYS9hcmNoL2FybTY0L2t2bS92Z2ljL3ZnaWMuYwo+PiAr
KysgYi9hcmNoL2FybTY0L2t2bS92Z2ljL3ZnaWMuYwo+PiBAQCAtOTE1LDYgKzkxNSw4IEBAIHZv
aWQga3ZtX3ZnaWNfZmx1c2hfaHdzdGF0ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCj4+Cj4+IMKg
wqDCoMKgIGlmIChjYW5fYWNjZXNzX3ZnaWNfZnJvbV9rZXJuZWwoKSkKPj4gwqDCoMKgwqDCoMKg
wqDCoCB2Z2ljX3Jlc3RvcmVfc3RhdGUodmNwdSk7Cj4+ICsKPj4gK8KgwqDCoCB2Z2ljX3Y0X3dh
aXRfdnB0KHZjcHUpOwo+PiDCoH0KPj4KPj4gwqB2b2lkIGt2bV92Z2ljX2xvYWQoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1KQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMt
aXRzLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYwo+PiBpbmRleCA1NDhkZTc1
Mzg2MzIuLmI3Y2JjOWJjYWI5ZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1n
aWMtdjMtaXRzLmMKPj4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmMKPj4g
QEAgLTM4MDMsNyArMzgwMyw3IEBAIHN0YXRpYyB2b2lkIGl0c193YWl0X3ZwdF9wYXJzZV9jb21w
bGV0ZSh2b2lkKQo+PiDCoMKgwqDCoCBXQVJOX09OX09OQ0UocmVhZHFfcmVsYXhlZF9wb2xsX3Rp
bWVvdXRfYXRvbWljKHZscGlfYmFzZSArIEdJQ1JfVlBFTkRCQVNFUiwKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsLAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAhKHZhbCAmIEdJQ1JfVlBFTkRCQVNFUl9EaXJ0eSksCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTAsIDUwMCkp
Owo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDEsIDUwMCkpOwo+IAo+IFRoaXMgcmVhbGx5IHNob3VsZCBiZSBpbiBhIHNlcGFy
YXRlIHBhdGNoLgoKT2ssIEkgd2lsbCBzZXBhcmF0ZSBpdC4KCj4gCj4+IMKgfQo+Pgo+PiDCoHN0
YXRpYyB2b2lkIGl0c192cGVfc2NoZWR1bGUoc3RydWN0IGl0c192cGUgKnZwZSkKPj4gQEAgLTM4
MzcsNyArMzgzNyw3IEBAIHN0YXRpYyB2b2lkIGl0c192cGVfc2NoZWR1bGUoc3RydWN0IGl0c192
cGUgKnZwZSkKPj4gwqDCoMKgwqAgdmFsIHw9IEdJQ1JfVlBFTkRCQVNFUl9WYWxpZDsKPj4gwqDC
oMKgwqAgZ2ljcl93cml0ZV92cGVuZGJhc2VyKHZhbCwgdmxwaV9iYXNlICsgR0lDUl9WUEVOREJB
U0VSKTsKPj4KPj4gLcKgwqDCoCBpdHNfd2FpdF92cHRfcGFyc2VfY29tcGxldGUoKTsKPj4gK8Kg
wqDCoCB2cGUtPnZwdF9yZWFkeSA9IGZhbHNlOwo+IAo+IFRoaXMgcmVhbGx5IGJlbG9uZ3MgdG8g
dGhlIGRlc2NoZWR1bGUgcGF0aCwgZG9lc24ndCBpdD8gR2l2ZW4gdGhhdAo+IGl0IGNhbiBvbmx5
IGJlIHNldCBmcm9tIHZnaWNfZmx1c2hfaHdzdGF0ZSgpLCBpdCBzaG91bGQgYmUgZmFpcmx5Cj4g
Zm9vbHByb29mLgoKWWVzLCB0aGF0J3MgYmV0dGVyLgoKPiAKPj4gwqB9Cj4+Cj4+IMKgc3RhdGlj
IHZvaWQgaXRzX3ZwZV9kZXNjaGVkdWxlKHN0cnVjdCBpdHNfdnBlICp2cGUpCj4+IEBAIC0zODgx
LDYgKzM4ODEsMTAgQEAgc3RhdGljIGludCBpdHNfdnBlX3NldF92Y3B1X2FmZmluaXR5KHN0cnVj
dAo+PiBpcnFfZGF0YSAqZCwgdm9pZCAqdmNwdV9pbmZvKQo+PiDCoMKgwqDCoMKgwqDCoMKgIGl0
c192cGVfc2NoZWR1bGUodnBlKTsKPj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4KPj4g
K8KgwqDCoCBjYXNlIFdBSVRfVlBUOgo+IAo+IENPTU1JVF9WUEUgc2VlbXMgYSBiZXR0ZXIgbmFt
ZS4KClllcywgdGhhdCdzIGJldHRlci4KCj4gCj4+ICvCoMKgwqDCoMKgwqDCoCBpdHNfd2FpdF92
cHRfcGFyc2VfY29tcGxldGUoKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiArCj4+
IMKgwqDCoMKgIGNhc2UgREVTQ0hFRFVMRV9WUEU6Cj4+IMKgwqDCoMKgwqDCoMKgwqAgaXRzX3Zw
ZV9kZXNjaGVkdWxlKHZwZSk7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IEBAIC00
MDQ3LDcgKzQwNTEsNyBAQCBzdGF0aWMgdm9pZCBpdHNfdnBlXzRfMV9zY2hlZHVsZShzdHJ1Y3Qg
aXRzX3ZwZSAqdnBlLAo+Pgo+PiDCoMKgwqDCoCBnaWNyX3dyaXRlX3ZwZW5kYmFzZXIodmFsLCB2
bHBpX2Jhc2UgKyBHSUNSX1ZQRU5EQkFTRVIpOwo+Pgo+PiAtwqDCoMKgIGl0c193YWl0X3ZwdF9w
YXJzZV9jb21wbGV0ZSgpOwo+PiArwqDCoMKgIHZwZS0+dnB0X3JlYWR5ID0gZmFsc2U7Cj4+IMKg
fQo+Pgo+PiDCoHN0YXRpYyB2b2lkIGl0c192cGVfNF8xX2Rlc2NoZWR1bGUoc3RydWN0IGl0c192
cGUgKnZwZSwKPj4gQEAgLTQxMTgsNiArNDEyMiwxMCBAQCBzdGF0aWMgaW50IGl0c192cGVfNF8x
X3NldF92Y3B1X2FmZmluaXR5KHN0cnVjdAo+PiBpcnFfZGF0YSAqZCwgdm9pZCAqdmNwdV9pbmZv
KQo+PiDCoMKgwqDCoMKgwqDCoMKgIGl0c192cGVfNF8xX3NjaGVkdWxlKHZwZSwgaW5mbyk7Cj4+
IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Cj4+ICvCoMKgwqAgY2FzZSBXQUlUX1ZQVDoK
Pj4gK8KgwqDCoMKgwqDCoMKgIGl0c193YWl0X3ZwdF9wYXJzZV9jb21wbGV0ZSgpOwo+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+ICsKPj4gwqDCoMKgwqAgY2FzZSBERVNDSEVEVUxFX1ZQ
RToKPj4gwqDCoMKgwqDCoMKgwqDCoCBpdHNfdnBlXzRfMV9kZXNjaGVkdWxlKHZwZSwgaW5mbyk7
Cj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ly
cWNoaXAvaXJxLWdpYy12NC5jIGIvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjQuYwo+PiBpbmRl
eCAwYzE4NzE0YWUxM2UuLjM2YmU0MjU2OTg3MiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pcnFj
aGlwL2lycS1naWMtdjQuYwo+PiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12NC5jCj4+
IEBAIC0yNTgsNiArMjU4LDE3IEBAIGludCBpdHNfbWFrZV92cGVfcmVzaWRlbnQoc3RydWN0IGl0
c192cGUgKnZwZSwKPj4gYm9vbCBnMGVuLCBib29sIGcxZW4pCj4+IMKgwqDCoMKgIHJldHVybiBy
ZXQ7Cj4+IMKgfQo+Pgo+PiAraW50IGl0c193YWl0X3ZwdChzdHJ1Y3QgaXRzX3ZwZSAqdnBlKQo+
IAo+IGl0c19jb21taXRfdnBlKCkKPiAKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgaXRzX2NtZF9p
bmZvIGluZm8gPSB7IH07Cj4+ICsKPj4gK8KgwqDCoCBXQVJOX09OKHByZWVtcHRpYmxlKCkpOwo+
PiArCj4+ICvCoMKgwqAgaW5mby5jbWRfdHlwZSA9IFdBSVRfVlBUOwo+IAo+IFBsZWFzZSB3cml0
ZSBpdCBhczoKPiAKPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaXRzX2NtZF9pbmZvID0gewo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuY21kX3R5cGUgPSBDT01NSVRfVlBFLAo+IMKg
wqDCoMKgwqDCoMKgIH07Cj4gCj4gYXMgZm9yIG1vc3Qgb2YgdGhlIGNvbW1hbmRzLgoKT2ssIEkg
d2lsbCBjb3JyZWN0IGl0LgoKPiAKPj4gKwo+PiArwqDCoMKgIHJldHVybiBpdHNfc2VuZF92cGVf
Y21kKHZwZSwgJmluZm8pOwo+PiArfQo+PiArCj4+IMKgaW50IGl0c19pbnZhbGxfdnBlKHN0cnVj
dCBpdHNfdnBlICp2cGUpCj4+IMKgewo+PiDCoMKgwqDCoCBzdHJ1Y3QgaXRzX2NtZF9pbmZvIGlu
Zm8gPSB7Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2t2bS9hcm1fdmdpYy5oIGIvaW5jbHVkZS9r
dm0vYXJtX3ZnaWMuaAo+PiBpbmRleCBhOGQ4ZmRjZDM3MjMuLmI1NWE4MzVkMjhhOCAxMDA2NDQK
Pj4gLS0tIGEvaW5jbHVkZS9rdm0vYXJtX3ZnaWMuaAo+PiArKysgYi9pbmNsdWRlL2t2bS9hcm1f
dmdpYy5oCj4+IEBAIC00MDIsNiArNDAyLDkgQEAgaW50IGt2bV92Z2ljX3Y0X3Vuc2V0X2Zvcndh
cmRpbmcoc3RydWN0IGt2bSAqa3ZtLCBpbnQgaXJxLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBrdm1fa2VybmVsX2lycV9yb3V0aW5nX2VudHJ5ICppcnFfZW50
cnkpOwo+Pgo+PiDCoGludCB2Z2ljX3Y0X2xvYWQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKPj4g
Kwo+PiArdm9pZCB2Z2ljX3Y0X3dhaXRfdnB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7Cj4+ICsK
Pj4gwqBpbnQgdmdpY192NF9wdXQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIG5lZWRfZGIp
Owo+Pgo+PiDCoCNlbmRpZiAvKiBfX0tWTV9BUk1fVkdJQ19IICovCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2lycWNoaXAvYXJtLWdpYy12NC5oCj4+IGIvaW5jbHVkZS9saW51eC9pcnFj
aGlwL2FybS1naWMtdjQuaAo+PiBpbmRleCA2OTc2YjgzMzFiNjAuLjY4YWMyYjdiOTMwOSAxMDA2
NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9pcnFjaGlwL2FybS1naWMtdjQuaAo+PiArKysgYi9p
bmNsdWRlL2xpbnV4L2lycWNoaXAvYXJtLWdpYy12NC5oCj4+IEBAIC03NSw2ICs3NSw4IEBAIHN0
cnVjdCBpdHNfdnBlIHsKPj4gwqDCoMKgwqAgdTE2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2cGVf
aWQ7Cj4+IMKgwqDCoMKgIC8qIFBlbmRpbmcgVkxQSXMgb24gc2NoZWR1bGUgb3V0PyAqLwo+PiDC
oMKgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZW5kaW5nX2xhc3Q7Cj4+ICvCoMKg
wqAgLyogVlBUIHBhcnNlIGNvbXBsZXRlICovCj4+ICvCoMKgwqAgYm9vbMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdnB0X3JlYWR5Owo+PiDCoH07Cj4+Cj4+IMKgLyoKPj4gQEAgLTEwMyw2ICsxMDUs
NyBAQCBlbnVtIGl0c192Y3B1X2luZm9fY21kX3R5cGUgewo+PiDCoMKgwqDCoCBQUk9QX1VQREFU
RV9WTFBJLAo+PiDCoMKgwqDCoCBQUk9QX1VQREFURV9BTkRfSU5WX1ZMUEksCj4+IMKgwqDCoMKg
IFNDSEVEVUxFX1ZQRSwKPj4gK8KgwqDCoCBXQUlUX1ZQVCwKPj4gwqDCoMKgwqAgREVTQ0hFRFVM
RV9WUEUsCj4+IMKgwqDCoMKgIElOVkFMTF9WUEUsCj4+IMKgwqDCoMKgIFBST1BfVVBEQVRFX1ZT
R0ksCj4+IEBAIC0xMjgsNiArMTMxLDcgQEAgc3RydWN0IGl0c19jbWRfaW5mbyB7Cj4+IMKgaW50
IGl0c19hbGxvY192Y3B1X2lycXMoc3RydWN0IGl0c192bSAqdm0pOwo+PiDCoHZvaWQgaXRzX2Zy
ZWVfdmNwdV9pcnFzKHN0cnVjdCBpdHNfdm0gKnZtKTsKPj4gwqBpbnQgaXRzX21ha2VfdnBlX3Jl
c2lkZW50KHN0cnVjdCBpdHNfdnBlICp2cGUsIGJvb2wgZzBlbiwgYm9vbCBnMWVuKTsKPj4gK2lu
dCBpdHNfd2FpdF92cHQoc3RydWN0IGl0c192cGUgKnZwZSk7Cj4+IMKgaW50IGl0c19tYWtlX3Zw
ZV9ub25fcmVzaWRlbnQoc3RydWN0IGl0c192cGUgKnZwZSwgYm9vbCBkYik7Cj4+IMKgaW50IGl0
c19pbnZhbGxfdnBlKHN0cnVjdCBpdHNfdnBlICp2cGUpOwo+PiDCoGludCBpdHNfbWFwX3ZscGko
aW50IGlycSwgc3RydWN0IGl0c192bHBpX21hcCAqbWFwKTsKPiAKPiBNeSBjb21tZW50cyBhcmUg
bW9zdGx5IGNvc21ldGljLiBJZiB5b3UgY2FuIHJlc3BpbiBxdWlja2x5LCBJJ2xsCj4gcGljayBp
dCB1cCBmb3IgNS4xMS4KCk9rLCBJIHdpbGwgdHJ5IHRvIHJlc3BpbiBpdCBxdWlja2x5LgoKVGhh
bmtzIGZvciByZXZpZXdpbmcsIDopClNoZW5taW5nCgo+IAo+IFRoYW5rcywKPiAKPiDCoMKgwqDC
oMKgwqDCoCBNLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6
Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
