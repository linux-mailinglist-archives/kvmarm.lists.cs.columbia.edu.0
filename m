Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF53367EF2
	for <lists+kvmarm@lfdr.de>; Thu, 22 Apr 2021 12:47:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DBD2B4B4B1;
	Thu, 22 Apr 2021 06:47:12 -0400 (EDT)
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
	with ESMTP id jj4rn1uUIVhs; Thu, 22 Apr 2021 06:47:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD2774B4D2;
	Thu, 22 Apr 2021 06:47:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 564C44B4B1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 06:47:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1qP7Oe2kg90M for <kvmarm@lists.cs.columbia.edu>;
 Thu, 22 Apr 2021 06:47:09 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 594694B413
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Apr 2021 06:47:09 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D82A61409;
 Thu, 22 Apr 2021 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619088428;
 bh=c00PLQfj9zNo6Kusw3zsLW4rKknJihekgM7hsgZq3pg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JC+Ctv3WSj9GhEWkE7fGRfC/UuJtaYZ0/mddeYWGbSXVSu55XK+H64iILq3z2a3Li
 WFkZHMz15rf0YkkMoA8pz0yhG3S9D0UiB2+xYeqwGNvVK6HaIUML/Y3hKl/RVTGjmC
 vuQv8zVYlG+sg2yYxuP0lHHE028x0NeEtnYo8RaFPF39ED5lEbe3WiWUkc+H3GQRFT
 QO4VTywWvgWaEGym+bg+IXyJPgT79F3nGOt43Kn4OpaaQYWOBePeFdiqRxaen6oTw6
 zlyIJ/KFqXMfBiu4ffMb/cLcm3/TuYa7J4SkEFNlPhO+XHQ9KSdf8w4i4hyJ4zgyUz
 /+i5XCItEkxAg==
Date: Thu, 22 Apr 2021 11:47:00 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 5/5] perf: Get rid of oprofile leftovers
Message-ID: <20210422104700.GE1442@willie-the-truck>
References: <20210414134409.1266357-1-maz@kernel.org>
 <20210414134409.1266357-6-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210414134409.1266357-6-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, kvm@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 nathan@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Wed, Apr 14, 2021 at 02:44:09PM +0100, Marc Zyngier wrote:
> perf_pmu_name() and perf_num_counters() are unused. Drop them.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/perf_event.h | 2 --
>  kernel/events/core.c       | 5 -----
>  2 files changed, 7 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
