Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD6639A67A
	for <lists+kvmarm@lfdr.de>; Thu,  3 Jun 2021 18:58:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 723BB4B114;
	Thu,  3 Jun 2021 12:58:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mORMqowrGVzR; Thu,  3 Jun 2021 12:58:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 294934B111;
	Thu,  3 Jun 2021 12:58:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6C5144B0AC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 12:58:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gs0aGTYBwnNy for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Jun 2021 12:58:47 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E5DD9407ED
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Jun 2021 12:58:46 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E671B61159;
 Thu,  3 Jun 2021 16:58:42 +0000 (UTC)
Date: Thu, 3 Jun 2021 17:58:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v13 6/8] KVM: arm64: Expose KVM_ARM_CAP_MTE
Message-ID: <20210603165840.GG20338@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
 <20210524104513.13258-7-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210524104513.13258-7-steven.price@arm.com>
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

On Mon, May 24, 2021 at 11:45:11AM +0100, Steven Price wrote:
> It's now safe for the VMM to enable MTE in a guest, so expose the
> capability to user space.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
