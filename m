Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B633D5BD
	for <lists+kvmarm@lfdr.de>; Tue, 16 Mar 2021 15:29:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 436F04B473;
	Tue, 16 Mar 2021 10:29:38 -0400 (EDT)
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
	with ESMTP id IFlSvdGRplbP; Tue, 16 Mar 2021 10:29:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4A4CB4B4F3;
	Tue, 16 Mar 2021 10:29:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AB6BA4B3AB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 10:29:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqQQZCSJAFbm for <kvmarm@lists.cs.columbia.edu>;
 Tue, 16 Mar 2021 10:29:34 -0400 (EDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8D04D4B2A5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 10:29:34 -0400 (EDT)
Received: by mail-wr1-f45.google.com with SMTP id b9so7551616wrt.8
 for <kvmarm@lists.cs.columbia.edu>; Tue, 16 Mar 2021 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/67JlL4XAW5mzmo5zvI5lnSjesASdzJ288R/r/boih4=;
 b=Rl1e1sgSA+j+wW40O0525WMi6vFtI6NhJ4n4bpyu3tI/m7gFZxqJ5KB6gt3G7RDN3n
 7LAbIs6WzuY1PMr78vgdfkz1gyq8EHfnqojbe82o+hpz+1pCYB9hv+KNrjZUAGiqKYaR
 fEun6V4QrR+U7Xt1n1pGAdYiWDt7kHGGf8AVQ4MCmR4hwWMoyHnPeSjYo7NLXkvS0YAq
 a8qHyXM8X58Z0bm1HSDvm2QFJ+fdR+FFPpMS6MV5dKjzAWq+0LtspyDZjPUfnyotQtTT
 I5XzyN9l5359/xLD9LIpeCUKV6OWLH10lD0A/T5jwakEUOD3hiatqmjLbb4aG+y02a23
 xmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/67JlL4XAW5mzmo5zvI5lnSjesASdzJ288R/r/boih4=;
 b=B9C1hUqVJGpryxmr7n2PVZDZFrNScPHElmuqy1v1WP2Y3ukdD8jslFAhw34v6Jfdja
 YIr0HS00v8VX6yNm2nu6cs1KxILe6T48l0M8Ynd3CWaFlbzHCSig6T/L81i12N5wHJoQ
 vknaUzIIwe6iQLCfiukZf51qoJHhrEZUekjJ6ISrHZ78eRxvV80Z4i7MDm5RdUEG8qVl
 zjYJWl3k1u5lBrBUtKPTRzBMpghnSqSMu6VtWCzhjxtavrMbXZVt7WK7Nq1jA6hNi8ZM
 ZNUA35NaCRe7jkQNO9uAMRJiQPsNfk0t56kUrL5mf7rI1UseiwQ/QPFO6yvYON+cDR3S
 UKGw==
X-Gm-Message-State: AOAM530fP4ennsGynKSvoaQflANnb0x8+PjR13SUuFgSFfiGdeTrqFM3
 SMIB852jFoAkEQX2S5DPvsFw+Q==
X-Google-Smtp-Source: ABdhPJyar0PDtR9PziUEdK0q4Lj3lv5hEyxzPSqinrBmYUkeCvkWvc7ADuJUVK9+9pY/pIHWlS9hmg==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr5266544wrn.255.1615904973496; 
 Tue, 16 Mar 2021 07:29:33 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com.
 [35.233.69.230])
 by smtp.gmail.com with ESMTPSA id u2sm22610401wrp.12.2021.03.16.07.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 07:29:33 -0700 (PDT)
Date: Tue, 16 Mar 2021 14:29:30 +0000
From: Quentin Perret <qperret@google.com>
To: Mate Toth-Pal <mate.toth-pal@arm.com>
Subject: Re: [PATCH v5 33/36] KVM: arm64: Wrap the host with a stage 2
Message-ID: <YFDAyhjPEsnZ4N3P@google.com>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-34-qperret@google.com>
 <ec9df9a4-a419-089c-469f-1a1509597dd9@arm.com>
 <YFCqYT3Ib8kAN7/c@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFCqYT3Ib8kAN7/c@google.com>
Cc: kernel-team@android.com, android-kvm@google.com, catalin.marinas@arm.com,
 seanjc@google.com, tabba@google.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Tuesday 16 Mar 2021 at 12:53:53 (+0000), Quentin Perret wrote:
> On Tuesday 16 Mar 2021 at 13:28:42 (+0100), Mate Toth-Pal wrote:
> > Changing the value of MT_S2_FWB_NORMAL to 7 would change this behavior, and
> > the resulting memory type would be device.
> 
> Sounds like the correct fix here -- see below.

Just to clarify this, I meant this should be the configuration for the
host stage-2. We'll want to keep the existing behaviour for guests I
believe.

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
