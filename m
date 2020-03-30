Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 85ACC19781D
	for <lists+kvmarm@lfdr.de>; Mon, 30 Mar 2020 11:56:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 040A04B261;
	Mon, 30 Mar 2020 05:56:21 -0400 (EDT)
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
	with ESMTP id F+8rTBjrs8+C; Mon, 30 Mar 2020 05:56:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DE6E14B1D6;
	Mon, 30 Mar 2020 05:56:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CD6DD4B1B9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 05:56:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SLd-OVS8gvI1 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Mar 2020 05:56:16 -0400 (EDT)
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E90934B1B4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 05:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585562176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+i48u5EVTvTZXlAFzW/M3AOj4ZvswK4iw2XDLheQWkE=;
 b=SHfHlPyaQRbcqbGJt78LlBXMXUe43GOiaXXDHKZDQWnxbFl8cGB7Z4oOC2k6MJS88FmkCz
 KT5MWt24qOPAhC5PzJsfm0UudmxCUBqk7SBhwyMzZLEhGjEV2u3cwvw7rH6Knd4Is9EuEA
 ciVRCd3aYHYRJ1fYbxLuDKA2XW7ScBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-jk6K2iO_ORCgrkaHNScO6Q-1; Mon, 30 Mar 2020 05:56:12 -0400
X-MC-Unique: jk6K2iO_ORCgrkaHNScO6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B4E7801E53;
 Mon, 30 Mar 2020 09:56:10 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA160953D6;
 Mon, 30 Mar 2020 09:56:04 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v7 06/13] arm/arm64: ITS: Introspection
 tests
To: Andrew Jones <drjones@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-7-eric.auger@redhat.com>
 <947a79f5-1f79-532b-9ec7-6fd539ccd183@huawei.com>
 <8878be7f-7653-b427-cd0d-722f82fb6b65@redhat.com>
 <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7d6dc4e7-82b4-3c54-574f-2149d4a85c48@redhat.com>
Date: Mon, 30 Mar 2020 11:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: thuth@redhat.com, kvm@vger.kernel.org, maz@kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, andre.przywara@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

SGksCgpPbiAzLzMwLzIwIDExOjExIEFNLCBBbmRyZXcgSm9uZXMgd3JvdGU6Cj4gT24gTW9uLCBN
YXIgMzAsIDIwMjAgYXQgMTA6NDY6NTdBTSArMDIwMCwgQXVnZXIgRXJpYyB3cm90ZToKPj4gSGkg
WmVuZ2h1aSwKPj4KPj4gT24gMy8zMC8yMCAxMDozMCBBTSwgWmVuZ2h1aSBZdSB3cm90ZToKPj4+
IEhpIEVyaWMsCj4+Pgo+Pj4gT24gMjAyMC8zLzIwIDE3OjI0LCBFcmljIEF1Z2VyIHdyb3RlOgo+
Pj4+ICtzdGF0aWMgdm9pZCBpdHNfY21kX3F1ZXVlX2luaXQodm9pZCkKPj4+PiArewo+Pj4+ICvC
oMKgwqAgdW5zaWduZWQgbG9uZyBvcmRlciA9IGdldF9vcmRlcihTWl82NEsgPj4gUEFHRV9TSElG
VCk7Cj4+Pj4gK8KgwqDCoCB1NjQgY2Jhc2VyOwo+Pj4+ICsKPj4+PiArwqDCoMKgIGl0c19kYXRh
LmNtZF9iYXNlID0gKHZvaWQgKil2aXJ0X3RvX3BoeXMoYWxsb2NfcGFnZXMob3JkZXIpKTsKPj4+
Cj4+PiBTaG91bGRuJ3QgdGhlIGNtZF9iYXNlIChhbmQgdGhlIGNtZF93cml0ZSkgYmUgc2V0IGFz
IGEgR1ZBPwo+PiB5ZXMgaXQgc2hvdWxkCj4gCj4gSWYgaXQncyBzdXBwb3NlZCB0byBiZSBhIHZp
cnR1YWwgYWRkcmVzcywgd2hlbiB3aHkgZG8gdGhlIHZpcnRfdG9fcGh5cz8KV2hhdCBpcyBwcm9n
cmFtbWVkIGluIENCQVNFUiByZWdpc3RlciBpcyBhIHBoeXNpY2FsIGFkZHJlc3MuIFNvIHRoZQp2
aXJ0X3RvX3BoeXMoKSBpcyByZWxldmFudC4gVGhlIGluY29uc2lzdGVuY3kgaXMgaW4gaXRzX2Fs
bG9jYXRlX2VudHJ5KCkKaW50cm9kdWNlZCBsYXRlciBvbiB3aGVyZSBJIHJldHVybiB0aGUgcGh5
c2ljYWwgYWRkcmVzcyBpbnN0ZWFkIG9mIHRoZQp2aXJ0dWFsIGFkZHJlc3MuIEkgd2lsbCBmaXgg
dGhhdC4KCgo+IAo+Pj4KPj4+IE90aGVyd2lzZSBJIHRoaW5rIHdlIHdpbGwgZW5kLXVwIHdpdGgg
bWVtb3J5IGNvcnJ1cHRpb24gd2hlbiB3cml0aW5nCj4+PiB0aGUgY29tbWFuZCBxdWV1ZS7CoCBC
dXQgaXQgc2VlbXMgdGhhdCBldmVyeXRoaW5nIGp1c3Qgd29ya3MgZmluZSAuLi4KPj4+IFNvIEkn
bSByZWFsbHkgY29uZnVzZWQgaGVyZSA6LS8KPj4gSSB3YXMgdG9sZCBieSBQYW9sbyB0aGF0IHRo
ZSBWQS9QQSBtZW1vcnkgbWFwIGlzIGZsYXQgaW4ga3ZtdW5pdCB0ZXN0Lgo+IAo+IFdoYXQgZG9l
cyBmbGF0IG1lYW4/CgpZZXMgSSBtZWFudCBhbiBpZGVudGl0eSBtYXAuCgoga3ZtLXVuaXQtdGVz
dHMsIGF0IGxlYXN0IGFybS9hcm02NCwgZG9lcyBwcmVwYXJlCj4gYW4gaWRlbnRpdHkgbWFwIG9m
IGFsbCBwaHlzaWNhbCBtZW1vcnksIHdoaWNoIGV4cGxhaW5zIHdoeSB0aGUgYWJvdmUKPiBpcyB3
b3JraW5nLgoKc2hvdWxkIGJlIHRoZSBzYW1lIG9uIHg4NgoKIEl0J3MgZG9pbmcgdmlydF90b19w
aHlzKHNvbWUtdmlydC1hZGRyKSwgd2hpY2ggZ2V0cyBhCj4gcGh5cyBhZGRyLCBidXQgd2hlbiB0
aGUgSVRTIHVzZXMgaXQgYXMgYSB2aXJ0IGFkZHIgaXQgd29ya3MgYmVjYXVzZQo+IHdlICphbHNv
KiBoYXZlIGEgdmlydCBhZGRyID09IHBoeXMgYWRkciBtYXBwaW5nIGluIHRoZSBkZWZhdWx0IHBh
Z2UKPiB0YWJsZSwgd2hpY2ggaXMgbmFtZWQgImlkbWFwIiBmb3IgZ29vZCByZWFzb24uCj4gCj4g
SSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdGVzdCB3aXRoIHRoZSBub24taWRlbnRpdHkg
bWFwcGVkIGFkZHJlc3Nlcwo+IHRob3VnaC4KCmlzIHRoZXJlIGFueSB3YXkgdG8gZXhlcmNpc2Ug
YSBub24gaWRtYXA/CgpUaGFua3MKCkVyaWMKPiAKPiBUaGFua3MsCj4gZHJldwo+IAo+Pgo+Pj4K
Pj4+PiArCj4+Pj4gK8KgwqDCoCBjYmFzZXIgPSAoKHU2NClpdHNfZGF0YS5jbWRfYmFzZSB8IChT
Wl82NEsgLyBTWl80SyAtIDEpwqDCoMKgIHwKPj4+PiBHSVRTX0NCQVNFUl9WQUxJRCk7Cj4+Pj4g
Kwo+Pj4+ICvCoMKgwqAgd3JpdGVxKGNiYXNlciwgaXRzX2RhdGEuYmFzZSArIEdJVFNfQ0JBU0VS
KTsKPj4+PiArCj4+Pj4gK8KgwqDCoCBpdHNfZGF0YS5jbWRfd3JpdGUgPSBpdHNfZGF0YS5jbWRf
YmFzZTsKPj4+PiArwqDCoMKgIHdyaXRlcSgwLCBpdHNfZGF0YS5iYXNlICsgR0lUU19DV1JJVEVS
KTsKPj4+PiArfQo+Pj4KPj4+IE90aGVyd2lzZSB0aGlzIGxvb2tzIGdvb2QsCj4+PiBSZXZpZXdl
ZC1ieTogWmVuZ2h1aSBZdSA8eXV6ZW5naHVpQGh1YXdlaS5jb20+Cj4+IFRoYW5rcyEKPj4KPj4g
RXJpYwo+Pj4KPj4+Cj4+PiBUaGFua3MKPj4+Cj4+Cj4+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0
cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9s
aXN0aW5mby9rdm1hcm0K
