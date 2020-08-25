Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B70F2251911
	for <lists+kvmarm@lfdr.de>; Tue, 25 Aug 2020 14:52:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 301DD4C002;
	Tue, 25 Aug 2020 08:52:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCPm0gcB479c; Tue, 25 Aug 2020 08:52:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 928C14BF22;
	Tue, 25 Aug 2020 08:52:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C6CCE4BEF8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 08:52:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEAGkXf034Ye for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Aug 2020 08:52:46 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C511F4BEDD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Aug 2020 08:52:46 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D8B41FB;
 Tue, 25 Aug 2020 05:52:46 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258963F66B;
 Tue, 25 Aug 2020 05:52:44 -0700 (PDT)
Date: Tue, 25 Aug 2020 13:52:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [RFC PATCH 0/5] KVM: arm64: Add pvtime LPT support
Message-ID: <20200825125230.GA33677@C02TD0UTHF1T.local>
References: <20200817084110.2672-1-zhukeqian1@huawei.com>
 <8308f52e4c906cad710575724f9e3855@kernel.org>
 <f14cfd5b-c103-5d56-82fb-59d0371c6f21@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f14cfd5b-c103-5d56-82fb-59d0371c6f21@arm.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

T24gV2VkLCBBdWcgMTksIDIwMjAgYXQgMDk6NTQ6NDBBTSArMDEwMCwgU3RldmVuIFByaWNlIHdy
b3RlOgo+IE9uIDE4LzA4LzIwMjAgMTU6NDEsIE1hcmMgWnluZ2llciB3cm90ZToKPiA+IE9uIDIw
MjAtMDgtMTcgMDk6NDEsIEtlcWlhbiBaaHUgd3JvdGU6Cgo+IFdlIGFyZSBkaXNjdXNzaW5nIChy
ZS0pcmVsZWFzaW5nIHRoZSBzcGVjIHdpdGggdGhlIExQVCBwYXJ0cyBhZGRlZC4gSWYgeW91Cj4g
aGF2ZSBmdW5kYW1lbnRhbCBvYmplY3Rpb25zIHRoZW4gcGxlYXNlIG1lIGtub3cuCgpMaWtlIE1h
cmMsIEkgYXJndWVkIHN0cm9uZ2x5IGZvciB0aGUgcmVtb3ZhbCBvZiB0aGUgTFBUIGJpdHMgb24g
dGhlCnByZW1pc2UgdGhhdCBpdCBkaWRuJ3QgcmVhbGx5IHdvcmsgKGUuZy4gd2hlbiB0cmFuc2lz
dGlvbmluZyBiZXR3ZWVuIFNXCmFnZW50cykgYW5kIHNvIGl0IHdhc8KgYSBwdXJlIG1haW50ZW5h
bmNlIGJ1cmRlbi4KCkkgZG9uJ3QgdGhpbmsgdGhlIHRlY2huaWNhbCBhcmd1bWVudHMgaGF2ZSBj
aGFuZ2VkLCBhbmQgSSBkb24ndCB0aGluawppdCdzIGEgZ29vZCBpZGVhIHRvIHRyeSB0byByZXNz
dXJlY3QgdGhpcy4gUGxlYXNlIHJvcGUgbWUgaW4gaWYKdGhpcyBjb21lcyB1cCBpbiBpbnRlcm5h
bCBkaXNjdXNzaW9ucy4KCk1hcmsuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlh
LmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFy
bQo=
