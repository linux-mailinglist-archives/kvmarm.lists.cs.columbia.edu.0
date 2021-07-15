Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ECF683C9BCC
	for <lists+kvmarm@lfdr.de>; Thu, 15 Jul 2021 11:29:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AAB34B0C2;
	Thu, 15 Jul 2021 05:29:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4mVGwg+72I-r; Thu, 15 Jul 2021 05:29:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EF824B0B4;
	Thu, 15 Jul 2021 05:28:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B3344B092
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 05:28:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p7s+rXgan7Ci for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Jul 2021 05:28:56 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BF644B0A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Jul 2021 05:28:56 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A646D;
 Thu, 15 Jul 2021 02:28:55 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CB9D3F774;
 Thu, 15 Jul 2021 02:28:54 -0700 (PDT)
Subject: Re: Any way to disable KVM VHE extension?
To: Qu Wenruo <wqu@suse.com>, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <37f873cf-1b39-ea7f-a5e7-6feb0200dd4c@suse.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e17449e7-b91d-d288-ff1c-e9451f9d1973@arm.com>
Date: Thu, 15 Jul 2021 10:28:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <37f873cf-1b39-ea7f-a5e7-6feb0200dd4c@suse.com>
Content-Language: en-GB
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

T24gMjAyMS0wNy0xNSAwOTo1NSwgUXUgV2VucnVvIHdyb3RlOgo+IEhpLAo+IAo+IFJlY2VudGx5
IEknbSBwbGF5aW5nIGFyb3VuZCB0aGUgTnZpZGlhIFhhdmllciBBR1ggYm9hcmQsIHdoaWNoIGhh
cyBWSEUgCj4gZXh0ZW5zaW9uIHN1cHBvcnQuCj4gCj4gSW4gdGhlb3J5LCBjb25zaWRlcmluZyB0
aGUgQ1BVIGFuZCBtZW1vcnksIGl0IHNob3VsZCBiZSBwcmV0dHkgcG93ZXJmdWwgCj4gY29tcGFy
ZWQgdG8gYm9hcmRzIGxpa2UgUlBJIENNNC4KPiAKPiBCdXQgdG8gbXkgc3VycHJpc2UsIEtWTSBy
dW5zIHByZXR0eSBwb29yIG9uIFhhdmllci4KPiAKPiBKdXN0IGJvb3RpbmcgdGhlIGVkazIgZmly
bXdhcmUgY291bGQgdGFrZSBvdmVyIDEwcywgYW5kIDIwcyB0byBmdWxseSAKPiBib290IHRoZSBr
ZXJuZWwuCj4gRXZlbiBteSBWTSBvbiBSUEkgQ000IGhhcyB3YXkgZmFzdGVyIGJvb3QgdGltZSwg
ZXZlbiBqdXN0IHJ1bm5pbmcgb24gCj4gUENJRTIuMCB4MSBsYW5lIE5WTUUsIGFuZCBqdXN0IDQg
Mi4xR2h6IEE3MiBjb3JlLgo+IAo+IFRoaXMgaXMgZGVmaW5pdGVseSBvdXQgb2YgbXkgZXhwZWN0
YXRpb24sIEkgZG91YmxlIGNoZWNrZWQgdG8gYmUgc3VyZSAKPiB0aGF0IGl0J3MgcnVubmluZyBp
biBLVk0gbW9kZS4KPiAKPiBCdXQgZnVydGhlciBkaWdnaW5nIHNob3dzIHRoYXQsIHNpbmNlIFhh
dmllciBBR1ggQ1BVIHN1cHBvcnRzIFZIRSwga3ZtIAo+IGlzIHJ1bm5pbmcgaW4gVkhFIG1vZGUg
b3RoZXIgdGhhbiBIWVAgbW9kZSBvbiBDTTQuCj4gCj4gSXMgdGhlcmUgYW55d2F5IHRvIG1hbnVh
bGx5IGRpc2FibGUgVkhFIG1vZGUgdG8gdGVzdCB0aGUgbW9yZSBjb21tb24gSFlQIAo+IG1vZGUg
b24gWGF2aWVyPwoKQWNjb3JkaW5nIHRvIGtlcm5lbC1wYXJhbWV0ZXJzLnR4dCwgImt2bS1hcm0u
bW9kZT1udmhlIiAob3IgaXRzIApsb3ctbGV2ZWwgZXF1aXZhbGVudCAiaWRfYWE2NG1tZnIxLnZo
PTAiKSBvbiB0aGUgY29tbWFuZCBsaW5lIHNob3VsZCBkbyAKdGhhdC4KCkhvd2V2ZXIgSSdkIGlt
YWdpbmUgdGhlIGRpc2NyZXBhbmN5IGlzIGxpa2VseSB0byBiZSBzb21ldGhpbmcgbW9yZSAKZnVu
ZGFtZW50YWwgdG8gdGhlIHdpbGRseSBkaWZmZXJlbnQgbWljcm9hcmNoaXRlY3R1cmVzLiBUaGVy
ZSdzIApjZXJ0YWlubHkgbm8gaGFybSBpbiBnaXZpbmcgbm9uLVZIRSBhIGdvIGZvciBjb21wYXJp
c29uLCBidXQgSSB3b3VsZG4ndCAKYmUgc3VycHJpc2VkIGlmIGl0IHR1cm5zIG91dCBldmVuIHNs
b3dlci4uLgoKUm9iaW4uCgo+IEJUVywgdGhpcyBpcyB0aGUgZG1lc2cgcmVsYXRlZCB0byBLVk0g
b24gWGF2aWVyLCBydW5uaW5nIHY1LjEzIHVwc3RyZWFtIAo+IGtlcm5lbCwgd2l0aCA2NEsgcGFn
ZSBzaXplOgo+IFvCoMKgwqAgMC44NTIzNTddIGt2bSBbMV06IElQQSBTaXplIExpbWl0OiA0MCBi
aXRzCj4gW8KgwqDCoCAwLjg1NzM3OF0ga3ZtIFsxXTogdmdpYyBpbnRlcnJ1cHQgSVJROQo+IFvC
oMKgwqAgMC44NjIxMjJdIGt2bTogcG11IGV2ZW50IGNyZWF0aW9uIGZhaWxlZCAtMgo+IFvCoMKg
wqAgMC44NjY3MzRdIGt2bSBbMV06IFZIRSBtb2RlIGluaXRpYWxpemVkIHN1Y2Nlc3NmdWxseQo+
IAo+IFdoaWxlIG9uIENNNCwgdGhlIGhvc3QgcnVucyB2NS4xMi4xMCB1cHN0cmVhbSBrZXJuZWwg
KHdpdGggZG93bnN0cmVhbSAKPiBkdGIpLCB3aXRoIDRLIHBhZ2Ugc2l6ZToKPiBbwqDCoMKgIDEu
Mjc2ODE4XSBrdm0gWzFdOiBJUEEgU2l6ZSBMaW1pdDogNDQgYml0cwo+IFvCoMKgwqAgMS4yNzg0
MjVdIGt2bSBbMV06IHZnaWMgaW50ZXJydXB0IElSUTkKPiBbwqDCoMKgIDEuMjc4NjIwXSBrdm0g
WzFdOiBIeXAgbW9kZSBpbml0aWFsaXplZCBzdWNjZXNzZnVsbHkKPiAKPiBDb3VsZCBpdCBiZSB0
aGUgUEFHRSBzaXplIGNhdXNpbmcgcHJvYmxlbT8KPiAKPiBUaGFua3MsCj4gUXUKPiAKPiAKPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczov
L2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
