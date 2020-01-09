Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4E166136234
	for <lists+kvmarm@lfdr.de>; Thu,  9 Jan 2020 22:05:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B8BAD4B1ED;
	Thu,  9 Jan 2020 16:05:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eBdoZExXYFWO; Thu,  9 Jan 2020 16:05:10 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B58154B1D8;
	Thu,  9 Jan 2020 16:05:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CD8124B1C2
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Jan 2020 16:05:08 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y5H1Aye+iKwL for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Jan 2020 16:05:07 -0500 (EST)
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6E1F44B1C0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Jan 2020 16:05:07 -0500 (EST)
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1ipez7-0008OC-Ij; Thu, 09 Jan 2020 22:04:53 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id 0AA1A105BCE; Thu,  9 Jan 2020 22:04:53 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sean Christopherson <sean.j.christopherson@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/14] x86/mm: Introduce lookup_address_in_mm()
In-Reply-To: <20200108202448.9669-6-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <20200108202448.9669-6-sean.j.christopherson@intel.com>
Date: Thu, 09 Jan 2020 22:04:53 +0100
Message-ID: <871rs8batm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>,
 linux-mm@kvack.org, kvmarm@lists.cs.columbia.edu,
 Dave Jiang <dave.jiang@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com,
 Barret Rhoden <brho@google.com>, kvm-ppc@vger.kernel.org,
 Liran Alon <liran.alon@oracle.com>, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Jason Zeng <jason.zeng@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
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

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index b5e49e6bac63..400ac8da75e8 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -561,6 +561,10 @@ static inline void update_page_count(int level, unsigned long pages) { }
>  extern pte_t *lookup_address(unsigned long address, unsigned int *level);
>  extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>  				    unsigned int *level);
> +
> +struct mm_struct;
> +pte_t *lookup_address_in_mm(struct mm_struct *mm, unsigned long address,
> +			    unsigned int *level);

Please keep the file consistent and use extern even if not required.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
