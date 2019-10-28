Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E471EE701C
	for <lists+kvmarm@lfdr.de>; Mon, 28 Oct 2019 12:06:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F41F4A5C3;
	Mon, 28 Oct 2019 07:06:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrqSOYc1++Yz; Mon, 28 Oct 2019 07:06:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 467514A5A8;
	Mon, 28 Oct 2019 07:06:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 96D0F4A522
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Oct 2019 07:06:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ySvXg40T1H8X for <kvmarm@lists.cs.columbia.edu>;
 Mon, 28 Oct 2019 07:06:36 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A2674A483
 for <kvmarm@lists.cs.columbia.edu>; Mon, 28 Oct 2019 07:06:36 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E501F1;
 Mon, 28 Oct 2019 04:06:36 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 EB70C3F71E; Mon, 28 Oct 2019 04:06:34 -0700 (PDT)
Date: Mon, 28 Oct 2019 11:06:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 4/5] arm64: KVM: Prevent speculative S1 PTW when
 restoring vcpu context
Message-ID: <20191028110632.GC16739@arrakis.emea.arm.com>
References: <20191019095521.31722-1-maz@kernel.org>
 <20191019095521.31722-5-maz@kernel.org>
 <151fc868-6709-3017-e34d-649ec0e1812c@arm.com>
 <8636ffzu30.wl-maz@kernel.org>
 <20191028103217.GB16739@arrakis.emea.arm.com>
 <86zhhlxhz2.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86zhhlxhz2.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
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

On Mon, Oct 28, 2019 at 10:49:37AM +0000, Marc Zyngier wrote:
> On Mon, 28 Oct 2019 10:32:17 +0000,
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Sat, Oct 26, 2019 at 11:20:35AM +0100, Marc Zyngier wrote:
> > > Catalin, Will: given that this series conflicts with the workaround for
> > > erratum 1542419, do you mind taking it via the arm64 tree?
[...]
> > I don't mind merging it but if you want to queue it, we already have
> > a stable for-next/neoverse-n1-stale-instr branch with 1542419 (I'll
> > push a fixup on top soon for a clang warning). The other issue is
> > that we get a conflict with mainline due to the tx2 erratum. If it
> > gets too complicated, I'll also merge for-next/fixes into
> > for-next/core.
> 
> OK, let me have another look at providing a resolution that includes
> all of the above. Worse case, you'll be able to pull the branch
> directly.

Don't worry about the resolution, I'll fix it up myself when merging
into for-next/core. The latter is not a stable branch, just an octopus
merge of various for-next/* topic branches.

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
