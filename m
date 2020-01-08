Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 454951346AC
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 16:51:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B512B4B075;
	Wed,  8 Jan 2020 10:51:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bWHcpYefmSd; Wed,  8 Jan 2020 10:51:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9185A4B06D;
	Wed,  8 Jan 2020 10:51:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 51B414B069
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 10:51:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I5MkliyONHgf for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 10:51:02 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C5AD4AFC5
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 10:51:02 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA382328;
 Wed,  8 Jan 2020 07:51:01 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 507113F534;
 Wed,  8 Jan 2020 07:51:00 -0800 (PST)
Date: Wed, 8 Jan 2020 15:50:58 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCHv2 2/3] KVM: arm/arm64: correct CPSR on exception entry
Message-ID: <20200108155057.GG49203@lakrids.cambridge.arm.com>
References: <20200108134324.46500-1-mark.rutland@arm.com>
 <20200108134324.46500-3-mark.rutland@arm.com>
 <3805fc5c-aa84-d203-11e4-b3a41ce5d809@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3805fc5c-aa84-d203-11e4-b3a41ce5d809@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: maz@kernel.org, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, will@kernel.org,
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

On Wed, Jan 08, 2020 at 02:41:04PM +0000, Alexandru Elisei wrote:
> On 1/8/20 1:43 PM, Mark Rutland wrote:
> > When KVM injects an exception into a guest, it generates the CPSR value
> > from scratch, configuring CPSR.{M,A,I,T,E}, and setting all other
> > bits to zero.
> >
> > This isn't correct, as the architecture specifies that some CPSR bits
> > are (conditionally) cleared or set upon an exception, and others are
> > unchanged from the original context.
> >
> > This patch adds logic to match the architectural behaviour. To make this
> > simple to follow/audit/extend, documentation references are provided,
> > and bits are configured in order of their layout in SPSR_EL2. This
> > layout can be seen in the diagram on ARM DDI 0487E.a page C5-426.
> >
> > Note that this code is used by both arm and arm64, and is intended to
> > fuction with the SPSR_EL2 and SPSR_HYP layouts.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>

> Looks good:
> 
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks!

I've folded that in (along with your Reviewed-by on patch 1), and pushed
out my kvm/exception-state branch again.

Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
