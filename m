Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C77FB2FF2FB
	for <lists+kvmarm@lfdr.de>; Thu, 21 Jan 2021 19:14:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD7504B0F5;
	Thu, 21 Jan 2021 13:14:27 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6JvV5Bbr7ogY; Thu, 21 Jan 2021 13:14:27 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7815A4B186;
	Thu, 21 Jan 2021 13:14:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9F1AA4B0DE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Jan 2021 13:14:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FId2XrZrdiR4 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 21 Jan 2021 13:14:23 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C8EAF4B0DB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 21 Jan 2021 13:14:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611252863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEgMkUTOCJsoedIDEpBA2hjPtpKSlnIAkYz8Z2MMNg0=;
 b=HhV9sQ15u8xtMOCvc5f7XYyaKls4zmWZ3XnrKGBi8SLVsOj0ainwS2r11PbitDq/PEEzgD
 EE2r0OTfgQI7XSyaey4DEEolQZQK7q73EAJFV4O+cZdnE5kR1jFKNnNreppBZcyS+lSnkI
 4BgDr7WmTT+vV4pVuOb0T52Anx48y6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-4sowHxENOA-jNF3X_XPxfw-1; Thu, 21 Jan 2021 13:14:19 -0500
X-MC-Unique: 4sowHxENOA-jNF3X_XPxfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87956107ACE3;
 Thu, 21 Jan 2021 18:14:16 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1251139A63;
 Thu, 21 Jan 2021 18:14:15 +0000 (UTC)
Date: Thu, 21 Jan 2021 11:14:14 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2 2/2] vfio/iommu_type1: Sanity check pfn_list when
 remove vfio_dma
Message-ID: <20210121111414.143e3e4e@omen.home.shazbot.org>
In-Reply-To: <32f8b347-587a-1a9a-bee8-569f09a03a15@huawei.com>
References: <20210115092643.728-1-zhukeqian1@huawei.com>
 <20210115092643.728-3-zhukeqian1@huawei.com>
 <20210115121447.54c96857@omen.home.shazbot.org>
 <32f8b347-587a-1a9a-bee8-569f09a03a15@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc
 Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, 18 Jan 2021 21:16:08 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> On 2021/1/16 3:14, Alex Williamson wrote:
> > On Fri, 15 Jan 2021 17:26:43 +0800
> > Keqian Zhu <zhukeqian1@huawei.com> wrote:
> >   
> >> vfio_sanity_check_pfn_list() is used to check whether pfn_list of
> >> vfio_dma is empty when remove the external domain, so it makes a
> >> wrong assumption that only external domain will add pfn to dma pfn_list.
> >>
> >> Now we apply this check when remove a specific vfio_dma and extract
> >> the notifier check just for external domain.  
> > 
> > The page pinning interface is gated by having a notifier registered for
> > unmaps, therefore non-external domains would also need to register a
> > notifier.  There's currently no other way to add entries to the
> > pfn_list.  So if we allow pinning for such domains, then it's wrong to
> > WARN_ON() when the notifier list is not-empty when removing an external
> > domain.  Long term we should probably extend page {un}pinning for the
> > caller to pass their notifier to be validated against the notifier list
> > rather than just allowing page pinning if *any* notifier is registered.
> > Thanks,  
> I was misled by the code comments. So when the commit a54eb55045ae is
> added, the only user of pin interface is mdev vendor driver, but now
> we also allow iommu backed group to use this interface to constraint
> dirty scope. Is vfio_iommu_unmap_unpin_all() a proper place to put
> this WARN()?

vfio_iommu_unmap_unpin_all() deals with removing vfio_dmas, it's
logically unrelated to whether any driver is registered to receive
unmap notifications.  Thanks,

Alex

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
