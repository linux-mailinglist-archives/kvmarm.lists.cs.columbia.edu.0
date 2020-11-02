Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C19512A263B
	for <lists+kvmarm@lfdr.de>; Mon,  2 Nov 2020 09:38:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C04C4B5FE;
	Mon,  2 Nov 2020 03:38:50 -0500 (EST)
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
	with ESMTP id xFXFmvfQgwPy; Mon,  2 Nov 2020 03:38:50 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 474764B5F3;
	Mon,  2 Nov 2020 03:38:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E2A994B5E1
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 03:38:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P4RJl49bL7aG for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Nov 2020 03:38:47 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 018114B5DE
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Nov 2020 03:38:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604306326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKprBlRGMj1c6o4rrrCoX/rFjaOYaPOS8vcmwCUOrZI=;
 b=N5YUJBbnZ5hlZDtM4FC4wdhUXsgBAi+fpA73fzINA7pDkM2owsu4eiiEbNIP3Y6QHVQx5C
 gBBqCeBvC5gL6dOjVT541EXh7jAuTy6eUgDzUm1+IB1yqPAWk41XIAGztgzEmtplE46vrU
 4qDJ61Y7SZpWbYSeYYhk7N2LOvyTBhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-p-ZdT5QJPvGRJvwdzpI1sg-1; Mon, 02 Nov 2020 03:38:43 -0500
X-MC-Unique: p-ZdT5QJPvGRJvwdzpI1sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB8B66414D;
 Mon,  2 Nov 2020 08:38:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8D1E1002C13;
 Mon,  2 Nov 2020 08:38:36 +0000 (UTC)
Date: Mon, 2 Nov 2020 09:38:33 +0100
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 3/4] KVM: selftests: Update aarch64 get-reg-list blessed
 list
Message-ID: <20201102083833.zjqrlmyvwfir2du4@kamzik.brq.redhat.com>
References: <20201029201703.102716-1-drjones@redhat.com>
 <20201029201703.102716-4-drjones@redhat.com>
 <875z6qdy63.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875z6qdy63.wl-maz@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, Dave.Martin@arm.com, pbonzini@redhat.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Sat, Oct 31, 2020 at 06:53:56PM +0000, Marc Zyngier wrote:
> On Thu, 29 Oct 2020 20:17:02 +0000,
> Andrew Jones <drjones@redhat.com> wrote:
> > 
> > The new registers come from the following commits:
> > 
> > commit 99adb567632b ("KVM: arm/arm64: Add save/restore support for
> > firmware workaround state")
> > 
> > commit c773ae2b3476 ("KVM: arm64: Save/Restore guest DISR_EL1")
> > 
> > commit 03fdfb269009 ("KVM: arm64: Don't write junk to sysregs on reset")
> > 
> > The last commit, which adds ARM64_SYS_REG(3, 3, 9, 12, 0) (PMCR_EL0),
> > and was committed for v5.3, doesn't indicate in its commit message that
> > enumerating it for save/restore was the plan, so doing so may have
> > been by accident.
> 
> It definitely was.
> 
> > It's a good idea anyway, though, since the other PMU registers have
> > been enumerated since v4.10.
> 
> Quite. The state of the PMU is pretty much unknown on restore until then.
> 
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  tools/testing/selftests/kvm/aarch64/get-reg-list.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > index 3aeb3de780a1..3ff097f6886e 100644
> > --- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > +++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> > @@ -352,7 +352,8 @@ int main(int ac, char **av)
> >  }
> >  
> >  /*
> > - * The current blessed list comes from kernel version v4.15 with --core-reg-fixup
> > + * The current blessed list was primed with the output of kernel version
> > + * v4.15 with --core-reg-fixup and then later updated with new registers.
> 
> Maybe have a reference to the last kernel version this was checked
> against? Either here or in the commit message?

Good idea. I'll put it in the comment in list form, encouraging the list
to be continued as we add more.

Thanks,
drew

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
