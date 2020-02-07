Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFCA155E1E
	for <lists+kvmarm@lfdr.de>; Fri,  7 Feb 2020 19:33:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0468C4A944;
	Fri,  7 Feb 2020 13:33:33 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5NFpzZO+En0; Fri,  7 Feb 2020 13:33:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9B4B54A578;
	Fri,  7 Feb 2020 13:33:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8E2FB4A528
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Feb 2020 13:33:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eJ+Jdv8buHcE for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 Feb 2020 13:33:28 -0500 (EST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9DC534A3A5
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 Feb 2020 13:33:28 -0500 (EST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Feb 2020 10:33:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,414,1574150400"; d="scan'208";a="430918451"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.202])
 by fmsmga005.fm.intel.com with ESMTP; 07 Feb 2020 10:33:25 -0800
Date: Fri, 7 Feb 2020 10:33:25 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v5 17/19] KVM: Terminate memslot walks via used_slots
Message-ID: <20200207183325.GI2401@linux.intel.com>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-18-sean.j.christopherson@intel.com>
 <20200206210944.GD700495@xz-x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200206210944.GD700495@xz-x1>
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

On Thu, Feb 06, 2020 at 04:09:44PM -0500, Peter Xu wrote:
> On Tue, Jan 21, 2020 at 02:31:55PM -0800, Sean Christopherson wrote:
> > @@ -9652,13 +9652,13 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
> >  		if (IS_ERR((void *)hva))
> >  			return PTR_ERR((void *)hva);
> >  	} else {
> > -		if (!slot->npages)
> > +		if (!slot || !slot->npages)
> >  			return 0;
> >  
> > -		hva = 0;
> > +		hva = slot->userspace_addr;
> 
> Is this intended?

Yes.  It's possible to allow VA=0 for userspace mappings.  It's extremely
uncommon, but possible.  Therefore "hva == 0" shouldn't be used to
indicate an invalid slot.

> > +		old_npages = slot->npages;
> >  	}
> >  
> > -	old = *slot;
> >  	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> >  		struct kvm_userspace_memory_region m;
> >  

...

> > @@ -869,63 +869,162 @@ static int kvm_create_dirty_bitmap(struct kvm_memory_slot *memslot)
> >  }
> >  
> >  /*
> > - * Insert memslot and re-sort memslots based on their GFN,
> > - * so binary search could be used to lookup GFN.
> > - * Sorting algorithm takes advantage of having initially
> > - * sorted array and known changed memslot position.
> > + * Delete a memslot by decrementing the number of used slots and shifting all
> > + * other entries in the array forward one spot.
> > + */
> > +static inline void kvm_memslot_delete(struct kvm_memslots *slots,
> > +				      struct kvm_memory_slot *memslot)
> > +{
> > +	struct kvm_memory_slot *mslots = slots->memslots;
> > +	int i;
> > +
> > +	if (WARN_ON(slots->id_to_index[memslot->id] == -1))
> > +		return;
> > +
> > +	slots->used_slots--;
> > +
> > +	for (i = slots->id_to_index[memslot->id]; i < slots->used_slots; i++) {
> > +		mslots[i] = mslots[i + 1];
> > +		slots->id_to_index[mslots[i].id] = i;
> > +	}
> > +	mslots[i] = *memslot;
> > +	slots->id_to_index[memslot->id] = -1;
> > +}
> > +
> > +/*
> > + * "Insert" a new memslot by incrementing the number of used slots.  Returns
> > + * the new slot's initial index into the memslots array.
> > + */
> > +static inline int kvm_memslot_insert_back(struct kvm_memslots *slots)
> 
> The naming here didn't help me to understand but a bit more
> confused...
> 
> How about "kvm_memslot_insert_end"?  Or even unwrap it.

It's not guaranteed to be the end, as there could be multiple unused
entries at the back of the array.  I agree the naming isn't perfect, but
IMO it's the least crappy option and will be familiar to anyone with C++
STL (and other languages?) experience.  Arguably it would be better to
follow kernel naming for lists, e.g. head/tail, but there are no
convenient adverbs for the move helpers, e.g. kvm_memslot_move_backward()
would be kvm_memslot_move_towards_tail().

I'm very strongly opposed to unwrapping it.

The code would look like this.  Without a beefy comment, the high level
semantics of the KVM_MR_CREATE case are not at all clear.  Adding a
comment gets messy because putting it above the entire if-else makes it
difficult to understand that its *only* for the CREATE case, and I hate
having multi-line comments in if-else statements without brackets.

                if (change == KVM_MR_CREATE)
                        i = slots->used_slots++
                else
                        i = kvm_memslot_move_backward(slots, memslot);

> > +{
> > +	return slots->used_slots++;
> > +}
> > +
> > +/*
> > + * Move a changed memslot backwards in the array by shifting existing slots
> > + * with a higher GFN toward the front of the array.  Note, the changed memslot
> > + * itself is not preserved in the array, i.e. not swapped at this time, only
> > + * its new index into the array is tracked.  Returns the changed memslot's
> > + * current index into the memslots array.
> > + */
> > +static inline int kvm_memslot_move_backward(struct kvm_memslots *slots,
> > +					    struct kvm_memory_slot *memslot)
> 
> "backward" makes me feel like it's moving towards smaller index,
> instead it's moving to bigger index.  Same applies to "forward" below.
> I'm not sure whether I'm the only one, though...

Move forward towards the front, and backward towards the back.  In the
languages I am familiar with, e.g. C++ STL, JavaScript, Python, and Golang,
front==container[0] and back==container[len() - 1].

> > +{
> > +	struct kvm_memory_slot *mslots = slots->memslots;
> > +	int i;
> > +
> > +	if (WARN_ON_ONCE(slots->id_to_index[memslot->id] == -1) ||
> > +	    WARN_ON_ONCE(!slots->used_slots))
> > +		return -1;
> > +
> > +	/*
> > +	 * Move the target memslot backward in the array by shifting existing
> > +	 * memslots with a higher GFN (than the target memslot) towards the
> > +	 * front of the array.
> > +	 */
> > +	for (i = slots->id_to_index[memslot->id]; i < slots->used_slots - 1; i++) {
> > +		if (memslot->base_gfn > mslots[i + 1].base_gfn)
> > +			break;
> > +
> > +		WARN_ON_ONCE(memslot->base_gfn == mslots[i + 1].base_gfn);
> 
> Will this trigger?  Note that in __kvm_set_memory_region() we have
> already checked overlap of memslots.

If you screw up the code it will :-)  In a perfect world, no WARN() will
*ever* trigger.  All of the added WARN_ON_ONCE() are to help the next poor
soul that wants to modify this code.
 
> > +
> > +		/* Shift the next memslot forward one and update its index. */
> > +		mslots[i] = mslots[i + 1];
> > +		slots->id_to_index[mslots[i].id] = i;
> > +	}
> > +	return i;
> > +}
> > @@ -1104,8 +1203,13 @@ int __kvm_set_memory_region(struct kvm *kvm,

...

> >  	 * when the memslots are re-sorted by update_memslots().
> >  	 */
> >  	tmp = id_to_memslot(__kvm_memslots(kvm, as_id), id);
> > -	old = *tmp;
> > -	tmp = NULL;
> 
> I was confused in that patch, then...
> 
> > +	if (tmp) {
> > +		old = *tmp;
> > +		tmp = NULL;
> 
> ... now I still don't know why it needs to set to NULL?

To make it abundantly clear that though shall not use @tmp, i.e. to force
using the copy and not the pointer.  Note, @tmp is also reused as an
iterator below.

> 
> > +	} else {
> > +		memset(&old, 0, sizeof(old));
> > +		old.id = id;
> > +	}
> >  
> >  	if (!mem->memory_size)
> >  		return kvm_delete_memslot(kvm, mem, &old, as_id);
> > @@ -1223,7 +1327,7 @@ int kvm_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log,
> >  
> >  	slots = __kvm_memslots(kvm, as_id);
> >  	*memslot = id_to_memslot(slots, id);
> > -	if (!(*memslot)->dirty_bitmap)
> > +	if (!(*memslot) || !(*memslot)->dirty_bitmap)
> >  		return -ENOENT;
> >  
> >  	kvm_arch_sync_dirty_log(kvm, *memslot);
> > @@ -1281,10 +1385,10 @@ static int kvm_get_dirty_log_protect(struct kvm *kvm, struct kvm_dirty_log *log)
> >  
> >  	slots = __kvm_memslots(kvm, as_id);
> >  	memslot = id_to_memslot(slots, id);
> > +	if (!memslot || !memslot->dirty_bitmap)
> > +		return -ENOENT;
> >  
> >  	dirty_bitmap = memslot->dirty_bitmap;
> > -	if (!dirty_bitmap)
> > -		return -ENOENT;
> >  
> >  	kvm_arch_sync_dirty_log(kvm, memslot);
> >  
> > @@ -1392,10 +1496,10 @@ static int kvm_clear_dirty_log_protect(struct kvm *kvm,
> >  
> >  	slots = __kvm_memslots(kvm, as_id);
> >  	memslot = id_to_memslot(slots, id);
> > +	if (!memslot || !memslot->dirty_bitmap)
> > +		return -ENOENT;
> >  
> >  	dirty_bitmap = memslot->dirty_bitmap;
> > -	if (!dirty_bitmap)
> > -		return -ENOENT;
> >  
> >  	n = ALIGN(log->num_pages, BITS_PER_LONG) / 8;
> >  
> > -- 
> > 2.24.1
> > 
> 
> -- 
> Peter Xu
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
