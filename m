Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C0D034740FD
	for <lists+kvmarm@lfdr.de>; Tue, 14 Dec 2021 12:00:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5230E4B204;
	Tue, 14 Dec 2021 06:00:19 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrPAjOV5clJ6; Tue, 14 Dec 2021 06:00:19 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B61F4B1F8;
	Tue, 14 Dec 2021 06:00:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 618224B10A
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Dec 2021 06:00:16 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bnq9fHZLvvSv for <kvmarm@lists.cs.columbia.edu>;
 Tue, 14 Dec 2021 06:00:15 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 52CCD4B105
 for <kvmarm@lists.cs.columbia.edu>; Tue, 14 Dec 2021 06:00:15 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6990DB8172C;
 Tue, 14 Dec 2021 11:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFE3C34600;
 Tue, 14 Dec 2021 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639479612;
 bh=0ESaXKHWL9SLGm1fqUxFqoZci08kgM2YFDP0m90NL08=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QUXdayKKWYNM6YPtPSq3vRZD/lKDGFogMz1FvlPqrkX9qrTpSx4Gn01Crm3N08aKe
 CgUjjym0vZAhdFrnvFmjSbAZK3j3pvw/H6/9kjCeEuFphLScikI+8piTmfh2hMkAfZ
 ffmal8W0WpjRbZxCEGJZLIxvJCak8RD3AE+cUuXQcQeX31bvPJFBR8S/YrFRnTJNx5
 CsFbpUYesoOdlCzKdgqHogtDX1IYcr8G1D93nKKPcVxvHk1fQJf/eKFMXlLkwkxw6m
 SmveboKScUAniznjnj5KNyiYcTBsQJzd25bRAHiUDvSxRqC2C2uJC2N14EH6vU4Vox
 c9ghB5u/W1qHw==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mx5XW-00C1e9-Bg; Tue, 14 Dec 2021 11:00:10 +0000
Date: Tue, 14 Dec 2021 11:00:10 +0000
Message-ID: <878rwnjvt1.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Libvirt on little.BIG ARM systems unable to start guest if no
 cpuset is provided
In-Reply-To: <242ff064-ba82-a045-a407-eaf9dbe5bb40@gmx.com>
References: <70a2f7d6-5ac1-72df-4a88-b1a662d07070@gmx.com>
 <32bb61a9-0938-d254-0453-18a108bc4b63@redhat.com>
 <1dc0403b-c61b-b04b-e7fd-f2d66276ba7b@gmx.com>
 <CAFEAcA-URrpy3w3AtDb8zVfq8fWxvQ8_jtSqEkaeb=3KE99oAQ@mail.gmail.com>
 <87lf0ojvq2.wl-maz@kernel.org>
 <aa407ba2-e9c4-882e-a085-91e7dd724f78@gmx.com>
 <29409a18-5156-6b3a-6a44-eecd83a20a78@redhat.com>
 <2281a255-fef3-c872-963e-2c5274d0d815@gmx.com>
 <87ee6fjyyh.wl-maz@kernel.org>
 <242ff064-ba82-a045-a407-eaf9dbe5bb40@gmx.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: quwenruo.btrfs@gmx.com, mprivozn@redhat.com,
 peter.maydell@linaro.org, libvirt-users@redhat.com, qemu-arm@nongnu.org,
 kvmarm@lists.cs.columbia.edu, qemu-discuss@nongnu.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Michal =?UTF-8?B?UHLDrXZvem7DrWs=?= <mprivozn@redhat.com>,
 qemu-discuss@nongnu.org, libvirt-users@redhat.com, qemu-arm@nongnu.org,
 kvmarm <kvmarm@lists.cs.columbia.edu>
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

On Tue, 14 Dec 2021 10:21:40 +0000,
Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2021/12/14 17:52, Marc Zyngier wrote:
> > The best workaround is to taskset the QEMU process (and I really mean
> > the process, not individual threads) to an homogeneous set of CPUs and
> > be done with it.
> 
> Yeah, that's why the cpuset way is working, as it seems also limiting
> the initial "temporary" VM creating to specified CPUs.
> 
> Just curious, is there some defined common VM related registers that can
> be restore on all cores? (At least for A53 + A72 case).

Most of the registers are common, and most of the feature registers
are actually massaged by KVM to make them look homogeneous if even the
HW isn't. There are however a few registers that need to be exposed to
the guest verbatim, and MIDR_EL1 is the most important one, as it
carries the core 'identity', which an operating system will absolutely
need to implement critical workarounds (and there are no shortage of
them on both A53 and A72).

> If completely no, then virtualization is really not even targeted for
> BIG.little designs I guess.

If your use of virtualisation is to be completely abstracted from the
underlying HW, then you are right, that doesn't really work at all.
Not by design, but because all implementations have embarrassing warts
that need some sort of workarounds.

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
