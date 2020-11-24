Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C549D2C2383
	for <lists+kvmarm@lfdr.de>; Tue, 24 Nov 2020 12:02:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52D7F4BD16;
	Tue, 24 Nov 2020 06:02:18 -0500 (EST)
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
	with ESMTP id EgkKEl+3k3cN; Tue, 24 Nov 2020 06:02:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 207034BD11;
	Tue, 24 Nov 2020 06:02:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 21F604BCA5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Nov 2020 06:02:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xq6xamjeZEVR for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Nov 2020 06:02:15 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 035C74BC74
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Nov 2020 06:02:14 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A9E82083E;
 Tue, 24 Nov 2020 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606215733;
 bh=1cxLgDpJmbdMl+KoljU+RVmexumupWZLEWD2oMoaKUU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=q75xZPDVFkN48q5ixVGY/INzSkna2IoQiNKgDb4iGJT45iswpwLADZaC+ly61ri94
 8re58ReAIjl1Tnv1nU4Or8bpJk8xty90DFENNPZRJeKjb7j+ycPeOjyIMlv6xGWwzZ
 3eBoXOh0wLdMYbdnDeNWJqq/1f0SacT67S0XRqYc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1khW5L-00DE77-AT; Tue, 24 Nov 2020 11:02:11 +0000
MIME-Version: 1.0
Date: Tue, 24 Nov 2020 11:02:11 +0000
From: Marc Zyngier <maz@kernel.org>
To: Jingyi Wang <wangjingyi11@huawei.com>
Subject: Re: [RFC PATCH 0/4] Add support for ARMv8.6 TWED feature
In-Reply-To: <9d341a2d-19f8-400c-6674-ef991ab78f62@huawei.com>
References: <20200929091727.8692-1-wangjingyi11@huawei.com>
 <9d341a2d-19f8-400c-6674-ef991ab78f62@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <10463cb9a0ae167a89300185c1de348c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangjingyi11@huawei.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 wanghaibin.wang@huawei.com, yezengruan@huawei.com,
 shameerali.kolothum.thodi@huawei.com, fanhenglong@huawei.com,
 prime.zeng@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, catalin.marinas@arm.com, fanhenglong@huawei.com,
 prime.zeng@hisilicon.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

T24gMjAyMC0xMS0xMyAwNzo1NCwgSmluZ3lpIFdhbmcgd3JvdGU6Cj4gSGkgYWxs77yMCj4gCj4g
U29ycnkgZm9yIHRoZSBkZWxheS4gSSBoYXZlIGJlZW4gdGVzdGluZyB0aGUgVFdFRCBmZWF0dXJl
IHBlcmZvcm1hbmNlCj4gbGF0ZWx5LiBXZSBzZWxlY3QgdW5peGJlbmNoIGFzIHRoZSBiZW5jaG1h
cmsgZm9yIHNvbWUgaXRlbXMgb2YgaXQgaXMKPiBsb2NrLWludGVuc2l2ZShmc3RpbWUvZnNidWZm
ZXIvZnNkaXNrKS4gV2UgcnVuIHVuaXhiZW5jaCBvbiBhIDQtVkNQVQo+IFZNLCBhbmQgYmluZCBl
dmVyeSB0d28gVkNQVXMgb24gb25lIFBDUFUuIEZpeGVkIFRXRUQgdmFsdWUgaXMgdXNlZCBhbmQK
PiBoZXJlIGlzIHRoZSByZXN1bHQuCgpIb3cgcmVwcmVzZW50YXRpdmUgaXMgdGhpcz8KClRCSCwg
SSBvbmx5IGtub3cgb2YgdHdvIHJlYWwgd29ybGQgY29uZmlndXJhdGlvbnM6IG9uZSB3aGVyZQp0
aGUgdkNQVXMgYXJlIHBpbm5lZCB0byBkaWZmZXJlbnQgcGh5c2ljYWwgQ1BVcyAoYW5kIGluIHRo
aXMKY2FzZSB5b3VyIHBhdGNoIGhhcyBhYnNvbHV0ZWx5IG5vIGVmZmVjdCBhcyBsb25nIGFzIHRo
ZXJlIGlzCm5vIGNvbmN1cnJlbnQgdGFza3MpLCBhbmQgb25lIHdoZXJlIHRoZXJlIGlzIG92ZXJz
dWJzY3JpcHRpb24sCmFuZCB0aGUgc2NoZWR1bGVyIG1vdmVzIHRoaW5ncyBhcm91bmQgYXMgaXQg
c2VlcyBmaXQsIGRlcGVuZGluZwpvbiB0aGUgbG9hZC4KCkhhdmluZyB0d28gdkNQVXMgcGlubmVk
IHBlciBDUFUgZmVlbHMgbGlrZSBhIHRlc3QgdGhhdCBoYXMgYmVlbgpwaWNrZWQgdG8gZ2l2ZSB0
aGUgcmVzdWx0IHlvdSB3YW50ZWQuIEknZCBsaWtlIHRvIHNlZSB0aGUgZnVsbApwaWN0dXJlLCBp
bmNsdWRpbmcgdGhlIGNhc2UgdGhhdCBtYXR0ZXJzIGZvciBjdXJyZW50IHVzZSBjYXNlcy4KSSdt
IHNwZWNpYWxseSBpbnRlcmVzdGVkIGluIHRoZSBjYXNlcyB3aGVyZSB0aGUgc3lzdGVtIGlzCm92
ZXJzdWJzY3JpYmVkLCBiZWNhdXNlIFRXRUQgaXMgZGVmaW5pdGVseSBnb2luZyB0byBzY3JldyB3
aXRoCnRoZSBzY2hlZHVsZXIgbGF0ZW5jeS4KClRoYW5rcywKCiAgICAgICAgIE0uCi0tIApKYXp6
IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBmdW5ueS4uLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBs
aXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1h
bi9saXN0aW5mby9rdm1hcm0K
