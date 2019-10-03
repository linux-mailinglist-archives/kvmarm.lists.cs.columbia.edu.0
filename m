Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1FC9F56
	for <lists+kvmarm@lfdr.de>; Thu,  3 Oct 2019 15:23:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A35C94A78E;
	Thu,  3 Oct 2019 09:23:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZyPU4DzVvwFT; Thu,  3 Oct 2019 09:23:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D7934A786;
	Thu,  3 Oct 2019 09:23:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AFDBD4A782
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Oct 2019 09:23:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cnn4m-SVaKnQ for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Oct 2019 09:23:26 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C45524A752
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Oct 2019 09:23:26 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 238833C919;
 Thu,  3 Oct 2019 13:23:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 093B510013A7;
 Thu,  3 Oct 2019 13:23:23 +0000 (UTC)
Date: Thu, 3 Oct 2019 15:23:21 +0200
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v5 06/10] KVM: Allow kvm_device_ops to be const
Message-ID: <20191003132321.jd7wtkbcdmyx7gnv@kamzik.brq.redhat.com>
References: <20191002145037.51630-1-steven.price@arm.com>
 <20191002145037.51630-7-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191002145037.51630-7-steven.price@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 03 Oct 2019 13:23:26 +0000 (UTC)
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Wed, Oct 02, 2019 at 03:50:33PM +0100, Steven Price wrote:
> Currently a kvm_device_ops structure cannot be const without triggering
> compiler warnings. However the structure doesn't need to be written to
> and, by marking it const, it can be read-only in memory. Add some more
> const keywords to allow this.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/linux/kvm_host.h | 4 ++--
>  virt/kvm/kvm_main.c      | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
