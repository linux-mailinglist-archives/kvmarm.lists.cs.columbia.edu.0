Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 08AA5445A15
	for <lists+kvmarm@lfdr.de>; Thu,  4 Nov 2021 19:58:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5978E4B092;
	Thu,  4 Nov 2021 14:58:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eYB+eZeMKrjR; Thu,  4 Nov 2021 14:58:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 391054B0EF;
	Thu,  4 Nov 2021 14:58:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 012404A5A0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Nov 2021 14:58:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NwB8fu73rTVK for <kvmarm@lists.cs.columbia.edu>;
 Thu,  4 Nov 2021 14:58:28 -0400 (EDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9825D49E5F
 for <kvmarm@lists.cs.columbia.edu>; Thu,  4 Nov 2021 14:58:28 -0400 (EDT)
Received: by mail-yb1-f169.google.com with SMTP id v64so16802838ybi.5
 for <kvmarm@lists.cs.columbia.edu>; Thu, 04 Nov 2021 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nUmCcM2R27aOSL47pzbGyQqJ7fyPEFQW3dQWmWZEKC0=;
 b=oQjhMPhYfnVcGc5KK9SCmA092z/fwG+34NzH0Wc9ooFbdCywDFlYcfLZsnjMMsT6wA
 UP7MYfCuyqdjsgF1ngXeQtwctBnTPnm3DAoPKWSubBQUVit3MSIN1oqZJGdcivz0ZMA2
 bf9zIa941ohwL40/4HeiHvsJYLpVvUdObfiBS9tDj4l8mzXhDOryCBTaDhkCS6ZMBL05
 wnkLbO2+6f3CNLWKslMFDqkVtyOw3f65Qmuz8TEmJEKSxtCjYvUlT3z2U7fo7bf8d4JR
 Lj+PdinXblZI0ySHphrkl8/9Avk12Y+rkrvka9L3n1cO3iUGqIeNU6rxVsxa5+rC/I1p
 14jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nUmCcM2R27aOSL47pzbGyQqJ7fyPEFQW3dQWmWZEKC0=;
 b=ZiOSIfVpQfuWcp81DbOMkgAK+dBpBs3qjpCl+Z60vyM+9ZmSRRd7HozWjs0VSGX6cc
 xC/v979LfySnC8xcup0sGuOCT16LdfumIvwaykXqXr+zJU3Uw/arI0alSDuAxfYDuwdp
 W25XBU/GRZN1JzfrtlPwvIe41qrdh3pvSqQxC28RQw1BLftYWfFVRJGcUpNXF9nasOwy
 QjpajD7S3RaSYFeAugWtPY+Cqw8Ps7VOTP0iuMb2AtXhKZcTUORdZ5rlA+kW48M57kVe
 g1hEsguZLcbYraFhTMTxb2cBsu0a5dIH+boLreQNJnMPe/T2xljSEvSkibO+H7MDkMuo
 o2vw==
X-Gm-Message-State: AOAM530l+VhakD8aYA+XvlW+alG6G7K5D/DOiTM7H+5YCTCdoRWlAXwV
 dYQ9gRjeLBs741zdAZeBKTiibXXucn/z8XsmUYkKhA==
X-Google-Smtp-Source: ABdhPJw9+in7+jK3BzPJrRdvOhUL2WxBB20G1qO5j2AUIeI2ZbWx1/3MaBBORni/qhRE4xF3hhcxbWt21DUg28bKgAM=
X-Received: by 2002:a05:6902:10c4:: with SMTP id
 w4mr39840645ybu.439.1636052307853; 
 Thu, 04 Nov 2021 11:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211102002203.1046069-1-rananta@google.com>
 <20211102002203.1046069-7-rananta@google.com>
 <YYMoEYzBvEqN5MD7@google.com>
In-Reply-To: <YYMoEYzBvEqN5MD7@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 4 Nov 2021 11:58:16 -0700
Message-ID: <CAJHc60yGpDR3denxfTUs_TxKcNWaPLChkVEgEXpNkGvkRS=KEg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] tools: Import the firmware registers
To: Oliver Upton <oupton@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Wed, Nov 3, 2021 at 5:23 PM Oliver Upton <oupton@google.com> wrote:
>
> On Tue, Nov 02, 2021 at 12:22:01AM +0000, Raghavendra Rao Ananta wrote:
> > Import the firmware definitions for the firmware registers,
> > KVM_REG_ARM_STD, KVM_REG_ARM_STD_HYP, and KVM_REG_ARM_VENDOR_HYP.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> >
> > ---
> >  tools/arch/arm64/include/uapi/asm/kvm.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
>
> Won't we have the latest UAPI headers available in usr/include/ at build
> time?
>
I think we do. Wasn't aware of this. I'll delete the patch.

Regards,
Raghavendra
> --
> Oliver
>
> > diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
> > index b3edde68bc3e..a1d0e8e69eed 100644
> > --- a/tools/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/tools/arch/arm64/include/uapi/asm/kvm.h
> > @@ -281,6 +281,24 @@ struct kvm_arm_copy_mte_tags {
> >  #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED     3
> >  #define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED          (1U << 4)
> >
> > +#define KVM_REG_ARM_STD                      KVM_REG_ARM_FW_REG(3)
> > +enum kvm_reg_arm_std_bmap {
> > +     KVM_REG_ARM_STD_TRNG_V1_0,
> > +     KVM_REG_ARM_STD_BMAP_MAX,
> > +};
> > +
> > +#define KVM_REG_ARM_STD_HYP          KVM_REG_ARM_FW_REG(4)
> > +enum kvm_reg_arm_std_hyp_bmap {
> > +     KVM_REG_ARM_STD_HYP_PV_TIME_ST,
> > +     KVM_REG_ARM_STD_HYP_BMAP_MAX,
> > +};
> > +
> > +#define KVM_REG_ARM_VENDOR_HYP               KVM_REG_ARM_FW_REG(5)
> > +enum kvm_reg_arm_vendor_hyp_bmap {
> > +     KVM_REG_ARM_VENDOR_HYP_PTP,
> > +     KVM_REG_ARM_VENDOR_HYP_BMAP_MAX,
> > +};
> > +
> >  /* SVE registers */
> >  #define KVM_REG_ARM64_SVE            (0x15 << KVM_REG_ARM_COPROC_SHIFT)
> >
> > --
> > 2.33.1.1089.g2158813163f-goog
> >
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
