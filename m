Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACE927DDB0
	for <lists+kvmarm@lfdr.de>; Wed, 30 Sep 2020 03:21:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EFA9C4B32F;
	Tue, 29 Sep 2020 21:21:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MxDB9Sxlte7M; Tue, 29 Sep 2020 21:21:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E85294B31C;
	Tue, 29 Sep 2020 21:21:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B157A4B1B5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 21:21:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iDjZN6Qo7p2B for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Sep 2020 21:21:44 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2A9B14B1B1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Sep 2020 21:21:44 -0400 (EDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1D670E2F40661DD61525;
 Wed, 30 Sep 2020 09:21:41 +0800 (CST)
Received: from [10.174.187.69] (10.174.187.69) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 09:21:31 +0800
Subject: Re: [RFC PATCH 0/4] Add support for ARMv8.6 TWED feature
To: Marc Zyngier <maz@kernel.org>
References: <20200929091727.8692-1-wangjingyi11@huawei.com>
 <913250ae919fb9453feadd0527827d55@kernel.org>
From: Jingyi Wang <wangjingyi11@huawei.com>
Message-ID: <21241889-7fca-5cd3-a5d3-41eb34f9c960@huawei.com>
Date: Wed, 30 Sep 2020 09:21:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <913250ae919fb9453feadd0527827d55@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.187.69]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, fanhenglong@huawei.com,
 prime.zeng@hisilicon.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

SGkgTWFyYywKCk9uIDkvMjkvMjAyMCA2OjUwIFBNLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gT24g
MjAyMC0wOS0yOSAxMDoxNywgSmluZ3lpIFdhbmcgd3JvdGU6Cj4+IFRXRSBEZWxheSBpcyBhbiBv
cHRpb25hbCBmZWF0dXJlIGluIEFSTXY4LjYgRXh0ZW50aW9ucy4gVGhlcmUgaXMgYQo+PiBwZXJm
b3JtYW5jZSBiZW5lZml0IGluIHdhaXRpbmcgZm9yIGEgcGVyaW9kIG9mIHRpbWUgZm9yIGFuIGV2
ZW50IHRvCj4+IGFycml2ZSBiZWZvcmUgdGFraW5nIHRoZSB0cmFwIGFzIGl0IGlzIGNvbW1vbiB0
aGF0IGV2ZW50IHdpbGwgYXJyaXZlCj4+IOKAnHF1aXRlIHNvb27igJ0gYWZ0ZXIgZXhlY3V0aW5n
IHRoZSBXRkUgaW5zdHJ1Y3Rpb24uCj4gCj4gRGVmaW5lICJxdWl0ZSBzb29uIi4gUXVhbnRpZnkg
InBlcmZvcm1hbmNlIGJlbmVmaXRzIi4gV2hpY2ggYXJlIHRoZQo+IHdvcmtsb2FkcyB0aGF0IGFj
dHVhbGx5IGJlbmVmaXQgZnJvbSB0aGlzIGltaXRhdGlvbiBvZiB0aGUgeDg2IFBMRT8KPiAKPiBJ
IHdhcyBvcHBvc2VkIHRvIHRoaXMgd2hlbiB0aGUgc3BlYyB3YXMgZHJhZnRlZCwgYW5kIEkgc3Rp
bGwgYW0gZ2l2ZW4KPiB0aGF0IHRoZXJlIGlzIHplcm8gc3VwcG9ydGluZyBldmlkZW5jZSB0aGF0
IGl0IGJyaW5nIGFueSBnYWluIG92ZXIKPiBpbW1lZGlhdGUgdHJhcHBpbmcgaW4gYW4gb3ZlcnN1
YnNjcmliZWQgZW52aXJvbm1lbnQgKHdoaWNoIGlzIHRoZSBvbmx5Cj4gY2FzZSB3aGVyZSBpdCBt
YXR0ZXJzKS4KPiAKPiBUaGFua3MsCj4gCj4gIMKgwqDCoMKgwqDCoMKgIE0uCgpTdXJlLCBJIHdp
bGwgZG8gbW9yZSBwZXJmb3JtYW5jZSB0ZXN0cyBhbmQgcG9zdCB0aGUgcmVzdWx0cyBhcyBzb29u
IGFzCnBvc3NpYmxlLgoKVGhhbmtzLApKaW5neWkKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1AbGlzdHMuY3Mu
Y29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGlu
Zm8va3ZtYXJtCg==
