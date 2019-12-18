Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2175F124E00
	for <lists+kvmarm@lfdr.de>; Wed, 18 Dec 2019 17:40:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 919024A7FE;
	Wed, 18 Dec 2019 11:40:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 46IB5xzxsbiZ; Wed, 18 Dec 2019 11:40:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 860D84A7E4;
	Wed, 18 Dec 2019 11:40:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B1D184A54B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 11:40:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Idlr4foSpduD for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Dec 2019 11:40:01 -0500 (EST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1B7704A5A8
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Dec 2019 11:40:01 -0500 (EST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2019 08:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; d="scan'208";a="205898318"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.202])
 by orsmga007.jf.intel.com with ESMTP; 18 Dec 2019 08:39:59 -0800
Date: Wed, 18 Dec 2019 08:39:59 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 19/19] KVM: selftests: Add test for
 KVM_SET_USER_MEMORY_REGION
Message-ID: <20191218163958.GC25201@linux.intel.com>
References: <20191217204041.10815-1-sean.j.christopherson@intel.com>
 <20191217204041.10815-20-sean.j.christopherson@intel.com>
 <f962fafb-3956-746f-d077-3dbcefaae7c8@de.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f962fafb-3956-746f-d077-3dbcefaae7c8@de.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
 linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 kvmarm@lists.cs.columbia.edu, Janosch Frank <frankja@linux.ibm.com>,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
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

On Wed, Dec 18, 2019 at 12:39:43PM +0100, Christian Borntraeger wrote:
> 
> On 17.12.19 21:40, Sean Christopherson wrote:
> > Add a KVM selftest to test moving the base gfn of a userspace memory
> > region.  The test is primarily targeted at x86 to verify its memslot
> > metadata is correctly updated, but also provides basic functionality
> > coverage on other architectures.
> > +static void *vcpu_worker(void *data)
> > +{
> > +	struct kvm_vm *vm = data;
> > +	struct kvm_run *run;
> > +	struct ucall uc;
> > +	uint64_t cmd;
> > +
> > +	/*
> > +	 * Loop until the guest is done.  Re-enter the guest on all MMIO exits,
> > +	 * which will occur if the guest attempts to access a memslot while it
> > +	 * is being moved.
> > +	 */
> > +	run = vcpu_state(vm, VCPU_ID);
> > +	do {
> > +		vcpu_run(vm, VCPU_ID);
> > +	} while (run->exit_reason == KVM_EXIT_MMIO);
> > +
> > +	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> > +		    "Unexpected exit reason = %d", run->exit_reason);
> 
> 
> This will also not work for s390. Maybe just make this test x86 specific for now?

Doh, that's obvious in hindsight.  I think the basic premise is also
broken on arm64 as it returns -EFAULT on is_error_noslot_pfn(pfn).  So
yeah, x86 only for now :-(
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
