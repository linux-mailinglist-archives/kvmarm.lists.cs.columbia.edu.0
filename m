Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5123D4DD4A1
	for <lists+kvmarm@lfdr.de>; Fri, 18 Mar 2022 07:14:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8991F49F55;
	Fri, 18 Mar 2022 02:14:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWSIZeDP3kBw; Fri, 18 Mar 2022 02:14:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D1EFD49F4B;
	Fri, 18 Mar 2022 02:14:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B5F5E40B41
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Mar 2022 02:14:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NF3AyyOTKziB for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Mar 2022 02:14:39 -0400 (EDT)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 328CF40B78
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Mar 2022 02:14:39 -0400 (EDT)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKYZl5mBZzCqsl;
 Fri, 18 Mar 2022 14:12:31 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 14:14:29 +0800
Received: from [10.174.187.192] (10.174.187.192) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 14:14:28 +0800
Subject: Re: Report an error on GICv4.1 vcpu de-schedule
To: Marc Zyngier <maz@kernel.org>
References: <4aae10ba-b39a-5f84-754b-69c2eb0a2c03@huawei.com>
 <87v8wcyjbn.wl-maz@kernel.org>
From: Jingyi Wang <wangjingyi11@huawei.com>
Message-ID: <24ea78d1-4ea1-ef88-e74c-6fe64a476d87@huawei.com>
Date: Fri, 18 Mar 2022 14:14:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87v8wcyjbn.wl-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.187.192]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

CgpPbiAzLzE3LzIwMjIgNjoxNyBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOgo+IEhpIEppbmd5aSwK
PiAKPiBPbiBUaHUsIDE3IE1hciAyMDIyIDA3OjI3OjQ1ICswMDAwLAo+IEppbmd5aSBXYW5nIDx3
YW5namluZ3lpMTFAaHVhd2VpLmNvbT4gd3JvdGU6Cj4+Cj4+IEhpIE1hcmPvvIwKPj4KPj4gVGhl
IHBhdGNoICJLVk06IGFybTY0OiBEZWxheSB0aGUgcG9sbGluZyBvZiB0aGUgR0lDUl9WUEVOREJB
U0VSLkRpcnR5Cj4+IGJpdCIoNTdlM2NlYmQwMjJmYmMwMzVkY2YxOTBhYzc4OWZkMmZmYzc0N2Y1
YikgcmVtb3ZlIHRoZSBwb2xsaW5nIG9mCj4+IEdJQ1JfVlBFTkRCQVNFUi5EaXJ0eSBiaXQgaW4g
dmNwdV9sb2FkKCkgLCB3aGlsZSBjaGVjayB0aGUgVlBUIHBhcnNpbmcKPj4gcmVhZHkgaW4ga3Zt
X3ZnaWNfZmx1c2hfaHdzdGF0ZSgpIGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UuCj4+Cj4+IE1vc3Qg
dGltZSBpdCB3b3JrcywgYnV0IHdlIGhhdmUgbWV0IGFuIGVycm9yIG9uIG91ciBoYXJkd2FyZSBy
ZWNlbnRseS4KPj4gSW4gcHJlZW1wdGFibGUga2VybmVsLCB0aGUgdmNwdSBjYW4gYmUgcHJlZW1w
dGVkIGJldHdlZW4gdmNwdV9sb2FkIGFuZAo+PiBrdm1fdmdpY19mbHVzaF9od3N0YXRlLiBBcyBh
IHJlc3VsdCwgaXQgZ2V0IGRlLXNjaGVkdWxlZCBhbmQKPj4gaXRzX2NsZWFyX3ZwZW5kX3ZhbGlk
KCkgaXMgY2FsbGVkCj4+Cj4+IAl2YWwgPSBnaWNyX3JlYWRfdnBlbmRiYXNlcih2bHBpX2Jhc2Ug
KyBHSUNSX1ZQRU5EQkFTRVIpOwo+PiAJdmFsICY9IH5HSUNSX1ZQRU5EQkFTRVJfVmFsaWQ7Cj4+
IAl2YWwgJj0gfmNscjsKPj4gCXZhbCB8PSBzZXQ7Cj4+IAlnaWNyX3dyaXRlX3ZwZW5kYmFzZXIo
dmFsLCB2bHBpX2Jhc2UgKyBHSUNSX1ZQRU5EQkFTRVIpOwo+Pgo+Pgo+PiBUaGUgZnVuY3Rpb24g
Y2xlYXJzIFZhbGlkIGJpdCBtZWFud2hpbGUgR0lDUl9WUEVOREJBU0VSX0RpcnR5Cj4+IG1heWJl
IHN0aWxsIDEsIHdoaWNoIGNhdXNlIHRoZSBzdWJzZXF1ZW50IEdJQ1JfVlBFTkRCQVNFUl9EaXJ0
eSBwb2xsaW5nCj4+IGZhaWwgYW5kIHJlcG9ydCAiIklUUyB2aXJ0dWFsIHBlbmRpbmcgdGFibGUg
bm90IGNsZWFuaW5nIi4KPj4KPj4gV2UgaGF2ZSBjb21tdW5pY2F0ZWQgd2l0aCBNYXJ0aW4gZnJv
bSBBUk0gYW5kIGdldCB0aGUgY29uY2x1c2lvbgo+PiB0aGF0IHdlIHNob3VsZCBub3QgY2hhbmdl
IHZhbGlkIGJpdCB3aGlsZSB0aGUgZGlydHkgYml0IG5vdCBjbGVhcuKAlOKAlAo+PiAiVGhlIGRp
cnR5IGJpdCByZXBvcnRzIHdoZXRoZXIgdGhlIGxhc3Qgc2NoZWR1bGUgL2RlLXNjaGVkdWxlCj4+
IG9wZXJhdGlvbiBoYXMgY29tcGxldGVkLlRoZSByZXN0cmljdGlvbiBvbiBub3QgY2hhbmdpbmcg
VmFsaWQgd2hlbiBEaXJ0eQo+PiBpcyAxLCBpcyBzbyB0aGF0IGhhcmR3YXJlIGNhbiBhbHdheXMg
Y29tcGxldGUgdGhlIGxhc3Qgb3BlcmF0aW9uIGZvcgo+PiBzdGFydGluZyB0aGUgbmV4dCIuCj4g
Cj4gSW5kZWVkLCB0aGUgc3BlYyBpcyBjcnlzdGFsIGNsZWFyIGFib3V0IHRoYXQsIGFuZCBjbGVh
cmluZyBWYWxpZCB3aGlsZQo+IERpcnR5IGlzIHNldCBpcyBwbGFpbiB3cm9uZy4KPiAKPj4KPj4g
SSB0aGluayBtYXliZSB3ZSBjYW4gY2hlY2sgZGlydHkgYml0IGNsZWFyIGJlZm9yZSBjbGVhcmlu
ZyB0aGUgdmFsaWQgYml0Cj4+IGluIGl0c19jbGVhcl92cGVuZF92YWxpZCgpIGNvZGUuIEhvcGUg
dG8ga25vdyB5b3VyIG9waW5pb24gYWJvdXQgdGhpcwo+PiBpc3N1ZS4KPiAKPiBZZXMsIHRoYXQn
cyB3aGF0IHNob3VsZCBoYXBwZW4uIEkgY2FtZSB1cCB3aXRoIHRoZSBwYXRjaCBiZWxvdy4gUGxl
YXNlCj4gZ2l2ZSBpdCBhIHNob3QgYW5kIGxldCBtZSBrbm93IGlmIHRoYXQgaGVscHMuIElmIGl0
IGRvZXMsIEknbGwgcXVldWUKPiBpdCBhcyBhIGZpeC4KPiAKPiBUaGFua3MsCj4gCj4gCU0uCj4g
CgpUaGFua3MsIHdlIHdpbGwgdGVzdCB0aGF0IHNvb24uCgo+PkZyb20gYzIzY2NjOWNmYTYwM2Uz
MGFjMTg5ZDQzYWY3NWYwM2I2MGQ3ODBiYyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKPiBGcm9t
OiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+IERhdGU6IFRodSwgMTcgTWFyIDIwMjIg
MDk6NDk6MDIgKzAwMDAKPiBTdWJqZWN0OiBbUEFUQ0hdIGlycWNoaXAvZ2ljLXY0OiBXYWl0IGZv
ciBHSUNSX1ZQRU5EQkFTRVIuRGlydHkgdG8gY2xlYXIKPiAgIGJlZm9yZSBkZXNjaGVkdWxpbmcK
PiAKPiBUaGUgd2F5IEtWTSBkcml2ZXMgR0lDdjQuezAsMX0gaXMgYXMgZm9sbG93czoKPiAtIHZj
cHVfbG9hZCgpIG1ha2VzIHRoZSBWUEUgcmVzaWRlbnQsIGluc3RydWN0aW5nIHRoZSBSRCB0byBz
dGFydAo+ICAgIHNjYW5uaW5nIGZvciBpbnRlcnJ1cHRzCj4gLSBqdXN0IGJlZm9yZSBlbnRlcmlu
ZyB0aGUgZ3Vlc3QsIHdlIGNoZWNrIHRoYXQgdGhlIFJEIGhhcyBmaW5pc2hlZAo+ICAgIHNjYW5u
aW5nIGFuZCB0aGF0IHdlIGNhbiBzdGFydCBydW5uaW5nIHRoZSB2Y3B1Cj4gLSBvbiBwcmVlbXB0
aW9uLCB3ZSBkZXNjaGVkdWxlIHRoZSBWUEUgYnkgbWFraW5nIGl0IGludmFsaWQgb24KPiAgICB0
aGUgUkQKPiAKPiBIb3dldmVyLCB3ZSBhcmUgcHJlZW1wdGlibGUgYmV0d2VlbiB0aGUgZmlyc3Qg
dHdvIHN0ZXBzLiBJZiBpdCBzbwo+IGhhcHBlbnMgKmFuZCogdGhhdCB0aGUgUkQgd2FzIHN0aWxs
IHNjYW5uaW5nLCB3ZSBub25ldGhlbGVzcyB3cml0ZQo+IHRvIHRoZSBHSUNSX1ZQRU5EQkFTRVIg
cmVnaXN0ZXIgd2hpbGUgRGlydHkgaXMgc2V0LCBhbmQgYmFkIHRoaW5ncwo+IGhhcHBlbiAod2Un
cmUgaW4gVU5QUkVEIGxhbmQpLgo+IAo+IFRoaXMgYWZmZWN0cyBib3RoIHRoZSA0LjAgYW5kIDQu
MSBpbXBsZW1lbnRhdGlvbnMuCj4gCj4gTWFrZSBzdXJlIERpcnR5IGlzIGNsZWFyZWQgYmVmb3Jl
IHBlcmZvcm1pbmcgdGhlIGRlc2NoZWR1bGUsCj4gbWVhbmluZyB0aGF0IGl0c19jbGVhcl92cGVu
ZF92YWxpZCgpIGJlY29tZXMgYSBzb3J0IG9mIGZ1bGwgVlBFCj4gcmVzaWRlbmN5IGJhcnJpZXIu
Cj4gCj4gUmVwb3J0ZWQtYnk6IEppbmd5aSBXYW5nIDx3YW5namluZ3lpMTFAaHVhd2VpLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+IEZpeGVzOiA1
N2UzY2ViZDAyMmYgKCJLVk06IGFybTY0OiBEZWxheSB0aGUgcG9sbGluZyBvZiB0aGUgR0lDUl9W
UEVOREJBU0VSLkRpcnR5Cj4gYml0IikKPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzRhYWUxMGJhLWIzOWEtNWY4NC03NTRiLTY5YzJlYjBhMmMwM0BodWF3ZWkuY29tCj4gLS0tCj4g
ICBkcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYyB8IDI4ICsrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0
aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMu
YyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy5jCj4gaW5kZXggOWU5M2ZmMmI2Mzc1
Li5jOWIxZGY5ODA4OTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMt
aXRzLmMKPiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My1pdHMuYwo+IEBAIC0zMDEx
LDE4ICszMDExLDEyIEBAIHN0YXRpYyBpbnQgX19pbml0IGFsbG9jYXRlX2xwaV90YWJsZXModm9p
ZCkKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgdTY0IGl0c19jbGVhcl92cGVu
ZF92YWxpZCh2b2lkIF9faW9tZW0gKnZscGlfYmFzZSwgdTY0IGNsciwgdTY0IHNldCkKPiArc3Rh
dGljIHU2NCByZWFkX3ZwZW5kX2RpcnR5X2NsZWFyKHZvaWQgX19pb21lbSAqdmxwaV9iYXNlKQo+
ICAgewo+ICAgCXUzMiBjb3VudCA9IDEwMDAwMDA7CS8qIDFzISAqLwo+ICAgCWJvb2wgY2xlYW47
Cj4gICAJdTY0IHZhbDsKPiAgIAo+IC0JdmFsID0gZ2ljcl9yZWFkX3ZwZW5kYmFzZXIodmxwaV9i
YXNlICsgR0lDUl9WUEVOREJBU0VSKTsKPiAtCXZhbCAmPSB+R0lDUl9WUEVOREJBU0VSX1ZhbGlk
Owo+IC0JdmFsICY9IH5jbHI7Cj4gLQl2YWwgfD0gc2V0Owo+IC0JZ2ljcl93cml0ZV92cGVuZGJh
c2VyKHZhbCwgdmxwaV9iYXNlICsgR0lDUl9WUEVOREJBU0VSKTsKPiAtCj4gICAJZG8gewo+ICAg
CQl2YWwgPSBnaWNyX3JlYWRfdnBlbmRiYXNlcih2bHBpX2Jhc2UgKyBHSUNSX1ZQRU5EQkFTRVIp
Owo+ICAgCQljbGVhbiA9ICEodmFsICYgR0lDUl9WUEVOREJBU0VSX0RpcnR5KTsKPiBAQCAtMzAz
MywxMCArMzAyNywyNiBAQCBzdGF0aWMgdTY0IGl0c19jbGVhcl92cGVuZF92YWxpZCh2b2lkIF9f
aW9tZW0gKnZscGlfYmFzZSwgdTY0IGNsciwgdTY0IHNldCkKPiAgIAkJfQo+ICAgCX0gd2hpbGUg
KCFjbGVhbiAmJiBjb3VudCk7Cj4gICAKPiAtCWlmICh1bmxpa2VseSh2YWwgJiBHSUNSX1ZQRU5E
QkFTRVJfRGlydHkpKSB7Cj4gKwlpZiAodW5saWtlbHkoIWNsZWFuKSkKPiAgIAkJcHJfZXJyX3Jh
dGVsaW1pdGVkKCJJVFMgdmlydHVhbCBwZW5kaW5nIHRhYmxlIG5vdCBjbGVhbmluZ1xuIik7Cj4g
Kwo+ICsJcmV0dXJuIHZhbDsKPiArfQo+ICsKPiArc3RhdGljIHU2NCBpdHNfY2xlYXJfdnBlbmRf
dmFsaWQodm9pZCBfX2lvbWVtICp2bHBpX2Jhc2UsIHU2NCBjbHIsIHU2NCBzZXQpCj4gK3sKPiAr
CXU2NCB2YWw7Cj4gKwo+ICsJLyogTWFrZSBzdXJlIHdlIHdhaXQgdW50aWwgdGhlIFJEIGlzIGRv
bmUgd2l0aCB0aGUgaW5pdGlhbCBzY2FuICovCj4gKwl2YWwgPSByZWFkX3ZwZW5kX2RpcnR5X2Ns
ZWFyKHZscGlfYmFzZSk7Cj4gKwl2YWwgJj0gfkdJQ1JfVlBFTkRCQVNFUl9WYWxpZDsKPiArCXZh
bCAmPSB+Y2xyOwo+ICsJdmFsIHw9IHNldDsKPiArCWdpY3Jfd3JpdGVfdnBlbmRiYXNlcih2YWws
IHZscGlfYmFzZSArIEdJQ1JfVlBFTkRCQVNFUik7Cj4gKwo+ICsJdmFsID0gcmVhZF92cGVuZF9k
aXJ0eV9jbGVhcih2bHBpX2Jhc2UpOwo+ICsJaWYgKHVubGlrZWx5KHZhbCAmIEdJQ1JfVlBFTkRC
QVNFUl9EaXJ0eSkpCj4gICAJCXZhbCB8PSBHSUNSX1ZQRU5EQkFTRVJfUGVuZGluZ0xhc3Q7Cj4g
LQl9Cj4gICAKPiAgIAlyZXR1cm4gdmFsOwo+ICAgfQo+IApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0
cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9s
aXN0aW5mby9rdm1hcm0K
