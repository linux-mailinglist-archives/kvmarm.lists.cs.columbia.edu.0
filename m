Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3745E1B4880
	for <lists+kvmarm@lfdr.de>; Wed, 22 Apr 2020 17:22:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A52164B199;
	Wed, 22 Apr 2020 11:22:58 -0400 (EDT)
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
	with ESMTP id uIfyV4GU0H2z; Wed, 22 Apr 2020 11:22:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C6EE4B14F;
	Wed, 22 Apr 2020 11:22:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 151A44B0B1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 11:22:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ga4a4jXG0eAd for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Apr 2020 11:22:55 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DF53A4B08B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Apr 2020 11:22:54 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D73C220774;
 Wed, 22 Apr 2020 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587568973;
 bh=8XuOqehhERZZcf92nOhLBVrA+6Dpuk+XPlrnJq30fOA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jm/0hbTpl0wzVkrvHzxvampYRVOqyuz82Ao8DR/Mvia3gHLGIFkGhMDA/qI0CixeC
 /cki7uv31jV6rOS+W7VhEqkFFnucNSzgQHTOYniE/4sMnsyfuXL4mmJRAKWrZE3dr8
 WbGSW2FGb+5BPRK4wC7UnH9zN+U7nBdaD7eTN/zo=
Date: Wed, 22 Apr 2020 16:22:49 +0100
From: Will Deacon <will@kernel.org>
To: maz@kernel.org
Subject: Re: [PATCH] arm64/kvm: Fix duplicate tracepoint definitions after
 KVM consolidation
Message-ID: <20200422152249.GE676@willie-the-truck>
References: <20200421091707.16743-1-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200421091707.16743-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Tue, Apr 21, 2020 at 10:17:07AM +0100, Will Deacon wrote:
> Both kvm/{arm,handle_exit}.c include trace.h and attempt to instantiate
> the same tracepoints, resulting in failures at link-time:
> 
>   | aarch64-linux-gnu-ld: arch/arm64/kvm/handle_exit.o:(__tracepoints+0x30):
>   |   multiple definition of `__tracepoint_kvm_wfx_arm64';
>   |   arch/arm64/kvm/arm.o:(__tracepoints+0x510): first defined here
>   | ...
> 
> Split trace.h into two files so that the tracepoints are only created
> in the C files that use them.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
> 
> Applies against kvm-arm64/welcome-home. Probably worth just folding in
> to the only commit on that branch.

I also just noticed that you forgot to update MAINTAINERS after the move,
so you can fold in the diff below as well.

Will

--->8

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..7bff7e94a930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9299,7 +9299,6 @@ F:	arch/arm64/include/asm/kvm*
 F:	arch/arm64/include/uapi/asm/kvm*
 F:	arch/arm64/kvm/
 F:	include/kvm/arm_*
-F:	virt/kvm/arm/
 
 KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips)
 L:	linux-mips@vger.kernel.org
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
