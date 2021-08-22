Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9753F415A
	for <lists+kvmarm@lfdr.de>; Sun, 22 Aug 2021 21:56:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 66ABE4B1F1;
	Sun, 22 Aug 2021 15:56:34 -0400 (EDT)
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
	with ESMTP id MClTeacZXN35; Sun, 22 Aug 2021 15:56:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6624A4B229;
	Sun, 22 Aug 2021 15:56:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A5D74B200
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Aug 2021 15:56:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdWkGKMb0pua for <kvmarm@lists.cs.columbia.edu>;
 Sun, 22 Aug 2021 15:56:26 -0400 (EDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 887444B1F1
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Aug 2021 15:56:26 -0400 (EDT)
Received: by mail-lf1-f42.google.com with SMTP id o10so33276782lfr.11
 for <kvmarm@lists.cs.columbia.edu>; Sun, 22 Aug 2021 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8EvprDUUqsYUgGbr+CUCRWV+3LEbs3hnD+fZ87zhZtk=;
 b=Yg0NsfcTNyrDqZJOESZ0zS4B8ms6dqrIZBjjTU/jkhkIkNh33wD67YtPQupdsGPWRC
 UtIyQRyUVmLF/ZYwdTmHX+3E4xAPRSJdEAKVb6qPz3JOCjAn98VJ01VnUwL9GUWp+9ND
 fJH8BYww140lSRwIA/ijPyisQhN9ljGkwQpTHvLUAPdQzROE7nr/Asz92pHS1a+j3/FK
 ADGlb4t1KG0ln+eGIvvG+TiZCWSCXaE5x8tGU5ippqNyKMvYC3IHYYLlI3C3xsdcRd2+
 f7qPBX8sc4Dn9QyLu4CGjHJAeZHMVIV9rGq8tr0u0w0lHaKAGDW8tQ9EWFCl/myJYeXp
 j5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8EvprDUUqsYUgGbr+CUCRWV+3LEbs3hnD+fZ87zhZtk=;
 b=saPSPzG0yD6Hucv2vtThAsYb/O+ZYwBw/s+v+zMzyeQ7ssqaZtmWWfkyImebWKX0ce
 ln/FAa7YrpQAAr0akMXr8cBBDJmhHcdYyKrJhT5kJj4zBJUdq+vx57LbUgFgvcjB7g3Q
 Qs7ZFynm7Xc7XuZLFOt8t0qrCVCxGCRRICf60jhvxJ7SpLTroxlD4X3C5Q2+n2a1jP+k
 erAlmqWNJk0moFftSesEA+xiD3a5kcAZp48/s3MszMb2T+OB/G4BENeRr0u5qRamBNeY
 lFfSMS48tGMRhNzMpjapIkolImoWS3kd7ujQS+N8YaLxo7/sEReXpSNmJuv9x8EXktXq
 2gEQ==
X-Gm-Message-State: AOAM533JbAObV54qgWogCaXZh36aOo3+TCENDr0s7Oj5/ohi2+BgsHD6
 k99MQY5paV2igye3IaP9prve9Eiiun7PwjVDmSw/bw==
X-Google-Smtp-Source: ABdhPJxK2ZKevjpY+Lj+EO4GHgYci/sC4siRXi3L+At0+wMEzqARiWLLWTshUd5QuzhAUgR2/ZulCBYsQ1zifvUPf1M=
X-Received: by 2002:a19:f718:: with SMTP id z24mr5922854lfe.57.1629662184795; 
 Sun, 22 Aug 2021 12:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210819223640.3564975-1-oupton@google.com>
In-Reply-To: <20210819223640.3564975-1-oupton@google.com>
From: Oliver Upton <oupton@google.com>
Date: Sun, 22 Aug 2021 12:56:13 -0700
Message-ID: <CAOQ_QsgaACbcW276TAqrmq2E5ne-C2JiEDVGjVXg9-WRds8ZQA@mail.gmail.com>
Subject: Re: [PATCH 0/6] KVM: arm64: Implement PSCI SYSTEM_SUSPEND support
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>
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

Marc,

On Thu, Aug 19, 2021 at 3:36 PM Oliver Upton <oupton@google.com> wrote:
>
> Certain VMMs/operators may wish to give their guests the ability to
> initiate a system suspend that could result in the VM being saved to
> persistent storage to be resumed at a later time. The PSCI v1.0
> specification describes an SMC, SYSTEM_SUSPEND, that allows a kernel to
> request a system suspend. This call is optional for v1.0, and KVM
> elected to not support the call in its v1.0 implementation.
>
> This series adds support for the SYSTEM_SUSPEND PSCI call to KVM/arm64.
> Since this is a system-scoped event, KVM cannot quiesce the VM on its
> own. We add a new system exit type in this series to clue in userspace
> that a suspend was requested. Per the KVM_EXIT_SYSTEM_EVENT ABI, a VMM
> that doesn't care about this event can simply resume the guest without
> issue (we set up the calling vCPU to come out of reset correctly on next
> KVM_RUN).
>
> Patch 1 is unrelated, and is a fix for "KVM: arm64: Enforce reserved
> bits for PSCI target affinities" on the kvmarm/next branch. Nothing
> particularly hairy, just an unused param.

Title line may not have been clear on this series, Patch 1 is a fix
for the PSCI CPU_ON series that's in kvmarm/next to suppress a
compiler warning.

> Patch 2 simplifies the function to check if KVM allows a particular PSCI
> function. We can generally disallow any PSCI function that sets the
> SMC64 bit in the PSCI function ID.
>
> Patch 3 wraps up the PSCI reset logic used for CPU_ON, which will be
> needed later to queue up a reset on the vCPU that requested the system
> suspend.
>
> Patch 4 brings in the new UAPI and PSCI call, guarded behind a VM
> capability for backwards compatibility.
>
> Patch 5 is indirectly related to this series, and avoids compiler
> reordering on PSCI calls in the selftest introduced by "selftests: KVM:
> Introduce psci_cpu_on_test".

This too is a fix for the PSCI CPU_ON series. Just wanted to raise it
to your attention beyond the new feature I'm working on here.

--
Thanks,
Oliver

> Finally, patch 6 extends the PSCI selftest to verify the
> SYSTEM_SUSPEND PSCI call behaves as intended.
>
> These patches apply cleanly to kvmarm/next at the following commit:
>
> f2267b87ecd5 ("Merge branch kvm-arm64/misc-5.15 into kvmarm-master/next")
>
> The series is intentionally based on kvmarm/next for the sake of fixing
> patches only present there in [1/6] and [5/6]. Tested on QEMU (ick)
> since my Mt. Jade box is out to lunch at the moment and for some unknown
> reason the toolchain on my work computer doesn't play nice with the FVP.
>
> Oliver Upton (6):
>   KVM: arm64: Drop unused vcpu param to kvm_psci_valid_affinity()
>   KVM: arm64: Clean up SMC64 PSCI filtering for AArch32 guests
>   KVM: arm64: Encapsulate reset request logic in a helper function
>   KVM: arm64: Add support for SYSTEM_SUSPEND PSCI call
>   selftests: KVM: Promote PSCI hypercalls to asm volatile
>   selftests: KVM: Test SYSTEM_SUSPEND PSCI call
>
>  arch/arm64/include/asm/kvm_host.h             |   3 +
>  arch/arm64/kvm/arm.c                          |   5 +
>  arch/arm64/kvm/psci.c                         | 134 +++++++++++++-----
>  include/uapi/linux/kvm.h                      |   2 +
>  .../selftests/kvm/aarch64/psci_cpu_on_test.c  | 126 +++++++++++-----
>  5 files changed, 202 insertions(+), 68 deletions(-)
>
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
