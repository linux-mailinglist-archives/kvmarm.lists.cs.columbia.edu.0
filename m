Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 254A835834C
	for <lists+kvmarm@lfdr.de>; Thu,  8 Apr 2021 14:30:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 694CC4BA25;
	Thu,  8 Apr 2021 08:30:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yqf9TEC7fFv9; Thu,  8 Apr 2021 08:30:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DA80E4B99C;
	Thu,  8 Apr 2021 08:30:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 644BF4B989
 for <kvmarm@lists.cs.columbia.edu>; Thu,  8 Apr 2021 08:30:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fjs6-V8cpC-l for <kvmarm@lists.cs.columbia.edu>;
 Thu,  8 Apr 2021 08:30:40 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6AC344B974
 for <kvmarm@lists.cs.columbia.edu>; Thu,  8 Apr 2021 08:30:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617885040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s64/vAfSrBNQsCpuAMqXq7sIP9uWm8iiIR6se2Ly0S4=;
 b=G5F3DP3HsldUnfyy9lyy0LAyFdhf+eSaPOaP/apRf/Atw85RINEsKiVKrc6Al1Ifz+Z9g9
 nxpQ1K8PjweYk8TtxHlq8TbsTDqurPBTwrwjCHb4M3467uLap2cmfEISk0LY4C/UgGtuTH
 VBpL6Q3v61fMGkB9ICDfIFh1h6qIYGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-TqiEpuyWMnmjarYH6YNu5g-1; Thu, 08 Apr 2021 08:30:35 -0400
X-MC-Unique: TqiEpuyWMnmjarYH6YNu5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8D10107ACC7;
 Thu,  8 Apr 2021 12:30:31 +0000 (UTC)
Received: from [10.36.115.214] (ovpn-115-214.ams2.redhat.com [10.36.115.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BEDB196E3;
 Thu,  8 Apr 2021 12:30:16 +0000 (UTC)
Subject: Re: [PATCH v14 06/13] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
To: Kunkun Jiang <jiangkunkun@huawei.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
References: <20210223205634.604221-1-eric.auger@redhat.com>
 <20210223205634.604221-7-eric.auger@redhat.com>
 <901720e6-6ca5-eb9a-1f24-0ca479bcfecc@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0246aec2-162d-0584-3ca4-b9c304ef3c8a@redhat.com>
Date: Thu, 8 Apr 2021 14:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <901720e6-6ca5-eb9a-1f24-0ca479bcfecc@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: jean-philippe@linaro.org, jacob.jun.pan@linux.intel.com,
 wangxingang5@huawei.com, lushenming@huawei.com, nicoleotsuka@gmail.com,
 vivek.gautam@arm.com, yi.l.liu@intel.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org
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

SGkgS3Vua3VuLAoKT24gNC8xLzIxIDI6MzcgUE0sIEt1bmt1biBKaWFuZyB3cm90ZToKPiBIaSBF
cmljLAo+IAo+IE9uIDIwMjEvMi8yNCA0OjU2LCBFcmljIEF1Z2VyIHdyb3RlOgo+PiBXaXRoIG5l
c3RlZCBzdGFnZSBzdXBwb3J0LCBzb29uIHdlIHdpbGwgbmVlZCB0byBpbnZhbGlkYXRlCj4+IFMx
IGNvbnRleHRzIGFuZCByYW5nZXMgdGFnZ2VkIHdpdGggYW4gdW5tYW5hZ2VkIGFzaWQsIHRoaXMK
Pj4gbGF0dGVyIGJlaW5nIG1hbmFnZWQgYnkgdGhlIGd1ZXN0LiBTbyBsZXQncyBpbnRyb2R1Y2Ug
MiBoZWxwZXJzCj4+IHRoYXQgYWxsb3cgdG8gaW52YWxpZGF0ZSB3aXRoIGV4dGVybmFsbHkgbWFu
YWdlZCBBU0lEcwo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJl
ZGhhdC5jb20+Cj4+Cj4+IC0tLQo+Pgo+PiB2MTMgLT4gdjE0Cj4+IC0gQWN0dWFsbHkgc2VuZCB0
aGUgTkhfQVNJRCBjb21tYW5kIChyZXBvcnRlZCBieSBYaW5nYW5nIFdhbmcpCj4+IC0tLQo+PiDC
oCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHwgMzggKysrKysr
KysrKysrKysrKy0tLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYwo+PiBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2Fy
bS1zbW11LXYzLmMKPj4gaW5kZXggNTU3OWVjNGZjY2M4Li40YzE5YTExMTRkZTQgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4gKysr
IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+PiBAQCAtMTg0
Myw5ICsxODQzLDkgQEAgaW50IGFybV9zbW11X2F0Y19pbnZfZG9tYWluKHN0cnVjdAo+PiBhcm1f
c21tdV9kb21haW4gKnNtbXVfZG9tYWluLCBpbnQgc3NpZCwKPj4gwqAgfQo+PiDCoCDCoCAvKiBJ
T19QR1RBQkxFIEFQSSAqLwo+PiAtc3RhdGljIHZvaWQgYXJtX3NtbXVfdGxiX2ludl9jb250ZXh0
KHZvaWQgKmNvb2tpZSkKPj4gK3N0YXRpYyB2b2lkIF9fYXJtX3NtbXVfdGxiX2ludl9jb250ZXh0
KHN0cnVjdCBhcm1fc21tdV9kb21haW4KPj4gKnNtbXVfZG9tYWluLAo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGV4dF9hc2lkKQo+PiDCoCB7Cj4+
IC3CoMKgwqAgc3RydWN0IGFybV9zbW11X2RvbWFpbiAqc21tdV9kb21haW4gPSBjb29raWU7Cj4+
IMKgwqDCoMKgwqAgc3RydWN0IGFybV9zbW11X2RldmljZSAqc21tdSA9IHNtbXVfZG9tYWluLT5z
bW11Owo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhcm1fc21tdV9jbWRxX2VudCBjbWQ7Cj4+IMKgIEBA
IC0xODU2LDcgKzE4NTYsMTMgQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVfdGxiX2ludl9jb250ZXh0
KHZvaWQKPj4gKmNvb2tpZSkKPj4gwqDCoMKgwqDCoMKgICogaW5zZXJ0aW9uIHRvIGd1YXJhbnRl
ZSB0aG9zZSBhcmUgb2JzZXJ2ZWQgYmVmb3JlIHRoZSBUTEJJLiBEbyBiZQo+PiDCoMKgwqDCoMKg
wqAgKiBjYXJlZnVsLCAwMDcuCj4+IMKgwqDCoMKgwqDCoCAqLwo+PiAtwqDCoMKgIGlmIChzbW11
X2RvbWFpbi0+c3RhZ2UgPT0gQVJNX1NNTVVfRE9NQUlOX1MxKSB7Cj4+ICvCoMKgwqAgaWYgKGV4
dF9hc2lkID49IDApIHsgLyogZ3Vlc3Qgc3RhZ2UgMSBpbnZhbGlkYXRpb24gKi8KPj4gK8KgwqDC
oMKgwqDCoMKgIGNtZC5vcGNvZGXCoMKgwqAgPSBDTURRX09QX1RMQklfTkhfQVNJRDsKPj4gK8Kg
wqDCoMKgwqDCoMKgIGNtZC50bGJpLmFzaWTCoMKgwqAgPSBleHRfYXNpZDsKPj4gK8KgwqDCoMKg
wqDCoMKgIGNtZC50bGJpLnZtaWTCoMKgwqAgPSBzbW11X2RvbWFpbi0+czJfY2ZnLnZtaWQ7Cj4+
ICvCoMKgwqDCoMKgwqDCoCBhcm1fc21tdV9jbWRxX2lzc3VlX2NtZChzbW11LCAmY21kKTsKPj4g
K8KgwqDCoMKgwqDCoMKgIGFybV9zbW11X2NtZHFfaXNzdWVfc3luYyhzbW11KTsKPj4gK8KgwqDC
oCB9IGVsc2UgaWYgKHNtbXVfZG9tYWluLT5zdGFnZSA9PSBBUk1fU01NVV9ET01BSU5fUzEpIHsK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFybV9zbW11X3RsYl9pbnZfYXNpZChzbW11LCBzbW11X2Rv
bWFpbi0+czFfY2ZnLmNkLmFzaWQpOwo+PiDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBjbWQub3Bjb2RlwqDCoMKgID0gQ01EUV9PUF9UTEJJX1MxMl9WTUFMTDsKPj4g
QEAgLTE4NjcsNiArMTg3MywxMyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV90bGJfaW52X2NvbnRl
eHQodm9pZCAqY29va2llKQo+PiDCoMKgwqDCoMKgIGFybV9zbW11X2F0Y19pbnZfZG9tYWluKHNt
bXVfZG9tYWluLCAwLCAwLCAwKTsKPj4gwqAgfQo+PiDCoCArc3RhdGljIHZvaWQgYXJtX3NtbXVf
dGxiX2ludl9jb250ZXh0KHZvaWQgKmNvb2tpZSkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgYXJt
X3NtbXVfZG9tYWluICpzbW11X2RvbWFpbiA9IGNvb2tpZTsKPj4gKwo+PiArwqDCoMKgIF9fYXJt
X3NtbXVfdGxiX2ludl9jb250ZXh0KHNtbXVfZG9tYWluLCAtMSk7Cj4+ICt9Cj4+ICsKPj4gwqAg
c3RhdGljIHZvaWQgX19hcm1fc21tdV90bGJfaW52X3JhbmdlKHN0cnVjdCBhcm1fc21tdV9jbWRx
X2VudCAqY21kLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXplLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplX3QgZ3JhbnVsZSwKPj4gQEAgLTE5MjYsOSAr
MTkzOSwxMCBAQCBzdGF0aWMgdm9pZCBfX2FybV9zbW11X3RsYl9pbnZfcmFuZ2Uoc3RydWN0Cj4+
IGFybV9zbW11X2NtZHFfZW50ICpjbWQsCj4+IMKgwqDCoMKgwqAgYXJtX3NtbXVfY21kcV9iYXRj
aF9zdWJtaXQoc21tdSwgJmNtZHMpOwo+PiDCoCB9Cj4+IMKgIAo+IEhlcmUgaXMgdGhlIHBhcnQg
b2YgY29kZSBpbiBfX2FybV9zbW11X3RsYl9pbnZfcmFuZ2UoKToKPj4gwqDCoMKgwqDCoMKgwqAg
aWYgKHNtbXUtPmZlYXR1cmVzICYgQVJNX1NNTVVfRkVBVF9SQU5HRV9JTlYpIHsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEdldCB0aGUgbGVhZiBwYWdlIHNpemUgKi8KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRnID0gX19mZnMoc21tdV9kb21haW4tPmRv
bWFpbi5wZ3NpemVfYml0bWFwKTsKPj4KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIENvbnZlcnQgcGFnZSBzaXplIG9mIDEyLDE0LDE2IChsb2cyKSB0byAxLDIsMyAqLwo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY21kLT50bGJpLnRnID0gKHRnIC0gMTApIC8g
MjsKPj4KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIERldGVybWluZSB3aGF0
IGxldmVsIHRoZSBncmFudWxlIGlzIGF0ICovCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjbWQtPnRsYmkudHRsID0gNCAtICgoaWxvZzIoZ3JhbnVsZSkgLSAzKSAvICh0ZyAtIDMp
KTsKPj4KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9wYWdlcyA9IHNpemUg
Pj4gdGc7Cj4+IMKgwqDCoMKgwqDCoMKgIH0KPiBXaGVuIHBTTU1VIHN1cHBvcnRzIFJJTCwgd2Ug
Z2V0IHRoZSBsZWFmIHBhZ2Ugc2l6ZSBieSBfX2ZmcyhzbW11X2RvbWFpbi0+Cj4gZG9tYWluLnBn
c2l6ZV9iaXRtYXApLiBJbiBuZXN0ZWQgbW9kZSwgaXQgaXMgZGV0ZXJtaW5lZCBieSBob3N0Cj4g
UEFHRV9TSVpFLiBJZgo+IHRoZSBob3N0IGtlcm5lbCBhbmQgZ3Vlc3Qga2VybmVsIGhhcyBkaWZm
ZXJlbnQgdHJhbnNsYXRpb24gZ3JhbnVsZSAoZS5nLgo+IGhvc3QgMTZLLAo+IGd1ZXN0IDRLKSwg
X19hcm1fc21tdV90bGJfaW52X3JhbmdlKCkgd2lsbCBpc3N1ZSBhbiBpbmNvcnJlY3QgdGxiaSBj
b21tYW5kLgo+IAo+IERvIHlvdSBoYXZlIGFueSBpZGVhIGFib3V0IHRoaXMgaXNzdWU/CgpJIHRo
aW5rIHRoaXMgaXMgdGhlIHNhbWUgaXNzdWUgYXMgdGhlIG9uZSByZXBvcnRlZCBieSBDaGVueGlh
bmcKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTU5MzhlZDUtMjA5NS1lOTAzLWEyOTAt
MzMzYzI5OTAxNWEyQGhpc2lsaWNvbi5jb20vCgpJbiBjYXNlIFJJTCBpcyBub3Qgc3VwcG9ydGVk
IGJ5IHRoZSBob3N0LCBuZXh0IHZlcnNpb24gd2lsbCB1c2UgdGhlCnNtYWxsZXN0IHBTTU1VIHN1
cHBvcnRlZCBwYWdlIHNpemUsIGFzIGRvbmUgaW4gX19hcm1fc21tdV90bGJfaW52X3JhbmdlCgpU
aGFua3MKCkVyaWMKCj4gCj4gQmVzdCBSZWdhcmRzLAo+IEt1bmt1biBKaWFuZwo+PiAtc3RhdGlj
IHZvaWQgYXJtX3NtbXVfdGxiX2ludl9yYW5nZV9kb21haW4odW5zaWduZWQgbG9uZyBpb3ZhLCBz
aXplX3QKPj4gc2l6ZSwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzaXplX3QgZ3JhbnVsZSwgYm9vbCBsZWFmLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhcm1fc21tdV9kb21haW4gKnNtbXVfZG9tYWlu
KQo+PiArc3RhdGljIHZvaWQKPj4gK2FybV9zbW11X3RsYl9pbnZfcmFuZ2VfZG9tYWluKHVuc2ln
bmVkIGxvbmcgaW92YSwgc2l6ZV90IHNpemUsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNpemVfdCBncmFudWxlLCBib29sIGxlYWYsIGludCBleHRfYXNpZCwKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFybV9zbW11X2RvbWFpbiAq
c21tdV9kb21haW4pCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfY21kcV9l
bnQgY21kID0gewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLnRsYmkgPSB7Cj4+IEBAIC0xOTM2LDcg
KzE5NTAsMTIgQEAgc3RhdGljIHZvaWQKPj4gYXJtX3NtbXVfdGxiX2ludl9yYW5nZV9kb21haW4o
dW5zaWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0s
Cj4+IMKgwqDCoMKgwqAgfTsKPj4gwqAgLcKgwqDCoCBpZiAoc21tdV9kb21haW4tPnN0YWdlID09
IEFSTV9TTU1VX0RPTUFJTl9TMSkgewo+PiArwqDCoMKgIGlmIChleHRfYXNpZCA+PSAwKSB7wqAg
LyogZ3Vlc3Qgc3RhZ2UgMSBpbnZhbGlkYXRpb24gKi8KPj4gK8KgwqDCoMKgwqDCoMKgIGNtZC5v
cGNvZGXCoMKgwqAgPSBzbW11X2RvbWFpbi0+c21tdS0+ZmVhdHVyZXMgJgo+PiBBUk1fU01NVV9G
RUFUX0UySCA/Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENNRFFfT1Bf
VExCSV9FTDJfVkEgOiBDTURRX09QX1RMQklfTkhfVkE7Cj4+ICvCoMKgwqDCoMKgwqDCoCBjbWQu
dGxiaS5hc2lkwqDCoMKgID0gZXh0X2FzaWQ7Cj4+ICvCoMKgwqDCoMKgwqDCoCBjbWQudGxiaS52
bWlkwqDCoMKgID0gc21tdV9kb21haW4tPnMyX2NmZy52bWlkOwo+PiArwqDCoMKgIH0gZWxzZSBp
ZiAoc21tdV9kb21haW4tPnN0YWdlID09IEFSTV9TTU1VX0RPTUFJTl9TMSkgewo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgY21kLm9wY29kZcKgwqDCoCA9IHNtbXVfZG9tYWluLT5zbW11LT5mZWF0dXJl
cyAmCj4+IEFSTV9TTU1VX0ZFQVRfRTJIID8KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQ01EUV9PUF9UTEJJX0VMMl9WQSA6IENNRFFfT1BfVExCSV9OSF9WQTsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGNtZC50bGJpLmFzaWTCoMKgwqAgPSBzbW11X2RvbWFpbi0+czFf
Y2ZnLmNkLmFzaWQ7Cj4+IEBAIC0xOTQ0LDYgKzE5NjMsNyBAQCBzdGF0aWMgdm9pZAo+PiBhcm1f
c21tdV90bGJfaW52X3JhbmdlX2RvbWFpbih1bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXpl
LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY21kLm9wY29kZcKgwqDCoCA9IENNRFFfT1BfVExCSV9T
Ml9JUEE7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjbWQudGxiaS52bWlkwqDCoMKgID0gc21tdV9k
b21haW4tPnMyX2NmZy52bWlkOwo+PiDCoMKgwqDCoMKgIH0KPj4gKwo+PiDCoMKgwqDCoMKgIF9f
YXJtX3NtbXVfdGxiX2ludl9yYW5nZSgmY21kLCBpb3ZhLCBzaXplLCBncmFudWxlLCBzbW11X2Rv
bWFpbik7Cj4+IMKgIMKgwqDCoMKgwqAgLyoKPj4gQEAgLTE5ODIsNyArMjAwMiw3IEBAIHN0YXRp
YyB2b2lkIGFybV9zbW11X3RsYl9pbnZfcGFnZV9ub3N5bmMoc3RydWN0Cj4+IGlvbW11X2lvdGxi
X2dhdGhlciAqZ2F0aGVyLAo+PiDCoCBzdGF0aWMgdm9pZCBhcm1fc21tdV90bGJfaW52X3dhbGso
dW5zaWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90IGdyYW51bGUsIHZvaWQgKmNvb2tpZSkKPj4gwqAgewo+
PiAtwqDCoMKgIGFybV9zbW11X3RsYl9pbnZfcmFuZ2VfZG9tYWluKGlvdmEsIHNpemUsIGdyYW51
bGUsIGZhbHNlLCBjb29raWUpOwo+PiArwqDCoMKgIGFybV9zbW11X3RsYl9pbnZfcmFuZ2VfZG9t
YWluKGlvdmEsIHNpemUsIGdyYW51bGUsIGZhbHNlLCAtMSwKPj4gY29va2llKTsKPj4gwqAgfQo+
PiDCoCDCoCBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X2ZsdXNoX29wcyBhcm1fc21tdV9mbHVz
aF9vcHMgPSB7Cj4+IEBAIC0yNTIzLDcgKzI1NDMsNyBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV9p
b3RsYl9zeW5jKHN0cnVjdAo+PiBpb21tdV9kb21haW4gKmRvbWFpbiwKPj4gwqAgwqDCoMKgwqDC
oCBhcm1fc21tdV90bGJfaW52X3JhbmdlX2RvbWFpbihnYXRoZXItPnN0YXJ0LAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdhdGhlci0+ZW5kIC0gZ2F0
aGVyLT5zdGFydCArIDEsCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ2F0aGVyLT5wZ3NpemUsIHRydWUsIHNtbXVfZG9tYWluKTsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnYXRoZXItPnBnc2l6ZSwgdHJ1ZSwgLTEs
IHNtbXVfZG9tYWluKTsKPj4gwqAgfQo+PiDCoCDCoCBzdGF0aWMgcGh5c19hZGRyX3QKPiAKPiAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBt
YWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNz
LmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
