Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2C3F87EA
	for <lists+kvmarm@lfdr.de>; Thu, 26 Aug 2021 14:48:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A37E14B114;
	Thu, 26 Aug 2021 08:48:53 -0400 (EDT)
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
	with ESMTP id 7+AhA-eoDWxI; Thu, 26 Aug 2021 08:48:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B239E4B10D;
	Thu, 26 Aug 2021 08:48:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 01E034B0FE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Aug 2021 08:48:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5IePnGHxMqFa for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Aug 2021 08:48:46 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E24F34B0F7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Aug 2021 08:48:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629982126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bUwJRAJ6EB5NdhoyuMNoCLrXGQTwaXG75pAqtPkBtiI=;
 b=Nf+lxU5DsqYqDpKx5bEbRfHvqL46kdySvgr5aVr1+OOzOS/LySRnqCjK25AiqOKmkJYgn5
 24YN/+a5eVvBRjRDABEOjVZ4mNpGRpXPVfZHn6SGmRQ6iTGtN1nzTOK3vbG63ZUI3P3p2v
 nEKmXBR1pDn13MYuI6k9YjpKaY3G3kY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-uQCCp8p9MEGitVIWfr94Lw-1; Thu, 26 Aug 2021 08:48:43 -0400
X-MC-Unique: uQCCp8p9MEGitVIWfr94Lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8E86190B2A0;
 Thu, 26 Aug 2021 12:48:40 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BFE1604CC;
 Thu, 26 Aug 2021 12:48:40 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
 id 8B23F416CE49; Thu, 26 Aug 2021 09:48:36 -0300 (-03)
Date: Thu, 26 Aug 2021 09:48:36 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v7 6/6] KVM: x86: Expose TSC offset controls to userspace
Message-ID: <20210826124836.GA155749@fuller.cnet>
References: <20210816001130.3059564-1-oupton@google.com>
 <20210816001130.3059564-7-oupton@google.com>
 <CAOQ_Qsj_MfRNRRSK1UswsfBw4c9ugSW6tKXNua=3O78sHEonvA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ_Qsj_MfRNRRSK1UswsfBw4c9ugSW6tKXNua=3O78sHEonvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Catalin Marinas <catalin.marinas@arm.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

On Mon, Aug 23, 2021 at 01:56:30PM -0700, Oliver Upton wrote:
> Paolo,
> 
> On Sun, Aug 15, 2021 at 5:11 PM Oliver Upton <oupton@google.com> wrote:
> >
> > To date, VMM-directed TSC synchronization and migration has been a bit
> > messy. KVM has some baked-in heuristics around TSC writes to infer if
> > the VMM is attempting to synchronize. This is problematic, as it depends
> > on host userspace writing to the guest's TSC within 1 second of the last
> > write.
> >
> > A much cleaner approach to configuring the guest's views of the TSC is to
> > simply migrate the TSC offset for every vCPU. Offsets are idempotent,
> > and thus not subject to change depending on when the VMM actually
> > reads/writes values from/to KVM. The VMM can then read the TSC once with
> > KVM_GET_CLOCK to capture a (realtime, host_tsc) pair at the instant when
> > the guest is paused.
> >
> > Cc: David Matlack <dmatlack@google.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Oliver Upton <oupton@google.com>
> 
> Could you please squash the following into this patch? We need to
> advertise KVM_CAP_VCPU_ATTRIBUTES to userspace. Otherwise, happy to
> resend.
> 
> Thanks,
> Oliver

Oliver,

Is there QEMU support for this, or are you using your own
userspace with this?

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
