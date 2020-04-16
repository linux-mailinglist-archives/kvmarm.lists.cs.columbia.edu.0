Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 411FD1ABCB4
	for <lists+kvmarm@lfdr.de>; Thu, 16 Apr 2020 11:21:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA5394B24C;
	Thu, 16 Apr 2020 05:21:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O6zHt7tB-uQ3; Thu, 16 Apr 2020 05:21:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8EC8A4B22B;
	Thu, 16 Apr 2020 05:21:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E3E94B19E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Apr 2020 05:21:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bfwSysmdLaxs for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Apr 2020 05:21:48 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 729FB4B18D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Apr 2020 05:21:48 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E136206D6;
 Thu, 16 Apr 2020 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587028907;
 bh=I43NbjtBbDTS3CdmNbDTSnB2YBA20hxQfVK2qJSV0pA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g83L9WrWpa7zZKiaiS6luhTWDkfuZ17XTZCP8NRcLRn254JtYa0uGXGudhneZ6pu1
 hyUYQMDC7TNT3NgJXB7B4ek8JM8jfM3LBM11aQ5+nVfs+bRt+caLIyjf8xulpwec3U
 pzEjCIO75dimEISJcPBelM60n/dMQdalKjee+8yE=
Date: Thu, 16 Apr 2020 10:21:41 +0100
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH RFCv1 0/7] Support Async Page Fault
Message-ID: <20200416092141.GA30816@willie-the-truck>
References: <20200410085820.758686-1-gshan@redhat.com>
 <d2882e806ad2f9793437160093c8d3fa@kernel.org>
 <6a1d7e8b-da10-409f-16d0-354004566a1a@redhat.com>
 <20200414110554.GB2486@C02TD0UTHF1T.local>
 <5bc62c4f-e19d-82f2-072e-dfa4498dccf3@redhat.com>
 <20200416091621.GA4987@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200416091621.GA4987@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Gavin Shan <gshan@redhat.com>, catalin.marinas@arm.com,
 sudeep.holla@arm.com, shan.gavin@gmail.com, Marc Zyngier <maz@kernel.org>,
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

On Thu, Apr 16, 2020 at 10:16:22AM +0100, Mark Rutland wrote:
> On Thu, Apr 16, 2020 at 05:59:33PM +1000, Gavin Shan wrote:
> > However, the hypercall number and behaviors are guarded by
> > specification. For example, the hypercalls used by para-virtualized
> > stolen time, which are defined in include/linux/arm-smccc.h, are
> > specified by ARM DEN0057A [1]. So I need a specification to be
> > created, where the hypercalls used by this feature are defined? If
> > it's not needed, can I pick hypercalls that aren't used and define
> > their behaviors by myself?
> > 
> > [1] http://infocenter.arm.com/help/topic/com.arm.doc.den0057a/DEN0057A_Paravirtualized_Time_for_Arm_based_Systems_v1_0.pdf
> 
> Take a look at the SMCCC / SMC Calling Convention:
> 
>  https://developer.arm.com/docs/den0028/c
> 
> ... that defines ranges set aside for hypervisor-specific usage, and
> despite its name it also applies to HVC calls.
> 
> There's been intermittent work to add a probing story for that, so that
> part is subject to change, but for prototyping you can just choose an
> arbitray number in that range -- just be suere to mention in the commit
> and cover letter that this part isn't complete.

Right, might be simplest to start off with:

https://android-kvm.googlesource.com/linux/+/refs/heads/willdeacon/hvc

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
