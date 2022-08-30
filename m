Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B66BC5A5AEE
	for <lists+kvmarm@lfdr.de>; Tue, 30 Aug 2022 06:54:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BCAAA4BB63;
	Tue, 30 Aug 2022 00:54:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7kx+OZPWAsB; Tue, 30 Aug 2022 00:54:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B8EAD4BB62;
	Tue, 30 Aug 2022 00:54:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B61DD4BB21
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Aug 2022 00:54:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VeMbNVd0tUfw for <kvmarm@lists.cs.columbia.edu>;
 Tue, 30 Aug 2022 00:54:42 -0400 (EDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BEF164B242
 for <kvmarm@lists.cs.columbia.edu>; Tue, 30 Aug 2022 00:54:42 -0400 (EDT)
Received: by mail-vk1-f169.google.com with SMTP id u11so2060286vkk.0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Aug 2022 21:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=j++opkMOwoopE0QFW7zgcieguS/bf5xl04LLXSqDsLw=;
 b=YxMAxwKFKn+WVskkqgF2Clsq7TotdjQCihFfTWuVcXX7SG3Hv0T05VhCQciookwMXh
 wZ72ibOTMi7Pt0mHOk5bGlz05xo2HBYuDC/D3pxV0gCT76JLE2fl+aFwkwLMLBpPlRNT
 xRVzxbmyxp+nw9x5yLC72QhBIGsQtSr68IsgAWLpMWlQ6Jor/YlWDxAMF30OojLiPaDN
 3/j0MhhNU9x9Gd3CEA2PMQ6m2tgN6wmr/tP3x0yMPasuPGPCtIKsAZOoLQ1/LuoF6mFk
 vJe1nsYhy1Q8CPFYf6TNHRyAENST54ixWOBKhh/a7FJiefYpihNwy5BwMu01LOFOdrkQ
 DMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=j++opkMOwoopE0QFW7zgcieguS/bf5xl04LLXSqDsLw=;
 b=GGu8OnXomq/RJCxU5d0NDWIRJWLVGyQ/X/vMWlPVe+zYzZwLMU7uKF2fonB6rvAst7
 8e7cZOfDYoOCUOezkiKW3YDtwxzEkn+7fLHMWMrWVsdQvWbA0iA7bsNP6U7ViKc2mrOC
 D92rtTfoN0NpvtRuJcL3nB+Lk5DFDJxhj15EEvWMDEPkF0AFZZLoUFgyFxxLBwiFc8NY
 S9jak9ChENNpKzh+QOmz63yDZfIPXuYryWDJDIwyDpv3XBbfHbpSTdKtDRo2qzBsRLou
 fBMUSe+dYF8Ae6s6j7DT91Ka8eAwVng089KVAqp5n1IqHPfSoRtBfpcxxhrln7pPs0Hm
 yK8g==
X-Gm-Message-State: ACgBeo0BzZAsczJcQRBElTe3EjiPHuzg+AuMmidbmPzKYOAq8YYj4O3R
 P9Y+t1INz5C2km+iD2UR9Jfo7oS9MUoxvULH6x5Rng==
X-Google-Smtp-Source: AA6agR4NBt2hLSUAn0G54sRGeKlPCojndb7uJeGXTx5Oh+x2e23RDCtuxkjVQ47CsH7TeYuFVXZWO4QpBbJcXOtZWaI=
X-Received: by 2002:a1f:acd2:0:b0:37b:531:9988 with SMTP id
 v201-20020a1facd2000000b0037b05319988mr4086066vke.19.1661835282107; Mon, 29
 Aug 2022 21:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220817214818.3243383-1-oliver.upton@linux.dev>
 <20220817214818.3243383-2-oliver.upton@linux.dev>
In-Reply-To: <20220817214818.3243383-2-oliver.upton@linux.dev>
From: Reiji Watanabe <reijiw@google.com>
Date: Mon, 29 Aug 2022 21:54:26 -0700
Message-ID: <CAAeT=FyxeNhTaNdQryTRoiC5AjKLzD7axm1pqaxLTrSuv6imaw@mail.gmail.com>
Subject: Re: [PATCH 1/6] KVM: arm64: Use visibility hook to treat ID regs as
 RAZ
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Wed, Aug 17, 2022 at 2:48 PM Oliver Upton <oliver.upton@linux.dev> wrote:
>
> The generic id reg accessors already handle RAZ registers by way of the
> visibility hook. Add a visibility hook that returns REG_RAZ
> unconditionally and throw out the RAZ specific accessors.
>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
