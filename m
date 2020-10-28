Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02829D219
	for <lists+kvmarm@lfdr.de>; Wed, 28 Oct 2020 21:24:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E14854B37D;
	Wed, 28 Oct 2020 16:24:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BibZW4V3XYfT; Wed, 28 Oct 2020 16:24:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A470F4B361;
	Wed, 28 Oct 2020 16:24:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC49B4B353
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Oct 2020 16:24:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRJcUVBaDw+f for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Oct 2020 16:24:41 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 05A0B4B2A6
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Oct 2020 16:24:40 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ABCE0247F8;
 Wed, 28 Oct 2020 20:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603916679;
 bh=UUOsZKN7KXk7cHfjExBsUtQIG2TwB07hlMnxPr/cS6I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iYmrlKDDxKu96zmq+Rr+6UMBZ4Z5Qf4kxsu4mfrhQOlKqhCTZLeY/QIppwXC310IC
 zIrHp6hEXp1SRINeXQBLbVRaVAB+iTWzMCtjNQgwowYXu9lLAGxRgjF7fRELzlrbdy
 U/ttQAO/n2NdjR44LppRDupZeVqfu1gRV4vRkdqQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kXrzp-0059jz-LS; Wed, 28 Oct 2020 20:24:37 +0000
MIME-Version: 1.0
Date: Wed, 28 Oct 2020 20:24:37 +0000
From: Marc Zyngier <maz@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 08/11] KVM: arm64: Inject AArch32 exceptions from HYP
In-Reply-To: <3691596f-fb42-a6e0-8aca-5a1605219c23@arm.com>
References: <20201026133450.73304-1-maz@kernel.org>
 <20201026133450.73304-9-maz@kernel.org>
 <b4ef5e3e-a1a4-948f-bc9d-4bd297cb26a6@arm.com>
 <6b30a9c9d082aeabc6cb81aca97b5398@kernel.org>
 <3691596f-fb42-a6e0-8aca-5a1605219c23@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <9c130c8e438f59ecd0072feea9addbcc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, ascull@google.com,
 will@kernel.org, qperret@google.com, dbrazdil@google.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

T24gMjAyMC0xMC0yOCAxOToyMCwgSmFtZXMgTW9yc2Ugd3JvdGU6Cj4gSGkgTWFyYywKPiAKPiBP
biAyNy8xMC8yMDIwIDE5OjIxLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+Pj4gK3N0YXRpYyBpbmxp
bmUgdTMyIF9fdmNwdV9yZWFkX2NwMTUoY29uc3Qgc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBpbnQg
Cj4+Pj4gcmVnKQo+Pj4+ICt7Cj4+Pj4gK8KgwqDCoCByZXR1cm4gX192Y3B1X3JlYWRfc3lzX3Jl
Zyh2Y3B1LCByZWcgLyAyKTsKPj4+PiArfQo+IAo+Pj4gRG9lc24ndCB0aGlzIHJlLWltcGxlbWVu
dCB0aGUgaXNzdWUgMzIwNGJlNDEwOWFkIGJpYXNlZD8KPiAKPj4gSSBkb24ndCB0aGluayBpdCBk
b2VzLiBUaGUgaXNzdWUgZXhpc3RlZCB3aGVuIGFjY2Vzc2luZyB0aGUgMzJiaXQgCj4+IHNoYWRv
dywKPj4gYW5kIHdlIGhhZCB0byBwaWNrIHdoaWNoIHNpZGUgb2YgdGhlIDY0Yml0IHJlZ2lzdGVy
IGhhZCBvdXIgMzJiaXQgCj4+IHZhbHVlLgo+PiBIZXJlLCB3ZSBkaXJlY3RseSBhY2Nlc3MgdGhl
IDY0Yml0IGZpbGUsIHdoaWNoIGlzIHNhZmUuCj4gCj4gQmVjYXVzZSBpdHMgbm90IGFjY2Vzc2lu
ZyB0aGUgY29wcm8gdW5pb24sIGFuZCB0aGUgdHdvIHVzZXJzIGFyZSBib3RoCj4gc3RyYWlnaHQg
Zm9yd2FyZCBhbGlhc2VzLgo+IAo+IC4uLgo+IAo+IFdoYXQgZG8gSSBnZXQgaWYgSSBjYWxsOgo+
IHwgX192Y3B1X3JlYWRfY3AxNSh2Y3B1LCBjNl9JRkFSKTsKPiAKPiBXb24ndCB0aGlzIHJldHVy
biB0aGUgdmFsdWUgb2YgYzZfREZBUiBpbnN0ZWFkIGFzIHRoZXkgbGl2ZSBpbiB0aGUKPiBzYW1l
IDY0IGJpdCByZWdpc3Rlci4KClllcywgdGhhdCB3b3VsZCBicmVhay4gTm90IGluIHRoaXMgYml0
IG9mIGNvZGUgdGhvdWdoLgoKPiAKPiAKPj4gQnV0IHRoaW5raW5nIG9mIGl0LCB3ZSBtYXkgYXMg
d2VsbCBjaGFuZ2UgdGhlIGNhbGwgc2l0ZXMgdG8gZGlyZWN0bHkKPj4gdXNlIHRoZSA2NGJpdCBl
bnVtLCByYXRoZXIgdGhhbiBwbGF5aW5nIGdhbWVzCj4gCj4gR3JlYXQhCgpZZWFoLCBhbmQgdGhl
cmUgaXMgYSBidW5jaCBvZiAuLi4gY3JhcCBhcm91bmQgdGhpcyBhbGlhc2luZy4KVW5mb3J0dW5h
dGVseSwgSSBqdXN0IG5vdGljZWQgdGhhdCAzMmJpdCBndWVzdHMgYXJlIGJvcmtlZCBpbiAtcmMx
LgpEZWJ1ZyB0aW1lLgoKICAgICAgICAgTS4KLS0gCkphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qg
c21lbGxzIGZ1bm55Li4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpo
dHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
