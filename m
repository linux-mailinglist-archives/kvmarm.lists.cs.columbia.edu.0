Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 71E951AE262
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 18:41:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D76A34B239;
	Fri, 17 Apr 2020 12:41:14 -0400 (EDT)
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
	with ESMTP id dxVqGG3Gbpe1; Fri, 17 Apr 2020 12:41:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B619A4B1FD;
	Fri, 17 Apr 2020 12:41:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 564CD4B18F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 12:41:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6hLpsB6wPbu for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 12:41:11 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 35D7E4B175
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 12:41:11 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E4A8F22209;
 Fri, 17 Apr 2020 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587141670;
 bh=yldu/9O+pI/74eLBcGiM5/HHh/VECo3WDbDrBUprZts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ulQaf7dBiblH0I77SP4hLxbd6p3rQIH28t4Osgf+X+dP31AGnFZ9mm73KZLWvJyK9
 jqHTCuPS790qnbi9L32WriRrlcbia2O5wnEGA0gaN+SRKdOHiS/bC5Qo+/W+x3c4Ag
 eWI+IFfxfOfiteIBkn3nYhDllHIGc8f0Sd40t2yQ=
Date: Fri, 17 Apr 2020 17:41:04 +0100
From: Will Deacon <will@kernel.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [RFC PATCH] arm64: unify WORKAROUND_SPECULATIVE_AT_{NVHE,VHE}
Message-ID: <20200417164103.GA12362@willie-the-truck>
References: <20200327143941.195626-1-ascull@google.com>
 <1705907b-234c-6f56-1360-f598c8047d1d@arm.com>
 <20200403125726.GA33049@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200403125726.GA33049@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "qwandor@google.com" <qwandor@google.com>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 "wedsonaf@google.com" <wedsonaf@google.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Fri, Apr 03, 2020 at 01:57:26PM +0100, Andrew Scull wrote:
> On Fri, Mar 27, 2020 at 02:59:47PM +0000, Steven Price wrote:
> > I proposed something similar a while ago[1], but Marc was concerned about
> > the microarch detail[2] and hence I split the workaround into VHE/non-VHE.
> > 
> > That said I'm not saying this is necessarily wrong, just that we'd need some
> > more information on whether the non-VHE workaround is suitable for the CPUs
> > we're currently forcing VHE on.
> 
> We noticed that both the nVHE and VHE workarounds share the same
> assumption that the EPDx bits are not being cached in the TLB.
> 
> `__tlb_switch_to_guest_vhe` and `__tlb_switch_to_guest_nvhe` are both
> setting EPDx as part of the workaround. However, neither handles the
> possibility of a speculative AT being able to make use of a cached EPD=0
> value in the TLB in order to allocate bad TLB entries.
> 
> If this is correct, the microarch concern appears to have been solved
> already. Otherwise, or if we are unsure, we should go ahead and add the
> TLB flushes to keep this safe.

I think Andrew's right here. Can we go ahead with the original approach of
combining the workarounds, or is there something we've missed?

Cheers,

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
