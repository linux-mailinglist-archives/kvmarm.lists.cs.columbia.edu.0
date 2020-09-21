Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A818E2726CB
	for <lists+kvmarm@lfdr.de>; Mon, 21 Sep 2020 16:17:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 483E14B58F;
	Mon, 21 Sep 2020 10:17:25 -0400 (EDT)
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
	with ESMTP id Rv3-VNvZQYqi; Mon, 21 Sep 2020 10:17:25 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3EAF54B5A9;
	Mon, 21 Sep 2020 10:17:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D0EE34B58F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 10:17:23 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3UpWEUej1rEh for <kvmarm@lists.cs.columbia.edu>;
 Mon, 21 Sep 2020 10:17:22 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DFD754B3B6
 for <kvmarm@lists.cs.columbia.edu>; Mon, 21 Sep 2020 10:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600697842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8Nn1pNNlmTaOdYpoWqgli92tHwU9FGvXXWgptLSEE0=;
 b=YJIpP6+MeOEuEFUgWB7M2XdOYxe+h8PUOLz03W1rERY49AIR0QDQlLL5cqwiP90NfLJ5fm
 R34Xiu2HICxjU2ZlF7n124lnihfLvF/CP+5KbuHzVWLvbdd9UuUMh16euZ9z1IaunUwl3h
 lcsA/Wm69CTA+ISm2fvr9uWfXXRlEDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-F8jshtu0MjKnm-_PvdCv9A-1; Mon, 21 Sep 2020 10:17:18 -0400
X-MC-Unique: F8jshtu0MjKnm-_PvdCv9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9162E57039;
 Mon, 21 Sep 2020 14:17:17 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BED160BF4;
 Mon, 21 Sep 2020 14:17:16 +0000 (UTC)
Date: Mon, 21 Sep 2020 16:17:13 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Match PMU error code descriptions with
 error conditions
Message-ID: <20200921141713.dr6l6po2luqyodjx@kamzik.brq.redhat.com>
References: <20200921130838.37296-1-alexandru.elisei@arm.com>
 <20200921130838.37296-3-alexandru.elisei@arm.com>
MIME-Version: 1.0
In-Reply-To: <20200921130838.37296-3-alexandru.elisei@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: maz@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On Mon, Sep 21, 2020 at 02:08:38PM +0100, Alexandru Elisei wrote:
> Update the description of the PMU KVM_{GET, SET}_DEVICE_ATTR error codes
> to be a better match for the code that returns them.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  Documentation/virt/kvm/devices/vcpu.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
> index 96d6cf77cb1e..5b8db30c61db 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
> @@ -26,8 +26,8 @@ Returns:
>  	 =======  ========================================================
>  	 -EBUSY   The PMU overflow interrupt is already set
>  	 -EFAULT  Error reading interrupt number
> -	 -ENXIO   The overflow interrupt not set when attempting to get it
> -	 -ENODEV  PMUv3 not supported
> +	 -ENXIO   PMUv3 not supported

I think -ENXIO matched the code better before the change.

> +	 -ENODEV  KVM_ARM_VCPU_PMU_V3 feature missing from VCPU
>  	 -EINVAL  Invalid PMU overflow interrupt number supplied or
>  		  trying to set the IRQ number without using an in-kernel
>  		  irqchip.
> @@ -48,8 +48,8 @@ Returns:
>  	 =======  ======================================================
>  	 -EEXIST  Interrupt number already used
>  	 -ENODEV  PMUv3 not supported or GIC not initialized
> -	 -ENXIO   PMUv3 not properly configured or in-kernel irqchip not
> -		  configured as required prior to calling this attribute
> +	 -ENXIO   PMUv3 not supported, missing VCPU feature or interrupt
> +                  number not set
>  	 -EBUSY   PMUv3 already initialized
>  	 =======  ======================================================
>

Thanks,
drew  

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
