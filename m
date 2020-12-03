Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D92CD408
	for <lists+kvmarm@lfdr.de>; Thu,  3 Dec 2020 11:55:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1355A4B1AE;
	Thu,  3 Dec 2020 05:55:21 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5DROH1P2zk0; Thu,  3 Dec 2020 05:55:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E32A94B1FB;
	Thu,  3 Dec 2020 05:55:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C24C74B1AE
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 05:55:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RR6KiFXF7vFh for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Dec 2020 05:55:16 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EC5F4B181
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Dec 2020 05:55:16 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD0F113E;
 Thu,  3 Dec 2020 02:55:15 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.87])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 129CC3F66B;
 Thu,  3 Dec 2020 02:55:11 -0800 (PST)
Date: Thu, 3 Dec 2020 10:55:09 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v4 16/26] kvm: arm64: Bootstrap PSCI SMC handler in nVHE
 EL2
Message-ID: <20201203105509.GD96754@C02TD0UTHF1T.local>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <20201202184122.26046-17-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201202184122.26046-17-dbrazdil@google.com>
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

On Wed, Dec 02, 2020 at 06:41:12PM +0000, David Brazdil wrote:
> Add a handler of PSCI SMCs in nVHE hyp code. The handler is initialized
> with the version used by the host's PSCI driver and the function IDs it
> was configured with. If the SMC function ID matches one of the
> configured PSCI calls (for v0.1) or falls into the PSCI function ID
> range (for v0.2+), the SMC is handled by the PSCI handler. For now, all
> SMCs return PSCI_RET_NOT_SUPPORTED.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

> +static bool is_psci_0_1_call(u64 func_id)
> +{
> +	return (func_id == kvm_host_psci_0_1_function_ids.cpu_suspend) ||
> +	       (func_id == kvm_host_psci_0_1_function_ids.cpu_on) ||
> +	       (func_id == kvm_host_psci_0_1_function_ids.cpu_off) ||
> +	       (func_id == kvm_host_psci_0_1_function_ids.migrate);
> +}

One minor thing, as I just spotted on an earlier patch: if FW doesn't
implement one of these, the ID will be 0, so we might need to snapshot
whether or not the function is enabled to stop spurious calls to FID 0.

To be clear, that can be done in a follow-up if necessary.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
