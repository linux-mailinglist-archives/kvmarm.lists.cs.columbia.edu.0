Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD4736B414
	for <lists+kvmarm@lfdr.de>; Mon, 26 Apr 2021 15:23:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9401D4AC78;
	Mon, 26 Apr 2021 09:23:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3VXkFebR3ktH; Mon, 26 Apr 2021 09:23:07 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5E3F94B086;
	Mon, 26 Apr 2021 09:23:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 139444B165
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Apr 2021 08:44:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aPNKSfFHipim for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Apr 2021 08:44:09 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 11D5E4B15F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Apr 2021 08:44:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619441048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSlotn4fBSdFFf3NHGJvYzieEsXBeHjCWbwR+pEgCSM=;
 b=IDvUY6jOfjwl7qFQXDiidWQC/ldN23dhpADcL3/YJT4KLxFWDvYZjoWceLZD++cDXfYWUO
 lAlflOly5AXVWaY3QBC/A8ZcxmSNih9ZW88ol6NZiMNxcSzuO7C3WNM5tDSyjeNclqjesq
 6/+YX6MHAm9PjppsoH50z6/d9eUMLsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-W1_il_x5O0-KQwH5hQ0CVw-1; Mon, 26 Apr 2021 08:44:07 -0400
X-MC-Unique: W1_il_x5O0-KQwH5hQ0CVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BB3587A83F;
 Mon, 26 Apr 2021 12:44:03 +0000 (UTC)
Received: from starship (unknown [10.40.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F70F6268B;
 Mon, 26 Apr 2021 12:43:49 +0000 (UTC)
Message-ID: <6d7146021f3435330b42f2e1b917d4b5dea00edc.camel@redhat.com>
Subject: Re: [PATCH v2 0/9] KVM: my debug patch queue
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Date: Mon, 26 Apr 2021 15:43:48 +0300
In-Reply-To: <cb7f918c-932f-d558-76ec-801ed8ed1f62@redhat.com>
References: <20210401135451.1004564-1-mlevitsk@redhat.com>
 <cb7f918c-932f-d558-76ec-801ed8ed1f62@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mailman-Approved-At: Mon, 26 Apr 2021 09:23:05 -0400
Cc: Wanpeng Li <wanpengli@tencent.com>, David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 "open list:KERNEL
 VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)" <kvmarm@lists.cs.columbia.edu>,
 "open list:S390" <linux-s390@vger.kernel.org>,
 Janosch Frank <frankja@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Kieran Bingham <kbingham@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, "moderated
 list:KERNEL VIRTUAL MACHINE FOR ARM64 \(KVM/arm64\)"
 <linux-arm-kernel@lists.infradead.org>, Jim Mattson <jmattson@google.com>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Fri, 2021-04-02 at 10:38 -0700, Paolo Bonzini wrote:
> On 01/04/21 15:54, Maxim Levitsky wrote:
> > Hi!
> > 
> > I would like to publish two debug features which were needed for other stuff
> > I work on.
> > 
> > One is the reworked lx-symbols script which now actually works on at least
> > gdb 9.1 (gdb 9.2 was reported to fail to load the debug symbols from the kernel
> > for some reason, not related to this patch) and upstream qemu.
> 
> Queued patches 2-5 for now.  6 is okay but it needs a selftest. (e.g. 
> using KVM_VCPU_SET_EVENTS) and the correct name for the constant.
Do you mean to add a kvm-unit-test or to add a test to kernel's kvm unit tests
for this?

Best regards,
	Maxim Levitsky

> 
> Paolo
> 
> > The other feature is the ability to trap all guest exceptions (on SVM for now)
> > and see them in kvmtrace prior to potential merge to double/triple fault.
> > 
> > This can be very useful and I already had to manually patch KVM a few
> > times for this.
> > I will, once time permits, implement this feature on Intel as well.
> > 
> > V2:
> > 
> >   * Some more refactoring and workarounds for lx-symbols script
> > 
> >   * added KVM_GUESTDBG_BLOCKEVENTS flag to enable 'block interrupts on
> >     single step' together with KVM_CAP_SET_GUEST_DEBUG2 capability
> >     to indicate which guest debug flags are supported.
> > 
> >     This is a replacement for unconditional block of interrupts on single
> >     step that was done in previous version of this patch set.
> >     Patches to qemu to use that feature will be sent soon.
> > 
> >   * Reworked the the 'intercept all exceptions for debug' feature according
> >     to the review feedback:
> > 
> >     - renamed the parameter that enables the feature and
> >       moved it to common kvm module.
> >       (only SVM part is currently implemented though)
> > 
> >     - disable the feature for SEV guests as was suggested during the review
> >     - made the vmexit table const again, as was suggested in the review as well.
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > Maxim Levitsky (9):
> >    scripts/gdb: rework lx-symbols gdb script
> >    KVM: introduce KVM_CAP_SET_GUEST_DEBUG2
> >    KVM: x86: implement KVM_CAP_SET_GUEST_DEBUG2
> >    KVM: aarch64: implement KVM_CAP_SET_GUEST_DEBUG2
> >    KVM: s390x: implement KVM_CAP_SET_GUEST_DEBUG2
> >    KVM: x86: implement KVM_GUESTDBG_BLOCKEVENTS
> >    KVM: SVM: split svm_handle_invalid_exit
> >    KVM: x86: add force_intercept_exceptions_mask
> >    KVM: SVM: implement force_intercept_exceptions_mask
> > 
> >   Documentation/virt/kvm/api.rst    |   4 +
> >   arch/arm64/include/asm/kvm_host.h |   4 +
> >   arch/arm64/kvm/arm.c              |   2 +
> >   arch/arm64/kvm/guest.c            |   5 -
> >   arch/s390/include/asm/kvm_host.h  |   4 +
> >   arch/s390/kvm/kvm-s390.c          |   3 +
> >   arch/x86/include/asm/kvm_host.h   |  12 ++
> >   arch/x86/include/uapi/asm/kvm.h   |   1 +
> >   arch/x86/kvm/svm/svm.c            |  87 +++++++++++--
> >   arch/x86/kvm/svm/svm.h            |   6 +-
> >   arch/x86/kvm/x86.c                |  14 ++-
> >   arch/x86/kvm/x86.h                |   2 +
> >   include/uapi/linux/kvm.h          |   1 +
> >   kernel/module.c                   |   8 +-
> >   scripts/gdb/linux/symbols.py      | 203 ++++++++++++++++++++----------
> >   15 files changed, 272 insertions(+), 84 deletions(-)
> > 


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
