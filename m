Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 684FD154C07
	for <lists+kvmarm@lfdr.de>; Thu,  6 Feb 2020 20:22:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ED94B4A4CD;
	Thu,  6 Feb 2020 14:22:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ki6fhNpOjOX; Thu,  6 Feb 2020 14:22:35 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D94E94A541;
	Thu,  6 Feb 2020 14:22:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0AD134A4CD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 14:22:34 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ItKqxPScYO3 for <kvmarm@lists.cs.columbia.edu>;
 Thu,  6 Feb 2020 14:22:32 -0500 (EST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8D63E4A4A3
 for <kvmarm@lists.cs.columbia.edu>; Thu,  6 Feb 2020 14:22:32 -0500 (EST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Feb 2020 11:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; d="scan'208";a="232140746"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.202])
 by orsmga003.jf.intel.com with ESMTP; 06 Feb 2020 11:22:30 -0800
Date: Thu, 6 Feb 2020 11:22:30 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v5 14/19] KVM: Clean up local variable usage in
 __kvm_set_memory_region()
Message-ID: <20200206192230.GE13067@linux.intel.com>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-15-sean.j.christopherson@intel.com>
 <20200206190641.GA700495@xz-x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200206190641.GA700495@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, kvmarm@lists.cs.columbia.edu,
 Janosch Frank <frankja@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
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

On Thu, Feb 06, 2020 at 02:06:41PM -0500, Peter Xu wrote:
> On Tue, Jan 21, 2020 at 02:31:52PM -0800, Sean Christopherson wrote:
> 
> [...]
> 
> > @@ -1101,52 +1099,55 @@ int __kvm_set_memory_region(struct kvm *kvm,
> >  	if (mem->guest_phys_addr + mem->memory_size < mem->guest_phys_addr)
> >  		return -EINVAL;
> >  
> > -	slot = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> > -	base_gfn = mem->guest_phys_addr >> PAGE_SHIFT;
> > -	npages = mem->memory_size >> PAGE_SHIFT;
> > -
> > -	if (npages > KVM_MEM_MAX_NR_PAGES)
> > -		return -EINVAL;
> > -
> >  	/*
> >  	 * Make a full copy of the old memslot, the pointer will become stale
> >  	 * when the memslots are re-sorted by update_memslots().
> >  	 */
> > -	old = *slot;
> > +	tmp = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> > +	old = *tmp;
> > +	tmp = NULL;
> 
> Shall we keep this chunk to the patch where it will be used?  Other
> than that, it looks good to me.

I assume you're talking about doing this instead of using @tmp?

	old = *id_to_memslot(__kvm_memslots(kvm, as_id), id);

It's obviously possible, but I really like resulting diff for
__kvm_set_memory_region() in "KVM: Terminate memslot walks via used_slots"
when tmp is used.

@@ -1104,8 +1203,13 @@ int __kvm_set_memory_region(struct kvm *kvm,
         * when the memslots are re-sorted by update_memslots().
         */
        tmp = id_to_memslot(__kvm_memslots(kvm, as_id), id);
-       old = *tmp;
-       tmp = NULL;
+       if (tmp) {
+               old = *tmp;
+               tmp = NULL;
+       } else {
+               memset(&old, 0, sizeof(old));
+               old.id = id;
+       }

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
