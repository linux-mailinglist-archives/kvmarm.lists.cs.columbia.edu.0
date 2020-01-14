Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 56F4F13A2E1
	for <lists+kvmarm@lfdr.de>; Tue, 14 Jan 2020 09:21:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB7124B072;
	Tue, 14 Jan 2020 03:21:04 -0500 (EST)
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
	with ESMTP id bmusEt6qmljN; Tue, 14 Jan 2020 03:21:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B9F3F4B06F;
	Tue, 14 Jan 2020 03:21:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E8DA24A4F6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jan 2020 03:21:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7VRu-AcBb9H5 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Jan 2020 03:21:00 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [205.139.110.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D85D24A3A5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Jan 2020 03:21:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578990060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuWgcBzyxfCZHiZvCkvjwdRcBMrfoCkxiwSI2/QXtic=;
 b=SaI4/us4C7hys9J19qZ59ukWTWyrIVdOfLQDY65wp7NOfj+SEsVbxisZOfJ2Q8KyAC4ziC
 ixjnpiWDlmX4b2zghgCFqlL4uWIG4orAplw1Z2d59LnoM/HqyFS3EpwiaZC1qtvchtzzyK
 5fh4fDBODA3Wsgo/PjInjuonhtaFITY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-QV_CL5bGPSqijPl5J2PZ6g-1; Tue, 14 Jan 2020 03:20:56 -0500
X-MC-Unique: QV_CL5bGPSqijPl5J2PZ6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4D7800A02;
 Tue, 14 Jan 2020 08:20:54 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 592175D9E5;
 Tue, 14 Jan 2020 08:20:52 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Check hopefully the last
 DISCARD command error
To: Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org
References: <20191225133014.1825-1-yuzenghui@huawei.com>
 <f9997198-c990-d638-24d0-41d6280a9d8a@redhat.com>
 <41c88abb-433a-f87c-c858-7f2eb4c40926@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <615c4713-d00e-e2f7-c2d4-fa8047355c9b@redhat.com>
Date: Tue, 14 Jan 2020 09:20:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <41c88abb-433a-f87c-c858-7f2eb4c40926@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: andre.przywara@arm.com, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

SGkgWmVuZ2h1aSwKCk9uIDEvMTQvMjAgODoxMCBBTSwgWmVuZ2h1aSBZdSB3cm90ZToKPiBIaSBF
cmljLAo+IAo+IE9uIDIwMjAvMS8xMCAxNjozNywgQXVnZXIgRXJpYyB3cm90ZToKPj4gSGkgWmVu
Z2h1aSwKPj4KPj4gT24gMTIvMjUvMTkgMjozMCBQTSwgWmVuZ2h1aSBZdSB3cm90ZToKPj4+IERJ
U0NBUkQgY29tbWFuZCBlcnJvciBvY2N1cnMgaWYgYW55IG9mIHRoZSBmb2xsb3dpbmcgYXBwbHk6
Cj4+Pgo+Pj4gwqAgLSBbIC4uLiAodGhvc2Ugd2hpY2ggd2UgaGF2ZSBhbHJlYWR5IGhhbmRsZWQp
IF0KPj4gbml0OiBJIHdvdWxkIHJlbW92ZSB0aGUgYWJvdmUgYW5kIHNpbXBseSBzYXkgdGhlIGRp
c2NhcmQgaXMgc3VwcG9zZWQgdG8KPj4gZmFpbCBpZiB0aGUgY29sbGVjdGlvbiBpcyBub3QgbWFw
cGVkIHRvIGFueSB0YXJnZXQgcmVkaXN0cmlidXRvci4gSWYgYW4KPj4gSVRFIGV4aXN0cyB0aGVu
IHRoZSBpdGUtPmNvbGxlY3Rpb24gaXMgbm9uIE5VTEwuCj4gCj4gSSB0aGluayB0aGlzIGlzIG5v
dCBhbHdheXMgdHJ1ZS4gTGV0J3MgdGFsayBhYm91dCB0aGUgZm9sbG93aW5nIHNjZW5hcmlvCj4g
KGEgYml0IGluc2FuZSwgdGhvdWdoKToKPiAKPiAxLiBGaXJzdCBtYXAgYSBMUEkgdG8gYW4gdW5t
YXBwZWQgQ29sbGVjdGlvbiwgdGhlbiBpdGUtPmNvbGxlY3Rpb24gaXMKPiDCoMKgIG5vbiBOVUxM
IGFuZCBpdHMgdGFyZ2V0X2FkZHIgaXMgQ09MTEVDVElPTl9OT1RfTUFQUEVELgo+IAo+IDIuIFRo
ZW4gaXNzdWUgTUFQQyBhbmQgdW5NQVBDKFY9MCkgY29tbWFuZHMgb24gdGhpcyBDb2xsZWN0aW9u
LCB0aGUKPiDCoMKgIGl0ZS0+Y29sbGVjdGlvbiB3aWxsIGJlIE5VTEwsIHNlZSB2Z2ljX2l0c19m
cmVlX2NvbGxlY3Rpb24oKS4KWW91J3JlIHJpZ2h0IEkgbWlzc2VkIHRoYXQgY2FzZS4KPiAKPiBE
aXNjYXJkIHRoZSBMUEkgbWFwcGluZyBhZnRlciAiMSIgb3IgIjIiLCB3ZSB3aWxsIGJvdGggZW5j
b3VudGVyIHRoZQo+IHVubWFwcGVkIGNvbGxlY3Rpb24gY29tbWFuZCBlcnJvci4KPiAKPj4gV2hh
dCBuZWVkcyB0byBiZSBjaGVja2VkIGlzIGl0c19pc19jb2xsZWN0aW9uX21hcHBlZCgpLgo+Pgo+
PiBCeSB0aGUgd2F5IHVwZGF0ZV9hZmZpbml0eV9jb2xsZWN0aW9uKCkgYWxzbyB0ZXN0cyBpdGUt
PmNvbGxlY3Rpb24uIEkKPj4gdGhpbmsgdGhpcyBpcyB1c2VsZXNzIG9yIGRvIEkgbWlzcyBzb21l
dGhpbmc/Cj4gCj4gWWVhaCwgSSBhZ3JlZS4gV2UgbWFuYWdlZCB0byBpbnZva2UgdXBkYXRlX2Fm
ZmluaXR5X2NvbGxlY3Rpb24oLCwgY29sbCksCj4gZW5zdXJlIHRoYXQgdGhlICdjb2xsJyBjYW4g
X25vdF8gYmUgTlVMTC4KPiBTbyAnIWl0ZS0+Y29sbGVjdGlvbicgaXMgYWxyZWFkeSBhIHN1YmNh
c2Ugb2YgJ2NvbGwgIT0gaXRlLT5jb2xsZWN0aW9uJy4KPiBXZSBjYW4gc2FmZWx5IGdldCByaWQg
b2YgaXQuCk9LLiBCdXQgdGhhdCdzIG5vdCBmb3IgdGhlICh3cm9uZykgcmVhc29uIEkgbWVudGlv
bmVkIGFib3ZlLiBTbyBpdCBpcyBhCm1pbm9yIGNsZWFudXAgYW5kIHlvdSBtYXkganVzdCBsZWF2
ZSBpdCBhcyBpcyBhbmQganVzdCBmb2N1cyBvbiB0aGlzIGZpeC4KClRoYW5rcwoKRXJpYwo+IAo+
Pgo+PiBSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgo+Pgo+
IAo+IFRoYW5rcyBmb3IgdGhhdC4gSSdsbCBjaGFuZ2UgdGhlIGNvbW1pdCBtZXNzYWdlIHdpdGgg
eW91ciBzdWdnZXN0aW9uIGFuZAo+IGFkZCB5b3VyIFItYiBpbiB2Mi4KPiAKPiAKPiBUaGFua3Ms
Cj4gWmVuZ2h1aQo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKPiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3Rz
LmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xp
c3RpbmZvL2t2bWFybQo=
