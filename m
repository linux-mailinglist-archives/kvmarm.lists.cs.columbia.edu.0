Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D126E3AAB7D
	for <lists+kvmarm@lfdr.de>; Thu, 17 Jun 2021 07:56:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B8DF4B08F;
	Thu, 17 Jun 2021 01:56:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.09
X-Spam-Level: 
X-Spam-Status: No, score=-4.09 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01, URIBL_RED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linuxfoundation.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YDKagS7p-sLk; Thu, 17 Jun 2021 01:56:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 12C6C4AEE2;
	Thu, 17 Jun 2021 01:56:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B7CE549FB7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 01:56:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFTf1sHmPlzH for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Jun 2021 01:56:46 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B2F5249F8F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Jun 2021 01:56:46 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFE4F61075;
 Thu, 17 Jun 2021 05:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623909405;
 bh=vOtZNKgdXLXqvbCCw4+EXSMYJqOfs4O96QCwxuzPKbo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qNELfefjOAmF72RgUFSYDo4Z5fFYlxjRbHuar95j+JUZJM3ZgjfoCqhN7zHBh1NLu
 O5paI6p4ir9l5NxuT9uUonZlFMa504HLp2Gt6iLpKk+tjloFIl0Z6DA+5I2MLbsQOw
 5SPL6v8y5Mhw6ZNQKl/x8pba97RTapGJ/iGkIKCs=
Date: Thu, 17 Jun 2021 07:56:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
Message-ID: <YMrkGZzPrt0jA1iP@kroah.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210617044146.2667540-4-jingzhangos@google.com>
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

On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
> +	struct kvm_stats_desc {
> +		__u32 flags;
> +		__s16 exponent;
> +		__u16 size;
> +		__u32 offset;
> +		__u32 unused;
> +		char name[0];
> +	};

<snip>

> +The ``unused`` fields are reserved for future support for other types of
> +statistics data, like log/linear histogram.

you HAVE to set unused to 0 for now, otherwise userspace does not know
it is unused, right?  And then, really it is "used", so why not just say
that now?  It's tricky, but you have to get this right now otherwise you
can never use it in the future.

> +The ``name`` field points to the name string of the statistics data. The name

It is not a pointer, it is the data itself.

> +string starts at the end of ``struct kvm_stats_desc``.
> +The maximum length (including trailing '\0') is indicated by ``name_size``
> +in ``struct kvm_stats_header``.

I thought we were replacing [0] arrays with [], are you sure you should
be declaring this as [0]?  Same for all structures in this document (and
code).

thanks,

greg k-h
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
