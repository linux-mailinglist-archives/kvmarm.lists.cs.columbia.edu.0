Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ED2113F4A60
	for <lists+kvmarm@lfdr.de>; Mon, 23 Aug 2021 14:10:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 45F004B1F4;
	Mon, 23 Aug 2021 08:10:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dasz+Bhm-sOe; Mon, 23 Aug 2021 08:10:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D8CF4B226;
	Mon, 23 Aug 2021 08:10:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E66DF4B1AC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Aug 2021 08:10:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KuEv83Dv8qBC for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Aug 2021 08:10:15 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6A4794B1A3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Aug 2021 08:10:15 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63CB26135F;
 Mon, 23 Aug 2021 12:10:14 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mI8mK-006ej3-DI; Mon, 23 Aug 2021 13:10:12 +0100
Date: Mon, 23 Aug 2021 13:10:11 +0100
Message-ID: <875yvwqs4c.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v4 11/15] KVM: arm64: Guest exit handlers for nVHE hyp
In-Reply-To: <CA+EHjTwyC-ZMpKQWGPqqYGHHR+YvyG3cdaxdwJfmYYf7XbBWEw@mail.gmail.com>
References: <20210817081134.2918285-1-tabba@google.com>
 <20210817081134.2918285-12-tabba@google.com>
 <87fsv6snup.wl-maz@kernel.org> <87zgtdqz77.wl-maz@kernel.org>
 <CA+EHjTwyC-ZMpKQWGPqqYGHHR+YvyG3cdaxdwJfmYYf7XbBWEw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tabba@google.com, kvmarm@lists.cs.columbia.edu,
 will@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
 suzuki.poulose@arm.com, mark.rutland@arm.com, christoffer.dall@arm.com,
 pbonzini@redhat.com, drjones@redhat.com, oupton@google.com, qperret@google.com,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, kvm@vger.kernel.org, pbonzini@redhat.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

Hi Fuad,

On Mon, 23 Aug 2021 11:21:05 +0100,
Fuad Tabba <tabba@google.com> wrote:
> 
> Hi Marc,
> 
> On Thu, Aug 19, 2021 at 3:36 PM Marc Zyngier <maz@kernel.org> wrote:
> > I realised that I wasn't very forthcoming here. I've decided to put
> > the code where my mouth is and pushed out a branch [1] with your first
> > 10 patches, followed by my own take on this particular problem. It
> > compiles, and even managed to boot a Debian guest on a nVHE box.
> >
> > As you can see, most of the early exit handling is now moved to
> > specific handlers, unifying the handling. For the protected mode, you
> > can provide your own handler array (just hack
> > kvm_get_exit_handler_array() to return something else), which will do
> > the right thing as long as you call into the existing handlers first.
> > When it comes to the ELR/SPSR handling, it is better left to the
> > individual handlers (which we already do in some cases, see how we
> > skip instructions, for example).
> > Please let me know what you think.
> 
> Thanks a lot for this and sorry for being late to reply. I've been
> travelling.

No worries, it should be me who apologies for getting to this that late.

> I think that your proposal looks great. All handling is consolidated
> now and handling for protected VMs can just be added on top. There are
> some small issues with what parameters we need (e.g., passing struct
> kvm to kvm_get_exit_handler_array), but I will sort them out and
> submit them in the next round.

OK. Please base these changes on top of the three patches in my
branch, which I will update with actual commit messages.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
