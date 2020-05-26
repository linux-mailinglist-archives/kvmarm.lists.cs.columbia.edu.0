Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE11E1ADE
	for <lists+kvmarm@lfdr.de>; Tue, 26 May 2020 07:59:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B6AC74B26E;
	Tue, 26 May 2020 01:59:36 -0400 (EDT)
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
	with ESMTP id UPDSa44ado5F; Tue, 26 May 2020 01:59:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 94DDC4B24A;
	Tue, 26 May 2020 01:59:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0EC614B249
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 01:59:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1e9EPC91O9b0 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 26 May 2020 01:59:34 -0400 (EDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0ABFA4B241
 for <kvmarm@lists.cs.columbia.edu>; Tue, 26 May 2020 01:59:33 -0400 (EDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49WNZn11tSz9sRY; Tue, 26 May 2020 15:59:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1590472769; bh=UvsMjZEYjC+bU7cDuBcQ49xsO8s4tc7S4Vm5YquVl3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dr7/DCW1ueRx4rYAQYErFOviGddLWKlo5BpU5HFciy9CJet5sWJEf2BjRFaWIfdr8
 exnM7o9NB/Edk/VdBss9/EVVuN4f8bDfV11zfFBbmNSYetArbeqDrPhOe9n7g0jy2w
 jPlaaGtU/Bys9q0B1FhwBdGuQzbxpZlMef7Omzw1nQCaKfe0sUl0HzmqRRaLXCiNsq
 9mwubjD8MVwaThkdXmLYOSbANn8EQAl66FmLO02dquKK/12GEHaZ8qqqsY5MwEIHvQ
 CTVrP2oC3cIqV5tanqXHRykuANp24K+isJl9f5Ks+0pA8PSIeFjFgqi3fPTEglfkPk
 PJf2vvuHBAlag==
Date: Tue, 26 May 2020 15:49:50 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH v4 4/7] KVM: PPC: clean up redundant 'kvm_run' parameters
Message-ID: <20200526054950.GC282305@thinks.paulus.ozlabs.org>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-5-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427043514.16144-5-tianjia.zhang@linux.alibaba.com>
Cc: wanpengli@tencent.com, kvm@vger.kernel.org, david@redhat.com,
 benh@kernel.crashing.org, heiko.carstens@de.ibm.com,
 linux-mips@vger.kernel.org, hpa@zytor.com, kvmarm@lists.cs.columbia.edu,
 linux-s390@vger.kernel.org, frankja@linux.ibm.com, chenhuacai@gmail.com,
 maz@kernel.org, joro@8bytes.org, x86@kernel.org, borntraeger@de.ibm.com,
 mingo@redhat.com, thuth@redhat.com, gor@linux.ibm.com, kvm-ppc@vger.kernel.org,
 bp@alien8.de, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 jmattson@google.com, tsbogend@alpha.franken.de, cohuck@redhat.com,
 sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, pbonzini@redhat.com, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
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

On Mon, Apr 27, 2020 at 12:35:11PM +0800, Tianjia Zhang wrote:
> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
> structure. For historical reasons, many kvm-related function parameters
> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
> patch does a unified cleanup of these remaining redundant parameters.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

This looks OK, though possibly a little larger than it needs to be
because of variable name changes (kvm_run -> run) that aren't strictly
necessary.

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
