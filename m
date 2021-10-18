Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE0431628
	for <lists+kvmarm@lfdr.de>; Mon, 18 Oct 2021 12:32:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 81B644B1E7;
	Mon, 18 Oct 2021 06:32:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgf1rDrKDxMh; Mon, 18 Oct 2021 06:32:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 686244B280;
	Mon, 18 Oct 2021 06:32:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D35BB4B1E6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Oct 2021 06:32:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6euCnfV5lF5v for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 Oct 2021 06:32:20 -0400 (EDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B57DC4B1DC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Oct 2021 06:32:20 -0400 (EDT)
Received: by mail-wm1-f42.google.com with SMTP id g2so8282920wme.4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 Oct 2021 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Gy0sHksnt+PEnqqXO6xICRTdN60Lc9eTfBQpwKge7yw=;
 b=O4of8n6X9NBPN4KWNWUJs/0mWzTc116qBuKDx3ncFthvjhtsyL5DV2kBO0oVRG2oIh
 R23RzUj3/dJp4qwHQHvuk/y2x51na6lRlbVwxnC+9CRpBOCwDAH4UlgfsJbVmB2x5lRg
 G2j+W0EWHRCCZkLvZP6GgzrSINGeENXTpyB0hfVC98NkB9ys1AwlyGsqdfPTfp4b0JkN
 y5IHHrIP08Poykj/HOb4KUgeMZLIBJ66URZVb6eYlcauxcx9uNn0wIvWtyoNmHgmuqPj
 7OosgV3O9JTZndiBJb0m0eNQEc5ibTOxG49zYgd1cERqKbT87xl5CKEuPRsyq6VOnQv9
 fJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Gy0sHksnt+PEnqqXO6xICRTdN60Lc9eTfBQpwKge7yw=;
 b=TagPe7e2R229u/nXCMoKBPDAtXSo3rQVo9JyyxiDxDG75Cb84Ut0CDVmq+8D9o7h7O
 UxyrpY3/OEQL8+yk9+uKswl4n87mVPlnEp7r56pGwGZaUy/UtTdJQCv8BMThRugM/lns
 9qAypVYie8C8BDeMK5fFxj/ivxzNF5fsHuwEfq8s4sTdTYs6kPhZTfUTjtJUbIMq4jdz
 eVSteq0iT9W7QY7DXXnYZKRV+oBkhe8pkMZsRH9USLBdci1h/EenetoigwGF5QCSJH4k
 9gTHRDpOb7qjgT6NJgEZ1Fbjs6kxKRpIKbVDYBVQ6U+GicZJDDLr0jrdy8fH5DRciOe2
 H7XQ==
X-Gm-Message-State: AOAM530VSbsSS68WBo36l6s7XhNlrz+LCNpP35Vb7tp+RujFeA4T3JhI
 frIfIXFtjtVN7CQjv1DbOa/DXQ==
X-Google-Smtp-Source: ABdhPJz+FBDbOuFngAsn1vKBnLFL7clNmJbT3DoPREC11e6c1F2lUuWQ/TmDO8FETn0vXuk/SALxwg==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr29804562wmd.190.1634553139612; 
 Mon, 18 Oct 2021 03:32:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:ba81:6f1b:ab2e:f120])
 by smtp.gmail.com with ESMTPSA id d24sm11609621wmb.35.2021.10.18.03.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 03:32:19 -0700 (PDT)
Date: Mon, 18 Oct 2021 11:32:13 +0100
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 16/16] KVM: arm64: pkvm: Unshare guest structs during
 teardown
Message-ID: <YW1NLb9Pn9NyEYZF@google.com>
References: <20211013155831.943476-1-qperret@google.com>
 <20211013155831.943476-17-qperret@google.com>
 <87h7dhupfa.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h7dhupfa.wl-maz@kernel.org>
Cc: kernel-team@android.com, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
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

On Saturday 16 Oct 2021 at 13:25:45 (+0100), Marc Zyngier wrote:
> At this stage, the old thread may have been destroyed and the memory
> recycled. What happens if, in the interval, that memory gets shared
> again in another context? My guts feeling is that either the sharing
> fails, or the unshare above breaks something else (the refcounting
> doesn't save us if the sharing is not with HYP).

Aha, yes, that's a good point. The problematic scenario would be: a vcpu
runs in the context of task A, then blocks. Then task A is destroyed,
but the vcpu isn't (possibly because e.g. userspace intends to run it in
the context of another task or something along those lines). But the
thread_info and fpsimd_state of task A remain shared with the hypervisor
until the next vcpu run, even though the memory has been freed by the
host, and is possibly reallocated to another guest in the meantime.

So yes, at this point sharing/donating this memory range with a new
guest will fail, and confuse the host massively :/

> In any case, I wonder whether we need a notification from the core
> code that a thread for which we have a HYP mapping is gone so that we
> can mop up the mapping at that point. That's similar to what we have
> for MMU notifiers and S2 PTs.
> 
> This is doable by hooking into fpsimd_release_task() and extending
> thread_struct to track the sharing with HYP.

I've been looking into this, but struggled to find a good way to avoid
all the races. Specifically, handling the case where a vcpu and the task
which last ran it get destroyed at the same time isn't that easy to
handle: you end up having to maintain pointers from the task to the vcpu
and vice versa, but I have no obvious idea to update them both in a
non-racy way (other than having a one big lock to serialize all
those changes, but that would mean serializing all task destructions so
that really doesn't scale).

Another option is to take a refcount on 'current' from
kvm_arch_vcpu_run_map_fp() before sharing thread-specific structs with
the hyp and release the refcount of the previous task after unsharing.
But that means we'll have to also drop the refcount when the vcpu
gets destroyed, as well as explicitly unshare at that point. Shouldn't
be too bad I think. Thoughts?

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
