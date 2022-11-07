Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F0BFC61F0FC
	for <lists+kvmarm@lfdr.de>; Mon,  7 Nov 2022 11:45:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E93B4B8BA;
	Mon,  7 Nov 2022 05:45:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9cSEhg5mgBVt; Mon,  7 Nov 2022 05:45:56 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 152214B8AF;
	Mon,  7 Nov 2022 05:45:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AD54B4B8A5
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Nov 2022 05:45:51 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vLXwe80fwJRw for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Nov 2022 05:45:46 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 627854B8A4
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Nov 2022 05:45:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667817946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhZko2tAd95sGl8F5ZCIlFO5WTO1mvvlCzHGpHk9NGk=;
 b=e4ku9cu5R0Wp+LliNr7o5Wy5nfKpnxcV97R/K4s6xKa9Ouec5EDcBWniTGslvO3hBZcBLV
 kw2zEUcUDuKkxvXsgsJ/XHyFLGnD+eDELlZ1Cm2vTVjNIjqI4Z6W3A+YiVF2Z9pepi3Fqo
 lFU0REnEl+/SVjktg/MR/RbNrDP+1B0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-KI2XVnQkP2W6p69I6MeARQ-1; Mon, 07 Nov 2022 05:45:42 -0500
X-MC-Unique: KI2XVnQkP2W6p69I6MeARQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19563101A54E;
 Mon,  7 Nov 2022 10:45:42 +0000 (UTC)
Received: from [10.64.54.78] (vpn2-54-78.bne.redhat.com [10.64.54.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32F8940C2064;
 Mon,  7 Nov 2022 10:45:36 +0000 (UTC)
Subject: Re: [PATCH v8 3/7] KVM: Support dirty ring in conjunction with bitmap
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.linux.dev
References: <20221104234049.25103-1-gshan@redhat.com>
 <20221104234049.25103-4-gshan@redhat.com>
Message-ID: <ec281dc5-baa2-3e18-8e83-089322db551a@redhat.com>
Date: Mon, 7 Nov 2022 18:45:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20221104234049.25103-4-gshan@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: shuah@kernel.org, kvm@vger.kernel.org, maz@kernel.org, bgardon@google.com,
 andrew.jones@linux.dev, shan.gavin@gmail.com, catalin.marinas@arm.com,
 dmatlack@google.com, pbonzini@redhat.com, zhenyzha@redhat.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, ajones@ventanamicro.com
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

Hi Marc, Peter, Oliver and Sean,

On 11/5/22 7:40 AM, Gavin Shan wrote:
> ARM64 needs to dirty memory outside of a VCPU context when VGIC/ITS is
> enabled. It's conflicting with that ring-based dirty page tracking always
> requires a running VCPU context.
> 
> Introduce a new flavor of dirty ring that requires the use of both VCPU
> dirty rings and a dirty bitmap. The expectation is that for non-VCPU
> sources of dirty memory (such as the VGIC/ITS on arm64), KVM writes to
> the dirty bitmap. Userspace should scan the dirty bitmap before migrating
> the VM to the target.
> 
> Use an additional capability to advertise this behavior. The newly added
> capability (KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP) can't be enabled before
> KVM_CAP_DIRTY_LOG_RING_ACQ_REL on ARM64. In this way, the newly added
> capability is treated as an extension of KVM_CAP_DIRTY_LOG_RING_ACQ_REL.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
>   Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++-----
>   include/linux/kvm_dirty_ring.h |  7 +++++
>   include/linux/kvm_host.h       |  1 +
>   include/uapi/linux/kvm.h       |  1 +
>   virt/kvm/Kconfig               |  8 ++++++
>   virt/kvm/dirty_ring.c          | 10 +++++++
>   virt/kvm/kvm_main.c            | 49 +++++++++++++++++++++++++++-------
>   7 files changed, 93 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index eee9f857a986..2ec32bd41792 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8003,13 +8003,6 @@ flushing is done by the KVM_GET_DIRTY_LOG ioctl).  To achieve that, one
>   needs to kick the vcpu out of KVM_RUN using a signal.  The resulting
>   vmexit ensures that all dirty GFNs are flushed to the dirty rings.
>   
> -NOTE: the capability KVM_CAP_DIRTY_LOG_RING and the corresponding
> -ioctl KVM_RESET_DIRTY_RINGS are mutual exclusive to the existing ioctls
> -KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.  After enabling
> -KVM_CAP_DIRTY_LOG_RING with an acceptable dirty ring size, the virtual
> -machine will switch to ring-buffer dirty page tracking and further
> -KVM_GET_DIRTY_LOG or KVM_CLEAR_DIRTY_LOG ioctls will fail.
> -
>   NOTE: KVM_CAP_DIRTY_LOG_RING_ACQ_REL is the only capability that
>   should be exposed by weakly ordered architecture, in order to indicate
>   the additional memory ordering requirements imposed on userspace when
> @@ -8018,6 +8011,32 @@ Architecture with TSO-like ordering (such as x86) are allowed to
>   expose both KVM_CAP_DIRTY_LOG_RING and KVM_CAP_DIRTY_LOG_RING_ACQ_REL
>   to userspace.
>   
> +After using the dirty rings, the userspace needs to detect the capability
> +of KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP to see whether the ring structures
> +need to be backed by per-slot bitmaps. With this capability advertised
> +and supported, it means the architecture can dirty guest pages without
> +vcpu/ring context, so that some of the dirty information will still be
> +maintained in the bitmap structure. KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP
> +can't be enabled until the capability of KVM_CAP_DIRTY_LOG_RING_ACQ_REL
> +has been enabled.
> +
> +Note that the bitmap here is only a backup of the ring structure, and
> +normally should only contain a very small amount of dirty pages, which
> +needs to be transferred during VM downtime. Collecting the dirty bitmap
> +should be the very last thing that the VMM does before transmitting state
> +to the target VM. VMM needs to ensure that the dirty state is final and
> +avoid missing dirty pages from another ioctl ordered after the bitmap
> +collection.
> +
> +To collect dirty bits in the backup bitmap, the userspace can use the
> +same KVM_GET_DIRTY_LOG ioctl. KVM_CLEAR_DIRTY_LOG shouldn't be needed
> +and its behavior is undefined since collecting the dirty bitmap always
> +happens in the last phase of VM's migration.
> +
> +NOTE: One example of using the backup bitmap is saving arm64 vgic/its
> +tables through KVM_DEV_ARM_{VGIC_GRP_CTRL, ITS_SAVE_TABLES} command on
> +KVM device "kvm-arm-vgic-its" during VM's migration.
> +

In order to speed up the review and reduce unnecessary respins. After
collecting comments on PATCH[v8 3/7] from Marc and Peter, I would change
above description as below. Could you please confirm it looks good to you?

In the 4th paragraph, the words starting from "Collecting the dirty bitmap..."
to the end, was previously suggested by Oliver, even Marc suggested to avoid
mentioning "migration".

   After enabling the dirty rings, the userspace needs to detect the
   capability of KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP to see whether the ring
   structures need to be backed by per-slot bitmaps. With this capability
   advertised, it means the architecture can dirty guest pages without
   vcpu/ring context, so that some of the dirty information will still be
   maintained in the bitmap structure. KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP
   can't be enabled if the capability of KVM_CAP_DIRTY_LOG_RING_ACQ_REL
   hasn't been enabled, or any memslot has been existing.

   Note that the bitmap here is only a backup of the ring structure. The
   use of the ring and bitmap combination is only beneficial if there is
   only a very small amount of memory that is dirtied out of vcpu/ring
   context. Otherwise, the stand-alone per-slot bitmap mechanism needs to
   be considered.

   To collect dirty bits in the backup bitmap, userspace can use the same
   KVM_GET_DIRTY_LOG ioctl. KVM_CLEAR_DIRTY_LOG isn't needed as long as all
   the generation of the dirty bits is done in a single pass. Collecting
   the dirty bitmap should be the very last thing that the VMM does before
   transmitting state to the target VM. VMM needs to ensure that the dirty
   state is final and avoid missing dirty pages from another ioctl ordered
   after the bitmap collection.

   NOTE: One example of using the backup bitmap is saving arm64 vgic/its
   tables through KVM_DEV_ARM_{VGIC_GRP_CTRL, ITS_SAVE_TABLES} command on
   KVM device "kvm-arm-vgic-its" during VM's migration.

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
