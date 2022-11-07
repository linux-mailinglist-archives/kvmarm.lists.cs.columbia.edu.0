Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 204D1620407
	for <lists+kvmarm@lfdr.de>; Tue,  8 Nov 2022 00:53:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 31C7F4B8BB;
	Mon,  7 Nov 2022 18:53:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ii900IqAVyYY; Mon,  7 Nov 2022 18:53:36 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7C99A4B8B9;
	Mon,  7 Nov 2022 18:53:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AD344B898
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Nov 2022 18:53:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQ1GUtSOnW6D for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Nov 2022 18:53:31 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 51E4E4B88F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Nov 2022 18:53:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667865210;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pT3sJPmwBj29BZlhUVGZFUrh95hujl1L/E+LlGzj8c8=;
 b=fp7MS5g3Nhc4PzlhUKtibsgJ7/u7sMdObm4Yt7dGa/3rqi+4nm7PzWG0hMy75PJjPB6YaZ
 qSbT7YDOyCuyypsrLA785+JAKFL4xyNMQYISQzRTbDn0MySYuSplDemlEyw9OyYY3tTijP
 v94lmElQRZM5rGtT2hSMW6aXqKnHvco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-d7dFaKVHN2WExWFIgfGwJw-1; Mon, 07 Nov 2022 18:53:27 -0500
X-MC-Unique: d7dFaKVHN2WExWFIgfGwJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EB9985A59D;
 Mon,  7 Nov 2022 23:53:26 +0000 (UTC)
Received: from [10.64.54.78] (vpn2-54-78.bne.redhat.com [10.64.54.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F236EC15BB5;
 Mon,  7 Nov 2022 23:53:20 +0000 (UTC)
Subject: Re: [PATCH v8 3/7] KVM: Support dirty ring in conjunction with bitmap
To: Marc Zyngier <maz@kernel.org>
References: <20221104234049.25103-1-gshan@redhat.com>
 <20221104234049.25103-4-gshan@redhat.com>
 <ec281dc5-baa2-3e18-8e83-089322db551a@redhat.com>
 <861qqfq9s2.wl-maz@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <3b1ed84e-c911-f41a-a57d-eada16e093c3@redhat.com>
Date: Tue, 8 Nov 2022 07:53:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <861qqfq9s2.wl-maz@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Cc: shuah@kernel.org, kvm@vger.kernel.org, catalin.marinas@arm.com,
 andrew.jones@linux.dev, dmatlack@google.com, shan.gavin@gmail.com,
 bgardon@google.com, kvmarm@lists.linux.dev, pbonzini@redhat.com,
 zhenyzha@redhat.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 ajones@ventanamicro.com
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

Hi Marc,

On 11/7/22 7:33 PM, Marc Zyngier wrote:
> On Mon, 07 Nov 2022 10:45:34 +0000,
> Gavin Shan <gshan@redhat.com> wrote:
>> On 11/5/22 7:40 AM, Gavin Shan wrote:
>>> ARM64 needs to dirty memory outside of a VCPU context when VGIC/ITS is
>>> enabled. It's conflicting with that ring-based dirty page tracking always
>>> requires a running VCPU context.
>>>
>>> Introduce a new flavor of dirty ring that requires the use of both VCPU
>>> dirty rings and a dirty bitmap. The expectation is that for non-VCPU
>>> sources of dirty memory (such as the VGIC/ITS on arm64), KVM writes to
>>> the dirty bitmap. Userspace should scan the dirty bitmap before migrating
>>> the VM to the target.
>>>
>>> Use an additional capability to advertise this behavior. The newly added
>>> capability (KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP) can't be enabled before
>>> KVM_CAP_DIRTY_LOG_RING_ACQ_REL on ARM64. In this way, the newly added
>>> capability is treated as an extension of KVM_CAP_DIRTY_LOG_RING_ACQ_REL.
>>>
>>> Suggested-by: Marc Zyngier <maz@kernel.org>
>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>> Co-developed-by: Oliver Upton <oliver.upton@linux.dev>
>>> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> Acked-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++-----
>>>    include/linux/kvm_dirty_ring.h |  7 +++++
>>>    include/linux/kvm_host.h       |  1 +
>>>    include/uapi/linux/kvm.h       |  1 +
>>>    virt/kvm/Kconfig               |  8 ++++++
>>>    virt/kvm/dirty_ring.c          | 10 +++++++
>>>    virt/kvm/kvm_main.c            | 49 +++++++++++++++++++++++++++-------
>>>    7 files changed, 93 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst

[...]

>>
>> In order to speed up the review and reduce unnecessary respins. After
>> collecting comments on PATCH[v8 3/7] from Marc and Peter, I would change
>> above description as below. Could you please confirm it looks good to you?
>>
>> In the 4th paragraph, the words starting from "Collecting the dirty bitmap..."
>> to the end, was previously suggested by Oliver, even Marc suggested to avoid
>> mentioning "migration".
>>
>>    After enabling the dirty rings, the userspace needs to detect the
>>    capability of KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP to see whether the ring
>>    structures need to be backed by per-slot bitmaps. With this capability
> 
> s/need/can/. If there was a *need*, it should happen automatically
> without user intervention.
> 

Ok. s/need to/can in next revision :)

>>    advertised, it means the architecture can dirty guest pages without
>>    vcpu/ring context, so that some of the dirty information will still be
>>    maintained in the bitmap structure. KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP
>>    can't be enabled if the capability of KVM_CAP_DIRTY_LOG_RING_ACQ_REL
>>    hasn't been enabled, or any memslot has been existing.
>>
>>    Note that the bitmap here is only a backup of the ring structure. The
>>    use of the ring and bitmap combination is only beneficial if there is
>>    only a very small amount of memory that is dirtied out of vcpu/ring
>>    context. Otherwise, the stand-alone per-slot bitmap mechanism needs to
>>    be considered.
>>
>>    To collect dirty bits in the backup bitmap, userspace can use the same
>>    KVM_GET_DIRTY_LOG ioctl. KVM_CLEAR_DIRTY_LOG isn't needed as long as all
>>    the generation of the dirty bits is done in a single pass. Collecting
>>    the dirty bitmap should be the very last thing that the VMM does before
>>    transmitting state to the target VM. VMM needs to ensure that the dirty
>>    state is final and avoid missing dirty pages from another ioctl ordered
>>    after the bitmap collection.
> 
> I would replace "transmitting state to the target VM" with
> "considering the state as complete", as I still object to casting this
> API into the migration mold. People use this stuff more far more than
> migration (checkpointing, for example).
> 

Fair enough. I will change accordingly in next revision.

>>
>>    NOTE: One example of using the backup bitmap is saving arm64 vgic/its
>>    tables through KVM_DEV_ARM_{VGIC_GRP_CTRL, ITS_SAVE_TABLES} command on
>>    KVM device "kvm-arm-vgic-its" during VM's migration.
> 
> Same remark about migration.
> 

Ok. I will change this paragraph as below in next revision, to avoid mentioning
"migration".

   NOTE: One example of using the backup bitmap is saving arm64 vgic/its
   tables through KVM_DEV_ARM_{VGIC_GRP_CTRL, ITS_SAVE_TABLES} command on
   KVM device "kvm-arm-vgic-its" when dirty ring is enabled.

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
