Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E16A610DCE7
	for <lists+kvmarm@lfdr.de>; Sat, 30 Nov 2019 08:20:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CCAF4A946;
	Sat, 30 Nov 2019 02:20:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ys-aQqdFk0IM; Sat, 30 Nov 2019 02:20:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6899E4AEB3;
	Sat, 30 Nov 2019 02:20:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AC8514AC88
 for <kvmarm@lists.cs.columbia.edu>; Sat, 30 Nov 2019 02:20:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id okOUYd3jhmNq for <kvmarm@lists.cs.columbia.edu>;
 Sat, 30 Nov 2019 02:20:34 -0500 (EST)
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9D2F24AC7A
 for <kvmarm@lists.cs.columbia.edu>; Sat, 30 Nov 2019 02:20:34 -0500 (EST)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 314F03BD4D38557D7AB9;
 Sat, 30 Nov 2019 15:20:25 +0800 (CST)
Received: from dggeme713-chm.china.huawei.com (10.1.199.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 30 Nov 2019 15:20:24 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme713-chm.china.huawei.com (10.1.199.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 30 Nov 2019 15:20:24 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Sat, 30 Nov 2019 15:20:24 +0800
From: linmiaohe <linmiaohe@huawei.com>
To: "maz@kernel.org" <maz@kernel.org>, "james.morse@arm.com"
 <james.morse@arm.com>, "julien.thierry.kdev@gmail.com"
 <julien.thierry.kdev@gmail.com>, "suzuki.poulose@arm.com"
 <suzuki.poulose@arm.com>, "christoffer.dall@arm.com"
 <christoffer.dall@arm.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "will@kernel.org"
 <will@kernel.org>, "andre.przywara@arm.com" <andre.przywara@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH] KVM: arm: get rid of unused arg in cpu_init_hyp_mode()
Thread-Topic: [PATCH] KVM: arm: get rid of unused arg in cpu_init_hyp_mode()
Thread-Index: AdWnTmGujmIRIVH4Q4a12QHyDyOpdA==
Date: Sat, 30 Nov 2019 07:20:24 +0000
Message-ID: <8efe4ab7f8c44c48a70378247c511edc@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

>From: Miaohe Lin <linmiaohe@huawei.com>
>
>As arg dummy is not really needed, there's no need to pass NULL when calling cpu_init_hyp_mode(). So clean it up.
>
>Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>---
> virt/kvm/arm/arm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c index 86c6aa1cb58e..a5470f1b1a19 100644
>--- a/virt/kvm/arm/arm.c
>+++ b/virt/kvm/arm/arm.c
>@@ -1315,7 +1315,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
> 	}
> }
>
>-static void cpu_init_hyp_mode(void *dummy)
>+static void cpu_init_hyp_mode(void)
> {
> 	phys_addr_t pgd_ptr;
> 	unsigned long hyp_stack_ptr;
>@@ -1349,7 +1349,7 @@ static void cpu_hyp_reinit(void)
> 	if (is_kernel_in_hyp_mode())
> 		kvm_timer_init_vhe();
> 	else
>-		cpu_init_hyp_mode(NULL);
>+		cpu_init_hyp_mode();
> 
> 	kvm_arm_init_debug();
> 
friendly ping ...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
