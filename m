Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD330455E
	for <lists+kvmarm@lfdr.de>; Tue, 26 Jan 2021 18:33:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5043D4B360;
	Tue, 26 Jan 2021 12:33:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R-vj5Uym16z2; Tue, 26 Jan 2021 12:33:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B0024B362;
	Tue, 26 Jan 2021 12:33:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 87C174B35E
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Jan 2021 12:33:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RgpsrcBfVRbz for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 Jan 2021 12:33:01 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 366874B35D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 Jan 2021 12:33:01 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5A731B;
 Tue, 26 Jan 2021 09:33:00 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA6983F66E;
 Tue, 26 Jan 2021 09:32:58 -0800 (PST)
Subject: Re: [PATCH v2 1/7] KVM: arm64: Fix missing RES1 in emulation of
 DBGBIDR
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
References: <20210125122638.2947058-1-maz@kernel.org>
 <20210125122638.2947058-2-maz@kernel.org>
From: Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <61c1954a-57b5-35c6-a18d-cb5a1aae6049@arm.com>
Date: Tue, 26 Jan 2021 17:32:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125122638.2947058-2-maz@kernel.org>
Content-Language: en-US
Cc: kernel-team@android.com
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

Hi Marc,

The patch looks correct to me. Just to be on the safe side, I had a look at how
the other fields are generated and they match the architecture:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

On 1/25/21 12:26 PM, Marc Zyngier wrote:
> The AArch32 CP14 DBGDIDR has bit 15 set to RES1, which our current
> emulation doesn't set. Just add the missing bit.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 3313dedfa505..0c0832472c4a 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1711,7 +1711,7 @@ static bool trap_dbgidr(struct kvm_vcpu *vcpu,
>  		p->regval = ((((dfr >> ID_AA64DFR0_WRPS_SHIFT) & 0xf) << 28) |
>  			     (((dfr >> ID_AA64DFR0_BRPS_SHIFT) & 0xf) << 24) |
>  			     (((dfr >> ID_AA64DFR0_CTX_CMPS_SHIFT) & 0xf) << 20)
> -			     | (6 << 16) | (el3 << 14) | (el3 << 12));
> +			     | (6 << 16) | (1 << 15) | (el3 << 14) | (el3 << 12));
>  		return true;
>  	}
>  }
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
