Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 521B7149A80
	for <lists+kvmarm@lfdr.de>; Sun, 26 Jan 2020 12:56:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0D534AF26;
	Sun, 26 Jan 2020 06:56:10 -0500 (EST)
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
	with ESMTP id OBry3oc9lMee; Sun, 26 Jan 2020 06:56:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6EA674AF35;
	Sun, 26 Jan 2020 06:56:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 33F4A4AF13
 for <kvmarm@lists.cs.columbia.edu>; Sun, 26 Jan 2020 06:56:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id evIdrHyEfB3O for <kvmarm@lists.cs.columbia.edu>;
 Sun, 26 Jan 2020 06:56:07 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3ACBC4AEBF
 for <kvmarm@lists.cs.columbia.edu>; Sun, 26 Jan 2020 06:56:07 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1030620700;
 Sun, 26 Jan 2020 11:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580039766;
 bh=GvIGv1MI/eOCaj0SZAXgD9vAtIzdzvrA7/ZPNS6pjW0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OS8ovI/tIj3NExuAYPpjRFKN8Eyborjxlqh7tin9jqJwd3RXunvFkl3xo/gCMk0Po
 GyzYI9TDdyAWVK+uQcJVpgmQAWrrRJkmuZXA+g1dggG5zzxAh6Tj/FgGy8Fc6LXr3V
 T+U+WHLX3/uXLFIMlJz2sxhI4Gbz6fDEwi9XBuJg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1ivgWJ-001TX7-R1; Sun, 26 Jan 2020 11:56:03 +0000
Date: Sun, 26 Jan 2020 11:56:02 +0000
From: Marc Zyngier <maz@kernel.org>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH 0/2] KVM: arm: fix KVM_CAP_ARM_INJECT_EXT_DABT for
 aarch32 guests
Message-ID: <20200126115602.6e67b11b@why>
In-Reply-To: <CADSWDzubQHvG8_c6a7E=basbtXxW-7u_ZVRz6+M7zGOAYYxz7A@mail.gmail.com>
References: <20200121123356.203000-1-james.morse@arm.com>
 <CADSWDzubQHvG8_c6a7E=basbtXxW-7u_ZVRz6+M7zGOAYYxz7A@mail.gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: beata.michalska@linaro.org, james.morse@arm.com,
 kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu
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

On Fri, 24 Jan 2020 15:39:29 +0000
Beata Michalska <beata.michalska@linaro.org> wrote:

Hi Beata,

> Hi James,
> 
> Thanks for the fixes - they work like a charm.
> 
> On Tue, 21 Jan 2020 at 12:34, James Morse <james.morse@arm.com> wrote:
> >
> > Beata reports that KVM_CAP_ARM_INJECT_EXT_DABT doesn't do the expected
> > thing for aarch32 guests. We get the wrong register layout, and weren't
> > even trying to set a 'external abort' in the first place!
> >
> > Both patches are intended as fixes, but patch 2 is somewhat in the eye
> > of the beholder. I don't know why an imp-def exception was picked...
> >  
> On a side note - currently KVM exposes capability that is not fully supported
> (till the fix gets applied) and there is no easy way for the user space to
> determine whether the injection will work as expected and whether it is safe to
> use it or not. Although this is addressing a problem that is not that common
> (I suppose) but still it might be worth to add a way for the kernel to inform
> the user-space that it is all good to go? There has been a 'similar' case in the
> past with KVM_SET_USER_MEMORY_REGION, where fixes where needed
> and those were announced through new caps. Now, I'm not sure if adding new
> capability would be the best approach here though it seems that there is not
> much of a choice?

My take on this particular issue is that although the functionality is
not perfectly working (far from it), it isn't completely broken (the
guest does get some form of abort). Furthermore, we tend to add this
kind of discovery mechanism when the userspace interface is broken, not
when we have an implementation defect in the CPU emulation.

The real question is whether there anything out there that would depend
on such broken behaviour?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
