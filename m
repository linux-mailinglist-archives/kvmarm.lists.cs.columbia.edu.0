Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD71B31B
	for <lists+kvmarm@lfdr.de>; Mon, 13 May 2019 11:44:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B9994A4F3;
	Mon, 13 May 2019 05:44:22 -0400 (EDT)
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
	with ESMTP id aASgD3hq20lR; Mon, 13 May 2019 05:44:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 19E904A4EB;
	Mon, 13 May 2019 05:44:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0C3F24A4E0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 May 2019 05:44:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z-Vld5nTw+PR for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 May 2019 05:44:17 -0400 (EDT)
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 886514A477
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 May 2019 05:44:17 -0400 (EDT)
Received: by mail-ot1-f68.google.com with SMTP id u11so711511otq.7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 May 2019 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TXYVyM1elY/e/gwr441pJoxadHFYtIz0EH7uksaUA00=;
 b=GQawiz8mlWxh/yf7/DiecVKQmIl48uHHnfbDs6NwSWdi9y+D4Kf5bCLwsxaGnEIUZf
 nrUE6T/lrxJFWLvhe10ToW17PX+6WZ7PWEf4xSPOXb8k1DSLt7O2Juet2Lgt5lC759eq
 g1/2yARQtJwd9CIw7tB136d5woqAAOHI8bNZLOCKr92a6YDS5/J3WlNpe+gEZ05/VpR8
 xBK5t6xm5FLjWabkFaYeqqAUPHhVrHYsN5daplbQKzmXrU6omOOpWIp9oBDSDKGEQLEE
 NVXTCZ3tJt/VjAwmPbgBz0t9AjLNN3OsPpyEBbIDeOrWVTKi2ZQkX7y2xbus1kqxTGmq
 bnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TXYVyM1elY/e/gwr441pJoxadHFYtIz0EH7uksaUA00=;
 b=WuDy+5gabG+2g+Wwribi23IxSSu9xdjF8lDV9roxpxP3n8cxOKAlq8UF9x8lR0pRML
 6GWxPrgZNt9LlERTv3SaNugNK3yOGUlLjOPatHMjEjFpACxeEph52BIvXwHG6lKm/7nN
 /E2jN3hYXCUfw/DwjaYvZLHqlg9qCMU32uvSPwlhzQzQvRGR2vaNbSA6kNfXO4DM/Yup
 xnqKVic+xmjay2int1/j6ojAJxnQ4LeMUtxCLz1fo/Jobqq39g1K7dGALxmfkA4/STQU
 hXX1JypDSAAWsDBmL+Z8ZcVGHjnKebC5hmKTa9rXGxarVmpal9PBmx36ToJkRZn3d8vI
 w3Rg==
X-Gm-Message-State: APjAAAU87KSmnVxCxQfr3KUshUNlwGi7ySP1G1Rm5Zkshsy+PinK1T6e
 JCgaVkce01Ws+drzZq1RXspADpSHtveAdJbi3Km2Ow==
X-Google-Smtp-Source: APXvYqzaNT+TgVDjenXnFHOeex93upzugiVccOLalDaA6Ieg0c7UGMs4NUZH4TszrKklUoDkyyO8dIHeKn7h76sHRXU=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr14592075oto.151.1557740656833; 
 Mon, 13 May 2019 02:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <1557728917-49079-1-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1557728917-49079-1-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 10:44:05 +0100
Message-ID: <CAFEAcA-S6Kh8yUqVZVA8gtDdRscgVaTfC4CwxngoS2ZPt6K9ww@mail.gmail.com>
Subject: Re: [RFC PATCH V2] kvm: arm64: export memory error recovery
 capability to user space
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 kvm-devel <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kvmarm@lists.cs.columbia.edu,
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

On Mon, 13 May 2019 at 07:32, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> When user space do memory recovery, it will check whether KVM and
> guest support the error recovery, only when both of them support,
> user space will do the error recovery. This patch exports this
> capability of KVM to user space.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> v1->v2:
> 1. check whether host support memory failure instead of RAS capability
>    https://patchwork.kernel.org/patch/10730827/
>
> v1:
> 1. User space needs to check this capability of host is suggested by Peter[1],
> this patch as RFC tag because user space patches are still under review,
> so this kernel patch is firstly sent out for review.
>
> [1]: https://patchwork.codeaurora.org/patch/652261/
> ---

I thought the conclusion of the thread on the v1 patch was that
userspace doesn't need to specifically ask the host kernel if
it has support for this -- if it does not, then the host kernel
will just never deliver userspace any SIGBUS with MCEERR code,
which is fine. Or am I still confused?

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
