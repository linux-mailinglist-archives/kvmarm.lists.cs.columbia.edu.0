Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 59D3437B6CF
	for <lists+kvmarm@lfdr.de>; Wed, 12 May 2021 09:23:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0134F4B4BE;
	Wed, 12 May 2021 03:23:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7rMX3D8LRcoG; Wed, 12 May 2021 03:23:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B86414B841;
	Wed, 12 May 2021 03:23:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B7574B417
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 23:13:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tpXlarW1Ah1i for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 May 2021 23:13:34 -0400 (EDT)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 452BF4B340
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 23:13:34 -0400 (EDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg0D93P73zCrTC;
 Wed, 12 May 2021 11:10:49 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:13:29 +0800
Subject: Re: [PATCH v4 0/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210511100550.28178-1-rppt@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <b4b384c1-0d45-bb7f-3bd4-56cdb15ff2f8@huawei.com>
Date: Wed, 12 May 2021 11:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210511100550.28178-1-rppt@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 12 May 2021 03:23:40 -0400
Cc: David
 Hildenbrand <david@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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



On 2021/5/11 18:05, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
> pfn_valid_within() to 1.
> 
> The idea is to mark NOMAP pages as reserved in the memory map and restore
> the intended semantics of pfn_valid() to designate availability of struct
> page for a pfn.
> 
> With this the core mm will be able to cope with the fact that it cannot use
> NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
> will be treated correctly even without the need for pfn_valid_within.
> 
> The patches are boot tested on qemu-system-aarch64.
> 
> I beleive it would be best to route these via mmotm tree.

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
