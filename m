Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75ABCB20
	for <lists+kvmarm@lfdr.de>; Tue, 24 Sep 2019 17:22:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7DFA34A672;
	Tue, 24 Sep 2019 11:22:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00iPTyWlxP3R; Tue, 24 Sep 2019 11:22:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 681DD4A66C;
	Tue, 24 Sep 2019 11:22:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ED4614A5A3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Sep 2019 11:22:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RxiF5xwTk62R for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Sep 2019 11:22:24 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 887CE4A57B
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Sep 2019 11:22:23 -0400 (EDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 19DE9F71006A9E2A596B;
 Tue, 24 Sep 2019 23:22:19 +0800 (CST)
Received: from linux-Bxxcye.huawei.com (10.175.104.222) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 24 Sep 2019 23:22:09 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <qemu-arm@nongnu.org>
Subject: [RFC PATCH 0/2] Add virtual SDEI support for arm64
Date: Tue, 24 Sep 2019 23:20:52 +0800
Message-ID: <1569338454-26202-1-git-send-email-guoheyi@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.104.222]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <marc.zyngier@arm.com>, Heyi Guo <guoheyi@huawei.com>,
 Dave Martin <Dave.Martin@arm.com>
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

As promised, this is the first RFC patch set for arm64 virtual SDEI
support.

New kvm capability KVM_CAP_FORWARD_HYPERCALL is added to probe if kvm
supports forwarding hypercalls, and the capability should be enabled
explicitly. PSCI can be set as exception for backward compatibility.

We reuse the existing term "hypercall" for SMC/HVC, as well as the
hypercall structure in kvm_run to exchange arguments and return
values. The definition on arm64 is as below:

exit_reason: KVM_EXIT_HYPERCALL

Input:
  nr: the immediate value of SMC/HVC calls; not really used today.
  args[6]: x0..x5 (This is not fully conform with SMCCC which requires
           x6 as argument as well, but use space can use GET_ONE_REG
           ioctl for such rare case).

Return:
  args[0..3]: x0..x3 as defined in SMCCC. We need to extract
              args[0..3] and write them to x0..x3 when hypercall exit
              returns.

And there is a corresponding patch set for qemu.

Please give your comments and suggestions.

Thanks,
HG

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>

Heyi Guo (2):
  kvm/arm: add capability to forward hypercall to user space
  kvm/arm64: expose hypercall_forwarding capability

 arch/arm/include/asm/kvm_host.h   |  5 +++++
 arch/arm64/include/asm/kvm_host.h |  5 +++++
 arch/arm64/kvm/reset.c            | 25 +++++++++++++++++++++++++
 include/kvm/arm_psci.h            |  1 +
 include/uapi/linux/kvm.h          |  3 +++
 virt/kvm/arm/arm.c                |  2 ++
 virt/kvm/arm/psci.c               | 30 ++++++++++++++++++++++++++++--
 7 files changed, 69 insertions(+), 2 deletions(-)

-- 
1.8.3.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
