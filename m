Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 264182B70AC
	for <lists+kvmarm@lfdr.de>; Tue, 17 Nov 2020 22:09:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA1024B78E;
	Tue, 17 Nov 2020 16:09:08 -0500 (EST)
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
	with ESMTP id W2iIrcT3N5sx; Tue, 17 Nov 2020 16:09:08 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A5C074B77F;
	Tue, 17 Nov 2020 16:09:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DE2064B6F8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 16:09:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1hBZjyIIyEXY for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Nov 2020 16:09:05 -0500 (EST)
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D3D974B77C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 16:09:04 -0500 (EST)
Received: by mail-lf1-f68.google.com with SMTP id j205so32135848lfj.6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Nov 2020 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tP9cJu+hNdrnsOn172LWwEbwH/Ks2TMbbDHgDB86rj4=;
 b=aMD+GTc2hgNt5hJdJ56z4JB9b0iJKM8IpM+fayTeBlPntks9GCHZbF+X9JPBYjvwyf
 I4D04AWxW6AtXl7fxyvDYOhvJvqnU1LoFK4bMHOi5ZM1WB5Pj+l99asNfaMs+BbbWo9s
 9hNZMzF+Hkl7KJ2jJ4thTxJ0HiDbpb+0uZdymrHD9WWPspNdV9vG4I0aa6abXX6L25bt
 vq1/LBlie6cXI1Tj/OdmFf2MekXKuHQVD2hg0AQmbCZZr+rlDxenLiiOnlPWEEWHvuuh
 XQzLHgLZSfHkAWfdsWePtMRL5RKw6/gwVtsKtuBQFB16Cm2yCIMKj6gJTQmOSCQCBP9B
 enMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tP9cJu+hNdrnsOn172LWwEbwH/Ks2TMbbDHgDB86rj4=;
 b=d3A5VNizY8vEAouSaeY7FIrphR75yph8xWpcHojniscNeG6xVdOdsJrW2K+uHMaS/j
 WNWVACwTC1jVmP47ojLQO2ARkD0Kf2nJ/yor8YB1Uuoxly/OHIGl1rF4hC3rX9rV0lf8
 AtARKYZ38EbQHFXgH/8vTyupfrZ6DrLXNx4OvV6xsvZMSfnDnzCK3zY9fBi9d6iZXohY
 nHV23f0m97WHrEtwEBu48LCCqpLyz8wNelVtDyciP9M+bGhPjaCVNRSNPB69JAJDUHCF
 kw9p/r5L2E+uv447Kg1+IFEHXt1Z1QXvUKHvOOv+100Q0WyhlrMpVA3WYy0tUif9Pnz1
 nqxA==
X-Gm-Message-State: AOAM533qTfasSUyBI3+x+N+K3EtB3PSIXcqBytB2fkKqnqjjmo1yCLzd
 BWw9mPXsGeUBpBy5cnnEQ9zbmaRvb4uXSiZX1x/Ykw==
X-Google-Smtp-Source: ABdhPJwvNCZp8XRFkmCadWv423VbSz/2KepxoylHmLLrM3J5p/oDV3m3p0jDqJ1J5/8uIJ66xnvr0pmRzMbvuLjIh1Y=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr2610499lfc.260.1605647343529; 
 Tue, 17 Nov 2020 13:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20201113182435.64015-1-andre.przywara@arm.com>
 <20201113182435.64015-3-andre.przywara@arm.com>
In-Reply-To: <20201113182435.64015-3-andre.przywara@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Nov 2020 22:08:52 +0100
Message-ID: <CACRpkdb3fUcidrFabJ-LGQUEJmoOfF29bhOoUhRjA4OA=YBBew@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] firmware: smccc: Introduce SMCCC TRNG framework
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

> The ARM DEN0098 document describe an SMCCC based firmware service to
> deliver hardware generated random numbers. Its existence is advertised
> according to the SMCCC v1.1 specification.
>
> Add a (dummy) call to probe functions implemented in each architecture
> (ARM and arm64), to determine the existence of this interface.
> For now this return false, but this will be overwritten by each
> architecture's support patch.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
