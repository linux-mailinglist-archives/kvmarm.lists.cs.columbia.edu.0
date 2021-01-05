Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9572EABCC
	for <lists+kvmarm@lfdr.de>; Tue,  5 Jan 2021 14:23:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E76BA4B318;
	Tue,  5 Jan 2021 08:23:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wQfmWZCs7A8i; Tue,  5 Jan 2021 08:23:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EDB734B313;
	Tue,  5 Jan 2021 08:23:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C58744B310
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 08:23:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmpTLlHHBTC2 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Jan 2021 08:23:34 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A423E4B30F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 08:23:34 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8EE98225AC;
 Tue,  5 Jan 2021 13:23:33 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kwmJ9-005R6C-Aj; Tue, 05 Jan 2021 13:23:31 +0000
From: Marc Zyngier <maz@kernel.org>
To: will@kernel.org, anshuman.khandual@arm.com, suzuki.poulose@arm.com,
 kvmarm@lists.cs.columbia.edu, Shannon Zhao <shannon.zhao@linux.alibaba.com>
Subject: Re: [PATCH] arm64: cpufeature: remove non-exist CONFIG_KVM_ARM_HOST
Date: Tue,  5 Jan 2021 13:23:27 +0000
Message-Id: <160985299725.2026437.9262118876346385901.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1609760324-92271-1-git-send-email-shannon.zhao@linux.alibaba.com>
References: <1609760324-92271-1-git-send-email-shannon.zhao@linux.alibaba.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, anshuman.khandual@arm.com,
 suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
 shannon.zhao@linux.alibaba.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-arm-kernel@lists.infradead.org
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

On Mon, 4 Jan 2021 19:38:44 +0800, Shannon Zhao wrote:
> Commit d82755b2e781 ("KVM: arm64: Kill off CONFIG_KVM_ARM_HOST") deletes
> CONFIG_KVM_ARM_HOST option, it should use CONFIG_KVM instead.
> 
> Just remove CONFIG_KVM_ARM_HOST here.

Applied to next, thanks!

[1/1] arm64: cpufeature: remove non-exist CONFIG_KVM_ARM_HOST
      commit: 45ba7b195a369f35cb39094fdb32efe5908b34ad

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
