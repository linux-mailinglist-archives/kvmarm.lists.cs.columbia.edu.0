Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8B33882D
	for <lists+kvmarm@lfdr.de>; Fri, 12 Mar 2021 10:03:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 848C94B72D;
	Fri, 12 Mar 2021 04:03:05 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bue7qvAuqlVc; Fri, 12 Mar 2021 04:03:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 70DB04B709;
	Fri, 12 Mar 2021 04:03:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B85364B6FE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 04:03:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AiTnJIS4kf7C for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Mar 2021 04:03:02 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A388B4B2EE
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 04:03:02 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 89D0064FE0;
 Fri, 12 Mar 2021 09:03:01 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1lKdhD-001Ac7-Km; Fri, 12 Mar 2021 09:02:59 +0000
Date: Fri, 12 Mar 2021 09:02:58 +0000
Message-ID: <87lfasg2wt.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Shenming Lu <lushenming@huawei.com>
Subject: Re: [PATCH v3 2/4] KVM: arm64: GICv4.1: Try to save hw pending state
 in save_pending_tables
In-Reply-To: <3b47598f-0795-a165-1a64-abe02258b306@huawei.com>
References: <20210127121337.1092-1-lushenming@huawei.com>
 <20210127121337.1092-3-lushenming@huawei.com>
 <87v99yf450.wl-maz@kernel.org>
 <3b47598f-0795-a165-1a64-abe02258b306@huawei.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lushenming@huawei.com, eric.auger@redhat.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com, cohuck@redhat.com,
 lorenzo.pieralisi@arm.com, wanghaibin.wang@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
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

On Thu, 11 Mar 2021 12:31:48 +0000,
Shenming Lu <lushenming@huawei.com> wrote:
> 
> On 2021/3/11 17:09, Marc Zyngier wrote:

> > I have asked that question in the past: is it actually safe to remap
> > the vPEs and expect them to be runnable
> 
> In my opinion, logically it can work, but there might be problems like the
> one below that I didn't notice...

One thing is that you will have lost interrupts in the meantime
(assuming your devices are still alive). How will you make up for
that?

> 
> > 
> > Also, the current code assumes that VMAPP.PTZ can be advertised if a
> > VPT is mapped for the first time. Clearly, it is unlikely that the VPT
> > will be only populated with 0s, so you'll end up with state corruption
> > on the first remap.
> 
> Oh, thanks for pointing it out.
> And if we always signal PTZ when alloc = 1, does it mean that we
> can't remap the vPE when the VPT is not empty, thus there is no
> chance to get the VLPI state?  Could we just assume that the VPT is
> not empty when first mapping the vPE?

I think we should drop the setting of PTZ altogether. It is a silly
micro-optimisation, and if the HW can't parse the VPT efficiently when
it is empty, then the HW is pretty bad, PTZ or not.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
