Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5830D360778
	for <lists+kvmarm@lfdr.de>; Thu, 15 Apr 2021 12:47:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0B714B6FA;
	Thu, 15 Apr 2021 06:47:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cw+n1kOaXh+8; Thu, 15 Apr 2021 06:47:34 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A79164B6BD;
	Thu, 15 Apr 2021 06:47:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C68444B6A4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 06:47:31 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id swbeH9p5Q3UP for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Apr 2021 06:47:31 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E35F14B6A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 06:47:30 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D806D61139;
 Thu, 15 Apr 2021 10:47:29 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lWzWx-007cd1-Sb; Thu, 15 Apr 2021 11:47:28 +0100
Date: Thu, 15 Apr 2021 11:47:26 +0100
Message-ID: <87fszrn7sx.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 3/5] s390: Get rid of oprofile leftovers
In-Reply-To: <YHgXvFCLh0Ls0b9t@osiris>
References: <20210414134409.1266357-1-maz@kernel.org>
 <20210414134409.1266357-4-maz@kernel.org> <YHgXvFCLh0Ls0b9t@osiris>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: hca@linux.ibm.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, mark.rutland@arm.com, will@kernel.org,
 dalias@libc.org, ysato@users.sourceforge.jp, peterz@infradead.org,
 acme@kernel.org, borntraeger@de.ibm.com, nathan@kernel.org,
 viresh.kumar@linaro.org, james.morse@arm.com, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: linux-s390@vger.kernel.org, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, kvm@vger.kernel.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, nathan@kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, kernel-team@android.com,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Thu, 15 Apr 2021 11:38:52 +0100,
Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> On Wed, Apr 14, 2021 at 02:44:07PM +0100, Marc Zyngier wrote:
> > perf_pmu_name() and perf_num_counters() are unused. Drop them.
> > 
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/s390/kernel/perf_event.c | 21 ---------------------
> >  1 file changed, 21 deletions(-)
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> 
> ...or do you want me to pick this up and route via the s390 tree(?).

Either way work for me, but I just want to make sure the last patch
doesn't get applied before the previous ones.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
