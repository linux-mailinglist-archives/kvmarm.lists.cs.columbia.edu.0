Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF857E034
	for <lists+kvmarm@lfdr.de>; Fri, 22 Jul 2022 12:48:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 943E44C81D;
	Fri, 22 Jul 2022 06:48:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GSVyYEZEHyBN; Fri, 22 Jul 2022 06:48:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 21A1D4C833;
	Fri, 22 Jul 2022 06:48:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 56DF54C797
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Jul 2022 06:48:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pi-VxlhrCgWR for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 Jul 2022 06:48:36 -0400 (EDT)
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2396C4C3C1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 Jul 2022 06:48:36 -0400 (EDT)
Date: Fri, 22 Jul 2022 11:48:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1658486914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0AyQqMWkq3QK3cl0AVPhmS1VRFhKVJORRDR1qEdQa2E=;
 b=xicOKB6Owxf662WLaEHk73CJEtDiVVJlzZYlCwcm2/Diwz0HTpzvGaebKIShQmRpj0iZR1
 G0JoITMh43Aju/9To6bjbUkmSVnwtTN0+CxPKbszZa19YuGHmQBj+QkAqOzApPVL6H6VZH
 n38wfKDStIPrL8+wxF39Kgji85DhFrU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v5 00/17] KVM nVHE Hypervisor stack unwinder
Message-ID: <YtqAf0e7Tc7qu5/c@google.com>
References: <20220721055728.718573-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: wangkefeng.wang@huawei.com, catalin.marinas@arm.com, elver@google.com,
 vincenzo.frascino@arm.com, will@kernel.org, android-mm@google.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, madvenka@linux.microsoft.com,
 kernel-team@android.com, drjones@redhat.com, ast@kernel.org,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org, andreyknvl@gmail.com,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org
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

Hi Kalesh,

On Wed, Jul 20, 2022 at 10:57:11PM -0700, Kalesh Singh wrote:

[...]

> Kalesh Singh (17):
>   arm64: stacktrace: Add shared header for common stack unwinding code
>   arm64: stacktrace: Factor out on_accessible_stack_common()
>   arm64: stacktrace: Factor out unwind_next_common()
>   arm64: stacktrace: Handle frame pointer from different address spaces
>   arm64: stacktrace: Factor out common unwind()
>   arm64: stacktrace: Add description of stacktrace/common.h
>   KVM: arm64: On stack overflow switch to hyp overflow_stack
>   KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
>   KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
>   KVM: arm64: Stub implementation of pKVM HYP stack unwinder
>   KVM: arm64: Stub implementation of non-protected nVHE HYP stack
>     unwinder
>   KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
>   KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
>   KVM: arm64: Implement protected nVHE hyp stack unwinder
>   KVM: arm64: Implement non-protected nVHE hyp stack unwinder
>   KVM: arm64: Introduce pkvm_dump_backtrace()
>   KVM: arm64: Introduce hyp_dump_backtrace()

Adding a general comment on the organization of the series. I think for
the next spin it'd be good to organize the entire non-pKVM
implementation first, followed by the pKVM implementation. Otherwise,
reviewers need to jump around the series a lot in order to page in the
appropriate context.

I had mentioned this about the last two patches earlier, but after
grokking the stack I see the comment applies to the entire KVM portion
of the series.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
