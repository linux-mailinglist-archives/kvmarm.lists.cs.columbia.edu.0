Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CD192402AD6
	for <lists+kvmarm@lfdr.de>; Tue,  7 Sep 2021 16:34:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 418734B1D5;
	Tue,  7 Sep 2021 10:34:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBNPUlI00aGV; Tue,  7 Sep 2021 10:34:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A6574B1D3;
	Tue,  7 Sep 2021 10:34:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DF684B1BD
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 10:34:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMxEJsTx9S0L for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Sep 2021 10:34:13 -0400 (EDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E43904B1AF
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 10:34:12 -0400 (EDT)
Received: by mail-lf1-f50.google.com with SMTP id m28so19955172lfj.6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 07 Sep 2021 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PZ01/kVjxN4qO85F71R96OvGPb6wIX4duLA904XRBt0=;
 b=sUtQ7iAwFIzvOQDRef2wZa27h8+hDyTaxtEx6mARLtFnIRrPuxoUB+6w/M2nVqWpgx
 3S+ciEJ8lUgYCEjN09Uwt7xfsur7rUUsHKtkHaFeS8UaXudk5cpVyCQDI3xqhty5k665
 DVg7jaq3i3tqVXi+tCdWo804axaXHCQhM7wqf2aWC/6nMcpXsBufmKX3J/gL8JmtqCcC
 6Hq3Qxl/hv0+oJ4GLjRcFzim1QbJdfVwOGWaLnYJ0c5Y3nTJxxhdQE4Kqh7Vyjbo1DaV
 1Ea6QbV54HLRL9YpQpXP/dUNDXFN4/soZDxGveC7jnSb+4LlYb8uf6tA/Hbpz0Lf0nn2
 4Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PZ01/kVjxN4qO85F71R96OvGPb6wIX4duLA904XRBt0=;
 b=hdJnuDjhPFNeLnVGCD6TkneKRWL7X0Bm6LCeAKZmIRkmhsSr4jC9+XPidNXpv2YOFv
 USCACZBY0w1LXjjINga62ptffvpzgOmvZ2EYFvNZVgPwpUREiEOC0MxRqrwFYL6KEfOt
 DQSBPPzfBvosVvdZW/n01AHgo95Pkp381u/uyYQbbk168p8OSrfxGetCew/PD6zMMy0s
 xGM1pWpRjTZSGNdUd6m091tHXTcjud5IF/M/sThrVKw5S2vlLDIDDcciQUjWjHKUT7dC
 qE01fe5d/zBtnU9YdHEBwf0Z16akrXAXEkwv1pj7G3oMzhsNZT52KqXjCKQCZ2f7nSaP
 aAOw==
X-Gm-Message-State: AOAM532jkGrdyWUGA2jx/ayYMgHLhOtymUCOTbjMbX9C1nX4X+xq5/pi
 d7ampokUcPYnc82NqF/UC36d6yXwLri+5fkgQb/Vmw==
X-Google-Smtp-Source: ABdhPJwuWNsB+X+8RleNTkUfobN0mJu2O1t+/HKXko5CgQZkOu4qHxK+7UF3rIDIOg4c0OeKfNIwiesKok3fCDh56ig=
X-Received: by 2002:ac2:51a2:: with SMTP id f2mr13179229lfk.685.1631025251259; 
 Tue, 07 Sep 2021 07:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210903231154.25091-1-ricarkol@google.com>
 <20210903231154.25091-2-ricarkol@google.com>
In-Reply-To: <20210903231154.25091-2-ricarkol@google.com>
From: Oliver Upton <oupton@google.com>
Date: Tue, 7 Sep 2021 09:34:00 -0500
Message-ID: <CAOQ_QsgBu07UmC7zZ-n07dqkg0Xp-AH=a8bmdF7nzt=ZO2j0=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: selftests: make memslot_perf_test arch
 independent
To: Ricardo Koller <ricarkol@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, pshier@google.com,
 Paolo Bonzini <pbonzini@redhat.com>, maciej.szmigiero@oracle.com,
 kvmarm@lists.cs.columbia.edu
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

On Fri, Sep 3, 2021 at 6:12 PM Ricardo Koller <ricarkol@google.com> wrote:
>
> memslot_perf_test uses ucalls for synchronization between guest and
> host. Ucalls API is architecture independent: tests do not need know
> what kind of exit they generate on a specific arch.  More specifically,
> there is no need to check whether an exit is KVM_EXIT_IO in x86 for the
> host to know that the exit is ucall related, as get_ucall() already
> makes that check.
>
> Change memslot_perf_test to not require specifying what exit does a
> ucall generate. Also add a missing ucall_init.
>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  .../testing/selftests/kvm/memslot_perf_test.c | 56 +++++++++++--------
>  1 file changed, 34 insertions(+), 22 deletions(-)

Reviewed-by: Oliver Upton <oupton@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
