Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C0B9535FB5D
	for <lists+kvmarm@lfdr.de>; Wed, 14 Apr 2021 21:10:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CA104B5D1;
	Wed, 14 Apr 2021 15:10:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vO1H4BGBRgc9; Wed, 14 Apr 2021 15:10:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E99054B5D0;
	Wed, 14 Apr 2021 15:10:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 896544B565
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 15:10:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqzu8m8eIgyr for <kvmarm@lists.cs.columbia.edu>;
 Wed, 14 Apr 2021 15:10:02 -0400 (EDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 606CB4B561
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 15:10:02 -0400 (EDT)
Received: by mail-vs1-f51.google.com with SMTP id l11so2392967vsr.10
 for <kvmarm@lists.cs.columbia.edu>; Wed, 14 Apr 2021 12:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z3hnQcI7xgmsUuxItoue27NrG4aaS9+tEraOADPkosg=;
 b=rJvYS+J2i2EDB7+H0ar79/9KmvFBlEX/IteDQrq+hZvhQqQReOy1b+AADr0cQalQxY
 PxnhJnEF2atVxze7tpA6bACUW9pw9VVOCHRRhz5BJb1yW+aY21NQry/q3kTxxwBWOzms
 y5vFPGI4/LGO9wgquxgyA27xGNGjlIIsn+cBDwPDh1hcXIYAfq5qWtwTT+8KqKflfFR/
 CLLqjSXNtF7wdbN6jEpBsSy7ahEsP9/U7049YzltFMONQlC+zFXcsIU6KTKDs+G00RiT
 wIeQzKiJjw0OQUptaVIE3tuO2vK8+DVBLQqoyO1FWW50Y1Gxna9hoMsvIl0t9Lao3JZF
 7SQA==
X-Gm-Message-State: AOAM53015/2X5gQVDMgNmS/xw5uZU1PmiAm9TIpVEjxZOe4ojjTLjuEC
 Z1qMg3JVzf3urGS/whyddinR3PC5V4hAClSUjSg=
X-Google-Smtp-Source: ABdhPJxJbGWB0l+pI+e+zsAVHVBLwrtdJbfPrWC2SKJve8ijlw7H6jw/dP0+aFP/QglhH1BBHAHmIOlyMsd9AxB04yU=
X-Received: by 2002:a67:80c4:: with SMTP id b187mr29948111vsd.42.1618427401975; 
 Wed, 14 Apr 2021 12:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210414134409.1266357-1-maz@kernel.org>
 <20210414134409.1266357-5-maz@kernel.org>
In-Reply-To: <20210414134409.1266357-5-maz@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Apr 2021 21:09:50 +0200
Message-ID: <CAMuHMdVfwRv_66mMz79rvszdgXnovrS_FZzPRK9fqOMH5Npu5A@mail.gmail.com>
Subject: Re: [PATCH 4/5] sh: Get rid of oprofile leftovers
To: Marc Zyngier <maz@kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, KVM list <kvm@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, nathan@kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Android Kernel Team <kernel-team@android.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Wed, Apr 14, 2021 at 3:53 PM Marc Zyngier <maz@kernel.org> wrote:
> perf_pmu_name() and perf_num_counters() are unused. Drop them.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
