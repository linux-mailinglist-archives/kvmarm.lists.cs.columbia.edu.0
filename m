Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AF80CF42FD
	for <lists+kvmarm@lfdr.de>; Fri,  8 Nov 2019 10:20:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B9954AEC8;
	Fri,  8 Nov 2019 04:20:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7WHgItPAGraO; Fri,  8 Nov 2019 04:20:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 066724AECC;
	Fri,  8 Nov 2019 04:20:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E80284ACBE
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Nov 2019 04:20:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3pGU573Gz1SH for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Nov 2019 04:20:31 -0500 (EST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E962F4AEBE
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Nov 2019 04:20:30 -0500 (EST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 09EA77BC64AC8CBF97B3;
 Fri,  8 Nov 2019 17:20:25 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 8 Nov 2019
 17:20:15 +0800
Subject: Re: [PATCH 2/2] KVM: arm64: Opportunistically turn off WFI trapping
 when using direct LPI injection
To: Marc Zyngier <maz@kernel.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, <linux-arm-kernel@lists.infradead.org>
References: <20191107160412.30301-1-maz@kernel.org>
 <20191107160412.30301-3-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <3ca03337-2a10-4958-c551-721461dc0082@huawei.com>
Date: Fri, 8 Nov 2019 17:20:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20191107160412.30301-3-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
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

On 2019/11/8 0:04, Marc Zyngier wrote:
> Just like we do for WFE trapping, it can be useful to turn off
> WFI trapping when the physical CPU is not oversubscribed (that
> is, the vcpu is the only runnable process on this CPU) *and*
> that we're using direct injection of interrupts.
> 
> The conditions are reevaluated on each vcpu_load(), ensuring that
> we don't switch to this mode on a busy system.
> 
> On a GICv4 system, this has the effect of reducing the generation
> of doorbell interrupts to zero when the right conditions are
> met, which is a huge improvement over the current situation
> (where the doorbells are screaming if the CPU ever hits a
> blocking WFI).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
