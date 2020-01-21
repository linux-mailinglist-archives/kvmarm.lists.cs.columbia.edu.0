Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA12143D3F
	for <lists+kvmarm@lfdr.de>; Tue, 21 Jan 2020 13:48:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A68734B00A;
	Tue, 21 Jan 2020 07:48:01 -0500 (EST)
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
	with ESMTP id sdGG1qAn1AE6; Tue, 21 Jan 2020 07:48:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 134224AFFC;
	Tue, 21 Jan 2020 07:47:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8BA5C4AFDD
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 07:47:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0NdffqEzwEmf for <kvmarm@lists.cs.columbia.edu>;
 Tue, 21 Jan 2020 07:47:50 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E6B7A4AFD2
 for <kvmarm@lists.cs.columbia.edu>; Tue, 21 Jan 2020 07:47:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579610870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GY+iQRTVNqzAwyuJVyAGWCFYTd4Vb20jwokeXldetiQ=;
 b=V9l/RjOrn5bDjy2gOLBOFwkEvsrMDrQ09s5AXSFxEryBPS+7M8MWYIymWxMJLsk6HNlTff
 pXsanWHlOHpFnKuYMIJhSxIVfeArffxP8JmWjNtsfxxCCpOcwtkY3jJM5zMWm3fnvOWcbF
 jiXv3jpgKH78MfbR77W0H5qh3cxUW1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-o7pT7f5bM8uq-sa5KpjA-Q-1; Tue, 21 Jan 2020 07:47:49 -0500
X-MC-Unique: o7pT7f5bM8uq-sa5KpjA-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E385190D340;
 Tue, 21 Jan 2020 12:47:48 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0000E84DB3;
 Tue, 21 Jan 2020 12:47:46 +0000 (UTC)
Date: Tue, 21 Jan 2020 13:47:44 +0100
From: Andrew Jones <drjones@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH kvm-unit-tests 0/3] arm/arm64: selftest for pabt
Message-ID: <20200121124744.avp3g2p24q6p44di@kamzik.brq.redhat.com>
References: <20200113130043.30851-1-drjones@redhat.com>
 <bbd1f024-2f6c-d963-57f9-e6d7f2939fda@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbd1f024-2f6c-d963-57f9-e6d7f2939fda@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On Tue, Jan 21, 2020 at 01:24:31PM +0100, Paolo Bonzini wrote:
> On 13/01/20 14:00, Andrew Jones wrote:
> > Patch 3/3 is a rework of Alexandru's pabt test on top of a couple of
> > framework changes allowing it to be more simply and robustly implemented.
> > 
> > Andrew Jones (3):
> >   arm/arm64: Improve memory region management
> >   arm/arm64: selftest: Allow test_exception clobber list to be extended
> >   arm/arm64: selftest: Add prefetch abort test
> > 
> >  arm/selftest.c      | 199 ++++++++++++++++++++++++++++++++------------
> >  lib/arm/asm/setup.h |   8 +-
> >  lib/arm/mmu.c       |  24 ++----
> >  lib/arm/setup.c     |  56 +++++++++----
> >  lib/arm64/asm/esr.h |   3 +
> >  5 files changed, 203 insertions(+), 87 deletions(-)
> > 
> 
> Looks good, are you going to send a pull request for this?
>

Sure. I'll send in a few minutes.

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
