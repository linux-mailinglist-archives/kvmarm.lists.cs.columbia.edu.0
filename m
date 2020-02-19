Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2916485A
	for <lists+kvmarm@lfdr.de>; Wed, 19 Feb 2020 16:19:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 999D74AF21;
	Wed, 19 Feb 2020 10:19:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UQfSUv2-qHpd; Wed, 19 Feb 2020 10:19:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A18674AF14;
	Wed, 19 Feb 2020 10:19:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 08F094AEE0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 Feb 2020 10:19:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GMnVRP9EiZTB for <kvmarm@lists.cs.columbia.edu>;
 Wed, 19 Feb 2020 10:19:07 -0500 (EST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D65F34AC77
 for <kvmarm@lists.cs.columbia.edu>; Wed, 19 Feb 2020 10:19:06 -0500 (EST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8FBB9C63BB00B34477CF;
 Wed, 19 Feb 2020 23:18:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Feb 2020
 23:18:19 +0800
Subject: Re: [PATCH v4 08/20] irqchip/gic-v4.1: Plumb get/set_irqchip_state
 SGI callbacks
From: Zenghui Yu <yuzenghui@huawei.com>
To: Marc Zyngier <maz@kernel.org>
References: <20200214145736.18550-1-maz@kernel.org>
 <20200214145736.18550-9-maz@kernel.org>
 <4b7f71f1-5e7f-e6af-f47d-7ed0d3a8739f@huawei.com>
 <75597af0d2373ac4d92d8162a1338cbb@kernel.org>
 <19a7c193f0e4b97343e822a35f0911ed@kernel.org>
 <8db95a86-0981-710b-6c82-be7f7f844151@huawei.com>
Message-ID: <8c538d2e-5ec8-0fd0-8999-e43a847df4c1@huawei.com>
Date: Wed, 19 Feb 2020 23:18:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8db95a86-0981-710b-6c82-be7f7f844151@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert
 Richter <rrichter@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
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

T24gMjAyMC8yLzE5IDE5OjUwLCBaZW5naHVpIFl1IHdyb3RlOgo+IDMuIGl0IGxvb2tzIGxpa2Ug
S1ZNIG1ha2VzIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHBlci1SRCBNTUlPIHJlZ2lvbgo+IHdp
bGwgb25seSBiZSBhY2Nlc3NlZCBieSB0aGUgYXNzb2NpYXRlZCBWQ1BVP8KgIEJ1dCBJIHRoaW5r
IHRoaXMncyBub3QKPiByZXN0cmljdGVkIGJ5IHRoZSBhcmNoaXRlY3R1cmUsIHdlIGNhbiBkbyBp
dCBiZXR0ZXIuwqAgT3IgSSd2ZSBqdXN0Cj4gbWlzc2VkIHNvbWUgaW1wb3J0YW50IHBvaW50cyBo
ZXJlLgoKKEFmdGVyIHNvbWUgYmFzaWMgdGVzdHMsIEtWTSBhY3R1YWxseSBkb2VzIHRoZSByaWdo
dCB0aGluZyEpClNvIEkgbXVzdCBoYXZlIHNvbWUgbWlzLXVuZGVyc3RhbmRpbmcgb24gdGhpcyBw
b2ludCwgcGxlYXNlCmlnbm9yZSBpdC4gIEknbGwgZGlnIGl0IGZ1cnRoZXIgbXlzZWxmLCBzb3Jy
eSBmb3IgdGhlIG5vaXN5LgoKClRoYW5rcywKWmVuZ2h1aQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka3ZtYXJtIG1haWxpbmcgbGlzdAprdm1hcm1AbGlz
dHMuY3MuY29sdW1iaWEuZWR1Cmh0dHBzOi8vbGlzdHMuY3MuY29sdW1iaWEuZWR1L21haWxtYW4v
bGlzdGluZm8va3ZtYXJtCg==
