Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 829E6B7009
	for <lists+kvmarm@lfdr.de>; Thu, 19 Sep 2019 02:23:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF1684A688;
	Wed, 18 Sep 2019 20:23:43 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@ozlabs.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPPr+fmGRxBz; Wed, 18 Sep 2019 20:23:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B78EB4A685;
	Wed, 18 Sep 2019 20:23:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D53104A67B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Sep 2019 20:23:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tLyq4TlooYS7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Sep 2019 20:23:38 -0400 (EDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E2E084A679
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Sep 2019 20:23:37 -0400 (EDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 46YcyX6FPFz9sNF; Thu, 19 Sep 2019 10:23:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1568852612; bh=cw3bVSIKyGLl8fd6W8ykuEcHQm9lvtEQ4ISh1Suv21A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R3NvO9RHRrBeHenKeGVQwRwaNzl90QJKU91Oh5UtKsnjPccYcuWsO/+sjMOyqwX7L
 qXGlMsp052mihy0ZJJ2eIVJLqlRGa9kQM/LgVKA7ED5dZy2xxDU0F7hWJ5Tp54i1Oj
 k55td7N92nS1j9aJa2rikaxwZ/Rett3ejrVCl2Y6XgJzt/d7qDn+ismHBncyRTAYV+
 hS8OCe+151b9IycINykjKDkPYC/8MG9vZUkPbnlESnKeZ09ZuP4shL0f/tklBl/8Uc
 RZALg8LGgjsbVJ+XmBlldREITO6j39TWleHK6T7JSCMg1LLpCOuW1Dvvlzw9Z/mO8v
 uxbb98hT109Jg==
Date: Thu, 19 Sep 2019 10:23:28 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 02/13] KVM: PPC: Move memslot memory allocation into
 prepare_memory_region()
Message-ID: <20190919002328.GB19503@blackberry>
References: <20190911185038.24341-1-sean.j.christopherson@intel.com>
 <20190911185038.24341-3-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190911185038.24341-3-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Cornelia Huck <cohuck@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Hildenbrand <david@redhat.com>,
 linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
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

On Wed, Sep 11, 2019 at 11:50:27AM -0700, Sean Christopherson wrote:
> Allocate the rmap array during kvm_arch_prepare_memory_region() to pave
> the way for removing kvm_arch_create_memslot() altogether.  Moving PPC's
> memory allocation only changes the order of kernel memory allocations
> between PPC and common KVM code.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Seems OK.

Acked-by: Paul Mackerras <paulus@ozlabs.org>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
