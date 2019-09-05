Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 32D25A980C
	for <lists+kvmarm@lfdr.de>; Thu,  5 Sep 2019 03:35:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B8FB4A59B;
	Wed,  4 Sep 2019 21:35:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FMpL8bIR0mDU; Wed,  4 Sep 2019 21:35:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D6EF4A579;
	Wed,  4 Sep 2019 21:35:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C8284A557
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Sep 2019 21:35:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id emV27Y+wVXTY for <kvmarm@lists.cs.columbia.edu>;
 Wed,  4 Sep 2019 21:35:33 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0C4A34A551
 for <kvmarm@lists.cs.columbia.edu>; Wed,  4 Sep 2019 21:35:32 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9A3CA77198259E426104;
 Thu,  5 Sep 2019 09:35:29 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 09:35:18 +0800
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Marc Zyngier
 <marc.zyngier@arm.com>
References: <20190904180736.29009-1-xypron.glpk@gmx.de>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <31537407-882d-f554-fbe6-0e8e611683d5@huawei.com>
Date: Thu, 5 Sep 2019 09:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190904180736.29009-1-xypron.glpk@gmx.de>
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Cc: "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>,
 linux-kernel@vger.kernel.org, Stefan
 Hajnoczi <stefanha@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

That's interesting; we also met this issue yesterday :)

HG


On 2019/9/5 2:07, Heinrich Schuchardt wrote:
> If an application tries to access memory that is not mapped, an error
> ENOSYS, "load/store instruction decoding not implemented" may occur.
> QEMU will hang with a register dump.
>
> Instead create a data abort that can be handled gracefully by the
> application running in the virtual environment.
>
> Now the virtual machine can react to the event in the most appropriate
> way - by recovering, by writing an informative log, or by rebooting.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   virt/kvm/arm/mmio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/arm/mmio.c b/virt/kvm/arm/mmio.c
> index a8a6a0c883f1..0cbed7d6a0f4 100644
> --- a/virt/kvm/arm/mmio.c
> +++ b/virt/kvm/arm/mmio.c
> @@ -161,8 +161,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
>   		if (ret)
>   			return ret;
>   	} else {
> -		kvm_err("load/store instruction decoding not implemented\n");
> -		return -ENOSYS;
> +		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> +		return 1;
>   	}
>
>   	rt = vcpu->arch.mmio_decode.rt;
> --
> 2.23.0.rc1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
