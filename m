Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8B21C3B6
	for <lists+kvmarm@lfdr.de>; Sat, 11 Jul 2020 12:20:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8D5A14B0CF;
	Sat, 11 Jul 2020 06:20:35 -0400 (EDT)
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
	with ESMTP id Knh2Nw8Jpdiq; Sat, 11 Jul 2020 06:20:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 80E1F4B150;
	Sat, 11 Jul 2020 06:20:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 13A444B144
 for <kvmarm@lists.cs.columbia.edu>; Sat, 11 Jul 2020 06:20:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ydY+2-ZmspJ for <kvmarm@lists.cs.columbia.edu>;
 Sat, 11 Jul 2020 06:20:32 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 10DA34AEE2
 for <kvmarm@lists.cs.columbia.edu>; Sat, 11 Jul 2020 06:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594462831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BTppUzQT8iaK/vwGBFLxjGeXS/GcirhTicRmFvkn6Y=;
 b=VnsDr1hpIzc+HYfnkjaRFzmtwCgfS5wdb1xLVmsEzLr6VhdQusS8afDB/PSQdaTJ2tSrp0
 tXrZ7Ydi2Otx6mgNeQ2K8SGDBgVO7q66HyOKuX042I9Znd8WIA+uS6yf+E5uJQfr7ik8Zo
 wi5UNnaE+JpiGqIXyyiIAhGH+xS/SHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-25fX6eXdMAea-hm4EM_Zqw-1; Sat, 11 Jul 2020 06:20:28 -0400
X-MC-Unique: 25fX6eXdMAea-hm4EM_Zqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E31C2102C7EC;
 Sat, 11 Jul 2020 10:20:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28862724BB;
 Sat, 11 Jul 2020 10:20:24 +0000 (UTC)
Date: Sat, 11 Jul 2020 12:20:22 +0200
From: Andrew Jones <drjones@redhat.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 0/5] KVM: arm64: pvtime: Fixes and a new cap
Message-ID: <20200711102022.rj2ks75k524gxuzl@kamzik.brq.redhat.com>
References: <20200711100434.46660-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200711100434.46660-1-drjones@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: pbonzini@redhat.com, steven.price@arm.com, maz@kernel.org
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

On Sat, Jul 11, 2020 at 12:04:29PM +0200, Andrew Jones wrote:
> The first three patches in the series are fixes that come from testing
> and reviewing pvtime code while writing the QEMU support (I'll reply
> to this mail with a link to the QEMU patches after posting - which I'll
> do shortly). The last patch is only a convenience for userspace, and I
> wouldn't be heartbroken if it wasn't deemed worth it. The QEMU patches
> I'll be posting are currently written without the cap. However, if the
> cap is accepted, then I'll change the QEMU code to use it.

And the promised link to the QEMU patches

https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg03856.html

Thanks,
drew

> 
> Thanks,
> drew
> 
> Andrew Jones (5):
>   KVM: arm64: pvtime: steal-time is only supported when configured
>   KVM: arm64: pvtime: Fix potential loss of stolen time
>   KVM: arm64: pvtime: Fix stolen time accounting across migration
>   KVM: Documentation minor fixups
>   arm64/x86: KVM: Introduce steal-time cap
> 
>  Documentation/virt/kvm/api.rst    | 20 ++++++++++++++++----
>  arch/arm64/include/asm/kvm_host.h |  2 +-
>  arch/arm64/kvm/arm.c              |  3 +++
>  arch/arm64/kvm/pvtime.c           | 31 +++++++++++++++----------------
>  arch/x86/kvm/x86.c                |  3 +++
>  include/linux/kvm_host.h          | 19 +++++++++++++++++++
>  include/uapi/linux/kvm.h          |  1 +
>  7 files changed, 58 insertions(+), 21 deletions(-)
> 
> -- 
> 2.25.4
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
