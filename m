Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B5402EBE
	for <lists+kvmarm@lfdr.de>; Tue,  7 Sep 2021 21:06:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C7BAE4B125;
	Tue,  7 Sep 2021 15:06:33 -0400 (EDT)
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
	with ESMTP id k1qWiKKUIkH4; Tue,  7 Sep 2021 15:06:33 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B8E904B0EF;
	Tue,  7 Sep 2021 15:06:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E69E4B0BD
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 15:06:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1S26vUJw9Y1t for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Sep 2021 15:06:28 -0400 (EDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 95CC84B099
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 15:06:28 -0400 (EDT)
Received: by mail-lf1-f43.google.com with SMTP id c8so27863lfi.3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 07 Sep 2021 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s+hlDwUFiTVxWGKpSU6MU8j+cu8U8TUReyBLxU0Tfmk=;
 b=D3GWVUAsTVbjoxvrtwleyMkvybOGrJteUI1wvNoq8RqFLISE3GOIPZXCWVsKqFsBoo
 +bYNN9SqyzIe8uObqPJdKTv4OhDniNZNtqY0gXWJ+Xmo9qNLxrU0+lQcTFxPRdc397bn
 9JUd0ty7PDiR9XxZLQ0iBg+jWxYEdHhYLHN/NoSFttvyFP5KHW/qn9nyd7L0Gg4LhVSb
 waSPRE8D4hMkiAam6KJN8Vch6JHUthjmNpPG+MpvLt1GOQEb7ll2rC7/AYrr49fwnfhB
 keSH+j+e0RQF/gaJnaDDQ0w0iexQyTDQIqGy0jJWB7gNuqEPbylw2NbO8iAYmq/yeE9+
 c+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s+hlDwUFiTVxWGKpSU6MU8j+cu8U8TUReyBLxU0Tfmk=;
 b=cGkC3issSYlU0CxqAC1HCJVmVR7xONczVMU1umj6VuQWKcUkw1HzvMPdTKaeIGi0+e
 6o46MGOx8h+oRc9eQDwcp+TtJLnt1OL+ouOTG4+M8udM1cItryj4ChN/3ItlIkt2RMba
 wvJR6fMsNkYS2ExDVcsNfuf30foe1O72K0qhd2cew95uq2cH9oL8o8jfverxApK9gDw2
 jwzVNWsUmM+7+5UgkNPFT4hiiHajvPYbLNF4+bFMKzcR9t8TVGeMJLYLS+OJT7FlPz1K
 X1LxjAevMKct+TSyQi9WIb2x878n39O6eZkdXMTV3l0YfIhRD3fkISfEmBj1PmNGjaWZ
 NFxw==
X-Gm-Message-State: AOAM533R8AVyKKbnXRSikmNQwh+m6mVGeXMQ0Ew02NboxMsYbSPauPlE
 YgnEQHLV/w74WyAfTRY7PU0ZNWSaqgOpNft045aTjA==
X-Google-Smtp-Source: ABdhPJxFH6TtOzvVoSUHVh1aaUptpkScIjaFBYjZjLBHoUXGtoXqRsTik7vATNsE0IDRxSFVL5PXNZ2s3Z6IPiHesMU=
X-Received: by 2002:a19:7406:: with SMTP id v6mr13841838lfe.669.1631041587078; 
 Tue, 07 Sep 2021 12:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210907180957.609966-1-ricarkol@google.com>
 <20210907180957.609966-2-ricarkol@google.com>
In-Reply-To: <20210907180957.609966-2-ricarkol@google.com>
From: Oliver Upton <oupton@google.com>
Date: Tue, 7 Sep 2021 14:06:16 -0500
Message-ID: <CAOQ_QsjEu2GQTnvuA+8hZ+w1rVU6g36TKzSUASroYxqS=-4GsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: make memslot_perf_test arch
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

On Tue, Sep 7, 2021 at 1:10 PM Ricardo Koller <ricarkol@google.com> wrote:
>
> memslot_perf_test uses ucalls for synchronization between guest and
> host. Ucalls API is architecture independent: tests do not need to know
> details like what kind of exit they generate on a specific arch.  More
> specifically, there is no need to check whether an exit is KVM_EXIT_IO
> in x86 for the host to know that the exit is ucall related, as
> get_ucall() already makes that check.
>
> Change memslot_perf_test to not require specifying what exit does a
> ucall generate. Also add a missing ucall_init.
>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  .../testing/selftests/kvm/memslot_perf_test.c | 56 +++++++++++--------
>  1 file changed, 34 insertions(+), 22 deletions(-)
>

Reviewed-by: Oliver Upton <oupton@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
