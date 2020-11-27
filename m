Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA72C6BC5
	for <lists+kvmarm@lfdr.de>; Fri, 27 Nov 2020 20:00:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 46DB44BD31;
	Fri, 27 Nov 2020 14:00:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I137TilDhfct; Fri, 27 Nov 2020 14:00:44 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 26F434BD2F;
	Fri, 27 Nov 2020 14:00:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A6764BD26
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Nov 2020 14:00:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2xUj16Yj9cK for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Nov 2020 14:00:40 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A82884BD29
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Nov 2020 14:00:40 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6781B21D7A;
 Fri, 27 Nov 2020 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606503639;
 bh=FNLaWuYw7sBx8IHLpM8id0DbitNOBC0M4TrCunOEzVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LsIdChUL8uT05mPeLUTBF8zOB6D2QvN8aNb9mtNHBEfr+veU1HzxcnuyO0TSAFARG
 z9tF9VDM5kgKxVLg5GVNL9DT5GSG5aWlW1E6JBCzvOeoqhCIDp/v/Z5TJaSaG+y27n
 ICTYgA7K4OonVMOvWCIz7GqTOYRt7QglYqs/av8A=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kiiyz-00E8hD-6P; Fri, 27 Nov 2020 19:00:37 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>,
	kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 0/3] KVM: arm64: Boring cosmetic patches
Date: Fri, 27 Nov 2020 19:00:33 +0000
Message-Id: <160650361523.5613.499561259838965353.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118194402.2892-1-will@kernel.org>
References: <20201118194402.2892-1-will@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, kvmarm@lists.cs.columbia.edu,
 catalin.marinas@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, kernel-team@android.com
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

On Wed, 18 Nov 2020 19:43:59 +0000, Will Deacon wrote:
> Here are some desperately dull patches I cooked while working on pkvm
> enablement. The latter isn't ready yet, but figured there wasn't much
> point me sitting on these. Although they're boring, the first patch does
> touch uapi/ so it's not completely trivial.
> 
> Cheers,
> 
> [...]

Applied to kvm-arm64/misc-5.11, thanks!

[1/3] KVM: arm64: Move 'struct kvm_arch_memory_slot' out of uapi/
      commit: 8d14797b53f044fda3ed42b5b6357c7622b8af58
[2/3] KVM: arm64: Remove kvm_arch_vm_ioctl_check_extension()
      commit: 36fb4cd55f626dff0f6e76bed14707fa00147b7f
[3/3] KVM: arm64: Remove unused __extended_idmap_trampoline() prototype
      commit: bf118a5cb7e6d17e7ec9492e4dc676e7e7b69d01

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
