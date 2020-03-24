Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F2F20190341
	for <lists+kvmarm@lfdr.de>; Tue, 24 Mar 2020 02:19:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 702874B0CA;
	Mon, 23 Mar 2020 21:19:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@ozlabs.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zd1L9wJBcaFK; Mon, 23 Mar 2020 21:19:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 495A94B099;
	Mon, 23 Mar 2020 21:19:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C78554B08E
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Mar 2020 21:19:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0yvpbxaGgmP0 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 23 Mar 2020 21:19:02 -0400 (EDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4B4614A4FC
 for <kvmarm@lists.cs.columbia.edu>; Mon, 23 Mar 2020 21:19:02 -0400 (EDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 48mYL92hc1z9sSL; Tue, 24 Mar 2020 12:18:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1585012737; bh=fWyvQjgmoVE45UQb8yBNTXiPed69yDbrhs5hdq0egsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mauSiS7oX6+4B1f4axm7Ayy0Hc0K4hbGipg06Vcls1bvNoep91a4i3dcGDcZKVpTJ
 xQC/JEjuilfLaSd1tD8NcDipXJjAbo7uhRcrYKD9LE8of4vea9QfKCKUAAkkdF/Uz7
 Dm7c/6XLcWYDVEm/PsidIOCTDafYwb4ENnFnDtX0zf2M52X8TbyUepK8RCjm3hj5Lu
 u8f6BSKtFagIKKzXfDcwdZegidVRR/Rw5iEGwGP+42XDZ08MSFz0spgTcZk9vvMJUq
 WBwqbuf0TPBzwB0coc1LPf1cCR+z4iTVCk1La6TvnzTrCQ1Bv8TD6+qUuXAoP37xGr
 j9GwIDroxtTsA==
Date: Tue, 24 Mar 2020 12:18:54 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 1/9] KVM: Pass kvm_init()'s opaque param to additional
 arch funcs
Message-ID: <20200324011854.GC5604@blackberry>
References: <20200321202603.19355-1-sean.j.christopherson@intel.com>
 <20200321202603.19355-2-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200321202603.19355-2-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Wanpeng Li <wanpengli@tencent.com>, Janosch Frank <frankja@linux.ibm.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
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

On Sat, Mar 21, 2020 at 01:25:55PM -0700, Sean Christopherson wrote:
> Pass @opaque to kvm_arch_hardware_setup() and
> kvm_arch_check_processor_compat() to allow architecture specific code to
> reference @opaque without having to stash it away in a temporary global
> variable.  This will enable x86 to separate its vendor specific callback
> ops, which are passed via @opaque, into "init" and "runtime" ops without
> having to stash away the "init" ops.
> 
> No functional change intended.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Tested-by: Cornelia Huck <cohuck@redhat.com> #s390
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
