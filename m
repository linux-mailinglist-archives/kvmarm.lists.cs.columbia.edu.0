Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AC492625E27
	for <lists+kvmarm@lfdr.de>; Fri, 11 Nov 2022 16:19:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 880404B917;
	Fri, 11 Nov 2022 10:19:13 -0500 (EST)
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
	with ESMTP id SLqSl6VVV5K2; Fri, 11 Nov 2022 10:19:13 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E0F44B901;
	Fri, 11 Nov 2022 10:19:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D9D24B8E5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Nov 2022 10:19:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gh1afeXBQL3v for <kvmarm@lists.cs.columbia.edu>;
 Fri, 11 Nov 2022 10:19:09 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 52E194B8D4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 11 Nov 2022 10:19:09 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5495A61FD3;
 Fri, 11 Nov 2022 15:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACABC43470;
 Fri, 11 Nov 2022 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668179947;
 bh=Myih+8eSXLKw3bm/7g/0UFkXRjh+SapEsLznCy0f9CI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dVcPkuhWLZcqwcllPFPJ1OK1KqydWxpSIA33Nh7cJaW/Q6wTeT77ronYe0J4TUpUB
 /ndiA/6wu3YBHOsS5XTg4Zx04bhlC39whiL+oNms3WyYvmXlRYXagsxlT5MxMEgcbG
 04gwZmRCuBmaiLWeC3NVJEwOV9lAoRPTfC3KAP7+s9EzR3KVIunpSwlAFkNRxJRXMf
 QeJNNF/auixMZfG6iCdqQA8Nq+taeG2Jq/1RHgl+qR70QbruE+ylatjc/q19EPhi/q
 iKHmWVazlYj9dIlebQhOZOpfeZ7E2lY50ggMzDS/PxpVed+eFTGO/iTwN/SuIu6tb0
 Hdwh7iCvZ3V9A==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1otVo9-005SPW-7g;
 Fri, 11 Nov 2022 15:19:05 +0000
Date: Fri, 11 Nov 2022 15:19:04 +0000
Message-ID: <86h6z5plhz.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v10 3/7] KVM: Support dirty ring in conjunction with bitmap
In-Reply-To: <1cfa0286-9a42-edd9-beab-02f95fc440ad@redhat.com>
References: <20221110104914.31280-1-gshan@redhat.com>
 <20221110104914.31280-4-gshan@redhat.com>
 <Y20q3lq5oc2gAqr+@google.com>
 <1cfa0286-9a42-edd9-beab-02f95fc440ad@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: gshan@redhat.com, seanjc@google.com, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, shuah@kernel.org,
 catalin.marinas@arm.com, andrew.jones@linux.dev, ajones@ventanamicro.com,
 bgardon@google.com, dmatlack@google.com, will@kernel.org,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, pbonzini@redhat.com,
 peterx@redhat.com, oliver.upton@linux.dev, zhenyzha@redhat.com,
 shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, bgardon@google.com, andrew.jones@linux.dev,
 dmatlack@google.com, will@kernel.org, shan.gavin@gmail.com,
 catalin.marinas@arm.com, kvmarm@lists.linux.dev, pbonzini@redhat.com,
 zhenyzha@redhat.com, shuah@kernel.org, kvmarm@lists.cs.columbia.edu,
 ajones@ventanamicro.com
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

On Thu, 10 Nov 2022 23:47:41 +0000,
Gavin Shan <gshan@redhat.com> wrote:
> 
> commit b05377ecbe003f12c8b79846fa3a300401dcab68 (HEAD -> kvm/arm64_dirtyring)
> Author: Gavin Shan <gshan@redhat.com>
> Date:   Fri Nov 11 07:13:12 2022 +0800
> 
>     KVM: Push dirty information unconditionally to backup bitmap
>         In mark_page_dirty_in_slot(), we bail out when no running vcpu
> exists and
>     a running vcpu context is strictly required by architecture. It may cause
>     backwards compatible issue. Currently, saving vgic/its tables is the only
>     case where no running vcpu context is required. We may have other unknown
>     cases where no running vcpu context exists and it's reported by the warning
>     message. For this, the application is going to enable the backup bitmap for
>     the unknown cases. However, the dirty information can't be pushed to the
>     backup bitmap even though the backup bitmap has been enabled, until the
>     unknown cases are added to the allowed list of non-running vcpu context
>     with extra code changes to the host kernel.
>         In order to make the new application, where the backup bitmap
> has been
>     enabled, to work with the unchanged host, we continue to push the dirty
>     information to the backup bitmap instead of bailing out early.
>         Suggested-by: Sean Christopherson <seanjc@google.com>
>     Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2719e10dd37d..03e6a38094c1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3308,8 +3308,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
>         if (WARN_ON_ONCE(vcpu && vcpu->kvm != kvm))
>                 return;
>  -       if
> (WARN_ON_ONCE(!kvm_arch_allow_write_without_running_vcpu(kvm) &&
> !vcpu))
> -               return;
> +       WARN_ON_ONCE(!vcpu && !kvm_arch_allow_write_without_running_vcpu(kvm));

I'm happy with this.

>  #endif
>          if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
> @@ -3318,7 +3317,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm,
>                  if (kvm->dirty_ring_size && vcpu)
>                         kvm_dirty_ring_push(vcpu, slot, rel_gfn);
> -               else
> +               else if (memslot->dirty_bitmap)
>                         set_bit_le(rel_gfn, memslot->dirty_bitmap);

But that I don't get. Or rather, I don't get the commit message that
matches this hunk. Do we want to catch the case where all of the
following are true:

- we don't have a vcpu,
- we're allowed to log non-vcpu dirtying
- we *only* have the ring?

If so, can we please capture that in the commit message?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
