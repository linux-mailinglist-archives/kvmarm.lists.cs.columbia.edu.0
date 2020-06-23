Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CB040205A1A
	for <lists+kvmarm@lfdr.de>; Tue, 23 Jun 2020 20:05:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 586494B16C;
	Tue, 23 Jun 2020 14:05:23 -0400 (EDT)
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
	with ESMTP id NA-PUlKiKsvm; Tue, 23 Jun 2020 14:05:23 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5511A4B16E;
	Tue, 23 Jun 2020 14:05:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AED1C4B16A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jun 2020 14:05:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgSAhDa4JPHF for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Jun 2020 14:05:20 -0400 (EDT)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B37834B169
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jun 2020 14:05:20 -0400 (EDT)
Received: by mail-ot1-f65.google.com with SMTP id s13so17573056otd.7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Jun 2020 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9GN+8WTXztbPfYorYujs4eOD7e69NJjv7MfYuASwATI=;
 b=rEBKHwpizm7Ptg3MSiXYR8mzHuu8RnTRZP8VL1dAlWFQOKnDktMPA1IyFJQjPiGpVV
 pZtSkYGqqTynz7BB9YYOfux0/mCdLQUUuL5D9URSyWPmiAQdidnZGAXkNAHLusVZml+h
 tdXMNHUpXyFOBTzoS9rjOpikizamG9FpjxatFwZwfaDFHVhMa3Eod+t4ZoSJ6N2uSboN
 8uMmhJGzX/7JhY6Mz70d0UIlj4Gont7X2CTkAkBjeqYQPjIzrH6E7TrHR0q0OkU3Xolg
 jAjVBE6d7j++wjpVoK0Thw4OCHr1pU6jLh/0Xw3gcuvhucCis9iZ/0yiIYW2TpdRTu/z
 1DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9GN+8WTXztbPfYorYujs4eOD7e69NJjv7MfYuASwATI=;
 b=GaqgW1OXs4mdNpNhpxBWxBFZ+XNEVmgW24vidMWE4B2EeidcsQ0KbPN44vOZ+MO9RZ
 4Pm5msAjRLcsWihn84LSM1XXfCjDumSsg8O+eAmQmVCBgCGkyH5shzxiOliDcfAniq3s
 IPP49GkyM7Y/RzvPlEDkY2mN/y/LcFHZyM0j4HX+kfp4Qph8Pt5nYh9MS5iqnYX+hnXP
 VMkqQIYvW/nUFIO48Rn+TGR3Q2R+/3CyWtTReUG6YMTk+XyUGFBG+tFORlDdPc2UaCyk
 cbiIwh1OavQ9V4Nltf6KKYaLPjz2DZuAPe4fVOZlulzKInbFQsvz386Z8n9eTSvNJ/kQ
 u0iA==
X-Gm-Message-State: AOAM533FZZLtNXozYzHUbSZ1E39y9ys3nMsV3/FUKNGcboqFFnQ/qF0T
 ++ELN1w/EkdxEwupXsCUZiJh4114kFF/g2cmK0IEAw==
X-Google-Smtp-Source: ABdhPJx+g/sUUdsTYxZOwpinRxMoNVeLqgTGnTNLSG5BjKxv4gWdiz5xp9V6RR8ykHO/RAqJZw++35u6gPTMVvxts0c=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr19304773oto.91.1592935518913; 
 Tue, 23 Jun 2020 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200617123844.29960-1-steven.price@arm.com>
In-Reply-To: <20200617123844.29960-1-steven.price@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 19:05:07 +0100
Message-ID: <CAFEAcA8Myn_QEjfk4Ka604PDAUAWXs6dLUY5bEQ98C__oMsmhA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
To: Steven Price <steven.price@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>,
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

On Wed, 17 Jun 2020 at 13:39, Steven Price <steven.price@arm.com> wrote:
>
> These patches add support to KVM to enable MTE within a guest. It is
> based on Catalin's v4 MTE user space series[1].
>
> [1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com
>
> Posting as an RFC as I'd like feedback on the approach taken.

What's your plan for handling tags across VM migration?
Will the kernel expose the tag ram to userspace so we
can copy it from the source machine to the destination
at the same time as we copy the actual ram contents ?

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
