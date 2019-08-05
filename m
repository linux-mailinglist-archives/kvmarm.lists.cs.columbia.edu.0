Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B25268164C
	for <lists+kvmarm@lfdr.de>; Mon,  5 Aug 2019 12:03:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 059B84A551;
	Mon,  5 Aug 2019 06:03:24 -0400 (EDT)
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
	with ESMTP id DES8JYhtnPiq; Mon,  5 Aug 2019 06:03:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C96664A53F;
	Mon,  5 Aug 2019 06:03:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 40C114A532
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Aug 2019 06:03:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id omVKk9fgySGO for <kvmarm@lists.cs.columbia.edu>;
 Mon,  5 Aug 2019 06:03:20 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 200BB4A522
 for <kvmarm@lists.cs.columbia.edu>; Mon,  5 Aug 2019 06:03:20 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D63212075B;
 Mon,  5 Aug 2019 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564999399;
 bh=YOw3eXXTngamY2vUc4t6eNrKhwGf591Fl1XUuUTIR14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hSLcHvvUheEUjR3iZldH1kFTzjsmKYQEJY3qZfcH2XHVp85wSCD10iY/IOI7hrQ0M
 RXojUUFfKcGjxcUYjZhk++s1wQBVkRKmQhCSJkDbeHWO0jF/4x/0ofAqCZ0MduABXE
 R/xSf8650vmGSiEbz9ThcRl5ywyoTZtrvpD4W18g=
Date: Mon, 5 Aug 2019 11:03:14 +0100
From: Will Deacon <will@kernel.org>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 7/9] arm/arm64: Provide a wrapper for SMCCC 1.1 calls
Message-ID: <20190805100313.x65743i3n4qx6gyc@willie-the-truck>
References: <20190802145017.42543-1-steven.price@arm.com>
 <20190802145017.42543-8-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190802145017.42543-8-steven.price@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Fri, Aug 02, 2019 at 03:50:15PM +0100, Steven Price wrote:
> SMCCC 1.1 calls may use either HVC or SMC depending on the PSCI
> conduit. Rather than coding this in every call site provide a macro
> which uses the correct instruction. The macro also handles the case
> where no PSCI conduit is configured returning a not supported error
> in res, along with returning the conduit used for the call.
> 
> This allow us to remove some duplicated code and will be useful later
> when adding paravirtualized time hypervisor calls.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/linux/arm-smccc.h | 44 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
