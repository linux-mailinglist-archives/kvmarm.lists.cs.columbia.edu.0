Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52A489CF2
	for <lists+kvmarm@lfdr.de>; Mon, 10 Jan 2022 16:58:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C65D94B19A;
	Mon, 10 Jan 2022 10:58:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KS3oTZ4kUfVW; Mon, 10 Jan 2022 10:58:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C3BC4B19D;
	Mon, 10 Jan 2022 10:58:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DD90C4B190
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 10:58:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CQL6DdwRM0bc for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Jan 2022 10:58:37 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AC7294B161
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Jan 2022 10:58:37 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 74C9460EF4;
 Mon, 10 Jan 2022 15:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA0DC36AE5;
 Mon, 10 Jan 2022 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641830315;
 bh=yy2g18ZmN6V9ofHPGdck09RwOJDBvsPANaHpXOcQECQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=W/cQTf1/z21ABUgAszAEP2BgFPvE9YEgWKljQMwmJ6gJbLqQOSnwQXOV/Q4zNr6yB
 xHYeV9IlJfEdy4gL8XJtjTYBa2xhAV0k0CWshEwx/bHQkbMu7A3k8UPvBl7hyDUJXz
 Na6pPAr9QtAHptoMmPRtycpNq8vOnMonKvc8uqUDufPv7uuEz7Lbc9tbXEq1jKswje
 cjYa9mXir1C+W9JlBKmg2Ee8uSSbQgs+FPFjnjlpSXCEUEgwRegKZTnXT4bF/1tLJ9
 sJNGM2S0p0im5T2v/C+RQ95xwa+RooWkSM6EXDRmlmw3hQCtvpooYgY0FdB4aQt5BF
 MGG8saYejYsKw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1n6x45-00HAi9-T9; Mon, 10 Jan 2022 15:58:34 +0000
Date: Mon, 10 Jan 2022 15:58:33 +0000
Message-ID: <87ilurtweu.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: eric.auger@redhat.com
Subject: Re: [PATCH v4 4/6] hw/arm/virt: Use the PA range to compute the
 memory map
In-Reply-To: <d7f793ab-bf78-32fb-e793-54a034ffd5d8@redhat.com>
References: <20220107163324.2491209-1-maz@kernel.org>
 <20220107163324.2491209-5-maz@kernel.org>
 <d7f793ab-bf78-32fb-e793-54a034ffd5d8@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, qemu-devel@nongnu.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, kernel-team@android.com,
 drjones@redhat.com, peter.maydell@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu
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

T24gTW9uLCAxMCBKYW4gMjAyMiAxNTozODo1NiArMDAwMCwKRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPiB3cm90ZToKPiAKPiBIaSBNYXJjLAo+IAo+IE9uIDEvNy8yMiA1OjMzIFBN
LCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gPiBUaGUgaGlnaG1lbSBhdHRyaWJ1dGUgaXMgbm90aGlu
ZyBidXQgYW5vdGhlciB3YXkgdG8gZXhwcmVzcyB0aGUKPiA+IFBBIHJhbmdlIG9mIGEgVk0uIFRv
IHN1cHBvcnQgSFcgdGhhdCBoYXMgYSBzbWFsbGVyIFBBIHJhbmdlIHRoZW4KPiA+IHdoYXQgUUVN
VSBhc3N1bWVzLCBwYXNzIHRoaXMgUEEgcmFuZ2UgdG8gdGhlIHZpcnRfc2V0X21lbW1hcCgpCj4g
PiBmdW5jdGlvbiwgYWxsb3dpbmcgaXQgdG8gY29ycmVjdGx5IGV4Y2x1ZGUgaGlnaG1lbSBkZXZp
Y2VzCj4gPiBpZiB0aGV5IGFyZSBvdXRzaWRlIG9mIHRoZSBQQSByYW5nZS4KPiA+Cj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+ID4gLS0tCj4gPiAgaHcv
YXJtL3ZpcnQuYyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdmlydC5jIGIvaHcvYXJtL3ZpcnQu
Ywo+ID4gaW5kZXggNTdjNTVlOGEzNy4uZGI0YjA2MzZlMSAxMDA2NDQKPiA+IC0tLSBhL2h3L2Fy
bS92aXJ0LmMKPiA+ICsrKyBiL2h3L2FybS92aXJ0LmMKPiA+IEBAIC0xNjYwLDcgKzE2NjAsNyBA
QCBzdGF0aWMgdWludDY0X3QgdmlydF9jcHVfbXBfYWZmaW5pdHkoVmlydE1hY2hpbmVTdGF0ZSAq
dm1zLCBpbnQgaWR4KQo+ID4gICAgICByZXR1cm4gYXJtX2NwdV9tcF9hZmZpbml0eShpZHgsIGNs
dXN0ZXJzeik7Cj4gPiAgfQo+ID4gIAo+ID4gLXN0YXRpYyB2b2lkIHZpcnRfc2V0X21lbW1hcChW
aXJ0TWFjaGluZVN0YXRlICp2bXMpCj4gPiArc3RhdGljIHZvaWQgdmlydF9zZXRfbWVtbWFwKFZp
cnRNYWNoaW5lU3RhdGUgKnZtcywgaW50IHBhX2JpdHMpCj4gPiAgewo+ID4gICAgICBNYWNoaW5l
U3RhdGUgKm1zID0gTUFDSElORSh2bXMpOwo+ID4gICAgICBod2FkZHIgYmFzZSwgZGV2aWNlX21l
bW9yeV9iYXNlLCBkZXZpY2VfbWVtb3J5X3NpemUsIG1lbXRvcDsKPiA+IEBAIC0xNjc4LDYgKzE2
NzgsMTMgQEAgc3RhdGljIHZvaWQgdmlydF9zZXRfbWVtbWFwKFZpcnRNYWNoaW5lU3RhdGUgKnZt
cykKPiA+ICAgICAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsKPiA+ICAgICAgfQo+ID4gIAo+ID4g
KyAgICAvKgo+ID4gKyAgICAgKiAhaGlnaG1lbSBpcyBleGFjdGx5IHRoZSBzYW1lIGFzIGxpbWl0
aW5nIHRoZSBQQSBzcGFjZSB0byAzMmJpdCwKPiA+ICsgICAgICogaXJyZXNwZWN0aXZlIG9mIHRo
ZSB1bmRlcmx5aW5nIGNhcGFiaWxpdGllcyBvZiB0aGUgSFcuCj4gPiArICAgICAqLwo+ID4gKyAg
ICBpZiAoIXZtcy0+aGlnaG1lbSkKPiA+ICsJICAgIHBhX2JpdHMgPSAzMjsKPiB5b3UgbmVlZCB7
fSBhY2NvcmRpbmcgdG8gdGhlIFFFTVUgY29kaW5nIHN0eWxlLiBXZWxjb21lIHRvIGEgbmV3IHNo
aW55Cj4gd29ybGQgOi0pCgpZZWFoLiBCZXR3ZWVuIHRoZSByZWR1Y2VkIGluZGVudGF0aW9uIGFu
ZCB0aGUgYXZhbGFuY2hlIG9mIGJyYWNlcywgbXkKYnJhaW4gZmFpbHMgdG8gcGF0dGVybi1tYXRj
aCBibG9ja3Mgb2YgY29kZS4gQW11c2luZyBob3cgaW5mbGV4aWJsZQp5b3UgYmVjb21lIGFmdGVy
IGEgY291cGxlIG9mIGRlY2FkZXMuLi4KCj4gPiArCj4gPiAgICAgIC8qCj4gPiAgICAgICAqIFdl
IGNvbXB1dGUgdGhlIGJhc2Ugb2YgdGhlIGhpZ2ggSU8gcmVnaW9uIGRlcGVuZGluZyBvbiB0aGUK
PiA+ICAgICAgICogYW1vdW50IG9mIGluaXRpYWwgYW5kIGRldmljZSBtZW1vcnkuIFRoZSBkZXZp
Y2UgbWVtb3J5IHN0YXJ0L3NpemUKPiA+IEBAIC0xNjkxLDggKzE2OTgsOSBAQCBzdGF0aWMgdm9p
ZCB2aXJ0X3NldF9tZW1tYXAoVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQo+ID4gIAo+ID4gICAgICAv
KiBCYXNlIGFkZHJlc3Mgb2YgdGhlIGhpZ2ggSU8gcmVnaW9uICovCj4gPiAgICAgIG1lbXRvcCA9
IGJhc2UgPSBkZXZpY2VfbWVtb3J5X2Jhc2UgKyBST1VORF9VUChkZXZpY2VfbWVtb3J5X3NpemUs
IEdpQik7Cj4gPiAtICAgIGlmICghdm1zLT5oaWdobWVtICYmIG1lbXRvcCA+IDQgKiBHaUIpIHsK
PiA+IC0gICAgICAgIGVycm9yX3JlcG9ydCgiaGlnaG1lbT1vZmYsIGJ1dCBtZW1vcnkgY3Jvc3Nl
cyB0aGUgNEdpQiBsaW1pdFxuIik7Cj4gPiArICAgIGlmIChtZW10b3AgPiBCSVRfVUxMKHBhX2Jp
dHMpKSB7Cj4gPiArCSAgICBlcnJvcl9yZXBvcnQoIkFkZHJlc3NpbmcgbGltaXRlZCB0byAlZCBi
aXRzLCBidXQgbWVtb3J5IGV4Y2VlZHMgaXQgYnkgJWxsdSBieXRlc1xuIiwKPiA+ICsJCQkgcGFf
Yml0cywgbWVtdG9wIC0gQklUX1VMTChwYV9iaXRzKSk7Cj4gPiAgICAgICAgICBleGl0KEVYSVRf
RkFJTFVSRSk7Cj4gPiAgICAgIH0KPiA+ICAgICAgaWYgKGJhc2UgPCBkZXZpY2VfbWVtb3J5X2Jh
c2UpIHsKPiA+IEBAIC0xNzExLDcgKzE3MTksMTMgQEAgc3RhdGljIHZvaWQgdmlydF9zZXRfbWVt
bWFwKFZpcnRNYWNoaW5lU3RhdGUgKnZtcykKPiA+ICAgICAgICAgIHZtcy0+bWVtbWFwW2ldLnNp
emUgPSBzaXplOwo+ID4gICAgICAgICAgYmFzZSArPSBzaXplOwo+ID4gICAgICB9Cj4gPiAtICAg
IHZtcy0+aGlnaGVzdF9ncGEgPSAodm1zLT5oaWdobWVtID8gYmFzZSA6IG1lbXRvcCkgLSAxOwo+
ID4gKwo+ID4gKyAgICAvKgo+ID4gKyAgICAgKiBJZiBiYXNlIGZpdHMgd2l0aGluIHBhX2JpdHMs
IGFsbCBnb29kLiBJZiBpdCBkb2Vzbid0LCBsaW1pdCBpdAo+ID4gKyAgICAgKiB0byB0aGUgZW5k
IG9mIFJBTSwgd2hpY2ggaXMgZ3VhcmFudGVlZCB0byBmaXQgd2l0aGluIHBhX2JpdHMuCj4gPiAr
ICAgICAqLwo+ID4gKyAgICB2bXMtPmhpZ2hlc3RfZ3BhID0gKGJhc2UgPD0gQklUX1VMTChwYV9i
aXRzKSA/IGJhc2UgOiBtZW10b3ApIC0gMTsKPiA+ICsKPiA+ICAgICAgaWYgKGRldmljZV9tZW1v
cnlfc2l6ZSA+IDApIHsKPiA+ICAgICAgICAgIG1zLT5kZXZpY2VfbWVtb3J5ID0gZ19tYWxsb2Mw
KHNpemVvZigqbXMtPmRldmljZV9tZW1vcnkpKTsKPiA+ICAgICAgICAgIG1zLT5kZXZpY2VfbWVt
b3J5LT5iYXNlID0gZGV2aWNlX21lbW9yeV9iYXNlOwo+ID4gQEAgLTE5MDIsMTIgKzE5MTYsMzgg
QEAgc3RhdGljIHZvaWQgbWFjaHZpcnRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpCj4gPiAg
ICAgIHVuc2lnbmVkIGludCBzbXBfY3B1cyA9IG1hY2hpbmUtPnNtcC5jcHVzOwo+ID4gICAgICB1
bnNpZ25lZCBpbnQgbWF4X2NwdXMgPSBtYWNoaW5lLT5zbXAubWF4X2NwdXM7Cj4gTW92ZSB0aGUg
Y3B1X3R5cGUgY2hlY2sgYmVmb3JlPwo+IAo+IMKgwqDCoCBpZiAoIWNwdV90eXBlX3ZhbGlkKG1h
Y2hpbmUtPmNwdV90eXBlKSkgewo+IMKgwqDCoMKgwqDCoMKgIGVycm9yX3JlcG9ydCgibWFjaC12
aXJ0OiBDUFUgdHlwZSAlcyBub3Qgc3VwcG9ydGVkIiwKPiBtYWNoaW5lLT5jcHVfdHlwZSk7Cj4g
wqDCoMKgwqDCoMKgwqAgZXhpdCgxKTsKPiDCoMKgwqAgfQo+ID4KClllcywgdmVyeSBnb29kIHBv
aW50LiBJIHdvbmRlciB3aHkgdGhpcyB3YXMgdHVja2VkIGF3YXkgcGFzdApjb21wdXRpbmcgdGhl
IG1lbW9yeSBtYXAgYW5kIHRoZSBHSUMgY29uZmlndXJhdGlvbi4uLiBBbnl3YXksIEknbGwKbW92
ZSBpdCB1cC4KClRoYW5rcywKCglNLgoKLS0gCldpdGhvdXQgZGV2aWF0aW9uIGZyb20gdGhlIG5v
cm0sIHByb2dyZXNzIGlzIG5vdCBwb3NzaWJsZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1AbGlzdHMuY3Mu
Y29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGlu
Zm8va3ZtYXJtCg==
