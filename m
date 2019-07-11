Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DAB336535A
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jul 2019 10:51:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 732C94A4E6;
	Thu, 11 Jul 2019 04:51:28 -0400 (EDT)
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
	with ESMTP id mIEbrMsWMAz4; Thu, 11 Jul 2019 04:51:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 048734A4E9;
	Thu, 11 Jul 2019 04:51:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8F2E4A4CA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 04:51:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id av798ZGIgax4 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jul 2019 04:51:22 -0400 (EDT)
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9C0624A49C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 04:51:22 -0400 (EDT)
Received: by mail-oi1-f193.google.com with SMTP id t76so3905314oih.4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jul 2019 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k/zX7qRMlJI8fUYktt5/frIONjiVDpZRrgUUq3EkUTc=;
 b=s+p5Rqsk09xdh4xS0WW1f/H4FX3ewk3iHV3RN01z+R3dZhbTECk4DovbE5aSicjP1J
 jwKXyuonvUvH9IoB+hOY4ff0IkyqGiYn4pxGDbF3yb/GyzMIXohihhNAEI2mEOokYQvQ
 jhLhtPqDv3/rkhuoALCCdFHi3hCn4l1Tt5kWirDEL0v7Xrrj9kIMQmOL4NBkef493ivh
 0q4+hngG4T0asJ5oDFOc/FPhwhj7ehsqjwEZZOpQ4EPofT4ObRq84QOEsTpEx62v44Ll
 xGe+96g+swpR5I7BVk1zNb7ZGkpxbkgLEC3elu+RkrqH8C2f7FGzgWjCCICopT3HHxLD
 e2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k/zX7qRMlJI8fUYktt5/frIONjiVDpZRrgUUq3EkUTc=;
 b=sJbJ9leN0viC1ZueQAXqQqbRymB0x8Br++7GcT/ANc8lk1X/Ft48a70r1FyuVu5ydp
 Y7wAyXg5MWHCx2szXewKf9FvVnnIGA2VFg4+uKmf9wN/i2qPVfIB59I/XKxtJw9TfKwF
 iNnJhCXErJRACl9n96E8pw+BXknWwsLuIzoKO3sGe7M7ZdrsepHvhIZACJy/xzod6zXO
 4cWtdRH8tXiRCsvFhXbFLFhvVsauH0S+2MML/NqjlFYP/XXVhb4r1YxXgD9g6EpFvKo6
 TEHBMePDczWAwj99cUkGfH4LY01615sYwlq5BwIQZqICQK+Kwgl9Ls6yNIOPqnjw9o+K
 DCDA==
X-Gm-Message-State: APjAAAWC1vIiNPuLZULekOe2PaZIYlP8SDzKlrI7UtSs+Qs1v7doRkdA
 r559qUAT4wRP09VlTWnSpWmh/6HNSTTtZ4+7vGZpTQ==
X-Google-Smtp-Source: APXvYqwN36w+hCesmo+OCwkoa7l8eUf1QaX3sqrlCqwBWedZ6AgvlD2qKx9fLYO82J5xohKuC9GzDxOHWqaxAbCxvEo=
X-Received: by 2002:a05:6808:d4:: with SMTP id t20mr65327oic.170.1562835081962; 
 Thu, 11 Jul 2019 01:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190710132724.28350-1-graf@amazon.com>
In-Reply-To: <20190710132724.28350-1-graf@amazon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 09:51:10 +0100
Message-ID: <CAFEAcA81mQ780H5EY8uV6AvbXzeZA60eCHoE_n9yzeZgw+ru4w@mail.gmail.com>
Subject: Re: [PATCH kvm-unit-tests] arm: Add PL031 test
To: Alexander Graf <graf@amazon.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, kvm-devel <kvm@vger.kernel.org>
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

On Wed, 10 Jul 2019 at 14:35, Alexander Graf <graf@amazon.com> wrote:
>
> This patch adds a unit test for the PL031 RTC that is used in the virt machine.
> It just pokes basic functionality. I've mostly written it to familiarize myself
> with the device, but I suppose having the test around does not hurt, as it also
> exercises the GIC SPI interrupt path.


Have you tested this against a real hardware pl031? I appreciate
that the scaffolding to let you do that is probably pretty
painful, but it would be interesting to test, because I'm
not really all that confident in the accuracy of QEMU's
pl031 model. (Notably there are some places where it absolutely
does not work like the real h/w; in some ways it's a bit
like "a pl031 that some imaginary firmware has initialized
and enabled"...)

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
