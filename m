Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F63CCC3
	for <lists+kvmarm@lfdr.de>; Tue, 11 Jun 2019 15:15:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C93E24A520;
	Tue, 11 Jun 2019 09:15:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pZXbrolwhkAZ; Tue, 11 Jun 2019 09:15:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 70DE54A51A;
	Tue, 11 Jun 2019 09:15:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 412784A510
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 09:15:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L+Jty6aiwAmH for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 Jun 2019 09:15:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D30B4A4EE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 Jun 2019 09:15:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1289D346;
 Tue, 11 Jun 2019 06:15:01 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31F8E3F557;
 Tue, 11 Jun 2019 06:14:59 -0700 (PDT)
Subject: Re: [PATCH v8 26/29] vfio-pci: Register an iommu fault handler
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20190526161004.25232-1-eric.auger@redhat.com>
 <20190526161004.25232-27-eric.auger@redhat.com>
 <20190603163139.70fe8839@x1.home>
 <10dd60d9-4af0-c0eb-08c9-a0db7ee1925e@redhat.com>
 <20190605154553.0d00ad8d@jacob-builder>
 <2753d192-1c46-d78e-c425-0c828e48cde2@arm.com>
 <20190606132903.064f7ac4@jacob-builder>
 <dc051424-67d7-02ff-9b8e-0d7a8a4e59eb@arm.com>
 <20190607104301.6b1bbd74@jacob-builder>
 <e02b024f-6ebc-e8fa-c30c-5bf3f4b164d6@arm.com>
 <20190610143134.7bff96e9@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <905f130b-02dc-6971-8d5b-ce87d9bc96a4@arm.com>
Date: Tue, 11 Jun 2019 14:14:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610143134.7bff96e9@jacob-builder>
Content-Language: en-US
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 Vincent Stehle <Vincent.Stehle@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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

On 10/06/2019 22:31, Jacob Pan wrote:
> On Mon, 10 Jun 2019 13:45:02 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 07/06/2019 18:43, Jacob Pan wrote:
>>>>> So it seems we agree on the following:
>>>>> - iommu_unregister_device_fault_handler() will never fail
>>>>> - iommu driver cleans up all pending faults when handler is
>>>>> unregistered
>>>>> - assume device driver or guest not sending more page response
>>>>> _after_ handler is unregistered.
>>>>> - system will tolerate rare spurious response
>>>>>
>>>>> Sounds right?    
>>>>
>>>> Yes, I'll add that to the fault series  
>>> Hold on a second please, I think we need more clarifications. Ashok
>>> pointed out to me that the spurious response can be harmful to other
>>> devices when it comes to mdev, where PRQ group id is not per PASID,
>>> device may reuse the group number and receiving spurious page
>>> response can confuse the entire PF.   
>>
>> I don't understand how mdev differs from the non-mdev situation (but I
>> also still don't fully get how mdev+PASID will be implemented). Is the
>> following the case you're worried about?
>>
>>   M#: mdev #
>>
>> # Dev         Host        mdev drv       VFIO/QEMU        Guest
>> ====================================================================
>> 1                     <- reg(handler)
>> 2 PR1 G1 P1    ->         M1 PR1 G1        inject ->     M1 PR1 G1
>> 3                     <- unreg(handler)
>> 4       <- PS1 G1 P1 (F)      |
>> 5                        unreg(handler)
>> 6                     <- reg(handler)
>> 7 PR2 G1 P1    ->         M2 PR2 G1        inject ->     M2 PR2 G1
>> 8                                                     <- M1 PS1 G1
>> 9         accept ??    <- PS1 G1 P1
>> 10                                                    <- M2 PS2 G1
>> 11        accept       <- PS2 G1 P1
>>
> Not really. I am not worried about PASID reuse or unbind. Just within
> the same PASID bind lifetime of a single mdev, back to back
> register/unregister fault handler.
> After Step 4, device will think G1 is done. Device could reuse G1 for
> the next PR, if we accept PS1 in step 9, device will terminate G1 before
> the real G1 PS arrives in Step 11. The real G1 PS might have a
> different response code. Then we just drop the PS in Step 11?

Yes, I think we do. Two possibilities:

* G1 is reused at step 7 for the same PASID context, which means that it
is for the same mdev. The problem is then identical to the non-mdev
case, new page faults and old page response may cross:

# Dev         Host        mdev drv       VFIO/QEMU        Guest
====================================================================
7 PR2 G1 P1  --.
8               \                         .------------- M1 PS1 G1
9                '----->  PR2 G1 P1  ->  /   inject  --> M1 PR2 G1
10           accept <---  PS1 G1 P1  <--'
11           reject <---  PS2 G1 P1  <------------------ M1 PS2 G1

And the incorrect page response is returned to the guest. However it
affects a single mdev/guest context, it doesn't affect other mdevs.

* Or G1 is reused at step 7 for a different PASID. At step 10 the fault
handler rejects the page response because the PASID is different, and
step 11 is accepted.


>>> Having spurious page response is also not
>>> abiding the PCIe spec. exactly.  
>>
>> We are following the PCI spec though, in that we don't send page
>> responses for PRGIs that aren't in flight.
>>
> You are right, the worst case of the spurious PS is to terminate the
> group prematurely. Need to know the scope of the HW damage in case of mdev
> where group IDs can be shared among mdevs belong to the same PF.

But from the IOMMU fault API point of view, the full page request is
identified by both PRGI and PASID. Given that each mdev has its own set
of PASIDs, it should be easy to isolate page responses per mdev.

Thanks,
Jean
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
