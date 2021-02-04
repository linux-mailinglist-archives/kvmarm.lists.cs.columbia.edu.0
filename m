Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3241A30AFAC
	for <lists+kvmarm@lfdr.de>; Mon,  1 Feb 2021 19:43:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C18524B3E2;
	Mon,  1 Feb 2021 13:43:19 -0500 (EST)
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
	with ESMTP id c4rxIEcZ3cIH; Mon,  1 Feb 2021 13:43:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AE9404B3D2;
	Mon,  1 Feb 2021 13:43:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1AE3A4B3C1
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 13:43:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qaUd5ifZO8PV for <kvmarm@lists.cs.columbia.edu>;
 Mon,  1 Feb 2021 13:43:16 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3101C4B25C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  1 Feb 2021 13:43:16 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 805CE64DDF;
 Mon,  1 Feb 2021 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612204995;
 bh=RhFJNirKCc5qirqDWt9dnB9pJEbvJC3OwoCh/S0tJag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GvsXOT9M6tx7XU32S2LQD3zE2QDOGi4NxYCdsgJUaIrVYsIaqjvwPE2ahcsSZOj+P
 DGfrm+cXrn9/hr2JY9DDEnNhvSNIi01Yg9AdtEzGT9z5D8RoJpCNGlZUTJCM8hayoC
 G4vUpck6IZGgopBzuKucK0HQdLAoaC1pq58RoB/dU8TBUxAc8qggzgQHUslRP3ay7k
 +ATbfYqpcmfFwBAFaIfMcCGPu+fAvqmkodFkVr6KkGlUwsBw+TluMAKEBHXbmuB7um
 1OooYeBO0KUdUF5+ux23pxikLy0zOGTvP52Oiiwo2AScyIHpoIHB/mdnPvm6YvyP7W
 MPwRJF6Mu3s3g==
Date: Mon, 1 Feb 2021 18:43:09 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 09/26] KVM: arm64: Allow using kvm_nvhe_sym() in
 hyp code
Message-ID: <20210201184309.GH15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-10-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-10-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, kvmarm@lists.cs.columbia.edu
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

On Fri, Jan 08, 2021 at 12:15:07PM +0000, Quentin Perret wrote:
> In order to allow the usage of code shared by the host and the hyp in
> static inline library function, allow the usage of kvm_nvhe_sym() at el2

typo: functions

> by defaulting to the raw symbol name.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/hyp_image.h | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
