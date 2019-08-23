Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 723239B160
	for <lists+kvmarm@lfdr.de>; Fri, 23 Aug 2019 15:54:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E6CD94A601;
	Fri, 23 Aug 2019 09:54:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oIjyry16nU3M; Fri, 23 Aug 2019 09:54:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADEE34A5F8;
	Fri, 23 Aug 2019 09:54:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AC7F14A59D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Aug 2019 09:54:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdJ-bupd4OP9 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Aug 2019 09:54:40 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA02D4A597
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Aug 2019 09:54:40 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F60D28;
 Fri, 23 Aug 2019 06:54:40 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 895E63F718;
 Fri, 23 Aug 2019 06:54:39 -0700 (PDT)
Subject: Re: [PATCH v3] KVM: arm: VGIC: properly initialise private IRQ
 affinity
To: Andre Przywara <andre.przywara@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>
References: <20190823103416.110976-1-andre.przywara@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <bdb1426b-1c00-fce3-5e42-25c97d4311e1@arm.com>
Date: Fri, 23 Aug 2019 14:54:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823103416.110976-1-andre.przywara@arm.com>
Content-Language: en-US
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu
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

Hi Andre,

On 23/08/2019 11:34, Andre Przywara wrote:
> At the moment we initialise the target *mask* of a virtual IRQ to the
> VCPU it belongs to, even though this mask is only defined for GICv2 and
> quickly runs out of bits for many GICv3 guests.
> This behaviour triggers an UBSAN complaint for more than 32 VCPUs:
> ------
> [ 5659.462377] UBSAN: Undefined behaviour in virt/kvm/arm/vgic/vgic-init.c:223:21
> [ 5659.471689] shift exponent 32 is too large for 32-bit type 'unsigned int'
> ------
> Also for GICv3 guests the reporting of TARGET in the "vgic-state" debugfs
> dump is wrong, due to this very same problem.
> 
> Because there is no requirement to create the VGIC device before the
> VCPUs (and QEMU actually does it the other way round), we can't safely
> initialise mpidr or targets in kvm_vgic_vcpu_init(). But since we touch
> every private IRQ for each VCPU anyway later (in vgic_init()), we can
> just move the initialisation of those fields into there, where we
> definitely know the VGIC type.
> 
> On the way make sure we really have either a VGICv2 or a VGICv3 device,
> since the existing code is just checking for "VGICv3 or not", silently
> ignoring the uninitialised case.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Dave Martin <dave.martin@arm.com>

I have tested with both a combination of GICv2/GICv3 and kvmtools/QEMU. I can 
confirm the UBSAN warning is not present anymore. Feel free to add my tested-by:

Tested-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
