Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5224036C6DA
	for <lists+kvmarm@lfdr.de>; Tue, 27 Apr 2021 15:15:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96B6C4B157;
	Tue, 27 Apr 2021 09:15:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QENg5NsdZP-k; Tue, 27 Apr 2021 09:15:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD46D4B150;
	Tue, 27 Apr 2021 09:15:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 224044B142
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Apr 2021 07:09:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uhsXgscVuJ1q for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Apr 2021 07:09:09 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D11D44B11F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Apr 2021 07:09:08 -0400 (EDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FTzTL22q8zPsMn;
 Tue, 27 Apr 2021 19:05:58 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 27 Apr 2021 19:09:00 +0800
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
To: Mike Rapoport <rppt@kernel.org>
References: <20210421065108.1987-1-rppt@kernel.org>
 <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
 <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
 <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
 <YIet5X7lgygD9rpZ@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
Date: Tue, 27 Apr 2021 19:08:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YIet5X7lgygD9rpZ@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 27 Apr 2021 09:15:48 -0400
Cc: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Ck9uIDIwMjEvNC8yNyAxNDoyMywgTWlrZSBSYXBvcG9ydCB3cm90ZToKPiBPbiBNb24sIEFwciAy
NiwgMjAyMSBhdCAxMToyNjozOFBNICswODAwLCBLZWZlbmcgV2FuZyB3cm90ZToKPj4gT24gMjAy
MS80LzI2IDEzOjIwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOgo+Pj4gT24gU3VuLCBBcHIgMjUsIDIw
MjEgYXQgMDM6NTE6NTZQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3JvdGU6Cj4+Pj4gT24gMjAyMS80
LzI1IDE1OjE5LCBNaWtlIFJhcG9wb3J0IHdyb3RlOgo+Pj4+Cj4+Pj4gICAgICAgT24gRnJpLCBB
cHIgMjMsIDIwMjEgYXQgMDQ6MTE6MTZQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3JvdGU6Cj4+Pj4K
Pj4+PiAgICAgICAgICAgSSB0ZXN0ZWQgdGhpcyBwYXRjaHNldChwbHVzIGFybTMyIGNoYW5nZSwg
bGlrZSBhcm02NCBkb2VzKQo+Pj4+ICAgICAgICAgICBiYXNlZCBvbiBsdHMgNS4xMO+8jGFkZCBz
b21lIGRlYnVnIGxvZywgdGhlIHVzZWZ1bCBpbmZvIHNob3dzCj4+Pj4gICAgICAgICAgIGJlbG93
LCBpZiB3ZSBlbmFibGUgSE9MRVNfSU5fWk9ORSwgbm8gcGFuaWMsIGFueSBpZGVhLAo+Pj4+ICAg
ICAgICAgICB0aGFua3MuCj4+Pj4KPj4+PiAgICAgICBBcmUgdGhlcmUgYW55IGNoYW5nZXMgb24g
dG9wIG9mIDUuMTAgZXhjZXB0IGZvciBwZm5fdmFsaWQoKSBwYXRjaD8KPj4+PiAgICAgICBEbyB5
b3Ugc2VlIHRoaXMgcGFuaWMgb24gNS4xMCB3aXRob3V0IHRoZSBjaGFuZ2VzPwo+Pj4+Cj4+Pj4g
WWVzLCB0aGVyZSBhcmUgc29tZSBCU1Agc3VwcG9ydCBmb3IgYXJtIGJvYXJkIGJhc2VkIG9uIDUu
MTAsCj4gSXMgaXQgcG9zc2libGUgdG8gdGVzdCA1LjEyPwo+Cj4+Pj4gd2l0aCBvciB3aXRob3V0
IHlvdXIgcGF0Y2ggd2lsbCBnZXQgc2FtZSBwYW5pYywgdGhlIHBhbmljIHBmbj1kZTYwMAo+Pj4+
IGluIHRoZSByYW5nZSBvZiBbZGNjMDAsZGUwMF0gd2hpY2ggaXMgZnJlZWQgYnkgZnJlZV9tZW1t
YXAsIHN0YXJ0X3Bmbgo+Pj4+ID0gZGNjMDAswqAgZGNjMDAwMDAgZW5kX3BmbiA9IGRlNzAwLCBk
ZTcwMDAwMAo+Pj4+Cj4+Pj4gd2Ugc2VlIHRoZSBQQyBpcyBhdCBQYWdlTFJVLCBzYW1lIHJlYXNv
biBsaWtlIGFybTY0IHBhbmljIGxvZywKPj4+Pgo+Pj4+ICAgICAgIlBhZ2VCdWRkeSBpbiBtb3Zl
X2ZyZWVwYWdlcyByZXR1cm5zIGZhbHNlCj4+Pj4gICAgICAgVGhlbiB3ZSBjYWxsIFBhZ2VMUlUs
IHRoZSBtYWNybyBjYWxscyBQRl9IRUFEIHdoaWNoIGlzIGNvbXBvdW5kX3BhZ2UoKQo+Pj4+ICAg
ICAgIGNvbXBvdW5kX3BhZ2UgcmVhZHMgcGFnZS0+Y29tcG91bmRfaGVhZCwgaXQgaXMgMHhmZmZm
ZmZmZmZmZmZmZmZmLCBzbyBpdAo+Pj4+ICAgICAgIHJlc3R1cm5zIDB4ZmZmZmZmZmZmZmZmZmZm
ZSAtIGFuZCBhY2Nlc3NpbmcgdGhpcyBhZGRyZXNzIGNhdXNlcyBjcmFzaCIKPj4+Pgo+Pj4+ICAg
ICAgIENhbiB5b3Ugc2VlIHN0YWNrIGJhY2t0cmFjZSBiZXlvbmQgbW92ZV9mcmVlcGFnZXNfYmxv
Y2s/Cj4+Pj4KPj4+PiBJIGRvIHNvbWUgb29tIHRlc3QsIHNvIHRoZSBsb2cgaXMgYWJvdXQgbWVt
b3J5IGFsbG9jYXRlLAo+Pj4+Cj4+Pj4gWzxjMDIzODNjOD5dIChtb3ZlX2ZyZWVwYWdlc19ibG9j
aykgZnJvbSBbPGMwMjM4NjY4Pl0KPj4+PiAoc3RlYWxfc3VpdGFibGVfZmFsbGJhY2srMHgxNzQv
MHgxZjQpCj4+Pj4KPj4+PiBbPGMwMjM4NjY4Pl0gKHN0ZWFsX3N1aXRhYmxlX2ZhbGxiYWNrKSBm
cm9tIFs8YzAyMzk5OWM+XSAoZ2V0X3BhZ2VfZnJvbV9mcmVlbGlzdCsweDQ5MC8weDlhNCkKPj4+
IEhtbSwgdGhpcyBpcyBjYWxsZWQgd2l0aCBhIHBhZ2UgZnJvbSBmcmVlIGxpc3QsIGhhdmluZyBh
IHBhZ2UgZnJvbSBhIGZyZWVkCj4+PiBwYXJ0IG9mIHRoZSBtZW1vcnkgbWFwIHBhc3NlZCB0byBz
dGVhbF9zdWl0YWJsZV9mYWxsYmFjaygpIG1lYW5zIHRoYXQgdGhlcmUKPj4+IGlzIGFuIGlzc3Vl
IHdpdGggY3JlYXRpb24gb2YgdGhlIGZyZWUgbGlzdC4KPj4+Cj4+PiBDYW4geW91IHBsZWFzZSBh
ZGQgIm1lbWJsb2NrPWRlYnVnIiB0byB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBhbmQgcG9zdCB0
aGUKPj4+IGxvZz8KPj4gSGVyZSBpcyB0aGUgbG9nLAo+Pgo+PiBDUFU6IEFSTXY3IFByb2Nlc3Nv
ciBbNDEzZmMwOTBdIHJldmlzaW9uIDAgKEFSTXY3KSwgY3I9MWFjNTM4N2QKPj4KPj4gQ1BVOiBQ
SVBUIC8gVklQVCBub25hbGlhc2luZyBkYXRhIGNhY2hlLCBWSVBUIGFsaWFzaW5nIGluc3RydWN0
aW9uIGNhY2hlCj4+IE9GOiBmZHQ6IE1hY2hpbmUgbW9kZWw6IEhJU0ktQ0E5Cj4+IG1lbWJsb2Nr
X2FkZDogWzB4ODBhMDAwMDAtMHg4NTVmZmZmZl0gZWFybHlfaW5pdF9kdF9zY2FuX21lbW9yeSsw
eDExYy8weDE4OAo+PiBtZW1ibG9ja19hZGQ6IFsweDg2YTAwMDAwLTB4ODdkZmZmZmZdIGVhcmx5
X2luaXRfZHRfc2Nhbl9tZW1vcnkrMHgxMWMvMHgxODgKPj4gbWVtYmxvY2tfYWRkOiBbMHg4YmQw
MDAwMC0weDhjNGZmZmZmXSBlYXJseV9pbml0X2R0X3NjYW5fbWVtb3J5KzB4MTFjLzB4MTg4Cj4+
IG1lbWJsb2NrX2FkZDogWzB4OGUzMDAwMDAtMHg4ZWNmZmZmZl0gZWFybHlfaW5pdF9kdF9zY2Fu
X21lbW9yeSsweDExYy8weDE4OAo+PiBtZW1ibG9ja19hZGQ6IFsweDkwZDAwMDAwLTB4YmZmZmZm
ZmZdIGVhcmx5X2luaXRfZHRfc2Nhbl9tZW1vcnkrMHgxMWMvMHgxODgKPj4gbWVtYmxvY2tfYWRk
OiBbMHhjYzAwMDAwMC0weGRjOWZmZmZmXSBlYXJseV9pbml0X2R0X3NjYW5fbWVtb3J5KzB4MTFj
LzB4MTg4Cj4+IG1lbWJsb2NrX2FkZDogWzB4ZTA4MDAwMDAtMHhlMGJmZmZmZl0gZWFybHlfaW5p
dF9kdF9zY2FuX21lbW9yeSsweDExYy8weDE4OAo+PiBtZW1ibG9ja19hZGQ6IFsweGY1MzAwMDAw
LTB4ZjViZmZmZmZdIGVhcmx5X2luaXRfZHRfc2Nhbl9tZW1vcnkrMHgxMWMvMHgxODgKPj4gbWVt
YmxvY2tfYWRkOiBbMHhmNWMwMDAwMC0weGY2ZmZmZmZmXSBlYXJseV9pbml0X2R0X3NjYW5fbWVt
b3J5KzB4MTFjLzB4MTg4Cj4+IG1lbWJsb2NrX2FkZDogWzB4ZmUxMDAwMDAtMHhmZWJmZmZmZl0g
ZWFybHlfaW5pdF9kdF9zY2FuX21lbW9yeSsweDExYy8weDE4OAo+PiBtZW1ibG9ja19hZGQ6IFsw
eGZlYzAwMDAwLTB4ZmZmZmZmZmZdIGVhcmx5X2luaXRfZHRfc2Nhbl9tZW1vcnkrMHgxMWMvMHgx
ODgKPj4gbWVtYmxvY2tfYWRkOiBbMHhkZTcwMDAwMC0weGRlOWZmZmZmXSBlYXJseV9pbml0X2R0
X3NjYW5fbWVtb3J5KzB4MTFjLzB4MTg4Cj4+IG1lbWJsb2NrX2FkZDogWzB4ZjRiMDAwMDAtMHhm
NTJmZmZmZl0gZWFybHlfaW5pdF9kdF9zY2FuX21lbW9yeSsweDExYy8weDE4OAo+PiBtZW1ibG9j
a19hZGQ6IFsweGZkYTAwMDAwLTB4ZmUwZmZmZmZdIGVhcmx5X2luaXRfZHRfc2Nhbl9tZW1vcnkr
MHgxMWMvMHgxODgKPj4gbWVtYmxvY2tfcmVzZXJ2ZTogWzB4ODBhMDEwMDAtMHg4MGEwMmQyZV0g
c2V0dXBfYXJjaCsweDY4LzB4NWM0Cj4+IE1hbGZvcm1lZCBlYXJseSBvcHRpb24gJ3ZlY3BhZ2Vf
d3Jwcm90ZWN0Jwo+PiBNZW1vcnkgcG9saWN5OiBEYXRhIGNhY2hlIHdyaXRlYWxsb2MKPj4gbWVt
YmxvY2tfcmVzZXJ2ZTogWzB4ODBiMDAwMDAtMHg4MTJlODA1N10gYXJtX21lbWJsb2NrX2luaXQr
MHgzNC8weDE0Ywo+PiBtZW1ibG9ja19yZXNlcnZlOiBbMHg4MzAwMDAwMC0weDg0ZmZmZmZmXSBh
cm1fbWVtYmxvY2tfaW5pdCsweDEwMC8weDE0Ywo+PiBtZW1ibG9ja19yZXNlcnZlOiBbMHg4MGEw
NDAwMC0weDgwYTA3ZmZmXSBhcm1fbWVtYmxvY2tfaW5pdCsweGEwLzB4MTRjCj4+IG1lbWJsb2Nr
X3Jlc2VydmU6IFsweDgwYTAwMDAwLTB4ODBhMDJmZmZdIGhpc2lfbWVtX3Jlc2VydmUrMHgxNC8w
eDMwCj4+IE1FTUJMT0NLIGNvbmZpZ3VyYXRpb246Cj4+ICDCoG1lbW9yeSBzaXplID0gMHg0YzBm
ZmZmZiByZXNlcnZlZCBzaXplID0gMHgwMjdlZjA1OAo+PiAgwqBtZW1vcnkuY250wqAgPSAweGEK
Pj4gIMKgbWVtb3J5WzB4MF3CoMKgwqAgWzB4ODBhMDAwMDAtMHg4NTVmZmZmZl0sIDB4MDRjMDAw
MDAgYnl0ZXMgZmxhZ3M6IDB4MAo+PiAgwqBtZW1vcnlbMHgxXcKgwqDCoCBbMHg4NmEwMDAwMC0w
eDg3ZGZmZmZmXSwgMHgwMTQwMDAwMCBieXRlcyBmbGFnczogMHgwCj4+ICDCoG1lbW9yeVsweDJd
wqDCoMKgIFsweDhiZDAwMDAwLTB4OGM0ZmZmZmZdLCAweDAwODAwMDAwIGJ5dGVzIGZsYWdzOiAw
eDAKPj4gIMKgbWVtb3J5WzB4M13CoMKgwqAgWzB4OGUzMDAwMDAtMHg4ZWNmZmZmZl0sIDB4MDBh
MDAwMDAgYnl0ZXMgZmxhZ3M6IDB4MAo+PiAgwqBtZW1vcnlbMHg0XcKgwqDCoCBbMHg5MGQwMDAw
MC0weGJmZmZmZmZmXSwgMHgyZjMwMDAwMCBieXRlcyBmbGFnczogMHgwCj4+ICDCoG1lbW9yeVsw
eDVdwqDCoMKgIFsweGNjMDAwMDAwLTB4ZGM5ZmZmZmZdLCAweDEwYTAwMDAwIGJ5dGVzIGZsYWdz
OiAweDAKPj4gIMKgbWVtb3J5WzB4Nl3CoMKgwqAgWzB4ZGU3MDAwMDAtMHhkZTlmZmZmZl0sIDB4
MDAzMDAwMDAgYnl0ZXMgZmxhZ3M6IDB4MAo+PiAgwqBtZW1vcnlbMHg3XcKgwqDCoCBbMHhlMDgw
MDAwMC0weGUwYmZmZmZmXSwgMHgwMDQwMDAwMCBieXRlcyBmbGFnczogMHgwCj4+ICDCoG1lbW9y
eVsweDhdwqDCoMKgIFsweGY0YjAwMDAwLTB4ZjZmZmZmZmZdLCAweDAyNTAwMDAwIGJ5dGVzIGZs
YWdzOiAweDAKPj4gIMKgbWVtb3J5WzB4OV3CoMKgwqAgWzB4ZmRhMDAwMDAtMHhmZmZmZmZmZV0s
IDB4MDI1ZmZmZmYgYnl0ZXMgZmxhZ3M6IDB4MAo+PiAgwqByZXNlcnZlZC5jbnTCoCA9IDB4NAo+
PiAgwqByZXNlcnZlZFsweDBdwqDCoMKgIFsweDgwYTAwMDAwLTB4ODBhMDJmZmZdLCAweDAwMDAz
MDAwIGJ5dGVzIGZsYWdzOiAweDAKPj4gIMKgcmVzZXJ2ZWRbMHgxXcKgwqDCoCBbMHg4MGEwNDAw
MC0weDgwYTA3ZmZmXSwgMHgwMDAwNDAwMCBieXRlcyBmbGFnczogMHgwCj4+ICDCoHJlc2VydmVk
WzB4Ml3CoMKgwqAgWzB4ODBiMDAwMDAtMHg4MTJlODA1N10sIDB4MDA3ZTgwNTggYnl0ZXMgZmxh
Z3M6IDB4MAo+PiAgwqByZXNlcnZlZFsweDNdwqDCoMKgIFsweDgzMDAwMDAwLTB4ODRmZmZmZmZd
LCAweDAyMDAwMDAwIGJ5dGVzIGZsYWdzOiAweDAKPiAuLi4KPj4gWm9uZSByYW5nZXM6Cj4+ICDC
oCBOb3JtYWzCoMKgIFttZW0gMHgwMDAwMDAwMDgwYTAwMDAwLTB4MDAwMDAwMDBiMDFmZmZmZl0K
Pj4gIMKgIEhpZ2hNZW3CoCBbbWVtIDB4MDAwMDAwMDBiMDIwMDAwMC0weDAwMDAwMDAwZmZmZmVm
ZmZdCj4+IE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFjaCBub2RlCj4+IEVhcmx5IG1lbW9yeSBu
b2RlIHJhbmdlcwo+PiAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAwMDAwODBhMDAwMDAtMHgw
MDAwMDAwMDg1NWZmZmZmXQo+PiAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAwMDAwODZhMDAw
MDAtMHgwMDAwMDAwMDg3ZGZmZmZmXQo+PiAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAwMDAw
OGJkMDAwMDAtMHgwMDAwMDAwMDhjNGZmZmZmXQo+PiAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAw
MDAwMDAwOGUzMDAwMDAtMHgwMDAwMDAwMDhlY2ZmZmZmXQo+PiAgwqAgbm9kZcKgwqAgMDogW21l
bSAweDAwMDAwMDAwOTBkMDAwMDAtMHgwMDAwMDAwMGJmZmZmZmZmXQo+PiAgwqAgbm9kZcKgwqAg
MDogW21lbSAweDAwMDAwMDAwY2MwMDAwMDAtMHgwMDAwMDAwMGRjOWZmZmZmXQo+PiAgwqAgbm9k
ZcKgwqAgMDogW21lbSAweDAwMDAwMDAwZGU3MDAwMDAtMHgwMDAwMDAwMGRlOWZmZmZmXQo+PiAg
wqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAwMDAwZTA4MDAwMDAtMHgwMDAwMDAwMGUwYmZmZmZm
XQo+PiAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAwMDAwZjRiMDAwMDAtMHgwMDAwMDAwMGY2
ZmZmZmZmXQo+PiAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAwMDAwZmRhMDAwMDAtMHgwMDAw
MDAwMGZmZmZlZmZmXQo+PiBaZXJvZWQgc3RydWN0IHBhZ2UgaW4gdW5hdmFpbGFibGUgcmFuZ2Vz
OiA1MTMgcGFnZXMKPj4gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21lbSAweDAwMDAwMDAwODBhMDAw
MDAtMHgwMDAwMDAwMGZmZmZlZmZmXQo+PiBPbiBub2RlIDAgdG90YWxwYWdlczogMzExNTUxCj4+
ICDCoCBOb3JtYWwgem9uZTogMTIzMCBwYWdlcyB1c2VkIGZvciBtZW1tYXAKPj4gIMKgIE5vcm1h
bCB6b25lOiAwIHBhZ2VzIHJlc2VydmVkCj4+ICDCoCBOb3JtYWwgem9uZTogMTU3NDQwIHBhZ2Vz
LCBMSUZPIGJhdGNoOjMxCj4+ICDCoCBIaWdoTWVtIHpvbmU6IDE1NDExMSBwYWdlcywgTElGTyBi
YXRjaDozMQo+IEFGQUlDVCB0aGUgcmFuZ2UgW2RlNjAwMDAwLCBkZTdmZjAwMF0gc2hvdWxkIG5v
dCBiZSBhZGRlZCB0byB0aGUgZnJlZQo+IGxpc3RzLgo+Cj4gQ2FuIHlvdSB0cnkgd2l0aCB0aGUg
YmVsb3cgcGF0Y2g6Cj4KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtYmxvY2suYyBiL21tL21lbWJsb2Nr
LmMKPiBpbmRleCBhZmFlZmE4ZmM2YWIuLjdmM2MzM2Q1M2Y4NyAxMDA2NDQKPiAtLS0gYS9tbS9t
ZW1ibG9jay5jCj4gKysrIGIvbW0vbWVtYmxvY2suYwo+IEBAIC0xOTk0LDYgKzE5OTQsOCBAQCBz
dGF0aWMgdW5zaWduZWQgbG9uZyBfX2luaXQgX19mcmVlX21lbW9yeV9jb3JlKHBoeXNfYWRkcl90
IHN0YXJ0LAo+ICAgCXVuc2lnbmVkIGxvbmcgZW5kX3BmbiA9IG1pbl90KHVuc2lnbmVkIGxvbmcs
Cj4gICAJCQkJICAgICAgUEZOX0RPV04oZW5kKSwgbWF4X2xvd19wZm4pOwo+ICAgCj4gKwlwcl9p
bmZvKCIlczogcmFuZ2U6ICVwYSAtICVwYSwgcGZuOiAlbHggLSAlbHhcbiIsIF9fZnVuY19fLCAm
c3RhcnQsICZlbmQsIHN0YXJ0X3BmbiwgZW5kX3Bmbik7Cj4gKwo+ICAgCWlmIChzdGFydF9wZm4g
Pj0gZW5kX3BmbikKPiAgIAkJcmV0dXJuIDA7Cj4gICAKX19mcmVlX21lbW9yeV9jb3JlLCByYW5n
ZTogMHg4MGEwMzAwMCAtIDB4ODBhMDQwMDAsIHBmbjogODBhMDMgLSA4MGEwNApfX2ZyZWVfbWVt
b3J5X2NvcmUsIHJhbmdlOiAweDgwYTA4MDAwIC0gMHg4MGIwMDAwMCwgcGZuOiA4MGEwOCAtIDgw
YjAwCl9fZnJlZV9tZW1vcnlfY29yZSwgcmFuZ2U6IDB4ODEyZTgwNTggLSAweDgzMDAwMDAwLCBw
Zm46IDgxMmU5IC0gODMwMDAKX19mcmVlX21lbW9yeV9jb3JlLCByYW5nZTogMHg4NTAwMDAwMCAt
IDB4ODU2MDAwMDAsIHBmbjogODUwMDAgLSA4NTYwMApfX2ZyZWVfbWVtb3J5X2NvcmUsIHJhbmdl
OiAweDg2YTAwMDAwIC0gMHg4N2UwMDAwMCwgcGZuOiA4NmEwMCAtIDg3ZTAwCl9fZnJlZV9tZW1v
cnlfY29yZSwgcmFuZ2U6IDB4OGJkMDAwMDAgLSAweDhjNTAwMDAwLCBwZm46IDhiZDAwIC0gOGM1
MDAKX19mcmVlX21lbW9yeV9jb3JlLCByYW5nZTogMHg4ZTMwMDAwMCAtIDB4OGVkMDAwMDAsIHBm
bjogOGUzMDAgLSA4ZWQwMApfX2ZyZWVfbWVtb3J5X2NvcmUsIHJhbmdlOiAweDkwZDAwMDAwIC0g
MHhhZjJjMDAwMCwgcGZuOiA5MGQwMCAtIGFmMmMwCl9fZnJlZV9tZW1vcnlfY29yZSwgcmFuZ2U6
IDB4YWY0MzAwMDAgLSAweGFmNDU0MDAwLCBwZm46IGFmNDMwIC0gYWY0NTQKX19mcmVlX21lbW9y
eV9jb3JlLCByYW5nZTogMHhhZjUxMDAwMCAtIDB4YWY1NDYwMDAsIHBmbjogYWY1MTAgLSBhZjU0
NgpfX2ZyZWVfbWVtb3J5X2NvcmUsIHJhbmdlOiAweGFmNTYwMDAwIC0gMHhhZjU4MDAwMCwgcGZu
OiBhZjU2MCAtIGFmNTgwCl9fZnJlZV9tZW1vcnlfY29yZSwgcmFuZ2U6IDB4YWZkOTgwMDAgLSAw
eGFmZGNlMDAwLCBwZm46IGFmZDk4IC0gYWZkY2UKX19mcmVlX21lbW9yeV9jb3JlLCByYW5nZTog
MHhhZmRkODAwMCAtIDB4YWZlMDAwMDAsIHBmbjogYWZkZDggLSBhZmUwMApfX2ZyZWVfbWVtb3J5
X2NvcmUsIHJhbmdlOiAweGFmZTE4MDAwIC0gMHhhZmU4MDAwMCwgcGZuOiBhZmUxOCAtIGFmZTgw
Cl9fZnJlZV9tZW1vcnlfY29yZSwgcmFuZ2U6IDB4YWZlZTAwMDAgLSAweGFmZjAwMDAwLCBwZm46
IGFmZWUwIC0gYWZmMDAKX19mcmVlX21lbW9yeV9jb3JlLCByYW5nZTogMHhhZmY4MDAwMCAtIDB4
YWZmOGQwMDAsIHBmbjogYWZmODAgLSBhZmY4ZApfX2ZyZWVfbWVtb3J5X2NvcmUsIHJhbmdlOiAw
eGFmZmYyMDAwIC0gMHhhZmZmNDU4MCwgcGZuOiBhZmZmMiAtIGFmZmY0Cl9fZnJlZV9tZW1vcnlf
Y29yZSwgcmFuZ2U6IDB4YWZmZmUwMDAgLSAweGFmZmZlMGUwLCBwZm46IGFmZmZlIC0gYWZmZmUK
X19mcmVlX21lbW9yeV9jb3JlLCByYW5nZTogMHhhZmZmZTRmYyAtIDB4YWZmZmU1MDAsIHBmbjog
YWZmZmYgLSBhZmZmZQpfX2ZyZWVfbWVtb3J5X2NvcmUsIHJhbmdlOiAweGFmZmZlNmU0IC0gMHhh
ZmZmZTcwMCwgcGZuOiBhZmZmZiAtIGFmZmZlCl9fZnJlZV9tZW1vcnlfY29yZSwgcmFuZ2U6IDB4
YWZmZmU4ZGMgLSAweGFmZmZlOGUwLCBwZm46IGFmZmZmIC0gYWZmZmUKX19mcmVlX21lbW9yeV9j
b3JlLCByYW5nZTogMHhhZmZmZTk3MCAtIDB4YWZmZmU5ODAsIHBmbjogYWZmZmYgLSBhZmZmZQpf
X2ZyZWVfbWVtb3J5X2NvcmUsIHJhbmdlOiAweGFmZmZlOTkwIC0gMHhhZmZmZTlhMCwgcGZuOiBh
ZmZmZiAtIGFmZmZlCl9fZnJlZV9tZW1vcnlfY29yZSwgcmFuZ2U6IDB4YWZmZmU5YTQgLSAweGFm
ZmZlOWMwLCBwZm46IGFmZmZmIC0gYWZmZmUKX19mcmVlX21lbW9yeV9jb3JlLCByYW5nZTogMHhh
ZmZmZWI1NCAtIDB4YWZmZmViNjAsIHBmbjogYWZmZmYgLSBhZmZmZQpfX2ZyZWVfbWVtb3J5X2Nv
cmUsIHJhbmdlOiAweGFmZmZlY2Y0IC0gMHhhZmZmZWQwMCwgcGZuOiBhZmZmZiAtIGFmZmZlCl9f
ZnJlZV9tZW1vcnlfY29yZSwgcmFuZ2U6IDB4YWZmZmVmYzQgLSAweGFmZmZlZmQ4LCBwZm46IGFm
ZmZmIC0gYWZmZmUKX19mcmVlX21lbW9yeV9jb3JlLCByYW5nZTogMHhiMDIwMDAwMCAtIDB4YzAw
MDAwMDAsIHBmbjogYjAyMDAgLSBiMDIwMApfX2ZyZWVfbWVtb3J5X2NvcmUsIHJhbmdlOiAweGNj
MDAwMDAwIC0gMHhkY2EwMDAwMCwgcGZuOiBjYzAwMCAtIGIwMjAwCl9fZnJlZV9tZW1vcnlfY29y
ZSwgcmFuZ2U6IDB4ZGU3MDAwMDAgLSAweGRlYTAwMDAwLCBwZm46IGRlNzAwIC0gYjAyMDAKX19m
cmVlX21lbW9yeV9jb3JlLCByYW5nZTogMHhlMDgwMDAwMCAtIDB4ZTBjMDAwMDAsIHBmbjogZTA4
MDAgLSBiMDIwMApfX2ZyZWVfbWVtb3J5X2NvcmUsIHJhbmdlOiAweGY0YjAwMDAwIC0gMHhmNzAw
MDAwMCwgcGZuOiBmNGIwMCAtIGIwMjAwCl9fZnJlZV9tZW1vcnlfY29yZSwgcmFuZ2U6IDB4ZmRh
MDAwMDAgLSAweGZmZmZmZmZmLCBwZm46IGZkYTAwIC0gYjAyMDAKCj4gICAKPj4+PiBbPGMwMjM5
OTljPl0gKGdldF9wYWdlX2Zyb21fZnJlZWxpc3QpIGZyb20gWzxjMDIzYTRkYz5dIChfX2FsbG9j
X3BhZ2VzX25vZGVtYXNrKzB4MTg4LzB4YzA4KQo+Pj4+IFs8YzAyM2E0ZGM+XSAoX19hbGxvY19w
YWdlc19ub2RlbWFzaykgZnJvbSBbPGMwMjIzMDc4Pl0gKGFsbG9jX3plcm9lZF91c2VyX2hpZ2hw
YWdlX21vdmFibGUrMHgxNC8weDNjKQo+Pj4+IFs8YzAyMjMwNzg+XSAoYWxsb2NfemVyb2VkX3Vz
ZXJfaGlnaHBhZ2VfbW92YWJsZSkgZnJvbSBbPGMwMjI2NzY4Pl0gKGhhbmRsZV9tbV9mYXVsdCsw
eDI1NC8weGFjOCkKPj4+PiBbPGMwMjI2NzY4Pl0gKGhhbmRsZV9tbV9mYXVsdCkgZnJvbSBbPGMw
NGJhMDljPl0gKGRvX3BhZ2VfZmF1bHQrMHgyMjgvMHgyZjQpCj4+Pj4gWzxjMDRiYTA5Yz5dIChk
b19wYWdlX2ZhdWx0KSBmcm9tIFs8YzAxMTFkODA+XSAoZG9fRGF0YUFib3J0KzB4NDgvMHhkMCkK
Pj4+PiBbPGMwMTExZDgwPl0gKGRvX0RhdGFBYm9ydCkgZnJvbSBbPGMwMTAwZTAwPl0gKF9fZGFi
dF91c3IrMHg0MC8weDYwKQo+Pj4+Cj4+Pj4gICAgICAgICAgIFpvbmUgcmFuZ2VzOgo+Pj4+ICAg
ICAgICAgICDCoCBOb3JtYWzCoMKgIFttZW0gMHgwMDAwMDAwMDgwYTAwMDAwLTB4MDAwMDAwMDBi
MDFmZmZmZl0KPj4+PiAgICAgICAgICAgwqAgSGlnaE1lbcKgIFttZW0gMHgwMDAwMDAwMGIwMjAw
MDAwLTB4MDAwMDAwMDBmZmZmZWZmZl0KPj4+PiAgICAgICAgICAgTW92YWJsZSB6b25lIHN0YXJ0
IGZvciBlYWNoIG5vZGUKPj4+PiAgICAgICAgICAgRWFybHkgbWVtb3J5IG5vZGUgcmFuZ2VzCj4+
Pj4gICAgICAgICAgIMKgIG5vZGXCoMKgIDA6IFttZW0gMHgwMDAwMDAwMDgwYTAwMDAwLTB4MDAw
MDAwMDA4NTVmZmZmZl0KPj4+PiAgICAgICAgICAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAw
MDAwODZhMDAwMDAtMHgwMDAwMDAwMDg3ZGZmZmZmXQo+Pj4+ICAgICAgICAgICDCoCBub2RlwqDC
oCAwOiBbbWVtIDB4MDAwMDAwMDA4YmQwMDAwMC0weDAwMDAwMDAwOGM0ZmZmZmZdCj4+Pj4gICAg
ICAgICAgIMKgIG5vZGXCoMKgIDA6IFttZW0gMHgwMDAwMDAwMDhlMzAwMDAwLTB4MDAwMDAwMDA4
ZWNmZmZmZl0KPj4+PiAgICAgICAgICAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAwMDAwOTBk
MDAwMDAtMHgwMDAwMDAwMGJmZmZmZmZmXQo+Pj4+ICAgICAgICAgICDCoCBub2RlwqDCoCAwOiBb
bWVtIDB4MDAwMDAwMDBjYzAwMDAwMC0weDAwMDAwMDAwZGM5ZmZmZmZdCj4+Pj4gICAgICAgICAg
IMKgIG5vZGXCoMKgIDA6IFttZW0gMHgwMDAwMDAwMGRlNzAwMDAwLTB4MDAwMDAwMDBkZTlmZmZm
Zl0KPj4+PiAgICAgICAgICAgwqAgbm9kZcKgwqAgMDogW21lbSAweDAwMDAwMDAwZTA4MDAwMDAt
MHgwMDAwMDAwMGUwYmZmZmZmXQo+Pj4+ICAgICAgICAgICDCoCBub2RlwqDCoCAwOiBbbWVtIDB4
MDAwMDAwMDBmNGIwMDAwMC0weDAwMDAwMDAwZjZmZmZmZmZdCj4+Pj4gICAgICAgICAgIMKgIG5v
ZGXCoMKgIDA6IFttZW0gMHgwMDAwMDAwMGZkYTAwMDAwLTB4MDAwMDAwMDBmZmZmZWZmZl0KPj4+
Pgo+Pj4+ICAgICAgICAgICAtLS0tPiBmcmVlX21lbW1hcCwgc3RhcnRfcGZuID0gODU4MDAswqAg
ODU4MDAwMDAgZW5kX3BmbiA9IDg2YTAwLCA4NmEwMDAwMAo+Pj4+ICAgICAgICAgICAtLS0tPiBm
cmVlX21lbW1hcCwgc3RhcnRfcGZuID0gOGM4MDAswqAgOGM4MDAwMDAgZW5kX3BmbiA9IDhlMzAw
LCA4ZTMwMDAwMAo+Pj4+ICAgICAgICAgICAtLS0tPiBmcmVlX21lbW1hcCwgc3RhcnRfcGZuID0g
OGYwMDAswqAgOGYwMDAwMDAgZW5kX3BmbiA9IDkwMDAwLCA5MDAwMDAwMAo+Pj4+ICAgICAgICAg
ICAtLS0tPiBmcmVlX21lbW1hcCwgc3RhcnRfcGZuID0gZGNjMDAswqAgZGNjMDAwMDAgZW5kX3Bm
biA9IGRlNzAwLCBkZTcwMDAwMAo+Pj4+ICAgICAgICAgICAtLS0tPiBmcmVlX21lbW1hcCwgc3Rh
cnRfcGZuID0gZGVjMDAswqAgZGVjMDAwMDAgZW5kX3BmbiA9IGUwMDAwLCBlMDAwMDAwMAo+Pj4+
ICAgICAgICAgICAtLS0tPiBmcmVlX21lbW1hcCwgc3RhcnRfcGZuID0gZTBjMDAswqAgZTBjMDAw
MDAgZW5kX3BmbiA9IGU0MDAwLCBlNDAwMDAwMAo+Pj4+ICAgICAgICAgICAtLS0tPiBmcmVlX21l
bW1hcCwgc3RhcnRfcGZuID0gZjcwMDAswqAgZjcwMDAwMDAgZW5kX3BmbiA9IGY4MDAwLCBmODAw
MDAwMAo+Pj4+ICAgICAgICAgICA9PT0gPm1vdmVfZnJlZXBhZ2VzOiBzdGFydF9wZm4vZW5kX3Bm
biBbZGU2MDEsIGRlN2ZmXSwgW2RlNjAwMDAwLCBkZTdmZjAwMF0KPj4+PiAgICAgICAgICAgOsKg
IHBmbiA9ZGU2MDAgcGZuMnBoeSA9IGRlNjAwMDAwICwgcGFnZSA9IGVmM2NjMDAwLCBwYWdlLWZs
YWdzID0gZmZmZmZmZmYKPj4+PiAgICAgICAgICAgODwtLS0gY3V0IGhlcmUgLS0tCj4+Pj4gICAg
ICAgICAgIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwg
YWRkcmVzcyBmZmZmZmZmZQo+Pj4+ICAgICAgICAgICBwZ2QgPSA1ZGQ1MGRmNQo+Pj4+ICAgICAg
ICAgICBbZmZmZmZmZmVdICpwZ2Q9YWZmZmY4NjEsICpwdGU9MDAwMDAwMDAsICpwcHRlPTAwMDAw
MDAwCj4+Pj4gICAgICAgICAgIEludGVybmFsIGVycm9yOiBPb3BzOiAzNyBbIzFdIFNNUCBBUk0K
Pj4+PiAgICAgICAgICAgTW9kdWxlcyBsaW5rZWQgaW46IGdtYWMoTykKPj4+PiAgICAgICAgICAg
Q1BVOiAyIFBJRDogNjM1IENvbW06IHRlc3Qtb29tIFRhaW50ZWQ6IEfCoMKgwqDCoMKgwqDCoMKg
wqDCoCBPwqDCoMKgwqDCoCA1LjEwLjArICMzMQo+Pj4+ICAgICAgICAgICBIYXJkd2FyZSBuYW1l
OiBIaXNpbGljb24gQTkKPj4+PiAgICAgICAgICAgUEMgaXMgYXQgbW92ZV9mcmVlcGFnZXNfYmxv
Y2srMHgxNTAvMHgyNzgKPj4+PiAgICAgICAgICAgTFIgaXMgYXQgbW92ZV9mcmVlcGFnZXNfYmxv
Y2srMHgxNTAvMHgyNzgKPj4+PiAgICAgICAgICAgcGMgOiBbPGMwMjM4M2E0Pl3CoMKgwqAgbHIg
OiBbPGMwMjM4M2E0Pl3CoMKgwqAgcHNyOiAyMDBlMDM5Mwo+Pj4+ICAgICAgICAgICBzcCA6IGM0
MTc5Y2Y4wqAgaXAgOiAwMDAwMDAwMMKgIGZwIDogMDAwMDAwMDEKPj4+PiAgICAgICAgICAgcjEw
OiBjNDE3OWQ1OMKgIHI5IDogMDAwZGU3ZmbCoCByOCA6IDAwMDAwMDAwCj4+Pj4gICAgICAgICAg
IHI3IDogYzA4NjMyODDCoCByNiA6IDAwMGRlNjAwwqAgcjUgOiAwMDBkZTYwMMKgIHI0IDogZWYz
Y2MwMDAKPj4+PiAgICAgICAgICAgcjMgOiBmZmZmZmZmZsKgIHIyIDogMDAwMDAwMDDCoCByMSA6
IGVmNWQwNjljwqAgcjAgOiBmZmZmZmZmZQo+Pj4+ICAgICAgICAgICBGbGFnczogbnpDdsKgIElS
UXMgb2ZmwqAgRklRcyBvbsKgIE1vZGUgU1ZDXzMywqAgSVNBIEFSTcKgIFNlZ21lbnQgdXNlcgo+
Pj4+ICAgICAgICAgICBDb250cm9sOiAxYWM1Mzg3ZMKgIFRhYmxlOiA4M2IwYzA0YcKgIERBQzog
NTU1NTU1NTUKPj4+PiAgICAgICAgICAgUHJvY2VzcyB0ZXN0LW9vbSAocGlkOiA2MzUsIHN0YWNr
IGxpbWl0ID0gMHgyNWQ2NjdkZikKPj4+Pgo+Pj4+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNz
LmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3Rp
bmZvL2t2bWFybQo=
