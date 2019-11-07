Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50CF352B
	for <lists+kvmarm@lfdr.de>; Thu,  7 Nov 2019 17:56:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E3FA74ACA0;
	Thu,  7 Nov 2019 11:56:41 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wunkK9o8lijs; Thu,  7 Nov 2019 11:56:41 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF47F4AC95;
	Thu,  7 Nov 2019 11:56:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6745F4A98A
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Nov 2019 11:56:39 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wBnp0FPkFDee for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 Nov 2019 11:56:38 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 36B9B4A94E
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 Nov 2019 11:56:38 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97CB31B;
 Thu,  7 Nov 2019 08:56:37 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.145.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C3873F719;
 Thu,  7 Nov 2019 08:56:37 -0800 (PST)
Date: Thu, 7 Nov 2019 17:56:36 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 0/2] KVM: arm64: Reduce occurence of GICv4 doorbells on
 non-oversubscribed systems
Message-ID: <20191107165636.GB17608@e113682-lin.lund.arm.com>
References: <20191107160412.30301-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191107160412.30301-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
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

On Thu, Nov 07, 2019 at 04:04:10PM +0000, Marc Zyngier wrote:
> As I was cleaning up some of the GICv4 code to make way for GICv4.1 it
> occured to me that we could drastically reduce the impact of the GICv4
> doorbells on systems that are not oversubscribed (each vcpu "owns" a
> physical CPU).
> 
> The technique borrows its logic from the way we disable WFE trapping
> when a vcpu is the only process on the CPU run-queue. If this vcpu is
> the target of VLPIs, it is then beneficial not to trap blocking WFIs
> and to leave the vcpu waiting for interrupts in guest state.
> 
> All we need to do here is to track whether VLPIs are associated to a
> vcpu (which is easily done by using a counter that we update on MAPI,
> DISCARD and MOVI).
> 
> It has been *very lightly* tested on a D05, and behaved pretty well in
> my limited test cases (I get almost no doorbell at all in the non
> oversubscribed case, and the usual hailstorm as soon as there is
> oversubscription). I'd welcome some testing on more current HW.
> 
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
