Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 42FC829F6A3
	for <lists+kvmarm@lfdr.de>; Thu, 29 Oct 2020 22:09:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B4C894B69F;
	Thu, 29 Oct 2020 17:09:32 -0400 (EDT)
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
	with ESMTP id dmVa0VEWA3Vd; Thu, 29 Oct 2020 17:09:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 48FD84B696;
	Thu, 29 Oct 2020 17:09:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 15D014B4A4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Oct 2020 17:09:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RNveSonR-0YR for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Oct 2020 17:09:28 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D14D94B685
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Oct 2020 17:09:28 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A716020809;
 Thu, 29 Oct 2020 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604005767;
 bh=lf0t0UJFCGB050lo14Z4j7zqhqTTfq2T0veFSPfejV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0lDMhNNTgQFcZhgAYW5AM6t/DcWAhW4A22KnY6O9/botf+3Vqvm0vGApHfmO+y0Gn
 pKfoK1CS5a9mn/a6B/8f5RVk3iDsXMgpeq47gfN1Py3EFMimiQjdkkbMKkJl+ugexQ
 6BUeqzcOFpc2cvJfZ5xQyp6S0ikMUQe1uB7OF3IM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=wait-a-minute.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kYFAj-005YNy-QP; Thu, 29 Oct 2020 21:09:25 +0000
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, Gavin Shan <gshan@redhat.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Allocate stage-2 pgd pages with
 GFP_KERNEL_ACCOUNT
Date: Thu, 29 Oct 2020 21:09:17 +0000
Message-Id: <160400571841.9348.8004046679555935823.b4-ty@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026144423.24683-1-will@kernel.org>
References: <20201026144423.24683-1-will@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, gshan@redhat.com,
 will@kernel.org, shan.gavin@gmail.com, linux-kernel@vger.kernel.org,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, shan.gavin@gmail.com
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

On Mon, 26 Oct 2020 14:44:23 +0000, Will Deacon wrote:
> For consistency with the rest of the stage-2 page-table page allocations
> (performing using a kvm_mmu_memory_cache), ensure that __GFP_ACCOUNT is
> included in the GFP flags for the PGD pages.

Applied to next, thanks!

[1/1] KVM: arm64: Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT
      commit: 7efe8ef274024ef1d5c495c79dfcbbff38c5f366

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
