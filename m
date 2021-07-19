Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D7D293CD5CE
	for <lists+kvmarm@lfdr.de>; Mon, 19 Jul 2021 15:39:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 54CFF4B093;
	Mon, 19 Jul 2021 09:39:13 -0400 (EDT)
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
	with ESMTP id 9Zu08r5WE0Sk; Mon, 19 Jul 2021 09:39:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 465AE4A5A0;
	Mon, 19 Jul 2021 09:39:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6B6074A3A3
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 09:39:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kxLfP5OzkMHZ for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Jul 2021 09:39:10 -0400 (EDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3A9824A1AF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 09:39:10 -0400 (EDT)
Received: by mail-wm1-f45.google.com with SMTP id c17so3335496wmb.5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YWipcSLEOaheP07xex9veQfZl0Z1vV0LQN+2n8cjKsA=;
 b=CNm1BBIQqcgx6zX/dXg0WWmp1MmRgupG3sxzggKPJQJmBNC9naFQbjh7hAKRFoMuT4
 N6kmjOrM7TwVZCUS3ViuT7cilOVw5TUGEk1JvtpcX+dZ0jnr6+P3n3UElg/7Yk+n3cqR
 5dcFbsGLReIGqlwZiYSSUIstzppYHr8STNug0C2hdG9JWZvk3H7aHe69G35165bLgXfF
 Wz/7jDi77m+ARzTOT/sUN9Tp7PXBNcS7I0LYMPtOUhStGhqNAuqTdAxMBDMsPJS+AU5y
 Wf7LifU3sZdwHZPUOhG5v5/ykSoXjkBecRidb642zpacSEv20rn8IkVcf3hUDWKXGZES
 5owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YWipcSLEOaheP07xex9veQfZl0Z1vV0LQN+2n8cjKsA=;
 b=DD6mFAwQnB5NG7rq7P1jaMF28EE7+B76Qg4BT0Unf1Yp5nQ7klAJw1y9JUq78D+IML
 wIjg5hrFN1sEs1O+5OGERkUvsj2Pqp6vADF8x1jWQwoM+dbxQksr9MDbQxih9D+GZesE
 FE4KMjgBLYIfaZicoATI8gn1B83HM4gboO9G95/JVVTrBUCFmz57wC6xYOhL6JFQuDJo
 zgKi4rphhinhQEMgTJaUMnWldTjppp5QeIofMaFbeSpBWq3vigS+iCAEgMjI2a8QNAtz
 WT+4S1irGBi1NgfTUPOy4E6vu19v8ckkc8uHBCTS6rbuPI0w6X122Cr0u32Wj4FxKM7I
 K7HQ==
X-Gm-Message-State: AOAM530yrW3lLcCnNDhi+o7FcgF0myPfxNLLhy/15eWvO8Ydc10hSIs1
 WAEh55qVhawlhwl2YoOrFN9gvQ==
X-Google-Smtp-Source: ABdhPJyYT/YffwHR1fUpFsi8GYZ3DLBHWESA81MHvoJEipodSYGoTNpTuaPUSnMI7u6L0EQikRpzog==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr11503607wmj.83.1626701949064; 
 Mon, 19 Jul 2021 06:39:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
 by smtp.gmail.com with ESMTPSA id p9sm8224430wrj.54.2021.07.19.06.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jul 2021 06:39:08 -0700 (PDT)
Date: Mon, 19 Jul 2021 14:39:05 +0100
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 05/14] KVM: arm64: Don't overwrite ignored bits with
 owner id
Message-ID: <YPWAeTJMWJ+A7W2c@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-6-qperret@google.com>
 <87im16jwe6.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87im16jwe6.wl-maz@kernel.org>
Cc: kernel-team@android.com, qwandor@google.com, will@kernel.org,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
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

On Monday 19 Jul 2021 at 13:55:29 (+0100), Marc Zyngier wrote:
> On Mon, 19 Jul 2021 11:47:26 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > The nVHE protected mode uses invalid mappings in the host stage-2
> > page-table to track the owner of each page in the system. In order to
> > allow the usage of ignored bits (a.k.a. software bits) in these
> > mappings, move the owner encoding away from the top bits.
> 
> But that's exactly what the current situation is allowing: the use of
> the SW bits. I am guessing that what you really mean is that you want
> to *preserve* the SW bits from an existing mapping and use other bits
> when the mapping is invalid?

Yes, this is really just forward looking, but I think it might be useful
to allow annotating invalid mappings with both an owner id _and_
additional flags for e.g. shared pages and such. And using bits [58-55]
to store those flags just like we do for valid mappings should make
things easier, but no big deal.

I see how this is going to conflict with kvm_pgtable_stage2_annotate()
from your series though, so maybe I should just drop this patch and
leave the encoding 'issue' to the caller -- the rest of the series
doesn't depend on this anyway, this was just small cleanup.

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
