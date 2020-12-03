Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A4D3C2CDADB
	for <lists+kvmarm@lfdr.de>; Thu,  3 Dec 2020 17:09:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 18A194B1EF;
	Thu,  3 Dec 2020 11:09:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x-Ys1AqncS7G; Thu,  3 Dec 2020 11:09:54 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D429F4B1E0;
	Thu,  3 Dec 2020 11:09:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A3F534B1B0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 11:09:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJQRI3I2GmCB for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Dec 2020 11:09:51 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 756884B1DA
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 11:09:51 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F8311D4;
 Thu,  3 Dec 2020 08:09:50 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.87])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B4043F575;
 Thu,  3 Dec 2020 08:09:46 -0800 (PST)
Date: Thu, 3 Dec 2020 16:09:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v6 0/2] MTE support for KVM guest
Message-ID: <20201203160943.GG96754@C02TD0UTHF1T.local>
References: <20201127152113.13099-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201127152113.13099-1-steven.price@arm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Catalin Marinas <catalin.marinas@arm.com>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Fri, Nov 27, 2020 at 03:21:11PM +0000, Steven Price wrote:
> It's been a week, and I think the comments on v5 made it clear that
> enforcing PROT_MTE requirements on the VMM was probably the wrong
> approach. So since I've got swap working correctly without that I
> thought I'd post a v6 which hopefully addresses all the comments so far.
> 
> This series adds support for Arm's Memory Tagging Extension (MTE) to
> KVM, allowing KVM guests to make use of it. This builds on the existing
> user space support already in v5.10-rc4, see [1] for an overview.

>  arch/arm64/include/asm/kvm_emulate.h       |  3 +++
>  arch/arm64/include/asm/kvm_host.h          |  8 ++++++++
>  arch/arm64/include/asm/pgtable.h           |  2 +-
>  arch/arm64/include/asm/sysreg.h            |  3 ++-
>  arch/arm64/kernel/mte.c                    | 18 +++++++++++++-----
>  arch/arm64/kvm/arm.c                       |  9 +++++++++
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>  arch/arm64/kvm/mmu.c                       | 16 ++++++++++++++++
>  arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
>  include/uapi/linux/kvm.h                   |  1 +
>  10 files changed, 82 insertions(+), 12 deletions(-)

I note that doesn't fixup arch/arm64/kvm/inject_fault.c, where in
enter_exception64() we have:

| // TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)

... and IIUC when MTE is present, TCO should be set when delivering an
exception, so I believe that needs to be updated to set TCO.

Given that MTE-capable HW does that unconditionally, this is going to be
a mess for big.LITTLE. :/

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
