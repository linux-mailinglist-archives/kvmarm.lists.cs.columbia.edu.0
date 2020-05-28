Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CA3501E59E4
	for <lists+kvmarm@lfdr.de>; Thu, 28 May 2020 09:53:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6774C4B213;
	Thu, 28 May 2020 03:53:23 -0400 (EDT)
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
	with ESMTP id aUEUKkzdnC6F; Thu, 28 May 2020 03:53:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C56364B230;
	Thu, 28 May 2020 03:53:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 509554B08A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 May 2020 02:34:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVhKCB6OZBCo for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 May 2020 02:34:20 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 76B914A125
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 May 2020 02:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590647660;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0TbfU1Wtk9UqNPHb2mnR7GHgRz5NlicH2MG30iIhdQ=;
 b=OjwtmTh0zrTrT55C1ugNY2uw/mCJiqwKZQPEcS9nFMDoY7Uj8LOigV5n9YQzGECOMVXP5Q
 UCVszqXIQFgl5u7w1vyTkSGzLnYxdhO09ZDldXEe0h+d1I4w9SXCeoHmN9ZTgQAafVqfnk
 X6YWrIvsBJSxvpMNQ4Vt8//23QvCE/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-V0gHZIGzPNaVCuaWjLDYHA-1; Thu, 28 May 2020 02:34:16 -0400
X-MC-Unique: V0gHZIGzPNaVCuaWjLDYHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9313E1005510;
 Thu, 28 May 2020 06:34:14 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-130.bne.redhat.com
 [10.64.54.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 048385C1B0;
 Thu, 28 May 2020 06:34:07 +0000 (UTC)
Subject: Re: [PATCH RFCv2 3/9] kvm/arm64: Rename kvm_vcpu_get_hsr() to
 kvm_vcpu_get_esr()
To: Marc Zyngier <maz@kernel.org>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-4-gshan@redhat.com>
 <20200526104249.GB1363@C02TD0UTHF1T.local>
 <2e4dd03f-656a-c32b-5e87-ca28583999ef@redhat.com>
 <359dad5546a428ea963781f2728e70bf@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <e71af813-7f72-9d2e-2419-f4e03cf35369@redhat.com>
Date: Thu, 28 May 2020 16:34:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <359dad5546a428ea963781f2728e70bf@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mailman-Approved-At: Thu, 28 May 2020 03:53:17 -0400
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

T24gNS8yNy8yMCA1OjIwIFBNLCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4gT24gMjAyMC0wNS0yNyAw
Mzo0MywgR2F2aW4gU2hhbiB3cm90ZToKPj4gSGkgTWFyaywKPj4KPj4gT24gNS8yNi8yMCA4OjQy
IFBNLCBNYXJrIFJ1dGxhbmQgd3JvdGU6Cj4+PiBPbiBGcmksIE1heSAwOCwgMjAyMCBhdCAwMToy
OToxM1BNICsxMDAwLCBHYXZpbiBTaGFuIHdyb3RlOgo+Pj4+IFNpbmNlIGt2bS9hcm0zMiB3YXMg
cmVtb3ZlZCwgdGhpcyByZW5hbWVzIGt2bV92Y3B1X2dldF9oc3IoKSB0bwo+Pj4+IGt2bV92Y3B1
X2dldF9lc3IoKSB0byBpdCBhIGJpdCBtb3JlIHNlbGYtZXhwbGFpbmluZyBiZWNhdXNlIHRoZQo+
Pj4+IGZ1bmN0aW9ucyByZXR1cm5zIEVTUiBpbnN0ZWFkIG9mIEhTUiBvbiBhYXJjaDY0LiBUaGlz
IHNob3VsZG4ndAo+Pj4+IGNhdXNlIGFueSBmdW5jdGlvbmFsIGNoYW5nZXMuCj4+Pj4KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPgo+Pj4KPj4+IEkgdGhp
bmsgdGhhdCB0aGlzIHdvdWxkIGJlIGEgbmljZSBjbGVhbnVwIG9uIGl0cyBvd24sIGFuZCBjb3Vs
ZCBiZSB0YWtlbgo+Pj4gaW5kZXBlbmRlbnRseSBvZiB0aGUgcmVzdCBvZiB0aGlzIHNlcmllcyBp
ZiBpdCB3ZXJlIHJlYmFzZWQgYW5kIHNlbnQgYXMKPj4+IGEgc2luZ2xlIHBhdGNoLgo+Pj4KPj4K
Pj4gWWVhaCwgSSdsbCBzZWUgaG93IFBBVENIWzMsNCw1XSBjYW4gYmUgcG9zdGVkIGluZGVwZW5k
ZW50bHkKPj4gYXMgcGFydCBvZiB0aGUgcHJlcGFyYXRvcnkgd29yaywgd2hpY2ggaXMgc3VnZ2Vz
dGVkIGJ5IHlvdQo+PiBpbiBhbm90aGVyIHJlcGx5Lgo+Pgo+PiBCeSB0aGUgd2F5LCBJIGFzc3Vt
ZSB0aGUgY2xlYW51cCBwYXRjaGVzIGFyZSBnb29kIGVub3VnaCB0bwo+PiB0YXJnZXQgNS44LnJj
MS9yYzIgaWYgeW91IGFncmVlLgo+IAo+IEl0J3MgZmluZSB0byBiYXNlIHRoZW0gb24gLXJjMSBv
ciAtcmMyLiBUaGV5IHdpbGwgbm90IGJlIG1lcmdlZAo+IGJlZm9yZSA1LjkgdGhvdWdoLgo+IAo+
IFRoYW5rcywKPiAKPiAgwqDCoMKgwqDCoMKgwqAgTS4KClN1cmUsIFRoYW5rcywgTWFyYyEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWls
aW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNv
bHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
