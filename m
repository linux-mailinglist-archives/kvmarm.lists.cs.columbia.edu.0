Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9387922A8D7
	for <lists+kvmarm@lfdr.de>; Thu, 23 Jul 2020 08:21:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 089FA4B34B;
	Thu, 23 Jul 2020 02:21:27 -0400 (EDT)
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
	with ESMTP id fk2e07K32M-G; Thu, 23 Jul 2020 02:21:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 03F5F4B343;
	Thu, 23 Jul 2020 02:21:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D57B44B33F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jul 2020 02:21:24 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1skmhKXCn52a for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Jul 2020 02:21:23 -0400 (EDT)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8BD324B337
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Jul 2020 02:21:23 -0400 (EDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4BC2KB5s0qz9sSJ; Thu, 23 Jul 2020 16:21:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1595485278; bh=IFTCm6zcqf516abhJ4Sn7meDBWdJj/FMmew567e6yPo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QHrs12kseRVGEX+ozdM7Bk6vM8hN0rntxzjRAXDLPJB5+D4I5trx8JLVKEGr+HWlW
 Mj63kCsmYQo/uJVxEQyo6xy71+qys9EPiyUnLS0wybJYnvAxhe3k+ZSJ+U2csi6dEv
 m4p3ywW83Fc4+QdjQ8081sBvInO0dflWfc+rdmby+iEWn07BdpvNwnJNhl+BoXRUko
 PGFpiYQvGK+7m6HjKWHrkG4zVYjQaSTJZBb90cqJYr+EdFmgz1kCMJiQLPN4BTwuys
 wW2IRygLknjUHpNpoWgw1D7M2qtPhMQU14/2XHHACcZE0i5VV9A13lZCYY5BQd0UY8
 9ybHPfknMp5Lg==
Date: Thu, 23 Jul 2020 16:19:04 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH v6 3/5] KVM: PPC: clean up redundant kvm_run parameters
 in assembly
Message-ID: <20200723061904.GC213782@thinks.paulus.ozlabs.org>
References: <20200623131418.31473-1-tianjia.zhang@linux.alibaba.com>
 <20200623131418.31473-4-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623131418.31473-4-tianjia.zhang@linux.alibaba.com>
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

On Tue, Jun 23, 2020 at 09:14:16PM +0800, Tianjia Zhang wrote:
> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
> structure. For historical reasons, many kvm-related function parameters
> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
> patch does a unified cleanup of these remaining redundant parameters.

Thanks, patch applied to my kvm-ppc-next branch, with fixes.

Paul.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
