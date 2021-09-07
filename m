Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 364C9402DCF
	for <lists+kvmarm@lfdr.de>; Tue,  7 Sep 2021 19:42:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BFE114B1FA;
	Tue,  7 Sep 2021 13:42:09 -0400 (EDT)
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
	with ESMTP id GL4RgP38mqJV; Tue,  7 Sep 2021 13:42:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C15024B1AF;
	Tue,  7 Sep 2021 13:42:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BBB984B199
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 13:42:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nsgZ5ytAxVZ1 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Sep 2021 13:42:06 -0400 (EDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 896C84B174
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 13:42:06 -0400 (EDT)
Received: by mail-pj1-f47.google.com with SMTP id
 g13-20020a17090a3c8d00b00196286963b9so2004477pjc.3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 07 Sep 2021 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=40HbNUxcF+T20RK2OUdw+aYb/8oENTKJgMKoFCUo07c=;
 b=s6OYBqLpD3/j1aEyb93Oh8WoZXc+VKDanEf2q6xWzGDc28ZW0Em6Bdij9R1Fg+Li2y
 MkdcevWyPzSOePZVZitqkjOcjZXy+mKNnVl+L21B3xAsNBcfYIAmjZWyvtzqb7OPSRgx
 6ZalvZ6QBpLxwizuU23OJrYaLb9W4bV670XhpQ4kJGSeOX1J3YH5v2sLwCuRXjHfm40u
 vzyijciJrEDSITEwzb9clo5E9cVu4p5LqVQzYRx0aQ71DjEtdfF4yvfyhE5lGnO8sAxo
 ekzpK6FoTWsKTfrLJ2vY+8GxM1ePtqe6gcRUFb81EiGCvVh+OyXA58Bz/YzBfZxlBxDH
 01Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=40HbNUxcF+T20RK2OUdw+aYb/8oENTKJgMKoFCUo07c=;
 b=PsSzxPAwHm4ynXkLCm0lRe0u2uOO3LLPwpn7X0v6glOS6+XujDBS2wlz/oll14tXEK
 pDhAC8DlTbuGyHSwbDWEoQpkDqtjD7tMwhywY0nNLVEhKCtO0VNs1J7LiUWZl5JSl50R
 iwiROIowzROU8F6rnfFB8rS2N2+kD53xhN50JZ/A9h6+dBZH//OXTth9wTp5ThW4PHpl
 MnH+SmOsWS3laq7CYVUGTuOW8LwslINhKxGHIb2zLHj/qF1zKdHYLGhUYULsZyokY/Yt
 eyn1oYG5WhZoUiVKVSJwifZI2qNWNpmP9VYwnwsSBQYuSVIYDRwm18t7ssT5IWF+Gg9K
 l+zw==
X-Gm-Message-State: AOAM530ulM8JWwXDsClS442vR5IwWitSGJvQvM9nTOpZ4lX9NvAdOH6M
 IZjkcltl7kHrgWzfvO0jKOc1Lg4T2PjJbg==
X-Google-Smtp-Source: ABdhPJz3Z+k1SXGfmZnqwU2YMASZrpPO/JbNt4ygiAWP7MBg8vyQqvf59hmDoq/FcStuiIFOcTTabw==
X-Received: by 2002:a17:90b:1d83:: with SMTP id
 pf3mr5363746pjb.158.1631036525474; 
 Tue, 07 Sep 2021 10:42:05 -0700 (PDT)
Received: from google.com (150.12.83.34.bc.googleusercontent.com.
 [34.83.12.150])
 by smtp.gmail.com with ESMTPSA id q18sm11606686pfj.46.2021.09.07.10.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 10:42:04 -0700 (PDT)
Date: Tue, 7 Sep 2021 10:42:01 -0700
From: Ricardo Koller <ricarkol@google.com>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 2/2] KVM: selftests: build the memslot tests for arm64
Message-ID: <YTekaQOHMzNxV8Bl@google.com>
References: <20210903231154.25091-1-ricarkol@google.com>
 <20210903231154.25091-3-ricarkol@google.com>
 <CAOQ_QshLu-EiLdPDY-d1dS3qvNjJBiN=B=a-W7_70Fdt=GbOcw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ_QshLu-EiLdPDY-d1dS3qvNjJBiN=B=a-W7_70Fdt=GbOcw@mail.gmail.com>
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

On Tue, Sep 07, 2021 at 09:39:12AM -0500, Oliver Upton wrote:
> Ricardo,
> 
> On Fri, Sep 3, 2021 at 6:12 PM Ricardo Koller <ricarkol@google.com> wrote:
> >
> > Add memslot_perf_test and memslot_modification_stress_test to the list
> > of aarch64 selftests.
> >
> > Signed-off-by: Ricardo Koller <ricarkol@google.com>
> 
> There isn't anything that prevents these tests from being used for
> s390x too right? Of course, we haven't anything to test on but just a
> thought.

Tbh I'm not sure. Will ask if somebody can try it in the cover letter
for v2.

Thanks,
Ricardo

> 
> Besides Drew's comments:
> 
> Reviewed-by: Oliver Upton <oupton@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
