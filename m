Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20E322EAB
	for <lists+kvmarm@lfdr.de>; Tue, 23 Feb 2021 17:25:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E8E244B1FE;
	Tue, 23 Feb 2021 11:25:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nyK2zD3K8I4J; Tue, 23 Feb 2021 11:25:20 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9CD524B1D2;
	Tue, 23 Feb 2021 11:25:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D604F4B1A5
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Feb 2021 11:25:17 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jZ3-kMFtU2v6 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 23 Feb 2021 11:25:16 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D4E4F4B196
 for <kvmarm@lists.cs.columbia.edu>; Tue, 23 Feb 2021 11:25:16 -0500 (EST)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5264E64E3F;
 Tue, 23 Feb 2021 16:25:14 +0000 (UTC)
Date: Tue, 23 Feb 2021 11:25:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v2 1/4] bug: Remove redundant condition check in report_bug
Message-ID: <20210223112512.30746025@gandalf.local.home>
In-Reply-To: <20210223155759.3495252-2-ascull@google.com>
References: <20210223155759.3495252-1-ascull@google.com>
 <20210223155759.3495252-2-ascull@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: kernel-team@android.com, Kees Cook <keescook@chromium.org>,
 Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
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

On Tue, 23 Feb 2021 15:57:56 +0000
Andrew Scull <ascull@google.com> wrote:

> report_bug() will return early if it cannot find a bug corresponding to
> the provided address. The subsequent test for the bug will always be
> true so remove it.

Fixes: 1b4cfe3c0a30d ("lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()")

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Andrew Scull <ascull@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> ---
>  lib/bug.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/bug.c b/lib/bug.c
> index 7103440c0ee1..4ab398a2de93 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -158,30 +158,27 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>  
>  	file = NULL;
>  	line = 0;
> -	warning = 0;
>  
> -	if (bug) {
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
> -		file = bug->file;
> +	file = bug->file;
>  #else
> -		file = (const char *)bug + bug->file_disp;
> +	file = (const char *)bug + bug->file_disp;
>  #endif
> -		line = bug->line;
> +	line = bug->line;
>  #endif
> -		warning = (bug->flags & BUGFLAG_WARNING) != 0;
> -		once = (bug->flags & BUGFLAG_ONCE) != 0;
> -		done = (bug->flags & BUGFLAG_DONE) != 0;
> -
> -		if (warning && once) {
> -			if (done)
> -				return BUG_TRAP_TYPE_WARN;
> -
> -			/*
> -			 * Since this is the only store, concurrency is not an issue.
> -			 */
> -			bug->flags |= BUGFLAG_DONE;
> -		}
> +	warning = (bug->flags & BUGFLAG_WARNING) != 0;
> +	once = (bug->flags & BUGFLAG_ONCE) != 0;
> +	done = (bug->flags & BUGFLAG_DONE) != 0;
> +
> +	if (warning && once) {
> +		if (done)
> +			return BUG_TRAP_TYPE_WARN;
> +
> +		/*
> +		 * Since this is the only store, concurrency is not an issue.
> +		 */
> +		bug->flags |= BUGFLAG_DONE;
>  	}
>  
>  	/*

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
