Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9B1C9670
	for <lists+kvmarm@lfdr.de>; Thu,  7 May 2020 18:26:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 98D9F4B3EB;
	Thu,  7 May 2020 12:26:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VYXRZX3Zn4g5; Thu,  7 May 2020 12:26:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6D2C34B3D8;
	Thu,  7 May 2020 12:26:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CBAA14B3CE
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 12:26:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SQDskhUngtlG for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 May 2020 12:26:10 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 810544B323
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 12:26:10 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4B21FB;
 Thu,  7 May 2020 09:26:10 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0701C3F71F;
 Thu,  7 May 2020 09:26:07 -0700 (PDT)
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 09/26] KVM: arm64: vgic-v3: Take cpu_if pointer directly
 instead of vcpu
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
References: <20200422120050.3693593-1-maz@kernel.org>
 <20200422120050.3693593-10-maz@kernel.org>
Message-ID: <3174eaad-7d8d-0c52-d71c-afc6b991b636@arm.com>
Date: Thu, 7 May 2020 17:26:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200422120050.3693593-10-maz@kernel.org>
Content-Language: en-GB
Cc: kvm@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, Will Deacon <will@kernel.org>,
 George Cherian <gcherian@marvell.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Hi Marc, Christoffer,

On 22/04/2020 13:00, Marc Zyngier wrote:
> From: Christoffer Dall <christoffer.dall@arm.com>
> 
> If we move the used_lrs field to the version-specific cpu interface
> structure, the following functions only operate on the struct
> vgic_v3_cpu_if and not the full vcpu:
> 
>   __vgic_v3_save_state
>   __vgic_v3_restore_state
>   __vgic_v3_activate_traps
>   __vgic_v3_deactivate_traps
>   __vgic_v3_save_aprs
>   __vgic_v3_restore_aprs
> 
> This is going to be very useful for nested virt, 

... because you don't need to consider whether the vcpu is running in vEL2?


> so move the used_lrs
> field and change the prototypes and implementations of these functions to
> take the cpu_if parameter directly.


> No functional change.

Looks like no change!

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
