Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 663FE357052
	for <lists+kvmarm@lfdr.de>; Wed,  7 Apr 2021 17:31:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 19EE24B93E;
	Wed,  7 Apr 2021 11:31:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CgWR5YqUojuy; Wed,  7 Apr 2021 11:31:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A58F4B942;
	Wed,  7 Apr 2021 11:31:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A91524B93C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 11:31:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UV03xvlOqdoK for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Apr 2021 11:31:03 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D9A4D4B902
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Apr 2021 11:31:03 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E3521424;
 Wed,  7 Apr 2021 08:31:03 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 415C73F792;
 Wed,  7 Apr 2021 08:31:01 -0700 (PDT)
Subject: Re: [RFC PATCH v3 1/2] KVM: arm64: Move CMOs from user_mem_abort to
 the fault handlers
To: Yanan Wang <wangyanan55@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210326031654.3716-1-wangyanan55@huawei.com>
 <20210326031654.3716-2-wangyanan55@huawei.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <cd6c8a86-b7b2-3d3e-121a-c9d1cb23c4b3@arm.com>
Date: Wed, 7 Apr 2021 16:31:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210326031654.3716-2-wangyanan55@huawei.com>
Content-Language: en-US
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

SGkgWWFuYW4sCgpPbiAzLzI2LzIxIDM6MTYgQU0sIFlhbmFuIFdhbmcgd3JvdGU6Cj4gV2UgY3Vy
cmVudGx5IHVuaWZvcm1seSBwZXJtb3JtIENNT3Mgb2YgRC1jYWNoZSBhbmQgSS1jYWNoZSBpbiBm
dW5jdGlvbgo+IHVzZXJfbWVtX2Fib3J0IGJlZm9yZSBjYWxsaW5nIHRoZSBmYXVsdCBoYW5kbGVy
cy4gSWYgd2UgZ2V0IGNvbmN1cnJlbnQKPiBndWVzdCBmYXVsdHMoZS5nLiB0cmFuc2xhdGlvbiBm
YXVsdHMsIHBlcm1pc3Npb24gZmF1bHRzKSBvciBzb21lIHJlYWxseQo+IHVubmVjZXNzYXJ5IGd1
ZXN0IGZhdWx0cyBjYXVzZWQgYnkgQkJNLCBDTU9zIGZvciB0aGUgZmlyc3QgdmNwdSBhcmUKCkkg
Y2FuJ3QgZmlndXJlIG91dCB3aGF0IEJCTSBtZWFucy4KCj4gbmVjZXNzYXJ5IHdoaWxlIHRoZSBv
dGhlcnMgbGF0ZXIgYXJlIG5vdC4KPgo+IEJ5IG1vdmluZyBDTU9zIHRvIHRoZSBmYXVsdCBoYW5k
bGVycywgd2UgY2FuIGVhc2lseSBpZGVudGlmeSBjb25kaXRpb25zCj4gd2hlcmUgdGhleSBhcmUg
cmVhbGx5IG5lZWRlZCBhbmQgYXZvaWQgdGhlIHVubmVjZXNzYXJ5IG9uZXMuIEFzIGl0J3MgYQo+
IHRpbWUgY29uc3VtaW5nIHByb2Nlc3MgdG8gcGVyZm9ybSBDTU9zIGVzcGVjaWFsbHkgd2hlbiBm
bHVzaGluZyBhIGJsb2NrCj4gcmFuZ2UsIHNvIHRoaXMgc29sdXRpb24gcmVkdWNlcyBtdWNoIGxv
YWQgb2Yga3ZtIGFuZCBpbXByb3ZlIGVmZmljaWVuY3kKPiBvZiB0aGUgcGFnZSB0YWJsZSBjb2Rl
Lgo+Cj4gU28gbGV0J3MgbW92ZSBib3RoIGNsZWFuIG9mIEQtY2FjaGUgYW5kIGludmFsaWRhdGlv
biBvZiBJLWNhY2hlIHRvIHRoZQo+IG1hcCBwYXRoIGFuZCBtb3ZlIG9ubHkgaW52YWxpZGF0aW9u
IG9mIEktY2FjaGUgdG8gdGhlIHBlcm1pc3Npb24gcGF0aC4KPiBTaW5jZSB0aGUgb3JpZ2luYWwg
QVBJcyBmb3IgQ01PcyBpbiBtbXUuYyBhcmUgb25seSBjYWxsZWQgaW4gZnVuY3Rpb24KPiB1c2Vy
X21lbV9hYm9ydCwgd2Ugbm93IGFsc28gbW92ZSB0aGVtIHRvIHBndGFibGUuYy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFlhbmFuIFdhbmcgPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+Cj4gLS0tCj4gIGFy
Y2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX21tdS5oIHwgMzEgLS0tLS0tLS0tLS0tLS0tCj4gIGFy
Y2gvYXJtNjQva3ZtL2h5cC9wZ3RhYmxlLmMgICAgIHwgNjggKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0KPiAgYXJjaC9hcm02NC9rdm0vbW11LmMgICAgICAgICAgICAgfCAyMyArKy0t
LS0tLS0tLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDY1IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX21tdS5oIGIv
YXJjaC9hcm02NC9pbmNsdWRlL2FzbS9rdm1fbW11LmgKPiBpbmRleCA5MDg3Mzg1MWY2NzcuLmMz
MWY4ODMwNmQ0ZSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2t2bV9tbXUu
aAo+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20va3ZtX21tdS5oCj4gQEAgLTE3NywzNyAr
MTc3LDYgQEAgc3RhdGljIGlubGluZSBib29sIHZjcHVfaGFzX2NhY2hlX2VuYWJsZWQoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1KQo+ICAJcmV0dXJuICh2Y3B1X3JlYWRfc3lzX3JlZyh2Y3B1LCBTQ1RM
Ul9FTDEpICYgMGIxMDEpID09IDBiMTAxOwo+ICB9Cj4gIAo+IC1zdGF0aWMgaW5saW5lIHZvaWQg
X19jbGVhbl9kY2FjaGVfZ3Vlc3RfcGFnZShrdm1fcGZuX3QgcGZuLCB1bnNpZ25lZCBsb25nIHNp
emUpCj4gLXsKPiAtCXZvaWQgKnZhID0gcGFnZV9hZGRyZXNzKHBmbl90b19wYWdlKHBmbikpOwo+
IC0KPiAtCS8qCj4gLQkgKiBXaXRoIEZXQiwgd2UgZW5zdXJlIHRoYXQgdGhlIGd1ZXN0IGFsd2F5
cyBhY2Nlc3NlcyBtZW1vcnkgdXNpbmcKPiAtCSAqIGNhY2hlYWJsZSBhdHRyaWJ1dGVzLCBhbmQg
d2UgZG9uJ3QgaGF2ZSB0byBjbGVhbiB0byBQb0Mgd2hlbgo+IC0JICogZmF1bHRpbmcgaW4gcGFn
ZXMuIEZ1cnRoZXJtb3JlLCBGV0IgaW1wbGllcyBJREMsIHNvIGNsZWFuaW5nIHRvCj4gLQkgKiBQ
b1UgaXMgbm90IHJlcXVpcmVkIGVpdGhlciBpbiB0aGlzIGNhc2UuCj4gLQkgKi8KPiAtCWlmIChj
cHVzX2hhdmVfY29uc3RfY2FwKEFSTTY0X0hBU19TVEFHRTJfRldCKSkKPiAtCQlyZXR1cm47Cj4g
LQo+IC0Ja3ZtX2ZsdXNoX2RjYWNoZV90b19wb2ModmEsIHNpemUpOwo+IC19Cj4gLQo+IC1zdGF0
aWMgaW5saW5lIHZvaWQgX19pbnZhbGlkYXRlX2ljYWNoZV9ndWVzdF9wYWdlKGt2bV9wZm5fdCBw
Zm4sCj4gLQkJCQkJCSAgdW5zaWduZWQgbG9uZyBzaXplKQo+IC17Cj4gLQlpZiAoaWNhY2hlX2lz
X2FsaWFzaW5nKCkpIHsKPiAtCQkvKiBhbnkga2luZCBvZiBWSVBUIGNhY2hlICovCj4gLQkJX19m
bHVzaF9pY2FjaGVfYWxsKCk7Cj4gLQl9IGVsc2UgaWYgKGlzX2tlcm5lbF9pbl9oeXBfbW9kZSgp
IHx8ICFpY2FjaGVfaXNfdnBpcHQoKSkgewo+IC0JCS8qIFBJUFQgb3IgVlBJUFQgYXQgRUwyIChz
ZWUgY29tbWVudCBpbiBfX2t2bV90bGJfZmx1c2hfdm1pZF9pcGEpICovCj4gLQkJdm9pZCAqdmEg
PSBwYWdlX2FkZHJlc3MocGZuX3RvX3BhZ2UocGZuKSk7Cj4gLQo+IC0JCWludmFsaWRhdGVfaWNh
Y2hlX3JhbmdlKCh1bnNpZ25lZCBsb25nKXZhLAo+IC0JCQkJCSh1bnNpZ25lZCBsb25nKXZhICsg
c2l6ZSk7Cj4gLQl9Cj4gLX0KPiAtCj4gIHZvaWQga3ZtX3NldF93YXlfZmx1c2goc3RydWN0IGt2
bV92Y3B1ICp2Y3B1KTsKPiAgdm9pZCBrdm1fdG9nZ2xlX2NhY2hlKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwgYm9vbCB3YXNfZW5hYmxlZCk7Cj4gIAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2t2
bS9oeXAvcGd0YWJsZS5jIGIvYXJjaC9hcm02NC9rdm0vaHlwL3BndGFibGUuYwo+IGluZGV4IDRk
MTc3Y2UxZDUzNi4uODI5YTM0ZWVhNTI2IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQva3ZtL2h5
cC9wZ3RhYmxlLmMKPiArKysgYi9hcmNoL2FybTY0L2t2bS9oeXAvcGd0YWJsZS5jCj4gQEAgLTQ2
NCw2ICs0NjQsNDMgQEAgc3RhdGljIGludCBzdGFnZTJfbWFwX3NldF9wcm90X2F0dHIoZW51bSBr
dm1fcGd0YWJsZV9wcm90IHByb3QsCj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiArc3RhdGljIGJv
b2wgc3RhZ2UyX3B0ZV9jYWNoZWFibGUoa3ZtX3B0ZV90IHB0ZSkKPiArewo+ICsJdTY0IG1lbWF0
dHIgPSBwdGUgJiBLVk1fUFRFX0xFQUZfQVRUUl9MT19TMl9NRU1BVFRSOwo+ICsJcmV0dXJuIG1l
bWF0dHIgPT0gUEFHRV9TMl9NRU1BVFRSKE5PUk1BTCk7Cj4gK30KPiArCj4gK3N0YXRpYyBib29s
IHN0YWdlMl9wdGVfZXhlY3V0YWJsZShrdm1fcHRlX3QgcHRlKQo+ICt7Cj4gKwlyZXR1cm4gIShw
dGUgJiBLVk1fUFRFX0xFQUZfQVRUUl9ISV9TMl9YTik7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lk
IHN0YWdlMl9mbHVzaF9kY2FjaGUodm9pZCAqYWRkciwgdTY0IHNpemUpCj4gK3sKPiArCS8qCj4g
KwkgKiBXaXRoIEZXQiwgd2UgZW5zdXJlIHRoYXQgdGhlIGd1ZXN0IGFsd2F5cyBhY2Nlc3NlcyBt
ZW1vcnkgdXNpbmcKPiArCSAqIGNhY2hlYWJsZSBhdHRyaWJ1dGVzLCBhbmQgd2UgZG9uJ3QgaGF2
ZSB0byBjbGVhbiB0byBQb0Mgd2hlbgo+ICsJICogZmF1bHRpbmcgaW4gcGFnZXMuIEZ1cnRoZXJt
b3JlLCBGV0IgaW1wbGllcyBJREMsIHNvIGNsZWFuaW5nIHRvCj4gKwkgKiBQb1UgaXMgbm90IHJl
cXVpcmVkIGVpdGhlciBpbiB0aGlzIGNhc2UuCj4gKwkgKi8KPiArCWlmIChjcHVzX2hhdmVfY29u
c3RfY2FwKEFSTTY0X0hBU19TVEFHRTJfRldCKSkKPiArCQlyZXR1cm47Cj4gKwo+ICsJX19mbHVz
aF9kY2FjaGVfYXJlYShhZGRyLCBzaXplKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgc3RhZ2Uy
X2ludmFsaWRhdGVfaWNhY2hlKHZvaWQgKmFkZHIsIHU2NCBzaXplKQo+ICt7Cj4gKwlpZiAoaWNh
Y2hlX2lzX2FsaWFzaW5nKCkpIHsKPiArCQkvKiBGbHVzaCBhbnkga2luZCBvZiBWSVBUIGljYWNo
ZSAqLwo+ICsJCV9fZmx1c2hfaWNhY2hlX2FsbCgpOwo+ICsJfSBlbHNlIGlmIChpc19rZXJuZWxf
aW5faHlwX21vZGUoKSB8fCAhaWNhY2hlX2lzX3ZwaXB0KCkpIHsKPiArCQkvKiBQSVBUIG9yIFZQ
SVBUIGF0IEVMMiAqLwo+ICsJCWludmFsaWRhdGVfaWNhY2hlX3JhbmdlKCh1bnNpZ25lZCBsb25n
KWFkZHIsCj4gKwkJCQkJKHVuc2lnbmVkIGxvbmcpYWRkciArIHNpemUpOwo+ICsJfQo+ICt9Cj4g
Kwo+ICBzdGF0aWMgaW50IHN0YWdlMl9tYXBfd2Fsa2VyX3RyeV9sZWFmKHU2NCBhZGRyLCB1NjQg
ZW5kLCB1MzIgbGV2ZWwsCj4gIAkJCQkgICAgICBrdm1fcHRlX3QgKnB0ZXAsCj4gIAkJCQkgICAg
ICBzdHJ1Y3Qgc3RhZ2UyX21hcF9kYXRhICpkYXRhKQo+IEBAIC00OTUsNiArNTMyLDEzIEBAIHN0
YXRpYyBpbnQgc3RhZ2UyX21hcF93YWxrZXJfdHJ5X2xlYWYodTY0IGFkZHIsIHU2NCBlbmQsIHUz
MiBsZXZlbCwKPiAgCQlwdXRfcGFnZShwYWdlKTsKPiAgCX0KPiAgCj4gKwkvKiBQZXJmb3JtIENN
T3MgYmVmb3JlIGluc3RhbGxhdGlvbiBvZiB0aGUgbmV3IFBURSAqLwo+ICsJaWYgKCFrdm1fcHRl
X3ZhbGlkKG9sZCkgfHwgc3RhZ2UyX3B0ZV9jYWNoZWFibGUob2xkKSkKCkknbSBub3Qgc3VyZSB3
aHkgdGhlIHN0YWdlMl9wdGVfY2FjaGVhYmxlKG9sZCkgY29uZGl0aW9uIGlzIG5lZWRlZC4KCmt2
bV9oYW5kbGVfZ3Vlc3RfYWJvcnQoKSBoYW5kbGVzIHRocmVlIHR5cGVzIG9mIHN0YWdlIDIgZGF0
YSBvciBpbnN0cnVjdGlvbgphYm9ydHM6IHRyYW5zbGF0aW9uIGZhdWx0cyAoZmF1bHRfc3RhdHVz
ID09IEZTQ19GQVVMVCksIGFjY2VzcyBmYXVsdHMKKGZhdWx0X3N0YXR1cyA9PSBGU0NfQUNDRVNT
KSBhbmQgcGVybWlzc2lvbiBmYXVsdHMgKGZhdWx0X3N0YXR1cyA9PSBGU0NfUEVSTSkuCgpBY2Nl
c3MgZmF1bHRzIGFyZSBoYW5kbGVkIGluIGhhbmRsZV9hY2Nlc3NfZmF1bHQoKSwgd2hpY2ggbWVh
bnMgdXNlcl9tZW1fYWJvcnQoKQpoYW5kbGVzIHRyYW5zbGF0aW9uIGFuZCBwZXJtaXNzaW9uIGZh
dWx0cy4gVGhlIG9yaWdpbmFsIGNvZGUgZGlkIHRoZSBkY2FjaGUgY2xlYW4KKyBpbnZhbCB3aGVu
IG5vdCBhIHBlcm1pc3Npb24gZmF1bHQsIHdoaWNoIG1lYW5zIHRoZSBDTU8gd2FzIGRvbmUgb25s
eSBvbiBhCnRyYW5zbGF0aW9uIGZhdWx0LiBUcmFuc2xhdGlvbiBmYXVsdHMgbWVhbiB0aGF0IHRo
ZSBJUEEgd2FzIG5vdCBtYXBwZWQsIHNvIHRoZSBvbGQKZW50cnkgd2lsbCBhbHdheXMgYmUgaW52
YWxpZC4gRXZlbiBpZiB3ZSdyZSBjb2FsZXNjaW5nIG11bHRpcGxlIGxhc3QgbGV2ZWwgbGVhZgpl
bnRyaWVzIGludCBvYcKgIGJsb2NrIG1hcHBpbmcsIHRoZSB0YWJsZSBlbnRyeSB3aGljaCBpcyBy
ZXBsYWNlZCBpcyBpbnZhbGlkCmJlY2F1c2UgaXQncyBtYXJrZWQgYXMgc3VjaCBpbiBzdGFnZTJf
bWFwX3dhbGtfdGFibGVfcHJlKCkuCgpJcyB0aGVyZSBzb21ldGhpbmcgSSdtIG1pc3Npbmc/Cgo+
ICsJCXN0YWdlMl9mbHVzaF9kY2FjaGUoX192YShwaHlzKSwgZ3JhbnVsZSk7Cj4gKwo+ICsJaWYg
KHN0YWdlMl9wdGVfZXhlY3V0YWJsZShuZXcpKQo+ICsJCXN0YWdlMl9pbnZhbGlkYXRlX2ljYWNo
ZShfX3ZhKHBoeXMpLCBncmFudWxlKTsKClRoaXMsIHRvZ2V0aGVyIHdpdGggdGhlIHN0YWdlMl9h
dHRyX3dhbGtlcigpIGNoYW5nZXMgYmVsb3csIGxvb2sgaWRlbnRpY2FsIHRvIHRoZQpjdXJyZW50
IGNvZGUgaW4gdXNlcl9tZW1fYWJvcnQoKS4gVGhlIGV4ZWN1dGFibGUgcGVybWlzc2lvbiBpcyBz
ZXQgb24gYW4gZXhlYwpmYXVsdCAoaW5zdHJ1Y3Rpb24gYWJvcnQgbm90IG9uIGEgc3RhZ2UgMiB0
cmFuc2xhdGlvbiB0YWJsZSB3YWxrKSwgYW5kIGFzIGEgcmVzdWx0Cm9mIHRoZSBmYXVsdCB3ZSBl
aXRoZXIgbmVlZCB0byBtYXAgYSBuZXcgcGFnZSBoZXJlLCBvciByZWxheCBwZXJtaXNzaW9ucyBp
bgprdm1fcGd0YWJsZV9zdGFnZTJfcmVsYXhfcGVybXMoKSAtPiBzdGFnZTJfYXR0cl93YWxrZXIo
KSBiZWxvdy4KClRoYW5rcywKCkFsZXgKCj4gKwo+ICAJc21wX3N0b3JlX3JlbGVhc2UocHRlcCwg
bmV3KTsKPiAgCWdldF9wYWdlKHBhZ2UpOwo+ICAJZGF0YS0+cGh5cyArPSBncmFudWxlOwo+IEBA
IC02NTEsMjAgKzY5NSw2IEBAIGludCBrdm1fcGd0YWJsZV9zdGFnZTJfbWFwKHN0cnVjdCBrdm1f
cGd0YWJsZSAqcGd0LCB1NjQgYWRkciwgdTY0IHNpemUsCj4gIAlyZXR1cm4gcmV0Owo+ICB9Cj4g
IAo+IC1zdGF0aWMgdm9pZCBzdGFnZTJfZmx1c2hfZGNhY2hlKHZvaWQgKmFkZHIsIHU2NCBzaXpl
KQo+IC17Cj4gLQlpZiAoY3B1c19oYXZlX2NvbnN0X2NhcChBUk02NF9IQVNfU1RBR0UyX0ZXQikp
Cj4gLQkJcmV0dXJuOwo+IC0KPiAtCV9fZmx1c2hfZGNhY2hlX2FyZWEoYWRkciwgc2l6ZSk7Cj4g
LX0KPiAtCj4gLXN0YXRpYyBib29sIHN0YWdlMl9wdGVfY2FjaGVhYmxlKGt2bV9wdGVfdCBwdGUp
Cj4gLXsKPiAtCXU2NCBtZW1hdHRyID0gcHRlICYgS1ZNX1BURV9MRUFGX0FUVFJfTE9fUzJfTUVN
QVRUUjsKPiAtCXJldHVybiBtZW1hdHRyID09IFBBR0VfUzJfTUVNQVRUUihOT1JNQUwpOwo+IC19
Cj4gLQo+ICBzdGF0aWMgaW50IHN0YWdlMl91bm1hcF93YWxrZXIodTY0IGFkZHIsIHU2NCBlbmQs
IHUzMiBsZXZlbCwga3ZtX3B0ZV90ICpwdGVwLAo+ICAJCQkgICAgICAgZW51bSBrdm1fcGd0YWJs
ZV93YWxrX2ZsYWdzIGZsYWcsCj4gIAkJCSAgICAgICB2b2lkICogY29uc3QgYXJnKQo+IEBAIC03
NDMsOCArNzczLDE2IEBAIHN0YXRpYyBpbnQgc3RhZ2UyX2F0dHJfd2Fsa2VyKHU2NCBhZGRyLCB1
NjQgZW5kLCB1MzIgbGV2ZWwsIGt2bV9wdGVfdCAqcHRlcCwKPiAgCSAqIGJ1dCB3b3JzdC1jYXNl
IHRoZSBhY2Nlc3MgZmxhZyB1cGRhdGUgZ2V0cyBsb3N0IGFuZCB3aWxsIGJlCj4gIAkgKiBzZXQg
b24gdGhlIG5leHQgYWNjZXNzIGluc3RlYWQuCj4gIAkgKi8KPiAtCWlmIChkYXRhLT5wdGUgIT0g
cHRlKQo+ICsJaWYgKGRhdGEtPnB0ZSAhPSBwdGUpIHsKPiArCQkvKgo+ICsJCSAqIEludmFsaWRh
dGUgdGhlIGluc3RydWN0aW9uIGNhY2hlIGJlZm9yZSB1cGRhdGluZwo+ICsJCSAqIGlmIHdlIGFy
ZSBnb2luZyB0byBhZGQgdGhlIGV4ZWN1dGFibGUgcGVybWlzc2lvbi4KPiArCQkgKi8KPiArCQlp
ZiAoIXN0YWdlMl9wdGVfZXhlY3V0YWJsZSgqcHRlcCkgJiYgc3RhZ2UyX3B0ZV9leGVjdXRhYmxl
KHB0ZSkpCj4gKwkJCXN0YWdlMl9pbnZhbGlkYXRlX2ljYWNoZShrdm1fcHRlX2ZvbGxvdyhwdGUp
LAo+ICsJCQkJCQkga3ZtX2dyYW51bGVfc2l6ZShsZXZlbCkpOwo+ICAJCVdSSVRFX09OQ0UoKnB0
ZXAsIHB0ZSk7Cj4gKwl9Cj4gIAo+ICAJcmV0dXJuIDA7Cj4gIH0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9rdm0vbW11LmMgYi9hcmNoL2FybTY0L2t2bS9tbXUuYwo+IGluZGV4IDc3Y2IyZDI4
ZjJhNC4uMWVlYzlmNjNiYzZmIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQva3ZtL21tdS5jCj4g
KysrIGIvYXJjaC9hcm02NC9rdm0vbW11LmMKPiBAQCAtNjA5LDE2ICs2MDksNiBAQCB2b2lkIGt2
bV9hcmNoX21tdV9lbmFibGVfbG9nX2RpcnR5X3B0X21hc2tlZChzdHJ1Y3Qga3ZtICprdm0sCj4g
IAlrdm1fbW11X3dyaXRlX3Byb3RlY3RfcHRfbWFza2VkKGt2bSwgc2xvdCwgZ2ZuX29mZnNldCwg
bWFzayk7Cj4gIH0KPiAgCj4gLXN0YXRpYyB2b2lkIGNsZWFuX2RjYWNoZV9ndWVzdF9wYWdlKGt2
bV9wZm5fdCBwZm4sIHVuc2lnbmVkIGxvbmcgc2l6ZSkKPiAtewo+IC0JX19jbGVhbl9kY2FjaGVf
Z3Vlc3RfcGFnZShwZm4sIHNpemUpOwo+IC19Cj4gLQo+IC1zdGF0aWMgdm9pZCBpbnZhbGlkYXRl
X2ljYWNoZV9ndWVzdF9wYWdlKGt2bV9wZm5fdCBwZm4sIHVuc2lnbmVkIGxvbmcgc2l6ZSkKPiAt
ewo+IC0JX19pbnZhbGlkYXRlX2ljYWNoZV9ndWVzdF9wYWdlKHBmbiwgc2l6ZSk7Cj4gLX0KPiAt
Cj4gIHN0YXRpYyB2b2lkIGt2bV9zZW5kX2h3cG9pc29uX3NpZ25hbCh1bnNpZ25lZCBsb25nIGFk
ZHJlc3MsIHNob3J0IGxzYikKPiAgewo+ICAJc2VuZF9zaWdfbWNlZXJyKEJVU19NQ0VFUlJfQVIs
ICh2b2lkIF9fdXNlciAqKWFkZHJlc3MsIGxzYiwgY3VycmVudCk7Cj4gQEAgLTg4MiwxMyArODcy
LDggQEAgc3RhdGljIGludCB1c2VyX21lbV9hYm9ydChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHBo
eXNfYWRkcl90IGZhdWx0X2lwYSwKPiAgCWlmICh3cml0YWJsZSkKPiAgCQlwcm90IHw9IEtWTV9Q
R1RBQkxFX1BST1RfVzsKPiAgCj4gLQlpZiAoZmF1bHRfc3RhdHVzICE9IEZTQ19QRVJNICYmICFk
ZXZpY2UpCj4gLQkJY2xlYW5fZGNhY2hlX2d1ZXN0X3BhZ2UocGZuLCB2bWFfcGFnZXNpemUpOwo+
IC0KPiAtCWlmIChleGVjX2ZhdWx0KSB7Cj4gKwlpZiAoZXhlY19mYXVsdCkKPiAgCQlwcm90IHw9
IEtWTV9QR1RBQkxFX1BST1RfWDsKPiAtCQlpbnZhbGlkYXRlX2ljYWNoZV9ndWVzdF9wYWdlKHBm
biwgdm1hX3BhZ2VzaXplKTsKPiAtCX0KPiAgCj4gIAlpZiAoZGV2aWNlKQo+ICAJCXByb3QgfD0g
S1ZNX1BHVEFCTEVfUFJPVF9ERVZJQ0U7Cj4gQEAgLTExNDQsMTAgKzExMjksMTAgQEAgaW50IGt2
bV9zZXRfc3B0ZV9odmEoc3RydWN0IGt2bSAqa3ZtLCB1bnNpZ25lZCBsb25nIGh2YSwgcHRlX3Qg
cHRlKQo+ICAJdHJhY2Vfa3ZtX3NldF9zcHRlX2h2YShodmEpOwo+ICAKPiAgCS8qCj4gLQkgKiBX
ZSd2ZSBtb3ZlZCBhIHBhZ2UgYXJvdW5kLCBwcm9iYWJseSB0aHJvdWdoIENvVywgc28gbGV0J3Mg
dHJlYXQgaXQKPiAtCSAqIGp1c3QgbGlrZSBhIHRyYW5zbGF0aW9uIGZhdWx0IGFuZCBjbGVhbiB0
aGUgY2FjaGUgdG8gdGhlIFBvQy4KPiArCSAqIFdlJ3ZlIG1vdmVkIGEgcGFnZSBhcm91bmQsIHBy
b2JhYmx5IHRocm91Z2ggQ29XLCBzbyBsZXQncyB0cmVhdAo+ICsJICogaXQganVzdCBsaWtlIGEg
dHJhbnNsYXRpb24gZmF1bHQgYW5kIHRoZSBtYXAgaGFuZGxlciB3aWxsIGNsZWFuCj4gKwkgKiB0
aGUgY2FjaGUgdG8gdGhlIFBvQy4KPiAgCSAqLwo+IC0JY2xlYW5fZGNhY2hlX2d1ZXN0X3BhZ2Uo
cGZuLCBQQUdFX1NJWkUpOwo+ICAJaGFuZGxlX2h2YV90b19ncGEoa3ZtLCBodmEsIGVuZCwgJmt2
bV9zZXRfc3B0ZV9oYW5kbGVyLCAmcGZuKTsKPiAgCXJldHVybiAwOwo+ICB9Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QK
a3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVk
dS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
