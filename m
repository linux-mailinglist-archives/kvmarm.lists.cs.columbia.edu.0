Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E0F08436212
	for <lists+kvmarm@lfdr.de>; Thu, 21 Oct 2021 14:47:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 356C84B173;
	Thu, 21 Oct 2021 08:47:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ukRT6t4uwbBR; Thu, 21 Oct 2021 08:47:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D4CA94B16E;
	Thu, 21 Oct 2021 08:47:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 88EA34B165
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Oct 2021 08:47:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNIS+WU2-yy7 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 Oct 2021 08:47:35 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8823C4B128
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Oct 2021 08:47:35 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8B66760F56;
 Thu, 21 Oct 2021 12:47:34 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mdXTo-000hRj-AN; Thu, 21 Oct 2021 13:47:32 +0100
From: Marc Zyngier <maz@kernel.org>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v2 0/2] KVM: selftests: enable the memslot tests in ARM64
Date: Thu, 21 Oct 2021 13:47:28 +0100
Message-Id: <163482044194.2203130.6587124513364503568.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907180957.609966-1-ricarkol@google.com>
References: <20210907180957.609966-1-ricarkol@google.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 ricarkol@google.com, jingzhangos@google.com, maciej.szmigiero@oracle.com,
 reijiw@google.com, oupton@google.com, drjones@redhat.com, pbonzini@redhat.com,
 pshier@google.com, rananta@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: pshier@google.com, Paolo Bonzini <pbonzini@redhat.com>,
 maciej.szmigiero@oracle.com
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

On Tue, 7 Sep 2021 11:09:55 -0700, Ricardo Koller wrote:
> Enable memslot_modification_stress_test and memslot_perf_test in ARM64
> (second patch). memslot_modification_stress_test builds and runs in
> aarch64 without any modification. memslot_perf_test needs some nits
> regarding ucalls (first patch).
> 
> Can anybody try these two tests in s390, please?
> 
> [...]

Applied to next, thanks!

[1/2] KVM: selftests: make memslot_perf_test arch independent
      commit: ffb4ce3c49366f02f1c064fbe2e66a96ab5f98b8
[2/2] KVM: selftests: build the memslot tests for arm64
      commit: 358928fd5264f069b9758f8b29297c7bff2a06de

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
