Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAA2377059
	for <lists+kvmarm@lfdr.de>; Sat,  8 May 2021 09:22:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B81C4B81E;
	Sat,  8 May 2021 03:22:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxPZdftUCNDW; Sat,  8 May 2021 03:22:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 422164B7EE;
	Sat,  8 May 2021 03:22:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B02B34B76C
 for <kvmarm@lists.cs.columbia.edu>; Sat,  8 May 2021 03:22:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZQxCpD+c6YA for <kvmarm@lists.cs.columbia.edu>;
 Sat,  8 May 2021 03:22:36 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 71A9C4B3FD
 for <kvmarm@lists.cs.columbia.edu>; Sat,  8 May 2021 03:22:36 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 583F36145E;
 Sat,  8 May 2021 07:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1620458555;
 bh=75QzCGmWcilMFGqhtLbNi4lbm90RLc6Y8MR3bsjz8IA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NzNgqZ1PGsNQWOtBMSrc7TB2OFZjXh0Ezp1/zJVKj9u+3OmDAA/w+jSbIVRyp8sd5
 1iyX9tOY7ZjW/jlvEhfQKvgcMWTEjouzxmq/liD4gbqjTrGog1gREUhIKwUGEVPii1
 z+sbXfG6rY+Q4wY+5fnzC19xZK+ZGQSqv/9yYGsM=
Date: Sat, 8 May 2021 09:22:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH] Revert "irqbypass: do not start cons/prod when failed
 connect"
Message-ID: <YJY8OOGMNEp97ej9@kroah.com>
References: <20210508071152.722425-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210508071152.722425-1-lingshan.zhu@intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, maz@kernel.org, jasowang@redhat.com,
 cohuck@redhat.com, stable@vger.kernel.org, alex.williamson@redhat.com,
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

On Sat, May 08, 2021 at 03:11:52PM +0800, Zhu Lingshan wrote:
> This reverts commit a979a6aa009f3c99689432e0cdb5402a4463fb88.
> 
> The reverted commit may cause VM freeze on arm64 platform.
> Because on arm64 platform, stop a consumer will suspend the VM,
> the VM will freeze without a start consumer
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  virt/lib/irqbypass.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
