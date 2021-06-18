Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3403ACDD4
	for <lists+kvmarm@lfdr.de>; Fri, 18 Jun 2021 16:47:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A2A7A4B091;
	Fri, 18 Jun 2021 10:47:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPysmj0Wxcvh; Fri, 18 Jun 2021 10:47:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AFD8949F82;
	Fri, 18 Jun 2021 10:47:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E3854048A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 10:47:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6qmEgJmtzppa for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Jun 2021 10:47:14 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2139140463
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Jun 2021 10:47:14 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EB796008E;
 Fri, 18 Jun 2021 14:47:10 +0000 (UTC)
Date: Fri, 18 Jun 2021 15:47:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v16 3/7] KVM: arm64: Introduce MTE VM feature
Message-ID: <20210618144707.GF16116@arm.com>
References: <20210618132826.54670-1-steven.price@arm.com>
 <20210618132826.54670-4-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210618132826.54670-4-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
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

On Fri, Jun 18, 2021 at 02:28:22PM +0100, Steven Price wrote:
> Add a new VM feature 'KVM_ARM_CAP_MTE' which enables memory tagging
> for a VM. This will expose the feature to the guest and automatically
> tag memory pages touched by the VM as PG_mte_tagged (and clear the tag
> storage) to ensure that the guest cannot see stale tags, and so that
> the tags are correctly saved/restored across swap.
> 
> Actually exposing the new capability to user space happens in a later
> patch.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

This works for me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
