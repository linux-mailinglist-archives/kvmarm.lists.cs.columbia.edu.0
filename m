Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 698907F59E
	for <lists+kvmarm@lfdr.de>; Fri,  2 Aug 2019 13:00:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E23E24A555;
	Fri,  2 Aug 2019 07:00:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXy2o3+++sT9; Fri,  2 Aug 2019 07:00:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BC4274A52F;
	Fri,  2 Aug 2019 07:00:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 98CF64A51E
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Aug 2019 07:00:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PzZnm6rhCmtx for <kvmarm@lists.cs.columbia.edu>;
 Fri,  2 Aug 2019 07:00:07 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 025F74A4E5
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Aug 2019 07:00:06 -0400 (EDT)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0CA50E7A5A43691467DE;
 Fri,  2 Aug 2019 19:00:03 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 18:59:56 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
Subject: kvm-unit-tests: psci_cpu_on_test FAILed
To: Marc Zyngier <maz@kernel.org>, <drjones@redhat.com>, James Morse
 <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
 <suzuki.poulose@arm.com>
Message-ID: <3ddf8766-6f02-b655-1b80-d8a7fd016509@huawei.com>
Date: Fri, 2 Aug 2019 18:56:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi folks,

Running kvm-unit-tests with Linux 5.3.0-rc2 on Kunpeng 920, we will get
the following fail info:

	[...]
	FAIL psci (4 tests, 1 unexpected failures)
	[...]
and
	[...]
	INFO: unexpected cpu_on return value: caller=CPU9, ret=-2
	FAIL: cpu-on
	SUMMARY: 4 tests, 1 unexpected failures


I think this is an issue had been fixed once by commit 6c7a5dce22b3
("KVM: arm/arm64: fix races in kvm_psci_vcpu_on"), which makes use of
kvm->lock mutex to fix the race between two PSCI_CPU_ON calls - one
does reset on the MPIDR register whilst another reads it.

But commit 358b28f09f0 ("arm/arm64: KVM: Allow a VCPU to fully reset
itself") later moves the reset work into check_vcpu_requests(), by
making a KVM_REQ_VCPU_RESET request in PSCI code. Thus the reset work
has not been protected by kvm->lock mutex anymore, and the race shows up
again...

Do we need a fix for this issue? At least achieve a mutex execution
between the reset of MPIDR and kvm_mpidr_to_vcpu()?


Thanks,
zenghui

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
