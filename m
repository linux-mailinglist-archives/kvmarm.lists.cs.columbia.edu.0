Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 842012EAB26
	for <lists+kvmarm@lfdr.de>; Tue,  5 Jan 2021 13:48:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05F3C4B11F;
	Tue,  5 Jan 2021 07:48:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 82tcA8i4I4Bp; Tue,  5 Jan 2021 07:48:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 55D5C4B2FC;
	Tue,  5 Jan 2021 07:48:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AC174B29B
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 07:48:52 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m+xI6fRbT8o8 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  5 Jan 2021 07:48:48 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B9F2F4B11F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  5 Jan 2021 07:48:48 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B34E229C5;
 Tue,  5 Jan 2021 12:48:46 +0000 (UTC)
Date: Tue, 5 Jan 2021 12:48:43 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Shannon Zhao <shannon.zhao@linux.alibaba.com>
Subject: Re: [PATCH] arm64: cpufeature: remove non-exist CONFIG_KVM_ARM_HOST
Message-ID: <20210105124843.GC11802@gaia>
References: <1609760324-92271-1-git-send-email-shannon.zhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1609760324-92271-1-git-send-email-shannon.zhao@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: maz@kernel.org, anshuman.khandual@arm.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Jan 04, 2021 at 07:38:44PM +0800, Shannon Zhao wrote:
> Commit d82755b2e781 ("KVM: arm64: Kill off CONFIG_KVM_ARM_HOST") deletes
> CONFIG_KVM_ARM_HOST option, it should use CONFIG_KVM instead.
> 
> Just remove CONFIG_KVM_ARM_HOST here.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
