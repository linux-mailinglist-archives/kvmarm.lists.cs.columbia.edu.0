Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E6DBC243B68
	for <lists+kvmarm@lfdr.de>; Thu, 13 Aug 2020 16:19:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52B0B4BA17;
	Thu, 13 Aug 2020 10:19:29 -0400 (EDT)
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
	with ESMTP id Qr6fsB2rh5ud; Thu, 13 Aug 2020 10:19:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AA7E4BA0B;
	Thu, 13 Aug 2020 10:19:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 08A574B9D7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Aug 2020 10:19:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A5c0Rkp547m3 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 13 Aug 2020 10:19:25 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 185794B83E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 13 Aug 2020 10:19:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597328364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVVaCgXcjbFi+DRQRD3jHW6JoaEa6ENlRJBReAb9qcI=;
 b=edHfv983AdseDwu7TyExSXE+19hKza+21EnWB0cIPgl4A8KvYA9PXhvLf7gCdxGe2lwHtJ
 yXbzBR1czKQptq47W55V63PVoa4Qz84zV1jwDmbIInDavN7MRqUVMK3ftqDGH+czv2UWst
 3pkikGfr0Tx1Gg8S1Ans6t9dZBdORFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-gEz4EjWENFClGnnKKDc-Pw-1; Thu, 13 Aug 2020 10:19:21 -0400
X-MC-Unique: gEz4EjWENFClGnnKKDc-Pw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E922B1005504;
 Thu, 13 Aug 2020 14:19:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2621D1014160;
 Thu, 13 Aug 2020 14:19:17 +0000 (UTC)
Date: Thu, 13 Aug 2020 16:19:15 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [RFC 0/4] kvm: arm64: emulate ID registers
Message-ID: <20200813141915.wagalfqn67azowu5@kamzik.brq.redhat.com>
References: <20200813060517.2360048-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813060517.2360048-1-liangpeng10@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: maz@kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, zhang.zhanghailiang@huawei.com
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

On Thu, Aug 13, 2020 at 02:05:13PM +0800, Peng Liang wrote:
> In AArch64, guest will read the same values of the ID regsiters with
> host.  Both of them read the values from arm64_ftr_regs.  This patch
> series add support to emulate and configure ID registers so that we can
> control the value of ID registers that guest read.
> 
> Peng Liang (4):
>   arm64: add a helper function to traverse arm64_ftr_regs
>   kvm: arm64: emulate the ID registers
>   kvm: arm64: make ID registers configurable
>   kvm: arm64: add KVM_CAP_ARM_CPU_FEATURE extension
> 
>  arch/arm64/include/asm/cpufeature.h |  2 ++
>  arch/arm64/include/asm/kvm_host.h   |  2 ++
>  arch/arm64/kernel/cpufeature.c      | 13 ++++++++
>  arch/arm64/kvm/arm.c                | 21 ++++++++++++
>  arch/arm64/kvm/sys_regs.c           | 50 ++++++++++++++++++++++-------
>  include/uapi/linux/kvm.h            | 12 +++++++
>  6 files changed, 89 insertions(+), 11 deletions(-)
> 
> -- 
> 2.18.4
> 

Hi Peng,

After having looked at the QEMU series I don't believe this is the right
approach to CPU models. As stated in my reply [*] this approach appears
to just be shifting the problem wholesale to the user. On the KVM side,
I think we should start by auditing all the ID registers to see what
should be masked and what should be under user control. Then, we need
to consider what MIDR a guest that can migrate between hosts of different
MIDRs should have. And that'll require addressing the errata problem in
one way or another.

[*] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02587.html

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
