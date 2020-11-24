Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DC6142C2A5E
	for <lists+kvmarm@lfdr.de>; Tue, 24 Nov 2020 15:49:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4780E4BDB9;
	Tue, 24 Nov 2020 09:49:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9nmAU3aihT8; Tue, 24 Nov 2020 09:49:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 609544BDA6;
	Tue, 24 Nov 2020 09:49:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CDCBB4BD36
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Nov 2020 03:10:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QKX2yRjF15cp for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Nov 2020 03:10:42 -0500 (EST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 867964BCE4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Nov 2020 03:10:41 -0500 (EST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CgGsp5vdGzhg5l;
 Tue, 24 Nov 2020 16:10:22 +0800 (CST)
Received: from [10.174.187.74] (10.174.187.74) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 16:10:27 +0800
Subject: Re: [RFC PATCH v1 3/4] KVM: arm64: GICv4.1: Restore VLPI's pending
 state to physical side
To: Marc Zyngier <maz@kernel.org>
References: <20201123065410.1915-1-lushenming@huawei.com>
 <20201123065410.1915-4-lushenming@huawei.com>
 <5c724bb83730cdd5dcf7add9a812fa92@kernel.org>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <b03edcf2-2950-572f-fd31-601d8d766c80@huawei.com>
Date: Tue, 24 Nov 2020 16:10:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <5c724bb83730cdd5dcf7add9a812fa92@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.187.74]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 24 Nov 2020 09:49:14 -0500
Cc: Neo Jia <cjia@nvidia.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

T24gMjAyMC8xMS8yMyAxNzoyNywgTWFyYyBaeW5naWVyIHdyb3RlOgo+IE9uIDIwMjAtMTEtMjMg
MDY6NTQsIFNoZW5taW5nIEx1IHdyb3RlOgo+PiBGcm9tOiBaZW5naHVpIFl1IDx5dXplbmdodWlA
aHVhd2VpLmNvbT4KPj4KPj4gV2hlbiBzZXR0aW5nIHRoZSBmb3J3YXJkaW5nIHBhdGggb2YgYSBW
TFBJLCBpdCBpcyBtb3JlIGNvbnNpc3RlbnQgdG8KPiAKPiBJJ20gbm90IHN1cmUgaXQgaXMgbW9y
ZSBjb25zaXN0ZW50LiBJdCBpcyBhICpuZXcqIGJlaGF2aW91ciwgYmVjYXVzZSBpdCBvbmx5Cj4g
bWF0dGVycyBmb3IgbWlncmF0aW9uLCB3aGljaCBoYXMgYmVlbiBzbyBmYXIgdW5zdXBwb3J0ZWQu
CgpBbHJpZ2h0LCBjb25zaXN0ZW50IG1heSBub3QgYmUgYWNjdXJhdGUuLi4KQnV0IEkgaGF2ZSBk
b3VidCB0aGF0IHdoZXRoZXIgdGhlcmUgaXMgcmVhbGx5IG5vIG5lZWQgdG8gdHJhbnNmZXIgdGhl
IHBlbmRpbmcgc3RhdGVzCmZyb20ga3ZtJ3ZnaWMgdG8gVlBUIGluIHNldF9mb3J3YXJkaW5nIHJl
Z2FyZGxlc3Mgb2YgbWlncmF0aW9uLCBhbmQgdGhlIHNpbWlsYXIKZm9yIHVuc2V0X2ZvcndhcmRp
bmcuCgo+IAo+PiBhbHNvIHRyYW5zZmVyIHRoZSBwZW5kaW5nIHN0YXRlIGZyb20gaXJxLT5wZW5k
aW5nX2xhdGNoIHRvIFZQVCAoZXNwZWNpYWxseQo+PiBpbiBtaWdyYXRpb24sIHRoZSBwZW5kaW5n
IHN0YXRlcyBvZiBWTFBJcyBhcmUgcmVzdG9yZWQgaW50byBrdm3igJlzIHZnaWMKPj4gZmlyc3Qp
LiBBbmQgd2UgY3VycmVudGx5IHNlbmQgIklOVCtWU1lOQyIgdG8gdHJpZ2dlciBhIFZMUEkgdG8g
cGVuZGluZy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogWmVuZ2h1aSBZdSA8eXV6ZW5naHVpQGh1YXdl
aS5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFNoZW5taW5nIEx1IDxsdXNoZW5taW5nQGh1YXdlaS5j
b20+Cj4+IC0tLQo+PiDCoGFyY2gvYXJtNjQva3ZtL3ZnaWMvdmdpYy12NC5jIHwgMTIgKysrKysr
KysrKysrCj4+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQva3ZtL3ZnaWMvdmdpYy12NC5jIGIvYXJjaC9hcm02NC9rdm0vdmdp
Yy92Z2ljLXY0LmMKPj4gaW5kZXggYjVmYTczYzlmZDM1Li5jYzNhYjljZWExODIgMTAwNjQ0Cj4+
IC0tLSBhL2FyY2gvYXJtNjQva3ZtL3ZnaWMvdmdpYy12NC5jCj4+ICsrKyBiL2FyY2gvYXJtNjQv
a3ZtL3ZnaWMvdmdpYy12NC5jCj4+IEBAIC00MTgsNiArNDE4LDE4IEBAIGludCBrdm1fdmdpY192
NF9zZXRfZm9yd2FyZGluZyhzdHJ1Y3Qga3ZtICprdm0sIGludCB2aXJxLAo+PiDCoMKgwqDCoCBp
cnEtPmhvc3RfaXJxwqDCoMKgID0gdmlycTsKPj4gwqDCoMKgwqAgYXRvbWljX2luYygmbWFwLnZw
ZS0+dmxwaV9jb3VudCk7Cj4+Cj4+ICvCoMKgwqAgLyogVHJhbnNmZXIgcGVuZGluZyBzdGF0ZSAq
Lwo+PiArwqDCoMKgIHJldCA9IGlycV9zZXRfaXJxY2hpcF9zdGF0ZShpcnEtPmhvc3RfaXJxLAo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVJRQ0hJUF9TVEFURV9Q
RU5ESU5HLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXJxLT5w
ZW5kaW5nX2xhdGNoKTsKPj4gK8KgwqDCoCBXQVJOX1JBVEVMSU1JVChyZXQsICJJUlEgJWQiLCBp
cnEtPmhvc3RfaXJxKTsKPj4gKwo+PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIExldCBpdCBi
ZSBwcnVuZWQgZnJvbSBhcF9saXN0IGxhdGVyIGFuZCBkb24ndCBib3RoZXIKPj4gK8KgwqDCoMKg
ICogdGhlIExpc3QgUmVnaXN0ZXIuCj4+ICvCoMKgwqDCoCAqLwo+PiArwqDCoMKgIGlycS0+cGVu
ZGluZ19sYXRjaCA9IGZhbHNlOwo+IAo+IEl0IG9jY3VycyB0byBtZSB0aGF0IGNhbGxpbmcgaW50
byBpcnFfc2V0X2lycWNoaXBfc3RhdGUoKSBmb3IgYSBsYXJnZQo+IG51bWJlciBvZiBpbnRlcnJ1
cHRzIGNhbiB0YWtlIGEgc2lnbmlmaWNhbnQgYW1vdW50IG9mIHRpbWUuIEl0IGlzIGFsc28KPiBv
ZGQgdGhhdCB5b3UgZHVtcCB0aGUgVlBUIHdpdGggdGhlIFZQRSB1bm1hcHBlZCwgYnV0IHJlbHkg
b24gdGhlIFZQRQo+IGJlaW5nIG1hcHBlZCBmb3IgdGhlIG9wcG9zaXRlIG9wZXJhdGlvbi4KPiAK
PiBTaG91bGRuJ3QgdGhlc2UgYmUgc3ltbWV0cmljLCBhbGwgcGVyZm9ybWVkIHdoaWxlIHRoZSBW
UEUgaXMgdW5tYXBwZWQ/Cj4gSXQgd291bGQgYWxzbyBzYXZlIGEgbG90IG9mIElUUyB0cmFmZmlj
Lgo+IAoKTXkgdGhvdWdodCB3YXMgdG8gdXNlIHRoZSBleGlzdGluZyBpbnRlcmZhY2UgZGlyZWN0
bHkgd2l0aG91dCB1bm1hcHBpbmcuLi4KCklmIHlvdSB3YW50IHRvIHVubWFwIHRoZSB2UEUgYW5k
IHBva2UgdGhlIFZQVCBoZXJlLCBhcyBJIHNhaWQgaW4gdGhlIGNvdmVyCmxldHRlciwgc2V0L3Vu
c2V0X2ZvcndhcmRpbmcgbWlnaHQgYWxzbyBiZSBjYWxsZWQgd2hlbiBhbGwgZGV2aWNlcyBhcmUg
cnVubmluZwphdCBub3JtYWwgcnVuIHRpbWUsIGluIHdoaWNoIGNhc2UgdGhlIHVubWFwcGluZyBv
ZiB0aGUgdlBFIGlzIG5vdCBhbGxvd2VkLi4uCgpBbm90aGVyIHBvc3NpYmxlIHNvbHV0aW9uIGlz
IHRvIGFkZCBhIG5ldyBkZWRpY2F0ZWQgaW50ZXJmYWNlIHRvIFFFTVUgdG8gdHJhbnNmZXIKdGhl
c2UgcGVuZGluZyBzdGF0ZXMgdG8gSFcgaW4gR0lDIFZNIHN0YXRlIGNoYW5nZSBoYW5kbGVyIGNv
cnJlc3BvbmRpbmcgdG8Kc2F2ZV9wZW5kaW5nX3RhYmxlcz8KCj4+ICsKPj4gwqBvdXQ6Cj4+IMKg
wqDCoMKgIG11dGV4X3VubG9jaygmaXRzLT5pdHNfbG9jayk7Cj4+IMKgwqDCoMKgIHJldHVybiBy
ZXQ7Cj4gCj4gVGhhbmtzLAo+IAo+IMKgwqDCoMKgwqDCoMKgIE0uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJt
QGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWls
bWFuL2xpc3RpbmZvL2t2bWFybQo=
