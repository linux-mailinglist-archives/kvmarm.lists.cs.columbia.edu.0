Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C043B347D3
	for <lists+kvmarm@lfdr.de>; Tue,  4 Jun 2019 15:16:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DD9B4A502;
	Tue,  4 Jun 2019 09:16:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FfW2LdQCfGAk; Tue,  4 Jun 2019 09:16:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 12F554A4F8;
	Tue,  4 Jun 2019 09:16:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F8844A4A9
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 09:16:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WEB7RCK+U1ew for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Jun 2019 09:16:14 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D266F4A49C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Jun 2019 09:16:14 -0400 (EDT)
Received: from oasis.local.home (unknown [146.247.46.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 120BA2484F;
 Tue,  4 Jun 2019 13:16:11 +0000 (UTC)
Date: Tue, 4 Jun 2019 09:16:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: KVM Arm Device passthrough and linux-rt
Message-ID: <20190604091607.2e87eb36@oasis.local.home>
In-Reply-To: <26832850-37ee-ae07-08ca-cc3e90978867@arm.com>
References: <26832850-37ee-ae07-08ca-cc3e90978867@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, julia@ni.com,
 Marc Zyngier <marc.zyngier@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue, 4 Jun 2019 13:58:51 +0100
Julien Grall <julien.grall@arm.com> wrote:

> This is happening because vgic_v2_fold_lr_state() is expected
> to be called with interrupt disabled. However, some of the path
> (e.g eventfd) will take a spinlock.
> 
> The spinlock is from the waitqueue, so using a raw_spin_lock cannot
> even be considered.
> 
> Do you have any input on how this could be solved?

What's the reason that vgic_v2_fold_lr_state() expects interrupts to be
disabled?

-- Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
