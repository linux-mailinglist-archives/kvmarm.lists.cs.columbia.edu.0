Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BFB0765718
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jul 2019 14:39:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DEAC4A4FA;
	Thu, 11 Jul 2019 08:39:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IdAf5sxni9jS; Thu, 11 Jul 2019 08:39:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4636E4A558;
	Thu, 11 Jul 2019 08:39:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 51FD74A4A9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 08:39:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VmQm3ovrqlFD for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jul 2019 08:39:07 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2EB9E4A4FA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 08:39:07 -0400 (EDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D9487673AB83A3D4C26E;
 Thu, 11 Jul 2019 20:38:59 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 20:38:52 +0800
Subject: Re: [PATCH v3 7/9] arm/arm64: kvm: pmu: Make overflow handler NMI safe
To: Julien Thierry <julien.thierry@arm.com>,
 <linux-arm-kernel@lists.infradead.org>
References: <1562596377-33196-1-git-send-email-julien.thierry@arm.com>
 <1562596377-33196-8-git-send-email-julien.thierry@arm.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c838f6a7-276d-4444-ff7d-829ebaf00440@huawei.com>
Date: Thu, 11 Jul 2019 20:38:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <1562596377-33196-8-git-send-email-julien.thierry@arm.com>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: peterz@infradead.org, jolsa@redhat.com, will.deacon@arm.com,
 acme@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com,
 Marc Zyngier <marc.zyngier@arm.com>, namhyung@kernel.org, liwei391@huawei.com,
 kvmarm@lists.cs.columbia.edu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Julien,

On 2019/7/8 22:32, Julien Thierry wrote:
> When using an NMI for the PMU interrupt, taking any lock migh cause a
                                                            ^^^^
s/migh/might/

> deadlock. The current PMU overflow handler in KVM takes takes locks when
                                                     ^^^^^ ^^^^^
                                                     two "takes" ?


Thanks,
zenghui

> trying to wake up a vcpu.
> 
> When overflow handler is called by an NMI, defer the vcpu waking in an
> irq_work queue.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
