Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3FDF2B4677
	for <lists+kvmarm@lfdr.de>; Mon, 16 Nov 2020 15:57:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D2A24C17F;
	Mon, 16 Nov 2020 09:57:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kV30yDbKOEkQ; Mon, 16 Nov 2020 09:57:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D3CB4C16F;
	Mon, 16 Nov 2020 09:57:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 04D684C164
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 09:57:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M5mGksA5QTcE for <kvmarm@lists.cs.columbia.edu>;
 Mon, 16 Nov 2020 09:57:40 -0500 (EST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D23CD4C15A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 16 Nov 2020 09:57:39 -0500 (EST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZXGy5byCzLlrL;
 Mon, 16 Nov 2020 22:57:14 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 22:57:26 +0800
Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace
 Redistributor accesses
To: Marc Zyngier <maz@kernel.org>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
 <20201113142801.1659-2-yuzenghui@huawei.com>
 <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
 <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
 <cc45285fe491aff5c28a24f94c124508@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7e58200c-814e-3598-155a-9a7e6cc24374@huawei.com>
Date: Mon, 16 Nov 2020 22:57:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cc45285fe491aff5c28a24f94c124508@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

Hi Marc,

On 2020/11/16 22:10, Marc Zyngier wrote:
>> My take is that only if the "[Re]Distributor base address" is specified
>> in the system memory map, will the user-provided kvm_device_attr.offset
>> make sense. And we can then handle the access to the register which is
>> defined by "base address + offset".
> 
> I'd tend to agree, but it is just that this is a large change at -rc4.
> I'd rather have a quick fix for 5.10, and a more invasive change for 5.11,
> spanning all the possible vgic devices.

So you prefer fixing it by "return a value that doesn't have the Last
bit set" for v5.10? I'm ok with it and can send v2 for it.

Btw, looking again at the way we handle the user-reading of GICR_TYPER

	vgic_mmio_read_v3r_typer(vcpu, addr, len)

it seems that @addr is actually the *offset* of GICR_TYPER (0x0008) and
@addr is unlikely to be equal to last_rdist_typer, which is the *GPA* of
the last RD. Looks like the user-reading of GICR_TYPER.Last is always
broken?


Thanks,
Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
