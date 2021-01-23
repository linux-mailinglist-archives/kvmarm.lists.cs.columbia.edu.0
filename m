Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B6301575
	for <lists+kvmarm@lfdr.de>; Sat, 23 Jan 2021 14:44:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BBC434B101;
	Sat, 23 Jan 2021 08:44:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g7wJhL00uAlY; Sat, 23 Jan 2021 08:44:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 99CEB4B153;
	Sat, 23 Jan 2021 08:44:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DEA094B13B
 for <kvmarm@lists.cs.columbia.edu>; Sat, 23 Jan 2021 08:44:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K6pHhC9EqLAU for <kvmarm@lists.cs.columbia.edu>;
 Sat, 23 Jan 2021 08:43:59 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CF7714B101
 for <kvmarm@lists.cs.columbia.edu>; Sat, 23 Jan 2021 08:43:59 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C232C22AAD;
 Sat, 23 Jan 2021 13:43:55 +0000 (UTC)
Date: Sat, 23 Jan 2021 13:43:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 12/21] arm64: cpufeature: Add an early command-line
 cpufeature override facility
Message-ID: <YAwoGDODQKq3798H@Catalins-MacBook-Air.local>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-13-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-13-maz@kernel.org>
Cc: Prasad Sodagudi <psodagud@codeaurora.org>,
 Srinivas Ramana <sramana@codeaurora.org>, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ajay Patil <pajay@qti.qualcomm.com>,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Jan 18, 2021 at 09:45:24AM +0000, Marc Zyngier wrote:
> +struct reg_desc {
> +	const char * const	name;
> +	u64 * const		val;
> +	u64 * const		mask;
> +	struct {
> +		const char * const	name;
> +		u8			 shift;
> +	} 			fields[];
> +};

Sorry, I didn't see this earlier. Do we need to add all these consts
here? So you want the pointers to be const but why is 'shift' special
and not a const then? Is it modified later?

Would this not work:

struct reg_desc {
	const char	*name;
	u64		*val;
	u64		*mask;
	struct {
		const char	*name;
		u8		shift;
	} fields[];
};

> +static const struct reg_desc * const regs[] __initdata = {

as we already declare the whole struct reg_desc pointers here as const.
I may have confused myself...

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
