Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 11EDD2A2626
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 09:32:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A02D4B5F4;
	Mon,  2 Nov 2020 03:32:38 -0500 (EST)
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
	with ESMTP id 48hkvP6azZQd; Mon,  2 Nov 2020 03:32:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 291FD4B5BC;
	Mon,  2 Nov 2020 03:32:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 24B734B4CF
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 03:32:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gg6M2SEQJ5Wh for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 03:32:35 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1EED74B4AE
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 03:32:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604305954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6XaYFGBLZgVS1+RdypFGytLHii7nmMINHdQyncFkHJQ=;
 b=IkhZZNX711vR33X4tft813y1mFVXwpBkSmQ+mrTkY6xoXMfCIPwpFiC2KiYcJI00WKGQNz
 m3HeV9TdllArC/vpMicrcQdPxhiSdqovkdAvC+v9M+1nhNbxs3Rr3C8wCLXQsS+CNKMRpS
 ODFl+6mvAfxnzjkJe9OuBxqcXLoXfZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-WwX2ILL-MNWcFmlaGaeNYA-1; Mon, 02 Nov 2020 03:32:30 -0500
X-MC-Unique: WwX2ILL-MNWcFmlaGaeNYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DAD757057;
 Mon,  2 Nov 2020 08:32:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E10FD5DA6A;
 Mon,  2 Nov 2020 08:32:27 +0000 (UTC)
Date: Mon, 2 Nov 2020 09:32:25 +0100
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/3] KVM: arm64: Check RAZ visibility in ID register
 accessors
Message-ID: <20201102083225.dncyprcessqbxiuu@kamzik.brq.redhat.com>
References: <20201029201105.101910-1-drjones@redhat.com>
 <20201029201105.101910-3-drjones@redhat.com>
 <878sbmdzln.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <878sbmdzln.wl-maz@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xu910121@sina.com, kvmarm@lists.cs.columbia.edu, Dave.Martin@arm.com
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

On Sat, Oct 31, 2020 at 06:23:00PM +0000, Marc Zyngier wrote:
> On Thu, 29 Oct 2020 20:11:04 +0000,
> Andrew Jones <drjones@redhat.com> wrote:
> > 
> > The instruction encodings of ID registers are preallocated. Until an
> > encoding is assigned a purpose the register is RAZ. KVM's general ID
> > register accessor functions already support both paths, RAZ or not.
> > If for each ID register we can determine if it's RAZ or not, then all
> > ID registers can build on the general functions. The register visibility
> > function allows us to check whether a register should be completely
> > hidden or not, extending it to also report when the register should
> > be RAZ or not allows us to use it for ID registers as well.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  arch/arm64/kvm/sys_regs.c | 19 ++++++++++++++++---
> >  arch/arm64/kvm/sys_regs.h | 20 ++++++++++++++++++++
> >  2 files changed, 36 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index d24e66ee59b3..9f6151589460 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1171,7 +1171,9 @@ static bool access_id_reg(struct kvm_vcpu *vcpu,
> >  			  struct sys_reg_params *p,
> >  			  const struct sys_reg_desc *r)
> >  {
> > -	return __access_id_reg(vcpu, p, r, false);
> > +	bool raz = sysreg_raz_from_guest(vcpu, r);
> > +
> > +	return __access_id_reg(vcpu, p, r, raz);
> >  }
> >  
> >  static bool access_raz_id_reg(struct kvm_vcpu *vcpu,
> > @@ -1283,13 +1285,17 @@ static int __set_id_reg(const struct kvm_vcpu *vcpu,
> >  static int get_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> >  		      const struct kvm_one_reg *reg, void __user *uaddr)
> >  {
> > -	return __get_id_reg(vcpu, rd, uaddr, false);
> > +	bool raz = sysreg_raz_from_user(vcpu, rd);
> > +
> > +	return __get_id_reg(vcpu, rd, uaddr, raz);
> >  }
> >  
> >  static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> >  		      const struct kvm_one_reg *reg, void __user *uaddr)
> >  {
> > -	return __set_id_reg(vcpu, rd, uaddr, false);
> > +	bool raz = sysreg_raz_from_user(vcpu, rd);
> > +
> > +	return __set_id_reg(vcpu, rd, uaddr, raz);
> >  }
> >  
> >  static int get_raz_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> > @@ -1375,12 +1381,19 @@ static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> >  	return false;
> >  }
> >  
> > +static unsigned int id_visibility(const struct kvm_vcpu *vcpu,
> > +				  const struct sys_reg_desc *r)
> > +{
> > +	return 0;
> > +}
> > +
> >  /* sys_reg_desc initialiser for known cpufeature ID registers */
> >  #define ID_SANITISED(name) {			\
> >  	SYS_DESC(SYS_##name),			\
> >  	.access	= access_id_reg,		\
> >  	.get_user = get_id_reg,			\
> >  	.set_user = set_id_reg,			\
> > +	.visibility = id_visibility,		\
> >  }
> >  
> >  /*
> > diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
> > index 5a6fc30f5989..d5add36c130a 100644
> > --- a/arch/arm64/kvm/sys_regs.h
> > +++ b/arch/arm64/kvm/sys_regs.h
> > @@ -61,6 +61,8 @@ struct sys_reg_desc {
> >  
> >  #define REG_HIDDEN_USER		(1 << 0) /* hidden from userspace ioctls */
> >  #define REG_HIDDEN_GUEST	(1 << 1) /* hidden from guest */
> > +#define REG_RAZ_USER		(1 << 2) /* RAZ from userspace ioctls */
> > +#define REG_RAZ_GUEST		(1 << 3) /* RAZ from guest */
> >
> >  static __printf(2, 3)
> >  inline void print_sys_reg_msg(const struct sys_reg_params *p,
> > @@ -129,6 +131,24 @@ static inline bool sysreg_hidden_from_user(const struct kvm_vcpu *vcpu,
> >  	return r->visibility(vcpu, r) & REG_HIDDEN_USER;
> >  }
> >  
> > +static inline bool sysreg_raz_from_guest(const struct kvm_vcpu *vcpu,
> > +					 const struct sys_reg_desc *r)
> > +{
> > +	if (likely(!r->visibility))
> > +		return false;
> > +
> > +	return r->visibility(vcpu, r) & REG_RAZ_GUEST;
> > +}
> > +
> > +static inline bool sysreg_raz_from_user(const struct kvm_vcpu *vcpu,
> > +					const struct sys_reg_desc *r)
> > +{
> > +	if (likely(!r->visibility))
> > +		return false;
> > +
> > +	return r->visibility(vcpu, r) & REG_RAZ_USER;
> > +}
> > +
> >  static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
> >  			      const struct sys_reg_desc *i2)
> >  {
> 
> Is there actually a case for any ID register to have different
> RAZ semantics between guest and userspace? I have the feeling that
> we'd want them to be consistent at all times. Or did you have any
> particular (and future) use case in mind?

I was just following the hidden pattern too closely. You're right
that we'll probably only ever need a single RAZ flag. And, if we do
ever need both, then we can always add another flag later.

I'll respin this patch with just one flag.

> 
> Otherwise, looks good.
> 

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
