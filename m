Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BF38851961C
	for <lists+kvmarm@lfdr.de>; Wed,  4 May 2022 05:39:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0D4764B14D;
	Tue,  3 May 2022 23:39:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gM4foP2rfQII; Tue,  3 May 2022 23:39:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CEFCF49EC3;
	Tue,  3 May 2022 23:39:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DBC341021
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 May 2022 23:39:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id woeWKuhGcG-Y for <kvmarm@lists.cs.columbia.edu>;
 Tue,  3 May 2022 23:39:48 -0400 (EDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
 [209.85.166.44])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C51C140FF0
 for <kvmarm@lists.cs.columbia.edu>; Tue,  3 May 2022 23:39:48 -0400 (EDT)
Received: by mail-io1-f44.google.com with SMTP id o190so307876iof.10
 for <kvmarm@lists.cs.columbia.edu>; Tue, 03 May 2022 20:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TKFkaOZkalvLFPXwyy85GYdezcn8X//pTVrKI0zHMyM=;
 b=OKeMQH51cvKoQfQVe6saCkxUR73NoKar+XZu/9qav85QUB81nfSHCeoHN5ex2uOb//
 kO1M3kU546nhzKG8drhWWWIUs2t14S730C1HbWkI98KwrAgY1/vgN9VpljYTWsTGpYMT
 n40EgHXpIz0/SkKO51NFcsULQvGXL6ctkwg5DTTIAS2gYvCpejuSQQ4qph7SlokYXt9s
 VUvf8WdkLPYjIyQeFT1pil2GnBWaBey1n1lhrl6pQgJvg7/UckiVZ1X7UNBDOqmR4njo
 LBHY2e3LUD3qHU9CyE4PtJWxl3SB3/EAnWvg4FyKsiXUSQX++UDJY9f7JOtRyg/wBBgS
 UVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TKFkaOZkalvLFPXwyy85GYdezcn8X//pTVrKI0zHMyM=;
 b=6F5Sdi8BmQ72NWhHnBGJJ+n+gF9BcBFixdCojdDXl+pYxKpN8Se9TMESxirIys1Vvl
 S+Froi2FVUwmZnn4N8pHFuXL2tFhneK1BuiB//bCM9NwnjGiLIJ3kiph34hRcdoOE/9G
 vDqK3xGBMqXiHCPqGKXxnjOV5Y7E60rZlGq9KsRQeQeGVegaSy/HazHVKnu/fqAFSSOF
 S75/bUn+DMcAljafQDa1HggvPstIokYwReFNYJ+XISwMGmDxFeJfy7dz8h5+8qkcYWCM
 IxMWCeUne8zNcNVQWBo+kOWF2h72/R0iK7AHDivAduSw3sWqJy5uhfOBshwFjoa6lgiO
 GeAQ==
X-Gm-Message-State: AOAM532vTuGUxXp+YBnNyHelI/5igsPQlgLBIkhe8+BQHWYYC7YbwAJQ
 bKWSgCCcACuKcPSNSNVOeY5lsw==
X-Google-Smtp-Source: ABdhPJwLTXJtAXiJwUCvEWggY3FV+wdRFZMRp+5BJmrk0AvQhZTFxdNQcILItIRCgxyMEkGbhuqhbA==
X-Received: by 2002:a05:6602:2427:b0:657:b2ff:89c5 with SMTP id
 g7-20020a056602242700b00657b2ff89c5mr7163783iob.26.1651635587956; 
 Tue, 03 May 2022 20:39:47 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194]) by smtp.gmail.com with ESMTPSA id
 x22-20020a029716000000b0032b3a781750sm4388413jai.20.2022.05.03.20.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 20:39:47 -0700 (PDT)
Date: Wed, 4 May 2022 03:39:43 +0000
From: Oliver Upton <oupton@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v7 0/9] KVM: arm64: Add support for hypercall services
 selection
Message-ID: <YnH1f2cXcpdKsA3q@google.com>
References: <20220502233853.1233742-1-rananta@google.com>
 <878rri8r78.wl-maz@kernel.org>
 <CAJHc60xp=UQT_CX0zoiSjAmkS8JSe+NB5Gr+F5mmybjJAWkUtQ@mail.gmail.com>
 <878rriicez.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878rriicez.wl-maz@kernel.org>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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

On Tue, May 03, 2022 at 09:33:40PM +0100, Marc Zyngier wrote:
> On Tue, 03 May 2022 19:49:13 +0100,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> > 
> > Hi Marc,
> > 
> > On Tue, May 3, 2022 at 10:24 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 03 May 2022 00:38:44 +0100,
> > > Raghavendra Rao Ananta <rananta@google.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Continuing the discussion from [1], the series tries to add support
> > > > for the userspace to elect the hypercall services that it wishes
> > > > to expose to the guest, rather than the guest discovering them
> > > > unconditionally. The idea employed by the series was taken from
> > > > [1] as suggested by Marc Z.
> > >
> > > As it took some time to get there, and that there was still a bunch of
> > > things to address, I've taken the liberty to apply my own fixes to the
> > > series.
> > >
> > > Please have a look at [1], and let me know if you're OK with the
> > > result. If you are, I'll merge the series for 5.19.
> > >
> > > Thanks,
> > >
> > >         M.
> > >
> > Thank you for speeding up the process; appreciate it. However, the
> > series's selftest patches have a dependency on Oliver's
> > PSCI_SYSTEM_SUSPEND's selftest patches [1][2]. Can we pull them in
> > too?

Posted, BTW.

http://lore.kernel.org/kvmarm/20220504032446.4133305-1-oupton@google.com

> > 2. Patch-2/9, arm_hypercall.h, clear all the macros in this patch
> > itself instead of doing it in increments (unless there's some reason
> > that I'm missing)?
> 
> Ah, rebasing leftovers, now gone.
> 
> I've pushed an updated branch again, please have a look.

Series looks good with your additions. For the pile:

Reviewed-by: Oliver Upton <oupton@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
