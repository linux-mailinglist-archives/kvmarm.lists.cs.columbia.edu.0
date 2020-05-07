Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7F1C8D14
	for <lists+kvmarm@lfdr.de>; Thu,  7 May 2020 15:55:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 958AD4B33F;
	Thu,  7 May 2020 09:55:57 -0400 (EDT)
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
	with ESMTP id NbUKeADN2PJl; Thu,  7 May 2020 09:55:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C7534B340;
	Thu,  7 May 2020 09:55:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A4ECF4B33D
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 09:55:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kfKftrxkamcg for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 May 2020 09:55:53 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B96344B333
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 09:55:53 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 77EBA2073A;
 Thu,  7 May 2020 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588859752;
 bh=ARBCvtUkWIJnZIUMuqoL/qArHyM8Q20nSwEF8CntUpc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gmbs48eMUoU11HWR9JvfCWurSC63USRCarYWpDYoeXzl2onX/u/zFAZ5KQsnkn4xB
 YP+Z0YTMkL7Il3qFBehFaq6cfYAf4nwiPiz+IUwR8X7yFaQbM90geR0o5Psa+dWGyd
 sBuWFtDgDkLQirhNiX7JtqnVonYc23+hsiUk0aeY=
Date: Thu, 7 May 2020 14:55:48 +0100
From: Will Deacon <will@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v5 4/4] KVM: arm64: Clean up kvm makefiles
Message-ID: <20200507135547.GB32706@willie-the-truck>
References: <20200505154520.194120-1-tabba@google.com>
 <20200505154520.194120-5-tabba@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200505154520.194120-5-tabba@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com
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

On Tue, May 05, 2020 at 04:45:20PM +0100, Fuad Tabba wrote:
> Consolidate references to the CONFIG_KVM configuration item to encompass
> entire folders rather than per line.
> 
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/kvm/Makefile     | 38 +++++++++++++------------------------
>  arch/arm64/kvm/hyp/Makefile | 15 ++++-----------
>  2 files changed, 17 insertions(+), 36 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
