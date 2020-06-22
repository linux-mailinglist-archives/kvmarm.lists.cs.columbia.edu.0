Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFA8203227
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jun 2020 10:35:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 027494B0B8;
	Mon, 22 Jun 2020 04:35:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q2a-MpGx5SFY; Mon, 22 Jun 2020 04:35:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C66AC4B0B6;
	Mon, 22 Jun 2020 04:35:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 56DD54B080
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 04:35:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tt+9U-mh8UbT for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jun 2020 04:35:13 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 877F54A551
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jun 2020 04:35:13 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E5851FB;
 Mon, 22 Jun 2020 01:35:13 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55C233F6CF;
 Mon, 22 Jun 2020 01:35:12 -0700 (PDT)
Subject: Re: [PATCH 2/4] arm64/x86: KVM: Introduce steal time cap
To: Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>
References: <20200619184629.58653-1-drjones@redhat.com>
 <20200619184629.58653-3-drjones@redhat.com>
 <5b1e895dc0c80bef3c0653894e2358cf@kernel.org>
From: Steven Price <steven.price@arm.com>
Message-ID: <b11baec8-10f2-f389-ab8d-16224e9525a4@arm.com>
Date: Mon, 22 Jun 2020 09:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5b1e895dc0c80bef3c0653894e2358cf@kernel.org>
Content-Language: en-GB
Cc: pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

T24gMjIvMDYvMjAyMCAwOToyMCwgTWFyYyBaeW5naWVyIHdyb3RlOgo+IEhpIEFuZHJldywKPiAK
PiBPbiAyMDIwLTA2LTE5IDE5OjQ2LCBBbmRyZXcgSm9uZXMgd3JvdGU6ClsuLi5dCj4+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmggYi9pbmNsdWRlL3VhcGkvbGludXgva3Zt
LmgKPj4gaW5kZXggNGZkZjMwMzE2NTgyLi4xMjFmYjI5YWMwMDQgMTAwNjQ0Cj4+IC0tLSBhL2lu
Y2x1ZGUvdWFwaS9saW51eC9rdm0uaAo+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtLmgK
Pj4gQEAgLTEwMzEsNiArMTAzMSw3IEBAIHN0cnVjdCBrdm1fcHBjX3Jlc2l6ZV9ocHQgewo+PiDC
oCNkZWZpbmUgS1ZNX0NBUF9QUENfU0VDVVJFX0dVRVNUIDE4MQo+PiDCoCNkZWZpbmUgS1ZNX0NB
UF9IQUxUX1BPTEwgMTgyCj4+IMKgI2RlZmluZSBLVk1fQ0FQX0FTWU5DX1BGX0lOVCAxODMKPj4g
KyNkZWZpbmUgS1ZNX0NBUF9TVEVBTF9USU1FIDE4NAo+Pgo+PiDCoCNpZmRlZiBLVk1fQ0FQX0lS
UV9ST1VUSU5HCj4gCj4gU2hvdWxkbid0IHlvdSBhbHNvIGFkZCB0aGUgc2FtZSBjaGVjayBvZiBz
Y2hlZF9pbmZvX29uKCkgdG8KPiB0aGUgdmFyaW91cyBwdnRpbWUgYXR0cmlidXRlIGhhbmRsaW5n
IGZ1bmN0aW9ucz8gSXQgZmVlbHMgb2RkCj4gdGhhdCB0aGUgY2FwYWJpbGl0eSBjYW4gc2F5ICJu
byIsIGFuZCB5ZXQgd2UnZCBhY2NlcHQgdXNlcnNwYWNlCj4gbWVzc2luZyB3aXRoIHRoZSBzdGVh
bCB0aW1lIHBhcmFtZXRlcnMuLi4KCk15IHRob3VnaHQgd2FzIHRoYXQgdG8gc29tZSBleHRlbnQg
dGhlIHR3byBhcmUgc2VwYXJhdGUuIApLVk1fQ0FQX1NURUFMX1RJTUUgaXMgIndlIGhhdmUgc3Rv
bGVuIHRpbWUgX0FORF8gaXQgcmV0dXJucyBtZWFuaW5nZnVsIApudW1iZXJzIiwgS1ZNX0hBU19E
RVZJQ0VfQVRUUihLVk1fQVJNX1ZDUFVfUFZUSU1FX0lQQSkgaXMgCih1bmZvcnR1bmF0ZWx5KSAi
d2UgaGF2ZSB0aGUgc3RvbGVuIGludGVyZmFjZSwgYnV0IGl0IG1pZ2h0IG5vdCBzaG93IGhvdyAK
bXVjaCB0aW1lIGlzIHN0b2xlbiIuIFJlc3RvcmluZyBhIFZNIG9uIGEgaG9zdCB3aXRoIFZDUFVf
UFZUSU1FX0lQQSBidXQgCndpdGhvdXQgS1ZNX0NBUF9TVEVBTF9USU1FIGlzIHBvc3NpYmxlIGp1
c3Qgd29uJ3QgcHJvdmlkZSBhbnkgc3RvbGVuIAp0aW1lIGRhdGEgKHRoZSBTTUMgY2FsbHMgd2ls
bCBzdGlsbCB3b3JrIGFuZCB0aGUgZGF0YSBmb3JtYXQgaXMgdmFsaWQpLgoKT2J2aW91c2x5IHdp
dGggaGluZHNpZ2h0IEkgd291bGQgaGF2ZSBkb25lIHRoaXMgZGlmZmVyZW50bHkuLi4KClN0ZXZl
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBt
YWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNz
LmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
