Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8244B25681
	for <lists+kvmarm@lfdr.de>; Tue, 21 May 2019 19:21:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DFFF94A526;
	Tue, 21 May 2019 13:21:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZJcvMkXgehU; Tue, 21 May 2019 13:21:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98EDA4A513;
	Tue, 21 May 2019 13:21:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A58154A50C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 May 2019 13:21:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04XAxlw5mnSk for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 May 2019 13:21:53 -0400 (EDT)
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B7594A47A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 May 2019 13:21:53 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B619F15A2;
 Tue, 21 May 2019 10:21:52 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4BC3F718;
 Tue, 21 May 2019 10:21:50 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
Subject: [PATCH v5 0/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Date: Tue, 21 May 2019 18:21:36 +0100
Message-Id: <20190521172139.21277-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Cc: ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, Julien Grall <julien.grall@arm.com>, Dave.Martin@arm.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi all,

This patch series keeps softirqs enabled while touching FPSIMD/SVE state.
For more details on the impact see patch #3.

This patch series has been benchmarked on Linux 5.1-rc4 with defconfig.

On Juno2:
    * hackbench 100 process 1000 (10 times)
    * .7% quicker

On ThunderX 2:
    * hackbench 1000 process 1000 (20 times)
    * 3.4% quicker

Note that while the benchmark has been done on 5.1-rc4, the patch series is
based on 5.2-rc1.

Cheers,

Julien Grall (3):
  arm64/fpsimd: Remove the prototype for sve_flush_cpu_state()
  arch/arm64: fpsimd: Introduce fpsimd_save_and_flush_cpu_state() and
    use it
  arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state

 arch/arm64/include/asm/fpsimd.h |   5 +-
 arch/arm64/include/asm/simd.h   |  10 +--
 arch/arm64/kernel/fpsimd.c      | 139 +++++++++++++++++++++++++++-------------
 arch/arm64/kvm/fpsimd.c         |   4 +-
 4 files changed, 103 insertions(+), 55 deletions(-)

-- 
2.11.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
