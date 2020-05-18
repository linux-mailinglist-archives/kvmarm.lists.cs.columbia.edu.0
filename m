Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48E1D742D
	for <lists+kvmarm@lfdr.de>; Mon, 18 May 2020 11:38:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 30D4A4B12D;
	Mon, 18 May 2020 05:38:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RxIwBQfim7Tc; Mon, 18 May 2020 05:38:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 237434B14D;
	Mon, 18 May 2020 05:38:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EC0B94B126
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 05:38:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TWGh5E-nxEVM for <kvmarm@lists.cs.columbia.edu>;
 Mon, 18 May 2020 05:38:40 -0400 (EDT)
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C23404B0FE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 18 May 2020 05:38:40 -0400 (EDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1jacE8-0006Sy-DK; Mon, 18 May 2020 11:38:28 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id D530B100606; Mon, 18 May 2020 11:38:27 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anastassios Nanos <ananos@nubificus.co.uk>
Subject: Re: [PATCH 0/2] Expose KVM API to Linux Kernel
In-Reply-To: <CALRTab-mEYtRG4zQbSGoAri+jg8xNL-imODv=MWE330Hkt_t+Q@mail.gmail.com>
References: <cover.1589784221.git.ananos@nubificus.co.uk>
 <87y2ppy6q0.fsf@nanos.tec.linutronix.de>
 <CALRTab-mEYtRG4zQbSGoAri+jg8xNL-imODv=MWE330Hkt_t+Q@mail.gmail.com>
Date: Mon, 18 May 2020 11:38:27 +0200
Message-ID: <87sgfxy44s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Will Deacon <will@kernel.org>,
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

Anastassios Nanos <ananos@nubificus.co.uk> writes:
> On Mon, May 18, 2020 at 11:43 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> And this shows clearly how simple the user space is which is required to
>> do that. So why on earth would we want to have all of that in the
>> kernel?
>>
> well, the main idea is that all this functionality is already in the
> kernel. My view is that kvmmtest is as simple as kvmtest.

That still does not explain the purpose, the advantage and any reason
why this should be moreged.

> Moreover, it doesn't involve *any* mode switch at all while printing
> out the result of the addition of these two registers -- which I guess
> for a simple use-case like this it isn't much.  But if we were to
> scale this to a large number of exits (and their respective handling
> in user-space) that would incur significant overhead. Don't you agree?

No. I still do not see the real world use case you are trying to
solve. We are not going to accept changes like this which have no proper
justification, real world use cases and proper numbers backing it up.

Thanks,

        tglx


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
