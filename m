Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 853C36465FC
	for <lists+kvmarm@lfdr.de>; Thu,  8 Dec 2022 01:37:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D45704B899;
	Wed,  7 Dec 2022 19:37:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linux.dev
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x3qUK53onLFF; Wed,  7 Dec 2022 19:37:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 822834B8A0;
	Wed,  7 Dec 2022 19:37:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 38C534B89C
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Dec 2022 19:37:30 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVUNS9xafTZh for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Dec 2022 19:37:28 -0500 (EST)
Received: from out-157.mta0.migadu.com (out-157.mta0.migadu.com
 [91.218.175.157])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D53BF4B899
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Dec 2022 19:37:28 -0500 (EST)
Date: Thu, 8 Dec 2022 00:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1670459848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1Ot9//nMiXKCXxmYFxpZAtjZ4ruTDUzpHcMNR6JE8Q=;
 b=Zo+rwodmUSpHYC0YOk/0NSai9qoHKbHeLsICVlcjQQslcyJgdi8NIVirevj/b5ycOtQtoL
 r1XtqN67K/9InXjPit9tu81ZxVQ+LMFtY3KPPNRrEScL+qmbpv+RRDRA+MScT8fR1Gp305
 E074yDhdLgLX+Huj4R41n1ZMU6arnIo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 2/4] KVM: selftests: Setup ucall after loading program
 into guest memory
Message-ID: <Y5Exwzr6Ibmmthl0@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-3-oliver.upton@linux.dev>
 <Y5EoZ5uwrTF3eSKw@google.com> <Y5EtMWuTaJk9I3Bd@google.com>
 <Y5EutGSjkRmdItQb@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5EutGSjkRmdItQb@google.com>
X-Migadu-Flow: FLOW_OUT
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Dec 08, 2022 at 12:24:20AM +0000, Sean Christopherson wrote:
> On Thu, Dec 08, 2022, Oliver Upton wrote:
> > On Wed, Dec 07, 2022 at 11:57:27PM +0000, Sean Christopherson wrote:
> > > > diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > > > index 92d3a91153b6..95d22cfb7b41 100644
> > > > --- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > > > +++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > > > @@ -609,8 +609,13 @@ static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
> > > >  				    data_size / guest_page_size,
> > > >  				    p->test_desc->data_memslot_flags);
> > > >  	vm->memslots[MEM_REGION_TEST_DATA] = TEST_DATA_MEMSLOT;
> > > > +}
> > > > +
> > > > +static void setup_ucall(struct kvm_vm *vm)
> > > > +{
> > > > +	struct userspace_mem_region *region = vm_get_mem_region(vm, MEM_REGION_TEST_DATA);
> > > >  
> > > > -	ucall_init(vm, data_gpa + data_size);
> > > > +	ucall_init(vm, region->region.guest_phys_addr + region->region.memory_size);
> > > 
> > > Isn't there a hole after CODE_AND_DATA_MEMSLOT?  I.e. after memslot 0?
> > 
> > Sure, but that's only guaranteed in the PA space.
> > 
> > > The reason
> > > I ask is because if so, then we can do the temporarily heinous, but hopefully forward
> > > looking thing of adding a helper to wrap kvm_vm_elf_load() + ucall_init().
> > > 
> > > E.g. I think we can do this immediately, and then at some point in the 6.2 cycle
> > > add a dedicated region+memslot for the ucall MMIO page.
> > 
> > Even still, that's just a kludge to make ucalls work. We have other
> > MMIO devices (GIC distributor, for example) that work by chance since
> > nothing conflicts with the constant GPAs we've selected in the tests.
> > 
> > I'd rather we go down the route of having an address allocator for the
> > for both the VA and PA spaces to provide carveouts at runtime.
> 
> Aren't those two separate issues?  The PA, a.k.a. memslots space, can be solved
> by allocating a dedicated memslot, i.e. doesn't need a carve.  At worst, collisions
> will yield very explicit asserts, which IMO is better than whatever might go wrong
> with a carve out.

Perhaps the use of the term 'carveout' wasn't right here.

What I'm suggesting is we cannot rely on KVM memslots alone to act as an
allocator for the PA space. KVM can provide devices to the guest that
aren't represented as memslots. If we're trying to fix PA allocations
anyway, why not make it generic enough to suit the needs of things
beyond ucalls?

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
