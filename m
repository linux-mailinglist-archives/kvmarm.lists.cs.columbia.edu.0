Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8B302337D7F
	for <lists+kvmarm@lfdr.de>; Thu, 11 Mar 2021 20:17:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A1A9A4B6EA;
	Thu, 11 Mar 2021 14:17:29 -0500 (EST)
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
	with ESMTP id m9gIDWUUo-Xe; Thu, 11 Mar 2021 14:17:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 548144B6D5;
	Thu, 11 Mar 2021 14:17:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 179F24B627
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 14:17:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a7lgHYudSobL for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Mar 2021 14:17:25 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E5AA74B52D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Mar 2021 14:17:24 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F13364E21;
 Thu, 11 Mar 2021 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615490243;
 bh=/fgB/prtT+9RLH2N2jUcU7RYPTvAJNdzfvwKlhf2uGs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n4uo0tkIXihBJA/SKKfXmICFMT1onRMFDghteyFbkMpvQ+MLw3qWaNYlaUqfQxRu3
 b+iAXIiFmn+UDfv5KgnxM6HaJOkRRDET5e5vKu+KqtC/O5yCsu2+Wd01CBuCMcaZuK
 Mrqdn0rF4GNHAYaY0slMJiWUwZuOq+7X8a0I6iDMTZo+wkZM/gQo09H0H+VQbZ78O/
 LDrgGduWiCxlER2mWpLCf/FZLvOD/2lShq7oHXvQZSLmNP5woAWg1ZDd2Wlk0YqE3R
 MJ9fW0/oj1kDTrQyVuv0RLxaL+wh9wqpkiKpUubYkf9Rwyj4p/85aywSwtG+Mb443l
 xXG+bN91/D2Zg==
Date: Thu, 11 Mar 2021 19:17:17 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 34/34] KVM: arm64: Protect the .hyp sections from the
 host
Message-ID: <20210311191716.GD31586@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-35-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-35-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: android-kvm@google.com, catalin.marinas@arm.com, mate.toth-pal@arm.com,
 seanjc@google.com, tabba@google.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On Wed, Mar 10, 2021 at 05:57:51PM +0000, Quentin Perret wrote:
> When KVM runs in nVHE protected mode, use the host stage 2 to unmap the
> hypervisor sections by marking them as owned by the hypervisor itself.
> The long-term goal is to ensure the EL2 code can remain robust
> regardless of the host's state, so this starts by making sure the host
> cannot e.g. write to the .hyp sections directly.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/arm.c                          | 46 +++++++++++++++++++
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  9 ++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 33 +++++++++++++
>  5 files changed, 91 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
