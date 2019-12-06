Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 311F8114FE4
	for <lists+kvmarm@lfdr.de>; Fri,  6 Dec 2019 12:43:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF2764AEFF;
	Fri,  6 Dec 2019 06:43:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eBGdoKFANFeY; Fri,  6 Dec 2019 06:43:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E8974A578;
	Fri,  6 Dec 2019 06:43:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D87404ACE6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:43:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ktGxAXC7KIs1 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Dec 2019 06:43:11 -0500 (EST)
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
 [213.251.177.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B759F4A531
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Dec 2019 06:43:11 -0500 (EST)
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1idC0j-0001qF-ES; Fri, 06 Dec 2019 12:43:01 +0100
To: linmiaohe <linmiaohe@huawei.com>
Subject: Re: [PATCH] KVM: arm: get rid of unused arg in
 =?UTF-8?Q?cpu=5Finit=5Fhyp=5Fmode=28=29?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Date: Fri, 06 Dec 2019 11:43:01 +0000
From: Marc Zyngier <maz@kernel.org>
In-Reply-To: <1574320559-5662-1-git-send-email-linmiaohe@huawei.com>
References: <1574320559-5662-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <2ca295ccc30b53b4d57098d9718f8aa3@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linmiaohe@huawei.com, pbonzini@redhat.com,
 rkrcmar@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 2019-11-21 07:15, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> As arg dummy is not really needed, there's no need to pass
> NULL when calling cpu_init_hyp_mode(). So clean it up.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  virt/kvm/arm/arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 86c6aa1cb58e..a5470f1b1a19 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1315,7 +1315,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  	}
>  }
>
> -static void cpu_init_hyp_mode(void *dummy)
> +static void cpu_init_hyp_mode(void)
>  {
>  	phys_addr_t pgd_ptr;
>  	unsigned long hyp_stack_ptr;
> @@ -1349,7 +1349,7 @@ static void cpu_hyp_reinit(void)
>  	if (is_kernel_in_hyp_mode())
>  		kvm_timer_init_vhe();
>  	else
> -		cpu_init_hyp_mode(NULL);
> +		cpu_init_hyp_mode();
>
>  	kvm_arm_init_debug();

Applied, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
