Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DC634588287
	for <lists+kvmarm@lfdr.de>; Tue,  2 Aug 2022 21:34:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1072451012;
	Tue,  2 Aug 2022 15:34:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R+vDk9UH3VoF; Tue,  2 Aug 2022 15:34:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 88C0C50EE6;
	Tue,  2 Aug 2022 15:34:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 048AA509D1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Aug 2022 15:34:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ShYu8p8haJY for <kvmarm@lists.cs.columbia.edu>;
 Tue,  2 Aug 2022 15:34:46 -0400 (EDT)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 69EEC509C1
 for <kvmarm@lists.cs.columbia.edu>; Tue,  2 Aug 2022 15:34:46 -0400 (EDT)
Date: Tue, 2 Aug 2022 12:34:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1659468885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OCcv/AYbwQMkwRUQMSe1O4XfWOyEUfS7V1bgTTCBT/U=;
 b=r7kFMl4+sawh0grH7bFq4KgIEfteNExDYsCihhAJ0WRVC8oeVhMVS40GpxT2kwnQwHiWBe
 YutnWi6wzRgPXNKXesXLJKm9fuvWuaEjAS7W9rV92zbPJ44MJ+FY0N/9+RiBvc/6dHW552
 so22xQVEVKGY2OS/atIozlZW+XKIBrU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: KVM/arm64: SPE: Translate VA to IPA on a stage 2 fault instead
 of pinning VM memory
Message-ID: <Yul8UBoDcy6GQddq@google.com>
References: <Yl6+JWaP+mq2Nc0b@monolith.localdoman>
 <20220419141012.GB6143@willie-the-truck>
 <Yt5nFAscgrRGNGoH@monolith.localdoman>
 <20220801170055.GB26471@willie-the-truck>
 <YujzE33aPSD22wvY@monolith.localdoman>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YujzE33aPSD22wvY@monolith.localdoman>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Cc: maz@kernel.org, Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

Hi folks,

On Tue, Aug 02, 2022 at 10:49:07AM +0100, Alexandru Elisei wrote:
> > > > A funkier approach might be to defer pinning of the buffer until the SPE is
> > > > enabled and avoid pinning all of VM memory that way, although I can't
> > > > immediately tell how flexible the architecture is in allowing you to cache
> > > > the base/limit values.
> > > 
> > > I was investigating this approach, and Mark raised a concern that I think
> > > might be a showstopper.
> > > 
> > > Let's consider this scenario:
> > > 
> > > Initial conditions: guest at EL1, profiling disabled (PMBLIMITR_EL1.E = 0,
> > > PMBSR_EL1.S = 0, PMSCR_EL1.{E0SPE,E1SPE} = {0,0}).
> > > 
> > > 1. Guest programs the buffer and enables it (PMBLIMITR_EL1.E = 1).
> > > 2. Guest programs SPE to enable profiling at **EL0**
> > > (PMSCR_EL1.{E0SPE,E1SPE} = {1,0}).
> > > 3. Guest changes the translation table entries for the buffer. The
> > > architecture allows this.
> > 
> > The architecture also allows MMIO accesses to use writeback addressing
> > modes, but it doesn't provide a mechanism to virtualise them sensibly.
> > 
> > So I'd prefer that we don't pin all of guest memory just to satisfy a corner
> > case -- as long as the impact of a guest doing this funny sequence is
> > constrained to the guest, then I think pinning only what is required is
> > probably the most pragmatic approach.
> > 
> > Is it ideal? No, of course not, and we should probably try to get the debug
> > architecture extended to be properly virtualisable, but in the meantime
> > having major operating systems as guests and being able to use SPE without
> > pinning seems like a major design goal to me.
> > 
> > In any case, that's just my thinking on this and I defer to Oliver and
> > Marc on the ultimate decision.

Thanks for chiming in Will, very much agree that pragmatism is likely
the best route forward. While fun to poke at all the pitfalls of
virtualizing SPE, pulling tricks in KVM probably has marginal return
over a simpler approach.

> Thank you for the input.
> 
> To summarize the approaches we've discussed so far:
> 
> 1. Pinning the entire guest memory
> - Heavy handed and not ideal.
> - Tried this approach in v5 of the SPE series [1], patches #2-#12.
> 
> 2. Mapping the guest SPE buffer on demand, page by page, as a result of stage 2
> faults reported by SPE.
> - Not feasible, because the entire contents of the buffer must be discarded is
>   PMBSR_EL1.DL is set to 1 when taking the fault.
> - Requires KVM to walk the guest's stage 1 tables, because SPE reports the VA,
>   not the IPA.
> 
> 3. Pinning the guest SPE buffer when profiling becomes enabled*:
> - There is the corner case described above, when profiling becomes enabled as a
>   result of an ERET to EL0. This can happen when the buffer is enabled and
>   PMSCR_EL1.{E0SPE,E1SPE} = {1,0};
> - The previous buffer is unpinned when a new buffer is pinned, to avoid SPE
>   stage 2 faults when draining the buffer, which is performed with profiling
>   disabled.
> - Also requires KVM to walk the guest's stage 1 tables.
> 
> 4. Pin the entire guest SPE buffer after the first stage 2 fault reported by
> SPE.
> - Gets rid of the corner case at 3.
> - Same approach to buffer unpinning as 3.
> - Introduces a blackout window before the first record is written.
> - Also requires KVM to walk the guest's stage 1 tables.
> 
> As for the corner case at 3, I proposed either:
> 
> a) Mandate that guest operating systems must never modify the buffer
> translation entries if the buffer is enabled and
> PMSCR_EL1.{E0SPE,E1SPE} = {1,0}.
> 
> b) Pin the entire buffer as a result of the first stage 2 fault reported by SPE,
> but **only** for this corner case. For all other cases, the buffer is pinned
> when profiling becomes enabled, to eliminate the blackout window. Guest
> operating systems can be modified to not change the translation entries for the
> buffer if this blackout window is not desirable.
> 
> Pinning as a result of the **first** stage 2 fault should work, because there
> are no prior records that would have to be discarded if PMSBR_EL1.DL = 1.
> 
> I hope I haven't missed anything. Thoughts and suggestions more than welcome.

Thanks Alex for pulling together all of the context here.

Unless there's any other strong opinions on the topic, it seems to me
that option #4 (pin on S2 fault) is probably the best approach for
the initial implementation. No amount of tricks in KVM can work around
the fact that SPE has some serious issues w.r.t. virtualization. With
that, we should probably document the behavior of SPE as a known erratum
of KVM.

If folks complain about EL1 profile blackout, eagerly pinning when
profiling is enabled could layer on top quite easily by treating it as
a synthetic S2 fault and triggering the implementation of #4. Having
said that I don't believe it is a hard requirement for enabling some
flavor of SPE for guests.

Walking guest S1 in KVM doesn't sound too exciting although it'll need to
be done eventually.

Do you feel like this is an OK route forward, or have I missed
something?

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
