Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E4E4799915
	for <lists+kvmarm@lfdr.de>; Thu, 22 Aug 2019 18:24:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6870D4A5F2;
	Thu, 22 Aug 2019 12:24:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BwCHtDvetrBd; Thu, 22 Aug 2019 12:24:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 415C14A5EC;
	Thu, 22 Aug 2019 12:24:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C388A4A5E6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Aug 2019 12:24:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h-C6vwVgILtQ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 22 Aug 2019 12:24:51 -0400 (EDT)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3B72E4A597
 for <kvmarm@lists.cs.columbia.edu>; Thu, 22 Aug 2019 12:24:51 -0400 (EDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 09:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; d="scan'208";a="181437997"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.41])
 by orsmga003.jf.intel.com with ESMTP; 22 Aug 2019 09:24:49 -0700
Date: Thu, 22 Aug 2019 09:24:49 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3 04/10] KVM: Implement kvm_put_guest()
Message-ID: <20190822162449.GF25467@linux.intel.com>
References: <20190821153656.33429-1-steven.price@arm.com>
 <20190821153656.33429-5-steven.price@arm.com>
 <20190822152854.GE25467@linux.intel.com>
 <e2abc69b-74c2-64ef-e270-43d93513eaae@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e2abc69b-74c2-64ef-e270-43d93513eaae@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-doc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Thu, Aug 22, 2019 at 04:46:10PM +0100, Steven Price wrote:
> On 22/08/2019 16:28, Sean Christopherson wrote:
> > On Wed, Aug 21, 2019 at 04:36:50PM +0100, Steven Price wrote:
> >> kvm_put_guest() is analogous to put_user() - it writes a single value to
> >> the guest physical address. The implementation is built upon put_user()
> >> and so it has the same single copy atomic properties.
> > 
> > What you mean by "single copy atomic"?  I.e. what guarantees does
> > put_user() provide that __copy_to_user() does not?
> 
> Single-copy atomicity is defined by the Arm architecture[1] and I'm not
> going to try to go into the full details here, so this is a summary.
> 
> For the sake of this feature what we care about is that the value
> written/read cannot be "torn". In other words if there is a read (in
> this case from another VCPU) that is racing with the write then the read
> will either get the old value or the new value. It cannot return a
> mixture. (This is of course assuming that the read is using a
> single-copy atomic safe method).

Thanks for the explanation.  I assumed that's what you were referring to,
but wanted to double check.
 
> __copy_to_user() is implemented as a memcpy() and as such cannot provide
> single-copy atomicity in the general case (the buffer could easily be
> bigger than the architecture can guarantee).
> 
> put_user() on the other hand is implemented (on arm64) as an explicit
> store instruction and therefore is guaranteed by the architecture to be
> single-copy atomic (i.e. another CPU cannot see a half-written value).

I don't think kvm_put_guest() belongs in generic code, at least not with
the current changelog explanation about it providing single-copy atomic
semantics.  AFAICT, the single-copy thing is very much an arm64
implementation detail, e.g. the vast majority of 32-bit architectures,
including x86, do not provide any guarantees, and x86-64 generates more
or less the same code for put_user() and __copy_to_user() for 8-byte and
smaller accesses.

As an alternative to kvm_put_guest() entirely, is it an option to change
arm64's raw_copy_to_user() to redirect to __put_user() for sizes that are
constant at compile time and can be handled by __put_user()?  That would
allow using kvm_write_guest() to update stolen time, albeit with
arguably an even bigger dependency on the uaccess implementation details.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
