Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B352E1533AA
	for <lists+kvmarm@lfdr.de>; Wed,  5 Feb 2020 16:18:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 12C474A650;
	Wed,  5 Feb 2020 10:18:12 -0500 (EST)
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
	with ESMTP id rnTnJzNN0w3Y; Wed,  5 Feb 2020 10:18:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D11F04A597;
	Wed,  5 Feb 2020 10:18:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 728834A51F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Feb 2020 10:18:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qKnmPo-nGPHE for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Feb 2020 10:18:08 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4B7A24A4A0
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Feb 2020 10:18:08 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DEF921927;
 Wed,  5 Feb 2020 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580915887;
 bh=NjMtCH7e1lEgkw+UMOfnxM45wLLuwDnPbf87CRI+yiM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Pk1qMj98DbqsrY9zinX98tPIosYlQDmFJUfNGjO3f6+6PUDmBrZ3KqEah87F3scC0
 A1zO+7lBUSwfFGjGeEKJJwsFgqbdslcWmf+Hb9mMb3wLN0DG1KOztvq+G+MxaIkyjZ
 LVqEpHPTFP1i9aw0NG1O15O7yOs2MJCHGlvPwQ8o=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1izMRJ-0039cd-Dy; Wed, 05 Feb 2020 15:18:05 +0000
MIME-Version: 1.0
Date: Wed, 05 Feb 2020 15:18:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: Jeremy Cline <jcline@redhat.com>
Subject: Re: [PATCH] KVM: arm/arm64: Fix up includes for trace.h
In-Reply-To: <20200205134146.82678-1-jcline@redhat.com>
References: <20200205134146.82678-1-jcline@redhat.com>
Message-ID: <e3446187abb20eb2a95eae1f51b36ca1@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jcline@redhat.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On 2020-02-05 13:41, Jeremy Cline wrote:
> Fedora kernel builds on armv7hl began failing recently because
> kvm_arm_exception_type and kvm_arm_exception_class were undeclared in
> trace.h. Add the missing include.
> 
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
> 
> I've not dug very deeply into what exactly changed between commit
> b3a608222336 (the last build that succeeded) and commit 14cd0bd04907,
> but my guess was commit 0e20f5e25556 ("KVM: arm/arm64: Cleanup MMIO
> handling").
> 
> Fedora's build config is available at
> https://src.fedoraproject.org/rpms/kernel/blob/master/f/kernel-armv7hl-fedora.config

This config doesn't have KVM enabled.

> 
>  virt/kvm/arm/trace.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
> index 204d210d01c2..cc94ccc68821 100644
> --- a/virt/kvm/arm/trace.h
> +++ b/virt/kvm/arm/trace.h
> @@ -4,6 +4,7 @@
> 
>  #include <kvm/arm_arch_timer.h>
>  #include <linux/tracepoint.h>
> +#include <asm/kvm_arm.h>
> 
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM kvm

After enabling KVM in the above config (which requires LPAE), I've 
managed to reproduce
the problem.

Fix now queued, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
