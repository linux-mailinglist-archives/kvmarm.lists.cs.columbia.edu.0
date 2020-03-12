Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FF1836B4
	for <lists+kvmarm@lfdr.de>; Thu, 12 Mar 2020 17:57:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 37D8A4AEDA;
	Thu, 12 Mar 2020 12:57:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 4.298
X-Spam-Level: ****
X-Spam-Status: No, score=4.298 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, FH_HELO_ALMOST_IP=3.499]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5elvXcxtMJOR; Thu, 12 Mar 2020 12:57:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E64C4AED8;
	Thu, 12 Mar 2020 12:57:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CA074A959
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 12:42:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R3xLT6DYPled for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Mar 2020 12:42:36 -0400 (EDT)
Received: from ns207790.ip-94-23-215.eu (poy.remlab.net [94.23.215.26])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 984804A7F0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Mar 2020 12:42:36 -0400 (EDT)
Received: from roundcube.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 9E9CD5FADD;
 Thu, 12 Mar 2020 17:42:35 +0100 (CET)
MIME-Version: 1.0
Date: Thu, 12 Mar 2020 18:42:35 +0200
From: Remi Denis-Courmont <remi@remlab.net>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: move kimage_vaddr to .rodata
Organization: Remlab Tmi
In-Reply-To: <20200312164035.GA21120@lakrids.cambridge.arm.com>
References: <20200312094002.153302-1-remi@remlab.net>
 <20200312164035.GA21120@lakrids.cambridge.arm.com>
Message-ID: <e87d4a759618c13dfc9d814112e6352a@remlab.net>
X-Sender: remi@remlab.net
User-Agent: Roundcube Webmail/1.2.3
X-Mailman-Approved-At: Thu, 12 Mar 2020 12:57:37 -0400
Cc: catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
 linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
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

TGUgMjAyMC0wMy0xMiAxODo0MCwgTWFyayBSdXRsYW5kIGEgw6ljcml0wqA6Cj4gT24gVGh1LCBN
YXIgMTIsIDIwMjAgYXQgMTE6NDA6MDJBTSArMDIwMCwgUsOpbWkgRGVuaXMtQ291cm1vbnQgd3Jv
dGU6Cj4+IEZyb206IFJlbWkgRGVuaXMtQ291cm1vbnQgPHJlbWkuZGVuaXMuY291cm1vbnRAaHVh
d2VpLmNvbT4KPj4gCj4+IFRoaXMgZGF0dW0gaXMgbm90IHJlZmVyZW5jZWQgZnJvbSAuaWRtYXAu
dGV4dDogaXQgZG9lcyBub3QgbmVlZCB0byBiZQo+PiBtYXBwZWQgaW4gaWRtYXAuIExldHMgbW92
ZSBpdCB0byAucm9kYXRhIGFzIGl0IGlzIG5ldmVyIHdyaXR0ZW4gdG8gCj4+IGFmdGVyCj4+IGVh
cmx5IGJvb3Qgb2YgdGhlIHByaW1hcnkgQ1BVLgo+PiAoTWF5YmUgLmRhdGEucm9fYWZ0ZXJfaW5p
dCB3b3VsZCBiZSBjbGVhbmVyIHRob3VnaD8pCj4gCj4gQ2FuIHdlIG1vdmUgdGhpcyBpbnRvIGFy
Y2gvYXJtNjQvbW0vbW11LmMsIHdoZXJlIHdlIGFscmVhZHkgaGF2ZQo+IGtpbWFnZV92b2Zmc2V0
Ogo+IAo+IHwgdTY0IGtpbWFnZV92b2Zmc2V0IF9fcm9fYWZ0ZXJfaW5pdDsKPiB8IEVYUE9SVF9T
WU1CT0woa2ltYWdlX3ZvZmZzZXQpOwo+IAo+IC4uLiBvciBpcyBpdCBub3QgcG9zc2libGUgdG8g
aW5pdGlhbGl6ZSBraW1hZ2VfdmFkZHIgY29ycmVjdGx5IGluIEM/CgpHb29kIHF1ZXN0aW9uLi4u
IEknbGwgY2hlY2sgdG9tb3Jyb3cuCgotLSAKUsOpbWkgRGVuaXMtQ291cm1vbnQKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlz
dAprdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEu
ZWR1L21haWxtYW4vbGlzdGluZm8va3ZtYXJtCg==
