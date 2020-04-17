Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4056E1ADB42
	for <lists+kvmarm@lfdr.de>; Fri, 17 Apr 2020 12:39:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B096F4B265;
	Fri, 17 Apr 2020 06:39:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DO+c+oA2IbjZ; Fri, 17 Apr 2020 06:39:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA2204B1FD;
	Fri, 17 Apr 2020 06:39:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A7E54B11B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 06:39:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mfCfYqBYOjpm for <kvmarm@lists.cs.columbia.edu>;
 Fri, 17 Apr 2020 06:39:37 -0400 (EDT)
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 915F74B10E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 06:39:37 -0400 (EDT)
Received: by mail-oi1-f195.google.com with SMTP id t199so1671681oif.7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 17 Apr 2020 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5nzwvwmfOZPiP8MgyjxaZA/nsHP01MUTiYZMGpB1IQw=;
 b=fJJve5VChNmbNEyE4RssX36h1BaQECR7okQfuRd5/lvgpeqnRSSFMf6UHUJN51TZoy
 yBxm6Xp6Hf3beJCVLLZbmUa7H0buGWYWXf2RJai0DwtdXAGyeP794kyaG9EPYred/1W5
 RA5qtgjP7YLlnUqvMXUCX03/EPPbOLsBe4ga2HxOWBg3UB1EfV4egxSUUoqgXpHAc5Eq
 zNlpEGdcpprWXkQP8R0Lacvnt2Z1jo1DCqxrfql6f+2ERjxnXb9XD80nfWypdWP8cJII
 2fVmtq6XXSPs9XtIIGOlUCYGOdX78yTvcl71NFjS8gsyHV22VjrhlwQAaBRSi3PFuOT3
 NE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5nzwvwmfOZPiP8MgyjxaZA/nsHP01MUTiYZMGpB1IQw=;
 b=XJTnqCNsNEfUB7NdchYqH92NItmgT8seO1wFwx//rXI2rFV5rj3Jk0gaOjdivIiCcU
 +4iY+jr5t7yHtx9ZfPApWOCRwk3MnkecWfJak+wZYxz5XgNqXd+zIkOQwU7wyy8LC3Sz
 q3zHak+ZdElgFrCeh6ZMvihyXUoWFIzri/vWFLM0EsPW9sdmTdQ5jqkgKEeve82xkJRe
 aFEVTnwVhH+OXaEg9fSoNMW0L+FSA1A3+TA4nzZG4yjLL+DxeY0XXyr2DUur8ztmb5EH
 VMjzfACPS/A3zoiO/tQX1km9/CrSDp8FeA/XYFkk5iDg/aEVYcFl4WA3a/rhHfZpikaE
 0WQQ==
X-Gm-Message-State: AGi0PuaJyfBBJFMyBysp1M+M7S5ZfCtzbVJ3W4AWlp3cQKJ9Eegej/T4
 64dQ+cVZrp4fhTkqhQVoLF4sqPQjdvbAgEZ86uMeFg==
X-Google-Smtp-Source: APiQypKpsoCGBM8B+5ULU2Kgg0ztLFZk9VQ9Z2Ac/7fK1Wbv+hVQnub17Ti7V4wympxWG8jlVVSUhGkZZaXj36jfJ7A=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr1572060oig.48.1587119977020; 
 Fri, 17 Apr 2020 03:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-2-beata.michalska@linaro.org>
In-Reply-To: <20200323113227.3169-2-beata.michalska@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 11:39:25 +0100
Message-ID: <CAFEAcA_uWS+cVRk=BKra8AhsD+B1syVzhXeCMttSKwQDdo=j3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Beata Michalska <beata.michalska@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
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

On Mon, 23 Mar 2020 at 11:32, Beata Michalska
<beata.michalska@linaro.org> wrote:
>
> On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
> exception with no valid ISS info to be decoded. The lack of decode info
> makes it at least tricky to emulate those instruction which is one of the
> (many) reasons why KVM will not even try to do so.
>
> Add support for handling those by requesting KVM to inject external
> dabt into the quest.
>
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  target/arm/cpu.h     |  2 ++
>  target/arm/kvm.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/kvm_arm.h | 11 +++++++++++
>  3 files changed, 67 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 4ffd991..4f834c1 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -560,6 +560,8 @@ typedef struct CPUARMState {
>          uint64_t esr;
>      } serror;
>
> +    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */

I was trying to work out whether we need to migrate this state,
and I'm not sure. Andrew, do you know? I think this comes down
to "at what points in QEMU's kvm run loop can migration kick in",
and specifically if we get a KVM_EXIT_ARM_NISV do we definitely
go round the loop and KVM_RUN again without ever checking
to see if we should do a migration ?

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
