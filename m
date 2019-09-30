Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9ECC219C
	for <lists+kvmarm@lfdr.de>; Mon, 30 Sep 2019 15:15:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 884AA4A7E5;
	Mon, 30 Sep 2019 09:15:47 -0400 (EDT)
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
	with ESMTP id akHPrX-TdhKw; Mon, 30 Sep 2019 09:15:47 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A15B4A770;
	Mon, 30 Sep 2019 09:15:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F15F4A704
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 09:15:45 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YymvN9DNCM4B for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Sep 2019 09:15:44 -0400 (EDT)
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A25334A6FD
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 09:15:44 -0400 (EDT)
Received: by mail-oi1-f195.google.com with SMTP id k20so11064487oih.3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Sep 2019 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jVVEvUCK/emC3iUCb0l7K7+9YIBMzhWZQM52MAW23W0=;
 b=Nq8irpzkOOU/Qk+FAEiw7mFJD3ED6x3p7RuFi3tcphxcKOTzPLv1rLkbm2e+p0opFz
 0UEW0u32jfZzOUrbWh7ydkm94WJv0uuQzjFwAZrAYAfHa4BcvIXQbG8wzssg1Wn+V9un
 5/Ls5khPQVF728b7aVK8k8i4+cX7AXRrKLpgq7i7uYatXGLbyH2K5LuLFeFrEb7JU0Jf
 ru05sDSWcbXopIAvYSzdORMVbxEvtThAiCDRA7uPHKSD6ACGCANYwf4lwbwx802aIrHI
 2Z2UWOgHCOIeV/nBlEQ3NQhTTdKCLVo8wWA3Digito5OsA120xeodDO9NfrEAlc7SnI+
 yv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jVVEvUCK/emC3iUCb0l7K7+9YIBMzhWZQM52MAW23W0=;
 b=TXRI2DacitYQRS7rZHgjvdok5hd7ck0Wx0DwBjHioif6Hm6RlmVGDiSzWmdBDmZ6bm
 iOQzkPN3mm2i0xWb/lyf4QQoyf7Ezx3FPw9lUaaM19tTZ5WDwAE5rYBzu18kTnxR+otx
 S6B1mWHHPZ84QkVyXmT4BcbFK0bB5V7zxc5D8ms6wxjqg94A2k8vdI51VzRwQTltUnIH
 d6RWZCBQ3R3rIX+xMSvtY/FU5TRIm/CIAVHwU/uiDviKGk2LK+IJLnq6rfC+M0wU5Z49
 xLwadQCe9+buVxekWcVjzK6WbZUBGV+VJacxtlcoisR427V/5n3a8OpFuosHECYINY59
 SykQ==
X-Gm-Message-State: APjAAAWecd1/R5tuRJXNcxEZ9hPzwtSWq3Z6nqiJhp+nnJSS8NTICF6r
 JXYrxxCtrpCWAXkQjnVT5VmJP/Ub5VSeBIeURi52ww==
X-Google-Smtp-Source: APXvYqwR/uvkoTEDQ6kjF9B5yRo9oWxbFNBjwD4EdIfTijDBaNwNgNDAKLYvIDj2ndcXMo57HW8oLx6+SCdOlzvOr+o=
X-Received: by 2002:aca:53d4:: with SMTP id
 h203mr17266374oib.146.1569849344040; 
 Mon, 30 Sep 2019 06:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
In-Reply-To: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 14:15:33 +0100
Message-ID: <CAFEAcA_ztr0_Bu9d__dSr9oH75s2DSd5=6NZvVMrxuDTxf31mw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] Add SDEI support for arm64
To: Heyi Guo <guoheyi@huawei.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave Martin <Dave.Martin@arm.com>,
 qemu-arm <qemu-arm@nongnu.org>, kvmarm@lists.cs.columbia.edu,
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
> As promised, this is the first RFC patch set for arm64 SDEI support.

Hi; for the benefit of possible reviewers who aren't familiar
with every corner of the arm ecosystem, could you provide a
summary of:
 * what is SDEI ?
 * what do KVM and QEMU want/need to do with it ?
 * what is this patchset trying to solve ?

That would provide some useful context for trying to
review the patchset.

thanks
-- PMM
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
