Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D449F153EA5
	for <lists+kvmarm@lfdr.de>; Thu,  6 Feb 2020 07:22:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 53D8C4A51E;
	Thu,  6 Feb 2020 01:22:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fenFR4Yp4-Aw; Thu,  6 Feb 2020 01:22:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F8AF4A535;
	Thu,  6 Feb 2020 01:22:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B4634A50F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 01:22:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZBdxmbXSwG17 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Feb 2020 01:22:35 -0500 (EST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BAF0F4A3B4
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 01:22:34 -0500 (EST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 40B44A058A6BDADCB195;
 Thu,  6 Feb 2020 14:22:30 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 14:22:24 +0800
Subject: Re: [PATCH 0/5] irqchip/gic-v4.1: Cleanup and fixes for GICv4.1
To: Marc Zyngier <maz@kernel.org>
References: <20200204090940.1225-1-yuzenghui@huawei.com>
 <004ca9ea2d525d5b1bcf1d78f10c61ba@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <df640d5a-e7ba-b1c8-51f9-89b843ad6adb@huawei.com>
Date: Thu, 6 Feb 2020 14:22:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <004ca9ea2d525d5b1bcf1d78f10c61ba@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: jason@lakedaemon.net, linux-kernel@vger.kernel.org, tglx@linutronix.de,
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

SGkgTWFyYywKCk9uIDIwMjAvMi81IDIwOjQ2LCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gSGkgWmVu
Z2h1aSwKPiAKPiBPbiAyMDIwLTAyLTA0IDA5OjA5LCBaZW5naHVpIFl1IHdyb3RlOgo+PiBIaSwK
Pj4KPj4gVGhpcyBzZXJpZXMgY29udGFpbnMgc29tZSBjbGVhbnVwcywgVlBST1BCQVNFUiBmaWVs
ZCBwcm9ncmFtbWluZyBmaXgKPj4gYW5kIGxldmVsMiB2UEUgdGFibGUgYWxsb2NhdGlvbiBlbmhh
bmNlbWVudCwgY29sbGVjdGVkIHdoaWxlIGxvb2tpbmcKPj4gdGhyb3VnaCB0aGUgR0lDdjQuMSBk
cml2ZXIgb25lIG1vcmUgdGltZS4KPj4KPj4gSG9wZSB0aGV5IHdpbGwgaGVscCwgdGhhbmtzIQo+
Pgo+PiBaZW5naHVpIFl1ICg1KToKPj4gwqAgaXJxY2hpcC9naWMtdjQuMTogRml4IHByb2dyYW1t
aW5nIG9mIEdJQ1JfVlBST1BCQVNFUl80XzFfU0laRQo+PiDCoCBpcnFjaGlwL2dpYy12NC4xOiBT
ZXQgdnBlX2wxX2Jhc2UgZm9yIGFsbCByZWRpc3RyaWJ1dG9ycwo+PiDCoCBpcnFjaGlwL2dpYy12
NC4xOiBFbnN1cmUgTDIgdlBFIHRhYmxlIGlzIGFsbG9jYXRlZCBhdCBSRCBsZXZlbAo+PiDCoCBp
cnFjaGlwL2dpYy12NC4xOiBEcm9wICd0bXAnIGluIGluaGVyaXRfdnBlX2wxX3RhYmxlX2Zyb21f
cmQoKQo+PiDCoCBpcnFjaGlwL2dpYy12My1pdHM6IFJlbW92ZSBzdXBlcmZsdW91cyBXQVJOX09O
Cj4+Cj4+IMKgZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLmPCoMKgIHwgODAgKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tCj4+IMKgaW5jbHVkZS9saW51eC9pcnFjaGlwL2FybS1n
aWMtdjMuaCB8wqAgMiArLQo+PiDCoDIgZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKPiAKPiBUaGFua3MgYSBsb3QgZm9yIHRoaXMsIG11Y2ggYXBwcmVjaWF0
ZWQsIEknbSBxdWl0ZSBoYXBweSB3aXRoIHRoZSBvdmVyYWxsCj4gc3RhdGUgb2YgdGhlIHNlcmll
cy4gSWYgeW91IGNhbiBqdXN0IGFkZHJlc3MgdGhlIGNvdXBsZSBvZiBuaXRzIEkgaGF2ZSBvbgo+
IHBhdGNoICMzLCBJJ2xsIHRoZW4gcXVldWUgdGhlIHNlcmllcyBhbmQgc2VuZCBvZmYgdG8gVGhv
bWFzIHRvZ2V0aGVyIHdpdGgKPiB0aGUgcmVzdCBvZiB0aGUgcXVldWVkIGZpeGVzLgoKSSB3aWxs
IHJlc3BpbiBwYXRjaCMzIHdpdGggeW91ciBzdWdnZXN0aW9uIGFuZCBzZW5kIHYyIHRvZGF5LgpU
aGFua3MgZm9yIHlvdXIgcmV2aWV3IQoKClplbmdodWkKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3Rz
LmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xp
c3RpbmZvL2t2bWFybQo=
