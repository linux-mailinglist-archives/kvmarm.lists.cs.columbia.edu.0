Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CC999249B55
	for <lists+kvmarm@lfdr.de>; Wed, 19 Aug 2020 13:04:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5246C4B8E5;
	Wed, 19 Aug 2020 07:04:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -0.591
X-Spam-Level: 
X-Spam-Status: No, score=-0.591 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_ALL=0.8, DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_MED=-2.3, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@amazon.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vmUx-6lQIN71; Wed, 19 Aug 2020 07:04:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F351F4BA57;
	Wed, 19 Aug 2020 07:04:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C3374BBFB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 19:24:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PxyImbiemtRc for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 Aug 2020 19:24:53 -0400 (EDT)
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1FF644B142
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 Aug 2020 19:24:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1597793094; x=1629329094;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=jR5nOW7+DwOgmrIAsVN7fuyxto6g5YRtj8aNKuXqjKc=;
 b=RWwvXWnX4Ws/BuYXkBwZuWH9pLCuh0Bkf8skXsKXW+lWEozUNmQ2sKN0
 SxxYYGKXzVderagGf5BF1FgZEmnNVj1n05DohpYqTIzmAMm/uov9eNd8j
 vdx8J/crdYf3w5kb37FnvQJgj5/rsF65MaBUPvlTL+i0/M5P6euTapYX2 8=;
X-IronPort-AV: E=Sophos;i="5.76,329,1592870400"; d="scan'208";a="67808757"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 18 Aug 2020 23:24:19 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS
 id 7E7F3A1826; Tue, 18 Aug 2020 23:24:15 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 23:24:14 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.228) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 23:24:11 +0000
Subject: Re: [PATCH v2 1/2] KVM: arm64: Add PMU event filtering infrastructure
To: Marc Zyngier <maz@kernel.org>, Auger Eric <eric.auger@redhat.com>
References: <20200309124837.19908-1-maz@kernel.org>
 <20200309124837.19908-2-maz@kernel.org>
 <70e712fc-6789-2384-c21c-d932b5e1a32f@redhat.com>
 <0027398587e8746a6a7459682330855f@kernel.org>
 <7c9e2e55-95c8-a212-e566-c48f5d3bc417@redhat.com>
 <470c88271ef8c4f92ecf990b7b86658e@kernel.org>
From: Alexander Graf <graf@amazon.com>
Message-ID: <0647b63c-ac27-8ec9-c9da-9a5e5163cb5d@amazon.com>
Date: Wed, 19 Aug 2020 01:24:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <470c88271ef8c4f92ecf990b7b86658e@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.43.162.228]
X-ClientProxiedBy: EX13D17UWC003.ant.amazon.com (10.43.162.206) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
X-Mailman-Approved-At: Wed, 19 Aug 2020 07:04:38 -0400
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

SGkgTWFyYywKCk9uIDEwLjAzLjIwIDE5OjAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gT24gMjAy
MC0wMy0xMCAxNzo0MCwgQXVnZXIgRXJpYyB3cm90ZToKPj4gSGkgTWFyYywKPj4KPj4gT24gMy8x
MC8yMCAxMjowMyBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOgo+Pj4gSGkgRXJpYywKPj4+Cj4+PiBP
biAyMDIwLTAzLTA5IDE4OjA1LCBBdWdlciBFcmljIHdyb3RlOgo+Pj4+IEhpIE1hcmMsCj4+Pj4K
Pj4+PiBPbiAzLzkvMjAgMTo0OCBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOgo+Pj4+PiBJdCBjYW4g
YmUgZGVzaXJhYmxlIHRvIGV4cG9zZSBhIFBNVSB0byBhIGd1ZXN0LCBhbmQgeWV0IG5vdCB3YW50
IHRoZQo+Pj4+PiBndWVzdCB0byBiZSBhYmxlIHRvIGNvdW50IHNvbWUgb2YgdGhlIGltcGxlbWVu
dGVkIGV2ZW50cyAoYmVjYXVzZSB0aGlzCj4+Pj4+IHdvdWxkIGdpdmUgaW5mb3JtYXRpb24gb24g
c2hhcmVkIHJlc291cmNlcywgZm9yIGV4YW1wbGUuCj4+Pj4+Cj4+Pj4+IEZvciB0aGlzLCBsZXQn
cyBleHRlbmQgdGhlIFBNVXYzIGRldmljZSBBUEksIGFuZCBvZmZlciBhIHdheSB0byAKPj4+Pj4g
c2V0dXAgYQo+Pj4+PiBiaXRtYXAgb2YgdGhlIGFsbG93ZWQgZXZlbnRzICh0aGUgZGVmYXVsdCBi
ZWluZyBubyBiaXRtYXAsIGFuZCB0aHVzIG5vCj4+Pj4+IGZpbHRlcmluZykuCj4+Pj4+Cj4+Pj4+
IFVzZXJzcGFjZSBjYW4gdGh1cyBhbGxvdy9kZW55IHJhbmdlcyBvZiBldmVudC4gVGhlIGRlZmF1
bHQgcG9saWN5Cj4+Pj4+IGRlcGVuZHMgb24gdGhlICJwb2xhcml0eSIgb2YgdGhlIGZpcnN0IGZp
bHRlciBzZXR1cCAoZGVmYXVsdCBkZW55IAo+Pj4+PiBpZiB0aGUKPj4+Pj4gZmlsdGVyIGFsbG93
cyBldmVudHMsIGFuZCBkZWZhdWx0IGFsbG93IGlmIHRoZSBmaWx0ZXIgZGVuaWVzIGV2ZW50cyku
Cj4+Pj4+IFRoaXMgYWxsb3dzIHRvIHNldHVwIGV4YWN0bHkgd2hhdCBpcyBhbGxvd2VkIGZvciBh
IGdpdmVuIGd1ZXN0Lgo+Pj4+Pgo+Pj4+PiBOb3RlIHRoYXQgYWx0aG91Z2ggdGhlIGlvY3RsIGlz
IHBlci12Y3B1LCB0aGUgbWFwIG9mIGFsbG93ZWQgZXZlbnRzIGlzCj4+Pj4+IGdsb2JhbCB0byB0
aGUgVk0gKGl0IGNhbiBiZSBzZXR1cCBmcm9tIGFueSB2Y3B1IHVudGlsIHRoZSB2Y3B1IFBNVSBp
cwo+Pj4+PiBpbml0aWFsaXplZCkuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hcmMgWnlu
Z2llciA8bWF6QGtlcm5lbC5vcmc+Cj4+Pj4+IC0tLQo+Pj4+PiDCoGFyY2gvYXJtNjQvaW5jbHVk
ZS9hc20va3ZtX2hvc3QuaCB8wqAgNiArKysKPj4+Pj4gwqBhcmNoL2FybTY0L2luY2x1ZGUvdWFw
aS9hc20va3ZtLmggfCAxNiArKysrKysKPj4+Pj4gwqB2aXJ0L2t2bS9hcm0vYXJtLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKwo+Pj4+PiDCoHZpcnQva3ZtL2FybS9wbXUu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDg0IAo+Pj4+PiArKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tCj4+Pj4+IMKgNCBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25z
KCspLCAxNiBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+Pj4+PiBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3Zt
X2hvc3QuaAo+Pj4+PiBpbmRleCA1N2ZkNDZhY2QwNTguLjhlNjNjNjE4Njg4ZCAxMDA2NDQKPj4+
Pj4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCj4+Pj4+ICsrKyBiL2Fy
Y2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAo+Pj4+PiBAQCAtOTEsNiArOTEsMTIgQEAg
c3RydWN0IGt2bV9hcmNoIHsKPj4+Pj4gwqDCoMKgwqDCoCAqIHN1cHBvcnRlZC4KPj4+Pj4gwqDC
oMKgwqDCoCAqLwo+Pj4+PiDCoMKgwqDCoCBib29sIHJldHVybl9uaXN2X2lvX2Fib3J0X3RvX3Vz
ZXI7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCAvKgo+Pj4+PiArwqDCoMKgwqAgKiBWTS13aWRlIFBN
VSBmaWx0ZXIsIGltcGxlbWVudGVkIGFzIGEgYml0bWFwIGFuZCBiaWcgZW5vdWdoCj4+Pj4+ICvC
oMKgwqDCoCAqIGZvciB1cCB0byA2NTUzNiBldmVudHMKPj4+Pj4gK8KgwqDCoMKgICovCj4+Pj4+
ICvCoMKgwqAgdW5zaWduZWQgbG9uZyAqcG11X2ZpbHRlcjsKPj4+Pj4gwqB9Owo+Pj4+Pgo+Pj4+
PiDCoCNkZWZpbmUgS1ZNX05SX01FTV9PQkpTwqDCoMKgwqAgNDAKPj4+Pj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvaW5jbHVkZS91YXBpL2FzbS9rdm0uaAo+Pj4+PiBiL2FyY2gvYXJtNjQvaW5j
bHVkZS91YXBpL2FzbS9rdm0uaAo+Pj4+PiBpbmRleCBiYTg1YmIyM2YwNjAuLjdiMTUxMWQ2Y2U0
NCAxMDA2NDQKPj4+Pj4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oCj4+
Pj4+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS91YXBpL2FzbS9rdm0uaAo+Pj4+PiBAQCAtMTU5
LDYgKzE1OSwyMSBAQCBzdHJ1Y3Qga3ZtX3N5bmNfcmVncyB7Cj4+Pj4+IMKgc3RydWN0IGt2bV9h
cmNoX21lbW9yeV9zbG90IHsKPj4+Pj4gwqB9Owo+Pj4+Pgo+Pj4+PiArLyoKPj4+Pj4gKyAqIFBN
VSBmaWx0ZXIgc3RydWN0dXJlLiBEZXNjcmliZSBhIHJhbmdlIG9mIGV2ZW50cyB3aXRoIGEgcGFy
dGljdWxhcgo+Pj4+PiArICogYWN0aW9uLiBUbyBiZSB1c2VkIHdpdGggS1ZNX0FSTV9WQ1BVX1BN
VV9WM19GSUxURVIuCj4+Pj4+ICsgKi8KPj4+Pj4gK3N0cnVjdCBrdm1fcG11X2V2ZW50X2ZpbHRl
ciB7Cj4+Pj4+ICvCoMKgwqAgX191MTbCoMKgwqAgYmFzZV9ldmVudDsKPj4+Pj4gK8KgwqDCoCBf
X3UxNsKgwqDCoCBuZXZlbnRzOwo+Pj4+PiArCj4+Pj4+ICsjZGVmaW5lIEtWTV9QTVVfRVZFTlRf
QUxMT1fCoMKgwqAgMAo+Pj4+PiArI2RlZmluZSBLVk1fUE1VX0VWRU5UX0RFTlnCoMKgwqAgMQo+
Pj4+PiArCj4+Pj4+ICvCoMKgwqAgX191OMKgwqDCoCBhY3Rpb247Cj4+Pj4+ICvCoMKgwqAgX191
OMKgwqDCoCBwYWRbM107Cj4+Pj4+ICt9Owo+Pj4+PiArCj4+Pj4+IMKgLyogZm9yIEtWTV9HRVQv
U0VUX1ZDUFVfRVZFTlRTICovCj4+Pj4+IMKgc3RydWN0IGt2bV92Y3B1X2V2ZW50cyB7Cj4+Pj4+
IMKgwqDCoMKgIHN0cnVjdCB7Cj4+Pj4+IEBAIC0zMjksNiArMzQ0LDcgQEAgc3RydWN0IGt2bV92
Y3B1X2V2ZW50cyB7Cj4+Pj4+IMKgI2RlZmluZSBLVk1fQVJNX1ZDUFVfUE1VX1YzX0NUUkzCoMKg
wqAgMAo+Pj4+PiDCoCNkZWZpbmXCoMKgIEtWTV9BUk1fVkNQVV9QTVVfVjNfSVJRwqDCoMKgIDAK
Pj4+Pj4gwqAjZGVmaW5lwqDCoCBLVk1fQVJNX1ZDUFVfUE1VX1YzX0lOSVTCoMKgwqAgMQo+Pj4+
PiArI2RlZmluZcKgwqAgS1ZNX0FSTV9WQ1BVX1BNVV9WM19GSUxURVLCoMKgwqAgMgo+Pj4+PiDC
oCNkZWZpbmUgS1ZNX0FSTV9WQ1BVX1RJTUVSX0NUUkzCoMKgwqDCoMKgwqDCoCAxCj4+Pj4+IMKg
I2RlZmluZcKgwqAgS1ZNX0FSTV9WQ1BVX1RJTUVSX0lSUV9WVElNRVLCoMKgwqDCoMKgwqDCoCAw
Cj4+Pj4+IMKgI2RlZmluZcKgwqAgS1ZNX0FSTV9WQ1BVX1RJTUVSX0lSUV9QVElNRVLCoMKgwqDC
oMKgwqDCoCAxCj4+Pj4+IGRpZmYgLS1naXQgYS92aXJ0L2t2bS9hcm0vYXJtLmMgYi92aXJ0L2t2
bS9hcm0vYXJtLmMKPj4+Pj4gaW5kZXggZWRhN2I2MjRlYWI4Li44ZDg0OWFjODhhNDQgMTAwNjQ0
Cj4+Pj4+IC0tLSBhL3ZpcnQva3ZtL2FybS9hcm0uYwo+Pj4+PiArKysgYi92aXJ0L2t2bS9hcm0v
YXJtLmMKPj4+Pj4gQEAgLTE2NCw2ICsxNjQsOCBAQCB2b2lkIGt2bV9hcmNoX2Rlc3Ryb3lfdm0o
c3RydWN0IGt2bSAqa3ZtKQo+Pj4+PiDCoMKgwqDCoCBmcmVlX3BlcmNwdShrdm0tPmFyY2gubGFz
dF92Y3B1X3Jhbik7Cj4+Pj4+IMKgwqDCoMKgIGt2bS0+YXJjaC5sYXN0X3ZjcHVfcmFuID0gTlVM
TDsKPj4+Pj4KPj4+Pj4gK8KgwqDCoCBiaXRtYXBfZnJlZShrdm0tPmFyY2gucG11X2ZpbHRlcik7
Cj4+Pj4+ICsKPj4+Pj4gwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IEtWTV9NQVhfVkNQVVM7ICsr
aSkgewo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChrdm0tPnZjcHVzW2ldKSB7Cj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdm1fdmNwdV9kZXN0cm95KGt2bS0+dmNwdXNbaV0pOwo+
Pj4+PiBkaWZmIC0tZ2l0IGEvdmlydC9rdm0vYXJtL3BtdS5jIGIvdmlydC9rdm0vYXJtL3BtdS5j
Cj4+Pj4+IGluZGV4IGYwZDAzMTJjMGE1NS4uOWYwZmQwMjI0ZDViIDEwMDY0NAo+Pj4+PiAtLS0g
YS92aXJ0L2t2bS9hcm0vcG11LmMKPj4+Pj4gKysrIGIvdmlydC9rdm0vYXJtL3BtdS5jCj4+Pj4+
IEBAIC01NzksMTAgKzU3OSwxOSBAQCBzdGF0aWMgdm9pZCBrdm1fcG11X2NyZWF0ZV9wZXJmX2V2
ZW50KHN0cnVjdAo+Pj4+PiBrdm1fdmNwdSAqdmNwdSwgdTY0IHNlbGVjdF9pZHgpCj4+Pj4+Cj4+
Pj4+IMKgwqDCoMKgIGt2bV9wbXVfc3RvcF9jb3VudGVyKHZjcHUsIHBtYyk7Cj4+Pj4+IMKgwqDC
oMKgIGV2ZW50c2VsID0gZGF0YSAmIEFSTVY4X1BNVV9FVlRZUEVfRVZFTlQ7Cj4+Pj4+ICvCoMKg
wqAgaWYgKHBtYy0+aWR4ID09IEFSTVY4X1BNVV9DWUNMRV9JRFgpCj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBldmVudHNlbCA9IEFSTVY4X1BNVVYzX1BFUkZDVFJfQ1BVX0NZQ0xFUzsKPj4+PiBuaXQ6
Cj4+Pj4gwqDCoMKgwqBpZiAocG1jLT5pZHggPT0gQVJNVjhfUE1VX0NZQ0xFX0lEWCkKPj4+PiDC
oMKgwqDCoMKgwqDCoCBldmVudHNlbCA9IEFSTVY4X1BNVVYzX1BFUkZDVFJfQ1BVX0NZQ0xFUzsK
Pj4+PiDCoMKgwqDCoGVsc2UKPj4+PiDCoMKgwqDCoMKgwqDCoCBldmVudHNlbCA9IGRhdGEgJiBB
Uk1WOF9QTVVfRVZUWVBFX0VWRU5UOwo+Pj4KPj4+IFlvdSBkb24ndCBsaWtlIGl0PyA7LSkKPj4g
PyBldmVudHNldCBzZXQgb25seSBvbmNlIGluc3RlYWQgb2YgMiB0aW1lcwo+IAo+IFRoZSBjb21w
aWxlciBkb2VzIHRoZSByaWdodCB0aGluZywgYnV0IHNvcmUsIEknbGwgY2hhbmdlIGl0LgoKSSBo
YXZlbid0IHNlZW4gYSB2MyBmb2xsb3ctdXAgYWZ0ZXIgdGhpcy4gRG8geW91IGhhcHBlbiB0byBo
YXZlIHRoYXQgCnNvbWV3aGVyZSBpbiBhIGxvY2FsIGJyYW5jaCBhbmQganVzdCBuZWVkIHRvIHNl
bmQgaXQgb3V0IG9yIHdvdWxkIHlvdSAKcHJlZmVyIGlmIEkgcGljayB1cCB2MiBhbmQgYWRkcmVz
cyB0aGUgY29tbWVudHM/CgoKVGhhbmtzLAoKQWxleAoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5j
b2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5m
by9rdm1hcm0K
