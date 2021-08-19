Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E40D93F1504
	for <lists+kvmarm@lfdr.de>; Thu, 19 Aug 2021 10:19:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6838D4AEE2;
	Thu, 19 Aug 2021 04:19:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qQJvNRN8EgnB; Thu, 19 Aug 2021 04:19:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 687694B111;
	Thu, 19 Aug 2021 04:18:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E6EB4B10D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Aug 2021 04:18:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VwJX2rHwsPpy for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Aug 2021 04:18:56 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 11C764B10C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Aug 2021 04:18:56 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 177B061139;
 Thu, 19 Aug 2021 08:18:55 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mGdGG-005vQx-SX; Thu, 19 Aug 2021 09:18:53 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v2 0/4] KVM: arm64: Fix some races in CPU_ON PSCI call
Date: Thu, 19 Aug 2021 09:18:49 +0100
Message-Id: <162936111407.541676.11774865845630227247.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818202133.1106786-1-oupton@google.com>
References: <20210818202133.1106786-1-oupton@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 oupton@google.com, suzuki.poulose@arm.com, james.morse@arm.com,
 ricarkol@google.com, alexandru.elisei@arm.com, drjones@redhat.com,
 jingzhangos@google.com, rananta@google.com, pshier@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Peter Shier <pshier@google.com>, Raghavendra Rao Anata <rananta@google.com>
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

On Wed, 18 Aug 2021 20:21:29 +0000, Oliver Upton wrote:
> The CPU_ON PSCI call requires careful coordination between vCPUs in KVM,
> as it allows callers to send a payload (pc, context id) to another vCPU
> to start execution. There are a couple of races in the handling of
> CPU_ON:
> 
>  - KVM uses the kvm->lock to serialize the write-side of a vCPU's reset
>    state. However, kvm_vcpu_reset() doesn't take the lock on the
>    read-size, meaning the vCPU could be reset with interleaved state
>    from two separate CPU_ON calls.
> 
> [...]

Applied to next, thanks!

[1/4] KVM: arm64: Fix read-side race on updates to vcpu reset state
      commit: 6654f9dfcb88fea3b9affc180dc3c04333d0f306
[2/4] KVM: arm64: Handle PSCI resets before userspace touches vCPU state
      commit: 6826c6849b46aaa91300201213701eb861af4ba0
[3/4] KVM: arm64: Enforce reserved bits for PSCI target affinities
      commit: e10ecb4d6c0761ca545b3946df1707a41f9f845e
[4/4] selftests: KVM: Introduce psci_cpu_on_test
      commit: cb97cf95c44021278b7637731bc0928026bc29ab

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
