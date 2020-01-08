Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 53DEC134013
	for <lists+kvmarm@lfdr.de>; Wed,  8 Jan 2020 12:16:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E050E4B02F;
	Wed,  8 Jan 2020 06:16:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001] autolearn=no
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AJiJZU6d0R4s; Wed,  8 Jan 2020 06:16:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD9574B047;
	Wed,  8 Jan 2020 06:16:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 669144AF7A
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 06:16:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AO-eGDz7ymed for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Jan 2020 06:15:41 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 934534AF6F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Jan 2020 06:15:41 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D05D30E;
 Wed,  8 Jan 2020 03:15:41 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5EDA3F703;
 Wed,  8 Jan 2020 03:15:39 -0800 (PST)
Date: Wed, 8 Jan 2020 11:15:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 1/3] KVM: arm64: correct PSTATE on exception entry
Message-ID: <20200108111537.GB49203@lakrids.cambridge.arm.com>
References: <20191220150549.31948-1-mark.rutland@arm.com>
 <20191220150549.31948-2-mark.rutland@arm.com>
 <bace4197-a723-5312-3990-84232aab30d9@arm.com>
 <86zhfbgnzf.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86zhfbgnzf.wl-maz@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: Will Deacon <will@kernel.org>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
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

On Sun, Dec 29, 2019 at 03:17:40PM +0000, Marc Zyngier wrote:
> On Fri, 27 Dec 2019 13:01:57 +0000,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
> > On 12/20/19 3:05 PM, Mark Rutland wrote:
> > > +	// PSTATE.PAN is unchanged unless overridden by SCTLR_ELx.SPAN
> > > +	// See ARM DDI 0487E.a, page D5-2578.
> > > +	new |= (old & PSR_PAN_BIT);
> > > +	if (sctlr & SCTLR_EL1_SPAN)
> > > +		new |= PSR_PAN_BIT;
> > 
> > On page D13-3264, it is stated that the PAN bit is set unconditionally if
> > SCTLR_EL1.SPAN is clear, not set.
> 
> Indeed. Given that when ARMv8.1-PAN is not implemented, SCTLR_EL1[23]
> is RES1, it seems surprising to force PAN based on this bit being set.
> 
> I've now dropped this series from my tree until Mark has a chance to
> clarify this.

Sorry for the mess; I'm fixing up the patches now and looking out for
any similar mistakes.

I'll try to have a v2 out by the end of today.

Thanks,
Mark.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
