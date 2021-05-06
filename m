Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE1374C39
	for <lists+kvmarm@lfdr.de>; Thu,  6 May 2021 02:14:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6DE234B445;
	Wed,  5 May 2021 20:14:26 -0400 (EDT)
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
	with ESMTP id tPcuc4Py-kbJ; Wed,  5 May 2021 20:14:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4223B4B43A;
	Wed,  5 May 2021 20:14:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D1404B420
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 May 2021 20:14:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ozS9xEds-teF for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 May 2021 20:14:22 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E946C4B331
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 May 2021 20:14:21 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A601261164;
 Thu,  6 May 2021 00:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620260060;
 bh=096xI+qq81ppXCw9EPK5Ma7vQkLFbEJxt4UQKHOxELA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Czy/j8JRaeWc7sta2wP4tEgSiNHaGZdKqOHSZjKaiKPGuLPy8rT4olB3BqJe8oAgZ
 VcgVLEo7aQBKvMi2/T3ay0LYiFVKkABB8zNUlMsKhfwo8MsA8ER1tgeITS+SN5jYav
 P/cknbOOsx+2jRW25JMIqS7uR8uAMVPV4p+jyP6X2SCQrpcV9vfFDOUwuULqzufdzd
 JRRmgrABnemgDzuCTsZRwVsjqBA+SgPAmlsoU2/QqBZ/I6cX8BoGqFzealQDIN5xn7
 GlUgZV9mVSR4b3zMeNJ2nBMC00EuzM0AbKvbebJHdb8d1fm3OFApcS6XmIitec4guG
 ecKqYoOvojTJA==
Date: Wed, 5 May 2021 20:14:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.11 036/104] KVM: arm64: Use BUG and BUG_ON in
 nVHE hyp
Message-ID: <YJM02uCYV24jrg+N@sashalap>
References: <20210505163413.3461611-1-sashal@kernel.org>
 <20210505163413.3461611-36-sashal@kernel.org>
 <874kfhnn2k.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874kfhnn2k.wl-maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Wed, May 05, 2021 at 05:48:51PM +0100, Marc Zyngier wrote:
>Sasha,
>
>On Wed, 05 May 2021 17:33:05 +0100,
>Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Andrew Scull <ascull@google.com>
>>
>> [ Upstream commit f79e616f27ab6cd74deb0995a8eead3d1c9d65af ]
>>
>> hyp_panic() reports the address of the panic by using ELR_EL2, but this
>> isn't a useful address when hyp_panic() is called directly. Replace such
>> direct calls with BUG() and BUG_ON() which use BRK to trigger an
>> exception that then goes to hyp_panic() with the correct address. Also
>> remove the hyp_panic() declaration from the header file to avoid
>> accidental misuse.
>>
>> Signed-off-by: Andrew Scull <ascull@google.com>
>> Acked-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Link: https://lore.kernel.org/r/20210318143311.839894-5-ascull@google.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This has no chance of working without the patches that enable BUG()
>support at EL2, and *really* isn't stable material.
>
>Please drop this patch.

Will do, thanks!

-- 
Thanks,
Sasha
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
