Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F12007C6
	for <lists+kvmarm@lfdr.de>; Fri, 19 Jun 2020 13:29:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 73CF04B15B;
	Fri, 19 Jun 2020 07:29:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hiM3IPcedGGZ; Fri, 19 Jun 2020 07:29:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AAD64B0D4;
	Fri, 19 Jun 2020 07:29:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8FF244B0C2
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Jun 2020 07:29:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5AA1aVsY9Xx5 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 19 Jun 2020 07:29:24 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A4A94B0B4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 19 Jun 2020 07:29:24 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15641101E;
 Fri, 19 Jun 2020 04:29:24 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA7FA3F6CF;
 Fri, 19 Jun 2020 04:29:22 -0700 (PDT)
Subject: Re: [PATCH] arm64: kvm: Annotate hyp NMI-related functions as
 __always_inline
To: Alexandru Elisei <alexandru.elisei@arm.com>, kvm@vger.kernel.org
References: <20200618171254.1596055-1-alexandru.elisei@arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <0236ea68-ec6a-44e6-97e3-eee05de9476c@arm.com>
Date: Fri, 19 Jun 2020 12:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200618171254.1596055-1-alexandru.elisei@arm.com>
Content-Language: en-GB
Cc: maz@kernel.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu
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

Hi Alex,

On 18/06/2020 18:12, Alexandru Elisei wrote:
> The "inline" keyword is a hint for the compiler to inline a function.  The
> functions system_uses_irq_prio_masking() and gic_write_pmr() are used by
> the code running at EL2 on a non-VHE system, so mark them as
> __always_inline to make sure they'll always be part of the .hyp.text
> section.
> 
> This fixes the following splat when trying to run a VM:
> 
> [   47.625273] Kernel panic - not syncing: HYP panic:

> The instruction abort was caused by the code running at EL2 trying to fetch
> an instruction which wasn't mapped in the EL2 translation tables. Using
> objdump showed the two functions as separate symbols in the .text section.

Bother. Looks like I didn't have CONFIG_ARM64_PSEUDO_NMI enabled when I went looking for
these!

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
