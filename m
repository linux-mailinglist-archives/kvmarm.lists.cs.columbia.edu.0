Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A40483F0475
	for <lists+kvmarm@lfdr.de>; Wed, 18 Aug 2021 15:18:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 414FE4B0D1;
	Wed, 18 Aug 2021 09:18:08 -0400 (EDT)
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
	with ESMTP id IziWPZQmWHKR; Wed, 18 Aug 2021 09:18:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2915E4B0AC;
	Wed, 18 Aug 2021 09:18:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B9F7B4A534
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 09:18:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOE8GG6d4y1i for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Aug 2021 09:18:00 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 177DC4A3A5
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Aug 2021 09:18:00 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 968B76108F;
 Wed, 18 Aug 2021 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629292679;
 bh=JlUFeNxsEk8ffbZ4STeULEr4uHA+Xv6pEtdyqf9Ea4Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ReG+ER0rC7KxI+2srUFAOcPJZJSz3c2oz48BBu46iYswAb9jZFOWxXhLuKxAcimIX
 DjbXuVbs8PMt+XwbaUqcZD7T8/mgqBOs5TZvwBceHd2LO1wZZfjpd8iSPertpCTwdH
 L/mbn4Z4XrMNrCdgPRzjhkwKKRoWzMwHgdZGPW7XsZD2UBThC4EoObciO2qK3TjvH1
 qpWP/Um3VYghocI24UCPlREOoXOBa3MBU9UAaKJXOCHsoXjakHbIRQI7CqiFkSHys7
 b+Z89GvnyDj0Ck+DWAdb8S8m/90mkzktvSoEGyjEMADHbxESbiSxU8kX2kbAPD1ieW
 /LqDqCl5W1irA==
Date: Wed, 18 Aug 2021 14:17:53 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v4 07/15] KVM: arm64: Keep mdcr_el2's value as set by
 __init_el2_debug
Message-ID: <20210818131752.GE14107@willie-the-truck>
References: <20210817081134.2918285-1-tabba@google.com>
 <20210817081134.2918285-8-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210817081134.2918285-8-tabba@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org, maz@kernel.org,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, Aug 17, 2021 at 09:11:26AM +0100, Fuad Tabba wrote:
> __init_el2_debug configures mdcr_el2 at initialization based on,
> among other things, available hardware support. Trap deactivation
> doesn't check that, so keep the initial value.
> 
> No functional change intended. However, the value of mdcr_el2
> might be different after deactivating traps than it was before
> this patch.

I think this sentence is very confusing, so I'd remove it. I also don't
think it's correct, as the EL2 initialisation code only manipulates the
bits which are being masked here.

So with that sentence removed:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
