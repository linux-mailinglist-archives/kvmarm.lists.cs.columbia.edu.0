Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 46646516DB3
	for <lists+kvmarm@lfdr.de>; Mon,  2 May 2022 11:48:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F13F4B1D3;
	Mon,  2 May 2022 05:48:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1j8y2LhlYqrq; Mon,  2 May 2022 05:48:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 02FBF4B24D;
	Mon,  2 May 2022 05:48:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD1084B09C
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 May 2022 05:48:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6kHQaTL0dzFi for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 May 2022 05:48:30 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 72F794B099
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 May 2022 05:48:30 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6211DB815C8;
 Mon,  2 May 2022 09:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE57CC385A4;
 Mon,  2 May 2022 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651484907;
 bh=km8t5GpWZMuY8sFBom7Ai4dq7ayaMW+RDKrREB38Qpw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dBpvmz6sEN1MJSCG6kftcwf2X41LKcoSP+2cvL+Mu7aaUuifXIn2IzlCzjSlKhIBn
 mGw6RHBuQhmpr6g9XCDrg7a5LrfailJ/55TjXnF0zMiXKdcFyrgY1K7g445sPce5L8
 oMqDksVZbBO2MK43HzGadn8kLatdYQVxmDgu5X0E45DWFURQATkuzFSyYfj0nAAYOu
 NFzKof5QKEpKbVfPAbMrjyO9EGWXQS6nO+WnqUbBQCu6Mpb+O1VxYF5bC6P6nS6oZr
 JpJlAIognaEJvVN0T9GVOhGfuEZHtJOTLtEntvW6vfDMlw7BTGjHAg/mN2w3ftJty/
 rSxiqU4ncTzfw==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nlSfI-008O7L-OG; Mon, 02 May 2022 10:48:24 +0100
Date: Mon, 02 May 2022 10:49:05 +0100
Message-ID: <87k0b4i7se.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 4/4] KVM: arm64/mmu: count KVM s2 mmu usage in
 secondary pagetable stats
In-Reply-To: <Ym+HLD/U0wwrxtaB@google.com>
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-5-yosryahmed@google.com>
 <Ym+HLD/U0wwrxtaB@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@google.com, yosryahmed@google.com, tj@kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, pbonzini@redhat.com,
 seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
 jmattson@google.com, joro@8bytes.org, akpm@linux-foundation.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, linux-mm@kvack.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
 Zefan Li <lizefan.x@bytedance.com>, kvmarm@lists.cs.columbia.edu,
 Joerg Roedel <joro@8bytes.org>, Shakeel Butt <shakeelb@google.com>,
 cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Mon, 02 May 2022 08:24:28 +0100,
Oliver Upton <oupton@google.com> wrote:
> 
> Hi Yosry,
> 
> On Fri, Apr 29, 2022 at 08:11:31PM +0000, Yosry Ahmed wrote:
> > Count the pages used by KVM in arm64 for stage2 mmu in secondary pagetable
> > stats.
> > 
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  arch/arm64/kvm/mmu.c | 35 +++++++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 53ae2c0640bc..fc5030307cce 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -92,9 +92,13 @@ static bool kvm_is_device_pfn(unsigned long pfn)
> >  static void *stage2_memcache_zalloc_page(void *arg)
> >  {
> >  	struct kvm_mmu_memory_cache *mc = arg;
> > +	void *virt;
> >  
> >  	/* Allocated with __GFP_ZERO, so no need to zero */
> > -	return kvm_mmu_memory_cache_alloc(mc);
> > +	virt = kvm_mmu_memory_cache_alloc(mc);
> > +	if (virt)
> > +		kvm_account_pgtable_pages(virt, +1);
> 
> Sorry I didn't say it last time around, would now be a good time to
> clean up the funky sign convention of kvm_mod_used_mmu_pages()? Or limit
> the funk to just x86 :)

Indeed. I pointed this out in my initial review of this series, and
expected these to be gone by now.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
