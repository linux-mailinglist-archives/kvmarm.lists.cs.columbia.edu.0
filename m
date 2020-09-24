Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE6276E48
	for <lists+kvmarm@lfdr.de>; Thu, 24 Sep 2020 12:11:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EA9D4B337;
	Thu, 24 Sep 2020 06:11:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GoiBU-THRd7u; Thu, 24 Sep 2020 06:11:01 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CDC04B335;
	Thu, 24 Sep 2020 06:11:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 376C34B234
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 06:10:59 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k50XRTIan2Fn for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Sep 2020 06:10:58 -0400 (EDT)
Received: from gentwo.org (gentwo.org [3.19.106.255])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3403E4B230
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Sep 2020 06:10:58 -0400 (EDT)
Received: by gentwo.org (Postfix, from userid 1002)
 id D7A6C3F1AE; Thu, 24 Sep 2020 10:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by gentwo.org (Postfix) with ESMTP id D4FD23F1AA;
 Thu, 24 Sep 2020 10:10:52 +0000 (UTC)
Date: Thu, 24 Sep 2020 10:10:52 +0000 (UTC)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH v4 00/10] Independent per-CPU data section for nVHE
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
Message-ID: <alpine.DEB.2.22.394.2009241003100.1613@www.lameter.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Tejun Heo <tj@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Will Deacon <will@kernel.org>,
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

On Tue, 22 Sep 2020, David Brazdil wrote:

> Introduce '.hyp.data..percpu' as part of ongoing effort to make nVHE
> hyp code self-contained and independent of the rest of the kernel.

The percpu subsystems point is to enable the use of special hardware
instructions that can perform address calculation and a memory operation
in one interruptible instruction. This is in particular useful to avoid
higher overhead for memory management related counters because preempt
disable/enable etc can be avoided.

ARM cannot do that and thus has a LC/SC loop.

This is a patchset for ARM64 so its not clear to me what kind of advantage
there would be against a simple implementation that does a regular fetch
from a base address with an offset.

> Main benefits:
>  * independent nVHE per-CPU data section that can be unmapped from host,
>  * more robust linking of nVHE hyp code,
>  * no need for hyp-specific macros to access per-CPU variables.

Maybe simply don't use percpu variables for your arm code? Those pointers
to data will be much more indepedent of the rest of the kernel and allow a
much higher degree of being self-contained.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
