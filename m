Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 709DE1AAEF7
	for <lists+kvmarm@lfdr.de>; Wed, 15 Apr 2020 19:00:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CFF0A4B23B;
	Wed, 15 Apr 2020 13:00:39 -0400 (EDT)
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
	with ESMTP id X+GoL-NVoHWo; Wed, 15 Apr 2020 13:00:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 801144B21E;
	Wed, 15 Apr 2020 13:00:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E345D4B213
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 13:00:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XkTNc2VXh8-T for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 13:00:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EB80D4B155
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 13:00:35 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0AE31206F9;
 Wed, 15 Apr 2020 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586970034;
 bh=MgOckoa6oaXylsn5YDxRnw+SO2S8/uU9ZQM4CMMYhm0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cp7XRASHgNQMYStqM9ccE+H4cbmpnvWsouW1/UcDJzRy7Tj4nwWnYlg5nCtAE246T
 bvnQx6CzbbqsPvaDF8ASoMzrXi3scNKrNh/PmIe+hw+3dcNqI/VHdWiAfYOEXE8JtC
 JaG0B9RXKq7wg2MukI0p2o4VLkjDuFNms4+4269M=
Date: Wed, 15 Apr 2020 18:00:29 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 3/8] arm64: cpufeature: Add CPU capability for AArch32
 EL1 support
Message-ID: <20200415170029.GA19615@willie-the-truck>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-4-will@kernel.org>
 <1b76993491176577567a0960a435dac0@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1b76993491176577567a0960a435dac0@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>, kernel-team@android.com,
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

Hi Marc,

On Wed, Apr 15, 2020 at 09:55:57AM +0100, Marc Zyngier wrote:
> On 2020-04-14 22:31, Will Deacon wrote:
> > Although we emit a "SANITY CHECK" warning and taint the kernel if we
> > detect a CPU mismatch for AArch32 support at EL1, we still online the
> > CPU with disastrous consequences for any running 32-bit VMs.
> > 
> > Introduce a capability for AArch32 support at EL1 so that late onlining
> > of incompatible CPUs is forbidden.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> Definitely an improvement over the current situation, as the direct read
> of ID_AA64PFR0 was always a bit dodgy. Given that I'm pretty sure these new
> braindead SoCs are going to run an older version of the kernel, should we
> Cc stable for this?

I don't think there's a real need for -stable given that we do at least
taint the kernel. That's likely to annoy vendors enough to backport this
themselves ;)

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
