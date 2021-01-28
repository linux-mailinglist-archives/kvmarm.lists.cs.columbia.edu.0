Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E0E17308033
	for <lists+kvmarm@lfdr.de>; Thu, 28 Jan 2021 22:07:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 702B64B284;
	Thu, 28 Jan 2021 16:07:34 -0500 (EST)
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
	with ESMTP id qSglgd6FaT6H; Thu, 28 Jan 2021 16:07:34 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 311F04B276;
	Thu, 28 Jan 2021 16:07:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AC9F4B211
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Jan 2021 16:07:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nntsaU60s9m6 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 28 Jan 2021 16:07:30 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 460DA4B1C9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 28 Jan 2021 16:07:30 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B331E64D9E;
 Thu, 28 Jan 2021 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611868049;
 bh=SV19fbo1HQRwoLMjM7eAFW6z+5oVaEDxb1NIivpX0DY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dIDqslui4PjFNEyYVvmNAYAX+V2GBkg2zm7jNwMGJudnL0UzoO4O+WRyF79TqJ1/f
 QSTw7nV+ymL8jwR81XVLuyjPrfMkOfNqSb7zwiobWSLl3/m5W7wIgJx3HvfsmC6uoX
 iNW+vEvBZKKQiynkYVlsIub7hKEk6ktCNgE4jjJVGDZG5OnKjsuWSoxhtNUC1rysG7
 E4hnzwX/6PNnePImh6q1QKH5ycolB2PPztgQhT1Vwo7DHJVTY53DtSGjIrSREY4sfY
 7HKWSmrm1++Vpx4P96At+/hONggUjY0IthrSOay/dqEGFyEtMNM8dqeahNMtL+DAXv
 4t2+A7bTRH2rA==
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>, catalin.marinas@arm.com,
 maz@kernel.org
Subject: Re: [PATCH] KVM: arm64: Move __hyp_set_vectors out of .hyp.text
Date: Thu, 28 Jan 2021 21:07:20 +0000
Message-Id: <161186447180.2021071.12564835205999648043.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210128173850.2478161-1-qperret@google.com>
References: <20210128173850.2478161-1-qperret@google.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Thu, 28 Jan 2021 17:38:50 +0000, Quentin Perret wrote:
> The .hyp.text section is supposed to be reserved for the nVHE EL2 code.
> However, there is currently one occurrence of EL1 executing code located
> in .hyp.text when calling __hyp_{re}set_vectors(), which happen to sit
> next to the EL2 stub vectors. While not a problem yet, such patterns
> will cause issues when removing the host kernel from the TCB, so a
> cleaner split would be preferable.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] KVM: arm64: Move __hyp_set_vectors out of .hyp.text
      https://git.kernel.org/arm64/c/e30be1455bd3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
