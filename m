Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4671A181A20
	for <lists+kvmarm@lfdr.de>; Wed, 11 Mar 2020 14:49:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D77D54A7F1;
	Wed, 11 Mar 2020 09:49:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21uhC0sf7bM8; Wed, 11 Mar 2020 09:49:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D4C34A534;
	Wed, 11 Mar 2020 09:49:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B49024A4A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 09:49:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FhbkXebL74RK for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Mar 2020 09:49:34 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F5264A4A0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 09:49:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsvML7TjAQJWusNVkCpKgOQx6lENNDL9bm3AiV1RPfc=;
 b=ROUOkk5z7St3NZu8IwbyoTMtqrsHJaSZ+QviFlUr2c0g94/mSW/iWQwSJqHq/Cq7xy4BkU
 pmGs9A+V2v3Gv+Ozrd+VAxTM82wo8LOoUfIXOMYI6aC+gn0EM2Y5Z9xb3/HFvvktx356Qn
 HeF8GNiBhMQMHs7ztiv6wwdsPab3qLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-49vmNWx9MBC47vDTZl3Pig-1; Wed, 11 Mar 2020 09:49:31 -0400
X-MC-Unique: 49vmNWx9MBC47vDTZl3Pig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A9C01137841;
 Wed, 11 Mar 2020 13:49:29 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 397A692D2C;
 Wed, 11 Mar 2020 13:49:25 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v5 13/13] arm/arm64: ITS: pending table
 migration test
To: Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-14-eric.auger@redhat.com>
 <54139b63-3a1d-7276-4d0b-4d38f9901536@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <96f01985-6515-8501-2b14-c8f91dcdfa81@redhat.com>
Date: Wed, 11 Mar 2020 14:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <54139b63-3a1d-7276-4d0b-4d38f9901536@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: andre.przywara@arm.com, thuth@redhat.com
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

CgpPbiAzLzExLzIwIDE6MDcgUE0sIFplbmdodWkgWXUgd3JvdGU6Cj4gSGkgRXJpYywKPiAKPiBP
biAyMDIwLzMvMTAgMjI6NTQsIEVyaWMgQXVnZXIgd3JvdGU6Cj4+IEFkZCB0d28gbmV3IG1pZ3Jh
dGlvbiB0ZXN0cy4gT25lIHRlc3RpbmcgdGhlIG1pZ3JhdGlvbiBvZgo+PiBhIHRvcG9sb2d5IHdo
ZXJlIGNvbGxlY3Rpb24gd2VyZSB1bm1hcHBlZC4gVGhlIHNlY29uZCB0ZXN0Cj4+IGNoZWNrcyB0
aGUgbWlncmF0aW9uIG9mIHRoZSBwZW5kaW5nIHRhYmxlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBF
cmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Cj4+Cj4+IC0tLQo+Pgo+PiB2NCAtPiB2
NToKPj4gLSBtb3ZlIHN0dWIgZnJvbSBoZWFkZXIgdG8gYXJtL2dpYy5jCj4+Cj4+IHYzIC0+IHY0
Ogo+PiAtIGRvIG5vdCB0YWxrIGFib3V0IG9kZC9ldmVuIENQVXMsIHVzZSBwZTAgYW5kIHBlMQo+
PiAtIGNvbW1lbnQgdGhlIGRlbGF5Cj4+Cj4+IHYyIC0+IHYzOgo+PiAtIHRlc3RzIGJlbG9uZyB0
byBib3RoIGl0cyBhbmQgbWlncmF0aW9uIGdyb3Vwcwo+PiAtIHVzZSBMUEkoaSkKPj4gLSBnaWN2
M19scGlfc2V0X3BlbmRpbmdfdGFibGVfYml0IHJlbmFtZWQgaW50byBnaWN2M19scGlfc2V0X2Ns
cl9wZW5kaW5nCj4+IC0tLQo+PiDCoCBhcm0vZ2ljLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTQ2ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gwqAgYXJtL3Vu
aXR0ZXN0cy5jZmcgfMKgIDE2ICsrKysrCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMTYyIGluc2Vy
dGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2FybS9naWMuYyBiL2FybS9naWMuYwo+PiBpbmRl
eCBiOGZiYzEzLi5lNmZmYmMzIDEwMDY0NAo+PiAtLS0gYS9hcm0vZ2ljLmMKPj4gKysrIGIvYXJt
L2dpYy5jCj4+IEBAIC0xOTMsNiArMTkzLDcgQEAgc3RhdGljIHZvaWQgbHBpX2hhbmRsZXIoc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MKPj4gX191bnVzZWQpCj4+IMKgwqDCoMKgwqAgc21wX3JtYigpOyAv
KiBwYWlycyB3aXRoIHdtYiBpbiBscGlfc3RhdHNfZXhwZWN0ICovCj4+IMKgwqDCoMKgwqAgbHBp
X3N0YXRzLm9ic2VydmVkLmNwdV9pZCA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKPj4gwqDCoMKgwqDC
oCBscGlfc3RhdHMub2JzZXJ2ZWQubHBpX2lkID0gaXJxbnI7Cj4+ICvCoMKgwqAgYWNrZWRbbHBp
X3N0YXRzLm9ic2VydmVkLmNwdV9pZF0rKzsKPj4gwqDCoMKgwqDCoCBzbXBfd21iKCk7IC8qIHBh
aXJzIHdpdGggcm1iIGluIGNoZWNrX2xwaV9zdGF0cyAqLwo+PiDCoCB9Cj4+IMKgIEBAIC0yMzYs
NiArMjM3LDIyIEBAIHN0YXRpYyB2b2lkIHNlY29uZGFyeV9scGlfdGVzdCh2b2lkKQo+PiDCoMKg
wqDCoMKgIHdoaWxlICgxKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgd2ZpKCk7Cj4+IMKgIH0KPj4g
Kwo+PiArc3RhdGljIHZvaWQgY2hlY2tfbHBpX2hpdHMoaW50ICpleHBlY3RlZCwgY29uc3QgY2hh
ciAqbXNnKQo+PiArewo+PiArwqDCoMKgIGJvb2wgcGFzcyA9IHRydWU7Cj4+ICvCoMKgwqAgaW50
IGk7Cj4+ICsKPj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnJfY3B1czsgaSsrKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAoYWNrZWRbaV0gIT0gZXhwZWN0ZWRbaV0pIHsKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVwb3J0X2luZm8oImV4cGVjdGVkICVkIExQSXMgb24gUEUgIyVkLCAl
ZCBvYnNlcnZlZCIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBl
eHBlY3RlZFtpXSwgaSwgYWNrZWRbaV0pOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXNz
ID0gZmFsc2U7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiArwqDCoMKgwqDC
oMKgwqAgfQo+PiArwqDCoMKgIH0KPj4gK8KgwqDCoCByZXBvcnQocGFzcywgIiVzIiwgbXNnKTsK
Pj4gK30KPj4gwqAgI2VuZGlmCj4+IMKgIMKgIHN0YXRpYyB2b2lkIGdpY3YyX2lwaV9zZW5kX3Nl
bGYodm9pZCkKPj4gQEAgLTU5MSw2ICs2MDgsOCBAQCBzdGF0aWMgdm9pZCBnaWNfdGVzdF9tbWlv
KHZvaWQpCj4+IMKgIHN0YXRpYyB2b2lkIHRlc3RfaXRzX2ludHJvc3BlY3Rpb24odm9pZCkge30K
Pj4gwqAgc3RhdGljIHZvaWQgdGVzdF9pdHNfdHJpZ2dlcih2b2lkKSB7fQo+PiDCoCBzdGF0aWMg
dm9pZCB0ZXN0X2l0c19taWdyYXRpb24odm9pZCkge30KPj4gK3N0YXRpYyB2b2lkIHRlc3RfaXRz
X3BlbmRpbmdfbWlncmF0aW9uKHZvaWQpIHt9Cj4+ICtzdGF0aWMgdm9pZCB0ZXN0X21pZ3JhdGVf
dW5tYXBwZWRfY29sbGVjdGlvbih2b2lkKSB7fQo+PiDCoCDCoCAjZWxzZSAvKiBfX2FhcmNoNjRf
XyAqLwo+PiDCoCBAQCAtNjU5LDYgKzY3OCwxNyBAQCBzdGF0aWMgaW50IGl0c19wcmVyZXF1aXNp
dGVzKGludCBuYl9jcHVzKQo+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+IMKgICtz
dGF0aWMgdm9pZCBzZXRfbHBpKHN0cnVjdCBpdHNfZGV2aWNlICpkZXYsIHUzMiBldmVudGlkLCB1
MzIgcGh5c2lkLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaXRzX2NvbGxlY3Rp
b24gKmNvbCkKPj4gK3sKPj4gK8KgwqDCoCBhc3NlcnQoZGV2ICYmIGNvbCk7Cj4+ICsKPj4gK8Kg
wqDCoCBpdHNfc2VuZF9tYXB0aShkZXYsIHBoeXNpZCwgZXZlbnRpZCwgY29sKTsKPj4gKwo+PiAr
wqDCoMKgIGdpY3YzX2xwaV9zZXRfY29uZmlnKHBoeXNpZCwgTFBJX1BST1BfREVGQVVMVCk7Cj4+
ICvCoMKgwqAgaXRzX3NlbmRfaW52YWxsKGNvbCk7Cj4gCj4gQWdhaW4sIHRoZSBjb2wgaGFzbid0
IGJlZW4gbWFwcGVkIGN1cnJlbnRseS4KcmlnaHQuIE1vdmluZyBpdCBvdXRzaWRlIG9mIHRoZSBo
ZWxwZXIgdGhlbgo+IAo+PiArfQo+PiArCj4+IMKgIC8qCj4+IMKgwqAgKiBTZXR1cCB0aGUgY29u
ZmlndXJhdGlvbiBmb3IgdGhvc2UgbWFwcGluZ3M6Cj4+IMKgwqAgKiBkZXZfaWQ9MiBldmVudD0y
MCAtPiB2Y3B1IDMsIGludGlkPTgxOTUKPj4gQEAgLTc5OSw2ICs4MjksMTE0IEBAIHN0YXRpYyB2
b2lkIHRlc3RfaXRzX21pZ3JhdGlvbih2b2lkKQo+PiDCoMKgwqDCoMKgIGl0c19zZW5kX2ludChk
ZXY3LCAyNTUpOwo+PiDCoMKgwqDCoMKgIGNoZWNrX2xwaV9zdGF0cygiZGV2Ny9ldmVudGlkPTI1
NSB0cmlnZ2VycyBMUEkgODE5NiBvbiBQRSAjMgo+PiBhZnRlciBtaWdyYXRpb24iKTsKPj4gwqAg
fQo+PiArCj4+ICtzdGF0aWMgdm9pZCB0ZXN0X21pZ3JhdGVfdW5tYXBwZWRfY29sbGVjdGlvbih2
b2lkKQo+PiArewo+PiArwqDCoMKgIHN0cnVjdCBpdHNfY29sbGVjdGlvbiAqY29sOwo+PiArwqDC
oMKgIHN0cnVjdCBpdHNfZGV2aWNlICpkZXYyLCAqZGV2NzsKPj4gK8KgwqDCoCBpbnQgcGUwID0g
bnJfY3B1cyAtIDE7Cj4+ICvCoMKgwqAgdTggY29uZmlnOwo+PiArCj4+ICvCoMKgwqAgaWYgKGl0
c19zZXR1cDEoKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gKwo+PiArwqDCoMKgIGNv
bCA9IGl0c19jcmVhdGVfY29sbGVjdGlvbihwZTAsIHBlMCk7Cj4+ICvCoMKgwqAgZGV2MiA9IGl0
c19nZXRfZGV2aWNlKDIpOwo+PiArwqDCoMKgIGRldjcgPSBpdHNfZ2V0X2RldmljZSg3KTsKPj4g
Kwo+PiArwqDCoMKgIC8qIE1BUFRJIHdpdGggdGhlIGNvbGxlY3Rpb24gdW5tYXBwZWQgKi8KPj4g
K8KgwqDCoCBzZXRfbHBpKGRldjIsIDAsIDgxOTIsIGNvbCk7Cj4+ICsKPj4gK8KgwqDCoCBwdXRz
KCJOb3cgbWlncmF0ZSB0aGUgVk0sIHRoZW4gcHJlc3MgYSBrZXkgdG8gY29udGludWUuLi5cbiIp
Owo+PiArwqDCoMKgICh2b2lkKWdldGNoYXIoKTsKPj4gK8KgwqDCoCByZXBvcnRfaW5mbygiTWln
cmF0aW9uIGNvbXBsZXRlIik7Cj4+ICsKPj4gK8KgwqDCoCAvKiBvbiB0aGUgZGVzdGluYXRpb24s
IG1hcCB0aGUgY29sbGVjdGlvbiAqLwo+PiArwqDCoMKgIGl0c19zZW5kX21hcGMoY29sLCB0cnVl
KTsKPj4gKwo+PiArwqDCoMKgIGxwaV9zdGF0c19leHBlY3QoMiwgODE5Nik7Cj4+ICvCoMKgwqAg
aXRzX3NlbmRfaW50KGRldjcsIDI1NSk7Cj4+ICvCoMKgwqAgY2hlY2tfbHBpX3N0YXRzKCJkZXY3
L2V2ZW50aWQ9IDI1NSB0cmlnZ2VyZWQgTFBJIDgxOTYgb24gUEUgIzIiKTsKPj4gKwo+PiArwqDC
oMKgIGNvbmZpZyA9IGdpY3YzX2xwaV9nZXRfY29uZmlnKDgxOTIpOwo+PiArwqDCoMKgIHJlcG9y
dChjb25maWcgPT0gTFBJX1BST1BfREVGQVVMVCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICJD
b25maWcgb2YgTFBJIDgxOTIgd2FzIHByb3Blcmx5IG1pZ3JhdGVkIik7Cj4+ICsKPj4gK8KgwqDC
oCBscGlfc3RhdHNfZXhwZWN0KHBlMCwgODE5Mik7Cj4+ICvCoMKgwqAgaXRzX3NlbmRfaW50KGRl
djIsIDApOwo+PiArwqDCoMKgIGNoZWNrX2xwaV9zdGF0cygiZGV2Mi9ldmVudGlkID0gMCB0cmln
Z2VyZWQgTFBJIDgxOTIgb24gUEUwIik7Cj4+ICsKPj4gK8KgwqDCoCAvKiB1bm1hcCB0aGUgY29s
bGVjdGlvbiAqLwo+PiArwqDCoMKgIGl0c19zZW5kX21hcGMoY29sLCBmYWxzZSk7Cj4gCj4gQWdh
aW4sIGJlaGF2aW9yIGlzIHVucHJlZGljdGFibGUuCnllcCByZW1vdmluZyB0aGF0IHRlc3QuCj4g
Cj4+ICsKPj4gK8KgwqDCoCBscGlfc3RhdHNfZXhwZWN0KC0xLCAtMSk7Cj4+ICvCoMKgwqAgaXRz
X3NlbmRfaW50KGRldjIsIDApOwo+PiArwqDCoMKgIGNoZWNrX2xwaV9zdGF0cygibm8gTFBJIHRy
aWdnZXJlZCBhZnRlciBjb2xsZWN0aW9uIHVubWFwcGluZyIpOwo+PiArfQo+PiArCj4+ICtzdGF0
aWMgdm9pZCB0ZXN0X2l0c19wZW5kaW5nX21pZ3JhdGlvbih2b2lkKQo+PiArewo+PiArwqDCoMKg
IHN0cnVjdCBpdHNfZGV2aWNlICpkZXY7Cj4+ICvCoMKgwqAgc3RydWN0IGl0c19jb2xsZWN0aW9u
ICpjb2xsZWN0aW9uWzJdOwo+PiArwqDCoMKgIGludCAqZXhwZWN0ZWQgPSBtYWxsb2MobnJfY3B1
cyAqIHNpemVvZihpbnQpKTsKPj4gK8KgwqDCoCBpbnQgcGUwID0gbnJfY3B1cyAtIDEsIHBlMSA9
IG5yX2NwdXMgLSAyOwo+PiArwqDCoMKgIHU2NCBwZW5kYmFzZXI7Cj4+ICvCoMKgwqAgdm9pZCAq
cHRyOwo+PiArwqDCoMKgIGludCBpOwo+PiArCj4+ICvCoMKgwqAgaWYgKGl0c19wcmVyZXF1aXNp
dGVzKDQpKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+PiArCj4+ICvCoMKgwqAgZGV2ID0g
aXRzX2NyZWF0ZV9kZXZpY2UoMiAvKiBkZXYgaWQgKi8sIDggLyogbmJfaXRlcyAqLyk7Cj4+ICvC
oMKgwqAgaXRzX3NlbmRfbWFwZChkZXYsIHRydWUpOwo+PiArCj4+ICvCoMKgwqAgY29sbGVjdGlv
blswXSA9IGl0c19jcmVhdGVfY29sbGVjdGlvbihwZTAsIHBlMCk7Cj4+ICvCoMKgwqAgY29sbGVj
dGlvblsxXSA9IGl0c19jcmVhdGVfY29sbGVjdGlvbihwZTEsIHBlMSk7Cj4+ICvCoMKgwqAgaXRz
X3NlbmRfbWFwYyhjb2xsZWN0aW9uWzBdLCB0cnVlKTsKPj4gK8KgwqDCoCBpdHNfc2VuZF9tYXBj
KGNvbGxlY3Rpb25bMV0sIHRydWUpOwo+PiArCj4+ICvCoMKgwqAgLyogZGlzYWJsZSBscGkgYXQg
cmVkaXN0IGxldmVsICovCj4+ICvCoMKgwqAgZ2ljdjNfbHBpX3JkaXN0X2Rpc2FibGUocGUwKTsK
Pj4gK8KgwqDCoCBnaWN2M19scGlfcmRpc3RfZGlzYWJsZShwZTEpOwo+PiArCj4+ICvCoMKgwqAg
LyogbHBpcyBhcmUgaW50ZXJsZWF2ZWQgaW5iZXR3ZWVuIHRoZSAyIFBFcyAqLwo+PiArwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCAyNTY7IGkrKykgewo+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGl0
c19jb2xsZWN0aW9uICpjb2wgPSBpICUgMiA/IGNvbGxlY3Rpb25bMF0gOgo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29sbGVjdGlv
blsxXTsKPj4gK8KgwqDCoMKgwqDCoMKgIGludCB2Y3B1ID0gY29sLT50YXJnZXRfYWRkcmVzcyA+
PiAxNjsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaXRzX3NlbmRfbWFwdGkoZGV2LCBMUEkoaSks
IGksIGNvbCk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBnaWN2M19scGlfc2V0X2NvbmZpZyhMUEkoaSks
IExQSV9QUk9QX0RFRkFVTFQpOwo+PiArwqDCoMKgwqDCoMKgwqAgZ2ljdjNfbHBpX3NldF9jbHJf
cGVuZGluZyh2Y3B1LCBMUEkoaSksIHRydWUpOwo+PiArwqDCoMKgIH0KPj4gK8KgwqDCoCBpdHNf
c2VuZF9pbnZhbGwoY29sbGVjdGlvblswXSk7Cj4+ICvCoMKgwqAgaXRzX3NlbmRfaW52YWxsKGNv
bGxlY3Rpb25bMV0pOwo+PiArCj4+ICvCoMKgwqAgLyogU2V0IHRoZSBQVFogYml0IG9uIGVhY2gg
cGVuZGJhc2VyICovCj4gCj4gJ0NsZWFyJyB0aGUgUFRaLgp5ZXAKPiAKPiBPdGhlcndpc2UgbG9v
a3MgZ29vZCEKClRoYW5rIHlvdSBmb3IgeW91ciBjYXJlZnVsIHJldmlldyEKCkJlc3QgUmVnYXJk
cwoKRXJpYwo+IAo+PiArCj4+ICvCoMKgwqAgZXhwZWN0ZWRbcGUwXSA9IDEyODsKPj4gK8KgwqDC
oCBleHBlY3RlZFtwZTFdID0gMTI4Owo+PiArCj4+ICvCoMKgwqAgcHRyID0gZ2ljdjNfZGF0YS5y
ZWRpc3RfYmFzZVtwZTBdICsgR0lDUl9QRU5EQkFTRVI7Cj4+ICvCoMKgwqAgcGVuZGJhc2VyID0g
cmVhZHEocHRyKTsKPj4gK8KgwqDCoCB3cml0ZXEocGVuZGJhc2VyICYgfkdJQ1JfUEVOREJBU0VS
X1BUWiwgcHRyKTsKPj4gKwo+PiArwqDCoMKgIHB0ciA9IGdpY3YzX2RhdGEucmVkaXN0X2Jhc2Vb
cGUxXSArIEdJQ1JfUEVOREJBU0VSOwo+PiArwqDCoMKgIHBlbmRiYXNlciA9IHJlYWRxKHB0cik7
Cj4+ICvCoMKgwqAgd3JpdGVxKHBlbmRiYXNlciAmIH5HSUNSX1BFTkRCQVNFUl9QVFosIHB0cik7
Cj4+ICsKPj4gK8KgwqDCoCBnaWN2M19scGlfcmRpc3RfZW5hYmxlKHBlMCk7Cj4+ICvCoMKgwqAg
Z2ljdjNfbHBpX3JkaXN0X2VuYWJsZShwZTEpOwo+PiArCj4+ICvCoMKgwqAgcHV0cygiTm93IG1p
Z3JhdGUgdGhlIFZNLCB0aGVuIHByZXNzIGEga2V5IHRvIGNvbnRpbnVlLi4uXG4iKTsKPj4gK8Kg
wqDCoCAodm9pZClnZXRjaGFyKCk7Cj4+ICvCoMKgwqAgcmVwb3J0X2luZm8oIk1pZ3JhdGlvbiBj
b21wbGV0ZSIpOwo+PiArCj4+ICvCoMKgwqAgLyogbGV0J3Mgd2FpdCBmb3IgdGhlIDI1NiBMUElz
IHRvIGJlIGhhbmRsZWQgKi8KPj4gK8KgwqDCoCBtZGVsYXkoMTAwMCk7Cj4+ICsKPj4gK8KgwqDC
oCBjaGVja19scGlfaGl0cyhleHBlY3RlZCwgIjEyOCBMUElzIG9uIGJvdGggUEUwIGFuZCBQRTEg
YWZ0ZXIKPj4gbWlncmF0aW9uIik7Cj4+ICt9Cj4gCj4gVGhhbmtzLAo+IFplbmdodWkKPiAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWls
aW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNv
bHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
