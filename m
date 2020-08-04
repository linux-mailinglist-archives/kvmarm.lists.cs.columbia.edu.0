Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7657323BAF9
	for <lists+kvmarm@lfdr.de>; Tue,  4 Aug 2020 15:18:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0DF4F4B7B0;
	Tue,  4 Aug 2020 09:18:19 -0400 (EDT)
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
	with ESMTP id s2IqwhGVqwVV; Tue,  4 Aug 2020 09:18:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B96F94B7A3;
	Tue,  4 Aug 2020 09:18:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2939E4B7A1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Aug 2020 09:18:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ESiMgcjehaVI for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Aug 2020 09:18:15 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 128E44B797
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Aug 2020 09:18:15 -0400 (EDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F2156207FC
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Aug 2020 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596547094;
 bh=wm1oWIkz07CI36FMnq4rtXhsNGI+Mj4JBSlrCfDJPAc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0jgn1VYqfdxa5LdhVuzklR9cLtBODKcqNJ3aBUxv4msLpxK6Sz3egMCyEhYBSiCKB
 3p+23CyCty+EfglMWaGZyDH6lSCnMIdQjMUbpmFpBR6RemHzEP7Iru2dR2i0xg/jFS
 ws7XFMfZlkhTK/LIBlLFHdZY9RlLwyMK2llPUhtE=
Received: by mail-ot1-f49.google.com with SMTP id q9so14855498oth.5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 04 Aug 2020 06:18:13 -0700 (PDT)
X-Gm-Message-State: AOAM533tN8T6VFnrXXVY24s0iJ15n/SRlCFg2OhA8FIXrYU07STq1E8Z
 8Jxt5An5Tlp+vER3AkNIrz2sUWWohFdrWnHNI1I=
X-Google-Smtp-Source: ABdhPJzHxSRDNEtGr5s2Fp+eY2I9/mBGbmaBN6cxwMOl06eur/SxYwUp7Y6U9Pc9z5WiTzXxj2I/7LwkJQ/wxudGz9c=
X-Received: by 2002:a9d:3a04:: with SMTP id j4mr17263203otc.108.1596547093325; 
 Tue, 04 Aug 2020 06:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200804124417.27102-1-alex.bennee@linaro.org>
In-Reply-To: <20200804124417.27102-1-alex.bennee@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Aug 2020 15:18:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXErSf7sQ4pPu-1em4AM=9JejA_-w3iwv4Wt=dgbQHxp-g@mail.gmail.com>
Message-ID: <CAMj1kXErSf7sQ4pPu-1em4AM=9JejA_-w3iwv4Wt=dgbQHxp-g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] put arm64 kvm_config on a diet
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

T24gVHVlLCA0IEF1ZyAyMDIwIGF0IDE0OjQ1LCBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmc+IHdyb3RlOgo+Cj4gSGksCj4KPiBXaGVuIGJ1aWxkaW5nIGd1ZXN0IGtlcm5lbHMg
Zm9yIHZpcnR1YWxpc2F0aW9uIHdlIHdlcmUgYnJpbmdpbmcgaW4gYQo+IGJ1bmNoIG9mIHN0dWZm
IGZyb20gcGh5c2ljYWwgaGFyZHdhcmUgd2hpY2ggd2UgZG9uJ3QgbmVlZCBmb3Igb3VyCj4gaWRl
YWxpc2VkIGZpeGFibGUgdmlydHVhbCBQQ0kgZGV2aWNlcy4gVGhpcyBzZXJpZXMgbWFrZXMgc29t
ZSBLY29uZmlnCj4gY2hhbmdlcyB0byBhbGxvdyB0aGUgVGh1bmRlclggYW5kIFhHZW5lIFBDSSBk
cml2ZXJzIHRvIGJlIGNvbXBpbGVkCj4gb3V0LiBJdCBhbHNvIGRyb3BzIFBDSV9RVUlSS1MgZnJv
bSB0aGUgS1ZNIGd1ZXN0IGJ1aWxkIGFzIGEgdmlydHVhbAo+IFBDSSBkZXZpY2Ugc2hvdWxkIGJl
IHF1aXJrIGZyZWUuCj4KCldoYXQgYWJvdXQgUENJIHBhc3N0aHJvdWdoPwoKPiBUaGlzIGlzIG15
IGZpcnN0IHRpbWUgaGFja2luZyBhcm91bmQgS2NvbmZpZyBzbyBJIGhvcGUgSSd2ZSBnb3QgdGhl
Cj4gYmFsYW5jZSBiZXR3ZWVuIGRlcGVuZHMgYW5kIHNlbGVjdHMgcmlnaHQgYnV0IHBsZWFzZSBs
ZXQgYmUga25vdyBpZiBpdAo+IGNvdWxkIGJlIHNwZWNpZmllZCBpbiBhIGNsZWFuZXIgd2F5Lgo+
Cj4gQWxleCBCZW5uw6llICgzKToKPiAgIGFybTY0OiBhbGxvdyBkZS1zZWxlY3Rpb24gb2YgVGh1
bmRlclggUENJIGNvbnRyb2xsZXJzCj4gICBhcm02NDogZ2F0ZSB0aGUgd2hvbGUgb2YgcGNpLXhn
ZW5lIG9uIENPTkZJR19QQ0lfWEdFTkUKPiAgIGtlcm5lbC9jb25maWdzOiBkb24ndCBpbmNsdWRl
IFBDSV9RVUlSS1MgaW4gS1ZNIGd1ZXN0IGNvbmZpZ3MKPgo+ICBhcmNoL2FybTY0L0tjb25maWcu
cGxhdGZvcm1zICAgIHwgMiArKwo+ICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgIHwg
MSArCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgfCA3ICsrKysrKysKPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSB8IDggKysrLS0tLS0KPiAga2VybmVsL2NvbmZp
Z3Mva3ZtX2d1ZXN0LmNvbmZpZyB8IDEgKwo+ICA1IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiAtLQo+IDIuMjAuMQo+Cj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0Cj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWls
aW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNv
bHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
