Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A0181C7B
	for <lists+kvmarm@lfdr.de>; Wed, 11 Mar 2020 16:39:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DAD384A597;
	Wed, 11 Mar 2020 11:38:59 -0400 (EDT)
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
	with ESMTP id 67Z4or8wA4kq; Wed, 11 Mar 2020 11:38:59 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BAFB34A542;
	Wed, 11 Mar 2020 11:38:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A18E4A528
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 11:38:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C+KShXvAav9D for <kvmarm@lists.cs.columbia.edu>;
 Wed, 11 Mar 2020 11:38:56 -0400 (EDT)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BDC0A4A3BF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 11 Mar 2020 11:38:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583941136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W5t/PCQFrEfrTtXP6H3fAc6etVr5BGU7Jh+WijcxdM8=;
 b=R/kMVGAgED5gqcCRr0PNzD+DSUmTVEFvm6wg0l638hwVEl0x0RP+TF53IDBTMNAPCDJP2H
 TONHmzaXNDUzCl1JfLbMMbGCd+zWbryFNaJ3Px47oY12HdbkBY0yr+IOYYZoq6wfuJdy/b
 iNMjLF5JlGp8QnVm0vBgoE+Sbp235wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-ukR6C7iqPe-lkwOjA2QKpw-1; Wed, 11 Mar 2020 11:38:54 -0400
X-MC-Unique: ukR6C7iqPe-lkwOjA2QKpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A8A189F764;
 Wed, 11 Mar 2020 15:38:52 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-206-80.brq.redhat.com
 [10.40.206.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CF0F5C13D;
 Wed, 11 Mar 2020 15:38:45 +0000 (UTC)
Date: Wed, 11 Mar 2020 16:38:42 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v6 07/13] arm/arm64: ITS:
 its_enable_defaults
Message-ID: <20200311153842.knuyqfnzqopb35gj@kamzik.brq.redhat.com>
References: <20200311135117.9366-1-eric.auger@redhat.com>
 <20200311135117.9366-8-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311135117.9366-8-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Wed, Mar 11, 2020 at 02:51:11PM +0100, Eric Auger wrote:
> +/* must be called after gicv3_enable_defaults */
> +void its_enable_defaults(void)
> +{
> +	int i;
> +
> +	/* Allocate LPI config and pending tables */
> +	gicv3_lpi_alloc_tables();
> +
> +	for (i = 0; i < nr_cpus; i++)
> +		gicv3_lpi_rdist_enable(i);

You still haven't explained what's wrong with for_each_present_cpu. Also,
I see you've added 'i < nr_cpus' loops in arm/gic.c too. I'd prefer we not
assume that all cpu's are present (even though, currently, they must be),
because we may want to integrate cpu hotplug tests with these tests at
some point.

> +
> +	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
> +}
> -- 
> 2.20.1
> 
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
