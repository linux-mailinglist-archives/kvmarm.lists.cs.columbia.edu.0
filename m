Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C45341603A2
	for <lists+kvmarm@lfdr.de>; Sun, 16 Feb 2020 11:41:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A1DE4AF42;
	Sun, 16 Feb 2020 05:41:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@c-s.fr
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cf+wDoVqulJN; Sun, 16 Feb 2020 05:41:17 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BA514AF00;
	Sun, 16 Feb 2020 05:41:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 40C144AEC6
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Feb 2020 05:41:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1pqQMtqqRMPc for <kvmarm@lists.cs.columbia.edu>;
 Sun, 16 Feb 2020 05:41:12 -0500 (EST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 077154AEBF
 for <kvmarm@lists.cs.columbia.edu>; Sun, 16 Feb 2020 05:41:12 -0500 (EST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48L3Yv0sRkz9tyM7;
 Sun, 16 Feb 2020 11:41:07 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=v+gbcEDk; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id WyvC_D0c5SGS; Sun, 16 Feb 2020 11:41:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48L3Yt6byhz9tyM6;
 Sun, 16 Feb 2020 11:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1581849666; bh=uYX8/YhQnPSB2yIUz2Iiabdy4hBMITqWSMKEeNzcsUE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=v+gbcEDki2kN7vHEJxzn4fWBIL7Q/3I+0FBhUByo9drALwmhlhMysLr6CcMG4Tb/X
 Z4bTovlfUg5KRdTCIWxMkP3mPM9tSoSf43EJfHHltAPtJWCtCrqKOA8Gx1u5xXKGgL
 NDEaCjEHzsYa4iDa+yCT8tNN28WzZnaXEMbkJvBY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D90528B784;
 Sun, 16 Feb 2020 11:41:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VGVzW0Ckh2uU; Sun, 16 Feb 2020 11:41:09 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B4E908B755;
 Sun, 16 Feb 2020 11:41:07 +0100 (CET)
Subject: Re: [PATCH v2 07/13] powerpc: add support for folded p4d page tables
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216081843.28670-8-rppt@kernel.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c79b363c-a111-389a-5752-51cf85fa8c44@c-s.fr>
Date: Sun, 16 Feb 2020 11:41:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200216081843.28670-8-rppt@kernel.org>
Content-Language: fr
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linux-hexagon@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Jonas Bonn <jonas@southpole.se>, linux-arch@vger.kernel.org,
 Brian Cain <bcain@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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

CgpMZSAxNi8wMi8yMDIwIMOgIDA5OjE4LCBNaWtlIFJhcG9wb3J0IGEgw6ljcml0wqA6Cj4gRnJv
bTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPgo+IAo+IEltcGxlbWVudCBwcmlt
aXRpdmVzIG5lY2Vzc2FyeSBmb3IgdGhlIDR0aCBsZXZlbCBmb2xkaW5nLCBhZGQgd2Fsa3Mgb2Yg
cDRkCj4gbGV2ZWwgd2hlcmUgYXBwcm9wcmlhdGUgYW5kIHJlcGxhY2UgNWxldmVsLWZpeHVwLmgg
d2l0aCBwZ3RhYmxlLW5vcDRkLmguCgpJIGRvbid0IHRoaW5rIGl0IGlzIHdvcnRoIGFkZGluZyBh
bGwgdGhpcyBhZGRpdGlvbm5hbHMgd2Fsa3Mgb2YgcDRkLCAKdGhpcyBwYXRjaCBjb3VsZCBiZSBs
aW1pdGVkIHRvIGNoYW5nZXMgbGlrZToKCi0JCXB1ZCA9IHB1ZF9vZmZzZXQocGdkLCBncGEpOwor
CQlwdWQgPSBwdWRfb2Zmc2V0KHA0ZF9vZmZzZXQocGdkLCBncGEpLCBncGEpOwoKVGhlIGFkZGl0
aW9ubmFsIHdhbGtzIHNob3VsZCBiZSBhZGRlZCB0aHJvdWdoIGFub3RoZXIgcGF0Y2ggdGhlIGRh
eSAKcG93ZXJwYyBuZWVkIHRoZW0uCgpTZWUgYmVsb3cgZm9yIG1vcmUgY29tbWVudHMuCgo+IAo+
IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4KPiBUZXN0
ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAYy1zLmZyPiAjIDh4eCBh
bmQgODN4eAo+IC0tLQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Jvb2szcy8zMi9wZ3Rh
YmxlLmggIHwgIDEgLQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Jvb2szcy82NC9oYXNo
LmggICAgIHwgIDQgKy0KPiAgIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvNjQvcGdh
bGxvYy5oICB8ICA0ICstCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L3Bn
dGFibGUuaCAgfCA1OCArKysrKysrKysrLS0tLS0tLS0KPiAgIGFyY2gvcG93ZXJwYy9pbmNsdWRl
L2FzbS9ib29rM3MvNjQvcmFkaXguaCAgICB8ICA2ICstCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vbm9oYXNoLzMyL3BndGFibGUuaCAgfCAgMSAtCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vbm9oYXNoLzY0L3BnYWxsb2MuaCAgfCAgMiArLQo+ICAgLi4uL2luY2x1ZGUvYXNtL25v
aGFzaC82NC9wZ3RhYmxlLTRrLmggICAgICAgIHwgMzIgKysrKystLS0tLQo+ICAgYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL25vaGFzaC82NC9wZ3RhYmxlLmggIHwgIDYgKy0KPiAgIGFyY2gvcG93
ZXJwYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAgICAgICB8ICA4ICsrKwo+ICAgYXJjaC9w
b3dlcnBjL2t2bS9ib29rM3NfNjRfbW11X3JhZGl4LmMgICAgICAgIHwgNTkgKysrKysrKysrKysr
KysrKy0tLQo+ICAgYXJjaC9wb3dlcnBjL2xpYi9jb2RlLXBhdGNoaW5nLmMgICAgICAgICAgICAg
IHwgIDcgKystCj4gICBhcmNoL3Bvd2VycGMvbW0vYm9vazNzMzIvbW11LmMgICAgICAgICAgICAg
ICAgfCAgMiArLQo+ICAgYXJjaC9wb3dlcnBjL21tL2Jvb2szczMyL3RsYi5jICAgICAgICAgICAg
ICAgIHwgIDQgKy0KPiAgIGFyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9oYXNoX3BndGFibGUuYyAg
ICAgICB8ICA0ICstCj4gICBhcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvcmFkaXhfcGd0YWJsZS5j
ICAgICAgfCAxOSArKysrLS0KPiAgIGFyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9zdWJwYWdlX3By
b3QuYyAgICAgICB8ICA2ICstCj4gICBhcmNoL3Bvd2VycGMvbW0vaHVnZXRsYnBhZ2UuYyAgICAg
ICAgICAgICAgICAgfCAyOCArKysrKy0tLS0KPiAgIGFyY2gvcG93ZXJwYy9tbS9rYXNhbi9rYXNh
bl9pbml0XzMyLmMgICAgICAgICB8ICA4ICstLQo+ICAgYXJjaC9wb3dlcnBjL21tL21lbS5jICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0KPiAgIGFyY2gvcG93ZXJwYy9tbS9ub2hhc2gv
NDB4LmMgICAgICAgICAgICAgICAgICB8ICA0ICstCj4gICBhcmNoL3Bvd2VycGMvbW0vbm9oYXNo
L2Jvb2szZV9wZ3RhYmxlLmMgICAgICAgfCAxNSArKystLQo+ICAgYXJjaC9wb3dlcnBjL21tL3Bn
dGFibGUuYyAgICAgICAgICAgICAgICAgICAgIHwgMjUgKysrKysrKy0KPiAgIGFyY2gvcG93ZXJw
Yy9tbS9wZ3RhYmxlXzMyLmMgICAgICAgICAgICAgICAgICB8IDI4ICsrKysrLS0tLQo+ICAgYXJj
aC9wb3dlcnBjL21tL3BndGFibGVfNjQuYyAgICAgICAgICAgICAgICAgIHwgMTAgKystLQo+ICAg
YXJjaC9wb3dlcnBjL21tL3B0ZHVtcC9oYXNocGFnZXRhYmxlLmMgICAgICAgIHwgMjAgKysrKysr
LQo+ICAgYXJjaC9wb3dlcnBjL21tL3B0ZHVtcC9wdGR1bXAuYyAgICAgICAgICAgICAgIHwgMjIg
KysrKysrLQo+ICAgYXJjaC9wb3dlcnBjL3htb24veG1vbi5jICAgICAgICAgICAgICAgICAgICAg
IHwgMTcgKysrKystCj4gICAyOCBmaWxlcyBjaGFuZ2VkLCAyODQgaW5zZXJ0aW9ucygrKSwgMTIw
IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
Ym9vazNzLzMyL3BndGFibGUuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvMzIv
cGd0YWJsZS5oCj4gaW5kZXggNWIzOWMxMWU4ODRhLi4zOWVjMTEzNzFiZTAgMTAwNjQ0Cj4gLS0t
IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Jvb2szcy8zMi9wZ3RhYmxlLmgKPiArKysgYi9h
cmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzMyL3BndGFibGUuaAo+IEBAIC0yLDcgKzIs
NiBAQAo+ICAgI2lmbmRlZiBfQVNNX1BPV0VSUENfQk9PSzNTXzMyX1BHVEFCTEVfSAo+ICAgI2Rl
ZmluZSBfQVNNX1BPV0VSUENfQk9PSzNTXzMyX1BHVEFCTEVfSAo+ICAgCj4gLSNkZWZpbmUgX19B
UkNIX1VTRV81TEVWRUxfSEFDSwo+ICAgI2luY2x1ZGUgPGFzbS1nZW5lcmljL3BndGFibGUtbm9w
bWQuaD4KPiAgIAo+ICAgI2luY2x1ZGUgPGFzbS9ib29rM3MvMzIvaGFzaC5oPgo+IGRpZmYgLS1n
aXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L2hhc2guaCBiL2FyY2gvcG93
ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvNjQvaGFzaC5oCj4gaW5kZXggMjc4MWViZjZhZGQ0Li44
NzZkMTUyOGMyY2YgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Jvb2sz
cy82NC9oYXNoLmgKPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L2hh
c2guaAo+IEBAIC0xMzQsOSArMTM0LDkgQEAgc3RhdGljIGlubGluZSBpbnQgZ2V0X3JlZ2lvbl9p
ZCh1bnNpZ25lZCBsb25nIGVhKQo+ICAgCj4gICAjZGVmaW5lCWhhc2hfX3BtZF9iYWQocG1kKQkJ
KHBtZF92YWwocG1kKSAmIEhfUE1EX0JBRF9CSVRTKQo+ICAgI2RlZmluZQloYXNoX19wdWRfYmFk
KHB1ZCkJCShwdWRfdmFsKHB1ZCkgJiBIX1BVRF9CQURfQklUUykKPiAtc3RhdGljIGlubGluZSBp
bnQgaGFzaF9fcGdkX2JhZChwZ2RfdCBwZ2QpCj4gK3N0YXRpYyBpbmxpbmUgaW50IGhhc2hfX3A0
ZF9iYWQocDRkX3QgcDRkKQo+ICAgewo+IC0JcmV0dXJuIChwZ2RfdmFsKHBnZCkgPT0gMCk7Cj4g
KwlyZXR1cm4gKHA0ZF92YWwocDRkKSA9PSAwKTsKPiAgIH0KPiAgICNpZmRlZiBDT05GSUdfU1RS
SUNUX0tFUk5FTF9SV1gKPiAgIGV4dGVybiB2b2lkIGhhc2hfX21hcmtfcm9kYXRhX3JvKHZvaWQp
Owo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L3BnYWxs
b2MuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvNjQvcGdhbGxvYy5oCj4gaW5k
ZXggYTQxZTkxYmQwNTgwLi42OWM1YjA1MTczNGYgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9wb3dlcnBj
L2luY2x1ZGUvYXNtL2Jvb2szcy82NC9wZ2FsbG9jLmgKPiArKysgYi9hcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vYm9vazNzLzY0L3BnYWxsb2MuaAo+IEBAIC04NSw5ICs4NSw5IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBwZ2RfZnJlZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgcGdkX3QgKnBnZCkKPiAg
IAlrbWVtX2NhY2hlX2ZyZWUoUEdUX0NBQ0hFKFBHRF9JTkRFWF9TSVpFKSwgcGdkKTsKPiAgIH0K
PiAgIAo+IC1zdGF0aWMgaW5saW5lIHZvaWQgcGdkX3BvcHVsYXRlKHN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tLCBwZ2RfdCAqcGdkLCBwdWRfdCAqcHVkKQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgcDRkX3Bv
cHVsYXRlKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBwNGRfdCAqcGdkLCBwdWRfdCAqcHVkKQo+ICAg
ewo+IC0JKnBnZCA9ICBfX3BnZChfX3BndGFibGVfcHRyX3ZhbChwdWQpIHwgUEdEX1ZBTF9CSVRT
KTsKPiArCSpwZ2QgPSAgX19wNGQoX19wZ3RhYmxlX3B0cl92YWwocHVkKSB8IFBHRF9WQUxfQklU
Uyk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgcHVkX3QgKnB1ZF9hbGxvY19vbmUoc3Ry
dWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgYWRkcikKPiBkaWZmIC0tZ2l0IGEvYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Jvb2szcy82NC9wZ3RhYmxlLmggYi9hcmNoL3Bvd2VycGMv
aW5jbHVkZS9hc20vYm9vazNzLzY0L3BndGFibGUuaAo+IGluZGV4IDIwMWE2OWU2YTM1NS4uZGRk
ZGJhZmZmMGFiIDEwMDY0NAo+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3Mv
NjQvcGd0YWJsZS5oCj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2Jvb2szcy82NC9w
Z3RhYmxlLmgKPiBAQCAtMiw3ICsyLDcgQEAKPiAgICNpZm5kZWYgX0FTTV9QT1dFUlBDX0JPT0sz
U182NF9QR1RBQkxFX0hfCj4gICAjZGVmaW5lIF9BU01fUE9XRVJQQ19CT09LM1NfNjRfUEdUQUJM
RV9IXwo+ICAgCj4gLSNpbmNsdWRlIDxhc20tZ2VuZXJpYy81bGV2ZWwtZml4dXAuaD4KPiArI2lu
Y2x1ZGUgPGFzbS1nZW5lcmljL3BndGFibGUtbm9wNGQuaD4KPiAgIAo+ICAgI2lmbmRlZiBfX0FT
U0VNQkxZX18KPiAgICNpbmNsdWRlIDxsaW51eC9tbWRlYnVnLmg+Cj4gQEAgLTI1MSw3ICsyNTEs
NyBAQCBleHRlcm4gdW5zaWduZWQgbG9uZyBfX3BtZF9mcmFnX3NpemVfc2hpZnQ7Cj4gICAvKiBC
aXRzIHRvIG1hc2sgb3V0IGZyb20gYSBQVUQgdG8gZ2V0IHRvIHRoZSBQTUQgcGFnZSAqLwo+ICAg
I2RlZmluZSBQVURfTUFTS0VEX0JJVFMJCTB4YzAwMDAwMDAwMDAwMDBmZlVMCj4gICAvKiBCaXRz
IHRvIG1hc2sgb3V0IGZyb20gYSBQR0QgdG8gZ2V0IHRvIHRoZSBQVUQgcGFnZSAqLwo+IC0jZGVm
aW5lIFBHRF9NQVNLRURfQklUUwkJMHhjMDAwMDAwMDAwMDAwMGZmVUwKPiArI2RlZmluZSBQNERf
TUFTS0VEX0JJVFMJCTB4YzAwMDAwMDAwMDAwMDBmZlVMCj4gICAKPiAgIC8qCj4gICAgKiBVc2Vk
IGFzIGFuIGluZGljYXRvciBmb3IgcmN1IGNhbGxiYWNrIGZ1bmN0aW9ucwo+IEBAIC05NDksNTQg
Kzk0OSw2MCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcHVkX2FjY2Vzc19wZXJtaXR0ZWQocHVkX3Qg
cHVkLCBib29sIHdyaXRlKQo+ICAgCXJldHVybiBwdGVfYWNjZXNzX3Blcm1pdHRlZChwdWRfcHRl
KHB1ZCksIHdyaXRlKTsKPiAgIH0KPiAgIAo+IC0jZGVmaW5lIHBnZF93cml0ZShwZ2QpCQlwdGVf
d3JpdGUocGdkX3B0ZShwZ2QpKQo+ICsjZGVmaW5lIF9fcDRkX3Jhdyh4KQkoKHA0ZF90KSB7IF9f
cGdkX3Jhdyh4KSB9KQo+ICtzdGF0aWMgaW5saW5lIF9fYmU2NCBwNGRfcmF3KHA0ZF90IHgpCj4g
K3sKPiArCXJldHVybiBwZ2RfcmF3KHgucGdkKTsKPiArfQo+ICsKClNob3VsZG4ndCB0aGlzIGJl
IGRlZmluZWQgaW4gYXNtL3BndGFibGUtYmUtdHlwZXMuaCwganVzdCBsaWtlIG90aGVyIApfX3B4
eF9yYXcoKSA/Cgo+ICsjZGVmaW5lIHA0ZF93cml0ZShwNGQpCQlwdGVfd3JpdGUocDRkX3B0ZShw
NGQpKQo+ICAgCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBwZ2RfY2xlYXIocGdkX3QgKnBnZHApCj4g
K3N0YXRpYyBpbmxpbmUgdm9pZCBwNGRfY2xlYXIocDRkX3QgKnA0ZHApCj4gICB7Cj4gLQkqcGdk
cCA9IF9fcGdkKDApOwo+ICsJKnA0ZHAgPSBfX3A0ZCgwKTsKPiAgIH0KPiAgIAo+IC1zdGF0aWMg
aW5saW5lIGludCBwZ2Rfbm9uZShwZ2RfdCBwZ2QpCj4gK3N0YXRpYyBpbmxpbmUgaW50IHA0ZF9u
b25lKHA0ZF90IHA0ZCkKPiAgIHsKPiAtCXJldHVybiAhcGdkX3JhdyhwZ2QpOwo+ICsJcmV0dXJu
ICFwNGRfcmF3KHA0ZCk7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGlubGluZSBpbnQgcGdkX3ByZXNl
bnQocGdkX3QgcGdkKQo+ICtzdGF0aWMgaW5saW5lIGludCBwNGRfcHJlc2VudChwNGRfdCBwNGQp
Cj4gICB7Cj4gLQlyZXR1cm4gISEocGdkX3JhdyhwZ2QpICYgY3B1X3RvX2JlNjQoX1BBR0VfUFJF
U0VOVCkpOwo+ICsJcmV0dXJuICEhKHA0ZF9yYXcocDRkKSAmIGNwdV90b19iZTY0KF9QQUdFX1BS
RVNFTlQpKTsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgaW5saW5lIHB0ZV90IHBnZF9wdGUocGdkX3Qg
cGdkKQo+ICtzdGF0aWMgaW5saW5lIHB0ZV90IHA0ZF9wdGUocDRkX3QgcDRkKQo+ICAgewo+IC0J
cmV0dXJuIF9fcHRlX3JhdyhwZ2RfcmF3KHBnZCkpOwo+ICsJcmV0dXJuIF9fcHRlX3JhdyhwNGRf
cmF3KHA0ZCkpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbmxpbmUgcGdkX3QgcHRlX3BnZChwdGVf
dCBwdGUpCj4gK3N0YXRpYyBpbmxpbmUgcDRkX3QgcHRlX3A0ZChwdGVfdCBwdGUpCj4gICB7Cj4g
LQlyZXR1cm4gX19wZ2RfcmF3KHB0ZV9yYXcocHRlKSk7Cj4gKwlyZXR1cm4gX19wNGRfcmF3KHB0
ZV9yYXcocHRlKSk7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGlubGluZSBpbnQgcGdkX2JhZChwZ2Rf
dCBwZ2QpCj4gK3N0YXRpYyBpbmxpbmUgaW50IHA0ZF9iYWQocDRkX3QgcDRkKQo+ICAgewo+ICAg
CWlmIChyYWRpeF9lbmFibGVkKCkpCj4gLQkJcmV0dXJuIHJhZGl4X19wZ2RfYmFkKHBnZCk7Cj4g
LQlyZXR1cm4gaGFzaF9fcGdkX2JhZChwZ2QpOwo+ICsJCXJldHVybiByYWRpeF9fcDRkX2JhZChw
NGQpOwo+ICsJcmV0dXJuIGhhc2hfX3A0ZF9iYWQocDRkKTsKPiAgIH0KPiAgIAo+IC0jZGVmaW5l
IHBnZF9hY2Nlc3NfcGVybWl0dGVkIHBnZF9hY2Nlc3NfcGVybWl0dGVkCj4gLXN0YXRpYyBpbmxp
bmUgYm9vbCBwZ2RfYWNjZXNzX3Blcm1pdHRlZChwZ2RfdCBwZ2QsIGJvb2wgd3JpdGUpCj4gKyNk
ZWZpbmUgcDRkX2FjY2Vzc19wZXJtaXR0ZWQgcDRkX2FjY2Vzc19wZXJtaXR0ZWQKPiArc3RhdGlj
IGlubGluZSBib29sIHA0ZF9hY2Nlc3NfcGVybWl0dGVkKHA0ZF90IHA0ZCwgYm9vbCB3cml0ZSkK
PiAgIHsKPiAtCXJldHVybiBwdGVfYWNjZXNzX3Blcm1pdHRlZChwZ2RfcHRlKHBnZCksIHdyaXRl
KTsKPiArCXJldHVybiBwdGVfYWNjZXNzX3Blcm1pdHRlZChwNGRfcHRlKHA0ZCksIHdyaXRlKTsK
PiAgIH0KPiAgIAo+IC1leHRlcm4gc3RydWN0IHBhZ2UgKnBnZF9wYWdlKHBnZF90IHBnZCk7Cj4g
K2V4dGVybiBzdHJ1Y3QgcGFnZSAqcDRkX3BhZ2UocDRkX3QgcDRkKTsKPiAgIAo+ICAgLyogUG9p
bnRlcnMgaW4gdGhlIHBhZ2UgdGFibGUgdHJlZSBhcmUgcGh5c2ljYWwgYWRkcmVzc2VzICovCj4g
ICAjZGVmaW5lIF9fcGd0YWJsZV9wdHJfdmFsKHB0cikJX19wYShwdHIpCj4gICAKPiAgICNkZWZp
bmUgcG1kX3BhZ2VfdmFkZHIocG1kKQlfX3ZhKHBtZF92YWwocG1kKSAmIH5QTURfTUFTS0VEX0JJ
VFMpCj4gICAjZGVmaW5lIHB1ZF9wYWdlX3ZhZGRyKHB1ZCkJX192YShwdWRfdmFsKHB1ZCkgJiB+
UFVEX01BU0tFRF9CSVRTKQo+IC0jZGVmaW5lIHBnZF9wYWdlX3ZhZGRyKHBnZCkJX192YShwZ2Rf
dmFsKHBnZCkgJiB+UEdEX01BU0tFRF9CSVRTKQo+ICsjZGVmaW5lIHA0ZF9wYWdlX3ZhZGRyKHA0
ZCkJX192YShwNGRfdmFsKHA0ZCkgJiB+UDREX01BU0tFRF9CSVRTKQo+ICAgCj4gICAjZGVmaW5l
IHBnZF9pbmRleChhZGRyZXNzKSAoKChhZGRyZXNzKSA+PiAoUEdESVJfU0hJRlQpKSAmIChQVFJT
X1BFUl9QR0QgLSAxKSkKPiAgICNkZWZpbmUgcHVkX2luZGV4KGFkZHJlc3MpICgoKGFkZHJlc3Mp
ID4+IChQVURfU0hJRlQpKSAmIChQVFJTX1BFUl9QVUQgLSAxKSkKPiBAQCAtMTAxMCw4ICsxMDE2
LDggQEAgZXh0ZXJuIHN0cnVjdCBwYWdlICpwZ2RfcGFnZShwZ2RfdCBwZ2QpOwo+ICAgCj4gICAj
ZGVmaW5lIHBnZF9vZmZzZXQobW0sIGFkZHJlc3MpCSAoKG1tKS0+cGdkICsgcGdkX2luZGV4KGFk
ZHJlc3MpKQo+ICAgCj4gLSNkZWZpbmUgcHVkX29mZnNldChwZ2RwLCBhZGRyKQlcCj4gLQkoKChw
dWRfdCAqKSBwZ2RfcGFnZV92YWRkcigqKHBnZHApKSkgKyBwdWRfaW5kZXgoYWRkcikpCj4gKyNk
ZWZpbmUgcHVkX29mZnNldChwNGRwLCBhZGRyKQlcCj4gKwkoKChwdWRfdCAqKSBwNGRfcGFnZV92
YWRkcigqKHA0ZHApKSkgKyBwdWRfaW5kZXgoYWRkcikpCj4gICAjZGVmaW5lIHBtZF9vZmZzZXQo
cHVkcCxhZGRyKSBcCj4gICAJKCgocG1kX3QgKikgcHVkX3BhZ2VfdmFkZHIoKihwdWRwKSkpICsg
cG1kX2luZGV4KGFkZHIpKQo+ICAgI2RlZmluZSBwdGVfb2Zmc2V0X2tlcm5lbChkaXIsYWRkcikg
XAo+IEBAIC0xMzY4LDYgKzEzNzQsMTIgQEAgc3RhdGljIGlubGluZSBib29sIHB1ZF9pc19sZWFm
KHB1ZF90IHB1ZCkKPiAgIAlyZXR1cm4gISEocHVkX3JhdyhwdWQpICYgY3B1X3RvX2JlNjQoX1BB
R0VfUFRFKSk7Cj4gICB9Cj4gICAKPiArI2RlZmluZSBwNGRfaXNfbGVhZiBwNGRfaXNfbGVhZgo+
ICtzdGF0aWMgaW5saW5lIGJvb2wgcDRkX2lzX2xlYWYocDRkX3QgcDRkKQo+ICt7Cj4gKwlyZXR1
cm4gISEocDRkX3JhdyhwNGQpICYgY3B1X3RvX2JlNjQoX1BBR0VfUFRFKSk7Cj4gK30KPiArCj4g
ICAjZGVmaW5lIHBnZF9pc19sZWFmIHBnZF9pc19sZWFmCj4gICAjZGVmaW5lIHBnZF9sZWFmIHBn
ZF9pc19sZWFmCj4gICBzdGF0aWMgaW5saW5lIGJvb2wgcGdkX2lzX2xlYWYocGdkX3QgcGdkKQoK
Wy4uLl0KCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgg
Yi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGd0YWJsZS5oCj4gaW5kZXggOGNjNTQzZWQxMTRj
Li4wYTA1ZmRkZDc4ODEgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Bn
dGFibGUuaAo+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgKPiBAQCAt
MTM5LDYgKzEzOSwxNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcHVkX2lzX2xlYWYocHVkX3QgcHVk
KQo+ICAgfQo+ICAgI2VuZGlmCj4gICAKPiArI2lmbmRlZiBwNGRfaXNfbGVhZgo+ICsjZGVmaW5l
IHA0ZF9pc19sZWFmIHA0ZF9pc19sZWFmCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBwNGRfaXNfbGVh
ZihwNGRfdCBwNGQpCj4gK3sKPiArCXJldHVybiBmYWxzZTsKPiArfQo+ICsjZW5kaWYKPiArCj4g
ICAjaWZuZGVmIHBnZF9pc19sZWFmCj4gICAjZGVmaW5lIHBnZF9pc19sZWFmIHBnZF9pc19sZWFm
Cj4gICBzdGF0aWMgaW5saW5lIGJvb2wgcGdkX2lzX2xlYWYocGdkX3QgcGdkKQo+IGRpZmYgLS1n
aXQgYS9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szc182NF9tbXVfcmFkaXguYyBiL2FyY2gvcG93ZXJw
Yy9rdm0vYm9vazNzXzY0X21tdV9yYWRpeC5jCj4gaW5kZXggODAzOTQwZDc5YjczLi41YWFjZmEw
YjI3ZWYgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9wb3dlcnBjL2t2bS9ib29rM3NfNjRfbW11X3JhZGl4
LmMKPiArKysgYi9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szc182NF9tbXVfcmFkaXguYwo+IEBAIC00
OTQsMTcgKzQ5NCwzOSBAQCBzdGF0aWMgdm9pZCBrdm1wcGNfdW5tYXBfZnJlZV9wdWQoc3RydWN0
IGt2bSAqa3ZtLCBwdWRfdCAqcHVkLAo+ICAgCXB1ZF9mcmVlKGt2bS0+bW0sIHB1ZCk7Cj4gICB9
Cj4gICAKPiArc3RhdGljIHZvaWQga3ZtcHBjX3VubWFwX2ZyZWVfcDRkKHN0cnVjdCBrdm0gKmt2
bSwgcDRkX3QgKnA0ZCwKPiArCQkJCSAgdW5zaWduZWQgaW50IGxwaWQpCj4gK3sKPiArCXVuc2ln
bmVkIGxvbmcgaXU7Cj4gKwlwNGRfdCAqcCA9IHA0ZDsKPiArCj4gKwlmb3IgKGl1ID0gMDsgaXUg
PCBQVFJTX1BFUl9QNEQ7ICsraXUsICsrcCkgewo+ICsJCWlmICghcDRkX3ByZXNlbnQoKnApKQo+
ICsJCQljb250aW51ZTsKPiArCQlpZiAocDRkX2lzX2xlYWYoKnApKSB7Cj4gKwkJCXA0ZF9jbGVh
cihwKTsKPiArCQl9IGVsc2Ugewo+ICsJCQlwdWRfdCAqcHVkOwo+ICsKPiArCQkJcHVkID0gcHVk
X29mZnNldChwLCAwKTsKPiArCQkJa3ZtcHBjX3VubWFwX2ZyZWVfcHVkKGt2bSwgcHVkLCBscGlk
KTsKPiArCQkJcDRkX2NsZWFyKHApOwo+ICsJCX0KPiArCX0KPiArCXA0ZF9mcmVlKGt2bS0+bW0s
IHA0ZCk7Cj4gK30KPiArCj4gICB2b2lkIGt2bXBwY19mcmVlX3BndGFibGVfcmFkaXgoc3RydWN0
IGt2bSAqa3ZtLCBwZ2RfdCAqcGdkLCB1bnNpZ25lZCBpbnQgbHBpZCkKPiAgIHsKPiAgIAl1bnNp
Z25lZCBsb25nIGlnOwo+ICAgCj4gICAJZm9yIChpZyA9IDA7IGlnIDwgUFRSU19QRVJfUEdEOyAr
K2lnLCArK3BnZCkgewo+IC0JCXB1ZF90ICpwdWQ7Cj4gKwkJcDRkX3QgKnA0ZDsKPiAgIAo+ICAg
CQlpZiAoIXBnZF9wcmVzZW50KCpwZ2QpKQo+ICAgCQkJY29udGludWU7Cj4gLQkJcHVkID0gcHVk
X29mZnNldChwZ2QsIDApOwo+IC0JCWt2bXBwY191bm1hcF9mcmVlX3B1ZChrdm0sIHB1ZCwgbHBp
ZCk7Cj4gKwkJcDRkID0gcDRkX29mZnNldChwZ2QsIDApOwo+ICsJCWt2bXBwY191bm1hcF9mcmVl
X3A0ZChrdm0sIHA0ZCwgbHBpZCk7Cj4gICAJCXBnZF9jbGVhcihwZ2QpOwo+ICAgCX0KPiAgIH0K
PiBAQCAtNTY2LDYgKzU4OCw3IEBAIGludCBrdm1wcGNfY3JlYXRlX3B0ZShzdHJ1Y3Qga3ZtICpr
dm0sIHBnZF90ICpwZ3RhYmxlLCBwdGVfdCBwdGUsCj4gICAJCSAgICAgIHVuc2lnbmVkIGxvbmcg
KnJtYXBwLCBzdHJ1Y3Qgcm1hcF9uZXN0ZWQgKipuX3JtYXApCj4gICB7Cj4gICAJcGdkX3QgKnBn
ZDsKPiArCXA0ZF90ICpwNGQsICpuZXdfcDRkID0gTlVMTDsKPiAgIAlwdWRfdCAqcHVkLCAqbmV3
X3B1ZCA9IE5VTEw7Cj4gICAJcG1kX3QgKnBtZCwgKm5ld19wbWQgPSBOVUxMOwo+ICAgCXB0ZV90
ICpwdGVwLCAqbmV3X3B0ZXAgPSBOVUxMOwo+IEBAIC01NzMsOSArNTk2LDE1IEBAIGludCBrdm1w
cGNfY3JlYXRlX3B0ZShzdHJ1Y3Qga3ZtICprdm0sIHBnZF90ICpwZ3RhYmxlLCBwdGVfdCBwdGUs
Cj4gICAKPiAgIAkvKiBUcmF2ZXJzZSB0aGUgZ3Vlc3QncyAybmQtbGV2ZWwgdHJlZSwgYWxsb2Nh
dGUgbmV3IGxldmVscyBuZWVkZWQgKi8KPiAgIAlwZ2QgPSBwZ3RhYmxlICsgcGdkX2luZGV4KGdw
YSk7Cj4gLQlwdWQgPSBOVUxMOwo+ICsJcDRkID0gTlVMTDsKPiAgIAlpZiAocGdkX3ByZXNlbnQo
KnBnZCkpCj4gLQkJcHVkID0gcHVkX29mZnNldChwZ2QsIGdwYSk7Cj4gKwkJcDRkID0gcDRkX29m
ZnNldChwZ2QsIGdwYSk7Cj4gKwllbHNlCj4gKwkJbmV3X3A0ZCA9IHA0ZF9hbGxvY19vbmUoa3Zt
LT5tbSwgZ3BhKTsKPiArCj4gKwlwdWQgPSBOVUxMOwo+ICsJaWYgKHA0ZF9wcmVzZW50KCpwNGQp
KQo+ICsJCXB1ZCA9IHB1ZF9vZmZzZXQocDRkLCBncGEpOwoKSXMgaXQgd29ydGggYWRkaW5nIGFs
bCB0aGlzIG5ldyBjb2RlID8KCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgc2VyaWVzIG9i
amVjdGl2ZSBpcyB0byBnZXQgcmlkIG9mIApfX0FSQ0hfSEFTXzVMRVZFTF9IQUNLLCB0byB0byBh
ZGQgc3VwcG9ydCBmb3IgNSBsZXZlbHMgdG8gYW4gCmFyY2hpdGVjdHVyZSB0aGF0IG5vdCBuZWVk
IGl0IChhdCBsZWFzdCBmb3Igbm93KS4KSWYgd2Ugd2FudCB0byBhZGQgc3VwcG9ydCBmb3IgNSBs
ZXZlbHMsIGl0IGNhbiBiZSBkb25lIGxhdGVyIGluIGFub3RoZXIgCnBhdGNoLgoKSGVyZSBJIHRo
aW5rIHlvdXIgY2hhbmdlIGNvdWxkIGJlIGxpbWl0ZWQgdG86CgotCQlwdWQgPSBwdWRfb2Zmc2V0
KHBnZCwgZ3BhKTsKKwkJcHVkID0gcHVkX29mZnNldChwNGRfb2Zmc2V0KHBnZCwgZ3BhKSwgZ3Bh
KTsKCgo+ICAgCWVsc2UKPiAgIAkJbmV3X3B1ZCA9IHB1ZF9hbGxvY19vbmUoa3ZtLT5tbSwgZ3Bh
KTsKPiAgIAo+IEBAIC01OTcsMTIgKzYyNiwxOCBAQCBpbnQga3ZtcHBjX2NyZWF0ZV9wdGUoc3Ry
dWN0IGt2bSAqa3ZtLCBwZ2RfdCAqcGd0YWJsZSwgcHRlX3QgcHRlLAo+ICAgCS8qIE5vdyB0cmF2
ZXJzZSBhZ2FpbiB1bmRlciB0aGUgbG9jayBhbmQgY2hhbmdlIHRoZSB0cmVlICovCj4gICAJcmV0
ID0gLUVOT01FTTsKPiAgIAlpZiAocGdkX25vbmUoKnBnZCkpIHsKPiArCQlpZiAoIW5ld19wNGQp
Cj4gKwkJCWdvdG8gb3V0X3VubG9jazsKPiArCQlwZ2RfcG9wdWxhdGUoa3ZtLT5tbSwgcGdkLCBu
ZXdfcDRkKTsKPiArCQluZXdfcDRkID0gTlVMTDsKPiArCX0KPiArCWlmIChwNGRfbm9uZSgqcDRk
KSkgewo+ICAgCQlpZiAoIW5ld19wdWQpCj4gICAJCQlnb3RvIG91dF91bmxvY2s7Cj4gLQkJcGdk
X3BvcHVsYXRlKGt2bS0+bW0sIHBnZCwgbmV3X3B1ZCk7Cj4gKwkJcDRkX3BvcHVsYXRlKGt2bS0+
bW0sIHA0ZCwgbmV3X3B1ZCk7Cj4gICAJCW5ld19wdWQgPSBOVUxMOwo+ICAgCX0KPiAtCXB1ZCA9
IHB1ZF9vZmZzZXQocGdkLCBncGEpOwo+ICsJcHVkID0gcHVkX29mZnNldChwNGQsIGdwYSk7Cj4g
ICAJaWYgKHB1ZF9pc19sZWFmKCpwdWQpKSB7Cj4gICAJCXVuc2lnbmVkIGxvbmcgaGdwYSA9IGdw
YSAmIFBVRF9NQVNLOwo+ICAgCj4gQEAgLTEyMjAsNiArMTI1NSw3IEBAIHN0YXRpYyBzc2l6ZV90
IGRlYnVnZnNfcmFkaXhfcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKmJ1ZiwK
PiAgIAlwZ2RfdCAqcGd0Owo+ICAgCXN0cnVjdCBrdm1fbmVzdGVkX2d1ZXN0ICpuZXN0ZWQ7Cj4g
ICAJcGdkX3QgcGdkLCAqcGdkcDsKPiArCXA0ZF90IHA0ZCwgKnA0ZHA7Cj4gICAJcHVkX3QgcHVk
LCAqcHVkcDsKPiAgIAlwbWRfdCBwbWQsICpwbWRwOwo+ICAgCXB0ZV90ICpwdGVwOwo+IEBAIC0x
Mjk4LDcgKzEzMzQsMTQgQEAgc3RhdGljIHNzaXplX3QgZGVidWdmc19yYWRpeF9yZWFkKHN0cnVj
dCBmaWxlICpmaWxlLCBjaGFyIF9fdXNlciAqYnVmLAo+ICAgCQkJY29udGludWU7Cj4gICAJCX0K
PiAgIAo+IC0JCXB1ZHAgPSBwdWRfb2Zmc2V0KCZwZ2QsIGdwYSk7Cj4gKwkJcDRkcCA9IHA0ZF9v
ZmZzZXQoJnBnZCwgZ3BhKTsKPiArCQlwNGQgPSBSRUFEX09OQ0UoKnA0ZHApOwo+ICsJCWlmICgh
KHA0ZF92YWwocDRkKSAmIF9QQUdFX1BSRVNFTlQpKSB7Cj4gKwkJCWdwYSA9IChncGEgJiBQNERf
TUFTSykgKyBQNERfU0laRTsKPiArCQkJY29udGludWU7Cj4gKwkJfQo+ICsKPiArCQlwdWRwID0g
cHVkX29mZnNldCgmcDRkLCBncGEpOwoKU2FtZSwgaGVyZSB5b3UgYXJlIGZvcmNpbmcgYSB1c2Vs
ZXNzIHJlYWQgd2l0aCBSRUFEX09OQ0UoKS4KCllvdXIgY2hhbmdlIGNvdWxkIGJlIGxpbWl0ZWQg
dG8KCi0JCXB1ZHAgPSBwdWRfb2Zmc2V0KCZwZ2QsIGdwYSk7CisJCXB1ZHAgPSBwdWRfb2Zmc2V0
KHA0ZF9vZmZzZXQoJnBnZCwgZ3BhKSwgZ3BhKTsKClRoaXMgY29tbWVudCBhcHBsaWVzIHRvIG1h
bnkgb3RoZXIgcGxhY2VzLgoKCj4gICAJCXB1ZCA9IFJFQURfT05DRSgqcHVkcCk7Cj4gICAJCWlm
ICghKHB1ZF92YWwocHVkKSAmIF9QQUdFX1BSRVNFTlQpKSB7Cj4gICAJCQlncGEgPSAoZ3BhICYg
UFVEX01BU0spICsgUFVEX1NJWkU7Cj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9saWIvY29k
ZS1wYXRjaGluZy5jIGIvYXJjaC9wb3dlcnBjL2xpYi9jb2RlLXBhdGNoaW5nLmMKPiBpbmRleCAz
MzQ1ZjAzOWE4NzYuLjdhNTlmNjg2M2NlYyAxMDA2NDQKPiAtLS0gYS9hcmNoL3Bvd2VycGMvbGli
L2NvZGUtcGF0Y2hpbmcuYwo+ICsrKyBiL2FyY2gvcG93ZXJwYy9saWIvY29kZS1wYXRjaGluZy5j
Cj4gQEAgLTEwNywxMyArMTA3LDE4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHVubWFwX3BhdGNoX2Fy
ZWEodW5zaWduZWQgbG9uZyBhZGRyKQo+ICAgCXB0ZV90ICpwdGVwOwo+ICAgCXBtZF90ICpwbWRw
Owo+ICAgCXB1ZF90ICpwdWRwOwo+ICsJcDRkX3QgKnA0ZHA7Cj4gICAJcGdkX3QgKnBnZHA7Cj4g
ICAKPiAgIAlwZ2RwID0gcGdkX29mZnNldF9rKGFkZHIpOwo+ICAgCWlmICh1bmxpa2VseSghcGdk
cCkpCj4gICAJCXJldHVybiAtRUlOVkFMOwo+ICAgCj4gLQlwdWRwID0gcHVkX29mZnNldChwZ2Rw
LCBhZGRyKTsKPiArCXA0ZHAgPSBwNGRfb2Zmc2V0KHBnZHAsIGFkZHIpOwo+ICsJaWYgKHVubGlr
ZWx5KCFwNGRwKSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlwdWRwID0gcHVkX29mZnNl
dChwNGRwLCBhZGRyKTsKPiAgIAlpZiAodW5saWtlbHkoIXB1ZHApKQo+ICAgCQlyZXR1cm4gLUVJ
TlZBTDsKPiAgIAo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvbW0vYm9vazNzMzIvbW11LmMg
Yi9hcmNoL3Bvd2VycGMvbW0vYm9vazNzMzIvbW11LmMKPiBpbmRleCAwYTFjNjVhMmM1NjUuLmIy
ZmMzZTcxMTY1YyAxMDA2NDQKPiAtLS0gYS9hcmNoL3Bvd2VycGMvbW0vYm9vazNzMzIvbW11LmMK
PiArKysgYi9hcmNoL3Bvd2VycGMvbW0vYm9vazNzMzIvbW11LmMKPiBAQCAtMzEyLDcgKzMxMiw3
IEBAIHZvaWQgaGFzaF9wcmVsb2FkKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25n
IGVhKQo+ICAgCj4gICAJaWYgKCFIYXNoKQo+ICAgCQlyZXR1cm47Cj4gLQlwbWQgPSBwbWRfb2Zm
c2V0KHB1ZF9vZmZzZXQocGdkX29mZnNldChtbSwgZWEpLCBlYSksIGVhKTsKPiArCXBtZCA9IHBt
ZF9vZmZzZXQocHVkX29mZnNldChwNGRfb2Zmc2V0KHBnZF9vZmZzZXQobW0sIGVhKSwgZWEpLCBl
YSksIGVhKTsKCklmIHdlIGNvbnRpbnVlIGxpa2UgdGhpcywgaW4gdGVuIHllYXJzIHRoaXMgbGlr
ZSBpcyBnb2luZyB0byBiZSBtYW55IApraWxvbWV0ZXJzIGxvbmcuCgpJIHRoaW5rIHRoZSBhYm92
ZSB3b3VsZCBiZSB3b3J0aCBhIGdlbmVyaWMgaGVscGVyLgoKPiAgIAlpZiAoIXBtZF9ub25lKCpw
bWQpKQo+ICAgCQlhZGRfaGFzaF9wYWdlKG1tLT5jb250ZXh0LmlkLCBlYSwgcG1kX3ZhbCgqcG1k
KSk7Cj4gICB9Cj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9tbS9ib29rM3MzMi90bGIuYyBi
L2FyY2gvcG93ZXJwYy9tbS9ib29rM3MzMi90bGIuYwo+IGluZGV4IDJmY2QzMjEwNDBmZi4uMTc1
YmMzM2I0MWI3IDEwMDY0NAo+IC0tLSBhL2FyY2gvcG93ZXJwYy9tbS9ib29rM3MzMi90bGIuYwo+
ICsrKyBiL2FyY2gvcG93ZXJwYy9tbS9ib29rM3MzMi90bGIuYwo+IEBAIC04Nyw3ICs4Nyw3IEBA
IHN0YXRpYyB2b2lkIGZsdXNoX3JhbmdlKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBs
b25nIHN0YXJ0LAo+ICAgCWlmIChzdGFydCA+PSBlbmQpCj4gICAJCXJldHVybjsKPiAgIAllbmQg
PSAoZW5kIC0gMSkgfCB+UEFHRV9NQVNLOwo+IC0JcG1kID0gcG1kX29mZnNldChwdWRfb2Zmc2V0
KHBnZF9vZmZzZXQobW0sIHN0YXJ0KSwgc3RhcnQpLCBzdGFydCk7Cj4gKwlwbWQgPSBwbWRfb2Zm
c2V0KHB1ZF9vZmZzZXQocDRkX29mZnNldChwZ2Rfb2Zmc2V0KG1tLCBzdGFydCksIHN0YXJ0KSwg
c3RhcnQpLCBzdGFydCk7Cj4gICAJZm9yICg7Oykgewo+ICAgCQlwbWRfZW5kID0gKChzdGFydCAr
IFBHRElSX1NJWkUpICYgUEdESVJfTUFTSykgLSAxOwo+ICAgCQlpZiAocG1kX2VuZCA+IGVuZCkK
PiBAQCAtMTQ1LDcgKzE0NSw3IEBAIHZvaWQgZmx1c2hfdGxiX3BhZ2Uoc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgdm1hZGRyKQo+ICAgCQlyZXR1cm47Cj4gICAJfQo+
ICAgCW1tID0gKHZtYWRkciA8IFRBU0tfU0laRSk/IHZtYS0+dm1fbW06ICZpbml0X21tOwo+IC0J
cG1kID0gcG1kX29mZnNldChwdWRfb2Zmc2V0KHBnZF9vZmZzZXQobW0sIHZtYWRkciksIHZtYWRk
ciksIHZtYWRkcik7Cj4gKwlwbWQgPSBwbWRfb2Zmc2V0KHB1ZF9vZmZzZXQocDRkX29mZnNldChw
Z2Rfb2Zmc2V0KG1tLCB2bWFkZHIpLCB2bWFkZHIpLCB2bWFkZHIpLCB2bWFkZHIpOwo+ICAgCWlm
ICghcG1kX25vbmUoKnBtZCkpCj4gICAJCWZsdXNoX2hhc2hfcGFnZXMobW0tPmNvbnRleHQuaWQs
IHZtYWRkciwgcG1kX3ZhbCgqcG1kKSwgMSk7Cj4gICB9Cj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93
ZXJwYy9tbS9ib29rM3M2NC9oYXNoX3BndGFibGUuYyBiL2FyY2gvcG93ZXJwYy9tbS9ib29rM3M2
NC9oYXNoX3BndGFibGUuYwo+IGluZGV4IDY0NzMzYjljYjIwYS4uOWNkMTU5MzdlODhhIDEwMDY0
NAo+IC0tLSBhL2FyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9oYXNoX3BndGFibGUuYwo+ICsrKyBi
L2FyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9oYXNoX3BndGFibGUuYwo+IEBAIC0xNDgsNiArMTQ4
LDcgQEAgdm9pZCBoYXNoX192bWVtbWFwX3JlbW92ZV9tYXBwaW5nKHVuc2lnbmVkIGxvbmcgc3Rh
cnQsCj4gICBpbnQgaGFzaF9fbWFwX2tlcm5lbF9wYWdlKHVuc2lnbmVkIGxvbmcgZWEsIHVuc2ln
bmVkIGxvbmcgcGEsIHBncHJvdF90IHByb3QpCj4gICB7Cj4gICAJcGdkX3QgKnBnZHA7Cj4gKwlw
NGRfdCAqcDRkcDsKPiAgIAlwdWRfdCAqcHVkcDsKPiAgIAlwbWRfdCAqcG1kcDsKPiAgIAlwdGVf
dCAqcHRlcDsKPiBAQCAtMTU1LDcgKzE1Niw4IEBAIGludCBoYXNoX19tYXBfa2VybmVsX3BhZ2Uo
dW5zaWduZWQgbG9uZyBlYSwgdW5zaWduZWQgbG9uZyBwYSwgcGdwcm90X3QgcHJvdCkKPiAgIAlC
VUlMRF9CVUdfT04oVEFTS19TSVpFX1VTRVI2NCA+IEhfUEdUQUJMRV9SQU5HRSk7Cj4gICAJaWYg
KHNsYWJfaXNfYXZhaWxhYmxlKCkpIHsKPiAgIAkJcGdkcCA9IHBnZF9vZmZzZXRfayhlYSk7Cj4g
LQkJcHVkcCA9IHB1ZF9hbGxvYygmaW5pdF9tbSwgcGdkcCwgZWEpOwo+ICsJCXA0ZHAgPSBwNGRf
b2Zmc2V0KHBnZHAsIGVhKTsKPiArCQlwdWRwID0gcHVkX2FsbG9jKCZpbml0X21tLCBwNGRwLCBl
YSk7CgpDb3VsZCBiZSBhIHNpbmdsZSBsaW5lLCB3aXRob3V0IGEgbmV3IHZhci4KCi0JCXB1ZHAg
PSBwdWRfYWxsb2MoJmluaXRfbW0sIHBnZHAsIGVhKTsKKwkJcHVkcCA9IHB1ZF9hbGxvYygmaW5p
dF9tbSwgcDRkX29mZnNldChwZ2RwLCBlYSksIGVhKTsKCgpTYW1lIGtpbmQgb2YgY29tbWVudHMg
YXMgYWxyZWFkeSBkb25lIGFwcGx5IHRvIHRoZSByZXN0LgoKQ2hyaXN0b3BoZQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0
Cmt2bWFybUBsaXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5l
ZHUvbWFpbG1hbi9saXN0aW5mby9rdm1hcm0K
