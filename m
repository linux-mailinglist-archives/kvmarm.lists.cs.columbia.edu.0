Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD760142CDD
	for <lists+kvmarm@lfdr.de>; Mon, 20 Jan 2020 15:09:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 43C514AF26;
	Mon, 20 Jan 2020 09:09:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.099
X-Spam-Level: 
X-Spam-Status: No, score=0.099 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j472PrZ8WEmP; Mon, 20 Jan 2020 09:09:23 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B42094AF28;
	Mon, 20 Jan 2020 09:09:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 978244ACF4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Jan 2020 09:09:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jJpHO-QJKEfD for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Jan 2020 09:09:12 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 554914A542
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Jan 2020 09:09:12 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C87BC30E;
 Mon, 20 Jan 2020 06:09:11 -0800 (PST)
Received: from [10.2.69.39] (unknown [10.2.69.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47B963F52E;
 Mon, 20 Jan 2020 06:09:11 -0800 (PST)
Subject: Re: [PATCH v2] ARM: virt: Relax arch timer version check during early
 boot
To: Marc Zyngier <maz@kernel.org>
References: <1579527498-31081-1-git-send-email-vladimir.murzin@arm.com>
 <c573c3f5b86ece28a10c2466e985b256@kernel.org>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <dbe70c99-812c-f10c-524a-1ff6c84c7574@arm.com>
Date: Mon, 20 Jan 2020 14:09:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c573c3f5b86ece28a10c2466e985b256@kernel.org>
Content-Language: en-US
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

T24gMS8yMC8yMCAyOjAxIFBNLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gT24gMjAyMC0wMS0yMCAx
MzozOCwgVmxhZGltaXIgTXVyemluIHdyb3RlOgo+PiBVcGRhdGVzIHRvIHRoZSBHZW5lcmljIFRp
bWVyIGFyY2hpdGVjdHVyZSBhbGxvdyBJRF9QRlIxLkdlblRpbWVyIHRvCj4+IGhhdmUgdmFsdWVz
IG90aGVyIHRoYW4gMCBvciAxIHdoaWxlIHN0aWxsIHByZXNlcnZpbmcgYmFja3dhcmQKPj4gY29t
cGF0aWJpbGl0eS4gQXQgdGhlIG1vbWVudCwgTGludXggaXMgcXVpdGUgc3RyaWN0IGluIHRoZSB3
YXkgaXQKPj4gaGFuZGxlcyB0aGlzIGZpZWxkIGF0IGVhcmx5IGJvb3QgYW5kIHdpbGwgbm90IGNv
bmZpZ3VyZSBhcmNoIHRpbWVyIGlmCj4+IGl0IGRvZXNuJ3QgZmluZCB0aGUgdmFsdWUgMS4KPj4K
Pj4gU2luY2UgaGVyZSB1c2UgdWJmeCBmb3IgYXJjaCB0aW1lciB2ZXJzaW9uIGV4dHJhY3Rpb24g
KGh5Yi1zdHViIGJ1aWxkCj4+IHdpdGggLW1hcmNoPWFybXY3LWEsIHNvIGl0IGlzIHNhZmUpCj4+
Cj4+IFRvIGhlbHAgYmFja3BvcnRzIChldmVuIHRob3VnaCB0aGUgY29kZSB3YXMgY29ycmVjdCBh
dCB0aGUgdGltZSBvZiB3cml0aW5nKQo+PiBGaXhlczogOGVjNThiZTlmM2ZmICgiQVJNOiB2aXJ0
OiBhcmNoX3RpbWVyczogZW5hYmxlIGFjY2VzcyB0byBwaHlzaWNhbCB0aW1lcnMiKQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBNdXJ6aW4gPHZsYWRpbWlyLm11cnppbkBhcm0uY29tPgo+IAo+
IEFja2VkLWJ5OiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+IAo+IEZlZWwgZnJlZSB0
byBwdXQgaXQgaW50byBSdXNzZWxsJ3MgcGF0Y2ggc3lzdGVtLgoKUGF0Y2ggaGFzIGJlZW4gYWNj
ZXB0ZWQgYXMgcGF0Y2ggODk1NS8xCgpUaGFua3MhCgpWbGFkaW1pcgoKPiAKPiBUaGFua3MsCj4g
Cj4gwqDCoMKgwqDCoMKgwqAgTS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlh
LmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFy
bQo=
