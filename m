Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 43AFE49AE47
	for <lists+kvmarm@lfdr.de>; Tue, 25 Jan 2022 09:46:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C0B249B0A;
	Tue, 25 Jan 2022 03:46:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.911
X-Spam-Level: 
X-Spam-Status: No, score=0.911 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pffW-+pE-SOi; Tue, 25 Jan 2022 03:46:03 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D56D49E1B;
	Tue, 25 Jan 2022 03:46:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7939149AFD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Jan 2022 03:46:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xjxv+lj66UCc for <kvmarm@lists.cs.columbia.edu>;
 Tue, 25 Jan 2022 03:46:00 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3BDFC4101F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 25 Jan 2022 03:46:00 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 94DBD6134F;
 Tue, 25 Jan 2022 08:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01173C340E0;
 Tue, 25 Jan 2022 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643100358;
 bh=o5P0EESqXEiVqLSm7A8kn65YVJDoZnbdLQ/5TGwA6to=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AEtTFdCq0bI0DCfv/5Ls9NQG93g5YJ6Wf4Anx9xGjdianL5hrM0D8s78lGOPZpcua
 Jz7jRQoGPJpvOj4PQGRIcZLoLTAaNvIcwkMabkmepjehhkJ0tDkfFoPTYLxkM6+lpb
 jY8WJmEPoc0K38vP0kZHAI/5sVgVkII2ysOPVqHKx9crzpGxy6I9LZd+TnrxsT6HUB
 eKiGfDJ/ZoJS/4AgjESgdGMTBKJL5Pjc3CwEjs0xAiKY13k8PWO+nNdyYMtJEfrwYX
 1ecGC968iT2a1uHckwxaq6i7ICowBvjzkqMFcwgDtXuXW/oXopeQgA3EWfh0DgPPPH
 Kj04X7tpRdPxw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nCHSd-002nE7-CG; Tue, 25 Jan 2022 08:45:55 +0000
Date: Tue, 25 Jan 2022 08:45:54 +0000
Message-ID: <875yq88app.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: KVM/arm64: Guest ABI changes do not appear rollback-safe
In-Reply-To: <CAJHc60wp4uCVQhigNrNxF3pPd_8RPHXQvK+gf7rSxCRfH6KwFg@mail.gmail.com>
References: <YSVhV+UIMY12u2PW@google.com> <87mtp5q3gx.wl-maz@kernel.org>
 <CAOQ_QshSaEm_cMYQfRTaXJwnVqeoN29rMLBej-snWd6_0HsgGw@mail.gmail.com>
 <87fsuxq049.wl-maz@kernel.org>
 <20210825150713.5rpwzm4grfn7akcw@gator.home>
 <CAOQ_QsgWiw9-BuGTUFpHqBw3simUaM4Tweb9y5_oz1UHdr4ELg@mail.gmail.com>
 <877dg8ppnt.wl-maz@kernel.org> <YSfiN3Xq1vUzHeap@google.com>
 <20210827074011.ci2kzo4cnlp3qz7h@gator.home>
 <CAOQ_Qsg2dKLLanSx6nMbC1Er9DSO3peLVEAJNvU1ZcRVmwaXgQ@mail.gmail.com>
 <87ilyitt6e.wl-maz@kernel.org>
 <CAOQ_QshfXEGL691_MOJn0YbL94fchrngP8vuFReCW-=5UQtNKQ@mail.gmail.com>
 <87lf3drmvp.wl-maz@kernel.org>
 <CAOQ_QsjVk9n7X9E76ycWBNguydPE0sVvywvKW0jJ_O58A0NJHg@mail.gmail.com>
 <CAJHc60wp4uCVQhigNrNxF3pPd_8RPHXQvK+gf7rSxCRfH6KwFg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rananta@google.com, drjones@redhat.com,
 kvmarm@lists.cs.columbia.edu, pshier@google.com, ricarkol@google.com,
 reijiw@google.com, jingzhangos@google.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, peter.maydell@linaro.org,
 seanjc@google.com, oupton@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, pshier@google.com, kvmarm@lists.cs.columbia.edu,
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

On Tue, 25 Jan 2022 03:47:04 +0000,
Raghavendra Rao Ananta <rananta@google.com> wrote:
> 
> Hello all,
> 
> Based on the recent discussion on the patch '[RFC PATCH v3 01/11] KVM:
> Capture VM start' [1], Reiji, I (and others in the team) were
> wondering, since the hypercall feature-map is technically per-VM and
> not per-vCPU, would it make more sense to present it as a kvm_device,
> rather than vCPU psuedo-registers to the userspace?

I really don't think so.

> If I understand correctly, the original motivation for going with
> pseudo-registers was to comply with QEMU, which uses KVM_GET_REG_LIST
> and KVM_[GET|SET]_ONE_REG interface, but I'm guessing the VMMs doing
> save/restore across migration might write the same values for every
> vCPU.

KVM currently restricts the vcpu features to be unified across vcpus,
but that's only an implementation choice. The ARM architecture doesn't
mandate that these registers are all the same, and it isn't impossible
that we'd allow for the feature set to become per-vcpu at some point
in time. So this argument doesn't really hold.

Furthermore, compatibility with QEMU's save/restore model is
essential, and AFAICT, there is no open source alternative.

> Granted that we would be diverging from the existing implementation
> (psci versioning and spectre WA registers), but this can be a cleaner
> way forward for extending hypercall support.

Cleaner? Why? How? You'd have the exact same constraints, plus the
disadvantages of having to maintain a new interface concurrently with
the existing ones.

> The kvm_device interface
> can be made backward compatible with the way hypercalls are exposed
> today, it can have the same registers/features discovery mechanisms
> that we discussed above, and majorly the userspace has to configure it
> only once per-VM. We can probably make the feature selection immutable
> just before any vCPU is created.

What is the problem with immutability on first run? Or even with a
'finalize' ioctl (we already have one)?

> 
> Please let me know your thoughts or any disadvantages that I'm overlooking.

A device means yet another configuration and migration API. Don't you
think we have enough of those? The complexity of KVM/arm64 userspace
API is already insane, and extremely fragile. Adding to it will be a
validation nightmare (it already is, and I don't see anyone actively
helping with it).

So no, I have no plan to consider anything but the GET/SET_ONE_REG
interface, and until someone writes another open source VMM that has
the same save/restore capabilities and proves that this interface
isn't fit for purpose, I see no incentive in deviating from a model
that is known to work.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
