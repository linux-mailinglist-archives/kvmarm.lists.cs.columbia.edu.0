Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74FCD26FA7B
	for <lists+kvmarm@lfdr.de>; Fri, 18 Sep 2020 12:21:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0A3254B45D;
	Fri, 18 Sep 2020 06:21:00 -0400 (EDT)
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
	with ESMTP id 0KA2NhWLjsjP; Fri, 18 Sep 2020 06:20:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C6C514B45C;
	Fri, 18 Sep 2020 06:20:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 91C774B454
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 06:20:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8zYrIFdgbkZb for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Sep 2020 06:20:56 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 89E084B44B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Sep 2020 06:20:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600424456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G47WwuXI/TrhIgIwLuIafRSSYe/pyUtsE+s3uMWOniM=;
 b=Z7qMHO6qyWKuvLyJv1qiH10B8ibg46E62qiWkZLYCLAHpqmVVDP3xgUT8wgJaH/mA66a5v
 ORmTPmmrOqY18zLvYN96MLzy2s0Ss2IhTpizq27cfXvTx9iv2EkzHIBTp/Fmm4HfgF2K0U
 Rm7PZu/etq8RVreKAYs4TZaFdh6LDU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-nZd7yA3zMEufoOu4K4kKHg-1; Fri, 18 Sep 2020 06:20:54 -0400
X-MC-Unique: nZd7yA3zMEufoOu4K4kKHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D350E1017DE2;
 Fri, 18 Sep 2020 10:20:52 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E3D778813;
 Fri, 18 Sep 2020 10:20:49 +0000 (UTC)
Date: Fri, 18 Sep 2020 12:20:46 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [RFC v2 0/7] kvm: arm64: emulate ID registers
Message-ID: <20200918102046.lpn2whexpfngpmur@kamzik.brq.redhat.com>
References: <20200917120101.3438389-1-liangpeng10@huawei.com>
 <20200918080106.5c6jqarj3mhwi3mv@kamzik.brq.redhat.com>
 <9847289d-c575-3ef6-4d6e-460227e8cc21@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9847289d-c575-3ef6-4d6e-460227e8cc21@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, maz@kernel.org,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Fri, Sep 18, 2020 at 05:51:27PM +0800, Peng Liang wrote:
> On 9/18/2020 4:01 PM, Andrew Jones wrote:
> > On Thu, Sep 17, 2020 at 08:00:54PM +0800, Peng Liang wrote:
> >> In AArch64, guest will read the same values of the ID regsiters with
> >> host.  Both of them read the values from arm64_ftr_regs.  This patch
> >> series add support to emulate and configure ID registers so that we can
> >> control the value of ID registers that guest read.
> >>
> >> v1 -> v2:
> >>  - save the ID registers in sysreg file instead of a new struct
> >>  - apply a checker before setting the value to the register
> >>  - add doc for new KVM_CAP_ARM_CPU_FEATURE
> >>
> >> Peng Liang (7):
> >>   arm64: add a helper function to traverse arm64_ftr_regs
> >>   arm64: introduce check_features
> >>   kvm: arm64: save ID registers to sys_regs file
> >>   kvm: arm64: introduce check_user
> >>   kvm: arm64: implement check_user for ID registers
> >>   kvm: arm64: make ID registers configurable
> >>   kvm: arm64: add KVM_CAP_ARM_CPU_FEATURE extension
> >>
> >>  Documentation/virt/kvm/api.rst      |   8 +
> >>  arch/arm64/include/asm/cpufeature.h |   4 +
> >>  arch/arm64/include/asm/kvm_coproc.h |   2 +
> >>  arch/arm64/include/asm/kvm_host.h   |   3 +
> >>  arch/arm64/kernel/cpufeature.c      |  36 +++
> >>  arch/arm64/kvm/arm.c                |   3 +
> >>  arch/arm64/kvm/sys_regs.c           | 481 +++++++++++++++++++++++++++-
> >>  arch/arm64/kvm/sys_regs.h           |   6 +
> >>  include/uapi/linux/kvm.h            |   1 +
> >>  9 files changed, 532 insertions(+), 12 deletions(-)
> >>
> >> -- 
> >> 2.26.2
> >>
> > 
> > Hi Peng,
> > 
> > I'd much rather see a series of patches where each patch converts a single
> > ID register from using ID_SANITISED() to having its own table entry, where
> > its own set_user() and reset() functions take into account its features
> > using high level arm64_ftr* functions. Any ID registers that can still
> > share code can certainly do so with some post-conversion refactoring.
> > 
> > Thanks,
> > drew
> > 
> > .
> > 
> Hi Andrew,
> 
> Thank you for your advise.  I'll rework the code to use different set_user()
> for different ID registers (maybe some general registers still use shareing
> set_user()) and check the value defined by user space in its own set_user in
> next version.
> 
> But do we need to implement reset() for ID registers?  I think ID registers
> are read-only in guest and guest won't and can't change their values.  And
> after 03fdfb2690099 ("KVM: arm64: Don't write junk to sysregs on reset"),
> we won't write junk to sysregs on reset.  So their values won't change on
> reset?

If a new reset isn't needed, then that's fine. I just want each ID
register to have its requirements considered independently, rather
than trying to apply the same functions to all of them without any
apparent consideration.

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
