Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6AD2C6972
	for <lists+kvmarm@lfdr.de>; Fri, 27 Nov 2020 17:33:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8F6974B53A;
	Fri, 27 Nov 2020 11:33:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g+uosLKL8Vpd; Fri, 27 Nov 2020 11:33:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 49EB34BEC0;
	Fri, 27 Nov 2020 11:33:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A90E54B2AA
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Nov 2020 11:33:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9dY6TILkOeM for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Nov 2020 11:33:04 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 76C3D4B29D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Nov 2020 11:33:04 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB72C1516;
 Fri, 27 Nov 2020 08:33:03 -0800 (PST)
Received: from bogus (unknown [10.57.59.53])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 373573F71F;
 Fri, 27 Nov 2020 08:33:00 -0800 (PST)
Date: Fri, 27 Nov 2020 16:32:54 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v3 06/23] kvm: arm64: Add kvm-arm.protected early kernel
 parameter
Message-ID: <20201127163254.zxdrszlveaxhluwn@bogus>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-7-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-7-dbrazdil@google.com>
User-Agent: NeoMutt/20171215
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
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

On Thu, Nov 26, 2020 at 03:54:04PM +0000, David Brazdil wrote:
> Add an early parameter that allows users to opt into protected KVM mode
> when using the nVHE hypervisor. In this mode, guest state will be kept
> private from the host. This will primarily involve enabling stage-2
> address translation for the host, restricting DMA to host memory, and
> filtering host SMCs.
> 
> Capability ARM64_PROTECTED_KVM is set if the param is passed, CONFIG_KVM
> is enabled and the kernel was not booted with VHE.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 ++++
>  arch/arm64/include/asm/cpucaps.h              |  3 +-
>  arch/arm64/include/asm/virt.h                 |  8 +++++
>  arch/arm64/kernel/cpufeature.c                | 29 +++++++++++++++++++
>  arch/arm64/kvm/arm.c                          |  4 ++-
>  5 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 526d65d8573a..06c89975c29c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2259,6 +2259,11 @@
>  			for all guests.
>  			Default is 1 (enabled) if in 64-bit or 32-bit PAE mode.
>  
> +	kvm-arm.protected=
> +			[KVM,ARM] Allow spawning protected guests whose state
> +			is kept private from the host. Only valid for non-VHE.
> +			Default is 0 (disabled).
> +

Sorry for being pedantic. Can we reword this to say valid for
!CONFIG_ARM64_VHE ? I read this as valid only for non-VHE hardware, it may
be just me, but if you agree please update so that it doesn't give remote
idea that it is not valid on VHE enabled hardware.

I was trying to run this on the hardware and was trying to understand the
details on how to do that.

-- 
Regards,
Sudeep
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
