Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5A865BCBA2
	for <lists+kvmarm@lfdr.de>; Tue, 24 Sep 2019 17:36:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E0DB24A6B5;
	Tue, 24 Sep 2019 11:36:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, FREEMAIL_FROM=0.001,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@gmail.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ab3+znpH4hV0; Tue, 24 Sep 2019 11:36:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 867804A523;
	Tue, 24 Sep 2019 11:36:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC9E74A51F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:36:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12zdoSpbUxom for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Sep 2019 14:36:35 -0400 (EDT)
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BF44A4A4FE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 14:36:35 -0400 (EDT)
Received: by mail-qt1-f195.google.com with SMTP id u22so18323545qtq.13
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Sep 2019 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YabcjeTFAAe5ZMdv64YzXMDO2i14GHKKmFFTyjQnKMA=;
 b=X7QiniTcJBk0fRmbeQkNylmFzYAw5Kc2QhnJf8bnNv1S0+mnP3sreyhHsjF2G2D1/o
 cWux4wEU5yZGEU9z7iDp0jzXnarBK+0l5AJhE9r2aG378Gq6/RzW/sm6uaKiSG+H7TFE
 wpv9m4E6pS0/i8F5o6l4tpAAlbWAm6V1YIRhmq5032hcEWdbopA/b4QzFmeivm/fZA7B
 UqhHvFBl1UVJxXwdtaN4oaGRg3nqONIQZHTGONuDDKGzFKvMh2n2RyosmsE+vyhAmUop
 0Ew9zYBVM6pWlT7ZeJD0KzD0iHUchtcFfga140cV/hfb5SttclrWyErFVM+JZXc+93jF
 ZC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YabcjeTFAAe5ZMdv64YzXMDO2i14GHKKmFFTyjQnKMA=;
 b=iB2yrUy9/8uX7ha9Y9n7vJdIG7eYEF2xEwEotOweEwW61QjRFHloMk7T1yY/OjUymb
 XIyggu8L4lXIMruAuW/E3FF91vz9GRgHheQGH2nu6opqsOr1bHmPD57s3UcLZhEFvQA3
 3uCssh3vlNSGyDjTaPGuaXEWwXQurBPMsYXExCX4HKoYTLIZsEZLyujoXlnI+WbePhTH
 EUg1v6+nWLCNkrLuJ+9myUWUwUT965/3l/3J7ZXJIIORIjLr1zUuFOyDhOHV0MHrHJOu
 87Dxf4eNESw+QebVlU4/BhKVTl7Hg30dOlOsoz/kCBOITWUVHY+tQGY31HtmDqk6WoVH
 exiQ==
X-Gm-Message-State: APjAAAW0JxB+0peNpCUhTtxIlI253ULXpTFkyuf0s0Ofez9SnHS1eRty
 57oR5hXAo2UPl+rpzEuS0g==
X-Google-Smtp-Source: APXvYqy2fdEcXIWBoYXcRLxg+LPDS82nD9cShWd1OI3O5iWFeP629CE1bNoD9ZFsdCpJHcyEa9v21g==
X-Received: by 2002:ac8:1c54:: with SMTP id j20mr1516904qtk.302.1569263795365; 
 Mon, 23 Sep 2019 11:36:35 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id 22sm5126837qkj.0.2019.09.23.11.36.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Sep 2019 11:36:34 -0700 (PDT)
Date: Mon, 23 Sep 2019 14:36:29 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Subject: Re: [Qemu-devel] [RFC QEMU v2 1/2] arm/virt: Initialize generic
 timer scale factor dynamically
Message-ID: <20190923183628.4jj5yougeksylqrt@gabell>
References: <1543352837-21529-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1543352837-21529-2-git-send-email-bijan.mottahedeh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543352837-21529-2-git-send-email-bijan.mottahedeh@oracle.com>
User-Agent: NeoMutt/20180716
X-Mailman-Approved-At: Tue, 24 Sep 2019 11:36:39 -0400
Cc: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu
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

Hi,

This issue remains on the latest qemu, right?
Let me add some comments for the patch.

On Tue, Nov 27, 2018 at 01:07:16PM -0800, Bijan Mottahedeh wrote:
> Initialize the generic timer scale factor based on the counter frequency
> register cntfrq_el0, and default to the current static value if necessary.
> Always use the default value for TCG.
> 
> Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
> ---
>  hw/arm/virt.c          | 17 +++++++++++++++++
>  target/arm/helper.c    | 19 ++++++++++++++++---
>  target/arm/internals.h |  8 ++++++--
>  target/arm/kvm64.c     |  1 +
>  4 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 281ddcd..792d223 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -59,6 +59,7 @@
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> +#include "target/arm/internals.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1710,6 +1711,21 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>      return NULL;
>  }
>  
> +static void set_system_clock_scale(void)
> +{
> +    unsigned long cntfrq_el0 = 0;
> +
> +#ifdef  CONFIG_KVM
> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(cntfrq_el0));
> +#endif
> +
> +    if (cntfrq_el0 == 0) {
> +        cntfrq_el0 = GTIMER_SCALE_DEF;
> +    }
> +
> +    system_clock_scale = NANOSECONDS_PER_SECOND / (int)cntfrq_el0;
> +}
> +
>  static void virt_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1736,6 +1752,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
>      hc->plug = virt_machine_device_plug_cb;
> +    set_system_clock_scale();
>  }
>  
>  static const TypeInfo virt_machine_info = {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 66afb08..6330586 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -18,6 +18,7 @@
>  #include "sysemu/kvm.h"
>  #include "fpu/softfloat.h"
>  #include "qemu/range.h"
> +#include "hw/arm/arm.h"

arm.h is renamed to boot.h, so:

#include "hw/arm/boot.h"

>  
>  #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
>  
> @@ -1614,6 +1615,18 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
>      return CP_ACCESS_OK;
>  }
>  
> +static void gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    assert(GTIMER_SCALE);
> +    assert(ri->fieldoffset);
> +
> +    if (cpreg_field_is_64bit(ri)) {
> +        CPREG_FIELD64(env, ri) = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
> +    } else {
> +        CPREG_FIELD32(env, ri) = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
> +    }
> +}
> +
>  static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
>                                          bool isread)
>  {
> @@ -1709,7 +1722,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
>      }
>  }
>  
> -static uint64_t gt_get_countervalue(CPUARMState *env)
> +uint64_t gt_get_countervalue(CPUARMState *env)
>  {
>      return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
>  }
> @@ -1996,7 +2009,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
>        .access = PL1_RW | PL0_R, .accessfn = gt_cntfrq_access,
>        .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
> -      .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
> +      .resetfn = gt_cntfrq_reset,

Build error is here on the target aarch64-linux-user, like as:

/home/foo/qemu/target/arm/helper.c:2901:18: error: 'gt_cntfrq_reset' undeclared here (not in a function); did you mean 'g_timer_reset'?
       .resetfn = gt_cntfrq_reset,
                  ^~~~~~~~~~~~~~~

The issue doesn't affect to aarch64-linux-user, right?
If so:

#ifdef CONFIG_LINUX_USER
      .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
#else
      .resetfn = gt_cntfrq_reset,
#endif

>      },
>      /* overall control: mostly access permissions */
>      { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
> @@ -2187,7 +2200,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
>        .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
>        .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
> -      .resetvalue = NANOSECONDS_PER_SECOND / GTIMER_SCALE,
> +      .resetfn = gt_cntfrq_reset,

Same as above.

>      },
>      { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index dc93577..b66a1fa 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -52,9 +52,13 @@ static inline bool excp_is_internal(int excp)
>  }
>  
>  /* Scale factor for generic timers, ie number of ns per tick.
> - * This gives a 62.5MHz timer.
> + * Calculated dynamically based on CNTFRQ with a default value
> + * that gives a 62.5MHZ timer.
>   */
> -#define GTIMER_SCALE 16
> +#define GTIMER_SCALE        system_clock_scale
> +#define GTIMER_SCALE_DEF    16

I think extern for system_clock_scale should be added here,
otherwise the build error happens.
If the issue doesn't affect to aarch64-linux-user, how about the following?

#ifndef CONFIG_LINUX_USER
extern int system_clock_scale;
#define GTIMER_SCALE        system_clock_scale
#define GTIMER_SCALE_DEF    16
#else
#define GTIMER_SCALE        16
#endif

> +
> +uint64_t gt_get_countervalue(CPUARMState *);
>  
>  /* Bit definitions for the v7M CONTROL register */
>  FIELD(V7M_CONTROL, NPRIV, 0, 1)
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index e0b8246..5d1c394 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -485,6 +485,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      set_feature(&features, ARM_FEATURE_NEON);
>      set_feature(&features, ARM_FEATURE_AARCH64);
>      set_feature(&features, ARM_FEATURE_PMU);
> +    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
>  
>      ahcf->features = features;

Thanks,
Masa
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
