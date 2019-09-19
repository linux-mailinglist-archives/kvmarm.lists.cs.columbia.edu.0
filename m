Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCF9B700A
	for <lists+kvmarm@lfdr.de>; Thu, 19 Sep 2019 02:23:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DD8B64A693;
	Wed, 18 Sep 2019 20:23:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@ozlabs.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8FIgW9kBRVLX; Wed, 18 Sep 2019 20:23:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF7374A6A3;
	Wed, 18 Sep 2019 20:23:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D3C4A4A67A
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Sep 2019 20:23:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wBej4gfj6CuG for <kvmarm@lists.cs.columbia.edu>;
 Wed, 18 Sep 2019 20:23:38 -0400 (EDT)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CB0214A5FF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 18 Sep 2019 20:23:37 -0400 (EDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 46YcyX5cBKz9sNf; Thu, 19 Sep 2019 10:23:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1568852612; bh=cu6MqzQ+Jjg6jBgAMHqPfsdtuEEEpXwelfg4ezvXdsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nt4NYXLQPNaOq5EaXwA6J6CUQqtE4sYHQnvkHZSOhCjqqWJ01CdAB4tfDaD7elmpm
 n8+n+jy0vrYBX7bhjUejT61fggDfeR0cgCIUnTuqNkpIC0IXNlLj5BQyxdJITIPcBR
 mnSFYsZrVTQqPYzswqowK1En17cvpVKAST5slijgNdV7bpZykh7hDKsvP4WJVNLb/9
 Ol1XIqjO/OL2LCmIx/vGzkgBlQMKHpTE8RacF1q2tw33WNlisVf3Zmdf+cisE74bOX
 ghUTBd1CuYuzqzcB8Zaw4KJe2JcyTf9IC7kOu6x2wrhVjXAyrW69MyKAvq+7wse73h
 GRj1zPawfFkIQ==
Date: Thu, 19 Sep 2019 10:22:42 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 10/13] KVM: Provide common implementation for generic
 dirty log functions
Message-ID: <20190919002242.GA19503@blackberry>
References: <20190911185038.24341-1-sean.j.christopherson@intel.com>
 <20190911185038.24341-11-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190911185038.24341-11-sean.j.christopherson@intel.com>
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

On Wed, Sep 11, 2019 at 11:50:35AM -0700, Sean Christopherson wrote:
> Move the implementations of KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG
> for CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT into common KVM code.
> The arch specific implemenations are extremely similar, differing
> only in whether the dirty log needs to be sync'd from hardware (x86)
> and how the TLBs are flushed.  Add new arch hooks to handle sync
> and TLB flush; the sync will also be used for non-generic dirty log
> support in a future patch (s390).
> 
> The ulterior motive for providing a common implementation is to
> eliminate the dependency between arch and common code with respect to
> the memslot referenced by the dirty log, i.e. to make it obvious in the
> code that the validity of the memslot is guaranteed, as a future patch
> will rework memslot handling such that id_to_memslot() can return NULL.

I notice you add empty definitions of kvm_arch_sync_dirty_log() for
PPC, both Book E and Book 3S.  Given that PPC doesn't select
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT, why is this necessary?

Paul.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
