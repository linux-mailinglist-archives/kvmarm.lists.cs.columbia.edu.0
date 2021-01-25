Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 959393024BA
	for <lists+kvmarm@lfdr.de>; Mon, 25 Jan 2021 13:13:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 485DA4B5FF;
	Mon, 25 Jan 2021 07:13:50 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SKUtnRKFWB61; Mon, 25 Jan 2021 07:13:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 35C114B5F2;
	Mon, 25 Jan 2021 07:13:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C33A14B5E7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 07:13:48 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8wx1ulWveYb for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Jan 2021 07:13:47 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DE9694B5DC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 07:13:47 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 447BE22C9E;
 Mon, 25 Jan 2021 12:13:44 +0000 (UTC)
Date: Mon, 25 Jan 2021 12:13:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 05/21] arm64: Initialise as nVHE before switching to VHE
Message-ID: <20210125121341.GB25360@gaia>
References: <20210125105019.2946057-1-maz@kernel.org>
 <20210125105019.2946057-6-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210125105019.2946057-6-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Prasad Sodagudi <psodagud@codeaurora.org>,
 Srinivas Ramana <sramana@codeaurora.org>, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Ajay Patil <pajay@qti.qualcomm.com>,
 kernel-team@android.com, Will Deacon <will@kernel.org>,
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

On Mon, Jan 25, 2021 at 10:50:03AM +0000, Marc Zyngier wrote:
> As we are aiming to be able to control whether we enable VHE or
> not, let's always drop down to EL1 first, and only then upgrade
> to VHE if at all possible.
> 
> This means that if the kernel is booted at EL2, we always start
> with a nVHE init, drop to EL1 to initialise the the kernel, and
> only then upgrade the kernel EL to EL2 if possible (the process
> is obviously shortened for secondary CPUs).
> 
> The resume path is handled similarly to a secondary CPU boot.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Acked-by: David Brazdil <dbrazdil@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
