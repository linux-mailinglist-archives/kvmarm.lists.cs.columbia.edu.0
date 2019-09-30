Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7636DC21B9
	for <lists+kvmarm@lfdr.de>; Mon, 30 Sep 2019 15:19:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0E0734A7E1;
	Mon, 30 Sep 2019 09:19:30 -0400 (EDT)
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
	with ESMTP id sl-p2Deg2rfP; Mon, 30 Sep 2019 09:19:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E32954A7DC;
	Mon, 30 Sep 2019 09:19:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F9B44A736
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 09:19:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1m3Z2b06gFst for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Sep 2019 09:19:26 -0400 (EDT)
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 89CA64A6A5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 09:19:26 -0400 (EDT)
Received: by mail-oi1-f195.google.com with SMTP id x3so11080272oig.2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tvF2rhjIU40oHZTkD8AiJlAuhk6N45ACdpW2yo/HLqU=;
 b=PO3eOfC/q3wl/KRr0kWCAelNHERyjJNf3sYliZiXHahyxh4ZRx2ySTuhPxn1dLYQtz
 Ye7DkO0wnQTjwjmUaxO8t8JgHdk/PerRiFSCyrNFh5SbjlOxqUbk17JiIevIdEtWEmqn
 D+03S22BPz+8zeYwZv2Bei/nLUk1RNyudNjaeErSn+O9FIlqczoufsYOsZOoGm5F3MtH
 oAOfw9c/il8g2OxXfN5HbM+5V+PC16ESN+8dUaf3o354nFgG9uXH+SoowTtN6gelXjGF
 2f7a0ilmT8oGOJV2PKIB+OsJ1h0c3lxdDtGuZ78Fa7qJuhxDICK5hsWj3CFXe07wW8IK
 nuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tvF2rhjIU40oHZTkD8AiJlAuhk6N45ACdpW2yo/HLqU=;
 b=jIsKZk/NsiOe5mEvDqDKUlJCTFzoPyTn1gxmtClayvGY/j08QYAgk6vyBy08N99FaC
 nOA294UxxEcU5TTi3ejIWaVhOHlgE/YsTgJRuD9sTnUeMblbSw1IZ/NG7k0XxWmG2abJ
 7bRw64On4i9BmJXRL3TfHcOPEsSxF5BzaAhWktpJgeeiBa+XgT7CYFeDJwjY+TSlA9pC
 G5nI6G0WzlW08dIjLzBbDVgMd0fOGADEpTOfrjIoBWZZiGLc+AvaIbAgNv97mvZdJ/0h
 5QupVs8l0TPMYrETn8sETODIqlpW4BoUTGuZ263zRrTWtWBN/UMWc2oOSF+abcDvP3M0
 Q8cw==
X-Gm-Message-State: APjAAAXoeYMfHMa4hT3FGvAFVOmYDBG4ySvxsuOT4ieCQn43+TJSwZk/
 Fm8f2xIy0e/FHLVsAL/iRpIl8UrbyjTU1uXupyapOA==
X-Google-Smtp-Source: APXvYqxkDA2j7mElW4UnsVMO8OvEuYOnFf4j7HG8KejxC44MOi2OBa9meGhMJ+mXVoFqHVS5fsi1jnMYUOeVkuK8Ih4=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr18336111oif.98.1569849565968; 
 Mon, 30 Sep 2019 06:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <1569338511-3572-8-git-send-email-guoheyi@huawei.com>
In-Reply-To: <1569338511-3572-8-git-send-email-guoheyi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 14:19:15 +0100
Message-ID: <CAFEAcA9ZHs=GdJ-_Ap1PWdgDjSDBnnRqG1UkMGx_FiqCJ5ZyGw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/12] arm/sdei: override qemu_irq handler when
 binding interrupt
To: Heyi Guo <guoheyi@huawei.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu,
 qemu-arm <qemu-arm@nongnu.org>, Dave Martin <Dave.Martin@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
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

On Tue, 24 Sep 2019 at 16:23, Heyi Guo <guoheyi@huawei.com> wrote:
>
> Override qemu_irq handler to support trigger SDEI event transparently
> after guest binds interrupt to SDEI event. We don't have good way to
> get GIC device and to guarantee SDEI device is initialized after GIC,
> so we search GIC in system bus when the first SDEI request happens or
> in VMSTATE post_load().
>
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>


> +static void override_qemu_irq(QemuSDEState *s, int32_t event, uint32_t intid)
> +{
> +    qemu_irq irq;
> +    QemuSDE *sde;
> +    CPUState *cs;
> +    int cpu;
> +
> +    /* SPI */
> +    if (intid >= GIC_INTERNAL) {
> +        cs = arm_get_cpu_by_id(0);
> +        irq = qdev_get_gpio_in(s->gic_dev,
> +                               gic_int_to_irq(s->num_irq, intid, 0));
> +        if (irq) {
> +            qemu_irq_intercept_in(&irq, qemu_sdei_irq_handler, 1);
> +        }

I'm not sure what this code is trying to do, but
qemu_irq_intercept_in() is a function for internal use
by the qtest testing infrastructure, so it shouldn't be
used in 'real' QEMU code.

> +        sde = get_sde_no_check(s, event, cs);
> +        sde->irq = irq;
> +        put_sde(sde, cs);
> +        return;
> +    }

> @@ -1042,6 +1152,17 @@ void sdei_handle_request(CPUState *cs, struct kvm_run *run)
>          return;
>      }
>
> +    if (!sde_state->gic_dev) {
> +        /* Search for ARM GIC device */
> +        qbus_walk_children(sysbus_get_default(), dev_walkerfn,
> +                           NULL, NULL, NULL, sde_state);
> +        if (!sde_state->gic_dev) {
> +            error_report("Cannot find ARM GIC device!");
> +            run->hypercall.args[0] = SDEI_NOT_SUPPORTED;
> +            return;
> +        }
> +    }

Walking through the qbus tree looking for particular devices
isn't really something I'd recommend either.

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
