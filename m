Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C26621805BB
	for <lists+kvmarm@lfdr.de>; Tue, 10 Mar 2020 19:01:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 442F64A534;
	Tue, 10 Mar 2020 14:01:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6XsZWuuR07dz; Tue, 10 Mar 2020 14:01:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B5384A50F;
	Tue, 10 Mar 2020 14:00:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 58A064A4A9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 14:00:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rc2dKwzzGAY9 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 10 Mar 2020 14:00:55 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B40C540A52
 for <kvmarm@lists.cs.columbia.edu>; Tue, 10 Mar 2020 14:00:55 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8F2C9205C9;
 Tue, 10 Mar 2020 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583863254;
 bh=6sC5CXMZeZmFyPY4N3hUbTKkfIifAKMmggTGMEoEi7w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DJyvE1xtCnbRh7r668b7VkOHRUIsGfKDlP3v3NGffMrvqldyS1hDKGTXOdICt2Rgg
 4z/G+EmjJpbBXxZRvD0ZfhiI5fDBWuejP+KwW7P3xgxm7akx5/ubjOXDOGCGhnDcbC
 0Oo83kiBMe3Tg+Vm6lkkM/aBH78dsXh15ZfdkUwM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jBjBU-00Bh1d-TO; Tue, 10 Mar 2020 18:00:53 +0000
MIME-Version: 1.0
Date: Tue, 10 Mar 2020 18:00:52 +0000
From: Marc Zyngier <maz@kernel.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: arm64: Add PMU event filtering infrastructure
In-Reply-To: <7c9e2e55-95c8-a212-e566-c48f5d3bc417@redhat.com>
References: <20200309124837.19908-1-maz@kernel.org>
 <20200309124837.19908-2-maz@kernel.org>
 <70e712fc-6789-2384-c21c-d932b5e1a32f@redhat.com>
 <0027398587e8746a6a7459682330855f@kernel.org>
 <7c9e2e55-95c8-a212-e566-c48f5d3bc417@redhat.com>
Message-ID: <470c88271ef8c4f92ecf990b7b86658e@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, mark.rutland@arm.com,
 kvm@vger.kernel.org, suzuki.poulose@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com,
 kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

T24gMjAyMC0wMy0xMCAxNzo0MCwgQXVnZXIgRXJpYyB3cm90ZToKPiBIaSBNYXJjLAo+IAo+IE9u
IDMvMTAvMjAgMTI6MDMgUE0sIE1hcmMgWnluZ2llciB3cm90ZToKPj4gSGkgRXJpYywKPj4gCj4+
IE9uIDIwMjAtMDMtMDkgMTg6MDUsIEF1Z2VyIEVyaWMgd3JvdGU6Cj4+PiBIaSBNYXJjLAo+Pj4g
Cj4+PiBPbiAzLzkvMjAgMTo0OCBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOgo+Pj4+IEl0IGNhbiBi
ZSBkZXNpcmFibGUgdG8gZXhwb3NlIGEgUE1VIHRvIGEgZ3Vlc3QsIGFuZCB5ZXQgbm90IHdhbnQg
dGhlCj4+Pj4gZ3Vlc3QgdG8gYmUgYWJsZSB0byBjb3VudCBzb21lIG9mIHRoZSBpbXBsZW1lbnRl
ZCBldmVudHMgKGJlY2F1c2UgCj4+Pj4gdGhpcwo+Pj4+IHdvdWxkIGdpdmUgaW5mb3JtYXRpb24g
b24gc2hhcmVkIHJlc291cmNlcywgZm9yIGV4YW1wbGUuCj4+Pj4gCj4+Pj4gRm9yIHRoaXMsIGxl
dCdzIGV4dGVuZCB0aGUgUE1VdjMgZGV2aWNlIEFQSSwgYW5kIG9mZmVyIGEgd2F5IHRvIAo+Pj4+
IHNldHVwIGEKPj4+PiBiaXRtYXAgb2YgdGhlIGFsbG93ZWQgZXZlbnRzICh0aGUgZGVmYXVsdCBi
ZWluZyBubyBiaXRtYXAsIGFuZCB0aHVzIAo+Pj4+IG5vCj4+Pj4gZmlsdGVyaW5nKS4KPj4+PiAK
Pj4+PiBVc2Vyc3BhY2UgY2FuIHRodXMgYWxsb3cvZGVueSByYW5nZXMgb2YgZXZlbnQuIFRoZSBk
ZWZhdWx0IHBvbGljeQo+Pj4+IGRlcGVuZHMgb24gdGhlICJwb2xhcml0eSIgb2YgdGhlIGZpcnN0
IGZpbHRlciBzZXR1cCAoZGVmYXVsdCBkZW55IGlmIAo+Pj4+IHRoZQo+Pj4+IGZpbHRlciBhbGxv
d3MgZXZlbnRzLCBhbmQgZGVmYXVsdCBhbGxvdyBpZiB0aGUgZmlsdGVyIGRlbmllcyAKPj4+PiBl
dmVudHMpLgo+Pj4+IFRoaXMgYWxsb3dzIHRvIHNldHVwIGV4YWN0bHkgd2hhdCBpcyBhbGxvd2Vk
IGZvciBhIGdpdmVuIGd1ZXN0Lgo+Pj4+IAo+Pj4+IE5vdGUgdGhhdCBhbHRob3VnaCB0aGUgaW9j
dGwgaXMgcGVyLXZjcHUsIHRoZSBtYXAgb2YgYWxsb3dlZCBldmVudHMgCj4+Pj4gaXMKPj4+PiBn
bG9iYWwgdG8gdGhlIFZNIChpdCBjYW4gYmUgc2V0dXAgZnJvbSBhbnkgdmNwdSB1bnRpbCB0aGUg
dmNwdSBQTVUgCj4+Pj4gaXMKPj4+PiBpbml0aWFsaXplZCkuCj4+Pj4gCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4KPj4+PiAtLS0KPj4+PiDCoGFyY2gv
YXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8wqAgNiArKysKPj4+PiDCoGFyY2gvYXJtNjQv
aW5jbHVkZS91YXBpL2FzbS9rdm0uaCB8IDE2ICsrKysrKwo+Pj4+IMKgdmlydC9rdm0vYXJtL2Fy
bS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICsKPj4+PiDCoHZpcnQva3Zt
L2FybS9wbXUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDg0IAo+Pj4+ICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0KPj4+PiDCoDQgZmlsZXMgY2hhbmdlZCwgOTIgaW5z
ZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4+Pj4gCj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+Pj4+IGIvYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9rdm1faG9zdC5oCj4+Pj4gaW5kZXggNTdmZDQ2YWNkMDU4Li44ZTYzYzYxODY4OGQgMTAwNjQ0
Cj4+Pj4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCj4+Pj4gKysrIGIv
YXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCj4+Pj4gQEAgLTkxLDYgKzkxLDEyIEBA
IHN0cnVjdCBrdm1fYXJjaCB7Cj4+Pj4gwqDCoMKgwqDCoCAqIHN1cHBvcnRlZC4KPj4+PiDCoMKg
wqDCoMKgICovCj4+Pj4gwqDCoMKgwqAgYm9vbCByZXR1cm5fbmlzdl9pb19hYm9ydF90b191c2Vy
Owo+Pj4+ICsKPj4+PiArwqDCoMKgIC8qCj4+Pj4gK8KgwqDCoMKgICogVk0td2lkZSBQTVUgZmls
dGVyLCBpbXBsZW1lbnRlZCBhcyBhIGJpdG1hcCBhbmQgYmlnIGVub3VnaAo+Pj4+ICvCoMKgwqDC
oCAqIGZvciB1cCB0byA2NTUzNiBldmVudHMKPj4+PiArwqDCoMKgwqAgKi8KPj4+PiArwqDCoMKg
IHVuc2lnbmVkIGxvbmcgKnBtdV9maWx0ZXI7Cj4+Pj4gwqB9Owo+Pj4+IAo+Pj4+IMKgI2RlZmlu
ZSBLVk1fTlJfTUVNX09CSlPCoMKgwqDCoCA0MAo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2luY2x1ZGUvdWFwaS9hc20va3ZtLmgKPj4+PiBiL2FyY2gvYXJtNjQvaW5jbHVkZS91YXBpL2Fz
bS9rdm0uaAo+Pj4+IGluZGV4IGJhODViYjIzZjA2MC4uN2IxNTExZDZjZTQ0IDEwMDY0NAo+Pj4+
IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS91YXBpL2FzbS9rdm0uaAo+Pj4+ICsrKyBiL2FyY2gv
YXJtNjQvaW5jbHVkZS91YXBpL2FzbS9rdm0uaAo+Pj4+IEBAIC0xNTksNiArMTU5LDIxIEBAIHN0
cnVjdCBrdm1fc3luY19yZWdzIHsKPj4+PiDCoHN0cnVjdCBrdm1fYXJjaF9tZW1vcnlfc2xvdCB7
Cj4+Pj4gwqB9Owo+Pj4+IAo+Pj4+ICsvKgo+Pj4+ICsgKiBQTVUgZmlsdGVyIHN0cnVjdHVyZS4g
RGVzY3JpYmUgYSByYW5nZSBvZiBldmVudHMgd2l0aCBhIAo+Pj4+IHBhcnRpY3VsYXIKPj4+PiAr
ICogYWN0aW9uLiBUbyBiZSB1c2VkIHdpdGggS1ZNX0FSTV9WQ1BVX1BNVV9WM19GSUxURVIuCj4+
Pj4gKyAqLwo+Pj4+ICtzdHJ1Y3Qga3ZtX3BtdV9ldmVudF9maWx0ZXIgewo+Pj4+ICvCoMKgwqAg
X191MTbCoMKgwqAgYmFzZV9ldmVudDsKPj4+PiArwqDCoMKgIF9fdTE2wqDCoMKgIG5ldmVudHM7
Cj4+Pj4gKwo+Pj4+ICsjZGVmaW5lIEtWTV9QTVVfRVZFTlRfQUxMT1fCoMKgwqAgMAo+Pj4+ICsj
ZGVmaW5lIEtWTV9QTVVfRVZFTlRfREVOWcKgwqDCoCAxCj4+Pj4gKwo+Pj4+ICvCoMKgwqAgX191
OMKgwqDCoCBhY3Rpb247Cj4+Pj4gK8KgwqDCoCBfX3U4wqDCoMKgIHBhZFszXTsKPj4+PiArfTsK
Pj4+PiArCj4+Pj4gwqAvKiBmb3IgS1ZNX0dFVC9TRVRfVkNQVV9FVkVOVFMgKi8KPj4+PiDCoHN0
cnVjdCBrdm1fdmNwdV9ldmVudHMgewo+Pj4+IMKgwqDCoMKgIHN0cnVjdCB7Cj4+Pj4gQEAgLTMy
OSw2ICszNDQsNyBAQCBzdHJ1Y3Qga3ZtX3ZjcHVfZXZlbnRzIHsKPj4+PiDCoCNkZWZpbmUgS1ZN
X0FSTV9WQ1BVX1BNVV9WM19DVFJMwqDCoMKgIDAKPj4+PiDCoCNkZWZpbmXCoMKgIEtWTV9BUk1f
VkNQVV9QTVVfVjNfSVJRwqDCoMKgIDAKPj4+PiDCoCNkZWZpbmXCoMKgIEtWTV9BUk1fVkNQVV9Q
TVVfVjNfSU5JVMKgwqDCoCAxCj4+Pj4gKyNkZWZpbmXCoMKgIEtWTV9BUk1fVkNQVV9QTVVfVjNf
RklMVEVSwqDCoMKgIDIKPj4+PiDCoCNkZWZpbmUgS1ZNX0FSTV9WQ1BVX1RJTUVSX0NUUkzCoMKg
wqDCoMKgwqDCoCAxCj4+Pj4gwqAjZGVmaW5lwqDCoCBLVk1fQVJNX1ZDUFVfVElNRVJfSVJRX1ZU
SU1FUsKgwqDCoMKgwqDCoMKgIDAKPj4+PiDCoCNkZWZpbmXCoMKgIEtWTV9BUk1fVkNQVV9USU1F
Ul9JUlFfUFRJTUVSwqDCoMKgwqDCoMKgwqAgMQo+Pj4+IGRpZmYgLS1naXQgYS92aXJ0L2t2bS9h
cm0vYXJtLmMgYi92aXJ0L2t2bS9hcm0vYXJtLmMKPj4+PiBpbmRleCBlZGE3YjYyNGVhYjguLjhk
ODQ5YWM4OGE0NCAxMDA2NDQKPj4+PiAtLS0gYS92aXJ0L2t2bS9hcm0vYXJtLmMKPj4+PiArKysg
Yi92aXJ0L2t2bS9hcm0vYXJtLmMKPj4+PiBAQCAtMTY0LDYgKzE2NCw4IEBAIHZvaWQga3ZtX2Fy
Y2hfZGVzdHJveV92bShzdHJ1Y3Qga3ZtICprdm0pCj4+Pj4gwqDCoMKgwqAgZnJlZV9wZXJjcHUo
a3ZtLT5hcmNoLmxhc3RfdmNwdV9yYW4pOwo+Pj4+IMKgwqDCoMKgIGt2bS0+YXJjaC5sYXN0X3Zj
cHVfcmFuID0gTlVMTDsKPj4+PiAKPj4+PiArwqDCoMKgIGJpdG1hcF9mcmVlKGt2bS0+YXJjaC5w
bXVfZmlsdGVyKTsKPj4+PiArCj4+Pj4gwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IEtWTV9NQVhf
VkNQVVM7ICsraSkgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKGt2bS0+dmNwdXNbaV0pIHsK
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga3ZtX3ZjcHVfZGVzdHJveShrdm0tPnZjcHVz
W2ldKTsKPj4+PiBkaWZmIC0tZ2l0IGEvdmlydC9rdm0vYXJtL3BtdS5jIGIvdmlydC9rdm0vYXJt
L3BtdS5jCj4+Pj4gaW5kZXggZjBkMDMxMmMwYTU1Li45ZjBmZDAyMjRkNWIgMTAwNjQ0Cj4+Pj4g
LS0tIGEvdmlydC9rdm0vYXJtL3BtdS5jCj4+Pj4gKysrIGIvdmlydC9rdm0vYXJtL3BtdS5jCj4+
Pj4gQEAgLTU3OSwxMCArNTc5LDE5IEBAIHN0YXRpYyB2b2lkIGt2bV9wbXVfY3JlYXRlX3BlcmZf
ZXZlbnQoc3RydWN0Cj4+Pj4ga3ZtX3ZjcHUgKnZjcHUsIHU2NCBzZWxlY3RfaWR4KQo+Pj4+IAo+
Pj4+IMKgwqDCoMKgIGt2bV9wbXVfc3RvcF9jb3VudGVyKHZjcHUsIHBtYyk7Cj4+Pj4gwqDCoMKg
wqAgZXZlbnRzZWwgPSBkYXRhICYgQVJNVjhfUE1VX0VWVFlQRV9FVkVOVDsKPj4+PiArwqDCoMKg
IGlmIChwbWMtPmlkeCA9PSBBUk1WOF9QTVVfQ1lDTEVfSURYKQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBldmVudHNlbCA9IEFSTVY4X1BNVVYzX1BFUkZDVFJfQ1BVX0NZQ0xFUzsKPj4+IG5pdDoKPj4+
IMKgwqDCoMKgaWYgKHBtYy0+aWR4ID09IEFSTVY4X1BNVV9DWUNMRV9JRFgpCj4+PiDCoMKgwqDC
oMKgwqDCoCBldmVudHNlbCA9IEFSTVY4X1BNVVYzX1BFUkZDVFJfQ1BVX0NZQ0xFUzsKPj4+IMKg
wqDCoMKgZWxzZQo+Pj4gwqDCoMKgwqDCoMKgwqAgZXZlbnRzZWwgPSBkYXRhICYgQVJNVjhfUE1V
X0VWVFlQRV9FVkVOVDsKPj4gCj4+IFlvdSBkb24ndCBsaWtlIGl0PyA7LSkKPiA/IGV2ZW50c2V0
IHNldCBvbmx5IG9uY2UgaW5zdGVhZCBvZiAyIHRpbWVzCgpUaGUgY29tcGlsZXIgZG9lcyB0aGUg
cmlnaHQgdGhpbmcsIGJ1dCBzb3JlLCBJJ2xsIGNoYW5nZSBpdC4KCj4+IAo+Pj4+IAo+Pj4+IMKg
wqDCoMKgIC8qIFNvZnR3YXJlIGluY3JlbWVudCBldmVudCBkb2VzJ3QgbmVlZCB0byBiZSBiYWNr
ZWQgYnkgYSBwZXJmCj4+Pj4gZXZlbnQgKi8KPj4+IG5pdDogd2hpbGUgd2VyIGFyZSBhdCBpdCBm
aXggdGhlIGRvZXMndCB0eXBvCj4+Pj4gLcKgwqDCoCBpZiAoZXZlbnRzZWwgPT0gQVJNVjhfUE1V
VjNfUEVSRkNUUl9TV19JTkNSICYmCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHBtYy0+aWR4ICE9IEFS
TVY4X1BNVV9DWUNMRV9JRFgpCj4+Pj4gK8KgwqDCoCBpZiAoZXZlbnRzZWwgPT0gQVJNVjhfUE1V
VjNfUEVSRkNUUl9TV19JTkNSKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+Pj4gKwo+
Pj4+ICvCoMKgwqAgLyoKPj4+PiArwqDCoMKgwqAgKiBJZiB3ZSBoYXZlIGEgZmlsdGVyIGluIHBs
YWNlIGFuZCB0aGF0IHRoZSBldmVudCBpc24ndAo+Pj4+IGFsbG93ZWQsIGRvCj4+Pj4gK8KgwqDC
oMKgICogbm90IGluc3RhbGwgYSBwZXJmIGV2ZW50IGVpdGhlci4KPj4+PiArwqDCoMKgwqAgKi8K
Pj4+PiArwqDCoMKgIGlmICh2Y3B1LT5rdm0tPmFyY2gucG11X2ZpbHRlciAmJgo+Pj4+ICvCoMKg
wqDCoMKgwqDCoCAhdGVzdF9iaXQoZXZlbnRzZWwsIHZjcHUtPmt2bS0+YXJjaC5wbXVfZmlsdGVy
KSkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+PiAKPj4+PiDCoMKgwqDCoCBtZW1z
ZXQoJmF0dHIsIDAsIHNpemVvZihzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyKSk7Cj4+Pj4gQEAgLTU5
NCw4ICs2MDMsNyBAQCBzdGF0aWMgdm9pZCBrdm1fcG11X2NyZWF0ZV9wZXJmX2V2ZW50KHN0cnVj
dAo+Pj4+IGt2bV92Y3B1ICp2Y3B1LCB1NjQgc2VsZWN0X2lkeCkKPj4+PiDCoMKgwqDCoCBhdHRy
LmV4Y2x1ZGVfa2VybmVsID0gZGF0YSAmIEFSTVY4X1BNVV9FWENMVURFX0VMMSA/IDEgOiAwOwo+
Pj4+IMKgwqDCoMKgIGF0dHIuZXhjbHVkZV9odiA9IDE7IC8qIERvbid0IGNvdW50IEVMMiBldmVu
dHMgKi8KPj4+PiDCoMKgwqDCoCBhdHRyLmV4Y2x1ZGVfaG9zdCA9IDE7IC8qIERvbid0IGNvdW50
IGhvc3QgZXZlbnRzICovCj4+Pj4gLcKgwqDCoCBhdHRyLmNvbmZpZyA9IChwbWMtPmlkeCA9PSBB
Uk1WOF9QTVVfQ1lDTEVfSURYKSA/Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIEFSTVY4X1BNVVYzX1BF
UkZDVFJfQ1BVX0NZQ0xFUyA6IGV2ZW50c2VsOwo+Pj4+ICvCoMKgwqAgYXR0ci5jb25maWcgPSBl
dmVudHNlbDsKPj4+IFNvIGluIHRoYXQgY2FzZSB0aGUgZ3Vlc3QgY291bnRlciB3aWxsIG5vdCBp
bmNyZW1lbnQgYnV0IHRoZSBndWVzdCAKPj4+IGRvZXMKPj4+IG5vdCBrbm93IHRoZSBjb3VudGVy
IGlzIG5vdCBpbXBsZW1lbnRlZC4gQ2FuJ3QgdGhpcyBsZWFkIHRvIGJhZCB1c2VyCj4+PiBleHBl
cmllbmNlLiBTaG91bGRuJ3QgdGhpcyBkaXNhYmxlbWVudCBiZSByZWZsZWN0ZWQgaW4gUE1DRUlE
MC8xIAo+Pj4gcmVncz8KPj4gCj4+IFRoZSB3aG9sZSBwb2ludCBpcyB0aGF0IHdlIHdhbnQgdG8g
a2VlcCB0aGluZ3MgaGlkZGVuIGZyb20gdGhlIGd1ZXN0Lgo+PiBBbHNvLCBQTUNFSUR7MCwxfSBv
bmx5IGRlc2NyaWJlIGEgc21hbGwgc2V0IG9mIGV2ZW50cyAodGhlIGFyY2hpdGVjdGVkCj4+IGNv
bW1vbiBldmVudHMpLCBhbmQgbm90IHRoZSB3aG9sZSByYW5nZSBvZiBtaWNyb2FyY2hpdGVjdHVy
YWwgZXZlbnRzCj4+IHRoYXQgdGhlIENQVSBpbXBsZW1lbnRzLgo+IAo+IEkgYW0gc3RpbGwgbm90
IHRvdGFsbHkgY29udmluY2VkLiBUaGluZ3MgYXJlIG5vdCB0b3RhbGx5IGhpZGRlbiB0byB0aGUK
PiBndWVzdCBhcyB0aGUgY291bnRlciBkb2VzIG5vdCBpbmNyZW1lbnQsIHJpZ2h0PyBTbyBhIGd1
ZXN0IG1heSB0cnkgdG8KPiB1c2UgYXMgaXQgaXMgYWR2ZXJ0aXNlZCBpbiBQTUNFSUQwLzEgYnV0
IG5vdCBnZXQgdGhlIGV4cGVjdGVkIHJlc3VsdHMKPiBsZWFkaW5nIHRvIHBvdGVudGlhbCBzdXBw
b3J0IHJlcXVlc3QuIEkgYWdyZWUgbm90IGFsbCB0aGUgZXZlbnRzIGFyZQo+IGRlc2NyaWJlZCB0
aGVyZSBidXQgeW91ciBBUEkgYWxzbyBhbGxvd3MgdG8gZmlsdGVyIG91dCBzb21lIG9mIHRoZSBv
bmVzCj4gdGhhdCBhcmUgYWR2ZXJ0aXNlZC4KCkkgdGhpbmsgd2UncmUgYXQgb2RkcyB3aGVuIGl0
IGNvbWVzIHRvIHRoZSBnb2FsIG9mIHRoaXMgc2VyaWVzLiBJZiB5b3UKcmVhZCB0aGUgQ1BVIFRS
TSwgeW91IHdpbGwgZmluZCB0aGF0IGV2ZW50IFggaXMgaW1wbGVtZW50ZWQuIFlvdSBsb29rCmF0
IFBNQ0VJRHgsIGFuZCB5b3UgZmluZCBpdCBpcyBub3QuIFlvdSBzdGlsbCBnZXQgYSBzdXBwb3J0
IHJlcXVlc3QhIDstKQoKRHJvcHBpbmcgZXZlbnRzIGZyb20gdGhlc2UgcmVnaXN0ZXJzIGlzIHRv
dGFsbHkgdHJpdmlhbCwgYnV0IEknbSBub3QKc3VyZSB0aGlzIHdpbGwgcmVkdWNlIHRoZSBzdXJw
cmlzZSBlZmZlY3QuIEl0IGRvZXNuJ3QgaHVydCBhbnl3YXksIHNvCkknbGwgaW1wbGVtZW50IHRo
YXQuCgo+PiAKPj4+PiAKPj4+PiDCoMKgwqDCoCBjb3VudGVyID0ga3ZtX3BtdV9nZXRfcGFpcl9j
b3VudGVyX3ZhbHVlKHZjcHUsIHBtYyk7Cj4+Pj4gCj4+Pj4gQEAgLTczNSwxNSArNzQzLDYgQEAg
aW50IGt2bV9hcm1fcG11X3YzX2VuYWJsZShzdHJ1Y3Qga3ZtX3ZjcHUgCj4+Pj4gKnZjcHUpCj4+
Pj4gCj4+Pj4gwqBzdGF0aWMgaW50IGt2bV9hcm1fcG11X3YzX2luaXQoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1KQo+Pj4+IMKgewo+Pj4+IC3CoMKgwqAgaWYgKCFrdm1fYXJtX3N1cHBvcnRfcG11X3Yz
KCkpCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PREVWOwo+Pj4+IC0KPj4+PiAtwqDC
oMKgIGlmICghdGVzdF9iaXQoS1ZNX0FSTV9WQ1BVX1BNVV9WMywgdmNwdS0+YXJjaC5mZWF0dXJl
cykpCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5YSU87Cj4+Pj4gLQo+Pj4+IC3CoMKg
wqAgaWYgKHZjcHUtPmFyY2gucG11LmNyZWF0ZWQpCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVy
biAtRUJVU1k7Cj4+Pj4gLQo+Pj4+IMKgwqDCoMKgIGlmIChpcnFjaGlwX2luX2tlcm5lbCh2Y3B1
LT5rdm0pKSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpbnQgcmV0Owo+Pj4+IAo+Pj4+IEBAIC03
OTQsOCArNzkzLDE5IEBAIHN0YXRpYyBib29sIHBtdV9pcnFfaXNfdmFsaWQoc3RydWN0IGt2bSAq
a3ZtLAo+Pj4+IGludCBpcnEpCj4+Pj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4+Pj4gwqB9Cj4+
Pj4gCj4+Pj4gKyNkZWZpbmUgTlJfRVZFTlRTwqDCoMKgIChBUk1WOF9QTVVfRVZUWVBFX0VWRU5U
ICsgMSkKPj4+PiArCj4+Pj4gwqBpbnQga3ZtX2FybV9wbXVfdjNfc2V0X2F0dHIoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LCBzdHJ1Y3QKPj4+PiBrdm1fZGV2aWNlX2F0dHIgKmF0dHIpCj4+Pj4gwqB7
Cj4+Pj4gK8KgwqDCoCBpZiAoIWt2bV9hcm1fc3VwcG9ydF9wbXVfdjMoKSkKPj4+PiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgaWYgKCF0ZXN0X2Jp
dChLVk1fQVJNX1ZDUFVfUE1VX1YzLCB2Y3B1LT5hcmNoLmZlYXR1cmVzKSkKPj4+PiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7Cj4+PiBJIHNlZSB5b3UgY2hhbmdlZCAtRU5YSU8gaW50
byAtRU5PREVWLiB3YW50ZWQ/Cj4+IAo+PiBQcm9iYWJseSBub3QuLi4gYnV0IHNlZSBiZWxvdy4K
Pj4gCj4+Pj4gKwo+Pj4+ICvCoMKgwqAgaWYgKHZjcHUtPmFyY2gucG11LmNyZWF0ZWQpCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUJVU1k7Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgIHN3aXRj
aCAoYXR0ci0+YXR0cikgewo+Pj4+IMKgwqDCoMKgIGNhc2UgS1ZNX0FSTV9WQ1BVX1BNVV9WM19J
UlE6IHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgIGludCBfX3VzZXIgKnVhZGRyID0gKGludCBfX3Vz
ZXIgKikobG9uZylhdHRyLT5hZGRyOwo+Pj4+IEBAIC04MDQsOSArODE0LDYgQEAgaW50IGt2bV9h
cm1fcG11X3YzX3NldF9hdHRyKHN0cnVjdCBrdm1fdmNwdQo+Pj4+ICp2Y3B1LCBzdHJ1Y3Qga3Zt
X2RldmljZV9hdHRyICphdHRyKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFpcnFjaGlwX2lu
X2tlcm5lbCh2Y3B1LT5rdm0pKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
LUVJTlZBTDsKPj4+PiAKPj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKCF0ZXN0X2JpdChLVk1fQVJN
X1ZDUFVfUE1VX1YzLCB2Y3B1LT5hcmNoLmZlYXR1cmVzKSkKPj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPj4+PiAtCj4+IAo+PiBIZXJlJ3Mgd2h5LiBJIHdvbmRl
ciBpZiB3ZSBhbHJlYWR5IGhhdmUgYSBwcm9ibGVtIHdpdGggdGhlIGNvbnNpc3RlbmN5Cj4+IG9m
IHRoZQo+PiBlcnJvciBjb2RlcyByZXR1cm5lZCB0byB1c2Vyc3BhY2UuCj4gT0suIFRoZW4geW91
IG1heSBkb2N1bWVudCBpdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2U/CgpJIHN0aWxsIG5lZWQgdG8g
d29yayBvdXQgd2hldGhlciB3ZSBhY3R1YWxseSBoYXZlIGFuIGlzc3VlIG9uIHRoYXQuCgpbLi4u
XQoKPj4+IG5vdCByZWxhdGVkIHRvIHRoaXMgcGF0Y2ggYnV0IHNob3VsZG4ndCB3ZSBhZHZlcnRp
c2UgdGhpcyBvbmx5IHdpdGgKPj4+IGluLWtlcm5lbCBpcnFjaGlwPwo+PiAKPj4gV2UgZG8gc3Vw
cG9ydCB0aGUgUE1VIHdpdGhvdXQgdGhlIGluLWtlcm5lbCBjaGlwLCB1bmZvcnR1bmF0ZWx5Li4u
IAo+PiBZZXMsCj4+IHN1cHBvcnRpbmcgdGhpcyBmZWF0dXJlIHdhcyBhIGJpZyBtaXN0YWtlLgo+
IEJ1dCBJIHNlZSBpbiBrdm1fYXJtX3BtdV92M19zZXRfYXR0cjoKPiBjYXNlIEtWTV9BUk1fVkNQ
VV9QTVVfVjNfSVJROgo+IC4uLy4uCj4gICAgICAgICAgICAgICAgIGlmICghaXJxY2hpcF9pbl9r
ZXJuZWwodmNwdS0+a3ZtKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsKCkFoLCBJIHNlZSB3aGF0IHlvdSBtZWFuLiBZZXMsIHdlIHByb2JhYmx5IHNob3VsZG4ndCBy
ZXBvcnQgdGhhdCB0aGUgUE1VCklSUSBhdHRyaWJ1dGUgaXMgc3VwcG9ydGVkIHdoZW4gd2UgZG9u
J3QgaGF2ZSBhbiBpbi1rZXJuZWwgaXJxY2hpcC4KClRoYW5rcywKCiAgICAgICAgIE0uCi0tIApK
YXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFy
bUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFp
bG1hbi9saXN0aW5mby9rdm1hcm0K
