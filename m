Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A38E1415D02
	for <lists+kvmarm@lfdr.de>; Thu, 23 Sep 2021 13:45:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 305DA4B135;
	Thu, 23 Sep 2021 07:45:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D3aWGYbpm-FQ; Thu, 23 Sep 2021 07:45:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C01754B11A;
	Thu, 23 Sep 2021 07:45:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A0464B101
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:45:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uuDEDRmuOznZ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Sep 2021 07:45:11 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B3044406E0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 07:45:11 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B973106F;
 Thu, 23 Sep 2021 04:45:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.17.13])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E915E3F59C;
 Thu, 23 Sep 2021 04:45:09 -0700 (PDT)
Date: Thu, 23 Sep 2021 12:45:06 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/5] arm64: Prevent kexec and hibernation if
 is_protected_kvm_enabled()
Message-ID: <20210923114506.GB14893@C02TD0UTHF1T.local>
References: <20210923112256.15767-1-will@kernel.org>
 <20210923112256.15767-2-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923112256.15767-2-will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>
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

On Thu, Sep 23, 2021 at 12:22:52PM +0100, Will Deacon wrote:
> When pKVM is enabled, the hypervisor code at EL2 and its data structures
> are inaccessible to the host kernel and cannot be torn down or replaced
> as this would defeat the integrity properies which pKVM aims to provide.
> Furthermore, the ABI between the host and EL2 is flexible and private to
> whatever the current implementation of KVM requires and so booting a new
> kernel with an old EL2 component is very likely to end in disaster.
> 
> In preparation for uninstalling the hyp stub calls which are relied upon
> to reset EL2, disable kexec and hibernation in the host when protected
> KVM is enabled.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 6f6ff072acbd..44369b99a57e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1128,5 +1128,6 @@ bool cpus_are_stuck_in_kernel(void)
>  {
>  	bool smp_spin_tables = (num_possible_cpus() > 1 && !have_cpu_die());
>  
> -	return !!cpus_stuck_in_kernel || smp_spin_tables;
> +	return !!cpus_stuck_in_kernel || smp_spin_tables ||
> +		is_protected_kvm_enabled();
>  }

IIUC you'll also need to do something to prevent kdump, since even with
CPUs stuck in the kernel that will try to do a kexec on the crashed CPU
and __cpu_soft_restart() won't be able to return to EL2.

You could fiddle with the BUG_ON() in machine_kexec() to die in this
case too.

Thanks,
Mark.

> -- 
> 2.33.0.464.g1972c5931b-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
