Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5D2D27E8
	for <lists+kvmarm@lfdr.de>; Tue,  8 Dec 2020 10:40:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF7704B2A5;
	Tue,  8 Dec 2020 04:40:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o72s9VzFA3eo; Tue,  8 Dec 2020 04:40:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B65784B263;
	Tue,  8 Dec 2020 04:40:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CF6254B25A
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Dec 2020 04:40:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tsq-V-SYDK2s for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Dec 2020 04:40:33 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D70EA4B19C
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Dec 2020 04:40:33 -0500 (EST)
Date: Tue, 8 Dec 2020 09:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607420432;
 bh=l03X9b1AwR7eEYo3VLDO+AWbKPeOsT8lUlLG3XUEGcc=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=B9yFCJVPeCmI8cxF0hHxdebit6cTtoLiw93kazgl0x+BJCfUJJXOZNfRGlYKaygXI
 S/N+40Uwu0X5uWaRwpuCZ2jc8AlyUfdZpE/NM3RSP3QSz+o8XgD35WRRD2+xDNbXGZ
 VGH+IiMIgdJj74Kd/2A2KesH+nrjgb9PcdGfaCUAdXvQdli5MpnnWsUwzJHKiwEvDd
 SmjfzgawHzDoD/40UPolbneGtEDobrxNbSh5oHZO3KfAdI+flFHiVg9esS9VGe/Oxr
 Rh5SfXP/9IDR+s7jMOFYBEKEwxZ8kOghkhqxHHdsyKIbnhjx4/wuZXbaNwKKQBF7mu
 GXiLXL8rGbQ2w==
From: Will Deacon <will@kernel.org>
To: Quentin Perret <qperret@google.com>
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20201208094026.GA5562@willie-the-truck>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
 <20201207134052.GA4563@willie-the-truck>
 <X844CBNCTL4XT3iq@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X844CBNCTL4XT3iq@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, kernel-team@android.com, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>
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

On Mon, Dec 07, 2020 at 02:11:20PM +0000, Quentin Perret wrote:
> On Monday 07 Dec 2020 at 13:40:52 (+0000), Will Deacon wrote:
> > Why not use the RESERVEDMEM_OF_DECLARE() interface for the hypervisor
> > memory? That way, the hypervisor memory can either be statically partitioned
> > as a carveout or allocated dynamically for us -- we wouldn't need to care.
> 
> Yup, I did consider that, but the actual amount of memory we need to
> reserve for the hypervisor depends on things such as the size of struct
> hyp_page, which depends on the kernel you're running (that is, it might
> change over time). So, that really felt like something the kernel should
> be doing, to keep the DT backward compatible, ... Or did you have
> something more elaborate in mind?

No, that's fair. Just wanted to make sure we had a good reason not to use
the existing memory reservation code.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
