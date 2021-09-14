Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BB40A493
	for <lists+kvmarm@lfdr.de>; Tue, 14 Sep 2021 05:33:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 501C94B1F1;
	Mon, 13 Sep 2021 23:33:51 -0400 (EDT)
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
	with ESMTP id WRNRnnifo1+7; Mon, 13 Sep 2021 23:33:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32A364B15D;
	Mon, 13 Sep 2021 23:33:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D37384B0C3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Sep 2021 23:33:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oG3cg-gLO8pq for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Sep 2021 23:33:47 -0400 (EDT)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C651A4B0C2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Sep 2021 23:33:47 -0400 (EDT)
Received: by mail-pf1-f170.google.com with SMTP id v123so10842178pfb.11
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Sep 2021 20:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vi+6Oqzw5KxlySzgQbdJRDGWe6tPJCzCtUhaRDBd7v0=;
 b=sx8egWgqFJdVg3oPrF2H/aMEWHH1fVFnCjLuhahKZJkxB5zim7av5ZHPiWAux7YLu4
 /QvAsTtpu1bY2KFKwQDqqKT24Xq0gVO2HdvHIbTP5rwCfvYJmTA0XoYlhyqxIYGBGVSN
 b1GpiZRgPxOXmKBhyBae38JdmOZmVRqCovCyd9qO53zTFTK5IHN7J8Uu0/cupFgXB29O
 w1A65ec5e+yvYMP6d0uUdFg2bThTc8n8wbKrnDibWKb3ekrd4bghP4xEfTDwqFeZZrR4
 55rUjD1IgbRJ5cqEPWjTHpFurBakE0mj0gF29cNihRJygPfjSZ4ViB3PWNbLTIX+O5Md
 +fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vi+6Oqzw5KxlySzgQbdJRDGWe6tPJCzCtUhaRDBd7v0=;
 b=ttN/uGpCJCC8PV/4FOcGUuyzU781NHTksmDoewaw9b6oeqinEplMstmT2iY9lgPRSx
 qtP0P9CKQKL/yEJLdxfhya/gFDUB7blaoQCFA3IEI/bSMIHWLmmfqJoUEzMWycAYUuia
 aDyDUfXXctkPd0CAa8Yccd7uMgIfr+GmKt5W9WEpC7GdbbcqXXH844kmhf25uSqh6BL6
 6cdYhUtOI5gRWI/+bM9rujFEK2dEVKODXvtDb6Iqf31Pvbi712OxriM3pnI3fDy4cl+s
 RCg/CZ9RHgNfW7faP24CPK6rADkS+fQV1QDQg/X8tVY5O+F4VlDOiF/bLHdKhGv9eZxL
 CCeA==
X-Gm-Message-State: AOAM531yCbEX5EX0LLyzLezDcsNBElFQjfpywnOMyIhvwlsRwiUe5mST
 W0VgLRcePaRfpduW5r7R5ox4Bu6p/mRLFNZmK9kmzg==
X-Google-Smtp-Source: ABdhPJzw2S/YgGBtO+1c3RPc29HGMQ/BkgHUl3KdPyLmldqI8eb6LknV3uVQi6FfdOHbKpFzUguwneEzrAZEpaVH5hI=
X-Received: by 2002:a63:d806:: with SMTP id b6mr13920055pgh.395.1631590426624; 
 Mon, 13 Sep 2021 20:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210913230955.156323-1-rananta@google.com>
 <20210913230955.156323-10-rananta@google.com>
In-Reply-To: <20210913230955.156323-10-rananta@google.com>
From: Reiji Watanabe <reijiw@google.com>
Date: Mon, 13 Sep 2021 20:33:30 -0700
Message-ID: <CAAeT=Fyd-K6OSLuCTBsxwqv77yw8YzPouOM2Oiocw4R0qW-0mQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/14] KVM: arm64: selftests: Add guest support to get
 the vcpuid
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Sep 13, 2021 at 4:10 PM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> At times, such as when in the interrupt handler, the guest wants
> to get the vcpuid that it's running on to pull the per-cpu private
> data. As a result, introduce guest_get_vcpuid() that returns the
> vcpuid of the calling vcpu. The interface is architecture
> independent, but defined only for arm64 as of now.
>
> Suggested-by: Reiji Watanabe <reijiw@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Ricardo Koller <ricarkol@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>

Thank you for creating this utility !
Reiji
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
