Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C34D6E51
	for <lists+kvmarm@lfdr.de>; Sat, 12 Mar 2022 12:09:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A5CA49EF1;
	Sat, 12 Mar 2022 06:09:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XWzMNi3dBA1x; Sat, 12 Mar 2022 06:09:45 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3109049EE7;
	Sat, 12 Mar 2022 06:09:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 07AE349ED9
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Mar 2022 06:09:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQZHH-HJr1xR for <kvmarm@lists.cs.columbia.edu>;
 Sat, 12 Mar 2022 06:09:41 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DF82A49EC2
 for <kvmarm@lists.cs.columbia.edu>; Sat, 12 Mar 2022 06:09:41 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B308B60C86;
 Sat, 12 Mar 2022 11:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFFEC340ED;
 Sat, 12 Mar 2022 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1647083377;
 bh=8BokdGzOAWwWQgKSNC+skWkkbkqD0MizSG1M3NoCd7E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZBEtiBGspieZnU8crI49xWKmqXIFFfqOEe6yFygfnpQK+NJ6UOqN9IWae8m72EW5R
 9rViKhBtjuXzbTJ+ArJeYLchLJq9JNgDNV1xj2X3WHNVViWOHuM+xP6Kx+7ICER4aQ
 8wyzdGTPtZHas8ccNnQycXxH/lIYhYFJ2ib0m5OE=
Date: Sat, 12 Mar 2022 12:09:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: James Morse <james.morse@arm.com>
Subject: Re: [stable:PATCH] KVM: arm64: Reset PMC_EL0 to avoid a panic() on
 systems with no PMU
Message-ID: <Yix/bcdSsMGvY/aw@kroah.com>
References: <20220308162939.603335-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220308162939.603335-1-james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
 stable@vger.kernel.org
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

On Tue, Mar 08, 2022 at 04:29:39PM +0000, James Morse wrote:
> The logic in commit 2a5f1b67ec57 "KVM: arm64: Don't access PMCR_EL0 when no
> PMU is available" relies on an empty reset handler being benign.  This was
> not the case in earlier kernel versions, so the stable backport of this
> patch is causing problems.
> 
> KVMs behaviour in this area changed over time. In particular, prior to commit
> 03fdfb269009 ("KVM: arm64: Don't write junk to sysregs on reset"), an empty
> reset handler will trigger a warning, as the guest registers have been
> poisoned.
> Prior to commit 20589c8cc47d ("arm/arm64: KVM: Don't panic on failure to
> properly reset system registers"), this warning was a panic().
> 
> Instead of reverting the backport, make it write 0 to the sys_reg[] array.
> This keeps the reset logic happy, and the dodgy value can't be seen by
> the guest as it can't request the emulation.
> 
> The original bug was accessing the PMCR_EL0 register on CPUs that don't
> implement that feature. There is no known silicon that does this, but
> v4.9's ACPI support is unable to find the PMU, so triggers this code:
> 
> | Kernel panic - not syncing: Didn't reset vcpu_sys_reg(24)
> | CPU: 1 PID: 3055 Comm: lkvm Not tainted 4.9.302-00032-g64e078a56789 #13476
> | Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jul 30 2018
> | Call trace:
> | [<ffff00000808b4b0>] dump_backtrace+0x0/0x1a0
> | [<ffff00000808b664>] show_stack+0x14/0x20
> | [<ffff0000088f0e18>] dump_stack+0x98/0xb8
> | [<ffff0000088eef08>] panic+0x118/0x274
> | [<ffff0000080b50e0>] access_actlr+0x0/0x20
> | [<ffff0000080b2620>] kvm_reset_vcpu+0x5c/0xac
> | [<ffff0000080ac688>] kvm_arch_vcpu_ioctl+0x3e4/0x490
> | [<ffff0000080a382c>] kvm_vcpu_ioctl+0x5b8/0x720
> | [<ffff000008201e44>] do_vfs_ioctl+0x2f4/0x884
> | [<ffff00000820244c>] SyS_ioctl+0x78/0x9c
> | [<ffff000008083a9c>] __sys_trace_return+0x0/0x4
> 
> Cc: <stable@vger.kernel.org> # < v5.3 with 2a5f1b67ec57 backported
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Now queued up for 4.9, 4.14, and 4.19 kernels, thanks!

greg k-h
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
