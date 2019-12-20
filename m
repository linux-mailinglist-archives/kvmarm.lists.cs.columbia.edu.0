Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE112802B
	for <lists+kvmarm@lfdr.de>; Fri, 20 Dec 2019 16:56:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03A5C4AC07;
	Fri, 20 Dec 2019 10:56:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zzkSduCunPpr; Fri, 20 Dec 2019 10:56:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C1BFD4A8E0;
	Fri, 20 Dec 2019 10:56:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 799964A586
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 10:56:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xz8vr3NuLjOx for <kvmarm@lists.cs.columbia.edu>;
 Fri, 20 Dec 2019 10:56:09 -0500 (EST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 41E734A523
 for <kvmarm@lists.cs.columbia.edu>; Fri, 20 Dec 2019 10:56:09 -0500 (EST)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2019 07:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; d="scan'208";a="241535997"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.202])
 by fmsmga004.fm.intel.com with ESMTP; 20 Dec 2019 07:56:07 -0800
Date: Fri, 20 Dec 2019 07:56:07 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 35/45] KVM: s390: Manually invoke vcpu setup during
 kvm_arch_vcpu_create()
Message-ID: <20191220155607.GB20453@linux.intel.com>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
 <20191218215530.2280-36-sean.j.christopherson@intel.com>
 <20191220110445.3a42041a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191220110445.3a42041a.cohuck@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Wanpeng Li <wanpengli@tencent.com>, Janosch Frank <frankja@linux.ibm.com>,
 kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Hildenbrand <david@redhat.com>,
 linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>,
 linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>,
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

On Fri, Dec 20, 2019 at 11:04:45AM +0100, Cornelia Huck wrote:
> On Wed, 18 Dec 2019 13:55:20 -0800
> Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> 
> > Rename kvm_arch_vcpu_setup() to kvm_s390_vcpu_setup() and manually call
> > the new function during kvm_arch_vcpu_create().  Define an empty
> > kvm_arch_vcpu_setup() as it's still required for compilation.  This
> > is effectively a nop as kvm_arch_vcpu_create() and kvm_arch_vcpu_setup()
> > are called back-to-back by common KVM code.  Obsoleting
> > kvm_arch_vcpu_setup() paves the way for its removal.
> > 
> > Note, gmap_remove() is now called if setup fails, as s390 was previously
> > freeing it via kvm_arch_vcpu_destroy(), which is called by common KVM
> > code if kvm_arch_vcpu_setup() fails.
> 
> Yes, this looks like the only thing that needs to be undone
> (sca_add_vcpu() is done later in the process.)
> 
> Maybe mention that gmap_remove() is for ucontrol only? I was confused
> for a moment :)

Will do.

Would it also make sense to open code __kvm_ucontrol_vcpu_init() in a
separate patch immediately preceding this change?  That'd make it a little
more obvious why gmap_remove() is called, and it would eliminate the
"uninit" verbiage in the label, e.g.:

        if (kvm_is_ucontrol(vcpu->kvm)) {
                vcpu->arch.gmap = gmap_create(current->mm, -1UL);
                if (!vcpu->arch.gmap) {
                        rc = -ENOMEM;
                        goto out_free_sie_block;
                }
                vcpu->arch.gmap->private = vcpu->kvm;
        }

        VM_EVENT(kvm, 3, "create cpu %d at 0x%pK, sie block at 0x%pK", id, vcpu,
                 vcpu->arch.sie_block);
        trace_kvm_s390_create_vcpu(id, vcpu, vcpu->arch.sie_block);

        rc = kvm_s390_vcpu_setup(vcpu);
        if (rc)
                goto out_free_ucontrol_gmap;
        return 0;

out_free_ucontrol_gmap:
        if (kvm_is_ucontrol(vcpu->kvm))
                gmap_remove(vcpu->arch.gmap);
out_free_sie_block:
        free_page((unsigned long)(vcpu->arch.sie_block));
        return rc;
}

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
