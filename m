Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F2D603DDE01
	for <lists+kvmarm@lfdr.de>; Mon,  2 Aug 2021 18:52:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B8D14A32E;
	Mon,  2 Aug 2021 12:52:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9xUcN46bxwr; Mon,  2 Aug 2021 12:52:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 294A140895;
	Mon,  2 Aug 2021 12:52:23 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8194340667
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Aug 2021 12:52:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uUwSWOqzuQwM for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Aug 2021 12:52:20 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C60040623
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Aug 2021 12:52:20 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89CCB610FF;
 Mon,  2 Aug 2021 16:52:17 +0000 (UTC)
Date: Mon, 2 Aug 2021 17:52:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 2/2] KVM: arm64: Unregister HYP sections from kmemleak
 in protected mode
Message-ID: <20210802165214.GK18685@arm.com>
References: <20210802123830.2195174-1-maz@kernel.org>
 <20210802123830.2195174-3-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210802123830.2195174-3-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 stable@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Mon, Aug 02, 2021 at 01:38:30PM +0100, Marc Zyngier wrote:
> Booting a KVM host in protected mode with kmemleak quickly results
> in a pretty bad crash, as kmemleak doesn't know that the HYP sections
> have been taken away. This is specially true for the BSS section,
> which is part of the kernel BSS section and registered at boot time
> by kmemleak itself.
> 
> Unregister the HYP part of the BSS before making that section
> HYP-private. The rest of the HYP-specific data is obtained via
> the page allocator or lives in other sections, none of which is
> subjected to kmemleak.
> 
> Fixes: 90134ac9cabb ("KVM: arm64: Protect the .hyp sections from the host")
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: stable@vger.kernel.org # 5.13

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
