Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BD4433EA12E
	for <lists+kvmarm@lfdr.de>; Thu, 12 Aug 2021 10:59:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C84C4A3BF;
	Thu, 12 Aug 2021 04:59:42 -0400 (EDT)
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
	with ESMTP id 4ZbRSbIqsTzV; Thu, 12 Aug 2021 04:59:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F31D4A1AF;
	Thu, 12 Aug 2021 04:59:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B3B2549E93
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 04:59:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zy1BSaSWEIJx for <kvmarm@lists.cs.columbia.edu>;
 Thu, 12 Aug 2021 04:59:35 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D4CBD40839
 for <kvmarm@lists.cs.columbia.edu>; Thu, 12 Aug 2021 04:59:35 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A969F6103A;
 Thu, 12 Aug 2021 08:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628758774;
 bh=4DUeuUPXJ9YkgfHJ3idaWRU8OrWSUOhWlkj96EgFH18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lAhd5jLoeFXGjCWRzXch7wQA0ymZWKH9PdJMX0CMFloTzMB8JcCmRPTVnESvo04Uf
 0A7eaN3VlakFMuAHcmi6tazp9k4YGq5Go6mvmKGRa5NJGWrEYmIDf9qt6GsUB1WKpr
 3C611NqL/+qazEyhzu3BLDQThOIQAElxqPhSqVkayslanV8D580qFPkgRnigRl0ksW
 p5LFgGmOTspWZIAdxeCG2/4yzqJgim+jlACsKe3Vpqn8Y39O3Kd8MKt1EfJ0OkDGw3
 PWScIm+TVsKwtV0K2li/OW3vCQZi9Ik9TLQ0VvamIcdgtuBG7Gn1NUcIo354/f00hH
 VV6d4LDlWOfwQ==
Date: Thu, 12 Aug 2021 09:59:29 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v3 07/15] KVM: arm64: Track value of cptr_el2 in struct
 kvm_vcpu_arch
Message-ID: <20210812085929.GE5912@willie-the-truck>
References: <20210719160346.609914-1-tabba@google.com>
 <20210719160346.609914-8-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210719160346.609914-8-tabba@google.com>
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

On Mon, Jul 19, 2021 at 05:03:38PM +0100, Fuad Tabba wrote:
> Track the baseline guest value for cptr_el2 in struct
> kvm_vcpu_arch, similar to the other registers that control traps.
> Use this value when setting cptr_el2 for the guest.
> 
> Currently this value is unchanged (CPTR_EL2_DEFAULT), but future
> patches will set trapping bits based on features supported for
> the guest.
> 
> No functional change intended.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 1 +
>  arch/arm64/kvm/arm.c              | 1 +
>  arch/arm64/kvm/hyp/nvhe/switch.c  | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
