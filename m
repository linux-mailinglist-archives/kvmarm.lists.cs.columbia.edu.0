Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF03623B59
	for <lists+kvmarm@lfdr.de>; Thu, 10 Nov 2022 06:38:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BC0A54BA86;
	Thu, 10 Nov 2022 00:38:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.79
X-Spam-Level: 
X-Spam-Status: No, score=-1.79 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09brYx+qPwqY; Thu, 10 Nov 2022 00:38:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 66A9E4BA79;
	Thu, 10 Nov 2022 00:38:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 87C034BA62
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Nov 2022 00:38:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pVcQVY42qB7x for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Nov 2022 00:38:54 -0500 (EST)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2D4C24BA39
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Nov 2022 00:38:54 -0500 (EST)
Date: Thu, 10 Nov 2022 05:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1668058728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cz0g122FW3hWdq2eHIOMV7hQCiSlXiVP/4zHh+q+Qq0=;
 b=niJA84Quup1g33NjpucWgilFD6cKWSGkmmg79fRyKKMCCj38GzothGXiO0FqQ/Ep/Zn3e/
 TxfMu/QWFWEvxts+FQHY1uvhJTwmeoOAGVHEHR/Gf33KdN6MHH1K28hIs1iegy+qSvtXD3
 dcIAT1pfI0BM3eJ40oo50kQD+mcDB/Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 04/14] KVM: arm64: Don't pass kvm_pgtable through
 kvm_pgtable_walk_data
Message-ID: <Y2yOY0FKNmri8J4h@google.com>
References: <20221107215644.1895162-1-oliver.upton@linux.dev>
 <20221107215644.1895162-5-oliver.upton@linux.dev>
 <acce8160-a559-648f-ea9f-995843b9a3fb@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acce8160-a559-648f-ea9f-995843b9a3fb@redhat.com>
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev,
 Ben Gardon <bgardon@google.com>, David Matlack <dmatlack@google.com>,
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

On Thu, Nov 10, 2022 at 01:30:08PM +0800, Gavin Shan wrote:
> Hi Oliver,
> 
> On 11/8/22 5:56 AM, Oliver Upton wrote:
> > In order to tear down page tables from outside the context of
> > kvm_pgtable (such as an RCU callback), stop passing a pointer through
> > kvm_pgtable_walk_data.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >   arch/arm64/kvm/hyp/pgtable.c | 18 +++++-------------
> >   1 file changed, 5 insertions(+), 13 deletions(-)
> > 
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>

Appreciated :)

> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index db25e81a9890..93989b750a26 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -50,7 +50,6 @@
> >   #define KVM_MAX_OWNER_ID		1
> >   struct kvm_pgtable_walk_data {
> > -	struct kvm_pgtable		*pgt;
> >   	struct kvm_pgtable_walker	*walker;
> >   	u64				addr;
> 
> Ok. Here is the answer why data->pgt->mm_ops isn't reachable in the walker
> and visitor, and @mm_ops needs to be passed down.

Yup, the reason for unhitching all of this from kvm_pgtable is explained
in the cover letter as well:

  Patches 1-4 clean up the context associated with a page table walk / PTE
  visit. This is helpful for:
   - Extending the context passed through for a visit
   - Building page table walkers that operate outside of a kvm_pgtable
     context (e.g. RCU callback)

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
