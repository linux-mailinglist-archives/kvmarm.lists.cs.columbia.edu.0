Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 902F9167DC5
	for <lists+kvmarm@lfdr.de>; Fri, 21 Feb 2020 13:55:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE0B64AEF3;
	Fri, 21 Feb 2020 07:55:24 -0500 (EST)
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
	with ESMTP id lXNtF07rE1xb; Fri, 21 Feb 2020 07:55:24 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C33F4AEE6;
	Fri, 21 Feb 2020 07:55:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 88A104AED5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Feb 2020 07:55:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUoMuzdNSPwP for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Feb 2020 07:55:19 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 662794AEA1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Feb 2020 07:55:19 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 094EC206EF;
 Fri, 21 Feb 2020 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582289718;
 bh=bCHIKq7xRJ3aaXYyj+S6libfKhwz5P3LINS5aKJYKJ4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vF1yCqUpEJpjFfoNbS8nSY6aPEFoswx0L3DHVJ27X/8r8+/FA/5rZWg0jfsL8E4+e
 av1xfnVFCOnWnpwNqxoazJ7u55ILnpdlu3SokNkLRAqUhkiF0LoOnoIgVQAwCRAK+y
 W2AOnGpzrYBlxViDcoq5QZIgM51kRZId5sP/5nQo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1j57ps-0072NR-Ah; Fri, 21 Feb 2020 12:55:16 +0000
MIME-Version: 1.0
Date: Fri, 21 Feb 2020 12:55:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 0/3] KVM: arm64: Ask the compiler to __always_inline
 functions used by KVM at HYP
In-Reply-To: <20200220165839.256881-1-james.morse@arm.com>
References: <20200220165839.256881-1-james.morse@arm.com>
Message-ID: <cb56f509ea0a4a9e1809af76f319daa2@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
 ard.biesheuvel@linaro.org, samitolvanen@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Sami Tolvanen <samitolvanen@google.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

Hi James,

On 2020-02-20 16:58, James Morse wrote:
> Hello!
> 
> It turns out KVM relies on the inline hint being honoured by the 
> compiler
> in quite a few more places than expected. Something about the Shadow 
> Call
> Stack support[0] causes the compiler to avoid inline-ing and to place
> these functions outside the __hyp_text. This ruins KVM's day.
> 
> Add the simon-says __always_inline annotation to all the static
> inlines that KVM calls from HYP code.
> 
> This series based on v5.6-rc2.

Many thanks for going through all this.

I'm happy to take it if Catalin or Will ack the arm64 patches.
It case we decide to go the other way around:

Acked-by: Marc Zyngier <maz@kernel.org>

One thing I'd like to look into though is a compile-time check that
nothing in the hyp_text section has a reference to a non-hyp_text
symbol.

We already have checks around non-init symbols pointing to init symbols,
and I was wondering if we could reuse this for fun and profit...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
