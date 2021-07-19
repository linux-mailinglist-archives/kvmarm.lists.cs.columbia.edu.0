Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 053D93CE075
	for <lists+kvmarm@lfdr.de>; Mon, 19 Jul 2021 18:01:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 735234B093;
	Mon, 19 Jul 2021 12:00:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T3Q41aGnhiSS; Mon, 19 Jul 2021 12:00:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 10A424A319;
	Mon, 19 Jul 2021 12:00:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95CF049E5F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 12:00:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OXSogE1x-22y for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Jul 2021 12:00:56 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C10349E57
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 12:00:56 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F8E51FB;
 Mon, 19 Jul 2021 09:00:55 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B39FE3F73D;
 Mon, 19 Jul 2021 09:00:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] KVM: arm64: Narrow PMU sysreg reset values to
 architectural requirements
To: Marc Zyngier <maz@kernel.org>
References: <20210719123902.1493805-1-maz@kernel.org>
 <20210719123902.1493805-2-maz@kernel.org>
 <171cca9d-2a6e-248c-8502-feba8ebbe55e@arm.com>
 <171834f3198b898d5c2aefa0270b65f2@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <482a40a8-d190-99d3-ec17-59ee730be0fa@arm.com>
Date: Mon, 19 Jul 2021 17:02:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <171834f3198b898d5c2aefa0270b65f2@kernel.org>
Content-Language: en-US
Cc: kvm@vger.kernel.org, kernel-team@android.com,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Russell King <linux@arm.linux.org.uk>, Robin Murphy <robin.murphy@arm.com>,
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

SGkgTWFyYywKCk9uIDcvMTkvMjEgNDo1NiBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOgo+IE9uIDIw
MjEtMDctMTkgMTY6NTUsIEFsZXhhbmRydSBFbGlzZWkgd3JvdGU6Cj4+IEhpIE1hcmMsCj4+Cj4+
IE9uIDcvMTkvMjEgMTozOCBQTSwgTWFyYyBaeW5naWVyIHdyb3RlOgo+Pj4gQSBudW1iZXIgb2Yg
dGhlIFBNVSBzeXNyZWdzIGV4cG9zZSByZXNldCB2YWx1ZXMgdGhhdCBhcmUgbm90Cj4+PiBjb21w
bGlhbnQgd2l0aCB0aGUgYXJjaGl0ZWN0dXJlIChzZXQgYml0cyBpbiB0aGUgUkVTMCByYW5nZXMs
Cj4+PiBmb3IgZXhhbXBsZSkuCj4+Pgo+Pj4gVGhpcyBpbiB0dXJuIGhhcyB0aGUgZWZmZWN0IHRo
YXQgd2UgbmVlZCB0byBwb2ludGxlc3NseSBtYXNrCj4+PiBzb21lIHJlZ2lzdGVyIGZpZWxkcyB3
aGVuIHVzaW5nIHRoZW0uCj4+Pgo+Pj4gTGV0J3Mgc3RhcnQgYnkgbWFraW5nIHN1cmUgd2UgZG9u
J3QgaGF2ZSBpbGxlZ2FsIHZhbHVlcyBpbiB0aGUKPj4+IHNoYWRvdyByZWdpc3RlcnMgYXQgcmVz
ZXQgdGltZS4gVGhpcyBhZmZlY3RzIGFsbCB0aGUgcmVnaXN0ZXJzCj4+PiB0aGF0IGRlZGljYXRl
IG9uZSBiaXQgcGVyIGNvdW50ZXIsIHRoZSBjb3VudGVycyB0aGVtc2VsdmVzLAo+Pj4gUE1FVlRZ
UEVSbl9FTDAgYW5kIFBNU0VMUl9FTDAuCj4+Pgo+Pj4gUmVwb3J0ZWQtYnk6IEFsZXhhbmRyZSBD
aGFydHJlIDxhbGV4YW5kcmUuY2hhcnRyZUBvcmFjbGUuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IEFs
ZXhhbmRyZSBDaGFydHJlIDxhbGV4YW5kcmUuY2hhcnRyZUBvcmFjbGUuY29tPgo+Pj4gQWNrZWQt
Ynk6IFJ1c3NlbGwgS2luZyAoT3JhY2xlKSA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgo+Pj4gLS0tCj4+
PiDCoGFyY2gvYXJtNjQva3ZtL3N5c19yZWdzLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0KPj4+IMKgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva3ZtL3N5c19y
ZWdzLmMgYi9hcmNoL2FybTY0L2t2bS9zeXNfcmVncy5jCj4+PiBpbmRleCBmNmYxMjZlYjZhYzEu
Ljk2YmRmYTBlNjhiMiAxMDA2NDQKPj4+IC0tLSBhL2FyY2gvYXJtNjQva3ZtL3N5c19yZWdzLmMK
Pj4+ICsrKyBiL2FyY2gvYXJtNjQva3ZtL3N5c19yZWdzLmMKPj4+IEBAIC02MDMsNiArNjAzLDQx
IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgcG11X3Zpc2liaWxpdHkoY29uc3Qgc3RydWN0IGt2bV92
Y3B1Cj4+PiAqdmNwdSwKPj4+IMKgwqDCoMKgIHJldHVybiBSRUdfSElEREVOOwo+Pj4gwqB9Cj4+
Pgo+Pj4gK3N0YXRpYyB2b2lkIHJlc2V0X3BtdV9yZWcoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBj
b25zdCBzdHJ1Y3Qgc3lzX3JlZ19kZXNjICpyKQo+Pj4gK3sKPj4+ICvCoMKgwqAgdTY0IG4sIG1h
c2sgPSBCSVQoQVJNVjhfUE1VX0NZQ0xFX0lEWCk7Cj4+PiArCj4+PiArwqDCoMKgIC8qIE5vIFBN
VSBhdmFpbGFibGUsIGFueSBQTVUgcmVnIG1heSBVTkRFRi4uLiAqLwo+Pj4gK8KgwqDCoCBpZiAo
IWt2bV9hcm1fc3VwcG9ydF9wbXVfdjMoKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+
PiArCj4+PiArwqDCoMKgIG4gPSByZWFkX3N5c3JlZyhwbWNyX2VsMCkgPj4gQVJNVjhfUE1VX1BN
Q1JfTl9TSElGVDsKPj4+ICvCoMKgwqAgbiAmPSBBUk1WOF9QTVVfUE1DUl9OX01BU0s7Cj4+PiAr
wqDCoMKgIGlmIChuKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1hc2sgfD0gR0VOTUFTSyhuIC0gMSwg
MCk7Cj4+Cj4+IEhtLi4uIHNlZW1zIHRvIGJlIG1pc3NpbmcgdGhlIGN5Y2xlIGNvdW50ZXIuCj4K
PiBDaGVjayB0aGUgZGVjbGFyYXRpb24gZm9yICdtYXNrJy4uLiA6LSkKClllYWgsIHNvcnJ5IGZv
ciB0aGF0LCBJIHN0aWxsIGhhZCBpbiBteSBtaW5kIHRoZSBvcmlnaW5hbCBmdW5jdGlvbiBib2R5
LgoKRXZlcnl0aGluZyBsb29rcyBhbHJpZ2h0IHRvIG1lLCBubyBjaGFuZ2VzIGZyb20gdGhlIHBy
ZXZpb3VzIHZlcnNpb24gKFBNU1dJTkNfRUwxCmlzIGhhbmRsZWQgaW4gdGhlIGxhc3QgcGF0Y2gp
IHdoZXJlIEkgaGFkIGNoZWNrZWQgdGhhdCB0aGUgcmVzZXQgdmFsdWVzIG1hdGNoIHRoZQphcmNo
aXRlY3R1cmU6CgpSZXZpZXdlZC1ieTogQWxleGFuZHJ1IEVsaXNlaSA8YWxleGFuZHJ1LmVsaXNl
aUBhcm0uY29tPgoKVGhhbmtzLAoKQWxleAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1AbGlzdHMuY3MuY29s
dW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4vbGlzdGluZm8v
a3ZtYXJtCg==
