Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD7446D94
	for <lists+kvmarm@lfdr.de>; Sat,  6 Nov 2021 12:17:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 741484B1CA;
	Sat,  6 Nov 2021 07:17:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DaeG2iUKPlya; Sat,  6 Nov 2021 07:17:56 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 205AA4B1BA;
	Sat,  6 Nov 2021 07:17:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D9EB4B1A3
 for <kvmarm@lists.cs.columbia.edu>; Sat,  6 Nov 2021 07:17:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oeamc7mZn8Ry for <kvmarm@lists.cs.columbia.edu>;
 Sat,  6 Nov 2021 07:17:52 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D15084A531
 for <kvmarm@lists.cs.columbia.edu>; Sat,  6 Nov 2021 07:17:51 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BD2F160ED5;
 Sat,  6 Nov 2021 11:17:50 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=wait-a-minute.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mjJhk-003oLQ-Fj; Sat, 06 Nov 2021 11:17:48 +0000
Date: Sat, 06 Nov 2021 11:17:41 +0000
Message-ID: <87o86xednu.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 1/5] KVM: Move wiping of the kvm->vcpus array to common
 code
In-Reply-To: <YYWQHBwD4nBLo9qi@google.com>
References: <20211105192101.3862492-1-maz@kernel.org>
 <20211105192101.3862492-2-maz@kernel.org>
 <YYWQHBwD4nBLo9qi@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: seanjc@google.com, kvm@vger.kernel.org,
 linux-mips@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
 aleksandar.qemu.devel@gmail.com, anup.patel@wdc.com, atish.patra@wdc.com,
 borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
 imbrenda@linux.ibm.com, pbonzini@redhat.com, jgross@suse.com,
 npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Juergen Gross <jgross@suse.com>, Anup Patel <anup.patel@wdc.com>,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Huacai Chen <chenhuacai@kernel.org>,
 David Hildenbrand <david@redhat.com>, linux-mips@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Atish Patra <atish.patra@wdc.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 kernel-team@android.com, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvmarm@lists.cs.columbia.edu
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

On Fri, 05 Nov 2021 20:12:12 +0000,
Sean Christopherson <seanjc@google.com> wrote:
> 
> On Fri, Nov 05, 2021, Marc Zyngier wrote:
> > All architectures have similar loops iterating over the vcpus,
> > freeing one vcpu at a time, and eventually wiping the reference
> > off the vcpus array. They are also inconsistently taking
> > the kvm->lock mutex when wiping the references from the array.
> 
> ...
> 
> > +void kvm_destroy_vcpus(struct kvm *kvm)
> > +{
> > +	unsigned int i;
> > +	struct kvm_vcpu *vcpu;
> > +
> > +	kvm_for_each_vcpu(i, vcpu, kvm)
> > +		kvm_vcpu_destroy(vcpu);
> > +
> > +	mutex_lock(&kvm->lock);
> 
> But why is kvm->lock taken here?  Unless I'm overlooking an arch,
> everyone calls this from kvm_arch_destroy_vm(), in which case this
> is the only remaining reference to @kvm.  And if there's some magic
> path for which that's not true, I don't see how it can possibly be
> safe to call kvm_vcpu_destroy() without holding kvm->lock, or how
> this would guarantee that all vCPUs have actually been destroyed
> before nullifying the array.

I asked myself the same question two years ago, and couldn't really
understand the requirement. However, x86 does just that, so I
preserved the behaviour.

If you too believe that this is just wrong, I'm happy to drop the
locking altogether. If that breaks someone's flow, they'll shout soon
enough.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
