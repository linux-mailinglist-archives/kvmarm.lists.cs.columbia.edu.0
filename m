Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D82FB52B
	for <lists+kvmarm@lfdr.de>; Tue, 19 Jan 2021 11:14:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 12B034B3FF;
	Tue, 19 Jan 2021 05:14:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4AB9FWQt6OcQ; Tue, 19 Jan 2021 05:14:42 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B83FF4B3FA;
	Tue, 19 Jan 2021 05:14:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8400E4B3F1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Jan 2021 05:14:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FJ1N-ml8gG9A for <kvmarm@lists.cs.columbia.edu>;
 Tue, 19 Jan 2021 05:14:30 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 190DC4B3EF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 19 Jan 2021 05:14:30 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7188A23158;
 Tue, 19 Jan 2021 10:14:28 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l1o1q-008hdN-2m; Tue, 19 Jan 2021 10:14:26 +0000
MIME-Version: 1.0
Date: Tue, 19 Jan 2021 10:14:25 +0000
From: Marc Zyngier <maz@kernel.org>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 2/2] KVM: arm64: Workaround firmware wrongly
 advertising GICv2-on-v3 compatibility
In-Reply-To: <0edcab071c4845f29ec20af630777dce@huawei.com>
References: <20210115140323.2682634-1-maz@kernel.org>
 <20210115140323.2682634-3-maz@kernel.org>
 <CAMj1kXHEMpypq54Vxr+JgL9b_zoj_y2azK3mgAhXhnXO6Bhygw@mail.gmail.com>
 <67c2f61a5dd33731cf52b6e26095ed51@kernel.org>
 <0edcab071c4845f29ec20af630777dce@huawei.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <00f4bbd18e1eb55d028d5db6e4e1ddb6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shameerali.kolothum.thodi@huawei.com, ardb@kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm <kvmarm@lists.cs.columbia.edu>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Android Kernel Team <kernel-team@android.com>,
 Ard Biesheuvel <ardb@kernel.org>
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

On 2021-01-19 10:09, Shameerali Kolothum Thodi wrote:
>> -----Original Message-----
>> From: Marc Zyngier [mailto:maz@kernel.org]
>> Sent: 15 January 2021 14:15
>> To: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>; kvmarm
>> <kvmarm@lists.cs.columbia.edu>; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; James Morse
>> <james.morse@arm.com>; Julien Thierry <julien.thierry.kdev@gmail.com>;
>> Suzuki K Poulose <suzuki.poulose@arm.com>; Android Kernel Team
>> <kernel-team@android.com>
>> Subject: Re: [PATCH v2 2/2] KVM: arm64: Workaround firmware wrongly
>> advertising GICv2-on-v3 compatibility
>> 
>> On 2021-01-15 14:08, Ard Biesheuvel wrote:
>> > On Fri, 15 Jan 2021 at 15:03, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> [...]
>> 
>> >> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c
>> >> b/arch/arm64/kvm/vgic/vgic-v3.c index 8e7bf3151057..67b27b47312b
>> >> 100644
>> >> --- a/arch/arm64/kvm/vgic/vgic-v3.c
>> >> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
>> >> @@ -584,8 +584,10 @@ early_param("kvm-arm.vgic_v4_enable",
>> >> early_gicv4_enable);
>> >>  int vgic_v3_probe(const struct gic_kvm_info *info)  {
>> >>         u64 ich_vtr_el2 = kvm_call_hyp_ret(__vgic_v3_get_gic_config);
>> >> +       bool has_v2;
>> >>         int ret;
>> >>
>> >> +       has_v2 = ich_vtr_el2 >> 63;
>> >>         ich_vtr_el2 = (u32)ich_vtr_el2;
>> >>
>> >>         /*
>> >> @@ -605,13 +607,15 @@ int vgic_v3_probe(const struct gic_kvm_info
>> >> *info)
>> >>                          gicv4_enable ? "en" : "dis");
>> >>         }
>> >>
>> >> +       kvm_vgic_global_state.vcpu_base = 0;
>> >> +
>> >>         if (!info->vcpu.start) {
>> >>                 kvm_info("GICv3: no GICV resource entry\n");
>> >> -               kvm_vgic_global_state.vcpu_base = 0;
>> >> +       } else if (!has_v2) {
>> >> +               pr_warn("CPU interface incapable of MMIO access\n");
>> >
>> > Could we include FW_BUG here to stress that this is a firmware problem?
>> 
>> Absolutely! That's what it now looks like:
>> 
>> [    2.648452] kvm [1]: IPA Size Limit: 40 bits
>> [    2.649259] [Firmware Bug]: CPU interface incapable of MMIO access
>> [    2.649620] kvm [1]: disabling GICv2 emulation
>> [    2.650227] kvm [1]: GIC system register CPU interface enabled
>> [    2.652004] kvm [1]: vgic interrupt IRQ9
>> [    2.655623] kvm [1]: VHE mode initialized successfully
>> 
>> Updated version pushed out.
> 
> Is there a v3 for this series? I couldn't find one.

Nope, I didn't think it was useful to send another series for such
a minor change.

> 
> Anyways, tested this series on a D06 with faulty firmware and it is
> working as expected.
> FWIW,
> 
>    Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
