Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5682B2F3621
	for <lists+kvmarm@lfdr.de>; Tue, 12 Jan 2021 17:50:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF4574B21F;
	Tue, 12 Jan 2021 11:50:20 -0500 (EST)
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
	with ESMTP id wK17LSvsOaVY; Tue, 12 Jan 2021 11:50:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C3DEE4B21E;
	Tue, 12 Jan 2021 11:50:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E12204B212
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Jan 2021 11:50:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UzZqo4IczyfV for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Jan 2021 11:50:16 -0500 (EST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B6AAB4B1CC
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Jan 2021 11:50:16 -0500 (EST)
Received: by mail-wr1-f47.google.com with SMTP id r3so3243546wrt.2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Jan 2021 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=90x7bSE6XP8JZlzynOLHF7U7UF119XCh3OM9LGBjMTs=;
 b=VeV7Bhbi83JAOnTWd71Dy939nVpu0J42s1sPM4bsu44fgHA910w59T24ByGjHj2k7B
 WWcR3YELkWLB8XK50PnnLR4gfbh2NKfaOsRVUn+dnMDddWD94eB53iViry2J/gyWkcs0
 iJrpCk9E/iZdoRBdsSr9jcGh+i1jdxEbRpW0iuqqpLPYkphnlVHvQJvcrnltVRybFdOn
 CeiDSnZKMNQkaEQtyGiNRx725KRfnaSPh9WtwkAxESUeeR0pz2L2tqZWhAy0q+Vck8Sb
 fQIfk204viOE/LY5i8CJlXl4RXPqVJXSoZKPs933VKUmcHwgdQIcOmDmjiDThspf0U0c
 /gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=90x7bSE6XP8JZlzynOLHF7U7UF119XCh3OM9LGBjMTs=;
 b=l66gfL/e5dv0NLpxHs18m1GO6doiQ2Ed5yvTfXIRKdlI+Ql/DupWfxaN0insv7oFPY
 +h5luMx4cFQd7iu39WnBjs/n+xbxxif0AdfngIkWpZkSTuGlCm3uICE+WdBabLIBS+eh
 OlNd4A0Mj43civ/8h22SYVy8VnxBZ+kKqkkyLPTZwNMYWW0++Dx7Et9AtV6LsRsQ1j4k
 LR33MJa2aokHjL1ILS6NldgJZ0/lVRHOkdM4+lzH2LFVnoF5loecNdT+JGTZGVb0DVdq
 KaXr3uplF1dykqWSl9h81KeNqBCjuo/Lx6EF3RP07toYpVkd5TJIrkSbYDQ7J8lIRrDd
 lUgA==
X-Gm-Message-State: AOAM532XIu4nL8dty+6A0V9ddBoeffnkJOqpwzLO2SgbFQQ2WbMmpY30
 rygc1CepBC8qX+P9hVFxC+u1fA==
X-Google-Smtp-Source: ABdhPJzS5AdRFcljD6Jz7OxKl5NJ+IEYr2nuZgQOpFTfBMfhhk81jA6ozUI57bPy8UvCQiWftyNS0g==
X-Received: by 2002:a05:6000:2c1:: with SMTP id
 o1mr5334917wry.264.1610470215396; 
 Tue, 12 Jan 2021 08:50:15 -0800 (PST)
Received: from google.com (49.222.77.34.bc.googleusercontent.com.
 [34.77.222.49])
 by smtp.gmail.com with ESMTPSA id n10sm4133998wrx.21.2021.01.12.08.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 08:50:14 -0800 (PST)
Date: Tue, 12 Jan 2021 16:50:12 +0000
From: Quentin Perret <qperret@google.com>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v2 15/26] of/fdt: Introduce
 early_init_dt_add_memory_hyp()
Message-ID: <X/3TRIkakv9mSHSQ@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-16-qperret@google.com>
 <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com>
 <X/1xN2UxiUxkzAiN@google.com>
 <CAL_Jsq+5d+Ox_-m_Rd83R9xoZb6e2cxCNfbL8YPzKdwj=y0M8Q@mail.gmail.com>
 <X/2xlxx9Ucp4UZvL@google.com>
 <CAL_Jsq+o+t4YYXEW_nYqMsT4ubYJWe6Kdhu614RtrCqsHBtfLw@mail.gmail.com>
 <X/3LIGgx83XJ+U0F@google.com>
 <CAL_Jsq+SeOrn4qFyFuPUmXdnM1oMNMLWLsDzrYgUt9Ts3hyoNg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+SeOrn4qFyFuPUmXdnM1oMNMLWLsDzrYgUt9Ts3hyoNg@mail.gmail.com>
Cc: devicetree@vger.kernel.org, Android Kernel Team <kernel-team@android.com>,
 Frank Rowand <frowand.list@gmail.com>, android-kvm@google.com,
 Catalin Marinas <catalin.marinas@arm.com>, Fuad Tabba <tabba@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <kvmarm@lists.cs.columbia.edu>
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

On Tuesday 12 Jan 2021 at 10:45:56 (-0600), Rob Herring wrote:
> Umm, yes you are right. But both are dealing with nomap. So someone
> needs to sort out what the right thing to do here is. No one cared
> enough to follow up in a year and a half.

Fair enough, happy to do that. I'll send a small series with these two
patches independently from this series which may take a while to land.

Thanks,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
