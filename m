Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5298D57458A
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jul 2022 09:10:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 43FAF4C59E;
	Thu, 14 Jul 2022 03:10:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enAxhf9n-CZj; Thu, 14 Jul 2022 03:10:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D07F84C59A;
	Thu, 14 Jul 2022 03:10:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0813A4C594
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 03:10:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wytsuRIcz-ap for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jul 2022 03:10:28 -0400 (EDT)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3086D4C592
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jul 2022 03:10:28 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 390F0CE256B;
 Thu, 14 Jul 2022 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9947BC34114;
 Thu, 14 Jul 2022 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657782621;
 bh=OW93xADmWIzkDjXJ3YhYksqVTv8k3OC+JR+fKsAdSus=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ob+epD8tkC8LjXI5bnJBB2af7jTHev4W+29rVw34ICgjtHVm2vjijZFoa+YMUiJUw
 +zX2ztSj9yg5u+xdMgXpRCKhf0t7OIezQfrBc4+qHTFy/tEscUu6u1YMwIpAf9oTek
 BaXAWHLfAYD8oe18fv05E4p+1buIVl5t33aq0vA3qaTslUg+/wTROuMo7Ci7x6CLSw
 mnU+43FS4TpiNS/t3imnQljheGTBS4i7CtSJVNkyzzJy3DSoOUZ2YG+qBNBmZNXwME
 bK6XL4YVnCEtQsDfopdxyfcFS9QYWJKYd11FWiYyEmCcPLiphVzC8zHaL1VJ4jfWSP
 p/RRWdr4vaKJA==
Received: from ip-185-104-136-29.ptr.icomera.net ([185.104.136.29]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1oBszD-007Ndf-LE;
 Thu, 14 Jul 2022 08:10:19 +0100
Date: Thu, 14 Jul 2022 08:09:32 +0100
Message-ID: <875yk0yxub.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Reiji Watanabe <reijiw@google.com>
Subject: Re: [PATCH 13/19] KVM: arm64: vgic-v2: Consolidate userspace access
 for MMIO registers
In-Reply-To: <CAAeT=Fx9CbiJStMJcQ=-iwoLhAQGcwPbW==b0yHxkd3hmcXjiQ@mail.gmail.com>
References: <20220706164304.1582687-1-maz@kernel.org>
 <20220706164304.1582687-14-maz@kernel.org>
 <CAAeT=Fx9CbiJStMJcQ=-iwoLhAQGcwPbW==b0yHxkd3hmcXjiQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.104.136.29
X-SA-Exim-Rcpt-To: reijiw@google.com, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, schspa@gmail.com,
 kernel-team@android.com, oliver.upton@linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Schspa Shi <schspa@gmail.com>,
 Oliver Upton <oliver.upton@linux.dev>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, 14 Jul 2022 05:43:27 +0100,
Reiji Watanabe <reijiw@google.com> wrote:
> 
> Hi Marc,
> 
> On Wed, Jul 6, 2022 at 10:05 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Align the GICv2 MMIO accesses from userspace with the way the GICv3
> > code is now structured.
> >
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/kvm/vgic/vgic-kvm-device.c | 40 ++++++++++++---------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
> > index 925875722027..ddead333c232 100644
> > --- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
> > +++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
> > @@ -348,17 +348,18 @@ bool lock_all_vcpus(struct kvm *kvm)
> >   *
> >   * @dev:      kvm device handle
> >   * @attr:     kvm device attribute
> > - * @reg:      address the value is read or written
> >   * @is_write: true if userspace is writing a register
> >   */
> >  static int vgic_v2_attr_regs_access(struct kvm_device *dev,
> >                                     struct kvm_device_attr *attr,
> > -                                   u32 *reg, bool is_write)
> > +                                   bool is_write)
> >  {
> > +       u32 __user *uaddr = (u32 __user *)(unsigned long)attr->addr;
> >         struct vgic_reg_attr reg_attr;
> >         gpa_t addr;
> >         struct kvm_vcpu *vcpu;
> >         int ret;
> > +       u32 val;
> >
> >         ret = vgic_v2_parse_attr(dev, attr, &reg_attr);
> >         if (ret)
> > @@ -367,6 +368,10 @@ static int vgic_v2_attr_regs_access(struct kvm_device *dev,
> >         vcpu = reg_attr.vcpu;
> >         addr = reg_attr.addr;
> >
> > +       if (is_write)
> > +               if (get_user(val, uaddr))
> > +                       return -EFAULT;
> > +
> >         mutex_lock(&dev->kvm->lock);
> >
> >         ret = vgic_init(dev->kvm);
> > @@ -380,10 +385,10 @@ static int vgic_v2_attr_regs_access(struct kvm_device *dev,
> >
> >         switch (attr->group) {
> >         case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
> > -               ret = vgic_v2_cpuif_uaccess(vcpu, is_write, addr, reg);
> > +               ret = vgic_v2_cpuif_uaccess(vcpu, is_write, addr, &val);
> >                 break;
> >         case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
> > -               ret = vgic_v2_dist_uaccess(vcpu, is_write, addr, reg);
> > +               ret = vgic_v2_dist_uaccess(vcpu, is_write, addr, &val);
> >                 break;
> >         default:
> >                 ret = -EINVAL;
> > @@ -393,6 +398,11 @@ static int vgic_v2_attr_regs_access(struct kvm_device *dev,
> >         unlock_all_vcpus(dev->kvm);
> >  out:
> >         mutex_unlock(&dev->kvm->lock);
> > +
> > +       if (!ret && !is_write)
> > +               if (put_user(val, uaddr))
> > +                       ret = -EFAULT;
> > +
> >         return ret;
> >  }
> >
> > @@ -407,15 +417,8 @@ static int vgic_v2_set_attr(struct kvm_device *dev,
> >
> >         switch (attr->group) {
> >         case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
> > -       case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
> > -               u32 __user *uaddr = (u32 __user *)(long)attr->addr;
> > -               u32 reg;
> > -
> > -               if (get_user(reg, uaddr))
> > -                       return -EFAULT;
> > -
> > -               return vgic_v2_attr_regs_access(dev, attr, &reg, true);
> > -       }
> > +       case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
> > +               return vgic_v2_attr_regs_access(dev, attr, true);
> >         }
> >
> >         return -ENXIO;
> > @@ -432,15 +435,8 @@ static int vgic_v2_get_attr(struct kvm_device *dev,
> >
> >         switch (attr->group) {
> >         case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
> > -       case KVM_DEV_ARM_VGIC_GRP_CPU_REGS: {
> > -               u32 __user *uaddr = (u32 __user *)(long)attr->addr;
> > -               u32 reg = 0;
> > -
> > -               ret = vgic_v2_attr_regs_access(dev, attr, &reg, false);
> > -               if (ret)
> > -                       return ret;
> > -               return put_user(reg, uaddr);
> > -       }
> > +       case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
> > +               return vgic_v2_attr_regs_access(dev, attr, false);
> >         }
> >
> >         return -ENXIO;
> 
> For vgic_v2_{set,get}_attr(), perhaps it might be even simpler
> to call vgic_{set,get}_common_attr() from the "default" case
> of "switch (attr->group)".
> This is not directly related to this patch though:)

Indeed. This also applies to v3, and there is a couple more cleanups
that can be added. I'll add that as an extra patch, as the result is
rather nice.

> Reviewed-by: Reiji Watanabe <reijiw@google.com>

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
