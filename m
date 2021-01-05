Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC1F2EAB3A
	for <lists+kvmarm@lfdr.de>; Tue,  5 Jan 2021 13:52:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E58214B30B;
	Tue,  5 Jan 2021 07:52:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fj7X7dyvbKZK; Tue,  5 Jan 2021 07:52:28 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D48824B2F3;
	Tue,  5 Jan 2021 07:52:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 911684B1A4
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 07:52:26 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wXk1ao7s8AIp for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Jan 2021 07:52:25 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A82F84B19F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 07:52:25 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C31922AAA;
 Tue,  5 Jan 2021 12:52:22 +0000 (UTC)
Date: Tue, 5 Jan 2021 12:52:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64: Fix labels in el2_setup macros
Message-ID: <20210105125220.GD11802@gaia>
References: <20201223121131.255551-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201223121131.255551-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

On Wed, Dec 23, 2020 at 12:11:31PM +0000, Marc Zyngier wrote:
> If someone happens to write the following code:
> 
> 	b	1f
> 	init_el2_state	vhe
> 1:
> 	[...]
> 
> they will be in for a long debugging session, as the label "1f"
> will be resolved *inside* the init_el2_state macro instead of
> after it. Not really what one expects.
> 
> Instead, rewite the EL2 setup macros to use unambiguous labels,
> thanks to the usual macro counter trick.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/el2_setup.h | 24 ++++++++++++------------

In case you need an ack:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
