Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B0268124AA9
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 16:07:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4B5BB4A541;
	Wed, 18 Dec 2019 10:07:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ec4HIzdEOl6s; Wed, 18 Dec 2019 10:07:57 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 22CB24A535;
	Wed, 18 Dec 2019 10:07:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E8FE74A500
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 10:07:54 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLLIDFp2QXh7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 10:07:53 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BB0C44A418
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 10:07:53 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5533C30E;
 Wed, 18 Dec 2019 07:07:53 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 554673F719;
 Wed, 18 Dec 2019 07:07:51 -0800 (PST)
Subject: Re: [PATCH 7/7] KVM: arm/arm64: Elide CMOs when unmapping a range
To: Marc Zyngier <maz@kernel.org>
References: <20191213182503.14460-1-maz@kernel.org>
 <20191213182503.14460-8-maz@kernel.org>
From: James Morse <james.morse@arm.com>
Message-ID: <0c832b27-7041-a6c8-31c0-d71a25c6f5b8@arm.com>
Date: Wed, 18 Dec 2019 15:07:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213182503.14460-8-maz@kernel.org>
Content-Language: en-GB
Cc: kvm-ppc@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-mips@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paul Mackerras <paulus@ozlabs.org>, linux-arm-kernel@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

Hi Marc,

On 13/12/2019 18:25, Marc Zyngier wrote:
> If userspace issues a munmap() on a set of pages, there is no
> expectation that the pages are cleaned to the PoC.

(Pedantry: Clean and invalidate. If the guest wrote through a device mapping, we ditch any
clean+stale lines with this path, meaning swapout saves the correct values)


> So let's
> not do more work than strictly necessary, and set the magic
> flag that avoids CMOs in this case.

I think this assumes the pages went from anonymous->free, so no-one cares about the contents.

If the pages are backed by a file, won't dirty pages will still get written back before
the page is free? (e.g. EFI flash 'file' mmap()ed in)

What if this isn't the only mapping of the page? Can't it be swapped out from another VMA?
(tenuous example, poor man's memory mirroring?)


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
