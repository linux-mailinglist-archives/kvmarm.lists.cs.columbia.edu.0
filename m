Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A98604CCF4A
	for <lists+kvmarm@lfdr.de>; Fri,  4 Mar 2022 08:52:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E07BA49B0C;
	Fri,  4 Mar 2022 02:52:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 75sN9zPBXMhs; Fri,  4 Mar 2022 02:52:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8184849E10;
	Fri,  4 Mar 2022 02:52:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0184C4965C
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Mar 2022 02:52:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yN8I7JIAdH+f for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Mar 2022 02:52:05 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9067D408B3
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Mar 2022 02:52:05 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6744461DBE;
 Fri,  4 Mar 2022 07:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA45DC340E9;
 Fri,  4 Mar 2022 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646380323;
 bh=ksGhUZhDgdzk0utLY0Dcn6F8E39I3EjEeqPACeNWMw8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jifwQ2QFazXC1dOwK/e3N7ouvYVg57p3UYOvf0eSkvJXGQIZ0P6bNaU8ZXgj0Fro7
 flchprpcyCBvm8LZmigzGmmM0hMnMRmbhf81Llyui6tkLOufagrwQE3ixRnj9gVicM
 x7/YqtaB0HWWW0g1S7my/chbST6rVS2AwIr9JJqCDDFnN4cDRskUhxUbBol1rh21iO
 C9U3OlOOOqYrv2oWxXTmXLiu2r57CPiClrRA1ofGVklqXbXDsMSgGlrIez/9ZuIt0p
 EzZ/3R9H3BrcE/eMNo42kAV8gAbEgG+382t7gM0oIK9DWfZPifvVvXAsku+Fh6ID7t
 Qw6NI4vNUpVIA==
Received: from ip-185-104-136-29.ptr.icomera.net ([185.104.136.29]
 helo=billy-the-mountain.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nQ2jJ-00C9EA-8J; Fri, 04 Mar 2022 07:52:01 +0000
Date: Fri, 04 Mar 2022 07:52:00 +0000
Message-ID: <87h78etasf.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH 2/3] KVM: arm64: selftests: add arch_timer_edge_cases
In-Reply-To: <Yh/gyN7Xu54SpWBx@google.com>
References: <20220302172144.2734258-1-ricarkol@google.com>
 <20220302172144.2734258-3-ricarkol@google.com>
 <Yh/XgYAbqCYguegJ@google.com> <Yh/gyN7Xu54SpWBx@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.104.136.29
X-SA-Exim-Rcpt-To: ricarkol@google.com, oupton@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, drjones@redhat.com, pbonzini@redhat.com,
 alexandru.elisei@arm.com, eric.auger@redhat.com, reijiw@google.com,
 rananta@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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

T24gV2VkLCAwMiBNYXIgMjAyMiAyMToyNToyOCArMDAwMCwKUmljYXJkbyBLb2xsZXIgPHJpY2Fy
a29sQGdvb2dsZS5jb20+IHdyb3RlOgo+IAo+IEhpIE9saXZlciwKPiAKPiBPbiBXZWQsIE1hciAw
MiwgMjAyMiBhdCAwODo0NTo1M1BNICswMDAwLCBPbGl2ZXIgVXB0b24gd3JvdGU6Cj4gPiBIaSBS
aWNhcmRvLAo+ID4gCj4gPiBPbiBXZWQsIE1hciAwMiwgMjAyMiBhdCAwOToyMTo0M0FNIC0wODAw
LCBSaWNhcmRvIEtvbGxlciB3cm90ZToKPiA+ID4gQWRkIGFuIGFyY2hfdGltZXIgZWRnZS1jYXNl
cyBzZWxmdGVzdC4gRm9yIG5vdywganVzdCBhZGQgc29tZSBiYXNpYwo+ID4gPiBzYW5pdHkgY2hl
Y2tzLCBhbmQgc29tZSBzdHJlc3MgY29uZGl0aW9ucyAobGlrZSB3YWl0aW5nIGZvciB0aGUgdGlt
ZXJzCj4gPiA+IHdoaWxlIHJlLXNjaGVkdWxpbmcgdGhlIHZjcHUpLiBUaGUgbmV4dCBjb21taXQg
d2lsbCBhZGQgdGhlIGFjdHVhbCBlZGdlCj4gPiA+IGNhc2UgdGVzdHMuCj4gPiA+IAo+ID4gPiBU
aGlzIHRlc3QgZmFpbHMgd2l0aG91dCBhODY3ZTlkMGNjMSAiS1ZNOiBhcm02NDogRG9uJ3QgbWlz
cyBwZW5kaW5nCj4gPiA+IGludGVycnVwdHMgZm9yIHN1c3BlbmRlZCB2Q1BVIi4KPiA+ID4gCj4g
PiAKPiA+IFRlc3RpbmcgdGltZXIgY29ycmVjdG5lc3MgaXMgZXh0cmVtZWx5IGNoYWxsZW5naW5n
IHRvIGRvIHdpdGhvdXQKPiA+IGluaGVyZW50IGZsYWtpbmVzcy4gSSBoYXZlIHNvbWUgY29uY2Vy
bnMgYWJvdXQgdGhlIGV4cGVjdGF0aW9ucyB0aGF0IGEKPiA+IHRpbWVyIElSUSBzaG91bGQgZmly
ZSBpbiBhIGdpdmVuIGFtb3VudCBvZiB0aW1lLCBhcyBpdCBpcyBwb3NzaWJsZSB0bwo+ID4gZmxh
a2UgZm9yIGFueSBudW1iZXIgb2YgYmVuaWduIHJlYXNvbnMgKHN1Y2ggYXMgaGlnaCBDUFUgbG9h
ZCBpbiB0aGUKPiA+IGhvc3QpLgo+ID4gCj4gPiBXaGlsZSB0aGUgYXJjaGl0ZWN0dXJlIG1heSBz
dWdnZXN0IHRoYXQgdGhlIHRpbWVyIHNob3VsZCBmaXJlIGFzIHNvb24gYXMKPiA+IENWQUwgaXMg
bWV0Ogo+ID4gCj4gPiAgIFRpbWVyQ29uZGl0aW9uTWV0ID0gKCgoQ291bnRlcls2MzowXSDigJMg
T2Zmc2V0WzYzOjBdKVs2MzowXSAtIENvbXBhcmVWYWx1ZVs2MzowXSkgPj0gMCkKPiA+IAo+ID4g
SG93ZXZlciwgdGhlIGFyY2hpdGVjdHVyZSBpcyBleHRyZW1lbHkgaW1wcmVjaXNlIGFzIHRvIHdo
ZW4gYW4gaW50ZXJydXB0Cj4gPiBzaG91bGQgYmUgdGFrZW46Cj4gPiAKPiA+ICAgSW4gdGhlIGFi
c2VuY2Ugb2YgYSBzcGVjaWZpYyByZXF1aXJlbWVudCB0byB0YWtlIGFuIGludGVycnVwdCwgdGhl
Cj4gPiAgIGFyY2hpdGVjdHVyZSBvbmx5IHJlcXVpcmVzIHRoYXQgdW5tYXNrZWQgcGVuZGluZyBp
bnRlcnJ1cHRzIGFyZSB0YWtlbgo+ID4gICBpbiBmaW5pdGUgdGltZS4gW0RESTA0ODdHLmIgRDEu
MTMuNCAiUHJpb3JpdGl6YXRpb24gYW5kIHJlY29nbml0aW9uIG9mCj4gPiAgIGludGVycnVwdHMi
XQo+ID4gCj4gPiBJdCBzZWVtcyB0byBtZSB0aGF0IHRoZSBvbmx5IHRoaW5nIHdlIGNhbiBwb3Np
dGl2ZWx5IGFzc2VydCBpcyB0aGF0IGEKPiA+IHRpbWVyIGludGVycnVwdCBzaG91bGQgbmV2ZXIg
YmUgdGFrZW4gZWFybHkuIE5vdyAtLSBJIGFncmVlIHRoYXQgdGhlcmUKPiA+IGlzIHZhbHVlIGlu
IHRlc3RpbmcgdGhhdCB0aGUgaW50ZXJydXB0IGJlIHRha2VuIGluIGJvdW5kZWQgdGltZSwgYnV0
IGl0cwo+ID4gaGFyZCB0byBwaWNrIGEgZ29vZCB2YWx1ZSBmb3IgaXQuCj4gCj4gWWVzLCBhIHRp
bWVyIHRoYXQgbmV2ZXIgZmlyZXMgcGFzc2VzIHRoZSB0ZXN0LCBidXQgaXQncyBub3QgdmVyeSB1
c2VmdWwuCj4gCj4gSSBzYXcgZGVsYXkgaXNzdWVzIGltbWVkaWF0ZWx5IGFmdGVyIHRlc3Rpbmcg
d2l0aCBRRU1VLiBJJ3ZlIGJlZW4gcGxheWVkCj4gd2l0aCB2YWx1ZXMgYW5kIGZvdW5kIHRoYXQg
MW1zIGlzIGVub3VnaCBmb3IgYWxsIG9mIG15IHJ1bnMgKFFFTVUKPiBpbmNsdWRlZCkgdG8gcGFz
cyAoMTAwMDAgaXRlcmF0aW9ucyBjb25jdXJyZW50bHkgb24gYWxsIG15IDY0IGNwdXMpLiBJCj4g
anVzdCBjaGVja2VkIGluIHRoZSBmYXN0IG1vZGVsIGFuZCAxbXMgc2VlbXMgdG8gYmUgZW5vdWdo
IGFzIHdlbGwKPiAoYWx0aG91Z2ggSSBkaWRuJ3QgY2hlY2sgZm9yIHNvIGxvbmcpLgo+IAo+IAkv
KiAxbXMgc291bmRzIGEgYml0IGV4Y2Vzc2l2ZSwgYnV0IFFFTVUtVENHIGlzIHNsb3cuICovCj4g
CSNkZWZpbmUgVEVTVF9NQVJHSU5fVVMJCQkxMDAwVUxMCgpJJ20gbm90IHN1cmUgdGhhdCdzIGV2
ZW4gcmVhbGlzdGljLiBJIGNhbiBhcmJpdHJhcnkgZGVsYXkgdGhvc2UgYnkKb3ZlcnN1YnNjcmli
aW5nIHRoZSBzeXN0ZW0uCgo+IAo+ID4gCj4gPiBQZXJoYXBzIGRvY3VtZW50aW5nIHRoZSBwb3Nz
aWJpbGl0eSBvZiBmbGFrZXMgaW4gdGhlIHRlc3QgaXMgd2FycmFudGVkLAo+ID4gYWxvbmcgd2l0
aCBzb21lIGtub2JzIHRvIGFkanVzdCB0aGVzZSB2YWx1ZXMgZm9yIGFueSBwYXJ0aWN1bGFybHkg
YmFkCj4gPiBpbXBsZW1lbnRhdGlvbi4KPiAKPiBXaGF0IGFib3V0IGhhdmluZyBhIGNtZGxpbmUg
YXJnIHRvIGVuYWJsZSB0aG9zZSB0ZXN0cz8KCkhvdyBpcyB0aGF0IGhhbmRsZWQgaW4ga3ZtLXVu
aXQtdGVzdHM/IEknZCByYXRoZXIgYXZvaWQgc3BlY2lhbAphcmd1bWVudHMsIGFzIHRoZXkgd2ls
bCBuZXZlciBiZSBzZXQuIEFsbCB0ZXN0cyBzaG91bGQgcnVuIGJ5IGRlZmF1bHQuCgoJTS4KCi0t
IApXaXRob3V0IGRldmlhdGlvbiBmcm9tIHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2li
bGUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFy
bSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3Rz
LmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
