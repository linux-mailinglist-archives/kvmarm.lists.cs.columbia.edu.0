Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FA2463F7
	for <lists+kvmarm@lfdr.de>; Mon, 17 Aug 2020 12:05:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 53D284C01D;
	Mon, 17 Aug 2020 06:05:55 -0400 (EDT)
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
	with ESMTP id JDkpC7b5JAY4; Mon, 17 Aug 2020 06:05:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1E56C4C00C;
	Mon, 17 Aug 2020 06:05:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1620E4BFFA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:05:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZ9k27o9Rf32 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Aug 2020 06:05:51 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05F644C005
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Aug 2020 06:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597658750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g75ZrE5XjeoAa9GS4qjgn2IQEBfxskCSMkQo08Lrbg0=;
 b=M2UnPZ58I7cv3ZdEfVXN+Vsz/PhBNYMb2m9oF+P/13wYA7wYGXOA/1K2HC2GhaBmuN16ha
 m7AI6pvbm1nyMW6X4PvBaRrrE0/rPv8HwhpnyIVleFKc7nc+z5T9IrKja3n3dz+nNmp0fE
 K/wAHwgtg5d8vYB4oA6eTpqulLe+hb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-dwITyxXoPjqksMABUnQb-g-1; Mon, 17 Aug 2020 06:05:42 -0400
X-MC-Unique: dwITyxXoPjqksMABUnQb-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D4A01DDE6;
 Mon, 17 Aug 2020 10:05:41 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-130.bne.redhat.com [10.64.54.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EE86784AD;
 Mon, 17 Aug 2020 10:05:34 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH 00/18] Support SDEI Virtualization
Date: Mon, 17 Aug 2020 20:05:13 +1000
Message-Id: <20200817100531.83045-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Cc: maz@kernel.org, shan.gavin@gmail.com, pbonzini@redhat.com
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

This series intends to support SDEI virtualization. The background is
the feature (Asynchronous Page Fault) needs virtualized SDEI event to
deliver page-not-present notification from host to guest. This series
depends on the series "Refactor SDEI Client Driver", which was posted
previously. Both series can be found from github:

   https://developer.arm.com/documentation/den0054/a/
   https://www.spinics.net/lists/arm-kernel/msg826783.html
   https://github.com/gwshan/linux  ("sdei_client")
   https://github.com/gwshan/linux  ("sdei")

First of all, bits[23:20] of the SDEI event number are reserved to
indicate the SDEI event type:

   0x0: physical SDEI event number, originated from underly firmware
   0x1: virtual SDEI event number, passed from KVM because of physical
        SDEI event. The corresponding SDEI events are also called as
        passthrou SDEI events.
   0x2: KVM private SDEI event number, originated from KVM itself.

The implementation supports passthrou and KVM private SDEI events. The
same SDEI event can be registered and enabled on multiple VMs. So the
registered SDEI event is represented by "struct kvm_sdei_event" and
formed into a linked list globally. "struct kvm_sdei_kvm_event" is
created and inserted into the radix tree in "struct kvm_sdei_event",
which is indexed by @kvm->userspace_pid if the corresponding SDEI event
is registered on the particular KVM. Besides, "struct kvm_sdei_vcpu_event"
is introduced to deliver SDEI event to one particular vCPU. So the data
structs have different scopes, summaried as below:

   struct kvm_sdei_event: global scope
   struct kvm_sdei_kvm_event: VM scope
   struct kvm_sdei_vcpu_event: vCPU sope

For the passthrou SDEI events, the specific handler is registered to the
underly firmware if it's supported. The core functionality of the handler
is to route the incoming SDEI events to the target VM and vCPU. For the
shared SDEI event, it's duplicated to all VMs where the SDEI event was
registered and enabled. The target vCPU is chosen basing on the setting
of routing affinity. For private SDEI event, the event received from the
physical CPU is duplicated and delivered to the vCPUs, which are currently
running or suspending on the physical CPU. For KVM private event, which is
pre-defined and represented by "struct kvm_sdei_priv", API (kvm_sdei_inject())
is always called to deliver the event to the specified vCPU.

The series is organized as below:

PATCH[01-02] Retrieve event signaled property on registration and add API
             (sdei_event_get_info()) to retrieve event's information from
             underly firmware for the passthrou SDEI events.
PATCH[03]    Introduce template for smccc_get_argx().
PATCH[04]    Adds the needed source files, data structs.
PATCH[05-13] Support various hypercalls defined in SDEI specification (v1.0).
PATCH[14]    Implements the SDEI handler to route the incoming passthrou SDEI
             events to target VMs and vCPUs.
PATCH[15-16] Support more hypercalls like COMPLETE, COMPLETE_AND_RESUME, and
             CONTEXT.
PATCH[17]    Support injecting KVM private SDEI event and expose the SDEI
             capability.
PATCH[18]    Add self-test case for KVM private SDEI event

Gavin Shan (18):
  drivers/firmware/sdei: Retrieve event signaled property on
    registration
  drivers/firmware/sdei: Add sdei_event_get_info()
  arm/smccc: Introduce template for inline functions
  arm64/kvm: Add SDEI virtualization infrastructure
  arm64/kvm: Support SDEI_1_0_FN_SDEI_VERSION hypercall
  arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_REGISTER
  arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_{ENABLE, DISABLE} hypercall
  arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_UNREGISTER hypercall
  arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_STATUS hypercall
  arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_GET_INFO hypercall
  arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET hypercall
  arm64/kvm: Support SDEI_1_0_FN_SDEI_PE_{MASK, UNMASK} hypercall
  arm64/kvm: Support SDEI_1_0_FN_SDEI_{PRIVATE,SHARED}_RESET hypercall
  arm64/kvm: Implement event handler
  arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_{COMPLETE,
    COMPLETE_AND_RESUME} hypercall
  arm64/kvm: Support SDEI_1_0_FN_SDEI_EVENT_CONTEXT hypercall
  arm64/kvm: Expose SDEI capability
  kvm/selftests: Add SDEI test case

 arch/arm64/include/asm/kvm_emulate.h       |    2 +
 arch/arm64/include/asm/kvm_host.h          |   10 +
 arch/arm64/include/asm/kvm_sdei.h          |  117 ++
 arch/arm64/kvm/Makefile                    |    2 +-
 arch/arm64/kvm/aarch32.c                   |    8 +
 arch/arm64/kvm/arm.c                       |   19 +
 arch/arm64/kvm/hypercalls.c                |   19 +
 arch/arm64/kvm/inject_fault.c              |   30 +
 arch/arm64/kvm/reset.c                     |    3 +
 arch/arm64/kvm/sdei.c                      | 1322 ++++++++++++++++++++
 drivers/firmware/arm_sdei.c                |   38 +
 include/kvm/arm_hypercalls.h               |   34 +-
 include/linux/arm_sdei.h                   |    7 +
 include/uapi/linux/kvm.h                   |    4 +
 tools/testing/selftests/kvm/Makefile       |    1 +
 tools/testing/selftests/kvm/aarch64/sdei.c |  170 +++
 16 files changed, 1766 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_sdei.h
 create mode 100644 arch/arm64/kvm/sdei.c
 create mode 100644 tools/testing/selftests/kvm/aarch64/sdei.c

-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
