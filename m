Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBDEA56AD
	for <lists+kvmarm@lfdr.de>; Mon,  2 Sep 2019 14:53:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B8984A590;
	Mon,  2 Sep 2019 08:53:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLzmm5dym4us; Mon,  2 Sep 2019 08:53:08 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B1E034A576;
	Mon,  2 Sep 2019 08:53:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 47D764A53F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Sep 2019 08:53:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v+QYXMNYKajZ for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Sep 2019 08:53:00 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D0CB64A50F
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Sep 2019 08:53:00 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA6F9190C004;
 Mon,  2 Sep 2019 12:52:59 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A723E608AB;
 Mon,  2 Sep 2019 12:52:56 +0000 (UTC)
Date: Mon, 2 Sep 2019 14:52:54 +0200
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v4 01/10] KVM: arm64: Document PV-time interface
Message-ID: <20190902125254.3w6lnvcbs7sfhjz7@kamzik.brq.redhat.com>
References: <20190830084255.55113-1-steven.price@arm.com>
 <20190830084255.55113-2-steven.price@arm.com>
 <20190830144734.kvj4dvt32qzmhw32@kamzik.brq.redhat.com>
 <7f459290-9c39-cfba-c514-a07469ff120f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f459290-9c39-cfba-c514-a07469ff120f@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 02 Sep 2019 12:53:00 +0000 (UTC)
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

On Fri, Aug 30, 2019 at 04:25:08PM +0100, Steven Price wrote:
> On 30/08/2019 15:47, Andrew Jones wrote:
> > On Fri, Aug 30, 2019 at 09:42:46AM +0100, Steven Price wrote:
> >> Introduce a paravirtualization interface for KVM/arm64 based on the
> >> "Arm Paravirtualized Time for Arm-Base Systems" specification DEN 0057A.
> >>
> >> This only adds the details about "Stolen Time" as the details of "Live
> >> Physical Time" have not been fully agreed.
> >>
> >> User space can specify a reserved area of memory for the guest and
> >> inform KVM to populate the memory with information on time that the host
> >> kernel has stolen from the guest.
> >>
> >> A hypercall interface is provided for the guest to interrogate the
> >> hypervisor's support for this interface and the location of the shared
> >> memory structures.
> >>
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> ---
> >>  Documentation/virt/kvm/arm/pvtime.txt   | 64 +++++++++++++++++++++++++
> >>  Documentation/virt/kvm/devices/vcpu.txt | 14 ++++++
> >>  2 files changed, 78 insertions(+)
> >>  create mode 100644 Documentation/virt/kvm/arm/pvtime.txt
> >>
> >> diff --git a/Documentation/virt/kvm/arm/pvtime.txt b/Documentation/virt/kvm/arm/pvtime.txt
> >> new file mode 100644
> >> index 000000000000..dda3f0f855b9
> >> --- /dev/null
> >> +++ b/Documentation/virt/kvm/arm/pvtime.txt
> >> @@ -0,0 +1,64 @@
> >> +Paravirtualized time support for arm64
> >> +======================================
> >> +
> >> +Arm specification DEN0057/A defined a standard for paravirtualised time
> >> +support for AArch64 guests:
> >> +
> >> +https://developer.arm.com/docs/den0057/a
> >> +
> >> +KVM/arm64 implements the stolen time part of this specification by providing
> >> +some hypervisor service calls to support a paravirtualized guest obtaining a
> >> +view of the amount of time stolen from its execution.
> >> +
> >> +Two new SMCCC compatible hypercalls are defined:
> >> +
> >> +PV_FEATURES 0xC5000020
> >> +PV_TIME_ST  0xC5000022
> >> +
> >> +These are only available in the SMC64/HVC64 calling convention as
> >> +paravirtualized time is not available to 32 bit Arm guests. The existence of
> >> +the PV_FEATURES hypercall should be probed using the SMCCC 1.1 ARCH_FEATURES
> >> +mechanism before calling it.
> >> +
> >> +PV_FEATURES
> >> +    Function ID:  (uint32)  : 0xC5000020
> >> +    PV_func_id:   (uint32)  : Either PV_TIME_LPT or PV_TIME_ST
> > 
> > PV_TIME_LPT doesn't exist
> 
> Thanks, will remove.
> 
> >> +    Return value: (int32)   : NOT_SUPPORTED (-1) or SUCCESS (0) if the relevant
> >> +                              PV-time feature is supported by the hypervisor.
> >> +
> >> +PV_TIME_ST
> >> +    Function ID:  (uint32)  : 0xC5000022
> >> +    Return value: (int64)   : IPA of the stolen time data structure for this
> >> +                              VCPU. On failure:
> >> +                              NOT_SUPPORTED (-1)
> >> +
> >> +The IPA returned by PV_TIME_ST should be mapped by the guest as normal memory
> >> +with inner and outer write back caching attributes, in the inner shareable
> >> +domain. A total of 16 bytes from the IPA returned are guaranteed to be
> >> +meaningfully filled by the hypervisor (see structure below).
> >> +
> >> +PV_TIME_ST returns the structure for the calling VCPU.
> >> +
> >> +Stolen Time
> >> +-----------
> >> +
> >> +The structure pointed to by the PV_TIME_ST hypercall is as follows:
> >> +
> >> +  Field       | Byte Length | Byte Offset | Description
> >> +  ----------- | ----------- | ----------- | --------------------------
> >> +  Revision    |      4      |      0      | Must be 0 for version 0.1
> >> +  Attributes  |      4      |      4      | Must be 0
> > 
> > The above fields don't appear to be exposed to userspace in anyway. How
> > will we handle migration from one KVM with one version of the structure
> > to another?
> 
> Interesting question. User space does have access to them now it is
> providing the memory, but it's not exactly an easy method. In particular
> user space has no (simple) way of probing the kernel's supported version.
> 
> I guess one solution would be to add an extra attribute on the VCPU
> which would provide the revision information. The current kernel would
> then reject any revision other than 0, but this could then be extended
> to support other revision numbers in the future.
> 
> Although there's some logic in saying we could add the extra attribute
> when(/if) there is a new version. Future kernels would then be expected
> to use the current version unless user space explicitly set the new
> attribute.
> 
> Do you feel this is something that needs to be addressed now, or can it
> be deferred until another version is proposed?

Assuming we'll want userspace to have the option of choosing version=0,
and that we're fine with version=0 being the implicit choice, when nothing
is selected, then I guess it can be left as is for now. If, OTOH, we just
want migration to fail when attempting to migrate to another host with
an incompatible stolen-time structure (i.e. version=0 is not selectable
on hosts that implement later versions), then we should expose the version
in some way now. Perhaps a VCPU's "PV config" should be described in a
set of pseudo registers?

> 
> >> +  Stolen time |      8      |      8      | Stolen time in unsigned
> >> +              |             |             | nanoseconds indicating how
> >> +              |             |             | much time this VCPU thread
> >> +              |             |             | was involuntarily not
> >> +              |             |             | running on a physical CPU.
> >> +
> >> +The structure will be updated by the hypervisor prior to scheduling a VCPU. It
> >> +will be present within a reserved region of the normal memory given to the
> >> +guest. The guest should not attempt to write into this memory. There is a
> >> +structure per VCPU of the guest.
> > 
> > Should we provide a recommendation as to how that reserved memory is
> > provided? One memslot divided into NR_VCPUS subregions? Should the
> > reserved region be described to the guest kernel with DT/ACPI? Or
> > should userspace ensure the region is not within any DT/ACPI described
> > regions?
> 
> I'm open to providing a recommendation, but I'm not entirely sure I know
> enough here to provide one.
> 
> There is an obvious efficiency argument for minimizing memslots with the
> current code. But if someone has a reason for using multiple memslots
> then that's probably a good argument for implementing a memslot-caching
> kvm_put_user() rather than to be dis-recommended.

Actually even if a single memslot is used for all the PV structures for
all VCPUs, but it's separate from the slot(s) used for main memory, then
we'll likely see performance issues with memslot searches (even though
it's a binary search). This is because memslots already have caching. The
last used slot is stored in the memslots' lru_slot member (the "lru" name
is confusing, but it means "last used" somehow). This means we could get
thrashing on that slot cache if we're searching for the PV structure
memslot on each vcpu load after searching for the main memory slot on each
page fault.

> 
> My assumption (and testing) has been with a single memslot divided into
> NR_VCPUS (or more accurately the number of VCPUs in the VM) subregions.
> 
> For testing DT I've tested both methods: an explicit reserved region or
> just ensuring it's not in any DT described region. Both seem reasonable,
> but it might be easier to integrate into existing migration mechanisms
> if it's simply a reserved region (then the memory block of the guest is
> just as it always was).
> 
> For ACPI the situation should be similar, but my testing has been with DT.

I also can't think of any reason why we'd have to describe it in DT/ACPI,
but I get this feeling that if we don't, then we'll hit some issue that
will make us wish we had...

Thanks,
drew
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
