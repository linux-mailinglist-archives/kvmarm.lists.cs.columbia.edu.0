Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 183964A4B9
	for <lists+kvmarm@lfdr.de>; Tue, 18 Jun 2019 17:04:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A7EF94A514;
	Tue, 18 Jun 2019 11:04:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JPlJlD-pRfC0; Tue, 18 Jun 2019 11:04:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A9204A507;
	Tue, 18 Jun 2019 11:04:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2B5994A4FA
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Jun 2019 11:04:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XjN9iR4l0zPo for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Jun 2019 11:04:41 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C96214A47A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Jun 2019 11:04:41 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 740342B;
 Tue, 18 Jun 2019 08:04:41 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 664943F718;
 Tue, 18 Jun 2019 08:04:40 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: arm64: Skip more of the SError vaxorcism
To: Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
References: <20190610163034.116151-1-james.morse@arm.com>
 <54049114-9e59-dc1a-b355-6c3e7c0ab1f7@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <67f64f7e-3a01-9949-c0a7-1f8ccbf1edb4@arm.com>
Date: Tue, 18 Jun 2019 16:04:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <54049114-9e59-dc1a-b355-6c3e7c0ab1f7@arm.com>
Content-Language: en-GB
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
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

SGkgUm9iaW4sCgpPbiAxMC8wNi8yMDE5IDE3OjM4LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MTAvMDYvMjAxOSAxNzozMCwgSmFtZXMgTW9yc2Ugd3JvdGU6Cj4+IER1cmluZyBfX2d1ZXN0X2V4
aXQoKSB3ZSBuZWVkIHRvIGNvbnN1bWUgYW55IFNFcnJvciBsZWZ0IHBlbmRpbmcgYnkgdGhlCj4+
IGd1ZXN0IHNvIGl0IGRvZXNuJ3QgY29udGFtaW5hdGUgdGhlIGhvc3QuIFdpdGggdjguMiB3ZSB1
c2UgdGhlCj4+IEVTQi1pbnN0cnVjdGlvbi4gRm9yIHN5c3RlbXMgd2l0aG91dCB2OC4yLCB3ZSB1
c2UgZHNiK2lzYiBhbmQgdW5tYXNrCj4+IFNFcnJvci4gV2UgZG8gdGhpcyBvbiBldmVyeSBndWVz
dCBleGl0Lgo+Pgo+PiBVc2UgdGhlIHNhbWUgZHNiK2lzcl9lbDEgdHJpY2ssIHRoaXMgbGV0cyB1
cyBrbm93IGlmIGFuIFNFcnJvciBpcyBwZW5kaW5nCj4+IGFmdGVyIHRoZSBkc2IsIGFsbG93aW5n
IHVzIHRvIHNraXAgdGhlIGlzYiBhbmQgc2VsZi1zeW5jaHJvbmlzaW5nIFBTVEFURQo+PiB3cml0
ZSBpZiBpdHMgbm90Lgo+Pgo+PiBUaGlzIG1lYW5zIFNFcnJvciByZW1haW5zIG1hc2tlZCBkdXJp
bmcgS1ZNJ3Mgd29ybGQtc3dpdGNoLCBzbyBhbnkgU0Vycm9yCj4+IHRoYXQgb2NjdXJzIGR1cmlu
ZyB0aGlzIHRpbWUgaXMgcmVwb3J0ZWQgYnkgdGhlIGhvc3QsIGluc3RlYWQgb2YgY2F1c2luZwo+
PiBhIGh5cC1wYW5pYy4KPj4KPj4gSWYgeW91IGdpdmUgZ2NjIGxpa2VseSgpL3VubGlrZWx5KCkg
aGludHMgaW4gYW4gaWYoKSBjb25kaXRpb24sIGl0Cj4+IHNodWZmbGVzIHRoZSBnZW5lcmF0ZWQg
YXNzZW1ibHkgc28gdGhhdCB0aGUgbGlrZWx5IGNhc2UgaXMgaW1tZWRpYXRlbHkKPj4gYWZ0ZXIg
dGhlIGJyYW5jaC4gTGV0cyBkbyB0aGUgc2FtZSBoZXJlLgoKPj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQva3ZtL2h5cC9lbnRyeS5TIGIvYXJjaC9hcm02NC9rdm0vaHlwL2VudHJ5LlMKPj4gaW5k
ZXggYTVhNDI1NDMxNGExLi5jMmRlMWExZmFhZjQgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtNjQv
a3ZtL2h5cC9lbnRyeS5TCj4+ICsrKyBiL2FyY2gvYXJtNjQva3ZtL2h5cC9lbnRyeS5TCj4+IEBA
IC0xNjEsMTggKzE2MSwyNCBAQCBhbHRlcm5hdGl2ZV9pZiBBUk02NF9IQVNfUkFTX0VYVE4KPj4g
wqDCoMKgwqDCoCBvcnLCoMKgwqAgeDAsIHgwLCAjKDE8PEFSTV9FWElUX1dJVEhfU0VSUk9SX0JJ
VCkKPj4gwqAgMTrCoMKgwqAgcmV0Cj4+IMKgIGFsdGVybmF0aXZlX2Vsc2UKPj4gLcKgwqDCoCAv
LyBJZiB3ZSBoYXZlIGEgcGVuZGluZyBhc3luY2hyb25vdXMgYWJvcnQsIG5vdyBpcyB0aGUKPj4g
LcKgwqDCoCAvLyB0aW1lIHRvIGZpbmQgb3V0LiBGcm9tIHlvdXIgVkFYb3JjaXN0IGJvb2ssIHBh
Z2UgNjY2Ogo+PiArwqDCoMKgIGRzYsKgwqDCoCBzecKgwqDCoMKgwqDCoMKgIC8vIFN5bmNocm9u
aXplIGFnYWluc3QgaW4tZmxpZ2h0IGxkL3N0Cj4+ICvCoMKgwqAgbXJzwqDCoMKgIHgyLCBpc3Jf
ZWwxCj4+ICvCoMKgwqAgYW5kwqDCoMKgIHgyLCB4MiwgIygxPDw4KcKgwqDCoCAvLyBJU1JfRUwx
LkEKPj4gK8KgwqDCoCBjYm56wqDCoMKgIHgyLCAyZgoKPiBJdCBkb2Vzbid0IGFwcGVhciB0aGF0
IGFueW9uZSBjYXJlcyBtdWNoIGFib3V0IHgyIGNvbnRhaW5pbmcgdGhlIG1hc2tlZCB2YWx1ZSBh
ZnRlcgo+IHJldHVybmluZywgc28gaXMgdGhpcyBqdXN0IGEgbmVlZGxlc3NseSBsb25nLWZvcm0g
VEJOWj8KClllcywgSSdkIG1ha2UgYSB0aGlyZC1yYXRlIGNvbXBpbGVyLgoKKEkgYWxtb3N0IGNl
cnRhaW5seSBoYWQgJ2NtcCB4MiwgeHpyJyBpbiB0aGVyZSBhdCBzb21lIHBvaW50ISkKCgpUaGFu
a3MsCgpKYW1lcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6
Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
