Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8F333519EC5
	for <lists+kvmarm@lfdr.de>; Wed,  4 May 2022 14:01:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B5E4D4B12C;
	Wed,  4 May 2022 08:01:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2uSaRrTi-nfZ; Wed,  4 May 2022 08:01:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 85B904B11F;
	Wed,  4 May 2022 08:01:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 380A34B11A
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 May 2022 08:01:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5+d9zKcCsPK8 for <kvmarm@lists.cs.columbia.edu>;
 Wed,  4 May 2022 08:01:31 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 119E24B105
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 May 2022 08:01:30 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6BE6BB82330;
 Wed,  4 May 2022 12:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2829BC385A5;
 Wed,  4 May 2022 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651665688;
 bh=f+/lmLtGAEtADfizlaMSjFSBhGJliHAhJYnmVX/pwXI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IoENOsL2mNLTOvyCkNM0si/i5sXPPGtRTJzbw0oIRX58ddWU90O6JoYd+AaNb4EVe
 I0wRicuh/Gw47OZL2KyiBE0OPt4HItd+2iK4c0dfkblPA9mVOhglQKNPxwNbqCWD/T
 av5peQdL/Zc6aliMzmOyaJKdNmFdeveBduCk9KEP/Gg8fCFHjFUIzV4OnhtkAZowCk
 q6YBnl7qwCBvtTUSXJz4b75P5XDuWXJXuSdL2vw5RNsWCkl7YupBpwvfCxB7FktrZa
 03PqNaJiujRVIDo1DslR2WPyYJEhzOnCtHIHQrkpH6LQ9KmLgLC4N2pHYrElfFQgr3
 2A6paoxzxrD+g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nmDh7-008tMB-Ic; Wed, 04 May 2022 13:01:25 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>,
 Raghavendra Rao Ananta <rananta@google.com>,
 James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v7 0/9] KVM: arm64: Add support for hypercall services
 selection
Date: Wed,  4 May 2022 13:01:23 +0100
Message-Id: <165166565256.3774994.4350940683684541291.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220502233853.1233742-1-rananta@google.com>
References: <20220502233853.1233742-1-rananta@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: drjones@redhat.com, rananta@google.com, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, will@kernel.org, pbonzini@redhat.com,
 pshier@google.com, catalin.marinas@arm.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
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

On Mon, 2 May 2022 23:38:44 +0000, Raghavendra Rao Ananta wrote:
> Continuing the discussion from [1], the series tries to add support
> for the userspace to elect the hypercall services that it wishes
> to expose to the guest, rather than the guest discovering them
> unconditionally. The idea employed by the series was taken from
> [1] as suggested by Marc Z.
> 
> In a broad sense, the concept is similar to the current implementation
> of PSCI interface- create a 'firmware psuedo-register' to handle the
> firmware revisions. The series extends this idea to all the other
> hypercalls such as TRNG (True Random Number Generator), PV_TIME
> (Paravirtualized Time), and PTP (Precision Time protocol).
> 
> [...]

Applied to next, thanks!

[1/9] KVM: arm64: Factor out firmware register handling from psci.c
      commit: 85fbe08e4da862dc64fc10071c4a03e51b6361d0
[2/9] KVM: arm64: Setup a framework for hypercall bitmap firmware registers
      commit: 05714cab7d63b189894235cf310fae7d6ffc2e9b
[3/9] KVM: arm64: Add standard hypervisor firmware register
      commit: 428fd6788d4d0e0d390de9fb4486be3c1187310d
[4/9] KVM: arm64: Add vendor hypervisor firmware register
      commit: b22216e1a617ca55b41337cd1e057ebc784a65d4
[5/9] Docs: KVM: Rename psci.rst to hypercalls.rst
      commit: f1ced23a9be5727c6f4cac0e2262c5411038952f
[6/9] Docs: KVM: Add doc for the bitmap firmware registers
      commit: fa246c68a04d46c7af6953b47dba7e16d24efbe2
[7/9] tools: Import ARM SMCCC definitions
      commit: ea733263949646700977feeb662a92703f514351
[8/9] selftests: KVM: aarch64: Introduce hypercall ABI test
      commit: 5ca24697d54027c1c94c94a5b920a75448108ed0
[9/9] selftests: KVM: aarch64: Add the bitmap firmware registers to get-reg-list
      commit: 920f4a55fdaa6f68b31c50cca6e51fecac5857a0

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
