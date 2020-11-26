Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1B742C5B7D
	for <lists+kvmarm@lfdr.de>; Thu, 26 Nov 2020 19:06:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3B3ED4B828;
	Thu, 26 Nov 2020 13:06:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wbgp-xGfnOwG; Thu, 26 Nov 2020 13:06:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 02D554B5CC;
	Thu, 26 Nov 2020 13:06:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BCB424B55F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 13:06:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qKNjSKNvMjFC for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Nov 2020 13:06:15 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 944E34B555
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Nov 2020 13:06:15 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C69831B;
 Thu, 26 Nov 2020 10:06:15 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.234])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F2F63F23F;
 Thu, 26 Nov 2020 10:06:11 -0800 (PST)
Date: Thu, 26 Nov 2020 18:06:08 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v3 05/23] arm64: Extract parts of el2_setup into a macro
Message-ID: <20201126180608.GF38486@C02TD0UTHF1T.local>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-6-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-6-dbrazdil@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
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

On Thu, Nov 26, 2020 at 03:54:03PM +0000, David Brazdil wrote:
> When the a CPU is booted in EL2, the kernel checks for VHE support and
> initializes the CPU core accordingly. For nVHE it also installs the stub
> vectors and drops down to EL1.
> 
> Once KVM gains the ability to boot cores without going through the
> kernel entry point, it will need to initialize the CPU the same way.
> Extract the relevant bits of el2_setup into an init_el2_state macro
> with an argument specifying whether to initialize for VHE or nVHE.
> 
> No functional change. Size of el2_setup increased by 148 bytes due
> to duplication.

As a heads-up, this will conflict with my rework which is queued in the
arm64 for-next/uaccess branch. I reworked an renamed el2_setup to
initialize SCTLR_ELx and PSTATE more consistently as a prerequisite for
the set_fs() removal.

I'm afraid this is going to conflict, and I reckon this needs to be
rebased atop that. I think the actual conflicts are logically trivial,
but the diff is going to be painful.

I'm certainly in favour of breaking this down into manageable chunks,
especially as that makes the branch naming easier to follow, but I have
a couple of concerns below.

> +/* GICv3 system register access */
> +.macro __init_el2_gicv3
> +	mrs	x0, id_aa64pfr0_el1
> +	ubfx	x0, x0, #ID_AA64PFR0_GIC_SHIFT, #4
> +	cbz	x0, 1f
> +
> +	mrs_s	x0, SYS_ICC_SRE_EL2
> +	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
> +	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
> +	msr_s	SYS_ICC_SRE_EL2, x0
> +	isb					// Make sure SRE is now set
> +	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
> +	tbz	x0, #0, 1f			// and check that it sticks
> +	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
> +1:
> +.endm

In the head.S code, this was under an ifdef CONFIG_ARM_GIC_V3, but that
ifdef wasn't carried into the macro here, or into its use below. I'm not
sure of the impact, but that does seem to be a functional change.

> +
> +.macro __init_el2_hstr
> +	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
> +.endm

Likewise, this used to be be guarded by CONFIG_COMPAT, but that's not
carried into the macro or its use.

If the intent was to remove the conditionality, then that should be
mentioned in the commit message, since it is a potential functional
change.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
