Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2256937ACC2
	for <lists+kvmarm@lfdr.de>; Tue, 11 May 2021 19:11:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A5B54B567;
	Tue, 11 May 2021 13:11:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4CeT-TLfgkW; Tue, 11 May 2021 13:11:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 85F924B515;
	Tue, 11 May 2021 13:11:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9ECD24B50F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 13:11:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xBwjkrV51Qg4 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 May 2021 13:11:04 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A5CA44B50B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 13:11:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620753064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZrjJ+O88rA6qykT2B9o+FKt5pQAnvwT/kjMZAbiQ+Y=;
 b=WJ8bNNpbV6AyvDz0e3uQlZg0YKtvoK2cEwpquBr+OS3IhWQDyC6ksfqaYET3VH3oJ1CPlf
 KCV8hCgxyKkexzUrwTcDnveI3HDupGIBvrjFAYM3Dtbw1l0WQ5190scBUYul8/RggjlqRp
 BWBirghz1qUBafZJJJ1zBMo8DJtY6gU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-cBtEeU8ONjSc50jgV9D6OA-1; Tue, 11 May 2021 13:11:01 -0400
X-MC-Unique: cBtEeU8ONjSc50jgV9D6OA-1
Received: by mail-ej1-f69.google.com with SMTP id
 zo1-20020a170906ff41b02903973107d7b5so6193953ejb.21
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 10:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rZrjJ+O88rA6qykT2B9o+FKt5pQAnvwT/kjMZAbiQ+Y=;
 b=AM8Gm99NrUQcB90ce17+vdNf3xUTxiDJGauuOgli0WAHdKT8EH+zfsU0vn478NtShZ
 W+wy0c5uB0N8A2+oGPxJ6Z0Sgk99SEyOxWsNjSTFXdZ0qXfxq6KKVy10iggIz/7raCg0
 vMrPSZsPLhA09n9ip+Am4RFASs3L3w4gJYrUrRdZJf5RfEqra0JGp5hp4mZ5C14nA98y
 z9o0msGKIApVNXymzZ9tcHWNQkGJ9yCssTSbbxehLxcUTPN+IsZH8ELEXk6gycaqfKHj
 ppnXvymoLxx1bHx89x392Kyl9vlnEOWNMIGzKz3Iv2AAdehlGV8zUnd5QZGoeDxbt4Ox
 AX9Q==
X-Gm-Message-State: AOAM531ivzlLekjByrH8OZz7M3NDycV6/22GFnEf6YcyP1oOTZ3093fD
 h96j5vELw77EaBebtYZ7HihQX4Nv+Q73ogjUoUhM7bj2xW+JS11vKaaLGG6HR2NpGREYkk9DQtS
 KGEFsa2SGcSgHn/bR4Yt0NoQNKmw87tIitsGL4ciFCV0HiSO825K1OfmlGjPrwVAjgh+xnvjCht
 FP
X-Received: by 2002:a05:6402:51c9:: with SMTP id
 r9mr33684866edd.94.1620753059558; 
 Tue, 11 May 2021 10:10:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpYpw07LI9oOo5kNjsJCNhMuCW/mc5JA7PEVerJPQlbNvE23xRfTktHpr5pHbEO7TKzgF4lg==
X-Received: by 2002:a05:6402:51c9:: with SMTP id
 r9mr33684840edd.94.1620753059355; 
 Tue, 11 May 2021 10:10:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id p14sm14826543eds.28.2021.05.11.10.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 10:10:58 -0700 (PDT)
Subject: Re: [kvm-unit-tests BUG] lib/ldiv32.c breaks arm compilation
To: Alexandru Elisei <alexandru.elisei@arm.com>,
 Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
References: <348f023d-f313-3d98-dc18-b53b6879fe45@arm.com>
 <604b1638-452f-e8e3-b674-014d634e2767@redhat.com>
 <05b5ce5d-4cd8-1fe3-1d2e-d34d4cf31384@arm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <887fb8f1-aa80-88eb-89f3-eda37394c22a@redhat.com>
Date: Tue, 11 May 2021 19:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <05b5ce5d-4cd8-1fe3-1d2e-d34d4cf31384@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

T24gMTEvMDUvMjEgMTk6MDMsIEFsZXhhbmRydSBFbGlzZWkgd3JvdGU6Cj4+IFRoZSBGZWRvcmEg
b25lIGlzIGZpeGVkIGluIHRoZSBjb21taXQgaW1tZWRpYXRlbHkgYWZ0ZXIsIHdoaWNoIHJlcGxh
Y2VzCj4+IGludHR5cGVzLmggd2l0aCBzdGRpbnQuaC4KPiAkIGdpdCByZW1vdGUgLXYgc2hvdyBu
ZXcKPiAqIHJlbW90ZSBuZXcKPiAgwqAgRmV0Y2ggVVJMOmh0dHBzOi8vZ2l0bGFiLmNvbS9rdm0t
dW5pdC10ZXN0cy9rdm0tdW5pdC10ZXN0cy5naXQvCj4gIMKgIFB1c2jCoCBVUkw6aHR0cHM6Ly9n
aXRsYWIuY29tL2t2bS11bml0LXRlc3RzL2t2bS11bml0LXRlc3RzLmdpdC8KPiAgwqAgSEVBRCBi
cmFuY2g6IG1hc3Rlcgo+ICDCoCBSZW1vdGUgYnJhbmNoZXM6Cj4gIMKgwqDCoCBtYXN0ZXLCoCB0
cmFja2VkCj4gIMKgwqDCoCBzdGFnaW5nIHRyYWNrZWQKPiAgwqAgTG9jYWwgYnJhbmNoIGNvbmZp
Z3VyZWQgZm9yICdnaXQgcHVsbCc6Cj4gIMKgwqDCoCBtYXN0ZXIgbWVyZ2VzIHdpdGggcmVtb3Rl
IG1hc3Rlcgo+ICDCoCBMb2NhbCByZWYgY29uZmlndXJlZCBmb3IgJ2dpdCBwdXNoJzoKPiAgwqDC
oMKgIG1hc3RlciBwdXNoZXMgdG8gbWFzdGVyICh1cCB0byBkYXRlKQo+ICQgZ2l0IHB1bGwgbmV3
Cj4gQWxyZWFkeSB1cCB0byBkYXRlLgo+ICQgZ2l0IHNob3cKPiBjb21taXQgMGIyZDNkYWZjMGQz
MTAyNTYzNjIwMWRmOTIzZmEwZGM4ZDJlMzgwZSAoSEVBRCAtPiBtYXN0ZXIsIG5ldy9tYXN0ZXIp
Cj4gQXV0aG9yOiBQYW9sbyBCb256aW5pPHBib256aW5pQHJlZGhhdC5jb20+Cj4gRGF0ZTrCoMKg
IFdlZCBNYXkgNSAwODozMzozOCAyMDIxIC0wNDAwCj4gCj4gIMKgwqDCoCBsaWJjZmxhdDogcHJv
dmlkZSBsb25nIGRpdmlzaW9uIHJvdXRpbmVzCj4gWy4uXQo+IAo+IEkgZ3Vlc3MgdGhlIHBhdGNo
IGhhcyBub3QgYmVlbiBtZXJnZWQgeWV0LCByaWdodD8KPiAKCk9vcHMsIGl0IHdhcyBvbmx5IGlu
IG15IG93biB0cmVlLiAgUHVzaGVkIG5vdy4KClBhb2xvCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBsaXN0
cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1hbi9s
aXN0aW5mby9rdm1hcm0K
