Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1356B4E1EBE
	for <lists+kvmarm@lfdr.de>; Mon, 21 Mar 2022 02:33:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AEB14B093;
	Sun, 20 Mar 2022 21:33:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level: 
X-Spam-Status: No, score=-1.898 required=6.1 tests=[BAYES_00=-1.9,
	RCVD_IN_DNSWL_BLOCKED=0.001, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKPqHEd9zITJ; Sun, 20 Mar 2022 21:33:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4270049ED1;
	Sun, 20 Mar 2022 21:33:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D184F40BD6
 for <kvmarm@lists.cs.columbia.edu>; Sun, 20 Mar 2022 21:33:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x1yDq4FHKnQX for <kvmarm@lists.cs.columbia.edu>;
 Sun, 20 Mar 2022 21:33:26 -0400 (EDT)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3869A40719
 for <kvmarm@lists.cs.columbia.edu>; Sun, 20 Mar 2022 21:33:26 -0400 (EDT)
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KMHF82P2Tzcb68;
 Mon, 21 Mar 2022 09:33:16 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 09:33:21 +0800
Received: from [10.174.187.192] (10.174.187.192) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 09:33:21 +0800
Subject: Re: Report an error on GICv4.1 vcpu de-schedule
To: Marc Zyngier <maz@kernel.org>
References: <4aae10ba-b39a-5f84-754b-69c2eb0a2c03@huawei.com>
 <87v8wcyjbn.wl-maz@kernel.org>
From: Jingyi Wang <wangjingyi11@huawei.com>
Message-ID: <115f1c12-cde7-faa4-59bb-33ba12cb5a37@huawei.com>
Date: Mon, 21 Mar 2022 09:33:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87v8wcyjbn.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.187.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, chengjian8@huawei.com, Martin.Weidmann@arm.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

SGkgTWFyYywKCk9uIDMvMTcvMjAyMiA2OjE3IFBNLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gSGkg
SmluZ3lpLAo+IAo+IE9uIFRodSwgMTcgTWFyIDIwMjIgMDc6Mjc6NDUgKzAwMDAsCj4gSmluZ3lp
IFdhbmcgPHdhbmdqaW5neWkxMUBodWF3ZWkuY29tPiB3cm90ZToKPj4KPj4gSGkgTWFyY++8jAo+
Pgo+PiBUaGUgcGF0Y2ggIktWTTogYXJtNjQ6IERlbGF5IHRoZSBwb2xsaW5nIG9mIHRoZSBHSUNS
X1ZQRU5EQkFTRVIuRGlydHkKPj4gYml0Iig1N2UzY2ViZDAyMmZiYzAzNWRjZjE5MGFjNzg5ZmQy
ZmZjNzQ3ZjViKSByZW1vdmUgdGhlIHBvbGxpbmcgb2YKPj4gR0lDUl9WUEVOREJBU0VSLkRpcnR5
IGJpdCBpbiB2Y3B1X2xvYWQoKSAsIHdoaWxlIGNoZWNrIHRoZSBWUFQgcGFyc2luZwo+PiByZWFk
eSBpbiBrdm1fdmdpY19mbHVzaF9od3N0YXRlKCkgZm9yIGJldHRlciBwZXJmb3JtYW5jZS4KPj4K
Pj4gTW9zdCB0aW1lIGl0IHdvcmtzLCBidXQgd2UgaGF2ZSBtZXQgYW4gZXJyb3Igb24gb3VyIGhh
cmR3YXJlIHJlY2VudGx5Lgo+PiBJbiBwcmVlbXB0YWJsZSBrZXJuZWwsIHRoZSB2Y3B1IGNhbiBi
ZSBwcmVlbXB0ZWQgYmV0d2VlbiB2Y3B1X2xvYWQgYW5kCj4+IGt2bV92Z2ljX2ZsdXNoX2h3c3Rh
dGUuIEFzIGEgcmVzdWx0LCBpdCBnZXQgZGUtc2NoZWR1bGVkIGFuZAo+PiBpdHNfY2xlYXJfdnBl
bmRfdmFsaWQoKSBpcyBjYWxsZWQKPj4KPj4gCXZhbCA9IGdpY3JfcmVhZF92cGVuZGJhc2VyKHZs
cGlfYmFzZSArIEdJQ1JfVlBFTkRCQVNFUik7Cj4+IAl2YWwgJj0gfkdJQ1JfVlBFTkRCQVNFUl9W
YWxpZDsKPj4gCXZhbCAmPSB+Y2xyOwo+PiAJdmFsIHw9IHNldDsKPj4gCWdpY3Jfd3JpdGVfdnBl
bmRiYXNlcih2YWwsIHZscGlfYmFzZSArIEdJQ1JfVlBFTkRCQVNFUik7Cj4+Cj4+Cj4+IFRoZSBm
dW5jdGlvbiBjbGVhcnMgVmFsaWQgYml0IG1lYW53aGlsZSBHSUNSX1ZQRU5EQkFTRVJfRGlydHkK
Pj4gbWF5YmUgc3RpbGwgMSwgd2hpY2ggY2F1c2UgdGhlIHN1YnNlcXVlbnQgR0lDUl9WUEVOREJB
U0VSX0RpcnR5IHBvbGxpbmcKPj4gZmFpbCBhbmQgcmVwb3J0ICIiSVRTIHZpcnR1YWwgcGVuZGlu
ZyB0YWJsZSBub3QgY2xlYW5pbmciLgo+Pgo+PiBXZSBoYXZlIGNvbW11bmljYXRlZCB3aXRoIE1h
cnRpbiBmcm9tIEFSTSBhbmQgZ2V0IHRoZSBjb25jbHVzaW9uCj4+IHRoYXQgd2Ugc2hvdWxkIG5v
dCBjaGFuZ2UgdmFsaWQgYml0IHdoaWxlIHRoZSBkaXJ0eSBiaXQgbm90IGNsZWFy4oCU4oCUCj4+
ICJUaGUgZGlydHkgYml0IHJlcG9ydHMgd2hldGhlciB0aGUgbGFzdCBzY2hlZHVsZSAvZGUtc2No
ZWR1bGUKPj4gb3BlcmF0aW9uIGhhcyBjb21wbGV0ZWQuVGhlIHJlc3RyaWN0aW9uIG9uIG5vdCBj
aGFuZ2luZyBWYWxpZCB3aGVuIERpcnR5Cj4+IGlzIDEsIGlzIHNvIHRoYXQgaGFyZHdhcmUgY2Fu
IGFsd2F5cyBjb21wbGV0ZSB0aGUgbGFzdCBvcGVyYXRpb24gZm9yCj4+IHN0YXJ0aW5nIHRoZSBu
ZXh0Ii4KPiAKPiBJbmRlZWQsIHRoZSBzcGVjIGlzIGNyeXN0YWwgY2xlYXIgYWJvdXQgdGhhdCwg
YW5kIGNsZWFyaW5nIFZhbGlkIHdoaWxlCj4gRGlydHkgaXMgc2V0IGlzIHBsYWluIHdyb25nLgo+
IAo+Pgo+PiBJIHRoaW5rIG1heWJlIHdlIGNhbiBjaGVjayBkaXJ0eSBiaXQgY2xlYXIgYmVmb3Jl
IGNsZWFyaW5nIHRoZSB2YWxpZCBiaXQKPj4gaW4gaXRzX2NsZWFyX3ZwZW5kX3ZhbGlkKCkgY29k
ZS4gSG9wZSB0byBrbm93IHlvdXIgb3BpbmlvbiBhYm91dCB0aGlzCj4+IGlzc3VlLgo+IAo+IFll
cywgdGhhdCdzIHdoYXQgc2hvdWxkIGhhcHBlbi4gSSBjYW1lIHVwIHdpdGggdGhlIHBhdGNoIGJl
bG93LiBQbGVhc2UKPiBnaXZlIGl0IGEgc2hvdCBhbmQgbGV0IG1lIGtub3cgaWYgdGhhdCBoZWxw
cy4gSWYgaXQgZG9lcywgSSdsbCBxdWV1ZQo+IGl0IGFzIGEgZml4Lgo+IAo+IFRoYW5rcywKPiAK
PiAJTS4KPiAKPj5Gcm9tIGMyM2NjYzljZmE2MDNlMzBhYzE4OWQ0M2FmNzVmMDNiNjBkNzgwYmMg
TW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4gRnJvbTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVs
Lm9yZz4KPiBEYXRlOiBUaHUsIDE3IE1hciAyMDIyIDA5OjQ5OjAyICswMDAwCj4gU3ViamVjdDog
W1BBVENIXSBpcnFjaGlwL2dpYy12NDogV2FpdCBmb3IgR0lDUl9WUEVOREJBU0VSLkRpcnR5IHRv
IGNsZWFyCj4gICBiZWZvcmUgZGVzY2hlZHVsaW5nCj4gCj4gVGhlIHdheSBLVk0gZHJpdmVzIEdJ
Q3Y0LnswLDF9IGlzIGFzIGZvbGxvd3M6Cj4gLSB2Y3B1X2xvYWQoKSBtYWtlcyB0aGUgVlBFIHJl
c2lkZW50LCBpbnN0cnVjdGluZyB0aGUgUkQgdG8gc3RhcnQKPiAgICBzY2FubmluZyBmb3IgaW50
ZXJydXB0cwo+IC0ganVzdCBiZWZvcmUgZW50ZXJpbmcgdGhlIGd1ZXN0LCB3ZSBjaGVjayB0aGF0
IHRoZSBSRCBoYXMgZmluaXNoZWQKPiAgICBzY2FubmluZyBhbmQgdGhhdCB3ZSBjYW4gc3RhcnQg
cnVubmluZyB0aGUgdmNwdQo+IC0gb24gcHJlZW1wdGlvbiwgd2UgZGVzY2hlZHVsZSB0aGUgVlBF
IGJ5IG1ha2luZyBpdCBpbnZhbGlkIG9uCj4gICAgdGhlIFJECj4gCj4gSG93ZXZlciwgd2UgYXJl
IHByZWVtcHRpYmxlIGJldHdlZW4gdGhlIGZpcnN0IHR3byBzdGVwcy4gSWYgaXQgc28KPiBoYXBw
ZW5zICphbmQqIHRoYXQgdGhlIFJEIHdhcyBzdGlsbCBzY2FubmluZywgd2Ugbm9uZXRoZWxlc3Mg
d3JpdGUKPiB0byB0aGUgR0lDUl9WUEVOREJBU0VSIHJlZ2lzdGVyIHdoaWxlIERpcnR5IGlzIHNl
dCwgYW5kIGJhZCB0aGluZ3MKPiBoYXBwZW4gKHdlJ3JlIGluIFVOUFJFRCBsYW5kKS4KPiAKPiBU
aGlzIGFmZmVjdHMgYm90aCB0aGUgNC4wIGFuZCA0LjEgaW1wbGVtZW50YXRpb25zLgo+IAo+IE1h
a2Ugc3VyZSBEaXJ0eSBpcyBjbGVhcmVkIGJlZm9yZSBwZXJmb3JtaW5nIHRoZSBkZXNjaGVkdWxl
LAo+IG1lYW5pbmcgdGhhdCBpdHNfY2xlYXJfdnBlbmRfdmFsaWQoKSBiZWNvbWVzIGEgc29ydCBv
ZiBmdWxsIFZQRQo+IHJlc2lkZW5jeSBiYXJyaWVyLgo+IAo+IFJlcG9ydGVkLWJ5OiBKaW5neWkg
V2FuZyA8d2FuZ2ppbmd5aTExQGh1YXdlaS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWFyYyBaeW5n
aWVyIDxtYXpAa2VybmVsLm9yZz4KPiBGaXhlczogNTdlM2NlYmQwMjJmICgiS1ZNOiBhcm02NDog
RGVsYXkgdGhlIHBvbGxpbmcgb2YgdGhlIEdJQ1JfVlBFTkRCQVNFUi5EaXJ0eQo+IGJpdCIpCj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci80YWFlMTBiYS1iMzlhLTVmODQtNzU0Yi02
OWMyZWIwYTJjMDNAaHVhd2VpLmNvbQo+IC0tLQo+ICAgZHJpdmVycy9pcnFjaGlwL2lycS1naWMt
djMtaXRzLmMgfCAyOCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdp
Yy12My1pdHMuYwo+IGluZGV4IDllOTNmZjJiNjM3NS4uYzliMWRmOTgwODk5IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy5jCj4gKysrIGIvZHJpdmVycy9pcnFj
aGlwL2lycS1naWMtdjMtaXRzLmMKPiBAQCAtMzAxMSwxOCArMzAxMSwxMiBAQCBzdGF0aWMgaW50
IF9faW5pdCBhbGxvY2F0ZV9scGlfdGFibGVzKHZvaWQpCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4g
ICAKPiAtc3RhdGljIHU2NCBpdHNfY2xlYXJfdnBlbmRfdmFsaWQodm9pZCBfX2lvbWVtICp2bHBp
X2Jhc2UsIHU2NCBjbHIsIHU2NCBzZXQpCj4gK3N0YXRpYyB1NjQgcmVhZF92cGVuZF9kaXJ0eV9j
bGVhcih2b2lkIF9faW9tZW0gKnZscGlfYmFzZSkKPiAgIHsKPiAgIAl1MzIgY291bnQgPSAxMDAw
MDAwOwkvKiAxcyEgKi8KPiAgIAlib29sIGNsZWFuOwo+ICAgCXU2NCB2YWw7Cj4gICAKPiAtCXZh
bCA9IGdpY3JfcmVhZF92cGVuZGJhc2VyKHZscGlfYmFzZSArIEdJQ1JfVlBFTkRCQVNFUik7Cj4g
LQl2YWwgJj0gfkdJQ1JfVlBFTkRCQVNFUl9WYWxpZDsKPiAtCXZhbCAmPSB+Y2xyOwo+IC0JdmFs
IHw9IHNldDsKPiAtCWdpY3Jfd3JpdGVfdnBlbmRiYXNlcih2YWwsIHZscGlfYmFzZSArIEdJQ1Jf
VlBFTkRCQVNFUik7Cj4gLQo+ICAgCWRvIHsKPiAgIAkJdmFsID0gZ2ljcl9yZWFkX3ZwZW5kYmFz
ZXIodmxwaV9iYXNlICsgR0lDUl9WUEVOREJBU0VSKTsKPiAgIAkJY2xlYW4gPSAhKHZhbCAmIEdJ
Q1JfVlBFTkRCQVNFUl9EaXJ0eSk7Cj4gQEAgLTMwMzMsMTAgKzMwMjcsMjYgQEAgc3RhdGljIHU2
NCBpdHNfY2xlYXJfdnBlbmRfdmFsaWQodm9pZCBfX2lvbWVtICp2bHBpX2Jhc2UsIHU2NCBjbHIs
IHU2NCBzZXQpCj4gICAJCX0KPiAgIAl9IHdoaWxlICghY2xlYW4gJiYgY291bnQpOwo+ICAgCj4g
LQlpZiAodW5saWtlbHkodmFsICYgR0lDUl9WUEVOREJBU0VSX0RpcnR5KSkgewo+ICsJaWYgKHVu
bGlrZWx5KCFjbGVhbikpCj4gICAJCXByX2Vycl9yYXRlbGltaXRlZCgiSVRTIHZpcnR1YWwgcGVu
ZGluZyB0YWJsZSBub3QgY2xlYW5pbmdcbiIpOwo+ICsKPiArCXJldHVybiB2YWw7Cj4gK30KPiAr
Cj4gK3N0YXRpYyB1NjQgaXRzX2NsZWFyX3ZwZW5kX3ZhbGlkKHZvaWQgX19pb21lbSAqdmxwaV9i
YXNlLCB1NjQgY2xyLCB1NjQgc2V0KQo+ICt7Cj4gKwl1NjQgdmFsOwo+ICsKPiArCS8qIE1ha2Ug
c3VyZSB3ZSB3YWl0IHVudGlsIHRoZSBSRCBpcyBkb25lIHdpdGggdGhlIGluaXRpYWwgc2NhbiAq
Lwo+ICsJdmFsID0gcmVhZF92cGVuZF9kaXJ0eV9jbGVhcih2bHBpX2Jhc2UpOwo+ICsJdmFsICY9
IH5HSUNSX1ZQRU5EQkFTRVJfVmFsaWQ7Cj4gKwl2YWwgJj0gfmNscjsKPiArCXZhbCB8PSBzZXQ7
Cj4gKwlnaWNyX3dyaXRlX3ZwZW5kYmFzZXIodmFsLCB2bHBpX2Jhc2UgKyBHSUNSX1ZQRU5EQkFT
RVIpOwo+ICsKPiArCXZhbCA9IHJlYWRfdnBlbmRfZGlydHlfY2xlYXIodmxwaV9iYXNlKTsKPiAr
CWlmICh1bmxpa2VseSh2YWwgJiBHSUNSX1ZQRU5EQkFTRVJfRGlydHkpKQo+ICAgCQl2YWwgfD0g
R0lDUl9WUEVOREJBU0VSX1BlbmRpbmdMYXN0Owo+IC0JfQo+ICAgCj4gICAJcmV0dXJuIHZhbDsK
PiAgIH0KPiAKCgpUaGlzIHBhdGNoIHdvcmtzIGZpbmUgb24gdGhlIGhhcmR3YXJlLgpUZXN0ZWQt
Ynk6TmlhbnlhbyBUYW5nIDx0YW5nbmlhbnlhb0BodWF3ZWkuY29tPgoKVGhhbmtzLApKaW5neWkK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1h
aWxpbmcgbGlzdAprdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3Mu
Y29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGluZm8va3ZtYXJtCg==
