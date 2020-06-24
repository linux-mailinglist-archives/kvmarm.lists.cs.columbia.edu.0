Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 702E920702C
	for <lists+kvmarm@lfdr.de>; Wed, 24 Jun 2020 11:38:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E16AD4B185;
	Wed, 24 Jun 2020 05:38:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rlk5d0+FKNqf; Wed, 24 Jun 2020 05:38:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C4E0B4B158;
	Wed, 24 Jun 2020 05:38:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F20C4B14A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Jun 2020 05:38:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jyhZp7IWDDlX for <kvmarm@lists.cs.columbia.edu>;
 Wed, 24 Jun 2020 05:38:52 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CC3F4B149
 for <kvmarm@lists.cs.columbia.edu>; Wed, 24 Jun 2020 05:38:52 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD8111FB;
 Wed, 24 Jun 2020 02:38:51 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A463F73C;
 Wed, 24 Jun 2020 02:38:50 -0700 (PDT)
Date: Wed, 24 Jun 2020 10:38:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
Message-ID: <20200624093846.GA11863@gaia>
References: <20200617123844.29960-1-steven.price@arm.com>
 <CAFEAcA8Myn_QEjfk4Ka604PDAUAWXs6dLUY5bEQ98C__oMsmhA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Myn_QEjfk4Ka604PDAUAWXs6dLUY5bEQ98C__oMsmhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Price <steven.price@arm.com>, kvmarm@lists.cs.columbia.edu,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jun 23, 2020 at 07:05:07PM +0100, Peter Maydell wrote:
> On Wed, 17 Jun 2020 at 13:39, Steven Price <steven.price@arm.com> wrote:
> > These patches add support to KVM to enable MTE within a guest. It is
> > based on Catalin's v4 MTE user space series[1].
> >
> > [1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com
> >
> > Posting as an RFC as I'd like feedback on the approach taken.
> 
> What's your plan for handling tags across VM migration?
> Will the kernel expose the tag ram to userspace so we
> can copy it from the source machine to the destination
> at the same time as we copy the actual ram contents ?

Qemu can map the guest memory with PROT_MTE and access the tags directly
with LDG/STG instructions. Steven was actually asking in the cover
letter whether we should require that the VMM maps the guest memory with
PROT_MTE as a guarantee that it can access the guest tags.

There is no architecturally visible tag ram (tag storage), that's a
microarchitecture detail.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
