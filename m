Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEE165FBBB
	for <lists+kvmarm@lfdr.de>; Fri,  6 Jan 2023 08:11:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 74F774107F;
	Fri,  6 Jan 2023 02:11:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VKylS-UClJ1V; Fri,  6 Jan 2023 02:11:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 163E84A0DA;
	Fri,  6 Jan 2023 02:11:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EC6140C29
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Jan 2023 02:11:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tktuA1SGVbJo for <kvmarm@lists.cs.columbia.edu>;
 Fri,  6 Jan 2023 02:11:27 -0500 (EST)
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 406BE40BA3
 for <kvmarm@lists.cs.columbia.edu>; Fri,  6 Jan 2023 02:11:27 -0500 (EST)
Date: Fri, 6 Jan 2023 08:11:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1672989085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fauj+NonVb8iLkKg1RFq1TexduZK1wTOfm20pD1NyCg=;
 b=JroxeUE7yy/Xx9l/Vx7NJIWTUGynOY1CexlSlRBwYdE2tmZNsfhYCMaIemYvwBrp0IkkdN
 TPEbLU0ORvdGdu+09QkEc6TGbxrtwK4LYNuBUIWwk+AOdoQqnI9pmxw2r9PCex2dMJDN67
 yv+o49uVsZHpJoVS3nTW3i2pcKTPUso=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Subject: Re: [kvm-unit-tests PATCH] arm: Remove MAX_SMP probe loop
Message-ID: <20230106071124.ytv6cmkvmvxhzmoh@orel>
References: <20221226182158.3azk5zwvl2vsy36h@orel>
 <gsntzgawr321.fsf@coltonlewis-kvm.c.googlers.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <gsntzgawr321.fsf@coltonlewis-kvm.c.googlers.com>
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Thu, Jan 05, 2023 at 11:09:58PM +0000, Colton Lewis wrote:
> Andrew Jones <andrew.jones@linux.dev> writes:
> > On Tue, Dec 20, 2022 at 04:32:00PM +0000, Colton Lewis wrote:
> > > Alexandru Elisei <alexandru.elisei@arm.com> writes:
> > Ah, I think I understand now. Were you running 32-bit arm tests? If so,
> > it'd be good to point that out explicitly in the commit message (the
> > 'arm:' prefix in the summary is ambiguous).
> 
> No, this was happening on arm64. Since it had been a while since I noted
> this issue, I reviewed it and realized the issue was only happening
> using -accel tcg. That was automatically being used on my problem test
> machine without me noticing. That's where the limit of 8 seems to be
> coming from and why the loop is triggered.
> 
> qemu-system-aarch64: Number of SMP CPUs requested (152) exceeds max CPUs
> supported by machine 'mach-virt' (8)
> 
> Since this case doesn't directly involve KVM, I doubt anyone cares about
> a fix.
> 
> > Assuming the loop body was running because it needed to reduce MAX_SMP to
> > 8 or lower for 32-bit arm tests, then we should be replacing the loop with
> > something that caps MAX_SMP at 8 for 32-bit arm tests instead.
> 
> We could cap at 8 for ACCEL=tcg. Even if no one cares, I'm tempted to do
> it so no one hits the same little landmine as me in the future.

TCG supports up to 255 CPUs. The only reason it'd have a max of 8 is if
you were configuring a GICv2 instead of a GICv3. Using gic-version=3 or
gic-version=max should allow the 152 CPUs to work. Actually, I should
have asked about your gic version instead of whether or not the VM was
AArch32 in the first place. I was incorrectly associating the gicv2
limits with arm32 since my memories of these things have started to
blur together...

Thanks,
drew
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
