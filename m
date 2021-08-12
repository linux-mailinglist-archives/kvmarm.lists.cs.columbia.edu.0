Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB63EA294
	for <lists+kvmarm@lfdr.de>; Thu, 12 Aug 2021 11:59:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EF706405A9;
	Thu, 12 Aug 2021 05:59:52 -0400 (EDT)
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
	with ESMTP id 2n1zH33kyB1l; Thu, 12 Aug 2021 05:59:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D1FB94A1A7;
	Thu, 12 Aug 2021 05:59:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D08949FE6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 05:59:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZlJx5TithP0q for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Aug 2021 05:59:47 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0706D49F83
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 05:59:47 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B160260FC4;
 Thu, 12 Aug 2021 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628762386;
 bh=xhJTzirtcBObaMNh3L8mgpZhwBRzbdzx21Im4hyotWo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mGbsEoq/0jOgKOOuYwiObaj/Yo1csUtEQC9KIgPGavdArcPFxAVMaF64mVewbSu2U
 5IvPkIRglcC07FiTaV5o5QV5Y4vOYO32N9OCwyusHfz6Qui+vqAC8mKzbPXTbClvn+
 VC8W2TF9pQ0fYvndiFmJBhpOAsfboDlhkgEn31ixaruKarsaaq4k1CPOWjJHZstUa3
 WD2ij1Cty5+dsTXVpRKWyMwFxBIZDqD25B8nesZQNBFf+VhhTdpvSKQNtJrOpazIPc
 H82NKgpZYnDdqm7jx2xeAin1ZZd3biXCmoSLrzqyHbzm/Q+tgkaxOzdeYT9DI0Xmqa
 OxOYwQOimZN3Q==
Date: Thu, 12 Aug 2021 10:59:40 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 15/15] KVM: arm64: Restrict protected VM capabilities
Message-ID: <20210812095938.GM5912@willie-the-truck>
References: <20210719160346.609914-1-tabba@google.com>
 <20210719160346.609914-16-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210719160346.609914-16-tabba@google.com>
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

On Mon, Jul 19, 2021 at 05:03:46PM +0100, Fuad Tabba wrote:
> Restrict protected VM capabilities based on the
> fixed-configuration for protected VMs.
> 
> No functional change intended in current KVM-supported modes
> (nVHE, VHE).
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/include/asm/kvm_fixed_config.h | 10 ++++
>  arch/arm64/kvm/arm.c                      | 63 ++++++++++++++++++++++-
>  arch/arm64/kvm/pkvm.c                     | 30 +++++++++++
>  3 files changed, 102 insertions(+), 1 deletion(-)

This patch looks good to me, but I'd be inclined to add this to the user-ABI
series given that it's really all user-facing and, without a functional
kvm_vm_is_protected(), isn't serving much purpose.

Cheers,

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
