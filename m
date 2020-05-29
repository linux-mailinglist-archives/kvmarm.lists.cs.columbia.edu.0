Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 798161E799C
	for <lists+kvmarm@lfdr.de>; Fri, 29 May 2020 11:41:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F1F174B213;
	Fri, 29 May 2020 05:41:51 -0400 (EDT)
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
	with ESMTP id UqwkaVuo7E39; Fri, 29 May 2020 05:41:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A05E74B1D3;
	Fri, 29 May 2020 05:41:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C32654B1BE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 05:41:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o15oMQhcelRF for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 May 2020 05:41:47 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B88934B16C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 05:41:47 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8050720810;
 Fri, 29 May 2020 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590745306;
 bh=7656s4eYWhYzzAhobQ/p864RjB2diU/xpekCGE7YNZ0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VQmr+kTgz6xT6jL5yWNdjI6CmqoEcxAQUP7Yjg5gfK3TvAVPbNdb45ezQRJ9TGm5G
 TYEBNnIFHaH7aClx19eT+daZr2aERlM073SlgHsQTree3AC6yibKxy1OhiiSgkbohN
 obMAXKU++5wiqUu1N0nZETdr3VtZjSVNHuHPj2mA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jebWK-00GEXJ-Vz; Fri, 29 May 2020 10:41:45 +0100
MIME-Version: 1.0
Date: Fri, 29 May 2020 10:41:44 +0100
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
In-Reply-To: <6a4a82a4-af01-98c2-c854-9199f55f7bd3@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
 <8ab64c6a-582b-691d-79ab-21cdc0455cd3@redhat.com>
 <6a4a82a4-af01-98c2-c854-9199f55f7bd3@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <6965aaf641a23fab64fbe2ceeb790272@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, pbonzini@redhat.com,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, will@kernel.org,
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

T24gMjAyMC0wNS0yOSAwMDowMiwgR2F2aW4gU2hhbiB3cm90ZToKPiBIaSBQYW9sbywKPiAKPiBP
biA1LzI4LzIwIDg6NDggUE0sIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4+IE9uIDI4LzA1LzIwIDA4
OjE0LCBHYXZpbiBTaGFuIHdyb3RlOgo+Pj4+IC0gZm9yIHg4NiB3ZSdyZSBhbHNvIHRoaW5raW5n
IG9mIGluaXRpYXRpbmcgdGhlIHBhZ2UgZmF1bHQgZnJvbSB0aGUKPj4+PiBleGNlcHRpb24gaGFu
ZGxlciwgcmF0aGVyIHRoYW4gZG9pbmcgc28gZnJvbSB0aGUgaHlwZXJ2aXNvciBiZWZvcmUKPj4+
PiBpbmplY3RpbmcgdGhlIGV4Y2VwdGlvbi7CoCBJZiBBUk0gbGVhZHMgdGhlIHdheSBoZXJlLCB3
ZSB3b3VsZCBkbyBvdXIKPj4+PiBiZXN0IHRvIHNoYXJlIGNvZGUgd2hlbiB4ODYgZG9lcyB0aGUg
c2FtZS4KPj4+IAo+Pj4gU29ycnksIFBhb2xvLCBJIGRvbid0IGZvbGxvdyB5b3VyIGlkZWEgaGVy
ZS4gQ291bGQgeW91IHBsZWFzZSBwcm92aWRlCj4+PiBtb3JlIGRldGFpbHM/Cj4+IAo+PiBUaGUg
aWRlYSBpcyB0byBpbmplY3Qgc3RhZ2UyIHBhZ2UgZmF1bHRzIGludG8gdGhlIGd1ZXN0IGV2ZW4g
YmVmb3JlIAo+PiB0aGUKPj4gaG9zdCBzdGFydHMgcG9wdWxhdGVzIHRoZSBwYWdlLiAgVGhlIGd1
ZXN0IHRoZW4gaW52b2tlcyBhIGh5cGVyY2FsbCwKPj4gdGVsbGluZyB0aGUgaG9zdCB0byBwb3B1
bGF0ZSB0aGUgcGFnZSB0YWJsZSBhbmQgaW5qZWN0IHRoZSAncGFnZSAKPj4gcmVhZHknCj4+IGV2
ZW50IChpbnRlcnJ1cHQpIHdoZW4gaXQncyBkb25lLgo+PiAKPj4gRm9yIHg4NiB0aGUgYWR2YW50
YWdlIGlzIHRoYXQgdGhlIHByb2Nlc3NvciBjYW4gdGFrZSBjYXJlIG9mIHJhaXNpbmcgCj4+IHRo
ZQo+PiBzdGFnZTIgcGFnZSBmYXVsdCBpbiB0aGUgZ3Vlc3QsIHNvIGl0J3MgZmFzdGVyLgo+PiAK
PiBJIHRoaW5rIHRoZXJlIG1pZ2h0IGJlIHRvbyBtdWNoIG92ZXJoZWFkIGlmIHRoZSBwYWdlIGNh
biBiZSBwb3B1bGF0ZWQKPiBxdWlja2x5IGJ5IGhvc3QuIEZvciBleGFtcGxlLCBpdCdzIGZhc3Qg
dG8gcG9wdWxhdGUgdGhlIHBhZ2VzIGlmIHN3YXBpbgo+IGlzbid0IGludm9sdmVkLgo+IAo+IElm
IEknbSBjb3JyZWN0IGVub3VnaCwgaXQgc2VlbXMgYXJtNjQgZG9lc24ndCBoYXZlIHNpbWlsYXIg
bWVjaGFuaXNtLAo+IHJvdXRpbmcgc3RhZ2UyIHBhZ2UgZmF1bHQgdG8gZ3Vlc3QuCgpJbmRlZWQs
IHRoaXMgaXNuJ3QgYSB0aGluZyBvbiBhcm02NC4gRXhjZXB0aW9uIGNhdXNlZCBieSBhIFMyIGZh
dWx0IGFyZQphbHdheXMgcm91dGVkIHRvIEVMMi4KCiAgICAgICAgIE0uCi0tIApKYXp6IGlzIG5v
dCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0cy5j
cy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9saXN0
aW5mby9rdm1hcm0K
