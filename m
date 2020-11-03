Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB7092A445E
	for <lists+kvmarm@lfdr.de>; Tue,  3 Nov 2020 12:37:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54A3B4B3B4;
	Tue,  3 Nov 2020 06:37:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TK1tVbwMIFtn; Tue,  3 Nov 2020 06:37:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 283584B3B3;
	Tue,  3 Nov 2020 06:37:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D3F644B31E
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 06:37:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AYw-zsyimtqa for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Nov 2020 06:37:31 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD7D74B353
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 06:37:31 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616FC101E;
 Tue,  3 Nov 2020 03:37:31 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B15193F66E;
 Tue,  3 Nov 2020 03:37:30 -0800 (PST)
Date: Tue, 3 Nov 2020 11:37:27 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v2 0/3] KVM: arm64: Fix get-reg-list regression
Message-ID: <20201103113726.GJ6882@arm.com>
References: <20201102185037.49248-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102185037.49248-1-drjones@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: maz@kernel.org, xu910121@sina.com, kvmarm@lists.cs.columbia.edu
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

T24gTW9uLCBOb3YgMDIsIDIwMjAgYXQgMDc6NTA6MzRQTSArMDEwMCwgQW5kcmV3IEpvbmVzIHdy
b3RlOgo+IOW8oOS4nOaXrSA8eHU5MTAxMjFAc2luYS5jb20+IHJlcG9ydGVkIGEgcmVncmVzc2lv
biBzZWVuIHdpdGggQ2VudE9TCj4gd2hlbiBtaWdyYXRpbmcgZnJvbSBhbiBvbGQga2VybmVsIHRv
IGEgbmV3IG9uZS4gVGhlIHByb2JsZW0gd2FzCj4gdGhhdCBRRU1VIHJlamVjdGVkIHRoZSBtaWdy
YXRpb24gc2luY2UgS1ZNX0dFVF9SRUdfTElTVCByZXBvcnRlZAo+IGEgcmVnaXN0ZXIgd2FzIG1p
c3Npbmcgb24gdGhlIGRlc3RpbmF0aW9uLiBFeHRyYSByZWdpc3RlcnMgYXJlIE9LCj4gb24gdGhl
IGRlc3RpbmF0aW9uLCBidXQgbm90IG1pc3Npbmcgb25lcy4gVGhlIHJlZ3Jlc3Npb24gcmVwcm9k
dWNlcwo+IHdpdGggdXBzdHJlYW0ga2VybmVscyB3aGVuIG1pZ3JhdGluZyBmcm9tIGEgNC4xNSBv
ciBsYXRlciBrZXJuZWwsCj4gdXAgdG8gb25lIHdpdGggY29tbWl0IDczNDMzNzYyZmNhZSAoIktW
TTogYXJtNjQvc3ZlOiBTeXN0ZW0gcmVnaXN0ZXIKPiBjb250ZXh0IHN3aXRjaCBhbmQgYWNjZXNz
IHN1cHBvcnQiKSwgdG8gYSBrZXJuZWwgdGhhdCBpbmNsdWRlcyB0aGF0Cj4gY29tbWl0LCBlLmcu
IHRoZSBsYXRlc3QgbWFpbmxpbmUgKDUuMTAtcmMyKS4KPiAKPiBUaGUgZmlyc3QgcGF0Y2ggb2Yg
dGhpcyBzZXJpZXMgaXMgdGhlIGZpeC4gVGhlIG5leHQgdHdvIHBhdGNoZXMsCj4gd2hpY2ggZG9u
J3QgaGF2ZSBhbnkgaW50ZW5kZWQgZnVuY3Rpb25hbCBjaGFuZ2VzLCBhbGxvdyBJRF9TQU5JVElT
RUQKPiB0byBiZSB1c2VkIGZvciByZWdpc3RlcnMgdGhhdCBmbGlwIGJldHdlZW4gZXhwb3Npbmcg
ZmVhdHVyZXMgYW5kCj4gYmVpbmcgUkFaLCB3aGljaCBhbGxvd3Mgc29tZSBjb2RlIHRvIGJlIHJl
bW92ZWQuCgpJcyBpdCB3b3J0aCB1cGRhdGluZyBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2FwaS5y
c3QgdG8gY2xhcmlmeSB0aGUKZXhwZWN0ZWQgdXNlIGR1cmluZyBWTSBtaWdyYXRpb25zLCBhbmQg
dGhlIGd1YXJhbnRlZXMgdGhhdCBhcmUgZXhwZWN0ZWQKdG8gaG9sZCBiZXR3ZWVuIG1pZ3JhdGFi
bGUga2VybmVsIHZlcnNpb25zPyAgQ3VycmVudGx5IHRoZSBzcGVjaWZpY2F0aW9uCmlzIGEgbWl4
dHVyZSBvZiAic3VyZWx5IGl0J3Mgb2J2aW91cyIgYW5kICJ3aGF0ZXZlciBtYWtlcyBRRU1VIHdv
cmsiLgoKSSBndWVzcyB0aGF0IGNhdWdodCBtZSBvdXQsIGJ1dCBJJ2xsIGxldCBvdGhlcnMganVk
Z2Ugd2hldGhlciBvdGhlcgpwZW9wbGUgYXJlIGxpa2VseSB0byBnZXQgc2ltaWxhcmx5IGNvbmZ1
c2VkLgoKWy4uLl0KCkNoZWVycwotLS1EYXZlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNv
bHVtYmlhLmVkdQpodHRwczovL2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZv
L2t2bWFybQo=
