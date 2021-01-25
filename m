Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 642723024C6
	for <lists+kvmarm@lfdr.de>; Mon, 25 Jan 2021 13:20:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C5D954B5E1;
	Mon, 25 Jan 2021 07:19:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pO6m1p990A7N; Mon, 25 Jan 2021 07:19:59 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 944474B5DF;
	Mon, 25 Jan 2021 07:19:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EF2604B5C3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 07:19:56 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j4SzgNGuZe87 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Jan 2021 07:19:55 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CD2BA4B5A4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 07:19:55 -0500 (EST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8C41229C6;
 Mon, 25 Jan 2021 12:19:51 +0000 (UTC)
Date: Mon, 25 Jan 2021 12:19:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 10/21] arm64: cpufeature: Use IDreg override in
 __read_sysreg_by_encoding()
Message-ID: <20210125121948.GF25360@gaia>
References: <20210125105019.2946057-1-maz@kernel.org>
 <20210125105019.2946057-11-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210125105019.2946057-11-maz@kernel.org>
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

On Mon, Jan 25, 2021 at 10:50:08AM +0000, Marc Zyngier wrote:
> __read_sysreg_by_encoding() is used by a bunch of cpufeature helpers,
> which should take the feature override into account. Let's do that.
> 
> For a good measure (and because we are likely to need to further
> down the line), make this helper available to the rest of the
> non-modular kernel.
> 
> Code that needs to know the *real* features of a CPU can still
> use read_sysreg_s(), and find the bare, ugly truth.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Acked-by: David Brazdil <dbrazdil@google.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
