Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8754F72A
	for <lists+kvmarm@lfdr.de>; Fri, 17 Jun 2022 14:04:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B8F64B2BB;
	Fri, 17 Jun 2022 08:04:17 -0400 (EDT)
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
	with ESMTP id RVqbSPecrVff; Fri, 17 Jun 2022 08:04:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A32B64B2B1;
	Fri, 17 Jun 2022 08:04:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C4C2A4B2A5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 08:04:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5CJcbcKm7T01 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Jun 2022 08:04:13 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6E1A04B2A1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Jun 2022 08:04:13 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7863661E71;
 Fri, 17 Jun 2022 12:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4DFC3411B;
 Fri, 17 Jun 2022 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655467451;
 bh=ff06ubygfLJX4WgKcGays/1C2mzW5Sh2DVYmtebhH8E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=n/lgPz9xDI61kFLjmYRaoISg8jz87EIHPKFqP+zK4bbmM6kMb6igl+xf1GUu6243n
 J2EAe6+D8uPIJzJAtVvRCpcR7WjSKY01RPFdkzPmqVVIMd5sN9VI1fI/HHgj3R4x7i
 zuTJvbqRlJBurH2zYTkLCkdQaU8glOqsWXPKsGFKXzGJmU/XOJc8UfUTFhAyv4gWY6
 sEmomIW0xHoZlQLODs3wHnm/6N+YZHDFzCxxNCqLPULgwYPeldQjlmezvuTEJl8Od/
 U9Rin/fsgfEAxB32IR6RyaNKFL41ebQU80AAy7cBt5EtwQcpQoAbwC1wwZbfwMpzTr
 sytkLejKyyYIg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1o2Aht-001IJJ-NC;
 Fri, 17 Jun 2022 13:04:09 +0100
Date: Fri, 17 Jun 2022 13:04:09 +0100
Message-ID: <87v8sz339i.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [Question] remote_tlb_flush statistic is missed from
 kvm_flush_remote_tlbs() ?
In-Reply-To: <20220617103316.4rejrhxtew7meawb@gator>
References: <25c7cc69-64ef-d42b-dc0b-968d7415b111@redhat.com>
 <87wndf383z.wl-maz@kernel.org>
 <20220617103316.4rejrhxtew7meawb@gator>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: drjones@redhat.com, gshan@redhat.com,
 kvmarm@lists.cs.columbia.edu, will@kernel.org, jingzhangos@google.com,
 pbonzini@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>, Paolo Bonzini <pbonzini@redhat.com>
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

On Fri, 17 Jun 2022 11:33:16 +0100,
Andrew Jones <drjones@redhat.com> wrote:
> 
> On Fri, Jun 17, 2022 at 11:19:28AM +0100, Marc Zyngier wrote:
> > On Fri, 17 Jun 2022 11:02:44 +0100,
> > Gavin Shan <gshan@redhat.com> wrote:
> > > 
> > > Hi Folks,
> > > 
> > > We're reviewing upstream commits and found that it seems that
> > > ++kvm->stat.generic.remote_tlb_flush has been missed from
> > > kvm_flush_remote_tlbs(). If I'm correct, we still need to
> > > increase the statistic in kvm_flush_remote_tlbs()?
> > > 
> > > History about the changes:
> > > 
> > > ce6a7007048b staging: r8188eu: remove {read,write}_macreg
> > >     The changes were NOT there any more.
> > > 419025b3b419 Merge branch kvm-arm64/misc-5.15 into kvmarm-master/next
> > >     The changes were still there
> > > 38f703663d4c KVM: arm64: Count VMID-wide TLB invalidations
> > >     The changes were initially introduced by this commit,
> > >     to increase 'kvm->stat.generic.remote_tlb_flush' in
> > >     kvm_flush_remote_tlbs().
> > 
> > I'm not sure what you are asking. This change is definitely still
> > present in the upstream kernel, and I don't get your point with the
> > staging commit, which is totally unrelated.
> > 
> > $ git describe --contains ce6a7007048b --match=v\*
> > v5.15-rc1~154^2~11
> > $ git describe --contains 419025b3b419 --match=v\*
> > v5.15-rc1~65^2~4^2
> > $ git describe --contains 38f703663d4c --match=v\*
> > v5.15-rc1~65^2~4^2^2~13
> > 
> > As you can see, the commit fixing the statistics was merged after
> > staging one (it appears closer to -rc1, as there is 6 days between the
> > two merge commits from Linus).
> >
> 
> Hi Marc,
> 
> I don't see the change for commit 38f703663d4c as of an upstream pull
> right now
>
> $ git show 47700948a4ab:arch/arm64/kvm/mmu.c | grep -A4 'void kvm_flush_remote_tlbs'
> void kvm_flush_remote_tlbs(struct kvm *kvm)
> {
> 	++kvm->stat.generic.remote_tlb_flush_requests;
> 	kvm_call_hyp(__kvm_tlb_flush_vmid, &kvm->arch.mmu);
> }
> 
> and I do see it got dropped with merge commit e99314a340d2.
> 
> $ git diff 419025b3b419 0d0a19395baa -- arch/arm64/kvm/mmu.c | grep -A5 'void kvm_flush_remote_tlbs'
>  void kvm_flush_remote_tlbs(struct kvm *kvm)
>  {
> +	++kvm->stat.generic.remote_tlb_flush_requests;
>  	kvm_call_hyp(__kvm_tlb_flush_vmid, &kvm->arch.mmu);
> -	++kvm->stat.generic.remote_tlb_flush;
>  }

That's because these two counters should have the exact same value at
all times. We don't use IPIs for TLB invalidation as the HW does the
broadcast for us, so there is no point in distinguishing requests from
actual flushes.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
