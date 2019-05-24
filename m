Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F89D29674
	for <lists+kvmarm@lfdr.de>; Fri, 24 May 2019 12:56:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D74664A4D5;
	Fri, 24 May 2019 06:56:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLtprUfBbZWO; Fri, 24 May 2019 06:56:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 733FC4A4CA;
	Fri, 24 May 2019 06:56:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 14F8B4A4A9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 May 2019 06:56:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k0rSyY2uzTo6 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 May 2019 06:56:10 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 95E294A47A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 May 2019 06:56:10 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC91374;
 Fri, 24 May 2019 03:56:10 -0700 (PDT)
Received: from [10.162.42.134] (p8cg001049571a15.blr.arm.com [10.162.42.134])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B23593F703; Fri, 24 May 2019 03:56:06 -0700 (PDT)
Subject: Re: mm/compaction: BUG: NULL pointer dereference
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-mm@kvack.org
References: <1558689619-16891-1-git-send-email-suzuki.poulose@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cfddd75a-b302-5557-05b8-2b328bba27c8@arm.com>
Date: Fri, 24 May 2019 16:26:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558689619-16891-1-git-send-email-suzuki.poulose@arm.com>
Content-Language: en-US
Cc: mhocko@suse.com, kvm@vger.kernel.org, marc.zyngier@arm.com,
 linux-kernel@vger.kernel.org, cai@lca.pw, akpm@linux-foundation.org,
 mgorman@techsingularity.net, kvmarm@lists.cs.columbia.edu
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



On 05/24/2019 02:50 PM, Suzuki K Poulose wrote:
> Hi,
> 
> We are hitting NULL pointer dereferences while running stress tests with KVM.
> See splat [0]. The test is to spawn 100 VMs all doing standard debian
> installation (Thanks to Marc's automated scripts, available here [1] ).
> The problem has been reproduced with a better rate of success from 5.1-rc6
> onwards.
> 
> The issue is only reproducible with swapping enabled and the entire
> memory is used up, when swapping heavily. Also this issue is only reproducible
> on only one server with 128GB, which has the following memory layout:
> 
> [32GB@4GB, hole , 96GB@544GB]
> 
> Here is my non-expert analysis of the issue so far.
> 
> Under extreme memory pressure, the kswapd could trigger reset_isolation_suitable()
> to figure out the cached values for migrate/free pfn for a zone, by scanning through
> the entire zone. On our server it does so in the range of [ 0x10_0000, 0xa00_0000 ],
> with the following area of holes : [ 0x20_0000, 0x880_0000 ].
> In the failing case, we end up setting the cached migrate pfn as : 0x508_0000, which
> is right in the center of the zone pfn range. i.e ( 0x10_0000 + 0xa00_0000 ) / 2,
> with reset_migrate = 0x88_4e00, reset_free = 0x10_0000.
> 
> Now these cached values are used by the fast_isolate_freepages() to find a pfn. However,
> since we cant find anything during the search we fall back to using the page belonging
> to the min_pfn (which is the migrate_pfn), without proper checks to see if that is valid
> PFN or not. This is then passed on to fast_isolate_around() which tries to do :
> set_pageblock_skip(page) on the page which blows up due to an NULL mem_section pointer.
> 
> The following patch seems to fix the issue for me, but I am not quite convinced that
> it is the right fix. Thoughts ?
> 
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 9febc8c..9e1b9ac 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1399,7 +1399,7 @@ fast_isolate_freepages(struct compact_control *cc)
>  				page = pfn_to_page(highest);
>  				cc->free_pfn = highest;
>  			} else {
> -				if (cc->direct_compaction) {
> +				if (cc->direct_compaction && pfn_valid(min_pfn)) {
>  					page = pfn_to_page(min_pfn);

pfn_to_online_page() here would be better as it does not add pfn_valid() cost on
architectures which does not subscribe to CONFIG_HOLES_IN_ZONE. But regardless if
the compaction is trying to scan pfns in zone holes, then it should be avoided.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
