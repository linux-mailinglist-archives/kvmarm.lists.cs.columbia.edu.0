Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5F413D3DA3
	for <lists+kvmarm@lfdr.de>; Fri, 11 Oct 2019 12:45:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D236B4A8B9;
	Fri, 11 Oct 2019 06:45:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQTuejDzwWV7; Fri, 11 Oct 2019 06:45:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 973D24A8B4;
	Fri, 11 Oct 2019 06:45:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 17B614A8B0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Oct 2019 06:45:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xBow-Dt9BmnY for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Oct 2019 06:45:01 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 084204A863
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Oct 2019 06:45:01 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D63B2084C;
 Fri, 11 Oct 2019 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570790700;
 bh=bbQgNFwnmbeP7cYb09L5PBaPKxGPa4z3Rigbwq5f1WM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xPSZgAGoy5tmVAYpsur6voRj8yry0H/Txb8PXUOgcBTc+MPrY2ZWSWQAD2CE2VLFI
 TsUI6e/xIKiJUv3ExQmO+OCDNdPaLNJV3dTrHmYTHvSHqPN49vaO0qiGIHjX+IzKye
 jZX3lZ6Z6Xgi4wGUBkqGq8W9UeqRck46gRVha2IE=
Date: Fri, 11 Oct 2019 11:44:55 +0100
From: Will Deacon <will@kernel.org>
To: Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Subject: Re: [PATCH 0/2] Workaround for Cavium ThunderX2 erratum 219
Message-ID: <20191011104454.d7dplgyjcnpfi5p3@willie-the-truck>
References: <1570790105-31829-1-git-send-email-jnair@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570790105-31829-1-git-send-email-jnair@marvell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Tomasz Nowicki <tnowicki@marvell.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Robert Richter <rrichter@marvell.com>, Marc Zyngier <maz@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi JC,

Thanks for posting this.

On Fri, Oct 11, 2019 at 10:35:21AM +0000, Jayachandran Chandrasekharan Nair wrote:
> These two patches are based on the work by Marc Zyngier and addresses
> Cavium ThunderX2 erratum 219.
> 
> This erratum (originally reported by ARM folks) is from an interesting
> use of the prefetch instruction in the KPTI patchset. The prefetch
> was done between a TTBR change and the corresponding ISB, and this
> occasionally caused a crash on ThunderX2.
> 
> The first patch removes the troublesome prefetch for ThunderX2.
> The second patch addresses the case where the issue can be triggered
> from a guest kernel. The workaround in this case is to trap TTBR
> accesses by setting HCR_EL2.TVM for guests and doing the system
> register update from EL2 in a fast path.

FWIW, I was already planning to send the following to Linus:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=errata/tx2-219

so please base any changes on top of that branch.

> Due to the nature of the erratum, the trap-and-emulate is only
> needed when SMT is enabled.
> 
> The overhead of trap-and-emulate is expected to be negligible on most
> workloads. A command line option kvm-arm.vm_msr_trap has been
> provided to override trapping on guest TTBR updates.  This is to
> address a very limited case where a user wants to run SMT enabled,
> with a trustworthy guest kernel, and wants to avoid the performance
> overhead associated with emulating the address translation register
> changes.

Do you have any performance data to show the impact of the workaround on
non-kpti guests? I don't think we can justify the inclusion of a cmdline
option for this without figures showing that it's really necessary.
Otherwise, the "very limited case" really is a niche scenario where the
CONFIG option can simply be disabled.

Cheers,

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
