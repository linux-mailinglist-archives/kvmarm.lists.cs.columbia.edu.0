Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DF3273D0EBD
	for <lists+kvmarm@lfdr.de>; Wed, 21 Jul 2021 14:20:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6101C4B130;
	Wed, 21 Jul 2021 08:20:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@chromium.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJgLUSk8Qn+X; Wed, 21 Jul 2021 08:20:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4EC384B110;
	Wed, 21 Jul 2021 08:20:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C0BC14AEE2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Jul 2021 06:38:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMxMukimS3NR for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Jul 2021 06:38:46 -0400 (EDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B54A04AED4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Jul 2021 06:38:46 -0400 (EDT)
Received: by mail-pf1-f175.google.com with SMTP id j199so1899176pfd.7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Jul 2021 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EIbOGymDYcRaNQxjueCe6a1zJ8aY0naaP0fQUkEZuv8=;
 b=Ov5r12ynseBnyTNRKsKx9w8I9twMbxcSJ1f73zH2iop1yQASsh3BfriyZofnrwgGPb
 JWsBYE6ZU5a3lBHKbfhG01blBS2BP/AHgilqkL+QG/cbbprBm/Aw4GR7gpJVVtkbNURP
 IGrlGE+9rwKA79Of6P2jRijrEqbvnRi+5RyzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EIbOGymDYcRaNQxjueCe6a1zJ8aY0naaP0fQUkEZuv8=;
 b=S26HZTUVqRCIFNbFUTVmT2V7X+AYArrjRzZZPskNOEoTofjiU2G9+WEiGIs+lSj+Tc
 Lz42H6weqAl16DO2u6xDVjHwLL5vecEaajS4bK5SPiy6+6riJ1jbPuzsPFuabD20IQv/
 wrIQf8HWVAg8fKJfwCbPzvdOLlleyXO3Rsq6/U7Mm8+A9e5oXYY36xRdiCG2f2JtX45k
 s0zscHCWXNOA+9GAneZhKVOtA/dKAqZN25hVtIyp9YYOCAR5+ZFBC3WGyadV4DABsD75
 RapZzmcO/XLubKeRkJGVflNfopK/NoN3MwY5A+DEEFgLPLUbw4ot6xCk0ePvLwC7+e5+
 ri0Q==
X-Gm-Message-State: AOAM532t4ugoXCWipzVZVSRW8ImiDp16WMxrHCaZH1FN48b7RxY7Wt3z
 U9BCKIpHwUUEjl5lh4sZ4SrTBQ==
X-Google-Smtp-Source: ABdhPJwG3zXjqu/tpj5VxqRx6FmJchnrD4hFB2OoBNGmAOcVyTAxWZv9VdpXTlSzk5yhFw1PCfmBEw==
X-Received: by 2002:aa7:81c5:0:b029:2f7:d4e3:78e9 with SMTP id
 c5-20020aa781c50000b02902f7d4e378e9mr36527927pfn.31.1626863925613; 
 Wed, 21 Jul 2021 03:38:45 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:f1b2:269f:996b:b71a])
 by smtp.gmail.com with ESMTPSA id z16sm5586915pgu.21.2021.07.21.03.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jul 2021 03:38:45 -0700 (PDT)
Date: Wed, 21 Jul 2021 19:38:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCHv2 4/4] arm64: add host pv-vcpu-state support
Message-ID: <YPf5MFV99zPdTu/U@google.com>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-5-senozhatsky@chromium.org>
 <874kcz33g5.wl-maz@kernel.org>
 <CAJWu+oqCyj3H0=1KNo3c+crdcktYinFoTQJ5jHgU8gjeF4d2yA@mail.gmail.com>
 <87h7go2h69.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h7go2h69.wl-maz@kernel.org>
X-Mailman-Approved-At: Wed, 21 Jul 2021 08:20:04 -0400
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Suleiman Souhlal <suleiman@google.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On (21/07/21 09:40), Marc Zyngier wrote:
> > 
> > Can that be cured by just checking vcpu->preempted before calling
> > kvm_update_vcpu_preempted() ?
> 
> It isn't obvious to me that this is the right thing to do.
> vcpu->preempted is always updated on sched-out from the preempt
> notifier if the vcpu was on the run-queue, so my guess is that it will
> always be set when switching to another task.
> 
> What you probably want is to check whether the vcpu is blocked by
> introspecting the wait-queue with:
> 
> 	scuwait_active(kvm_arch_vcpu_get_wait(vcpu)
> 
> which will tell you whether you are blocking or not. We are already
> using a similar construct for arming a background timer in this case.

Can we examine if vcpu->run->exit_reason == WFE/WFI and avoid setting
preempted state if so?
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
