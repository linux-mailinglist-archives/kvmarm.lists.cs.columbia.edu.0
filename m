Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2253C834D
	for <lists+kvmarm@lfdr.de>; Wed, 14 Jul 2021 12:56:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E31244B08B;
	Wed, 14 Jul 2021 06:56:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id si96mOAy2SvM; Wed, 14 Jul 2021 06:56:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BE7C54AC78;
	Wed, 14 Jul 2021 06:56:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 18B40407F4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Jul 2021 06:56:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fWSbNVp1UeaA for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Jul 2021 06:56:46 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 240994A4A4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Jul 2021 06:56:46 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2946761363;
 Wed, 14 Jul 2021 10:56:45 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1m3cZH-00DGup-2m; Wed, 14 Jul 2021 11:56:43 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, Andrew Jones <drjones@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: selftests: a couple fixes
Date: Wed, 14 Jul 2021 11:56:38 +0100
Message-Id: <162626019253.574894.16521023581512885892.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713203742.29680-1-drjones@redhat.com>
References: <20210713203742.29680-1-drjones@redhat.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, drjones@redhat.com,
 kvm@vger.kernel.org, pbonzini@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: pbonzini@redhat.com
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

On Tue, 13 Jul 2021 22:37:40 +0200, Andrew Jones wrote:
> The first removes a compiler warning. The second does what a 6 patch
> patch series wanted to do, but apparently got too distracted with
> the preparation refactoring to actually do...
> 
> Andrew Jones (2):
>   KVM: selftests: change pthread_yield to sched_yield
>   KVM: arm64: selftests: get-reg-list: actually enable pmu regs in pmu
>     sublist
> 
> [...]

Applied to fixes, thanks!

[1/2] KVM: selftests: change pthread_yield to sched_yield
      commit: bac0b135907855e9f8c032877c3df3c60885a08f
[2/2] KVM: arm64: selftests: get-reg-list: actually enable pmu regs in pmu sublist
      commit: 5cf17746b302aa32a4f200cc6ce38865bfe4cf94

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
