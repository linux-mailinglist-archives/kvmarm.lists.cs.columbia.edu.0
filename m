Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 74C814180DD
	for <lists+kvmarm@lfdr.de>; Sat, 25 Sep 2021 11:50:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CD1204B0B9;
	Sat, 25 Sep 2021 05:50:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRG0S+5kGBrb; Sat, 25 Sep 2021 05:50:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 84D5B4B0A0;
	Sat, 25 Sep 2021 05:50:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BA8334086D
 for <kvmarm@lists.cs.columbia.edu>; Sat, 25 Sep 2021 05:50:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uFQZ-mUeBLEq for <kvmarm@lists.cs.columbia.edu>;
 Sat, 25 Sep 2021 05:50:09 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 99767407D1
 for <kvmarm@lists.cs.columbia.edu>; Sat, 25 Sep 2021 05:50:09 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 441BD61279;
 Sat, 25 Sep 2021 09:50:08 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mU4Jq-00Cuoe-EB; Sat, 25 Sep 2021 10:50:06 +0100
Date: Sat, 25 Sep 2021 10:50:05 +0100
Message-ID: <878rzlass2.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 07/14] KVM: Don't block+unblock when halt-polling is
 successful
In-Reply-To: <20210925005528.1145584-8-seanjc@google.com>
References: <20210925005528.1145584-1-seanjc@google.com>
 <20210925005528.1145584-8-seanjc@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: seanjc@google.com, chenhuacai@kernel.org,
 aleksandar.qemu.devel@gmail.com, paulus@ozlabs.org, borntraeger@de.ibm.com,
 frankja@linux.ibm.com, pbonzini@redhat.com, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com, david@redhat.com,
 cohuck@redhat.com, imbrenda@linux.ibm.com, vkuznets@redhat.com,
 wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-mips@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmatlack@google.com, jingzhangos@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 kvmarm@lists.cs.columbia.edu, Janosch Frank <frankja@linux.ibm.com>,
 Joerg Roedel <joro@8bytes.org>, Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, kvm-ppc@vger.kernel.org,
 David Matlack <dmatlack@google.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

On Sat, 25 Sep 2021 01:55:21 +0100,
Sean Christopherson <seanjc@google.com> wrote:
> 
> Invoke the arch hooks for block+unblock if and only if KVM actually
> attempts to block the vCPU.  The only non-nop implementation is on arm64,
> and if halt-polling is successful, there is no need for arm64 to put/load
> the vGIC as KVM hasn't relinquished control of the vCPU in any way.

This doesn't mean that there is no requirement for any state
change. The put/load on GICv4 is crucial for performance, and the VMCR
resync is a correctness requirement.

> 
> The primary motivation is to allow future cleanup to split out "block"
> from "halt", but this is also likely a small performance boost on arm64
> when halt-polling is successful.
> 
> Adjust the post-block path to update "cur" after unblocking, i.e. include
> vGIC load time in halt_wait_ns and halt_wait_hist, so that the behavior
> is consistent.  Moving just the pre-block arch hook would result in only
> the vGIC put latency being included in the halt_wait stats.  There is no
> obvious evidence that one way or the other is correct, so just ensure KVM
> is consistent.

This effectively reverts 07ab0f8d9a12 ("KVM: Call
kvm_arch_vcpu_blocking early into the blocking sequence"), which was a
huge gain on arm64, not to mention a correctness fix.

Without this, a GICv4 machine will always pay for the full poll
penalty, going into schedule(), and only then get a doorbell interrupt
signalling telling the kernel that there was an interrupt.

On a non-GICv4 machine, it means that interrupts injected by another
thread during the pooling will be evaluated with an outdated priority
mask, which can result in either a spurious wake-up or a missed
wake-up.

If it means introducing a new set of {pre,post}-poll arch-specific
hooks, so be it. But I don't think this change is acceptable as is.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
