Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DD12B701CB
	for <lists+kvmarm@lfdr.de>; Mon, 22 Jul 2019 15:57:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5309F4A536;
	Mon, 22 Jul 2019 09:57:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XDS2YmB0Nu4; Mon, 22 Jul 2019 09:57:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 78FF64A534;
	Mon, 22 Jul 2019 09:57:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 185584A524
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jul 2019 09:57:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqtql-CeG5G1 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 22 Jul 2019 09:56:59 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 55BCA4A4F5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 22 Jul 2019 09:56:59 -0400 (EDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62B0C217F9;
 Mon, 22 Jul 2019 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563803818;
 bh=bQfkIbf6XvrrfgVB6dqgFGaZ+h0Cn+0vIdllQGKDcAI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F8tS7392/+6aK0cYmP+vQ9RmGPXef4dDqMkLjhO6alko1nydst/YuXyfD6a/gygLH
 i850A3sQfeK3UW+PqYy2iv50KnWxO5O1G2Hm9nVU5ixBjqyn4iOZ0Mvu6xhwOTWBoL
 aTNPSsJodTo2Otm/KNbTLdjSX6p7UQcWjNJoQyNY=
Date: Mon, 22 Jul 2019 14:56:53 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address
Message-ID: <20190722135652.se2ba5ithml37dtz@willie-the-truck>
References: <20190722134438.31003-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190722134438.31003-1-jean-philippe@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, mst@redhat.com,
 maz@kernel.org, joro@8bytes.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Mon, Jul 22, 2019 at 02:44:40PM +0100, Jean-Philippe Brucker wrote:
> Update MAINTAINERS and .mailmap with my @linaro.org address, since I
> don't have access to my @arm.com address anymore.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 0fef932de3db..8ce554b9c9f1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -98,6 +98,7 @@ Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
>  Javi Merino <javi.merino@kernel.org> <javi.merino@arm.com>
>  <javier@osg.samsung.com> <javier.martinez@collabora.co.uk>
>  Jean Tourrilhes <jt@hpl.hp.com>
> +<jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
>  Jeff Garzik <jgarzik@pretzel.yyz.us>
>  Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
>  Jeff Layton <jlayton@kernel.org> <jlayton@poochiereds.net>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783569e3c4b4..bded78c84701 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17123,7 +17123,7 @@ F:	drivers/virtio/virtio_input.c
>  F:	include/uapi/linux/virtio_input.h
>  
>  VIRTIO IOMMU DRIVER
> -M:	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> +M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Maintained
>  F:	drivers/iommu/virtio-iommu.c

Thanks (and your new address is easier to remember ;). I can take this one
via arm64, since I already have a bunch of MAINTAINERS updates queued for
-rc2.

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
