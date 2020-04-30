Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFD1C0564
	for <lists+kvmarm@lfdr.de>; Thu, 30 Apr 2020 20:57:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4BDF04B5AA;
	Thu, 30 Apr 2020 14:57:53 -0400 (EDT)
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
	with ESMTP id thp1kYWhnntN; Thu, 30 Apr 2020 14:57:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D9944B5A2;
	Thu, 30 Apr 2020 14:57:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 619C14B58E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 14:57:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qwiX0H1zlUVX for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Apr 2020 14:57:49 -0400 (EDT)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 565B64B3CE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 14:57:49 -0400 (EDT)
Received: by mail-wm1-f66.google.com with SMTP id y24so3295414wma.4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Apr 2020 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=d5WxWhtGo9e2cw/8suqpVIB4+YEef9w62JZ0kEYHubo=;
 b=nfLflQyW8kj3CShI0XY4Vf6gRlgHFhTVQZw/GdD/zV4jALyGUkiWfG1+YbmI/MdYAj
 bdgTZPpCZ7Uf3+4PI7o2+IBAYzeEoV2BgNFA/RJ5ZJJkLTEnSmU8eG+X+oGMBE9ASWq9
 FlAdajBRHQVg1AZ3Ljwgtn8mCP8u3g8A/uGbua+pVlGqTbJdH+KsVd6ioM/C7DLFfrdR
 KJv+BsPm8MJOEf0OU/7N8vwe34xLtNw38tm8MlwiUDdAgkIEqasbbBr+Bv2uA/8MaTY6
 rN2xSH/xxF9Rupsf5ruVst0HeoT4VWff/Z2RxG0CBHKc/8ClZusJAiOUrSSWH7m83gcp
 p85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d5WxWhtGo9e2cw/8suqpVIB4+YEef9w62JZ0kEYHubo=;
 b=AvD6Arpb/+RWmMxgzfKwkcshGkTtPe1N2zd5zH0aceAcdXIS6SzCZMC8t7uWQ900a3
 /03r/7lfWbSweEviEwGO3UiQZEc8YnzzVnl4NqaLmRpYtjW9emjR353BxnwcaMaQ2cJv
 FtkK9TLcWVxha+11LFr1992xeSx6ILHWCD5dahUBAF1xRyClKjxP29D6DR7Dm4L2Mk2x
 1uEvaYNEHhQE/7LnUhbiMIAwbXb0A20mMAH0Km+ww3TUpfyODunZqa78P4oTf4ThMlMj
 qLVK4nQ5gNTJoH7BHsYbrxotjWxI3Qg6dyFM9OE4Doz8oknb7nn5WpwMJ6816AOqeQpY
 be7g==
X-Gm-Message-State: AGi0Puael58Z1d2Ovg0OFm793Sy67/fQTVP2yVkBEaTvSvb+Tafar8S2
 /xCdlMObhFxaVLkBx2U54KAPsA==
X-Google-Smtp-Source: APiQypJv60KX28ucnsH13Cw7j+iU/N3+xGie9VPYRPXyvaTcmuL9pnj+qnn6cgfiQwc5zxsDYQrDUA==
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr4867772wmi.91.1588273067897; 
 Thu, 30 Apr 2020 11:57:47 -0700 (PDT)
Received: from dbrazdil-macbookpro.roam.corp.google.com
 ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
 by smtp.gmail.com with ESMTPSA id j10sm713583wmi.18.2020.04.30.11.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:57:46 -0700 (PDT)
From: David Brazdil <dbrazdil@google.com>
X-Google-Original-From: David Brazdil
 <dbrazdil@dbrazdil-macbookpro.roam.corp.google.com>
Date: Thu, 30 Apr 2020 19:57:45 +0100
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 00/15] Split off nVHE hyp code
Message-ID: <20200430185745.rcsug4f55yh5jtyr@dbrazdil-macbookpro.roam.corp.google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <73efca41e7b955db4963ff182624107d@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73efca41e7b955db4963ff182624107d@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
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

Hey Marc,

> Do you have any figure on how much bigger the final kernel becomes once this
> is applied? I guess I can find out pretty easily, but this is the kind of
> thing
> that would be useful to make part of your cover letter.
Bloat-o-meter puts the diff at 21KB:
  add/remove: 152/45 grow/shrink: 10/32 up/down: 27882/-6240 (21642)
That said, the size of `Image` hasn't changed at all, not sure why that is.
The size of Image.gz has gone up by 10KB.

> 
> I'll try to review this shortly.
Cheers, no rush.

-David
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
