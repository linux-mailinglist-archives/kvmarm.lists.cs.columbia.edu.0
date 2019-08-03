Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 781948048D
	for <lists+kvmarm@lfdr.de>; Sat,  3 Aug 2019 08:03:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E42394A530;
	Sat,  3 Aug 2019 02:03:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1WcpXqqs8b3m; Sat,  3 Aug 2019 02:03:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B24B84A523;
	Sat,  3 Aug 2019 02:03:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B9D54A500
 for <kvmarm@lists.cs.columbia.edu>; Sat,  3 Aug 2019 02:03:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ceFlPfUv2LYR for <kvmarm@lists.cs.columbia.edu>;
 Sat,  3 Aug 2019 02:03:07 -0400 (EDT)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5BB684A4F4
 for <kvmarm@lists.cs.columbia.edu>; Sat,  3 Aug 2019 02:03:07 -0400 (EDT)
Received: by mail-wm1-f65.google.com with SMTP id l2so68200969wmg.0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 02 Aug 2019 23:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/bB8Tbrp6SJ+FGTr4csz+1D60Rf87D30EGS4/Cd4pOQ=;
 b=DXGGEJulYr067JIEcr20JZzPb63wmyv+jP0bQzkmlw4gOzctVEoKHWyq9maKwegyim
 wUGVlIlA0vtC1dqfAwBEYsIfePyEUR3g+p4oBLpd8FuzP3sSKHw7Emd6sbEs2oiq6Zl9
 0YIbTHoRzQnEzQ9G+QyKV4DPHB0J+K0d1800FJYe3CX/R87CBoCaPiHATuEWLIv9Iw2o
 K5hHBt5CITU4fh4JFV/RaVDj41csJgJOOQaV0sdS25uT4/zCmma0RKa3YiAtj+F1PmXx
 bZ6mPrERRBt/q05CQ+nWa92K8dfvHuLYxVWQ/HvBi4xBf8Z62MbfyhV9ImGOoYWFG4ov
 vpZQ==
X-Gm-Message-State: APjAAAVNxfwBnDbhzD9n10MgUfqTinqlZ+Em/WrkUC9/zkYxL3gSe+uq
 +Ymu9SoMEV0gMT3FS6gMh3YS+Q==
X-Google-Smtp-Source: APXvYqzmXtzAIcuj5yKJypFgHWm6U9OgstcVcB6Y5ltzAT+GHKA1HqHuRFuXPJ+KmmZti0tSUDoYrA==
X-Received: by 2002:a1c:5f55:: with SMTP id t82mr7517714wmb.111.1564812186238; 
 Fri, 02 Aug 2019 23:03:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff?
 ([2001:b07:6468:f312:4013:e920:9388:c3ff])
 by smtp.gmail.com with ESMTPSA id f7sm77310740wrv.38.2019.08.02.23.03.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 23:03:05 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH] arm: timer: Fix potential deadlock when
 waiting for interrupt
To: Alexandru Elisei <alexandru.elisei@arm.com>, kvm@vger.kernel.org
References: <1564392532-7692-1-git-send-email-alexandru.elisei@arm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <edcac547-58e1-4031-6ee0-e8f7daef0d15@redhat.com>
Date: Sat, 3 Aug 2019 08:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564392532-7692-1-git-send-email-alexandru.elisei@arm.com>
Content-Language: en-US
Cc: marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu
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

On 29/07/19 11:28, Alexandru Elisei wrote:
> Commit 204e85aa9352 ("arm64: timer: a few test improvements") added a call
> to report_info after enabling the timer and before the wfi instruction. The
> uart that printf uses is emulated by userspace and is slow, which makes it
> more likely that the timer interrupt will fire before executing the wfi
> instruction, which leads to a deadlock.
> 
> An interrupt can wake up a CPU out of wfi, regardless of the
> PSTATE.{A, I, F} bits. Fix the deadlock by masking interrupts on the CPU
> before enabling the timer and unmasking them after the wfi returns so the
> CPU can execute the timer interrupt handler.
> 
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arm/timer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arm/timer.c b/arm/timer.c
> index 6f2ad1d76ab2..f2f60192ba62 100644
> --- a/arm/timer.c
> +++ b/arm/timer.c
> @@ -242,9 +242,11 @@ static void test_timer(struct timer_info *info)
>  	/* Test TVAL and IRQ trigger */
>  	info->irq_received = false;
>  	info->write_tval(read_sysreg(cntfrq_el0) / 100);	/* 10 ms */
> +	local_irq_disable();
>  	info->write_ctl(ARCH_TIMER_CTL_ENABLE);
>  	report_info("waiting for interrupt...");
>  	wfi();
> +	local_irq_enable();
>  	left = info->read_tval();
>  	report("interrupt received after TVAL/WFI", info->irq_received);
>  	report("timer has expired (%d)", left < 0, left);
> 

Queued, thanks.

Paolo
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
