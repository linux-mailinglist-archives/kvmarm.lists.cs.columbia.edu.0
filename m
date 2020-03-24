Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 03B09190D1E
	for <lists+kvmarm@lfdr.de>; Tue, 24 Mar 2020 13:14:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E9874B08B;
	Tue, 24 Mar 2020 08:14:22 -0400 (EDT)
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
	with ESMTP id vZVpirzCR6Vt; Tue, 24 Mar 2020 08:14:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51F444B09F;
	Tue, 24 Mar 2020 08:14:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6139D4B093
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Mar 2020 08:14:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sC5Ls3fj5g8Q for <kvmarm@lists.cs.columbia.edu>;
 Tue, 24 Mar 2020 08:14:18 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3509E4B082
 for <kvmarm@lists.cs.columbia.edu>; Tue, 24 Mar 2020 08:14:18 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A54920658;
 Tue, 24 Mar 2020 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585052057;
 bh=dhtvbB+PPXUZoBcoMnaOLzrw631OzqnrbINwvvOINt4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BgAC6V2Az+2jFYEhLlmiHR3DebSQCeuePZdwonD5gjANLrYa9D+arvTk94T7GB+BZ
 +YV6s/yqUjiFPXUurWd/i7Nk6p/54EQx+aFWgjpj7OXiVAZUdZF+ehgehCHIaMuDJL
 IsReRW1A7GPCm69FfQjZKPUGQla2Wxpj9rbdq9Zc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jGiRj-00FFea-4G; Tue, 24 Mar 2020 12:14:15 +0000
Date: Tue, 24 Mar 2020 12:14:13 +0000
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v6 08/23] irqchip/gic-v4.1: Plumb skeletal VSGI irqchip
Message-ID: <20200324121413.12839170@why>
In-Reply-To: <0ac3af1c-5160-a528-f2b4-aac4833ce32c@huawei.com>
References: <20200320182406.23465-1-maz@kernel.org>
 <20200320182406.23465-9-maz@kernel.org>
 <0ac3af1c-5160-a528-f2b4-aac4833ce32c@huawei.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net,
 tglx@linutronix.de, eric.auger@redhat.com, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, 24 Mar 2020 10:27:18 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

> On 2020/3/21 2:23, Marc Zyngier wrote:
> > +static int its_sgi_set_affinity(struct irq_data *d,
> > +				const struct cpumask *mask_val,
> > +				bool force)
> > +{
> > +	/*
> > +	 * There is no notion of affinity for virtual SGIs, at least
> > +	 * not on the host (since they can only be targetting a vPE).
> > +	 * Tell the kernel we've done whetever it asked for.  
> 
> new typo?
> s/whetever/whatever/

Yeah, I'm that good... :-(.

Fixed now.

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
