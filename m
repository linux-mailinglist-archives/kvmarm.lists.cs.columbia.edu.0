Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1E338064C
	for <lists+kvmarm@lfdr.de>; Fri, 14 May 2021 11:33:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA4384B795;
	Fri, 14 May 2021 05:33:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pu0epo9nwC-O; Fri, 14 May 2021 05:33:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8161A4B5DF;
	Fri, 14 May 2021 05:33:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 003224B399
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 May 2021 05:33:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dp8xR8l9eu20 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 May 2021 05:33:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 45EA24B2FB
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 May 2021 05:33:39 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5650D61407;
 Fri, 14 May 2021 09:33:38 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lhUCO-001ML2-7Z; Fri, 14 May 2021 10:33:36 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu,
	Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 0/2] KVM: arm64: Mark a couple of variables static
Date: Fri, 14 May 2021 10:33:33 +0100
Message-Id: <162098480497.2617215.5479779823421190391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210514085640.3917886-1-qperret@google.com>
References: <20210514085640.3917886-1-qperret@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, qperret@google.com,
 will@kernel.org, kbuild-all@lists.01.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kbuild-all@lists.01.org, will@kernel.org
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

On Fri, 14 May 2021 08:56:38 +0000, Quentin Perret wrote:
> The kernel test bot is complaining (and rightfully so) about variables
> introduced by the host stage-2 series that should be static. This series
> fixes all of them.
> 
> Thanks!
> 
> Quentin Perret (2):
>   KVM: arm64: Mark pkvm_pgtable_mm_ops static
>   KVM: arm64: Mark the host stage-2 memory pools static
> 
> [...]

Applied to fixes, thanks!

[1/2] KVM: arm64: Mark pkvm_pgtable_mm_ops static
      commit: 8030d45936f2c526ace7b8404c8272239289b5b7
[2/2] KVM: arm64: Mark the host stage-2 memory pools static
      commit: 72799c362520f37abd929799190350e466890336

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
