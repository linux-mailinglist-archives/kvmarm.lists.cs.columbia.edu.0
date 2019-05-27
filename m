Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 059642AE07
	for <lists+kvmarm@lfdr.de>; Mon, 27 May 2019 07:38:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 681E24A4F0;
	Mon, 27 May 2019 01:38:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dzH5frM6cCKR; Mon, 27 May 2019 01:38:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E666B4A4EA;
	Mon, 27 May 2019 01:38:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A72B4A4AA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 May 2019 01:38:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9luE9LjapPv3 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 27 May 2019 01:38:46 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D04B54A332
 for <kvmarm@lists.cs.columbia.edu>; Mon, 27 May 2019 01:38:45 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1783D374;
 Sun, 26 May 2019 22:38:45 -0700 (PDT)
Received: from [10.162.40.17] (p8cg001049571a15.blr.arm.com [10.162.40.17])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7E53F690;
 Sun, 26 May 2019 22:38:42 -0700 (PDT)
Subject: Re: [PATCH] mm, compaction: Make sure we isolate a valid PFN
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-mm@kvack.org
References: <20190524103924.GN18914@techsingularity.net>
 <1558711908-15688-1-git-send-email-suzuki.poulose@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8068e2e2-e90d-e8b8-55dc-9dee7d73c5e3@arm.com>
Date: Mon, 27 May 2019 11:08:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558711908-15688-1-git-send-email-suzuki.poulose@arm.com>
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



On 05/24/2019 09:01 PM, Suzuki K Poulose wrote:
> When we have holes in a normal memory zone, we could endup having
> cached_migrate_pfns which may not necessarily be valid, under heavy memory
> pressure with swapping enabled ( via __reset_isolation_suitable(), triggered
> by kswapd).
> 
> Later if we fail to find a page via fast_isolate_freepages(), we may
> end up using the migrate_pfn we started the search with, as valid
> page. This could lead to accessing NULL pointer derefernces like below,
> due to an invalid mem_section pointer.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008 [47/1825]
>  Mem abort info:
>    ESR = 0x96000004
>    Exception class = DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>  Data abort info:
>    ISV = 0, ISS = 0x00000004
>    CM = 0, WnR = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp = 0000000082f94ae9
>  [0000000000000008] pgd=0000000000000000
>  Internal error: Oops: 96000004 [#1] SMP
>  ...
>  CPU: 10 PID: 6080 Comm: qemu-system-aar Not tainted 510-rc1+ #6
>  Hardware name: AmpereComputing(R) OSPREY EV-883832-X3-0001/OSPREY, BIOS 4819 09/25/2018
>  pstate: 60000005 (nZCv daif -PAN -UAO)
>  pc : set_pfnblock_flags_mask+0x58/0xe8
>  lr : compaction_alloc+0x300/0x950
>  [...]
>  Process qemu-system-aar (pid: 6080, stack limit = 0x0000000095070da5)
>  Call trace:
>   set_pfnblock_flags_mask+0x58/0xe8
>   compaction_alloc+0x300/0x950
>   migrate_pages+0x1a4/0xbb0
>   compact_zone+0x750/0xde8
>   compact_zone_order+0xd8/0x118
>   try_to_compact_pages+0xb4/0x290
>   __alloc_pages_direct_compact+0x84/0x1e0
>   __alloc_pages_nodemask+0x5e0/0xe18
>   alloc_pages_vma+0x1cc/0x210
>   do_huge_pmd_anonymous_page+0x108/0x7c8
>   __handle_mm_fault+0xdd4/0x1190
>   handle_mm_fault+0x114/0x1c0
>   __get_user_pages+0x198/0x3c0
>   get_user_pages_unlocked+0xb4/0x1d8
>   __gfn_to_pfn_memslot+0x12c/0x3b8
>   gfn_to_pfn_prot+0x4c/0x60
>   kvm_handle_guest_abort+0x4b0/0xcd8
>   handle_exit+0x140/0x1b8
>   kvm_arch_vcpu_ioctl_run+0x260/0x768
>   kvm_vcpu_ioctl+0x490/0x898
>   do_vfs_ioctl+0xc4/0x898
>   ksys_ioctl+0x8c/0xa0
>   __arm64_sys_ioctl+0x28/0x38
>   el0_svc_common+0x74/0x118
>   el0_svc_handler+0x38/0x78
>   el0_svc+0x8/0xc
>  Code: f8607840 f100001f 8b011401 9a801020 (f9400400)
>  ---[ end trace af6a35219325a9b6 ]---
> 
> The issue was reported on an arm64 server with 128GB with holes in the zone
> (e.g, [32GB@4GB, 96GB@544GB]), with a swap device enabled, while running 100 KVM
> guest instances.
> 
> This patch fixes the issue by ensuring that the page belongs to a valid PFN
> when we fallback to using the lower limit of the scan range upon failure in
> fast_isolate_freepages().
> 
> Fixes: 5a811889de10f1eb ("mm, compaction: use free lists to quickly locate a migration target")
> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
