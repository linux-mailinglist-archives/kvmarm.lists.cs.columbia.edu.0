Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18B1B5B3A
	for <lists+kvmarm@lfdr.de>; Thu, 23 Apr 2020 14:18:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DBDE94B171;
	Thu, 23 Apr 2020 08:18:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cKlC4FI02Jt8; Thu, 23 Apr 2020 08:18:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D1C754B165;
	Thu, 23 Apr 2020 08:18:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 60A774B08D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Apr 2020 08:18:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TxhEFgh4hjeK for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Apr 2020 08:18:35 -0400 (EDT)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 24AC24B08A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Apr 2020 08:18:35 -0400 (EDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B62D4A5E8B3BB75455A8;
 Thu, 23 Apr 2020 20:18:31 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Apr 2020
 20:18:25 +0800
Subject: Re: [PATCH v3 5/6] KVM: arm64: vgic-v3: Retire all pending LPIs on
 vcpu destroy
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>
References: <20200422161844.3848063-1-maz@kernel.org>
 <20200422161844.3848063-6-maz@kernel.org>
 <2a0d1542-1964-c818-aae8-76f9227676b8@arm.com>
 <c4b89164d79b733bcc38801c9483417d@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5e611150-ce2a-7e90-ba9c-80275269b436@huawei.com>
Date: Thu, 23 Apr 2020 20:18:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <c4b89164d79b733bcc38801c9483417d@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Julien Grall <julien@xen.org>, kvm@vger.kernel.org,
 Andre Przywara <Andre.Przywara@arm.com>, kvmarm@lists.cs.columbia.edu,
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

T24gMjAyMC80LzIzIDIwOjAzLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gCj4gSSB0aGluayB0aGlz
IGlzIHNsaWdodGx5IG1vcmUgY29uY2VybmluZy4gVGhlIGlzc3VlIGlzIHRoYXQgd2UgaGF2ZQo+
IHN0YXJ0ZWQgZnJlZWluZyBwYXJ0cyBvZiB0aGUgaW50ZXJydXB0IHN0YXRlIGFscmVhZHkgKHdl
IGZyZWUgdGhlCj4gU1BJcyBlYXJseSBpbiBrdm1fdmdpY19kaXN0X2Rlc3Ryb3koKSkuCj4gCj4g
SWYgYSBTUEkgd2FzIHBlbmRpbmcgb3IgYWN0aXZlIGF0IHRoaXMgc3RhZ2UgKGkuZS4gcHJlc2Vu
dCBpbiB0aGUKPiBhcF9saXN0KSwgd2UgYXJlIGdvaW5nIHRvIGl0ZXJhdGUgb3ZlciBtZW1vcnkg
dGhhdCBoYXMgYmVlbiBmcmVlZAo+IGFscmVhZHkuIFRoaXMgaXMgYmFkLCBhbmQgdGhpcyBjYW4g
aGFwcGVuIG9uIEdJQ3YzIGFzIHdlbGwuCgpBaCwgSSB0aGluayB0aGlzIHNob3VsZCBiZSB0aGUg
Y2FzZS4KCj4gCj4gSSB0aGluayB0aGlzIHNob3VsZCBzb2x2ZSBpdCwgYnV0IEkgbmVlZCB0byB0
ZXN0IGl0IG9uIGEgR0lDdjIgc3lzdGVtOgoKQWdyZWVkLgoKPiAKPiBkaWZmIC0tZ2l0IGEvdmly
dC9rdm0vYXJtL3ZnaWMvdmdpYy1pbml0LmMgYi92aXJ0L2t2bS9hcm0vdmdpYy92Z2ljLWluaXQu
Ywo+IGluZGV4IDUzZWM5YjlkOWJjNDMuLjMwZGJlYzlmZTBiNGEgMTAwNjQ0Cj4gLS0tIGEvdmly
dC9rdm0vYXJtL3ZnaWMvdmdpYy1pbml0LmMKPiArKysgYi92aXJ0L2t2bS9hcm0vdmdpYy92Z2lj
LWluaXQuYwo+IEBAIC0zNjUsMTAgKzM2NSwxMCBAQCBzdGF0aWMgdm9pZCBfX2t2bV92Z2ljX2Rl
c3Ryb3koc3RydWN0IGt2bSAqa3ZtKQo+IAo+ICDCoMKgwqDCoCB2Z2ljX2RlYnVnX2Rlc3Ryb3ko
a3ZtKTsKPiAKPiAtwqDCoMKgIGt2bV92Z2ljX2Rpc3RfZGVzdHJveShrdm0pOwo+IC0KPiAgwqDC
oMKgwqAga3ZtX2Zvcl9lYWNoX3ZjcHUoaSwgdmNwdSwga3ZtKQo+ICDCoMKgwqDCoMKgwqDCoMKg
IGt2bV92Z2ljX3ZjcHVfZGVzdHJveSh2Y3B1KTsKPiArCj4gK8KgwqDCoCBrdm1fdmdpY19kaXN0
X2Rlc3Ryb3koa3ZtKTsKPiAgwqB9Cj4gCj4gIMKgdm9pZCBrdm1fdmdpY19kZXN0cm95KHN0cnVj
dCBrdm0gKmt2bSkKClRoYW5rcyBmb3IgdGhlIGZpeCwKWmVuZ2h1aQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1h
cm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21h
aWxtYW4vbGlzdGluZm8va3ZtYXJtCg==
