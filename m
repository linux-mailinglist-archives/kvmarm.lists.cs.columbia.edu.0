Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD73FF4CE
	for <lists+kvmarm@lfdr.de>; Thu,  2 Sep 2021 22:21:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6A3AF4B11D;
	Thu,  2 Sep 2021 16:21:00 -0400 (EDT)
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
	with ESMTP id xMZWeQwpgr2E; Thu,  2 Sep 2021 16:21:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 592984B0FC;
	Thu,  2 Sep 2021 16:20:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AA4394B0CD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Sep 2021 16:20:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnH0vVUEkOri for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Sep 2021 16:20:56 -0400 (EDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 99E5C4B0A0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Sep 2021 16:20:56 -0400 (EDT)
Received: by mail-lj1-f180.google.com with SMTP id s3so5809814ljp.11
 for <kvmarm@lists.cs.columbia.edu>; Thu, 02 Sep 2021 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hreAElmr17ZL4OZVVbHmIMZ79i4fbz6kVkns1rTJnHc=;
 b=HCYGedbiW5sxO0PtzzBBe+DYAD81uoV3SwQYKClx0kwNbPRA5ElojhCrT3jnR4uhRd
 HLxyprxHi7xQasx3DFgNlTj/yg1d0j46tzGDI1S8+hIdpRX9R1nPqC6KPQ5zirF2eLrV
 WDmNqiVxfeaWTlBG45m02oSkp/x9Yu4g+rjx1xUpK1aFOMOU+I3ajhe5cEWguOx0iCHh
 kR/QtkZR4ZQBYPsR2sA6DjayNC4N6XiTfe9La6Wm0Kty9kskkGxLF3OHRbvTyhVxtEWe
 2lKIWZNF4S+geRas9yuWGFUU1fQPftnpoScaFM9gHMr2ZkBjj551yoTkTj+7+Hdr7gsE
 zz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hreAElmr17ZL4OZVVbHmIMZ79i4fbz6kVkns1rTJnHc=;
 b=n7PsdtIc9agjsNfaBny2C5Z0D1vukSdY3hZTbJYqbcAGfY55HRmNiSJnGGvnRomdVZ
 KYpAG0Ndcjb7bw3Q/Q1Bj9IurDMsPBO1DXKU0sTgwNg3GMbPxb4K8Sbz0qBzzRhLB6t/
 zD0a2L+9peBzXMG6dXbjzRqheC0Zf7GBNGtml4XUuM6SEQ8+tIm4vV+PZrsWd9wQYLtn
 Q7h+76c0GO1pn2lk9LGMnFEKUmYYjDEP9S3n9EW1TYeBuCCVUI/zbldcAKO172OagRdE
 vUwqhM1j/JImctdf4I9ZMwHmj/+UhOuRcvYF8vElLKAD09/eFjA/CTuS4yLNNjfdLlHL
 GFrA==
X-Gm-Message-State: AOAM531uBchrWbnMLcKNi+NEj6R8TeJyJeb2MedIL10ZobUHpPU3bBm6
 FN/9hWA2xCosYShUbwYWAgHHyq2rVmQl5hf+Jd5PyA==
X-Google-Smtp-Source: ABdhPJxtMphhWy4wchNGwPu9Zb74KqIJd30juhzzc4H9TTlbKYRgu/wGvWW5BjAXM4aFpOFXzfBrOucRHxro2nUvpiU=
X-Received: by 2002:a05:651c:33b:: with SMTP id
 b27mr65586ljp.314.1630614055208; 
 Thu, 02 Sep 2021 13:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com>
 <20210901211412.4171835-6-rananta@google.com>
In-Reply-To: <20210901211412.4171835-6-rananta@google.com>
From: Oliver Upton <oupton@google.com>
Date: Thu, 2 Sep 2021 13:20:31 -0700
Message-ID: <CAOQ_Qsg1VPf+YBG4fvM2ddWMp82h7QRzdzO-iWNF7d6-EsJ4VA@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] KVM: arm64: selftests: Add basic support to
 generate delays
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
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

On Wed, Sep 1, 2021 at 2:14 PM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> Add udelay() support to generate a delay in the guest.
>
> The routines are derived and simplified from kernel's
> arch/arm64/lib/delay.c.
>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/include/aarch64/delay.h     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/delay.h
>

Reviewed-by: Oliver Upton <oupton@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
