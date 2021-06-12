Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C13A4F21
	for <lists+kvmarm@lfdr.de>; Sat, 12 Jun 2021 15:40:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BFB8D409DD;
	Sat, 12 Jun 2021 09:40:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1pNH9OX9+Ik3; Sat, 12 Jun 2021 09:40:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AEC6640878;
	Sat, 12 Jun 2021 09:40:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D3CCB4086D
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Jun 2021 09:33:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58hh6Z87pJF5 for <kvmarm@lists.cs.columbia.edu>;
 Sat, 12 Jun 2021 09:33:06 -0400 (EDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9C32D40630
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Jun 2021 09:33:06 -0400 (EDT)
Received: by mail-pf1-f182.google.com with SMTP id k15so6806129pfp.6
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Jun 2021 06:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3wRiFAQA4e7Yl+ksEnUziylD3jK+gtjCHkmYNeOuE6c=;
 b=kkOz4/i5zkzyVPTKWg39IK/HWEgMrL9zXxvikEQEVTtUod29kMfdGqcWoaDfyCMlYO
 OQQzJd/J0+23gs9/NKFipZlTk7Awviicwc2aCgNFt43XfQn/190dgYrIqE4v9IagCIOK
 AwylwXL6JLY1AEl3UQ4u0Q99u/mp6UnNG/CNKZn413JQi2HIOGBCeaH56eta+G5OswqZ
 5JGpJQ/oI3B+6RAGYxenCw1WINzPe1TCHScNqR2ORfJnSv88WyWJ7JRIB0HXnXVmJrpS
 147Dit7Bviiwba3DqlBce9NWwQ3PJEg7ZvZLOThgLuo+Y7j+yo///3L8hmCEShi06tkL
 /q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3wRiFAQA4e7Yl+ksEnUziylD3jK+gtjCHkmYNeOuE6c=;
 b=NmLrOhBwnkpS/SBKOnoq6547X98/Pggsju48BU6L7LiEq7XyUCGKSS5WFAw2T1XkCk
 scHc2SO14pbgc/oO9wZQUfLlby81TmHgLhDYUtdpnCdu50TMrP5maT+FXGSWOA4lhKxI
 90LbIpF5qwr0ben30tUCn/dBIg6R9KbaQ+yLAojdUPGAwt/+rTsaXfDT5F/2bWIfD8SP
 gF38mMPn3hjDObKm4E7YdL22OZtJHztJOwfYCDi6FTybBoBp26K/1387aZ2q31W79gb/
 lt1gCW0Vkn9LPBfld54/H7Kal2S8TOc4wODZJaWlkV7c+9wMgLAV2bx3E94NQwx9DiuR
 ynkA==
X-Gm-Message-State: AOAM532mWFfD7PPN3JkDNdcf93oyBdwu3Jc1hsY2Ud+SxA02pJMuPkrS
 EkWadICnxN12Qz3x9Bvq9EktPjryxPd4ZFDDtp0=
X-Google-Smtp-Source: ABdhPJzaXwq+agQL2AlHlBr3G1cfDRdHqcnICZBjnuHuO89La+HnzeFKLp339if3uODrOsoOoDvF9lUXeGMayXlPRYE=
X-Received: by 2002:a63:f815:: with SMTP id n21mr8634604pgh.2.1623504785601;
 Sat, 12 Jun 2021 06:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210612110014.GA1211@raspberrypi> <87eed7tk24.wl-maz@kernel.org>
In-Reply-To: <87eed7tk24.wl-maz@kernel.org>
From: Austin Kim <austindh.kim@gmail.com>
Date: Sat, 12 Jun 2021 22:32:54 +0900
Message-ID: <CADLLry7bYPYfqwQwWLtsXaAMG_deJ=TVVowAb5wtk_=AhTT64Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: vgic: declear local variable 'flags' before
 for loop starts
To: Marc Zyngier <maz@kernel.org>
X-Mailman-Approved-At: Sat, 12 Jun 2021 09:40:02 -0400
Cc: will@kernel.org, catalin.marinas@arm.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>, kvmarm@lists.cs.columbia.edu,
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

MjAyMeuFhCA27JuUIDEy7J28ICjthqApIOyYpO2bhCA4OjEwLCBNYXJjIFp5bmdpZXIgPG1hekBr
ZXJuZWwub3JnPuuLmOydtCDsnpHshLE6Cj4KPiBPbiBTYXQsIDEyIEp1biAyMDIxIDEyOjAwOjE0
ICswMTAwLAo+IEF1c3RpbiBLaW0gPGF1c3RpbmRoLmtpbUBnbWFpbC5jb20+IHdyb3RlOgo+ID4K
PiA+IEZyb206IEF1c3RpbiBLaW0gPGF1c3Rpbi5raW1AbGdlLmNvbT4KPiA+Cj4gPiBOb3JtYWxs
eSBsb2NhbCB2YXJpYWJsZSAnZmxhZ3MnIGlzIGRlZmluZWQgb3V0IG9mIGZvciBsb29wLAo+ID4g
d2hlbiAnZmxhZ3MnIGlzIHVzZWQgYXMgdGhlIHNlY29uZCBwYXJhbWV0ZXIgaW4gYSBjYWxsIHRv
Cj4gPiBzcGlubG9ja19pcnFbc2F2ZS9yZXN0b3JlXSBmdW5jdGlvbi4KPiA+Cj4gPiBTbyBpdCBo
YWQgYmV0dGVyIGRlY2xlYXIgbG9jYWwgdmFyaWFibGUgJ2ZsYWdzJyBhaGVhZCBvZiBmb3IgbG9v
cC4KPgo+IFdoeSBiZXR0ZXI/IFJlZHVjaW5nIHRoZSBzY29wZSBvZiBhIHZhcmlhYmxlIGlzIGlu
IGdlbmVyYWwgZ29vZAo+IHByYWN0aWNlLiBEbyB5b3Ugc2VlIGFueSBtYXRlcmlhbCBhZHZhbnRh
Z2UgaW4gbW92aW5nIHRoaXMgdmFyaWFibGUKPiBvdXQgb2YgdGhlIGxvb3A/IERvZXMgdGhlIGNv
bXBpbGVyIGdlbmVyYXRlIGJldHRlciBjb2RlPwoKRmlyc3QgYWxsIG9mLCB0aGFua3MgZm9yIGZl
ZWRiYWNrLgoKSSBjaGVja2VkIGhvdyB0aGUgY29tcGlsZXIgZ2VuZXJhdGUgYXNzZW1ibHkgY29k
ZShiZWZvcmUvYWZ0ZXIpIHVzaW5nCm9iamR1bXAgdXRpbGl0eS4KQW5kIHRoZW4gZm91bmQgb3V0
IHRoYXQgY29tcGlsZXIgZ2VuZXJhdGVzIHRoZSBzYW1lIGFzc2VtYmx5IGNvZGUuCgo8Y29tcGls
ZXIgdmVyc2lvbjogZ2NjLWxpbmFyby03LjUuMC0yMDE5LjEyLXg4Nl82NF9hYXJjaDY0PgoKZmZm
ZjgwMDAxMDA1ZjVjOCA8dmdpY19tbWlvX3JlYWRfcGVuZGluZz46CmZmZmY4MDAwMTAwNWY1Yzg6
ICAgZDUwMzIzM2YgICAgcGFjaWFzcAouLi4KZmZmZjgwMDAxMDA1ZjYzYzogICA5N2ZmZTlhZiAg
ICBibCAgZmZmZjgwMDAxMDA1OWNmOCA8dmdpY19nZXRfaXJxPgpmZmZmODAwMDEwMDVmNjQwOiAg
IGFhMDAwM2YzICAgIG1vdiB4MTksIHgwCmZmZmY4MDAwMTAwNWY2NDQ6ICAgOTQzODg2YzMgICAg
YmwgIGZmZmY4MDAwMTBlODExNTAgPF9yYXdfc3Bpbl9sb2NrX2lycXNhdmU+CgpMZXQgbWUga2Vl
cCBpbiBtaW5kIGhvdyBjb21waWxlciBnZW5lcmF0ZSBhc3NlbWJseSBjb2RlIHdpdGggbmV3IHBh
dGNoLAp3aGljaCBsZWFkcyB0byBtYXRlcmlhbCBhZHZhbnRhZ2UuCgpCUiwKQXVzdGluIEtpbQoK
Pgo+IFRoYW5rcywKPgo+ICAgICAgICAgTS4KPgo+IC0tCj4gV2l0aG91dCBkZXZpYXRpb24gZnJv
bSB0aGUgbm9ybSwgcHJvZ3Jlc3MgaXMgbm90IHBvc3NpYmxlLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprdm1hcm0gbWFpbGluZyBsaXN0Cmt2bWFybUBs
aXN0cy5jcy5jb2x1bWJpYS5lZHUKaHR0cHM6Ly9saXN0cy5jcy5jb2x1bWJpYS5lZHUvbWFpbG1h
bi9saXN0aW5mby9rdm1hcm0K
