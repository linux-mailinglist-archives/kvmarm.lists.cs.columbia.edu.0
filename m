Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BD9991AAE61
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 18:36:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5038A4B24E;
	Wed, 15 Apr 2020 12:36:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HMn49tGRypmy; Wed, 15 Apr 2020 12:36:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D54064B116;
	Wed, 15 Apr 2020 12:36:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 81B5A4B219
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 12:36:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ES4qKlE3ndLW for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 12:36:14 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A1AA24B24B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 12:36:14 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282DD1FB;
 Wed, 15 Apr 2020 09:36:14 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67313F6C4;
 Wed, 15 Apr 2020 09:36:12 -0700 (PDT)
Subject: Re: [PATCH kvmtool v3] Add emulation for CFI compatible flash memory
To: Ard Biesheuvel <ardb@kernel.org>
References: <20200221165532.90618-1-andre.przywara@arm.com>
 <2d3bad43-10a5-3ee1-72e7-e1da1d6c65dd@arm.com>
 <CAMj1kXGUiCLvmJUwrxCc8aHdE30WWfa95ou-tEM8Kv0nj2GdDA@mail.gmail.com>
 <CAMj1kXF6iw47MM_tg5izB9KC-N2zrnQbhwT2TVPOuKdpOBX=ow@mail.gmail.com>
 <d9ae6d29-c2c5-6aa7-15b6-6549fc89c043@arm.com>
 <CAMj1kXHKOBbCKsgYOYuLU+vOALBUbNRysVfVRpKXkh00GvTtEA@mail.gmail.com>
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <32355204-30b1-4615-0d08-b484f0340e82@arm.com>
Date: Wed, 15 Apr 2020 17:35:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHKOBbCKsgYOYuLU+vOALBUbNRysVfVRpKXkh00GvTtEA@mail.gmail.com>
Content-Language: en-US
Cc: kvm@vger.kernel.org, Raphael Gault <raphael.gault@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, sami.mujawar@arm.com,
 Will Deacon <will@kernel.org>, kvmarm <kvmarm@lists.cs.columbia.edu>
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

T24gMTUvMDQvMjAyMCAxNzoyMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gT24gV2VkLCAxNSBB
cHIgMjAyMCBhdCAxODoxMSwgQW5kcsOpIFByenl3YXJhIDxhbmRyZS5wcnp5d2FyYUBhcm0uY29t
PiB3cm90ZToKPj4KPj4gT24gMTUvMDQvMjAyMCAxNjo1NSwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6
Cj4+PiBPbiBXZWQsIDE1IEFwciAyMDIwIGF0IDE3OjQzLCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToKPj4+Pgo+Pj4+IE9uIFR1ZSwgNyBBcHIgMjAyMCBhdCAxNzoxNSwg
QWxleGFuZHJ1IEVsaXNlaSA8YWxleGFuZHJ1LmVsaXNlaUBhcm0uY29tPiB3cm90ZToKPj4+Pj4K
Pj4+Pj4gSGksCj4+Pj4+Cj4+Pj4+IEkndmUgdGVzdGVkIHRoaXMgcGF0Y2ggYnkgcnVubmluZyBi
YWRibG9ja3MgYW5kIGZpbyBvbiBhIGZsYXNoIGRldmljZSBpbnNpZGUgYQo+Pj4+PiBndWVzdCwg
ZXZlcnl0aGluZyB3b3JrZWQgYXMgZXhwZWN0ZWQuCj4+Pj4+Cj4+Pj4+IEkndmUgYWxzbyBsb29r
ZWQgYXQgdGhlIGZsb3djaGFydHMgZm9yIGRldmljZSBvcGVyYXRpb24gZnJvbSBJbnRlbCBBcHBs
aWNhdGlvbgo+Pj4+PiBOb3RlIDY0NiwgcGFnZXMgMTItMjEsIGFuZCB0aGV5IHNlZW0gaW1wbGVt
ZW50ZWQgY29ycmVjdGx5Lgo+Pj4+Pgo+Pj4+PiBBIGZldyBtaW5vciBpc3N1ZXMgYmVsb3cuCj4+
Pj4+Cj4+Pj4+IE9uIDIvMjEvMjAgNDo1NSBQTSwgQW5kcmUgUHJ6eXdhcmEgd3JvdGU6Cj4+Pj4+
PiBGcm9tOiBSYXBoYWVsIEdhdWx0IDxyYXBoYWVsLmdhdWx0QGFybS5jb20+Cj4+Pj4+Pgo+Pj4+
Pj4gVGhlIEVESyBJSSBVRUZJIGZpcm13YXJlIGltcGxlbWVudGF0aW9uIHJlcXVpcmVzIHNvbWUg
c3RvcmFnZSBmb3IgdGhlIEVGSQo+Pj4+Pj4gdmFyaWFibGVzLCB3aGljaCBpcyB0eXBpY2FsbHkg
c29tZSBmbGFzaCBzdG9yYWdlLgo+Pj4+Pj4gU2luY2UgdGhpcyBpcyBhbHJlYWR5IHN1cHBvcnRl
ZCBvbiB0aGUgRURLIElJIHNpZGUsIHdlIGFkZCBhIENGSSBmbGFzaAo+Pj4+Pj4gZW11bGF0aW9u
IHRvIGt2bXRvb2wuCj4+Pj4+PiBUaGlzIGlzIGJhY2tlZCBieSBhIGZpbGUsIHNwZWNpZmllZCB2
aWEgdGhlIC0tZmxhc2ggb3IgLUYgY29tbWFuZCBsaW5lCj4+Pj4+PiBvcHRpb24uIEFueSBmbGFz
aCB3cml0ZXMgZG9uZSBieSB0aGUgZ3Vlc3Qgd2lsbCBpbW1lZGlhdGVseSBiZSByZWZsZWN0ZWQK
Pj4+Pj4+IGludG8gdGhpcyBmaWxlIChrdm10b29sIG1tYXAncyB0aGUgZmlsZSkuCj4+Pj4+PiBU
aGUgZmxhc2ggd2lsbCBiZSBsaW1pdGVkIHRvIHRoZSBuZWFyZXN0IHBvd2VyLW9mLTIgc2l6ZSwg
c28gb25seSB0aGUKPj4+Pj4+IGZpcnN0IDIgTUIgb2YgYSAzIE1CIGZpbGUgd2lsbCBiZSB1c2Vk
Lgo+Pj4+Pj4KPj4+Pj4+IFRoaXMgaW1wbGVtZW50cyBhIENGSSBmbGFzaCB1c2luZyB0aGUgIklu
dGVsL1NoYXJwIGV4dGVuZGVkIGNvbW1hbmQKPj4+Pj4+IHNldCIsIGFzIHNwZWNpZmllZCBpbjoK
Pj4+Pj4+IC0gSkVERUMgSkVTRDY4LjAxCj4+Pj4+PiAtIEpFREVDIEpFUDEzN0IKPj4+Pj4+IC0g
SW50ZWwgQXBwbGljYXRpb24gTm90ZSA2NDYKPj4+Pj4+IFNvbWUgZ2FwcyBpbiB0aG9zZSBzcGVj
cyBoYXZlIGJlZW4gZmlsbGVkIGJ5IGxvb2tpbmcgYXQgcmVhbCBkZXZpY2VzIGFuZAo+Pj4+Pj4g
b3RoZXIgaW1wbGVtZW50YXRpb25zIChRRU1VLCBMaW51eCBrZXJuZWwgZHJpdmVyKS4KPj4+Pj4+
Cj4+Pj4+PiBBdCB0aGUgbW9tZW50IHRoaXMgcmVsaWVzIG9uIERUIHRvIGFkdmVydGlzZSB0aGUg
YmFzZSBhZGRyZXNzIG9mIHRoZQo+Pj4+Pj4gZmxhc2ggbWVtb3J5IChtYXBwZWQgaW50byB0aGUg
TU1JTyBhZGRyZXNzIHNwYWNlKSBhbmQgaXMgb25seSBlbmFibGVkCj4+Pj4+PiBmb3IgQVJNL0FS
TTY0LiBUaGUgZW11bGF0aW9uIGl0c2VsZiBpcyBhcmNoaXRlY3R1cmUgYWdub3N0aWMsIHRob3Vn
aC4KPj4+Pj4+Cj4+Pj4+PiBUaGlzIGlzIG9uZSBtaXNzaW5nIHBpZWNlIHRvd2FyZCBhIHdvcmtp
bmcgVUVGSSBib290IHdpdGgga3ZtdG9vbCBvbgo+Pj4+Pj4gQVJNIGd1ZXN0cywgdGhlIG90aGVy
IGlzIHRvIHByb3ZpZGUgd3JpdGFibGUgUENJIEJBUnMsIHdoaWNoIGlzIFdJUC4KPj4+Pj4+Cj4+
Pj4KPj4+PiBJIGhhdmUgZ2l2ZW4gdGhpcyBhIHNwaW4gd2l0aCBVRUZJIGJ1aWx0IGZvciBrdm10
b29sLCBhbmQgaXQgYXBwZWFycwo+Pj4+IHRvIGJlIHdvcmtpbmcgY29ycmVjdGx5LiBIb3dldmVy
LCBJIG5vdGljZWQgdGhhdCBpdCBpcyBpbnRvbGVyYWJseQo+Pj4+IHNsb3csIHdoaWNoIHNlZW1z
IHRvIGJlIGNhdXNlZCBieSB0aGUgZmFjdCB0aGF0IGJvdGggYXJyYXkgbW9kZSBhbmQKPj4+PiBj
b21tYW5kIG1vZGUgKG9yIHdoYXRldmVyIGl0IGlzIGNhbGxlZCBpbiB0aGUgQ0ZJIHNwZWMpIGFy
ZSBmdWxseQo+Pj4+IGVtdWxhdGVkLCB3aGVyZWFzIGluIHRoZSBRRU1VIGltcGxlbWVudGF0aW9u
IChmb3IgaW5zdGFuY2UpLCB0aGUKPj4+PiByZWdpb24gaXMgYWN0dWFsbHkgZXhwb3NlZCB0byB0
aGUgZ3Vlc3QgdXNpbmcgYSByZWFkLW9ubHkgS1ZNIG1lbXNsb3QKPj4+PiBpbiBhcnJheSBtb2Rl
LCBhbmQgc28gdGhlIHJlYWQgYWNjZXNzZXMgYXJlIG1hZGUgbmF0aXZlbHkuCj4+Pj4KPj4+PiBJ
dCBpcyBhbHNvIGNhdXNpbmcgcHJvYmxlbXMgaW4gdGhlIFVFRkkgaW1wbGVtZW50YXRpb24sIGFz
IHdlIGNhbiBubwo+Pj4+IGxvbmdlciB1c2UgdW5hbGlnbmVkIGFjY2Vzc2VzIHRvIHJlYWQgZnJv
bSB0aGUgcmVnaW9uLCB3aGljaCBpcwo+Pj4+IHNvbWV0aGluZyB0aGUgY29kZSBjdXJyZW50bHkg
cmVsaWVzIG9uIChhbmQgd2hpY2ggd29ya3MgZmluZSBvbiBhY3R1YWwKPj4+PiBoYXJkd2FyZSBh
cyBsb25nIGFzIHlvdSB1c2Ugbm9ybWFsIG5vbi1jYWNoZWFibGUgbWFwcGluZ3MpCj4+Pj4KPj4+
Cj4+PiBBY3R1YWxseSwgdGhlIGlzc3VlIGlzIG5vdCBhbGlnbm1lbnQuIFRoZSBpc3N1ZSBpcyB3
aXRoIGluc3RydWN0aW9ucwo+Pj4gd2l0aCBtdWx0aXBsZSBvdXRwdXRzLCB3aGljaCBtZWFucyB5
b3UgY2Fubm90IGRvIGFuIG9yZGluYXJ5IG1lbWNweSgpCj4+PiBmcm9tIHRoZSBOT1IgcmVnaW9u
IHVzaW5nIGxkcCBpbnN0cnVjdGlvbnMsIGFsaWduZWQgb3Igbm90Lgo+Pgo+PiBZZXMsIHdlIHRy
YWNlZCB0aGF0IGRvd24gdG8gYW4gImxkcmIgd2l0aCBwb3N0LWluYyIsIGluIHRoZSBtZW1jcHkg
Y29kZS4KPj4gTXkgc3VnZ2VzdGlvbiB3YXMgdG8gcHJvdmlkZSBhIHZlcnNpb24gb2YgbWVtY3B5
X3tmcm9tLHRvfV9pbygpLCBhcwo+PiBMaW51eCBkb2VzLCB3aGljaCBvbmx5IHVzZXMgTU1JTyBh
Y2Nlc3NvcnMgdG8gYXZvaWQgImZhbmN5IiBpbnN0cnVjdGlvbnMuCj4+Cj4gCj4gVGhhdCBpcyBw
b3NzaWJsZSwgYW5kIHRoZSBpbXBhY3Qgb24gdGhlIGNvZGUgaXMgbWFuYWdlYWJsZSwgZ2l2ZW4g
dGhlCj4gbW9kdWxhciBuYXR1cmUgb2YgRURLMi4KPiAKPj4gQmFjayBhdCB0aGlzIHBvaW50IEkg
d2FzIGNoYWxsZW5naW5nIHRoZSBpZGVhIG9mIGFjY2Vzc2luZyBhIGZsYXNoCj4+IGRldmljZSB3
aXRoIGEgbm9ybWFsIG1lbW9yeSBtYXBwaW5nLCBiZWNhdXNlIG9mIGl0IGZhaWxpbmcgd2hlbiBi
ZWluZyBpbgo+PiBzb21lIHF1ZXJ5IG1vZGUuIERvIHlvdSBrbm93IG9mIGFueSBiZXN0IHByYWN0
aWNlcyBmb3IgZmxhc2ggbWFwcGluZ3M/Cj4+IEFyZSB0d28gbWFwcGluZ3MgY29tbW9uPwo+Pgo+
IAo+IEluIHRoZSBRRU1VIHBvcnQgb2YgRURLMiwgd2UgdXNlIG5vcm1hbCBub24tY2FjaGVhYmxl
IGZvciB0aGUgZmlyc3QKPiBmbGFzaCBkZXZpY2UsIHdoaWNoIGNvbnRhaW5zIHRoZSBleGVjdXRh
YmxlIGltYWdlLCBhbmQgaXMgbm90Cj4gdXBkYXRhYmxlIGJ5IHRoZSBndWVzdC4gVGhlIHNlY29u
ZCBmbGFzaCBiYW5rIGlzIHVzZWQgZm9yIHRoZSB2YXJpYWJsZQo+IHN0b3JlLCBhbmQgaXMgYWN0
dWFsbHkgbWFwcGVkIGFzIGEgZGV2aWNlIGFsbCB0aGUgdGltZS4KPiAKPiBBbm90aGVyIHRoaW5n
IEkganVzdCByZWFsaXplZCBpcyB0aGF0IHlvdSBjYW5ub3QgZmV0Y2ggaW5zdHJ1Y3Rpb25zCj4g
ZnJvbSBhbiBlbXVsYXRlZCBmbGFzaCBkZXZpY2UgZWl0aGVyLCBzbyB0byBleGVjdXRlIGZyb20g
Tk9SIGZsYXNoLAo+IHlvdSB3aWxsIG5lZWQgYSB0cnVlIG1lbW9yeSBtYXBwaW5nIGFzIHdlbGwu
CgpXYWl0LCBkaWQgeW91IHB1dCB0aGUgd2hvbGUgb2YgRURLLTIgaW1hZ2UgaW4gdGhlIGZsYXNo
PyBNeSBhc3N1bXB0aW9uCihhbmQgdGVzdGluZykgd2FzIHRvIHVzZQoKJCBsa3ZtIHJ1biAtZiBL
Vk1UT09MX0VGSS5mZCAtLWZsYXNoIGp1c3RfdGhlX3ZhcmlhYmxlcy5pbWcKCkhlbmNlIG15IGln
bm9yYW5jZSBhYm91dCBwZXJmb3JtYW5jZSwgYmVjYXVzZSBpdCB3b3VsZCBqdXN0IGJlIGEgZmV3
CmJ5dGVzIHdyaXR0ZW4vcmVhZC4gLWYgbG9hZHMgdGhlIGZpcm13YXJlIGltYWdlIGludG8gZ3Vl
c3QgUkFNLgoKPiBTbyBpbiBzdW1tYXJ5LCBJIHRoaW5rIHRoZSBtb2RlIHN3aXRjaCBpcyBuZWVk
ZWQgdG8gYmUgZ2VuZXJhbGx5Cj4gdXNlZnVsLCBldmVuIGlmIHRoZSBjdXJyZW50IGFwcHJvYWNo
IGlzIHN1ZmZpY2llbnQgZm9yIChzbG93KQo+IHJlYWQvd3JpdGUgdXNpbmcgc3BlY2lhbCBtZW1v
cnkgYWNjZXNzb3JzLgoKV2VsbCxpbiBoaW5kc2lnaHQgSSByZWdyZXQgcHVyc3VpbmcgdGhpcyB3
aG9sZSBmbGFzaCBlbXVsYXRpb24gYXBwcm9hY2gKaW4ga3ZtdG9vbCBpbiB0aGUgZmlyc3QgcGxh
Y2UuIEp1c3Qgc29tZSBtYWdpYyAidGhpcyBtZW1vcnkgcmVnaW9uIGlzCnBlcnNpc3RlbnQiICht
bWFwcGluZyBhIGZpbGUgYW5kIHByZXNlbnRpbmcgYXMgYSBtZW1zbG90KSB3b3VsZCBiZQoqbXVj
aCogZWFzaWVyIG9uIHRoZSBrdm10b29sIHNpZGUuIEl0IGp1c3Qgc2VlbXMgdGhhdCB0aGVyZSB3
YXNuJ3QgYW55Cmdvb2QgRFQgYmluZGluZyBvciBleGlzdGluZyBkZXZpY2UgY2xhc3MgZm9yIHRo
aXMgKHRvIG15IHN1cnByaXNlKSwgb3IKYXQgbGVhc3Qgbm90IG9uZSB3aXRob3V0IGlzc3Vlcy4g
QW5kIHRoZW4gRURLLTIgaGFkIHRoaXMgQ0ZJIGZsYXNoCnN1cHBvcnQgYWxyZWFkeSwgc28gd2Ug
ZmlndXJlZCB0aGlzIHNob3VsZCBiZSB0aGUgd2F5IHRvIGdvLiBXZSBqdXN0Cm5lZWQgc29tZSBl
bXVsYXRpb24gY29kZSAuLi4gbW9udGhzIGxhdGVyIC4uLgoKU28gZG8geW91IGtub3cgb2Ygc29t
ZSBwZXJzaXN0ZW50IHN0b3JhZ2UgZGV2aWNlIHdlIGNvdWxkIHVzZT8gVGhpcwp3b3VsZCBjb21l
IGF0IHRoZSBjb3N0IG9mIGFkZGluZyBzdXBwb3J0IHRvIEVESy0yLCBidXQgSSBndWVzcyBpdCBz
aG91bGQKYmUgc3RyYWlnaHQtZm9yd2FyZCBnaXZlbiB0aGUgc2ltcGxlIHNlbWFudGljPwoKQ2hl
ZXJzLApBbmRyZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6
Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
