Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 052BD30DEC7
	for <lists+kvmarm@lfdr.de>; Wed,  3 Feb 2021 16:55:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C7564B2A3;
	Wed,  3 Feb 2021 10:55:01 -0500 (EST)
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
	with ESMTP id 2-MTY3Mm4yCQ; Wed,  3 Feb 2021 10:55:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F37A4B286;
	Wed,  3 Feb 2021 10:55:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E9F74B255
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 10:54:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jNibLjf8OlNR for <kvmarm@lists.cs.columbia.edu>;
 Wed,  3 Feb 2021 10:54:57 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8F2AE4B222
 for <kvmarm@lists.cs.columbia.edu>; Wed,  3 Feb 2021 10:54:57 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 869C864F5D;
 Wed,  3 Feb 2021 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612367696;
 bh=0tzbGa7brGsNplQvhjfRaT8HNbr8dBf5jGW+q18QilI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tNUyz+DjH/CsemTHfyE2WSJE+eJF1poA9n+9wSxhXQY+OFFoupu0EG08WSs7jBMxu
 zqVAme/SKvOmhtWQEyCaxE4bvDnhM6w9YioSV3fxxMqLm1ivyYIXLorunEQEZ8JQ4a
 L2YDYGm22GqyVYxFdlBI3lWGnr+ZaCqOwkfGs/KMu2EckoiPv7BNZu6gvVkcm24w3A
 qbG3jzGrbroCrHheg9cSQcQi8KN9urnDOcMS3IzLnQKEmWUo9H0yXnJjX5AsbyIWSI
 O8acyg89I/lswmaVlw9ZELJqjwVbb7eNwd4bGktqh5M7wgH5wHpwRB3XnX/GP8xBTN
 XyH2LemCf0jaA==
Date: Wed, 3 Feb 2021 15:54:50 +0000
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH v2 22/26] KVM: arm64: Refactor __load_guest_stage2()
Message-ID: <20210203155449.GF18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-23-qperret@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-23-qperret@google.com>
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

On Fri, Jan 08, 2021 at 12:15:20PM +0000, Quentin Perret wrote:
> Refactor __load_guest_stage2() to introduce __load_stage2() which will
> be re-used when loading the host stage 2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
