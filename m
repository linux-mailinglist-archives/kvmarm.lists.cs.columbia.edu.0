Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F28881DDF6A
	for <lists+kvmarm@lfdr.de>; Fri, 22 May 2020 07:34:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 60AE34B2BA;
	Fri, 22 May 2020 01:34:42 -0400 (EDT)
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
	with ESMTP id oi5uZN011XLr; Fri, 22 May 2020 01:34:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A9094B315;
	Fri, 22 May 2020 01:34:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BAC334B185
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 May 2020 01:34:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5oHjPfB5tfC for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 May 2020 01:34:38 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A5BB44B0A0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 May 2020 01:34:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590125678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnQ0nMFf0h8WwglXkeiu5R/EKl0trwSByG4G+2rCYaE=;
 b=dPPRdln3FqEm+T6OxykFW8fr83H33F2+oeLfK782L+4mwKWnszXKx22d8jood+Ylml+56X
 5cF+gnpydMOs3DRMwW5kUk3lN/GTm1Rm/gWcDp+mM4ekCX8VCzl+QJNqg9F26w4hhUHmHB
 W4SOwL5xJT2GzxAwgEUWGqzZT31jCGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-V2GasK5KMByUJGyOtwaR9g-1; Fri, 22 May 2020 01:34:36 -0400
X-MC-Unique: V2GasK5KMByUJGyOtwaR9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06A131005510;
 Fri, 22 May 2020 05:34:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58C605D9CD;
 Fri, 22 May 2020 05:34:27 +0000 (UTC)
Date: Fri, 22 May 2020 07:34:23 +0200
From: Andrew Jones <drjones@redhat.com>
To: Jingyi Wang <wangjingyi11@huawei.com>
Subject: Re: [kvm-unit-tests PATCH 1/6] arm64: microbench: get correct ipi
 recieved num
Message-ID: <20200522053423.cus3pnhmp4p4t3ck@kamzik.brq.redhat.com>
References: <20200517100900.30792-1-wangjingyi11@huawei.com>
 <20200517100900.30792-2-wangjingyi11@huawei.com>
 <8e011659-4e4d-7312-4466-5ed3ea54cc9b@huawei.com>
 <8b9d51f2-3906-9e0a-38ae-564424c38ff5@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b9d51f2-3906-9e0a-38ae-564424c38ff5@huawei.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Fri, May 22, 2020 at 10:32:25AM +0800, Jingyi Wang wrote:
> =

> On 5/21/2020 10:00 PM, Zenghui Yu wrote:
> > On 2020/5/17 18:08, Jingyi Wang wrote:
> > > If ipi_exec() fails because of timeout, we shouldn't increase
> > > the number of ipi received.
> > > =

> > > Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
> > > ---
> > > =A0 arm/micro-bench.c | 4 +++-
> > > =A0 1 file changed, 3 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/arm/micro-bench.c b/arm/micro-bench.c
> > > index 4612f41..ca022d9 100644
> > > --- a/arm/micro-bench.c
> > > +++ b/arm/micro-bench.c
> > > @@ -103,7 +103,9 @@ static void ipi_exec(void)
> > > =A0=A0=A0=A0=A0 while (!ipi_received && tries--)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 cpu_relax();
> > > -=A0=A0=A0 ++received;
> > > +=A0=A0=A0 if (ipi_recieved)
> > =

> > I think you may want *ipi_received* ;-) Otherwise it can not even
> > compile!
> > =

> > > +=A0=A0=A0=A0=A0=A0=A0 ++received;
> > > +
> > > =A0=A0=A0=A0=A0 assert_msg(ipi_received, "failed to receive IPI in ti=
me, but
> > > received %d successfully\n", received);
> > > =A0 }
> > =

> > With this fixed, this looks good to me,
> > =

> > Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> > =

> > =

> > Thanks.
> > =

> > .
> This variable name is modified in the next patch, so I ignored that
> mistake, thanks.
>

kvm-unit-tests build and run fast enough that you can do something like

  git rebase -i -x 'make clean && make && arm/run arm/micro-bench'

to test your series before posting.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
