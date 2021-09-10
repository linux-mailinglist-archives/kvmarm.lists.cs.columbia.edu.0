Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47C406942
	for <lists+kvmarm@lfdr.de>; Fri, 10 Sep 2021 11:45:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D2B64B1AC;
	Fri, 10 Sep 2021 05:45:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WSjrgcPZY51Y; Fri, 10 Sep 2021 05:45:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4421E4B188;
	Fri, 10 Sep 2021 05:45:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 978AA4B173
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Sep 2021 05:45:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oLwzDZvqtB9X for <kvmarm@lists.cs.columbia.edu>;
 Fri, 10 Sep 2021 05:45:48 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6CECB405EE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 10 Sep 2021 05:45:48 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3758610C7;
 Fri, 10 Sep 2021 09:45:45 +0000 (UTC)
Date: Fri, 10 Sep 2021 10:45:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 0/4] Fix racing TLBI with ASID/VMID reallocation
Message-ID: <YTspRlASNfGWTdss@arm.com>
References: <20210806113109.2475-1-will@kernel.org>
 <753ff5ea79d54db0af83d195adcfa2b1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <753ff5ea79d54db0af83d195adcfa2b1@huawei.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Marc Zyngier <maz@kernel.org>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jade Alglave <jade.alglave@arm.com>
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

On Fri, Sep 10, 2021 at 09:06:31AM +0000, Shameerali Kolothum Thodi wrote:
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/commit/
> 
> I am going through the ASID TLA+ model and in the above commit, it appears that the
> different ASID check(=> ActiveAsid(c1) # ActiveAsid(c2)) for the Invariant
> UniqueASIDActiveTask is now removed.
> 
> Just wondering why that is not relevant anymore?

It's still relevant. I probably deleted it by mistake, I'll add it back
now. Thanks for carefully looking at this commit.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
