Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DE7AB2D5C66
	for <lists+kvmarm@lfdr.de>; Thu, 10 Dec 2020 14:53:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 612E54B1A4;
	Thu, 10 Dec 2020 08:53:52 -0500 (EST)
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
	with ESMTP id te3h-LRR0fbu; Thu, 10 Dec 2020 08:53:52 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1469F4B1D1;
	Thu, 10 Dec 2020 08:53:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 84A714B1A2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 08:53:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmm8i4aLsUZl for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Dec 2020 08:53:48 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 612B74B17E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Dec 2020 08:53:48 -0500 (EST)
Date: Thu, 10 Dec 2020 13:53:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607608427;
 bh=NjrQ4FJF5266Z90UJ72u1Wg6hCMf64J2BYn3ruDlCmM=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=OEPHAVOhWkIGpVAHib6eInZKs+4RcuFzg6tl2dG3haMd7QNgF9yOHoMF7ye0hqlQ9
 omcJKaLkBYMJASEvcgVM0BV6YOzfh7esaPQiE6sILqzQSK/g44y8XrjQHwpfCXYrmH
 EuEU34T3U6N4Ww+DQ4Se5XmyU+DcdKaLZT9ebxOdI+oc+YAX6h5NXLfeR12zrU+roq
 qdVBWzVj9hyBfCa4ChpHMVk/R6OnHepOX5D3r9iGoySk/z4RpRwRxAefIrJMMCT3fc
 /6EnxEqfvpMpArhXZg6MGSo/acLDk5cDdE6kMPyW9rhg5cN7lhMxV+XIQLS5ZjlqCo
 iOKArx0T+z5JQ==
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 0/2] KVM: arm64: Expose CSV3 to guests on running on
 Meltdown-safe HW
Message-ID: <20201210135341.GA10255@willie-the-truck>
References: <20201204183709.784533-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201204183709.784533-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, David Brazdil <dbarzdil@google.com>,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
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

On Fri, Dec 04, 2020 at 06:37:07PM +0000, Marc Zyngier wrote:
> Will recently pointed out that when running on big-little systems that
> are known not to be vulnerable to Metldown, guests are not presented
> with the CSV3 property if the physical HW include a core that doesn't
> have CSV3, despite being known to be safe (it is on the kpti_safe_list).
> 
> Since this is valuable information that can be cheaply given to the
> guest, let's just do that. The scheme is the same as what we do for
> CSV2, allowing userspace to change the default setting if this doesn't
> advertise a safer setting than what the kernel thinks it is.
> 
> * From v1:
>   - Fix the clearing of ID_AA64PFR0_EL1.CSV3 on update from userspace
>   - Actually store the userspace value
> 
> Marc Zyngier (2):
>   arm64: Make the Meltdown mitigation state available
>   KVM: arm64: Advertise ID_AA64PFR0_EL1.CSV3=1 if the CPUs are
>     Meltdown-safe

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
