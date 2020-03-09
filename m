Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B6C3A17DEE0
	for <lists+kvmarm@lfdr.de>; Mon,  9 Mar 2020 12:44:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4E2AD4A4E5;
	Mon,  9 Mar 2020 07:44:14 -0400 (EDT)
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
	with ESMTP id PnhbQM1Y6q3r; Mon,  9 Mar 2020 07:44:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F10D4A4CD;
	Mon,  9 Mar 2020 07:44:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9EE9E40456
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Mar 2020 07:44:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0T4akNurnLN for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 Mar 2020 07:44:11 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C795040217
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 Mar 2020 07:44:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583754251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78I5LVGNS/WghemDDn/hYLUYD1AftfK/zET4ULXdDjQ=;
 b=CXL+7CfTKfQhdcu9RbMCDrOGjnOSbNvqRysfmHIGcY1i1wa4SqbP27R+qD2QMrxj38e4yV
 HpWPvhmi218R/qobEtpzSKZKbrSqaBkOujV5twDA+xmza+BQ+vwssMFsSPpazJao88WuE9
 +xfIwTAc7yNdRfY3bu4OBDYNLeTF4aM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-145ePac0Mx-b9s86tx_zLg-1; Mon, 09 Mar 2020 07:44:07 -0400
X-MC-Unique: 145ePac0Mx-b9s86tx_zLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D5AF107B116;
 Mon,  9 Mar 2020 11:44:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BE2960C05;
 Mon,  9 Mar 2020 11:44:00 +0000 (UTC)
Date: Mon, 9 Mar 2020 12:43:58 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 10/13] arm/arm64: ITS: INT functional
 tests
Message-ID: <20200309114358.aaf5dyglehby4pup@kamzik.brq.redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
 <20200309102420.24498-11-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200309102420.24498-11-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: thuth@redhat.com, kvm@vger.kernel.org, maz@kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, andre.przywara@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Mon, Mar 09, 2020 at 11:24:17AM +0100, Eric Auger wrote:
...
> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
> index 0096de6..956d7b8 100644
> --- a/lib/arm/asm/gic-v3-its.h
> +++ b/lib/arm/asm/gic-v3-its.h
> @@ -5,9 +5,8 @@
>   *
>   * This work is licensed under the terms of the GNU LGPL, version 2.
>   */
> -
> -#ifndef _ASMARM_GICv3_ITS
> -#define _ASMARM_GICv3_ITS
> +#ifndef _ASMARM_GIC_V3_ITS_H_
> +#define _ASMARM_GIC_V3_ITS_H_

Another fix to squash into the patch where the lines are introduced.

>  
>  /* dummy its_data struct to allow gic_get_dt_bases() call */
>  struct its_data {
> @@ -19,5 +18,9 @@ static inline void test_its_introspection(void)
>  {
>  	report_abort("not supported on 32-bit");
>  }
> +static inline void test_its_trigger(void)
> +{
> +	report_abort("not supported on 32-bit");

As mentioned before, we don't want test_* and report_* functions in the
library code.

> +}
>  
>  #endif /* _ASMARM_GICv3_ITS */

Forgot to change _ASMARM_GICv3_ITS here.

> -- 
> 2.20.1
>

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
