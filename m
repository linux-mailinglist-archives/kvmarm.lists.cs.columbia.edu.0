Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA791290D1
	for <lists+kvmarm@lfdr.de>; Mon, 23 Dec 2019 03:06:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DFC014AF65;
	Sun, 22 Dec 2019 21:06:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RpUKbpUVjDFf; Sun, 22 Dec 2019 21:06:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C72AD4AF58;
	Sun, 22 Dec 2019 21:06:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 76D584AF2C
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Dec 2019 21:06:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ljbBShN1uuxJ for <kvmarm@lists.cs.columbia.edu>;
 Sun, 22 Dec 2019 21:06:50 -0500 (EST)
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 71DE54AF29
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Dec 2019 21:06:50 -0500 (EST)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 21A7A9D47367D63EB243;
 Mon, 23 Dec 2019 10:06:47 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 23 Dec 2019 10:06:46 +0800
Received: from [127.0.0.1] (10.173.221.248) by dggeme755-chm.china.huawei.com
 (10.3.19.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 23
 Dec 2019 10:06:46 +0800
Subject: Re: [PATCH 1/5] KVM: arm64: Document PV-lock interface
To: Markus Elfring <Markus.Elfring@web.de>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <virtualization@lists.linux-foundation.org>
References: <20191217135549.3240-2-yezengruan@huawei.com>
 <2337a083-499f-7778-7bf3-9f525a04e17a@web.de>
From: yezengruan <yezengruan@huawei.com>
Message-ID: <6d798e02-7ab2-fc58-9f75-ee74de97ae72@huawei.com>
Date: Mon, 23 Dec 2019 10:06:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <2337a083-499f-7778-7bf3-9f525a04e17a@web.de>
Content-Language: en-US
X-Originating-IP: [10.173.221.248]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Marc
 Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Will Deacon <will@kernel.org>
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

SGkgTWFya3VzLAoKT24gMjAxOS8xMi8yMCAyMjozMiwgTWFya3VzIEVsZnJpbmcgd3JvdGU6Cj4g
4oCmCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vdmlydC9rdm0vYXJtL3B2bG9jay5yc3QKPiDigKYK
Pj4gK1BhcmF2aXJ0dWFsaXplZCBsb2NrIHN1cHBvcnQgZm9yIGFybTY0Cj4+ICs9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+PiArCj4+ICtLVk0vYXJtNjQgcHJvdmlkcyBz
b21lIOKApgo+IOKApgo+IAo+IEkgc3VnZ2VzdCB0byBhdm9pZCBhIHR5cG8gaGVyZS4KClRoYW5r
cyBmb3IgcG9zdGluZyB0aGlzLgoKPiAKPiBSZWdhcmRzLAo+IE1hcmt1cwo+IAoKVGhhbmtzLAoK
WmVuZ3J1YW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmt2bWFybSBtYWlsaW5nIGxpc3QKa3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdQpodHRwczov
L2xpc3RzLmNzLmNvbHVtYmlhLmVkdS9tYWlsbWFuL2xpc3RpbmZvL2t2bWFybQo=
