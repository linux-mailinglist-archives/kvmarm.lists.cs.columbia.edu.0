Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 12E612D17B1
	for <lists+kvmarm@lfdr.de>; Mon,  7 Dec 2020 18:41:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A6A694B274;
	Mon,  7 Dec 2020 12:41:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id awzbhUXF-mcg; Mon,  7 Dec 2020 12:41:58 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 828624B269;
	Mon,  7 Dec 2020 12:41:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7715D4B238
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Dec 2020 12:41:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3QTgxgJxjXfA for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Dec 2020 12:41:55 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7E4954B190
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Dec 2020 12:41:55 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6618121D42;
 Mon,  7 Dec 2020 17:41:54 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kmKWG-00GpPw-C4; Mon, 07 Dec 2020 17:41:52 +0000
MIME-Version: 1.0
Date: Mon, 07 Dec 2020 17:41:52 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] arm64: Work around broken GCC handling of "S" constraint
In-Reply-To: <CAMj1kXG9mmC8wY9Gvo-oJat0bZTNk495x1Hmmi-_FXbu-gDzDw@mail.gmail.com>
References: <20201207154341.1004276-1-maz@kernel.org>
 <CAMj1kXHb9=KPkCAwYWDFH1ddy_p3sDTZ7QemtvWV8nC_14rN+g@mail.gmail.com>
 <CAMj1kXG9mmC8wY9Gvo-oJat0bZTNk495x1Hmmi-_FXbu-gDzDw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <87316821c90a13a912a624250055f50f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, dbrazdil@google.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, catalin.marinas@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Android Kernel Team <kernel-team@android.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On 2020-12-07 17:19, Ard Biesheuvel wrote:
> (resend with David's email address fixed)

Irk. Thanks for that.

>> > +#ifdef CONFIG_CC_HAS_BROKEN_S_CONSTRAINT
>> > +#define SYM_CONSTRAINT "i"
>> > +#else
>> > +#define SYM_CONSTRAINT "S"
>> > +#endif
>> > +
>> 
>> Could we just check GCC_VERSION here?

I guess we could. But I haven't investigated which exact range of
compiler is broken (GCC 6.3 seems fixed, but that's the oldest
I have apart from the offending 4.9).

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
