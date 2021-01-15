Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACB2F7782
	for <lists+kvmarm@lfdr.de>; Fri, 15 Jan 2021 12:20:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8C224B1A1;
	Fri, 15 Jan 2021 06:20:53 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id evF2FAMJWI+5; Fri, 15 Jan 2021 06:20:53 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A4BE04B19C;
	Fri, 15 Jan 2021 06:20:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 02CBC4B191
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jan 2021 06:20:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmkTIohQAtBN for <kvmarm@lists.cs.columbia.edu>;
 Fri, 15 Jan 2021 06:20:49 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B3A334B164
 for <kvmarm@lists.cs.columbia.edu>; Fri, 15 Jan 2021 06:20:49 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 885A62371F;
 Fri, 15 Jan 2021 11:20:48 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l0N9q-007iyv-BK; Fri, 15 Jan 2021 11:20:46 +0000
MIME-Version: 1.0
Date: Fri, 15 Jan 2021 11:20:46 +0000
From: Marc Zyngier <maz@kernel.org>
To: Jianyong Wu <jianyong.wu@arm.com>
Subject: Re: [PATCH] arm64/kvm: correct the error report in
 kvm_handle_guest_abort
In-Reply-To: <20210115093028.6504-1-jianyong.wu@arm.com>
References: <20210115093028.6504-1-jianyong.wu@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <6f5a2ce458e33f879635f45140293517@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jianyong.wu@arm.com, james.morse@arm.com, will@kernel.org,
 suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, Steve.Capper@arm.com, justin.he@arm.com,
 nd@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: justin.he@arm.com, nd@arm.com, will@kernel.org,
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

On 2021-01-15 09:30, Jianyong Wu wrote:
> Currently, error report when cache maintenance at read-only memory 
> range,
> like rom, is not clear enough and even not correct. As the specific 
> error
> is definitely known by kvm, it is obliged to give it out.
> 
> Fox example, in a qemu/kvm VM, if the guest do dc at the pflash range 
> from
> 0 to 128M, error is reported by kvm as "Data abort outside memslots 
> with
> no valid syndrome info" which is not quite correct.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  arch/arm64/kvm/mmu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 7d2257cc5438..de66b7e38a5b 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1022,9 +1022,15 @@ int kvm_handle_guest_abort(struct kvm_vcpu 
> *vcpu)
>  		 * So let's assume that the guest is just being
>  		 * cautious, and skip the instruction.
>  		 */
> -		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
> -			kvm_incr_pc(vcpu);
> -			ret = 1;
> +		if (kvm_vcpu_dabt_is_cm(vcpu)) {
> +			if (kvm_is_error_hva(hva)) {
> +				kvm_incr_pc(vcpu);
> +				ret = 1;
> +				goto out_unlock;
> +			}
> +
> +			kvm_err("Do cache maintenance in the read-only memory range\n");

We don't scream on the console for guests bugs.

> +			ret = -EFAULT;
>  			goto out_unlock;
>  		}

And what is userspace going to do with that? To be honest, I'd rather
not report it in any case:

- either it isn't mapped, and there is no cache to clean/invalidate
- or it is mapped read-only:
   - if it is a "DC IVAC", the guest should get the fault as per
     the ARM ARM. But I don't think we can identify the particular CMO
     at this stage, so actually performing an invalidation is the least
     bad thing to do.

How about this (untested)?

         M.

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7d2257cc5438..0f497faad131 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1013,16 +1013,27 @@ int kvm_handle_guest_abort(struct kvm_vcpu 
*vcpu)
  		}

  		/*
-		 * Check for a cache maintenance operation. Since we
-		 * ended-up here, we know it is outside of any memory
-		 * slot. But we can't find out if that is for a device,
-		 * or if the guest is just being stupid. The only thing
-		 * we know for sure is that this range cannot be cached.
+		 * Check for a cache maintenance operation. Two cases:
  		 *
-		 * So let's assume that the guest is just being
-		 * cautious, and skip the instruction.
+		 * - It is outside of any memory slot. But we can't
+		 *   find out if that is for a device, or if the guest
+		 *   is just being stupid. The only thing we know for
+		 *   sure is that this range cannot be cached.  So
+		 *   let's assume that the guest is just being
+		 *   cautious, and skip the instruction.
+		 *
+		 * - Otherwise, clean/invalidate the whole memslot. We
+		 *   should special-case DC IVAC and inject a
+		 *   permission fault, but we can't really identify it
+		 *   in this context.
  		 */
-		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
+		if (kvm_vcpu_dabt_is_cm(vcpu)) {
+			if (!kvm_is_error_hva(hva)) {
+				spin_lock(&vcpu->kvm->mmu_lock);
+				stage2_flush_memslot(vcpu->kvm, memslot);
+				spin_unlock(&vcpu->kvm->mmu_lock);
+			}
+
  			kvm_incr_pc(vcpu);
  			ret = 1;
  			goto out_unlock;

-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
