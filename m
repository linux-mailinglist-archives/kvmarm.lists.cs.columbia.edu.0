Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D64883A7A64
	for <lists+kvmarm@lfdr.de>; Tue, 15 Jun 2021 11:21:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 57F6A4B0EC;
	Tue, 15 Jun 2021 05:21:46 -0400 (EDT)
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
	with ESMTP id TInD0Rqy8bJz; Tue, 15 Jun 2021 05:21:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D0E24B0E5;
	Tue, 15 Jun 2021 05:21:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 972844B0BC
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Jun 2021 05:21:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BvZO3pWWoYou for <kvmarm@lists.cs.columbia.edu>;
 Tue, 15 Jun 2021 05:21:42 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 958A74B09F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 15 Jun 2021 05:21:42 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E23BF6137D;
 Tue, 15 Jun 2021 09:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623748901;
 bh=0tj/dQXhQr4F8TkJ6u1QLLJjy1TjKMTf4Ej+MdIFcnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q5lST+dKOr4Dkl2UvZOYXFU0nxIYOs1vGMf3GpujfqPe/5SiJ3pNN9BuT6A9RmZcR
 D/kah3Ydys+8ikUaKNj4CpYs+Byb3CybeMwgGrGiBMlDVhfeqyDewJ7I7wZzC0m6fi
 2mRxpNnl2uEoOWM10Sps8EkZbn/PVdnivEL0TO28=
Date: Tue, 15 Jun 2021 11:21:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v9 0/5] KVM statistics data fd-based binary interface
Message-ID: <YMhxIiciyzPchF/2@kroah.com>
References: <20210614212155.1670777-1-jingzhangos@google.com>
 <b86aa6df-5fd7-d705-1688-4d325df6f7d9@metux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b86aa6df-5fd7-d705-1688-4d325df6f7d9@metux.net>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>,
 David Matlack <dmatlack@google.com>, Jim Mattson <jmattson@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Shier <pshier@google.com>, LinuxMIPS <linux-mips@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Tue, Jun 15, 2021 at 10:37:36AM +0200, Enrico Weigelt, metux IT consult wrote:
> Why not putting this into sysfs ?

Because sysfs is "one value per file".

> I see two options:
> 
> a) if it's really kvm-specific (and no chance of using the same
>    interface for other hypervisors), we could put it under the
>    kvm device (/sys/class/misc/kvm).

Again, that is NOT what sysfs is for.

> b) have a generic VMM stats interface that theroretically could work
>    with any hypervisor.

What other hypervisor matters?

greg k-h
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
