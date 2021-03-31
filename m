Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7E34FC43
	for <lists+kvmarm@lfdr.de>; Wed, 31 Mar 2021 11:13:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A79894B3FC;
	Wed, 31 Mar 2021 05:13:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBCZjUWfqJ65; Wed, 31 Mar 2021 05:13:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A63384B3F2;
	Wed, 31 Mar 2021 05:13:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BF984B3EE
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 05:13:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pdWRd9ETwsm7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 31 Mar 2021 05:13:33 -0400 (EDT)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AD2F34B3EA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 31 Mar 2021 05:13:33 -0400 (EDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9LCc41hqz9tpr;
 Wed, 31 Mar 2021 17:11:24 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 17:13:20 +0800
Subject: Re: [RFC PATCH v2 0/2] kvm/arm64: Try stage2 block mapping for host
 device MMIO
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20210316134338.18052-1-zhukeqian1@huawei.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <1870563d-4da8-60d6-22e4-242ac820f5ba@huawei.com>
Date: Wed, 31 Mar 2021 17:13:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210316134338.18052-1-zhukeqian1@huawei.com>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Catalin Marinas <catalin.marinas@arm.com>, lushenming@huawei.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Kind ping...

On 2021/3/16 21:43, Keqian Zhu wrote:
> Hi all,
> 
> We have two pathes to build stage2 mapping for MMIO regions.
> 
> Create time's path and stage2 fault path.
> 
> Patch#1 removes the creation time's mapping of MMIO regions
> Patch#2 tries stage2 block mapping for host device MMIO at fault path
> 
> Thanks,
> Keqian
> 
> Keqian Zhu (2):
>   kvm/arm64: Remove the creation time's mapping of MMIO regions
>   kvm/arm64: Try stage2 block mapping for host device MMIO
> 
>  arch/arm64/kvm/mmu.c | 80 +++++++++++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 39 deletions(-)
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
