Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A7C4111DC9B
	for <lists+kvmarm@lfdr.de>; Fri, 13 Dec 2019 04:28:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D1DD4AEB3;
	Thu, 12 Dec 2019 22:28:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CANAhbvT1TbA; Thu, 12 Dec 2019 22:28:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0EBD74AEAC;
	Thu, 12 Dec 2019 22:28:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BC774ACFA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Dec 2019 22:28:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xlLMCwqoYam2 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Dec 2019 22:28:47 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DA1D4A5A6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Dec 2019 22:28:47 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D823630E;
 Thu, 12 Dec 2019 19:28:46 -0800 (PST)
Received: from [192.168.0.10] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 931973F52E;
 Thu, 12 Dec 2019 19:28:43 -0800 (PST)
Subject: Re: [PATCH] arm64: Introduce ISAR6 CPU ID register
To: Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
 Mark Rutland <mark.rutland@arm.com>
References: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
 <20191212144633.GE46910@lakrids.cambridge.arm.com>
 <be707b09-6469-d12f-07d5-50d574dc7284@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <066cec52-f939-d55d-3a8a-e061767ec8d2@arm.com>
Date: Fri, 13 Dec 2019 08:59:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <be707b09-6469-d12f-07d5-50d574dc7284@arm.com>
Content-Language: en-US
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

CgpPbiAxMi8xMi8yMDE5IDA4OjUyIFBNLCBTdXp1a2kgS3VydXBwYXNzZXJ5IFBvdWxvc2Ugd3Jv
dGU6Cj4gT24gMTIvMTIvMjAxOSAxNDo0NiwgTWFyayBSdXRsYW5kIHdyb3RlOgo+PiBPbiBUaHUs
IERlYyAxMiwgMjAxOSBhdCAwMzo0NDoyM1BNICswNTMwLCBBbnNodW1hbiBLaGFuZHVhbCB3cm90
ZToKPj4+ICsjZGVmaW5lIElEX0lTQVI2X0pTQ1ZUX1NISUZUwqDCoMKgwqDCoMKgwqAgMAo+Pj4g
KyNkZWZpbmUgSURfSVNBUjZfRFBfU0hJRlTCoMKgwqDCoMKgwqDCoCA0Cj4+PiArI2RlZmluZSBJ
RF9JU0FSNl9GSE1fU0hJRlTCoMKgwqDCoMKgwqDCoCA4Cj4+PiArI2RlZmluZSBJRF9JU0FSNl9T
Ql9TSElGVMKgwqDCoMKgwqDCoMKgIDEyCj4+PiArI2RlZmluZSBJRF9JU0FSNl9TUEVDUkVTX1NI
SUZUwqDCoMKgwqDCoMKgwqAgMTYKPj4+ICsjZGVmaW5lIElEX0lTQVI2X0JGMTZfU0hJRlTCoMKg
wqDCoMKgwqDCoCAyMAo+Pj4gKyNkZWZpbmUgSURfSVNBUjZfSThNTV9TSElGVMKgwqDCoMKgwqDC
oMKgIDI0Cj4+Cj4+PiBAQCAtMzk5LDYgKzM5OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgX19m
dHJfcmVnX2VudHJ5IHsKPj4+IMKgwqDCoMKgwqAgQVJNNjRfRlRSX1JFRyhTWVNfSURfSVNBUjRf
RUwxLCBmdHJfZ2VuZXJpY18zMmJpdHMpLAo+Pj4gwqDCoMKgwqDCoCBBUk02NF9GVFJfUkVHKFNZ
U19JRF9JU0FSNV9FTDEsIGZ0cl9pZF9pc2FyNSksCj4+PiDCoMKgwqDCoMKgIEFSTTY0X0ZUUl9S
RUcoU1lTX0lEX01NRlI0X0VMMSwgZnRyX2lkX21tZnI0KSwKPj4KPj4+ICvCoMKgwqAgQVJNNjRf
RlRSX1JFRyhTWVNfSURfSVNBUjZfRUwxLCBmdHJfZ2VuZXJpY18zMmJpdHMpLAo+Pgo+PiBVc2lu
ZyBmdHJfZ2VuZXJpY18zMmJpdHMgZXhwb3NlcyB0aGUgbG93ZXN0LWNvbW1vbi1kZW5vbWluYXRv
ciBmb3IgYWxsCj4+IDQtYml0IGZpZWxkcyBpbiB0aGUgcmVnaXN0ZXIsIGFuZCBJIGRvbid0IHRo
aW5rIHRoYXQncyB0aGUgcmlnaHQgdGhpbmcKPj4gdG8gZG8gaGVyZSwgYmVjYXVzZToKPj4KPj4g
KiBXZSBoYXZlIG5vIGlkZWEgd2hhdCBJRF9JU0FSNiBiaXRzIFszMToyOF0gbWF5IG1lYW4gaW4g
ZnV0dXJlLgo+Pgo+PiAqIEFGQUlDVCwgdGhlIGluc3RydWN0aW9ucyBkZXNjcmliZWQgYnkgSURf
SVNBUjYuU1BFQ1JFUyAoZnJvbSB0aGUKPj4gwqDCoCBBUk12OC4wLVByZWRJbnYgZXh0ZW5zaW9u
KSBvcGVyYXRlIG9uIHRoZSBsb2NhbCBQRSBhbmQgYXJlIG5vdAo+PiDCoMKgIGJyb2FkY2FzdC4g
VG8gbWFrZSB0aG9zZSB3b3JrIGFzIGEgZ3Vlc3QgZXhwZWN0cywgdGhlIGhvc3Qgd2lsbCBuZWVk
Cj4+IMKgwqAgdG8gZG8gYWRkaXRpb25hbCB0aGluZ3MgKGUuZy4gdG8gcHJlc2VydmUgdGhhdCBp
bGx1c2lvbiB3aGVuIGEgdkNQVSBpcwo+PiDCoMKgIG1pZ3JhdGVkIGZyb20gb25lIHBDUFUgdG8g
YW5vdGhlciBhbmQgYmFjaykuCj4+Cj4+IEdpdmVuIHRoYXQsIHRoaW5rIHdlIHNob3VsZCBhZGQg
YW4gZXhwbGljaXQgZnRyX2lkX2lzYXI2IHdoaWNoIG9ubHkKPj4gZXhwb3NlcyB0aGUgZmllbGRz
IHRoYXQgd2UncmUgY2VydGFpbiBhcmUgc2FmZSB0byBleHBvc2UgdG8gYSBndWVzdAo+PiAoaS5l
LiB3aXRob3V0IFNQRUNSRVMpLgo+IAo+IEFncmVlLiBUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMg
b3V0LiBJIHJlY29tbWVuZGVkIHRoZSB1c2FnZSBvZgo+IGdlbmVyaWNfMzJiaXRzIHRhYmxlIHdp
dGhvdXQgYWN0dWFsbHkgbG9va2luZyBhdCB0aGUgZmVhdHVyZQo+IGRlZmluaXRpb25zLgo+IAo+
IEFuc2h1bWFuLAo+IAo+IFNvcnJ5IGFib3V0IHRoaXMuCgpOb3QgYSBwcm9ibGVtLCB3aWxsIGFk
ZCBhbiBleHBsaWNpdCBkZWZpbml0aW9uIGZvciBmdHJfaWRfaXNhcjYgd2l0aAphbGwgZmVhdHVy
ZXMgZXhjZXB0IFNQRUNSRVMgYXMgTWFyayBoYWQgcG9pbnRlZCBwdXQuCgo+IAo+IENoZWVycwo+
IFN1enVraQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
dm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9s
aXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
