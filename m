Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 743DA292490
	for <lists+kvmarm@lfdr.de>; Mon, 19 Oct 2020 11:25:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 823864B57D;
	Mon, 19 Oct 2020 05:25:37 -0400 (EDT)
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
	with ESMTP id txTlnOne3pQA; Mon, 19 Oct 2020 05:25:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C0114B572;
	Mon, 19 Oct 2020 05:25:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 47C9B4B560
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 05:25:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hHUm-Bkdki56 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Oct 2020 05:25:34 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 35CFE4B54B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Oct 2020 05:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603099533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8Vq1Ap8SBigkU/8LGMXA2a9BrKy83dFwogd18gdHco=;
 b=itjxMV7yghLgIRICKcso5SEst/X51s5AlXHYACEswT438Dl8164UK4CpGsoS5Jpy/HTVk6
 2Dik1H8Q06QNmy7WKWo+14c/ZFf1SFW0Fw2GhdC1RA4SzswmnFfn9ezrnd/xXPKUmhnGjo
 2chJyyIKRgLspgqPMA64gvLMqe/RTCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-2BZvLv5HObiGgA1Gim2UDA-1; Mon, 19 Oct 2020 05:25:32 -0400
X-MC-Unique: 2BZvLv5HObiGgA1Gim2UDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F888800462;
 Mon, 19 Oct 2020 09:25:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F4C86EF46;
 Mon, 19 Oct 2020 09:25:28 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:25:25 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Marc Zyngier <maz@kernel.org>, xu910121@sina.com,
 qemu-devel <qemu-devel@nongnu.org>, kvmarm <kvmarm@lists.cs.columbia.edu>,
 "Dave.Martin" <dave.martin@arm.com>
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

On Thu, Oct 15, 2020 at 03:57:02PM +0100, Peter Maydell wrote:
> On Thu, 15 Oct 2020 at 15:41, Andrew Jones <drjones@redhat.com> wrote:
> > The reporter states neither the source nor destination hardware supports
> > SVE. My guess is that what's happening is the reserved ID register
> > ID_UNALLOCATED(4,4) was showing up in the KVM_GET_REG_LIST count on
> > the old kernel, but the new kernel filters it out. Maybe it is a
> > bug to filter it out of the count, as it's a reserved ID register and
> > I suppose the other reserved ID registers are still showing up?
> 
> Yeah, RES0 ID registers should show up in the list, because otherwise
> userspace has to annoyingly special case them when the architecture
> eventually defines behaviour for them.
> 
> Dave's comment in the kernel commit message
> # ID_AA64ZFR0_EL1 is RO-RAZ for MRS/MSR when SVE is disabled for the
> # guest, but for compatibility with non-SVE aware KVM implementations
> # the register should not be enumerated at all for KVM_GET_REG_LIST
> # in this case.
> seems wrong to me -- for compatibility the register should remain
> present and behave as RAZ/WI if SVE is disabled in the guest,
> the same way it was before the kernel/KVM knew about SVE at all.

Yup, I agree with you and I'll try writing a patch for this.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
