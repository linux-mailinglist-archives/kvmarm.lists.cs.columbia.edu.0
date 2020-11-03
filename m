Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECEC2A441A
	for <lists+kvmarm@lfdr.de>; Tue,  3 Nov 2020 12:24:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1950B4B3B3;
	Tue,  3 Nov 2020 06:24:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04B01bhMx3a3; Tue,  3 Nov 2020 06:24:02 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D213E4B367;
	Tue,  3 Nov 2020 06:24:01 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 743C34B31D
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 06:24:00 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k3RynyNsN+6D for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 Nov 2020 06:23:59 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 383044B290
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 Nov 2020 06:23:59 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D575D101E;
 Tue,  3 Nov 2020 03:23:58 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 327A03F66E;
 Tue,  3 Nov 2020 03:23:58 -0800 (PST)
Date: Tue, 3 Nov 2020 11:23:54 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v2 2/3] KVM: arm64: Check RAZ visibility in ID register
 accessors
Message-ID: <20201103112354.GH6882@arm.com>
References: <20201102185037.49248-1-drjones@redhat.com>
 <20201102185037.49248-3-drjones@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102185037.49248-3-drjones@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: maz@kernel.org, xu910121@sina.com, kvmarm@lists.cs.columbia.edu
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

On Mon, Nov 02, 2020 at 07:50:36PM +0100, Andrew Jones wrote:
> The instruction encodings of ID registers are preallocated. Until an
> encoding is assigned a purpose the register is RAZ. KVM's general ID
> register accessor functions already support both paths, RAZ or not.
> If for each ID register we can determine if it's RAZ or not, then all
> ID registers can build on the general functions. The register visibility
> function allows us to check whether a register should be completely
> hidden or not, extending it to also report when the register should
> be RAZ or not allows us to use it for ID registers as well.

Nit: no statement of what the patch does.

You might want to point out that the introduced REG_RAZ functionality is
intentionally not used in this patch.

> No functional change intended.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 19 ++++++++++++++++---
>  arch/arm64/kvm/sys_regs.h | 10 ++++++++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 6ff0c15531ca..b8822a20b1ea 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1153,6 +1153,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  	return val;
>  }
>  
> +static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
> +				  const struct sys_reg_desc *r)
> +{
> +	return 0;
> +}
> +
>  /* cpufeature ID register access trap handlers */
>  
>  static bool __access_id_reg(struct kvm_vcpu *vcpu,
> @@ -1171,7 +1177,9 @@ static bool access_id_reg(struct kvm_vcpu *vcpu,
>  			  struct sys_reg_params *p,
>  			  const struct sys_reg_desc *r)
>  {
> -	return __access_id_reg(vcpu, p, r, false);
> +	bool raz = sysreg_visible_as_raz(vcpu, r);
> +
> +	return __access_id_reg(vcpu, p, r, raz);
>  }
>  
>  static bool access_raz_id_reg(struct kvm_vcpu *vcpu,
> @@ -1283,13 +1291,17 @@ static int __set_id_reg(const struct kvm_vcpu *vcpu,
>  static int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  		      const struct kvm_one_reg *reg, void __user *uaddr)
>  {
> -	return __get_id_reg(vcpu, rd, uaddr, false);
> +	bool raz = sysreg_visible_as_raz(vcpu, rd);
> +
> +	return __get_id_reg(vcpu, rd, uaddr, raz);
>  }
>  
>  static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>  		      const struct kvm_one_reg *reg, void __user *uaddr)
>  {
> -	return __set_id_reg(vcpu, rd, uaddr, false);
> +	bool raz = sysreg_visible_as_raz(vcpu, rd);
> +
> +	return __set_id_reg(vcpu, rd, uaddr, raz);
>  }
>  
>  static int get_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> @@ -1381,6 +1393,7 @@ static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	.access	= access_id_reg,		\
>  	.get_user = get_id_reg,			\
>  	.set_user = set_id_reg,			\
> +	.visibility = id_visibility,		\

This is just the default for ID_SANITISED, right?

>  }
>  
>  /*
> diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> index 5a6fc30f5989..9d3ef7cfa116 100644
> --- a/arch/arm64/kvm/sys_regs.h
> +++ b/arch/arm64/kvm/sys_regs.h
> @@ -61,6 +61,7 @@ struct sys_reg_desc {
>  
>  #define REG_HIDDEN_USER		(1 << 0) /* hidden from userspace ioctls */
>  #define REG_HIDDEN_GUEST	(1 << 1) /* hidden from guest */
> +#define REG_RAZ			(1 << 2) /* RAZ from userspace ioctls and guest */
>  
>  static __printf(2, 3)
>  inline void print_sys_reg_msg(const struct sys_reg_params *p,
> @@ -129,6 +130,15 @@ static inline bool sysreg_hidden_from_user(const struct kvm_vcpu *vcpu,
>  	return r->visibility(vcpu, r) & REG_HIDDEN_USER;
>  }
>  
> +static inline bool sysreg_visible_as_raz(const struct kvm_vcpu *vcpu,
> +					 const struct sys_reg_desc *r)
> +{
> +	if (likely(!r->visibility))
> +		return false;
> +
> +	return r->visibility(vcpu, r) & REG_RAZ;
> +}
> +

[...]

Looks reasonable, I think.

Cheers
---Dave
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
