Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5D4CC035
	for <lists+kvmarm@lfdr.de>; Thu,  3 Mar 2022 15:42:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CE10049EC2;
	Thu,  3 Mar 2022 09:42:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MhdLNCIRKqu; Thu,  3 Mar 2022 09:42:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 82A7B49EC0;
	Thu,  3 Mar 2022 09:42:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 267FD49EB4
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Mar 2022 09:42:45 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fZEN1J2d2tJ9 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Mar 2022 09:42:43 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DBC4940D26
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Mar 2022 09:42:43 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1B7C961BF5;
 Thu,  3 Mar 2022 14:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B53FC004E1;
 Thu,  3 Mar 2022 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646318560;
 bh=fEawHlSGJkQ0TMVb3/JIkWCxFMc6aFdK2XAEdic1Qjs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VIiIhfqzn6HDo1LJf9inK7GaMGLx99MpAQGXtGHvV3mR0YmTBrEIRew2q+rYmoRoM
 twBrGb6i0nfIcqEO3SqFwGfb2lHJNY6IsN3w0+SLmF4ruAOgV9vTHI6dSYoeYY4cZt
 YfbmrIuboNoeiY8pUNNYQHJf4yaDr3j12tYhCwIAI/aw+6oLFwGvK1olMLtOj567yJ
 DhMeNgmIlR/xcuWkzekw2tbTJGJOkr6e+Ri4Ki2bnCiEcKR1LdKVDn4JElps0BN7wb
 IxRAVPCDZdMgkP1BPrBKw78fB6lnMROsw5R2pqW4IF0sUGTq9yZAsz9+60I6GHO6lQ
 J6lcem9C1PLuw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1nPmf8-00Byjk-1o; Thu, 03 Mar 2022 14:42:38 +0000
Date: Thu, 03 Mar 2022 14:42:37 +0000
Message-ID: <87v8wv14iq.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Eugene Huang <eugeneh@nvidia.com>
Subject: Re: Timer delays in VM
In-Reply-To: <BYAPR12MB3192AD55DF0B67DB2F7C78FFD9049@BYAPR12MB3192.namprd12.prod.outlook.com>
References: <BYAPR12MB31927AEB9D0A4068ED12826DD9019@BYAPR12MB3192.namprd12.prod.outlook.com>
 <667c9f084b2d38725369de60daef6d58@misterjones.org>
 <BYAPR12MB3192EFEBABB1B31D9751C931D9029@BYAPR12MB3192.namprd12.prod.outlook.com>
 <87wnhc6cef.wl-maz@kernel.org>
 <BYAPR12MB3192AD55DF0B67DB2F7C78FFD9049@BYAPR12MB3192.namprd12.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: eugeneh@nvidia.com, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
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

On Thu, 03 Mar 2022 05:49:00 +0000,
Eugene Huang <eugeneh@nvidia.com> wrote:
> 
> <EH> We have the following further 1-to-1 mappings:
> pcpu-20 - vcpu-0 is running your timer test, everything is fine
> pcpu-21 - vcpu-1 starts some other workload, and this affects the timer test
> on the other vcpu
> 
> - Each vCPU thread is pinned to its individual pCPU on the host (vcpupin in libvirt).
> - Each pCPU on which a vCPU thread runs is isolated on the host (isolcpus).
> - Each vCPU that runs the workload is isolated in the guest VM (isolcpus).
> 
> So we are pretty sure the workloads are separated.

Hmmm. Isolcpus certainly is something I never use. You may want to
check whether this has an influence on what your test's behaviour. You
may also want to post your full libvirt config, just in case someone
spots an issue there (I won't, as I know next to nothing about
libvirt).

> 
> > 
> > Also, please work out whether you exit because of a blocking WFI or WFE, as
> > they are indicative of different guest behaviour.
> 
> <EH> Will do. Somehow our current trace does not show this information.
> 
> > 
> > > Since we pin that workload to its own vCPU, in theory, it should not
> > > affect the timing of another vCPU.
> > 
> > Why not? a vcpu is just a host thread, and if they share a physical CPU at
> > some point, there is a knock-on effect.
> 
> <EH> Again, because of vcpupin in libvirt, there is no sharing of a
> pCPU among vCPUs. At least that is our configuration intention.

Which may or may not be what happens in reality. libvirt is largely
opaque, and because you ask it to do something doesn't mean it happens
the way you hope it does.

> 
> > 
> > > > You also don't mention what host kernel version you are running.
> > > > In general, please try and reproduce the issue using the latest
> > > > kernel version
> > > > (5.16 at the moment). Please also indicate what HW you are using.
> > >
> > > <EH> Tried 5.15 and 5.4 kernels. Both have the issue. Do you think
> > > 5.16 can make a difference? The HW is an Ampere Altra system.
> > 
> > Unlikely. The Altra is a mostly sane system, as long as you make sure that
> > VMs don't migrate across sockets (at which point it becomes laughably bad).
> > Nothing to do with KVM though.
> 
> <EH> Right, there is no migration of VMs.
> I see kvm arm timer related code is very different between 5.4 and
> 5.15/5.16.  Can we still use 5.4 for both the host and the guest?

That's your call. I've stopped looking at 5.4 a couple of minutes
after it was released. If I'm going to look for something, that will
be on top of upstream.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
