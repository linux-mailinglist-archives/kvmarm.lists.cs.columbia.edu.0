Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 20F5D3AFE81
	for <lists+kvmarm@lfdr.de>; Tue, 22 Jun 2021 09:57:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A3283407F4;
	Tue, 22 Jun 2021 03:57:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QYmr0eDdnyIu; Tue, 22 Jun 2021 03:57:57 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7AE49407B0;
	Tue, 22 Jun 2021 03:57:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6787140413
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Jun 2021 03:57:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LefZf0yAXang for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Jun 2021 03:57:54 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 40961402BD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Jun 2021 03:57:54 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 348B560234;
 Tue, 22 Jun 2021 07:57:53 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lvbI6-0092om-8b; Tue, 22 Jun 2021 08:57:50 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
 kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v3 0/5] KVM: arm64: selftests: Fix get-reg-list
Date: Tue, 22 Jun 2021 08:57:43 +0100
Message-Id: <162434848561.3797427.13959402137362865018.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531103344.29325-1-drjones@redhat.com>
References: <20210531103344.29325-1-drjones@redhat.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvm@vger.kernel.org, drjones@redhat.com,
 kvmarm@lists.cs.columbia.edu, ricarkol@google.com, alexandru.elisei@arm.com,
 pbonzini@redhat.com, eric.auger@redhat.com
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

On Mon, 31 May 2021 12:33:39 +0200, Andrew Jones wrote:
> v3:
>  - Took Ricardo's suggestions in order to avoid needing to update
>    prepare_vcpu_init, finalize_vcpu, and check_supported when adding
>    new register sublists by better associating the sublists with their
>    vcpu feature bits and caps [Ricardo]
>  - We now dynamically generate the vcpu config name by creating them
>    from its sublist names [drew]
> 
> [...]

Applied to next, thanks!

[1/5] KVM: arm64: selftests: get-reg-list: Introduce vcpu configs
      commit: 2f9ace5d4557f8ceea07969d6214c320f5e50c0c
[2/5] KVM: arm64: selftests: get-reg-list: Prepare to run multiple configs at once
      commit: 94e9223c06bece9165a36f0f56bac3552a45cbfc
[3/5] KVM: arm64: selftests: get-reg-list: Provide config selection option
      commit: f3032fcc9cf065733ce9a50057aaeffd6c464e2e
[4/5] KVM: arm64: selftests: get-reg-list: Remove get-reg-list-sve
      commit: 32edd2290889d0cd0751dd11853e5a368188066d
[5/5] KVM: arm64: selftests: get-reg-list: Split base and pmu registers
      commit: 313673bad871750c0c829def53d037868af75b67

I have also queued an additional patch adding the arm64 selftests
to the list of KVM/arm64 files:

https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?h=next&id=b356a831088730a3ef36848cd9f2d62dcac392bf

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
