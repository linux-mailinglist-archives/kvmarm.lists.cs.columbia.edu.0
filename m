Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D961921D1A4
	for <lists+kvmarm@lfdr.de>; Mon, 13 Jul 2020 10:26:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F30A4B2F6;
	Mon, 13 Jul 2020 04:26:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rPWAsQaQKpGU; Mon, 13 Jul 2020 04:26:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 45F344B2F4;
	Mon, 13 Jul 2020 04:26:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AA8674B2EC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jul 2020 04:26:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id glbaFNg2Zl1c for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Jul 2020 04:26:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 869674B2EB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jul 2020 04:26:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19C2330E;
 Mon, 13 Jul 2020 01:26:01 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 088D83F887;
 Mon, 13 Jul 2020 01:25:59 -0700 (PDT)
Subject: Re: [PATCH 0/5] KVM: arm64: pvtime: Fixes and a new cap
To: Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
References: <20200711100434.46660-1-drjones@redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <81e3cf61-afa6-134b-e532-419d34349b04@arm.com>
Date: Mon, 13 Jul 2020 09:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200711100434.46660-1-drjones@redhat.com>
Content-Language: en-GB
Cc: pbonzini@redhat.com, maz@kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 11/07/2020 11:04, Andrew Jones wrote:
> The first three patches in the series are fixes that come from testing
> and reviewing pvtime code while writing the QEMU support (I'll reply
> to this mail with a link to the QEMU patches after posting - which I'll
> do shortly). The last patch is only a convenience for userspace, and I
> wouldn't be heartbroken if it wasn't deemed worth it. The QEMU patches
> I'll be posting are currently written without the cap. However, if the
> cap is accepted, then I'll change the QEMU code to use it.

Thanks for this, you've already got my r-b on the last two patches. For 
the others:

Reviewed-by: Steven Price <steven.price@arm.com>

> Thanks,
> drew
> 
> Andrew Jones (5):
>    KVM: arm64: pvtime: steal-time is only supported when configured
>    KVM: arm64: pvtime: Fix potential loss of stolen time
>    KVM: arm64: pvtime: Fix stolen time accounting across migration
>    KVM: Documentation minor fixups
>    arm64/x86: KVM: Introduce steal-time cap
> 
>   Documentation/virt/kvm/api.rst    | 20 ++++++++++++++++----
>   arch/arm64/include/asm/kvm_host.h |  2 +-
>   arch/arm64/kvm/arm.c              |  3 +++
>   arch/arm64/kvm/pvtime.c           | 31 +++++++++++++++----------------
>   arch/x86/kvm/x86.c                |  3 +++
>   include/linux/kvm_host.h          | 19 +++++++++++++++++++
>   include/uapi/linux/kvm.h          |  1 +
>   7 files changed, 58 insertions(+), 21 deletions(-)
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
