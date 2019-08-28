Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A735A0549
	for <lists+kvmarm@lfdr.de>; Wed, 28 Aug 2019 16:48:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1B7C4A563;
	Wed, 28 Aug 2019 10:48:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Famsxt11XO3n; Wed, 28 Aug 2019 10:48:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 638314A52F;
	Wed, 28 Aug 2019 10:48:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C737D4A52F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 10:48:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LKt-iLP-+DFj for <kvmarm@lists.cs.columbia.edu>;
 Wed, 28 Aug 2019 10:48:02 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id DDFFF4A4DF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 28 Aug 2019 10:48:02 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E21C2A973;
 Wed, 28 Aug 2019 14:48:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74DFA6060D;
 Wed, 28 Aug 2019 14:48:00 +0000 (UTC)
Date: Wed, 28 Aug 2019 16:47:57 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [kvm-unit-tests RFC PATCH 03/16] lib: arm/arm64: Add missing
 include for alloc_page.h in pgtable.h
Message-ID: <20190828144757.q7utxtnzehmv2duk@kamzik.brq.redhat.com>
References: <1566999511-24916-1-git-send-email-alexandru.elisei@arm.com>
 <1566999511-24916-4-git-send-email-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1566999511-24916-4-git-send-email-alexandru.elisei@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 28 Aug 2019 14:48:02 +0000 (UTC)
Cc: kvm@vger.kernel.org, maz@kernel.org, andre.przywara@arm.com,
 pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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

On Wed, Aug 28, 2019 at 02:38:18PM +0100, Alexandru Elisei wrote:
> pgtable.h is used only by mmu.c, where it is included after alloc_page.h.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  lib/arm/asm/pgtable.h   | 1 +
>  lib/arm64/asm/pgtable.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/lib/arm/asm/pgtable.h b/lib/arm/asm/pgtable.h
> index 241dff69b38a..b01c34348321 100644
> --- a/lib/arm/asm/pgtable.h
> +++ b/lib/arm/asm/pgtable.h
> @@ -13,6 +13,7 @@
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2.
>   */
> +#include <alloc_page.h>
>  
>  /*
>   * We can convert va <=> pa page table addresses with simple casts
> diff --git a/lib/arm64/asm/pgtable.h b/lib/arm64/asm/pgtable.h
> index ee0a2c88cc18..e9dd49155564 100644
> --- a/lib/arm64/asm/pgtable.h
> +++ b/lib/arm64/asm/pgtable.h
> @@ -14,6 +14,7 @@
>   * This work is licensed under the terms of the GNU GPL, version 2.
>   */
>  #include <alloc.h>
> +#include <alloc_page.h>
>  #include <asm/setup.h>
>  #include <asm/page.h>
>  #include <asm/pgtable-hwdef.h>
> -- 
> 2.7.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
