Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88E2449FD
	for <lists+kvmarm@lfdr.de>; Fri, 14 Aug 2020 14:51:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AE194BC4C;
	Fri, 14 Aug 2020 08:51:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ktoxVoSQtTLC; Fri, 14 Aug 2020 08:51:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 001D44BC41;
	Fri, 14 Aug 2020 08:51:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C917D4BC39
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Aug 2020 08:51:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALHg7-cSrmLM for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Aug 2020 08:51:46 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E8974BC32
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Aug 2020 08:51:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597409505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rk6ITuCn7zU0e7A2NQrTHTju/fxpAw6G/R1jmaxYFto=;
 b=WoEoAo2fViqsJfxTVYIIrCTeoAVgeFSXNtvJj+VrKenxI8AcQ3OJpETieHCs2uwkG6muDp
 288XD2OEZHwBsXthAISvFa5QZaF60xFss/5OXbvl/wPU+pQic7CCDLNKhLOUDFfPrsqA56
 /V/JgRFL/BDhmVw/dvYmJ0ucHoSp47g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-b-7UvObSNSCX7uE_UBnHhA-1; Fri, 14 Aug 2020 08:51:43 -0400
X-MC-Unique: b-7UvObSNSCX7uE_UBnHhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 442B5106B81C;
 Fri, 14 Aug 2020 12:51:42 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B73255C1C2;
 Fri, 14 Aug 2020 12:51:38 +0000 (UTC)
Date: Fri, 14 Aug 2020 14:51:35 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [RFC 2/4] kvm: arm64: emulate the ID registers
Message-ID: <20200814125135.i2uz74vqunwik4fz@kamzik.brq.redhat.com>
References: <20200813060517.2360048-1-liangpeng10@huawei.com>
 <20200813060517.2360048-3-liangpeng10@huawei.com>
 <20200813090558.3eqwoxp7m6jmknft@kamzik.brq.redhat.com>
 <20200813100200.mvcumaeifnqezelm@kamzik.brq.redhat.com>
 <bc64b90c-db51-02cf-28af-0af2fddc3e90@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc64b90c-db51-02cf-28af-0af2fddc3e90@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, kvm@vger.kernel.org,
 maz@kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Fri, Aug 14, 2020 at 07:49:43PM +0800, Peng Liang wrote:
> On 8/13/2020 6:02 PM, Andrew Jones wrote:
> > On Thu, Aug 13, 2020 at 11:05:58AM +0200, Andrew Jones wrote:
> >> On Thu, Aug 13, 2020 at 02:05:15PM +0800, Peng Liang wrote:
> >>> To emulate the ID registers, we need a place to storage the values of
> >>> the ID regsiters.  Maybe putting in kvm_arch_vcpu is a good idea.
> >>>
> >>> This commit has no functional changes but only code refactor.  When
> >>> initializing a vcpu, get the values of the ID registers from
> >>> arm64_ftr_regs and storage them in kvm_arch_vcpu.  And we just read
> >>> the value from kvm_arch_vcpu when getting/setting the value of the ID
> >>> regs.
> >>>
> >>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >>> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
> >>> ---
> >>>  arch/arm64/include/asm/kvm_host.h |  2 ++
> >>>  arch/arm64/kvm/arm.c              | 20 ++++++++++++++++++++
> >>>  arch/arm64/kvm/sys_regs.c         | 27 +++++++++++++++++++++++----
> >>>  include/uapi/linux/kvm.h          | 11 +++++++++++
> >>>  4 files changed, 56 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> >>> index f81151ad3d3c..7f7bd36702f7 100644
> >>> --- a/arch/arm64/include/asm/kvm_host.h
> >>> +++ b/arch/arm64/include/asm/kvm_host.h
> >>> @@ -336,6 +336,8 @@ struct kvm_vcpu_arch {
> >>>  		u64 last_steal;
> >>>  		gpa_t base;
> >>>  	} steal;
> >>> +
> >>> +	struct id_registers idregs;
> >>>  };
> >>>  
> >>>  /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
> >>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> >>> index 73e12869afe3..18ebbe1c64ee 100644
> >>> --- a/arch/arm64/kvm/arm.c
> >>> +++ b/arch/arm64/kvm/arm.c
> >>> @@ -262,6 +262,24 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
> >>>  	return 0;
> >>>  }
> >>>  
> >>> +static int get_cpu_ftr(u32 id, u64 val, void *argp)
> >>> +{
> >>> +	struct id_registers *idregs = argp;
> >>> +
> >>> +	/*
> >>> +	 * (Op0, Op1, CRn, CRm, Op2) of ID registers is (3, 0, 0, crm, op2),
> >>> +	 * where 1<=crm<8, 0<=op2<8.
> >>> +	 */
> >>> +	if (sys_reg_Op0(id) == 3 && sys_reg_Op1(id) == 0 &&
> >>> +	    sys_reg_CRn(id) == 0 && sys_reg_CRm(id) > 0) {
> >>> +		idregs->regs[idregs->num].sys_id = id;
> >>> +		idregs->regs[idregs->num].sys_val = val;
> >>> +		idregs->num++;
> >>
> >> This num++ means we should ensure get_cpu_ftr() is only used once per
> >> VCPU, but we don't need 'num'. The index can be derived: (crm<<3)|op2
> >>
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> >>>  {
> >>>  	int err;
> >>> @@ -285,6 +303,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> >>>  	if (err)
> >>>  		return err;
> >>>  
> >>> +	arm64_cpu_ftr_regs_traverse(get_cpu_ftr, &vcpu->arch.idregs);
> >>> +
> >>>  	return create_hyp_mappings(vcpu, vcpu + 1, PAGE_HYP);
> >>>  }
> >>>  
> >>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> >>> index 138961d7ebe3..776c2757a01e 100644
> >>> --- a/arch/arm64/kvm/sys_regs.c
> >>> +++ b/arch/arm64/kvm/sys_regs.c
> >>> @@ -1092,13 +1092,32 @@ static bool access_arch_timer(struct kvm_vcpu *vcpu,
> >>>  	return true;
> >>>  }
> >>>  
> >>> +static struct id_reg_info *kvm_id_reg(struct kvm_vcpu *vcpu, u64 id)
> >>> +{
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < vcpu->arch.idregs.num; ++i) {
> >>> +		if (vcpu->arch.idregs.regs[i].sys_id == id)
> >>> +			return &vcpu->arch.idregs.regs[i];
> >>
> >> With a derived index we don't need to search. Just do
> >>
> >>  if (sys_reg_Op0(id) != 3 || sys_reg_Op1(id) != 0 ||
> >>      sys_reg_CRn(id) != 0 || sys_reg_CRm(id) == 0)
> >>       return NULL;
> >>
> >>  return &vcpu->arch.idregs.regs[(sys_reg_CRm(id)<<3) | sys_reg_Op2(id)]; 
> >>  
> >>
> >>> +	}
> >>> +	return NULL;
> >>> +}
> >>> +
> >>> +static u64 kvm_get_id_reg(struct kvm_vcpu *vcpu, u64 id)
> >>> +{
> >>> +	struct id_reg_info *ri = kvm_id_reg(vcpu, id);
> >>> +
> >>> +	BUG_ON(!ri);
> >>> +	return ri->sys_val;
> >>> +}
> >>> +
> >>>  /* Read a sanitised cpufeature ID register by sys_reg_desc */
> >>> -static u64 read_id_reg(const struct kvm_vcpu *vcpu,
> >>> +static u64 read_id_reg(struct kvm_vcpu *vcpu,
> >>>  		struct sys_reg_desc const *r, bool raz)
> >>>  {
> >>>  	u32 id = sys_reg((u32)r->Op0, (u32)r->Op1,
> >>>  			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
> >>> -	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
> >>> +	u64 val = raz ? 0 : kvm_get_id_reg(vcpu, id);
> >>>  
> >>>  	if (id == SYS_ID_AA64PFR0_EL1) {
> >>>  		if (!vcpu_has_sve(vcpu))
> >>> @@ -1238,7 +1257,7 @@ static int set_id_aa64zfr0_el1(struct kvm_vcpu *vcpu,
> >>>   * are stored, and for set_id_reg() we don't allow the effective value
> >>>   * to be changed.
> >>>   */
> >>> -static int __get_id_reg(const struct kvm_vcpu *vcpu,
> >>> +static int __get_id_reg(struct kvm_vcpu *vcpu,
> >>>  			const struct sys_reg_desc *rd, void __user *uaddr,
> >>>  			bool raz)
> >>>  {
> >>> @@ -1248,7 +1267,7 @@ static int __get_id_reg(const struct kvm_vcpu *vcpu,
> >>>  	return reg_to_user(uaddr, &val, id);
> >>>  }
> >>>  
> >>> -static int __set_id_reg(const struct kvm_vcpu *vcpu,
> >>> +static int __set_id_reg(struct kvm_vcpu *vcpu,
> >>>  			const struct sys_reg_desc *rd, void __user *uaddr,
> >>>  			bool raz)
> >>>  {
> >>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >>> index f6d86033c4fa..1029444d04aa 100644
> >>> --- a/include/uapi/linux/kvm.h
> >>> +++ b/include/uapi/linux/kvm.h
> >>> @@ -1272,6 +1272,17 @@ struct kvm_vfio_spapr_tce {
> >>>  	__s32	tablefd;
> >>>  };
> >>>  
> >>> +#define ID_REG_MAX_NUMS 64
> >>> +struct id_reg_info {
> >>> +	uint64_t sys_id;
> >>> +	uint64_t sys_val;
> >>
> >> I'm not sure the 'sys_' prefix is necessary.
> >>
> >>> +};
> >>> +
> >>> +struct id_registers {
> >>> +	struct id_reg_info regs[ID_REG_MAX_NUMS];
> >>> +	uint64_t num;
> >>> +};
> >>> +
> >>
> >> This is arch specific, so there should be ARMv8 in the names.
> > 
> > Also, why are id_reg_info and id_registers UAPI?
> > 
> > Thanks,
> > drew
> > 
> 
> id_reg_info is for information of an ID register, and id_registers contains
> all the ID registers.

Obviously. But why is that UAPI? What user interface is using them?

> 
> Thanks,
> Peng
> 
> >>
> >>>  /*
> >>>   * ioctls for VM fds
> >>>   */
> >>> -- 
> >>> 2.18.4
> >>>
> >>
> > 
> > .
> > 
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
