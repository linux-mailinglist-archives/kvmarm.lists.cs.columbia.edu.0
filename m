Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE9212EE5
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 23:33:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BDB484B17A;
	Thu,  2 Jul 2020 17:33:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dxRbIs4CHNC5; Thu,  2 Jul 2020 17:33:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A01854B176;
	Thu,  2 Jul 2020 17:33:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BA1D84B170
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 17:33:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7K+OM-0gNPeU for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 17:33:31 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DFF854B16B
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 17:33:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593725611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0h1v1gqoiYvmFvRrxXEUuS8DGV7OpPpVRJ2+qA494c0=;
 b=bMsfqgsRo9y0umabz2MyOc85fcioacMp5u2ZWIobyZmkb4O2vVCTOTqtxPS5klruEnClU2
 vucNzDuhDzjCYaqe0DYgy2xCNBdR6z4RW2oKwxvRWRheXb9BJCJwfh1O5iWyRS4KJ19X90
 RggujmFgJzO3D3LIU65X0sOEEztUzTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-sOPfLPf9ON2iAjzy-rk44A-1; Thu, 02 Jul 2020 17:33:29 -0400
X-MC-Unique: sOPfLPf9ON2iAjzy-rk44A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 556CD186A200;
 Thu,  2 Jul 2020 21:33:28 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 497047610C;
 Thu,  2 Jul 2020 21:33:23 +0000 (UTC)
Date: Thu, 2 Jul 2020 23:33:20 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 3/8] arm64: microbench: gic: Add
 gicv4.1 support for ipi latency test.
Message-ID: <20200702213320.6okdtuesqkpz3c3t@kamzik.brq.redhat.com>
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
 <20200702030132.20252-4-wangjingyi11@huawei.com>
 <087ef371-5e7b-e0b2-900f-67b2eacb4e0f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <087ef371-5e7b-e0b2-900f-67b2eacb4e0f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Thu, Jul 02, 2020 at 02:57:56PM +0200, Auger Eric wrote:
> Hi Jingyi,
> 
> On 7/2/20 5:01 AM, Jingyi Wang wrote:
> > If gicv4.1(sgi hardware injection) supported, we test ipi injection
> > via hw/sw way separately.
> > 
> > Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
> > ---
> >  arm/micro-bench.c    | 45 +++++++++++++++++++++++++++++++++++++++-----
> >  lib/arm/asm/gic-v3.h |  3 +++
> >  lib/arm/asm/gic.h    |  1 +
> >  3 files changed, 44 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arm/micro-bench.c b/arm/micro-bench.c
> > index fc4d356..80d8db3 100644
> > --- a/arm/micro-bench.c
> > +++ b/arm/micro-bench.c
> > @@ -91,9 +91,40 @@ static void gic_prep_common(void)
> >  	assert(irq_ready);
> >  }
> >  
> > -static void ipi_prep(void)
> > +static bool ipi_prep(void)
> Any reason why the bool returned value is preferred over the standard int?

Why would an int be preferred over bool if the return is boolean?

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
