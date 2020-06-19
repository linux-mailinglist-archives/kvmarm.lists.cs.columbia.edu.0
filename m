Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EAAD12005FF
	for <lists+kvmarm@lfdr.de>; Fri, 19 Jun 2020 12:06:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 807264B183;
	Fri, 19 Jun 2020 06:06:42 -0400 (EDT)
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
	with ESMTP id ePWKqPIe28UJ; Fri, 19 Jun 2020 06:06:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5EF694B13C;
	Fri, 19 Jun 2020 06:06:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E8FF04B13C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Jun 2020 06:06:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cCMmhhzbuEnr for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Jun 2020 06:06:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 050D34B127
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Jun 2020 06:06:39 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE8E52073E;
 Fri, 19 Jun 2020 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592561197;
 bh=DWSDBScNwddwzZeNQuc8t3eZi3YeAqlJ80SvLgG6nS8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qIufNTZj6yHfnPnBRaf2owSdXt7OVv7IpCYl31/NDFk71OtOv+pZZqp0d8gLcdubc
 TDzWmk0gLtWleYLotZ1fKE9J16A0E/65QArtUQm0riJj+wYsYWhuzvh/TDqu6dmvam
 KkjDqDbCPnaAwVGwUECfJZMmVIuxBpYakWWlymGQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jmDuu-004QT8-7C; Fri, 19 Jun 2020 11:06:36 +0100
MIME-Version: 1.0
Date: Fri, 19 Jun 2020 11:06:36 +0100
From: Marc Zyngier <maz@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v3 02/15] arm64: kvm: Move __smccc_workaround_1_smc to
 .rodata
In-Reply-To: <20200619095120.wenkbs5bl3wbyiyh@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-3-dbrazdil@google.com>
 <02322fdac903aa1786c334d0ddd7f38a@kernel.org>
 <20200619095120.wenkbs5bl3wbyiyh@google.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <eac273f8f0801969c650a3bd78052e0a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, will@kernel.org,
 catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 android-kvm@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On 2020-06-19 10:51, David Brazdil wrote:
> Hey Marc,
> 
>> > -	.popsection
>> 
>> I'd be tempted to leave the .popsection in place, if only for symmetry 
>>  with
>> the initial .pushsection.
> 
> I removed it because other .S files don't pop either. It must have been 
> added
> here purely for the smccc workaround code. Happy to add it back if you 
> prefer,
> but the pushsection is removed later in the series, so this would 
> disappear
> as well.

Don't bother then.

> 
>> > +	.pushsection	.rodata
>> > +	.global		__smccc_workaround_1_smc
>> > +__smccc_workaround_1_smc:
>> 
>> You probably want to replace this with SYM_DATA_START (and 
>> SYM_DATA_END at
>> the end).
> 
> Done

Thanks!

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
