Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B51ABED5
	for <lists+kvmarm@lfdr.de>; Thu, 16 Apr 2020 13:10:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D52464B21A;
	Thu, 16 Apr 2020 07:10:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.8
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	UNPARSEABLE_RELAY=0.001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GMldLK9JpsEB; Thu, 16 Apr 2020 07:10:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B67FB4B26E;
	Thu, 16 Apr 2020 07:10:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B8E54B11B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Apr 2020 04:45:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nLnGfcoS-WNf for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Apr 2020 04:45:42 -0400 (EDT)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 26FA14B10E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Apr 2020 04:45:41 -0400 (EDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07484;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0TvgT7ce_1587026733; 
Received: from 30.27.118.45(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0TvgT7ce_1587026733) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Apr 2020 16:45:35 +0800
Subject: Re: [PATCH v2] KVM: Optimize kvm_arch_vcpu_ioctl_run function
To: Marc Zyngier <maz@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200416051057.26526-1-tianjia.zhang@linux.alibaba.com>
 <878sivx67g.fsf@vitty.brq.redhat.com>
 <1000159f971a6fa3b5bd9e5871ce4d82@kernel.org>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <8b92fb5b-5138-0695-fb90-6c36b8dfad00@linux.alibaba.com>
Date: Thu, 16 Apr 2020 16:45:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1000159f971a6fa3b5bd9e5871ce4d82@kernel.org>
X-Mailman-Approved-At: Thu, 16 Apr 2020 07:10:16 -0400
Cc: wanpengli@tencent.com, kvm@vger.kernel.org, david@redhat.com,
 benh@kernel.crashing.org, heiko.carstens@de.ibm.com,
 linux-kernel@vger.kernel.org, paulus@ozlabs.org, hpa@zytor.com,
 kvmarm@lists.cs.columbia.edu, linux-s390@vger.kernel.org,
 frankja@linux.ibm.com, mpe@ellerman.id.au, joro@8bytes.org, x86@kernel.org,
 borntraeger@de.ibm.com, mingo@redhat.com, thuth@redhat.com, gor@linux.ibm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, jmattson@google.com,
 tsbogend@alpha.franken.de, cohuck@redhat.com, linux-mips@vger.kernel.org,
 sean.j.christopherson@intel.com, pbonzini@redhat.com,
 linuxppc-dev@lists.ozlabs.org
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

CgpPbiAyMDIwLzQvMTYgMTY6MjgsIE1hcmMgWnluZ2llciB3cm90ZToKPiBPbiAyMDIwLTA0LTE2
IDA4OjAzLCBWaXRhbHkgS3V6bmV0c292IHdyb3RlOgo+PiBUaWFuamlhIFpoYW5nIDx0aWFuamlh
LnpoYW5nQGxpbnV4LmFsaWJhYmEuY29tPiB3cml0ZXM6Cj4+Cj4+PiBJbiBlYXJsaWVyIHZlcnNp
b25zIG9mIGt2bSwgJ2t2bV9ydW4nIGlzIGFuIGluZGVwZW5kZW50IHN0cnVjdHVyZQo+Pj4gYW5k
IGlzIG5vdCBpbmNsdWRlZCBpbiB0aGUgdmNwdSBzdHJ1Y3R1cmUuIEF0IHByZXNlbnQsICdrdm1f
cnVuJwo+Pj4gaXMgYWxyZWFkeSBpbmNsdWRlZCBpbiB0aGUgdmNwdSBzdHJ1Y3R1cmUsIHNvIHRo
ZSBwYXJhbWV0ZXIKPj4+ICdrdm1fcnVuJyBpcyByZWR1bmRhbnQuCj4+Pgo+Pj4gVGhpcyBwYXRj
aCBzaW1wbGlmeSB0aGUgZnVuY3Rpb24gZGVmaW5pdGlvbiwgcmVtb3ZlcyB0aGUgZXh0cmEKPj4+
ICdrdm1fcnVuJyBwYXJhbWV0ZXIsIGFuZCBleHRyYWN0IGl0IGZyb20gdGhlICdrdm1fdmNwdScg
c3RydWN0dXJlCj4+PiBpZiBuZWNlc3NhcnkuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogVGlhbmpp
YSBaaGFuZyA8dGlhbmppYS56aGFuZ0BsaW51eC5hbGliYWJhLmNvbT4KPj4+IC0tLQo+Pj4KPj4+
IHYyIGNoYW5nZToKPj4+IMKgIHJlbW92ZSAna3ZtX3J1bicgcGFyYW1ldGVyIGFuZCBleHRyYWN0
IGl0IGZyb20gJ2t2bV92Y3B1Jwo+Pj4KPj4+IMKgYXJjaC9taXBzL2t2bS9taXBzLmPCoMKgwqDC
oMKgwqAgfMKgIDMgKystCj4+PiDCoGFyY2gvcG93ZXJwYy9rdm0vcG93ZXJwYy5jIHzCoCAzICsr
LQo+Pj4gwqBhcmNoL3MzOTAva3ZtL2t2bS1zMzkwLmPCoMKgIHzCoCAzICsrLQo+Pj4gwqBhcmNo
L3g4Ni9rdm0veDg2LmPCoMKgwqDCoMKgwqDCoMKgIHwgMTEgKysrKysrLS0tLS0KPj4+IMKgaW5j
bHVkZS9saW51eC9rdm1faG9zdC5owqDCoCB8wqAgMiArLQo+Pj4gwqB2aXJ0L2t2bS9hcm0vYXJt
LmPCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKy0tLQo+Pj4gwqB2aXJ0L2t2bS9rdm1fbWFpbi5j
wqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0KPj4+IMKgNyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCAxMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL2t2
bS9taXBzLmMgYi9hcmNoL21pcHMva3ZtL21pcHMuYwo+Pj4gaW5kZXggOGYwNWRkMGEwZjRlLi5l
YzI0YWRmNDg1N2UgMTAwNjQ0Cj4+PiAtLS0gYS9hcmNoL21pcHMva3ZtL21pcHMuYwo+Pj4gKysr
IGIvYXJjaC9taXBzL2t2bS9taXBzLmMKPj4+IEBAIC00MzksOCArNDM5LDkgQEAgaW50IGt2bV9h
cmNoX3ZjcHVfaW9jdGxfc2V0X2d1ZXN0X2RlYnVnKHN0cnVjdCAKPj4+IGt2bV92Y3B1ICp2Y3B1
LAo+Pj4gwqDCoMKgwqAgcmV0dXJuIC1FTk9JT0NUTENNRDsKPj4+IMKgfQo+Pj4KPj4+IC1pbnQg
a3ZtX2FyY2hfdmNwdV9pb2N0bF9ydW4oc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3Zt
X3J1biAqcnVuKQo+Pj4gK2ludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1bihzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUpCj4+PiDCoHsKPj4+ICvCoMKgwqAgc3RydWN0IGt2bV9ydW4gKnJ1biA9IHZjcHUt
PnJ1bjsKPj4+IMKgwqDCoMKgIGludCByID0gLUVJTlRSOwo+Pj4KPj4+IMKgwqDCoMKgIHZjcHVf
bG9hZCh2Y3B1KTsKPj4+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMva3ZtL3Bvd2VycGMuYyBi
L2FyY2gvcG93ZXJwYy9rdm0vcG93ZXJwYy5jCj4+PiBpbmRleCBlMTUxNjZiMGExNmQuLjdlMjQ2
OTFlMTM4YSAxMDA2NDQKPj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9rdm0vcG93ZXJwYy5jCj4+PiAr
KysgYi9hcmNoL3Bvd2VycGMva3ZtL3Bvd2VycGMuYwo+Pj4gQEAgLTE3NjQsOCArMTc2NCw5IEBA
IGludCBrdm1fdmNwdV9pb2N0bF9zZXRfb25lX3JlZyhzdHJ1Y3Qga3ZtX3ZjcHUgCj4+PiAqdmNw
dSwgc3RydWN0IGt2bV9vbmVfcmVnICpyZWcpCj4+PiDCoMKgwqDCoCByZXR1cm4gcjsKPj4+IMKg
fQo+Pj4KPj4+IC1pbnQga3ZtX2FyY2hfdmNwdV9pb2N0bF9ydW4oc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCBzdHJ1Y3Qga3ZtX3J1biAqcnVuKQo+Pj4gK2ludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1
bihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCj4+PiDCoHsKPj4+ICvCoMKgwqAgc3RydWN0IGt2bV9y
dW4gKnJ1biA9IHZjcHUtPnJ1bjsKPj4+IMKgwqDCoMKgIGludCByOwo+Pj4KPj4+IMKgwqDCoMKg
IHZjcHVfbG9hZCh2Y3B1KTsKPj4+IGRpZmYgLS1naXQgYS9hcmNoL3MzOTAva3ZtL2t2bS1zMzkw
LmMgYi9hcmNoL3MzOTAva3ZtL2t2bS1zMzkwLmMKPj4+IGluZGV4IDE5YTgxMDI0ZmUxNi4uNDQz
YWYzZWFkNzM5IDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC9zMzkwL2t2bS9rdm0tczM5MC5jCj4+PiAr
KysgYi9hcmNoL3MzOTAva3ZtL2t2bS1zMzkwLmMKPj4+IEBAIC00MzMzLDggKzQzMzMsOSBAQCBz
dGF0aWMgdm9pZCBzdG9yZV9yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgCj4+PiBzdHJ1Y3Qg
a3ZtX3J1biAqa3ZtX3J1bikKPj4+IMKgwqDCoMKgwqDCoMKgwqAgc3RvcmVfcmVnc19mbXQyKHZj
cHUsIGt2bV9ydW4pOwo+Pj4gwqB9Cj4+Pgo+Pj4gLWludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1
bihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1fcnVuIAo+Pj4gKmt2bV9ydW4pCj4+
PiAraW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKPj4+
IMKgewo+Pj4gK8KgwqDCoCBzdHJ1Y3Qga3ZtX3J1biAqa3ZtX3J1biA9IHZjcHUtPnJ1bjsKPj4+
IMKgwqDCoMKgIGludCByYzsKPj4+Cj4+PiDCoMKgwqDCoCBpZiAoa3ZtX3J1bi0+aW1tZWRpYXRl
X2V4aXQpCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3Zt
L3g4Ni5jCj4+PiBpbmRleCAzYmYyZWNhZmQwMjcuLmEwMzM4ZTg2YzkwZiAxMDA2NDQKPj4+IC0t
LSBhL2FyY2gveDg2L2t2bS94ODYuYwo+Pj4gKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5jCj4+PiBA
QCAtODcwNyw4ICs4NzA3LDkgQEAgc3RhdGljIHZvaWQga3ZtX3B1dF9ndWVzdF9mcHUoc3RydWN0
IGt2bV92Y3B1IAo+Pj4gKnZjcHUpCj4+PiDCoMKgwqDCoCB0cmFjZV9rdm1fZnB1KDApOwo+Pj4g
wqB9Cj4+Pgo+Pj4gLWludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1bihzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsIHN0cnVjdCBrdm1fcnVuIAo+Pj4gKmt2bV9ydW4pCj4+PiAraW50IGt2bV9hcmNoX3Zj
cHVfaW9jdGxfcnVuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKPj4+IMKgewo+Pj4gK8KgwqDCoCBz
dHJ1Y3Qga3ZtX3J1biAqa3ZtX3J1biA9IHZjcHUtPnJ1bjsKPj4+IMKgwqDCoMKgIGludCByOwo+
Pj4KPj4+IMKgwqDCoMKgIHZjcHVfbG9hZCh2Y3B1KTsKPj4+IEBAIC04NzI2LDE4ICs4NzI3LDE4
IEBAIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1bihzdHJ1Y3Qga3ZtX3ZjcHUgCj4+PiAqdmNw
dSwgc3RydWN0IGt2bV9ydW4gKmt2bV9ydW4pCj4+PiDCoMKgwqDCoMKgwqDCoMKgIHIgPSAtRUFH
QUlOOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoc2lnbmFsX3BlbmRpbmcoY3VycmVudCkpIHsK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByID0gLUVJTlRSOwo+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdmNwdS0+cnVuLT5leGl0X3JlYXNvbiA9IEtWTV9FWElUX0lOVFI7Cj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdm1fcnVuLT5leGl0X3JlYXNvbiA9IEtWTV9FWElUX0lO
VFI7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKyt2Y3B1LT5zdGF0LnNpZ25hbF9leGl0
czsKPj4+IMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsK
Pj4+IMKgwqDCoMKgIH0KPj4+Cj4+PiAtwqDCoMKgIGlmICh2Y3B1LT5ydW4tPmt2bV92YWxpZF9y
ZWdzICYgfktWTV9TWU5DX1g4Nl9WQUxJRF9GSUVMRFMpIHsKPj4+ICvCoMKgwqAgaWYgKGt2bV9y
dW4tPmt2bV92YWxpZF9yZWdzICYgfktWTV9TWU5DX1g4Nl9WQUxJRF9GSUVMRFMpIHsKPj4+IMKg
wqDCoMKgwqDCoMKgwqAgciA9IC1FSU5WQUw7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0
Owo+Pj4gwqDCoMKgwqAgfQo+Pj4KPj4+IC3CoMKgwqAgaWYgKHZjcHUtPnJ1bi0+a3ZtX2RpcnR5
X3JlZ3MpIHsKPj4+ICvCoMKgwqAgaWYgKGt2bV9ydW4tPmt2bV9kaXJ0eV9yZWdzKSB7Cj4+PiDC
oMKgwqDCoMKgwqDCoMKgIHIgPSBzeW5jX3JlZ3ModmNwdSk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKg
IGlmIChyICE9IDApCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+PiBA
QCAtODc2Nyw3ICs4NzY4LDcgQEAgaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKHN0cnVjdCBr
dm1fdmNwdSAKPj4+ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3J1biAqa3ZtX3J1bikKPj4+Cj4+PiDCoG91
dDoKPj4+IMKgwqDCoMKgIGt2bV9wdXRfZ3Vlc3RfZnB1KHZjcHUpOwo+Pj4gLcKgwqDCoCBpZiAo
dmNwdS0+cnVuLT5rdm1fdmFsaWRfcmVncykKPj4+ICvCoMKgwqAgaWYgKGt2bV9ydW4tPmt2bV92
YWxpZF9yZWdzKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBzdG9yZV9yZWdzKHZjcHUpOwo+Pj4gwqDC
oMKgwqAgcG9zdF9rdm1fcnVuX3NhdmUodmNwdSk7Cj4+PiDCoMKgwqDCoCBrdm1fc2lnc2V0X2Rl
YWN0aXZhdGUodmNwdSk7Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rdm1faG9zdC5o
IGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oCj4+PiBpbmRleCA2ZDU4YmViNjU0NTQuLjFlMTdl
ZjcxOTU5NSAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaAo+Pj4gKysr
IGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oCj4+PiBAQCAtODY2LDcgKzg2Niw3IEBAIGludCBr
dm1fYXJjaF92Y3B1X2lvY3RsX3NldF9tcHN0YXRlKHN0cnVjdCAKPj4+IGt2bV92Y3B1ICp2Y3B1
LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qga3Zt
X21wX3N0YXRlICptcF9zdGF0ZSk7Cj4+PiDCoGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3NldF9n
dWVzdF9kZWJ1ZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBrdm1fZ3Vlc3RfZGVidWcgKmRiZyk7Cj4+PiAt
aW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0
IGt2bV9ydW4gCj4+PiAqa3ZtX3J1bik7Cj4+PiAraW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVu
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7Cj4+Pgo+Pj4gwqBpbnQga3ZtX2FyY2hfaW5pdCh2b2lk
ICpvcGFxdWUpOwo+Pj4gwqB2b2lkIGt2bV9hcmNoX2V4aXQodm9pZCk7Cj4+PiBkaWZmIC0tZ2l0
IGEvdmlydC9rdm0vYXJtL2FybS5jIGIvdmlydC9rdm0vYXJtL2FybS5jCj4+PiBpbmRleCA0OGQw
ZWM0NGFkNzcuLmY1MzkwYWMyMTY1YiAxMDA2NDQKPj4+IC0tLSBhL3ZpcnQva3ZtL2FybS9hcm0u
Ywo+Pj4gKysrIGIvdmlydC9rdm0vYXJtL2FybS5jCj4+PiBAQCAtNjM5LDcgKzYzOSw2IEBAIHN0
YXRpYyB2b2lkIGNoZWNrX3ZjcHVfcmVxdWVzdHMoc3RydWN0IGt2bV92Y3B1IAo+Pj4gKnZjcHUp
Cj4+PiDCoC8qKgo+Pj4gwqAgKiBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1biAtIHRoZSBtYWluIFZD
UFUgcnVuIGZ1bmN0aW9uIHRvIGV4ZWN1dGUgCj4+PiBndWVzdCBjb2RlCj4+PiDCoCAqIEB2Y3B1
OsKgwqDCoCBUaGUgVkNQVSBwb2ludGVyCj4+PiAtICogQHJ1bjrCoMKgwqAgVGhlIGt2bV9ydW4g
c3RydWN0dXJlIHBvaW50ZXIgdXNlZCBmb3IgdXNlcnNwYWNlIHN0YXRlIAo+Pj4gZXhjaGFuZ2UK
Pj4+IMKgICoKPj4+IMKgICogVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgdGhyb3VnaCB0aGUgVkNQ
VV9SVU4gaW9jdGwgY2FsbGVkIGZyb20gCj4+PiB1c2VyIHNwYWNlLiBJdAo+Pj4gwqAgKiB3aWxs
IGV4ZWN1dGUgVk0gY29kZSBpbiBhIGxvb3AgdW50aWwgdGhlIHRpbWUgc2xpY2UgZm9yIHRoZSAK
Pj4+IHByb2Nlc3MgaXMgdXNlZAo+Pj4gQEAgLTY0Nyw4ICs2NDYsOSBAQCBzdGF0aWMgdm9pZCBj
aGVja192Y3B1X3JlcXVlc3RzKHN0cnVjdCBrdm1fdmNwdSAKPj4+ICp2Y3B1KQo+Pj4gwqAgKiBy
ZXR1cm4gd2l0aCByZXR1cm4gdmFsdWUgMCBhbmQgd2l0aCB0aGUga3ZtX3J1biBzdHJ1Y3R1cmUg
ZmlsbGVkIAo+Pj4gaW4gd2l0aCB0aGUKPj4+IMKgICogcmVxdWlyZWQgZGF0YSBmb3IgdGhlIHJl
cXVlc3RlZCBlbXVsYXRpb24uCj4+PiDCoCAqLwo+Pj4gLWludCBrdm1fYXJjaF92Y3B1X2lvY3Rs
X3J1bihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1fcnVuICpydW4pCj4+PiAraW50
IGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKPj4+IMKgewo+
Pj4gK8KgwqDCoCBzdHJ1Y3Qga3ZtX3J1biAqcnVuID0gdmNwdS0+cnVuOwo+Pj4gwqDCoMKgwqAg
aW50IHJldDsKPj4+Cj4+PiDCoMKgwqDCoCBpZiAodW5saWtlbHkoIWt2bV92Y3B1X2luaXRpYWxp
emVkKHZjcHUpKSkKPj4+IEBAIC02NTksNyArNjU5LDcgQEAgaW50IGt2bV9hcmNoX3ZjcHVfaW9j
dGxfcnVuKHN0cnVjdCBrdm1fdmNwdSAKPj4+ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3J1biAqcnVuKQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4KPj4+IMKgwqDCoMKgIGlmIChydW4t
PmV4aXRfcmVhc29uID09IEtWTV9FWElUX01NSU8pIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCByZXQg
PSBrdm1faGFuZGxlX21taW9fcmV0dXJuKHZjcHUsIHZjcHUtPnJ1bik7Cj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0ID0ga3ZtX2hhbmRsZV9tbWlvX3JldHVybih2Y3B1LCBydW4pOwo+Pgo+PiBJIGRv
bid0IGtub3cgbXVjaCBhYm91dCBBUk0gYnV0IHRoaXMgYWxzbyBzZWVtcyByZWR1bmRhbnQsCj4+
IGt2bV9oYW5kbGVfbW1pb19yZXR1cm4oKSBpcyBhbHNvIGFibGUgdG8gZXh0cnVjdCAnc3RydWN0
IGt2bV9ydW4nIGZyb20nCj4+ICdzdHJ1Y3Qga3ZtX3ZjcHUnLiBUaGlzIGxpa2VseSBkZXNlcnZl
cyBpdCdzIG93biBwYXRjaCB0aG91Z2guCj4gCj4gU29tZXRoaW5nIGxpa2UgdGhpcyAodW50ZXN0
ZWQpOgo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0Lmgg
Cj4gYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKPiBpbmRleCAzMmM4YTY3NWU1
YTQuLjgyOTc4OTk1YmRkNiAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2
bV9ob3N0LmgKPiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKPiBAQCAt
NDkwLDcgKzQ5MCw3IEBAIHZvaWQgaGFuZGxlX2V4aXRfZWFybHkoc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCBzdHJ1Y3QgCj4ga3ZtX3J1biAqcnVuLAo+ICDCoHZvaWQga3ZtX21taW9fd3JpdGVfYnVm
KHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbiwgdW5zaWduZWQgbG9uZyBkYXRhKTsKPiAgwqB1
bnNpZ25lZCBsb25nIGt2bV9tbWlvX3JlYWRfYnVmKGNvbnN0IHZvaWQgKmJ1ZiwgdW5zaWduZWQg
aW50IGxlbik7Cj4gCj4gLWludCBrdm1faGFuZGxlX21taW9fcmV0dXJuKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgc3RydWN0IGt2bV9ydW4gKnJ1bik7Cj4gK2ludCBrdm1faGFuZGxlX21taW9fcmV0
dXJuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7Cj4gIMKgaW50IGlvX21lbV9hYm9ydChzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1fcnVuICpydW4sCj4gIMKgwqDCoMKgwqDCoMKgwqDC
oCBwaHlzX2FkZHJfdCBmYXVsdF9pcGEpOwo+IAo+IGRpZmYgLS1naXQgYS92aXJ0L2t2bS9hcm0v
bW1pby5jIGIvdmlydC9rdm0vYXJtL21taW8uYwo+IGluZGV4IDRlMDM2Njc1OTcyNi4uM2IyYzgy
MmI0ODU5IDEwMDY0NAo+IC0tLSBhL3ZpcnQva3ZtL2FybS9tbWlvLmMKPiArKysgYi92aXJ0L2t2
bS9hcm0vbW1pby5jCj4gQEAgLTc3LDkgKzc3LDggQEAgdW5zaWduZWQgbG9uZyBrdm1fbW1pb19y
ZWFkX2J1Zihjb25zdCB2b2lkICpidWYsIAo+IHVuc2lnbmVkIGludCBsZW4pCj4gIMKgICrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvciBpbi1rZXJuZWwgSU8gZW11bGF0aW9uCj4g
IMKgICoKPiAgwqAgKiBAdmNwdTogVGhlIFZDUFUgcG9pbnRlcgo+IC0gKiBAcnVuOsKgIFRoZSBW
Q1BVIHJ1biBzdHJ1Y3QgY29udGFpbmluZyB0aGUgbW1pbyBkYXRhCj4gIMKgICovCj4gLWludCBr
dm1faGFuZGxlX21taW9fcmV0dXJuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGt2bV9y
dW4gKnJ1bikKPiAraW50IGt2bV9oYW5kbGVfbW1pb19yZXR1cm4oc3RydWN0IGt2bV92Y3B1ICp2
Y3B1KQo+ICDCoHsKPiAgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBkYXRhOwo+ICDCoMKgwqDCoCB1
bnNpZ25lZCBpbnQgbGVuOwo+IEBAIC05Myw3ICs5Miw3IEBAIGludCBrdm1faGFuZGxlX21taW9f
cmV0dXJuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgCj4gc3RydWN0IGt2bV9ydW4gKnJ1bikKPiAK
PiAgwqDCoMKgwqAgaWYgKCFrdm1fdmNwdV9kYWJ0X2lzd3JpdGUodmNwdSkpIHsKPiAgwqDCoMKg
wqDCoMKgwqDCoCBsZW4gPSBrdm1fdmNwdV9kYWJ0X2dldF9hcyh2Y3B1KTsKPiAtwqDCoMKgwqDC
oMKgwqAgZGF0YSA9IGt2bV9tbWlvX3JlYWRfYnVmKHJ1bi0+bW1pby5kYXRhLCBsZW4pOwo+ICvC
oMKgwqDCoMKgwqDCoCBkYXRhID0ga3ZtX21taW9fcmVhZF9idWYodmNwdS0+cnVuLT5tbWlvLmRh
dGEsIGxlbik7Cj4gCj4gIMKgwqDCoMKgwqDCoMKgwqAgaWYgKGt2bV92Y3B1X2RhYnRfaXNzZXh0
KHZjcHUpICYmCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZW4gPCBzaXplb2YodW5zaWdu
ZWQgbG9uZykpIHsKPiBAQCAtMTA0LDcgKzEwMyw4IEBAIGludCBrdm1faGFuZGxlX21taW9fcmV0
dXJuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgCj4gc3RydWN0IGt2bV9ydW4gKnJ1bikKPiAgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoIWt2bV92Y3B1X2RhYnRfaXNzZih2Y3B1KSkKPiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRhdGEgPSBkYXRhICYgMHhmZmZmZmZmZjsKPiAKPiAtwqDCoMKgwqDC
oMKgwqAgdHJhY2Vfa3ZtX21taW8oS1ZNX1RSQUNFX01NSU9fUkVBRCwgbGVuLCBydW4tPm1taW8u
cGh5c19hZGRyLAo+ICvCoMKgwqDCoMKgwqDCoCB0cmFjZV9rdm1fbW1pbyhLVk1fVFJBQ0VfTU1J
T19SRUFELCBsZW4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2Y3B1
LT5ydW4tPm1taW8ucGh5c19hZGRyLAo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAmZGF0YSk7Cj4gIMKgwqDCoMKgwqDCoMKgwqAgZGF0YSA9IHZjcHVfZGF0YV9ob3N0
X3RvX2d1ZXN0KHZjcHUsIGRhdGEsIGxlbik7Cj4gIMKgwqDCoMKgwqDCoMKgwqAgdmNwdV9zZXRf
cmVnKHZjcHUsIGt2bV92Y3B1X2RhYnRfZ2V0X3JkKHZjcHUpLCBkYXRhKTsKPiAKPiBPdmVyYWxs
LCB0aGVyZSBpcyBhIGxhcmdlIHNldCBvZiBjbGVhbnVwcyB0byBiZSBkb25lIHdoZW4gYm90aCB0
aGUgdmNwdSAKPiBhbmQgdGhlIHJ1bgo+IHN0cnVjdHVyZXMgYXJlIHBhc3NlZCBhcyBwYXJhbWV0
ZXJzIGF0IHRoZSBzYW1lIHRpbWUuIEp1c3QgZ3JlcHBpbmcgdGhlIAo+IHRyZWUgZm9yCj4ga3Zt
X3J1biBpcyBwcmV0dHkgaW5zdHJ1Y3RpdmUuCj4gCj4gIMKgwqDCoMKgwqDCoMKgIE0uCgpTb3Jy
eSwgaXQncyBteSBtaXN0YWtlLCBJIG9ubHkgY29tcGlsZWQgdGhlIHg4NiBwbGF0Zm9ybSwgSSB3
aWxsIHN1Ym1pdCAKcGF0Y2ggYWdhaW4uCgpUaGFua3MsClRpYW5qaWEKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1h
cm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21h
aWxtYW4vbGlzdGluZm8va3ZtYXJtCg==
