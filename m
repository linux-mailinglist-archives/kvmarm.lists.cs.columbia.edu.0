Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 967C450E6A4
	for <lists+kvmarm@lfdr.de>; Mon, 25 Apr 2022 19:14:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 148734B29E;
	Mon, 25 Apr 2022 13:14:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1xORdOU9EnMk; Mon, 25 Apr 2022 13:14:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D88C34B262;
	Mon, 25 Apr 2022 13:14:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AB4B4B262
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Apr 2022 13:14:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y1Bqy95XJvxz for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Apr 2022 13:14:17 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D881F4B241
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Apr 2022 13:14:17 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B74F661521;
 Mon, 25 Apr 2022 17:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F3DC385A7;
 Mon, 25 Apr 2022 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650906856;
 bh=30Xz83WjEjlPuGd160S3OWJ2GpjN1lAzqyn8HINC7ls=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=spuipJBRHJwnDWhFTncEFli4zdLKIZZbYgxNMmI1s8C3wJh9cHq9Dpwmx/Dm0VimT
 XLWE5qIiybFAzOWn1AZ8esybrFrlnwYsuaGVLuz5pzj2aAc9ifnAE/jTGJXpJ8QIr7
 nnS+CC/BhzPLTfpvK32WsVncQjf9XqzsOqq9oOqqd5uDy1NS8FNtEabu3uf9GSmuZ/
 Z2bxovHHu3PlkzxN//yxqIX8+Vnn0yHXSN93ZtJl9n3qD8lrzjx8AGO87gzPulhNai
 pdEzhOmUYLPEy8xzz/Bqi3ku6qRxLtiCf31ibq6mGtD7RDapXiJBxZ5LBMkkDAhXvC
 6WzL43KHXu8Cg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nj2Ht-006qcE-Iv; Mon, 25 Apr 2022 18:14:13 +0100
Date: Mon, 25 Apr 2022 18:14:13 +0100
Message-ID: <875ymx9jbu.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH] KVM/arm64: Don't emulate a PMU for 32-bit guests if
 feature not set
In-Reply-To: <20220425145530.723858-1-alexandru.elisei@arm.com>
References: <20220425145530.723858-1-alexandru.elisei@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com, james.morse@arm.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, oupton@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
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

[+ Oliver]

Hi Alex,

On Mon, 25 Apr 2022 15:55:30 +0100,
Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> 
> kvm->arch.arm_pmu is set when userspace attempts to set the first PMU
> attribute. As certain attributes are mandatory, arm_pmu ends up always
> being set to a valid arm_pmu, otherwise KVM will refuse to run the VCPU.
> However, this only happens if the VCPU has the PMU feature. If the VCPU
> doesn't have the feature bit set, kvm->arch.arm_pmu will be left
> uninitialized and equal to NULL.

Although I'm not opposed to this as an immediate workaround to avoid
the ugly crash, I think sanitising the AArch32 regs is the way to go.
Oliver had a stab at this a few weeks back[1], but this seem to have
stalled.

Could you have a look and see if anything was missing (the patches
needed some rework, but I haven't checked whether DFR0 was correctly
handled or not).

Thanks,

	M.

[1] https://lore.kernel.org/r/20220401010832.3425787-1-oupton@google.com

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
