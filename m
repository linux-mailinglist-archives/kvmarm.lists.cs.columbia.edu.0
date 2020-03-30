Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9660E197CAC
	for <lists+kvmarm@lfdr.de>; Mon, 30 Mar 2020 15:18:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A3564B239;
	Mon, 30 Mar 2020 09:18:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9EZIwcRx39D0; Mon, 30 Mar 2020 09:18:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CCB1A4B1B7;
	Mon, 30 Mar 2020 09:18:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BB17D4B1A9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 09:18:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgvRabcLocvp for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Mar 2020 09:18:02 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 68F0B4B12F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 09:18:00 -0400 (EDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6D6481EB6A23AB42A64A;
 Mon, 30 Mar 2020 21:17:54 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 21:17:48 +0800
Subject: Re: [kvm-unit-tests PATCH v7 13/13] arm/arm64: ITS: pending table
 migration test
To: Auger Eric <eric.auger@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-14-eric.auger@redhat.com>
 <296c574b-810c-9c90-a613-df732a9ac193@huawei.com>
 <ea74559c-2ab4-752c-e587-2bf40eab14b0@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <0e73fd13-ca18-2d17-2267-fd5d852e3ac8@huawei.com>
Date: Mon, 30 Mar 2020 21:17:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ea74559c-2ab4-752c-e587-2bf40eab14b0@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, maz@kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, andre.przywara@arm.com, thuth@redhat.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

T24gMjAyMC8zLzMwIDIwOjM4LCBBdWdlciBFcmljIHdyb3RlOgo+IEhpIFplbmdodWksCgpbLi4u
XQoKPj4+ICsKPj4+ICvCoMKgwqAgcHRyID0gZ2ljdjNfZGF0YS5yZWRpc3RfYmFzZVtwZTBdICsg
R0lDUl9QRU5EQkFTRVI7Cj4+PiArwqDCoMKgIHBlbmRiYXNlciA9IHJlYWRxKHB0cik7Cj4+PiAr
wqDCoMKgIHdyaXRlcShwZW5kYmFzZXIgJiB+R0lDUl9QRU5EQkFTRVJfUFRaLCBwdHIpOwo+Pj4g
Kwo+Pj4gK8KgwqDCoCBwdHIgPSBnaWN2M19kYXRhLnJlZGlzdF9iYXNlW3BlMV0gKyBHSUNSX1BF
TkRCQVNFUjsKPj4+ICvCoMKgwqAgcGVuZGJhc2VyID0gcmVhZHEocHRyKTsKPj4+ICvCoMKgwqAg
d3JpdGVxKHBlbmRiYXNlciAmIH5HSUNSX1BFTkRCQVNFUl9QVFosIHB0cik7Cj4+PiArCj4+PiAr
wqDCoMKgIGdpY3YzX2xwaV9yZGlzdF9lbmFibGUocGUwKTsKPj4+ICvCoMKgwqAgZ2ljdjNfbHBp
X3JkaXN0X2VuYWJsZShwZTEpOwo+Pgo+PiBJIGRvbid0IGtub3cgaG93IHRoZSBtaWdyYXRpb24g
Z2V0cyBpbXBsZW1lbnRlZCBpbiBrdm0tdW5pdC10ZXN0cy4KPj4gQnV0IGlzIHRoZXJlIGFueSBn
dWFyYW50ZWUgdGhhdCB0aGUgTFBJcyB3aWxsIG9ubHkgYmUgdHJpZ2dlcmVkIG9uIHRoZQo+PiBk
ZXN0aW5hdGlvbiBzaWRlPyBBcyBvbmNlIHRoZSBFbmFibGVMUElzIGJpdCBiZWNvbWVzIDEsIFZH
SUMgd2lsbCBzdGFydAo+PiByZWFkaW5nIHRoZSBwZW5kaW5nIGJpdCBpbiBndWVzdCBtZW1vcnkg
YW5kIHBvdGVudGlhbGx5IGluamVjdGluZyBMUElzCj4+IGludG8gdGhlIHRhcmdldCB2Y3B1IChp
biB0aGUgc291cmNlIHNpZGUpLgo+IAo+IEkgZXhwZWN0IHNvbWUgTFBJcyB0byBoaXQgb24gc291
cmNlIGFuZCBzb21lIG90aGVycyB0byBoaXQgb24gdGhlCj4gZGVzdGluYXRpb24uIFRvIG1lLCB0
aGlzIGRvZXMgbm90IHJlYWxseSBtYXR0ZXIgYXMgbG9uZyBhcyB0aGUgaGFuZGxlcnMKPiBnZXRz
IGNhbGxlZCBhbmQgYWNjdW11bGF0ZSB0aGUgc3RhdHMuIEdpdmVuIHRoZSBudW1iZXIgb2YgTFBJ
cywgd2Ugd2lsbAo+IGF0IGxlYXN0IHRlc3QgdGhlIG1pZ3JhdGlvbiBvZiBzb21lIG9mIHRoZSBw
ZW5kaW5nIGJpdHMgYW5kIGVzcGVjaWFsbHkKPiBhZGphY2VudCBvbmVzLiBJdCBkb2VzIHdvcmsg
YXMgaXQgYWxsb3dzIHRvIHRlc3QgeW91ciBmaXg6Cj4gCj4gY2ExODViMjYwOTUxICBLVk06IGFy
bS9hcm02NDogdmdpYzogRG9uJ3QgcmVseSBvbiB0aGUgd3JvbmcgcGVuZGluZyB0YWJsZQoKRmFp
ciBlbm91Z2guIFRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbiEKCgpaZW5naHVpCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBs
aXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJp
YS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
