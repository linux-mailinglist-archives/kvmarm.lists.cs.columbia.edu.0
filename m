Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 94D291F6B68
	for <lists+kvmarm@lfdr.de>; Thu, 11 Jun 2020 17:46:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1F8634B1A6;
	Thu, 11 Jun 2020 11:46:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BdWCSMzXpIZQ; Thu, 11 Jun 2020 11:46:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B37D4B1A2;
	Thu, 11 Jun 2020 11:46:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 024084B192
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jun 2020 11:46:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JdhxYHNt0MfF for <kvmarm@lists.cs.columbia.edu>;
 Thu, 11 Jun 2020 11:46:17 -0400 (EDT)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BFE894B17F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 11 Jun 2020 11:46:16 -0400 (EDT)
IronPort-SDR: jZSN9fbOd/1CSNvOkmEhMsJOhhJnYFEaxu97pE0bzwP8iKx0Lchfwqig0rFI22kd+T5RFKwIr0
 eTZXJ499Qifw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 08:46:16 -0700
IronPort-SDR: 3iKlFSNmGLJIQjG6i4tV9DKlsjIjo/kGZ/UFziPeMJdfG9W3E92AKxhhodHCTS+EuQk+hqoqc0
 jidNOjbX/9Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; d="scan'208";a="419145052"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com)
 ([10.54.74.152])
 by orsmga004.jf.intel.com with ESMTP; 11 Jun 2020 08:46:15 -0700
Date: Thu, 11 Jun 2020 08:46:15 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 18/21] KVM: arm64: Use common KVM implementation of MMU
 memory caches
Message-ID: <20200611154615.GG29918@linux.intel.com>
References: <20200605213853.14959-1-sean.j.christopherson@intel.com>
 <20200605213853.14959-19-sean.j.christopherson@intel.com>
 <3555daf3b38c890e1e74f05d6f49f9be@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3555daf3b38c890e1e74f05d6f49f9be@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Ben Gardon <bgardon@google.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Janosch Frank <frankja@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Junaid Shahid <junaids@google.com>, kvm-ppc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Shier <pshier@google.com>,
 linux-mips@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Peter Feiner <pfeiner@google.com>
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

On Thu, Jun 11, 2020 at 09:01:44AM +0100, Marc Zyngier wrote:
> On 2020-06-05 22:38, Sean Christopherson wrote:

...

> >@@ -1024,7 +993,7 @@ static pud_t *stage2_get_pud(struct kvm *kvm,
> >struct kvm_mmu_memory_cache *cache
> > 	if (stage2_pgd_none(kvm, *pgd)) {
> > 		if (!cache)
> > 			return NULL;
> >-		pud = mmu_memory_cache_alloc(cache);
> >+		pud = kvm_mmu_memory_cache_alloc(cache);
> > 		stage2_pgd_populate(kvm, pgd, pud);
> > 		get_page(virt_to_page(pgd));
> > 	}
> 
> Quick note: this patch (as it is) breaks on arm64 due to Mike Rapoport's
> P4D rework. I've fixed it locally in order to test the series.

Good to know, I'll wait to send v2 until that gets pulled into Paolo's tree.
Thanks for the heads up, and especially for testing!
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
