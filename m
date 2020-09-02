Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 878F425A9BE
	for <lists+kvmarm@lfdr.de>; Wed,  2 Sep 2020 12:58:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 214204B290;
	Wed,  2 Sep 2020 06:58:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jr0-FHtgKSix; Wed,  2 Sep 2020 06:58:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E62624B28B;
	Wed,  2 Sep 2020 06:58:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E30484B158
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Sep 2020 06:58:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Ul51o3HxtBo for <kvmarm@lists.cs.columbia.edu>;
 Wed,  2 Sep 2020 06:58:24 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D0CD44B129
 for <kvmarm@lists.cs.columbia.edu>; Wed,  2 Sep 2020 06:58:24 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70D81D6E;
 Wed,  2 Sep 2020 03:58:24 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D57CB3F66F;
 Wed,  2 Sep 2020 03:58:23 -0700 (PDT)
Subject: Re: [PATCH] arm64/kvm: Fix zapping stage2 page table wrongly
To: Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20200822024444.28132-1-gshan@redhat.com>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <dbd37825-9f3b-1911-cba5-03099250dc7e@arm.com>
Date: Wed, 2 Sep 2020 11:59:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200822024444.28132-1-gshan@redhat.com>
Content-Language: en-US
Cc: maz@kernel.org, shan.gavin@gmail.com
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

Hi,

On 8/22/20 3:44 AM, Gavin Shan wrote:
> Depending on the kernel configuration, PUD_SIZE could be equal to
> PMD_SIZE. For example, both of them are 512MB with the following
> kernel configuration. In this case, both PUD and PMD are folded
> to PGD.
>
>    CONFIG_ARM64_64K_PAGES   y
>    CONFIG_ARM64_VA_BITS     42
>    CONFIG_PGTABLE_LEVELS    2
>
> With the above configuration, the stage2 PUD is used to backup the
> 512MB huge page when the stage2 mapping is built. During the mapping,
> the PUD and its subordinate levels of page table entries are unmapped
> if the PUD is present and not huge page sensitive in stage2_set_pud_huge().
> Unfornately, the @addr isn't aligned to S2_PUD_SIZE and wrong page table
> entries are zapped. It eventually leads to PUD's present bit can't be
> cleared successfully and infinite loop in stage2_set_pud_huge().
>
> This fixes the issue by checking with S2_{PUD, PMD}_SIZE instead of
> {PUD, PMD}_SIZE to determine if stage2 PUD or PMD is used to back the
> huge page. For this particular case, the stage2 PMD entry should be
> used to backup the 512MB huge page with stage2_set_pmd_huge().

I can reproduce this on my rockpro64 using kvmtool.

I see two issues here: first, PUD_SIZE = 512MB, but S2_PUD_SIZE = 4TB (checked
using printk), and second, stage2_set_pud_huge() hangs. I'm working on debugging them.

Thanks,

Alex

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
