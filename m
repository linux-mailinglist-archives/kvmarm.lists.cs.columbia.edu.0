Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C8A889033C
	for <lists+kvmarm@lfdr.de>; Fri, 16 Aug 2019 15:39:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 168294A556;
	Fri, 16 Aug 2019 09:39:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfXXCBteqwPv; Fri, 16 Aug 2019 09:39:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CDBD94A55C;
	Fri, 16 Aug 2019 09:39:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 968734A556
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Aug 2019 09:39:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u1bPOhcKlFtR for <kvmarm@lists.cs.columbia.edu>;
 Fri, 16 Aug 2019 09:39:35 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 19A584A52B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 16 Aug 2019 09:39:35 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70720344;
 Fri, 16 Aug 2019 06:39:34 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738CA3F694;
 Fri, 16 Aug 2019 06:39:33 -0700 (PDT)
From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH] arm64/kvm: remove VMID rollover I-cache maintenance
To: Mark Rutland <mark.rutland@arm.com>
References: <20190806155737.39307-1-mark.rutland@arm.com>
Message-ID: <1dca0489-9e85-cb8f-b846-b6da65f41773@arm.com>
Date: Fri, 16 Aug 2019 14:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190806155737.39307-1-mark.rutland@arm.com>
Content-Language: en-GB
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Mark,

On 06/08/2019 16:57, Mark Rutland wrote:
> For VPIPT I-caches, we need I-cache maintenance on VMID rollover to
> avoid an ABA problem. Consider a single vCPU VM, with a pinned stage-2,
> running with an idmap VA->IPA and idmap IPA->PA. If we don't do
> maintenance on rollover:
> 
>         // VMID A
>         Writes insn X to PA 0xF
>         Invalidates PA 0xF (for VMID A)
> 
>         I$ contains [{A,F}->X]
> 
>         [VMID ROLLOVER]
> 
>         // VMID B
>         Writes insn Y to PA 0xF
>         Invalidates PA 0xF (for VMID B)
> 
>         I$ contains [{A,F}->X, {B,F}->Y]
> 
>         [VMID ROLLOVER]
> 
>         // VMID A
>         I$ contains [{A,F}->X, {B,F}->Y]
> 
>         Unexpectedly hits stale I$ line {A,F}->X.
> 
> However, for PIPT and VIPT I-caches, the VMID doesn't affect lookup or
> constrain maintenance. Given the VMID doesn't affect PIPT and VIPT
> I-caches, and given VMID rollover is independent of changes to stage-2
> mappings, I-cache maintenance cannot be necessary on VMID rollover for
> PIPT or VIPT I-caches.
> 
> This patch removes the maintenance on rollover for VIPT and PIPT
> I-caches. At the same time, the unnecessary colons are removed from the
> asm statement to make it more legible.

Makes sense!

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
