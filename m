Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9461B2B70B6
	for <lists+kvmarm@lfdr.de>; Tue, 17 Nov 2020 22:10:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BAB84B74E;
	Tue, 17 Nov 2020 16:10:52 -0500 (EST)
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
	with ESMTP id wzDeI3I0CFJc; Tue, 17 Nov 2020 16:10:51 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 030A94B745;
	Tue, 17 Nov 2020 16:10:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 798704B735
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 16:10:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i57OVAivhDwz for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Nov 2020 16:10:48 -0500 (EST)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 657334B732
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 16:10:48 -0500 (EST)
Received: by mail-lf1-f67.google.com with SMTP id j205so32142167lfj.6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 13:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3qvLQy5uXFpIrg6tKYvqeLz2PzWU29eE1D3GlGEf7hA=;
 b=RQGc5BDlqCxPdo6QO0uTD/X3Hcx7aIM9LLRlWuTXrjTLDGNHalufPHT/+S1VuDQ5IE
 ZfRVxzTnC/a6N8EPqu0vPEQrEZy/xiR+EYgC+CEnT3+eP5hDz3tKZNIfEnM3hoQlmjL2
 CzNNGCo6/aA9uoXrwKktURNVP2nGcbx8ZMsydDJ81n2DQPR8yVbJBC3FlyeDJ0SOOz77
 2Uu9uL4oZJMJFINAYCg1lkMPoonWbBw018agy/RRIufINIn8G3jx5XYxKdrQILDngm85
 K4krG8aRB8y2AitVMIjEjv4b8BNhYV/6oh9MxzLUSAygxd8M0evOGAHQ3nrTCkMoO53F
 yPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3qvLQy5uXFpIrg6tKYvqeLz2PzWU29eE1D3GlGEf7hA=;
 b=rQMoOJ7Bhk1bfF1UYiniad/1ZWxIuteXgijkE12RG07uxTITi9sKTHjRAvisn/rXIb
 4Ph0NqNGdKoqER2idp8p6UKho54ghk59CPdgzRh6dG63nP/wFH6j7zxLHP/FRg6CKl7z
 tPqXsd0Q6opH21HcKhacg7IIOCbsPi0lQs+EZwH1FhX/J0KC0PO2AO3PU3OM+CAa+utz
 0oDgWIbQRVunYXvP//03QWB+9F+nymQf88wSPx9y7VY7TmPUMyZeSGZzlg3ZW/vV3zNl
 HU/9z4xILrD+R/3n6ZXg+vhs/EzCHGgzfjdLkJ3pRjxGJG63mv6RTXTQw2JBS4+35SBP
 1WhA==
X-Gm-Message-State: AOAM531qt/Vkt98hFUcfjsRzT5j3FFALb3vR5KenXk7MZ/6HZfDsRsxt
 nbWnMb+PcFEgICbPBObZV3Epm1/GHYikAqEDWKJQRA==
X-Google-Smtp-Source: ABdhPJxkBvjPwPqdZfFC0v46RqXEY3h0mC9gU0DWW5QyqY1whnhbT6cH9oIiB3zYhnME/r0H//P+GtfhkSgfahbkzRc=
X-Received: by 2002:a19:8686:: with SMTP id i128mr2305571lfd.333.1605647447061; 
 Tue, 17 Nov 2020 13:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20201113182435.64015-1-andre.przywara@arm.com>
 <20201113182435.64015-4-andre.przywara@arm.com>
In-Reply-To: <20201113182435.64015-4-andre.przywara@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Nov 2020 22:10:36 +0100
Message-ID: <CACRpkdZq=RBrJ52vbSguTQBdyfACNQxyCLA6yvtVqZvv1ndaCQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ARM: implement support for SMCCC TRNG entropy
 source
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Theodore Ts'o <tytso@mit.edu>, Catalin Marinas <catalin.marinas@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, kvmarm <kvmarm@lists.cs.columbia.edu>,
 Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Fri, Nov 13, 2020 at 7:24 PM Andre Przywara <andre.przywara@arm.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
>
> Implement arch_get_random_seed_*() for ARM based on the firmware
> or hypervisor provided entropy source described in ARM DEN0098.
>
> This will make the kernel's random number generator consume entropy
> provided by this interface, at early boot, and periodically at
> runtime when reseeding.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [Andre: rework to be initialised by the SMCCC firmware driver]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Excellent idea,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
