Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6E51C343F9C
	for <lists+kvmarm@lfdr.de>; Mon, 22 Mar 2021 12:25:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9B3F4B411;
	Mon, 22 Mar 2021 07:25:00 -0400 (EDT)
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
	with ESMTP id IuWwKaRajH2p; Mon, 22 Mar 2021 07:25:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B74024B41A;
	Mon, 22 Mar 2021 07:24:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E1E34B3CD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 07:24:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LgRW6-fEPkA3 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Mar 2021 07:24:57 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6F5414B3C2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Mar 2021 07:24:57 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 971096191F;
 Mon, 22 Mar 2021 11:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616412295;
 bh=ZLi6Bd3+v6SEZ7BojqeGDRUBPIM44t1xQ82RsA0FR9E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X1/XGgKUEwjQp5cnpZHom0FOv2Wv5aaJYB7D+9Rw0EKC2/dvDBwEJcrxiYyR97pDU
 eYn/PT/+WCDlABZbe8MpPobHdtfpAF8TYkAGpcCR8OJweh0kThjbcjPdgqZ6+yp8C6
 bafuJ8IHT1lZ6KsjCHAipLHctHG91NWEMOK8h3E/xmoUC2T8/t23/Ft5yM0t7K6xqQ
 w5HhDuSR+/J9+l+Cn/QyRCrEd5qWcl181B1HdL4IPUQExefVoxRsXpztnn9/sAgvRB
 c624LvFnWaco433jFHovHRbtT6LhTK8h7dp+zoHh6jnJnEt3YrnzRqMTAE+uTqgHJM
 2/yrTOk8JW+ZQ==
Date: Mon, 22 Mar 2021 11:24:49 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v6 13/38] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <20210322112448.GA10318@willie-the-truck>
References: <20210319100146.1149909-1-qperret@google.com>
 <20210319100146.1149909-14-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319100146.1149909-14-qperret@google.com>
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

On Fri, Mar 19, 2021 at 10:01:21AM +0000, Quentin Perret wrote:
> Introduce the infrastructure in KVM enabling to copy CPU feature
> registers into EL2-owned data-structures, to allow reading sanitised
> values directly at EL2 in nVHE.
> 
> Given that only a subset of these features are being read by the
> hypervisor, the ones that need to be copied are to be listed under
> <asm/kvm_cpufeature.h> together with the name of the nVHE variable that
> will hold the copy. This introduces only the infrastructure enabling
> this copy. The first users will follow shortly.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/cpufeature.h     |  1 +
>  arch/arm64/include/asm/kvm_cpufeature.h | 22 ++++++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h       |  4 ++++
>  arch/arm64/kernel/cpufeature.c          | 13 +++++++++++++
>  arch/arm64/kvm/sys_regs.c               | 19 +++++++++++++++++++
>  5 files changed, 59 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
