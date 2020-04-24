Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76A1B7136
	for <lists+kvmarm@lfdr.de>; Fri, 24 Apr 2020 11:51:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 78AD44B285;
	Fri, 24 Apr 2020 05:51:51 -0400 (EDT)
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
	with ESMTP id 4ygG10zjFxom; Fri, 24 Apr 2020 05:51:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4CA134B280;
	Fri, 24 Apr 2020 05:51:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E8F284B27B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Apr 2020 05:51:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6TzrUXV0Hnz9 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 24 Apr 2020 05:51:48 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EF16E4B278
 for <kvmarm@lists.cs.columbia.edu>; Fri, 24 Apr 2020 05:51:47 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9790A20728;
 Fri, 24 Apr 2020 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587721907;
 bh=GlmWL52bv6OnLp9DBrDN1ldUCRy/XQQdtf9ANF1syTg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=v5nleYikOuIFnS0BI7aR6eooGKKHQ5ItndtMTTMulwEAhRMdR/qpxngv1ZCzwqvD/
 pfCGsm16KpvVb0SiPFO0ntXGzDV3zOVACX2s8lgJFi1mO2VlB+RfR98rDQRHf6mDwI
 BSycbMR0P6QSaPD/xbnQFlMRPuDd/+NVG6xfaCI8=
Date: Fri, 24 Apr 2020 10:51:42 +0100
From: Will Deacon <will@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH kvmtool v4 1/5] virtio-mmio: Assign IRQ line directly
 before registering device
Message-ID: <20200424095141.GA21141@willie-the-truck>
References: <20200423173844.24220-1-andre.przywara@arm.com>
 <20200423173844.24220-2-andre.przywara@arm.com>
 <20200424084104.GB20801@willie-the-truck>
 <a8b424ed-9c63-bc72-6608-3e7e01dbdbce@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a8b424ed-9c63-bc72-6608-3e7e01dbdbce@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Raphael Gault <raphael.gault@arm.com>, Sami Mujawar <sami.mujawar@arm.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Fri, Apr 24, 2020 at 09:50:04AM +0100, Andr=E9 Przywara wrote:
> On 24/04/2020 09:41, Will Deacon wrote:
> > On Thu, Apr 23, 2020 at 06:38:40PM +0100, Andre Przywara wrote:
> >> diff --git a/devices.c b/devices.c
> >> index a7c666a7..2c8b2665 100644
> >> --- a/devices.c
> >> +++ b/devices.c
> >> @@ -1,7 +1,6 @@
> >>  #include "kvm/devices.h"
> >>  #include "kvm/kvm.h"
> >>  #include "kvm/pci.h"
> >> -#include "kvm/virtio-mmio.h"
> >>  =

> >>  #include <linux/err.h>
> >>  #include <linux/rbtree.h>
> >> @@ -33,9 +32,6 @@ int device__register(struct device_header *dev)
> >>  	case DEVICE_BUS_PCI:
> >>  		pci__assign_irq(dev);
> >>  		break;
> >> -	case DEVICE_BUS_MMIO:
> >> -		virtio_mmio_assign_irq(dev);
> >> -		break;
> > =

> > Hmm, but then it's a bit ugly to handle these differently to PCI. How
> > difficult is it to add a new bus type instead? e.g. stick the virtio mm=
io
> > devices on DEVICE_BUS_VIRTIO_MMIO and then add the non-virtio MMIO devi=
ces
> > to DEVICE_BUS_MMIO?
> =

> I have another patch to also do the IRQ allocation for PCI devices in
> their callers. This avoids the allocation on an IRQ for vesa, for
> instance, but otherwise doesn't solve a real problem, so I didn't post
> it yet.
> By looking at devices.c, I feel like this should only be handling the
> administrative part of managing the device_header structs in the rbtree.
> Dealing with bus specific things looks out of scope for this file, IMHO.
> =

> If you agree, I will send the patch shortly.

Yes please.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
