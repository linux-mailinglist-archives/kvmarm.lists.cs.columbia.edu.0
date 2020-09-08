Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C4FF2260F79
	for <lists+kvmarm@lfdr.de>; Tue,  8 Sep 2020 12:16:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 643284B57B;
	Tue,  8 Sep 2020 06:16:04 -0400 (EDT)
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
	with ESMTP id 6nCy-FPrgjFg; Tue,  8 Sep 2020 06:16:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 52A954B3CE;
	Tue,  8 Sep 2020 06:16:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1BCBE4B2CD
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 06:16:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agX72jjpb9+3 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Sep 2020 06:16:01 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 382D24B2C7
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 06:16:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599560161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mv11ZJIjPR3ewQkRWE9R7NV/KCoGwIh6nFYREmaN9/I=;
 b=FXUe6XjO3KDamf0sUj+1cCERtSINFf9Nln7vsEMIKEwkeuRhKBK7MJLokoLkblffNsRe6I
 vvSJQuEdUhyJqciYqq/5N6iXlqg49lzhmvdDx/7x+bMPPCKzWDEH1n8lbAHK+yzW133Vx/
 cifdQ6566LTin3KJX0KqhXmlQoVHhs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-rCxIOhvXMwWqo_LAgRoOTQ-1; Tue, 08 Sep 2020 06:15:57 -0400
X-MC-Unique: rCxIOhvXMwWqo_LAgRoOTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EE24802B60;
 Tue,  8 Sep 2020 10:15:55 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF7675D9E2;
 Tue,  8 Sep 2020 10:15:53 +0000 (UTC)
Date: Tue, 8 Sep 2020 12:15:50 +0200
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 3/5] KVM: arm64: Add PMU event filtering infrastructure
Message-ID: <20200908101550.mve4ibscf2rvam6t@kamzik.brq.redhat.com>
References: <20200908075830.1161921-1-maz@kernel.org>
 <20200908075830.1161921-4-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908075830.1161921-4-maz@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, kernel-team@android.com, graf@amazon.com,
 Robin Murphy <robin.murphy@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Sep 08, 2020 at 08:58:28AM +0100, Marc Zyngier wrote:
> It can be desirable to expose a PMU to a guest, and yet not want the
> guest to be able to count some of the implemented events (because this
> would give information on shared resources, for example.
> 
> For this, let's extend the PMUv3 device API, and offer a way to setup a
> bitmap of the allowed events (the default being no bitmap, and thus no
> filtering).
> 
> Userspace can thus allow/deny ranges of event. The default policy
> depends on the "polarity" of the first filter setup (default deny if the
> filter allows events, and default allow if the filter denies events).
> This allows to setup exactly what is allowed for a given guest.
> 
> Note that although the ioctl is per-vcpu, the map of allowed events is
> global to the VM (it can be setup from any vcpu until the vcpu PMU is
> initialized).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h |  5 +++
>  arch/arm64/include/uapi/asm/kvm.h | 16 +++++++
>  arch/arm64/kvm/arm.c              |  2 +
>  arch/arm64/kvm/pmu-emul.c         | 70 ++++++++++++++++++++++++++++---
>  4 files changed, 87 insertions(+), 6 deletions(-)
> 

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
