Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 638775EAE10
	for <lists+kvmarm@lfdr.de>; Mon, 26 Sep 2022 19:22:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 502D44B74F;
	Mon, 26 Sep 2022 13:22:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10qZxVTjNCNy; Mon, 26 Sep 2022 13:22:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EAB924B743;
	Mon, 26 Sep 2022 13:22:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A6004B62A
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Sep 2022 13:22:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tty47+6f3Ujk for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Sep 2022 13:22:17 -0400 (EDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D016D40E25
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Sep 2022 13:22:17 -0400 (EDT)
Received: by mail-pj1-f53.google.com with SMTP id go6so6942411pjb.2
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Sep 2022 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=R7X1SDUffa2GKX/qHcqI1vL/oFJyVJgl0377su/y5wk=;
 b=Qpfjt7EqVpZbXAqTXvGvWggL9tZUa0qMg71aM1Jb7QpbfZaITj2obDXSlTBfj4mwp2
 87Jc5cpM2MvCRGMJOPQO3KEeMTjPC/XSVzeDGiU62gEJqTDMuneeDpmSWCFXkrJW6alo
 HLi0xSGTU5pzLh0FPhicsB9f5EoHT20TRKTos1nzXyrpdewdqPAwAl54tMz7PzFLCCQX
 y/RYOBfpxmGeTJirxXOcmCcRkWK0Xn6xljPfc0sc4MuP5E4jN1SBjhHuOHBgMMSxlX4j
 M4Onfp6lVFVjnp+ocVITbFA5/hdLjs0/ukGXHrgF3OcbPFrSpDg0iBClQ+ARa8bNgw7Y
 tx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=R7X1SDUffa2GKX/qHcqI1vL/oFJyVJgl0377su/y5wk=;
 b=NGKPrrLQIfn997wVm0N0xNIFwMspGwSjrnIczT9KUPpvUNsw2NsLePn9RORhh5vLtt
 hI9qlAOhbOGiQu16vwkzw6IYJ3kDkBE5SGU5AoMc4KDCz/DGs3+RwWt6/M+ftahN34I1
 knnvWyLMZJ9Iaoz+EzgmIH0M0ofl63qMaQuw+/Hvk4CH27THAatrnRN2v+cUsZPp6GiV
 zz/bp4ytyQp5XH4CDlB9/Ki5T4wdZlTFlVYSG6Wfk9JS89Nfvw/yhp/sEAgzzIabknRS
 T6SHLs3aOFxwzsgQRQVMrQboz7D2b4dxLU4eYFNmJBIzHmAYOq2rFkbXD3iQgxUZBRqr
 Twbg==
X-Gm-Message-State: ACrzQf3RRD/1FduXBnyCBYObX1ggDbVNuxeqK8rAKyHuChc9aqlUkgCD
 EBBk9xrRnEVUa7AMs3i53Lp0Ag==
X-Google-Smtp-Source: AMsMyM4tRK4K8+B/i1JkGhoUP0+VnP30Y+iCzcZKtmgRw/orO54avzYF9KCU8PiCryAaHOJ2FTT2ig==
X-Received: by 2002:a17:902:da8a:b0:179:e022:5f6 with SMTP id
 j10-20020a170902da8a00b00179e02205f6mr2308882plx.80.1664212936586; 
 Mon, 26 Sep 2022 10:22:16 -0700 (PDT)
Received: from google.com (220.181.82.34.bc.googleusercontent.com.
 [34.82.181.220]) by smtp.gmail.com with ESMTPSA id
 a124-20020a636682000000b00439103a6c3bsm10929187pgc.94.2022.09.26.10.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Sep 2022 10:22:14 -0700 (PDT)
Date: Mon, 26 Sep 2022 10:22:10 -0700
From: Ricardo Koller <ricarkol@google.com>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v8 10/14] KVM: selftests: aarch64: Add
 aarch64/page_fault_test
Message-ID: <YzHfwmZqMQ9xXaNa@google.com>
References: <20220922031857.2588688-1-ricarkol@google.com>
 <20220922031857.2588688-11-ricarkol@google.com>
 <Yyy4WjEmuSH1tSZb@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yyy4WjEmuSH1tSZb@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, bgardon@google.com,
 andrew.jones@linux.dev, dmatlack@google.com, pbonzini@redhat.com,
 axelrasmussen@google.com, kvmarm@lists.cs.columbia.edu
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

On Thu, Sep 22, 2022 at 07:32:42PM +0000, Sean Christopherson wrote:
> On Thu, Sep 22, 2022, Ricardo Koller wrote:
> > +/* Returns true to continue the test, and false if it should be skipped. */
> > +static bool punch_hole_in_memslot(struct kvm_vm *vm,
> 
> This is a very misleading name, and IMO is flat out wrong.  The helper isn't
> punching a hole in the memslot, it's punching a hole in the backing store, and
> those are two very different things.  Encountering a hole in a _memslot_ yields
> emualted MMIO semantics, not CoW zero page semantics.

Interestingly, we used to refer those as "gaps", as in "gaps between memslots".
But I get the point.

> 
> Ideally, if we can come up with a not awful name, I'd also prefer to avoid "punch
> hole" in the function name.  I can't think of a better alternative, so it's not
> the end of the world if we're stuck with e.g punch_hole_in_backing_store(), but I

Ack.

> think the "punch_hole" name will be confusing for readers that are unfamiliar with
> PUNCH_HOLE, especially for anonymous memory as "punching a hole" in anonymous
> memory is more likely to be interpreted as "munmap()".
> 
> > +				  struct userspace_mem_region *region)
> > +{
> > +	void *hva = (void *)region->region.userspace_addr;
> > +	uint64_t paging_size = region->region.memory_size;
> > +	int ret, fd = region->fd;
> > +
> > +	if (fd != -1) {
> > +		ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > +				0, paging_size);
> > +		TEST_ASSERT(ret == 0, "fallocate failed, errno: %d\n", errno);
> > +	} else {
> > +		if (is_backing_src_hugetlb(region->backing_src_type))
> > +			return false;
> 
> Why is hugetlb disallowed?  I thought anon hugetlb supports MADV_DONTNEED?
> 

It fails with EINVAL (only tried on arm) for both the PAGE_SIZE and the huge
page size. And note that the address is aligned as well.

madvise(0xffffb7c00000, 2097152, MADV_DONTNEED) = -1 EINVAL (Invalid argument)
	^^^^^^^^^^^^^^	^^^^^^^
	2M aligned	2M (hugepage size)
			
madvise(0xffff9e800000, 4096, MADV_DONTNEED) = -1 EINVAL (Invalid argument)   
			^^^^
			PAGE_SIZE

> > +
> > +		ret = madvise(hva, paging_size, MADV_DONTNEED);
> > +		TEST_ASSERT(ret == 0, "madvise failed, errno: %d\n", errno);
> > +	}
> > +
> > +	return true;
> > +}
> 
> ...
> 
> > +	/*
> > +	 * Accessing a hole in the data memslot (punched with fallocate or
> 
> s/memslot/backing store
> 
> > +	 * madvise) shouldn't fault (more sanity checks).
> 
> 
> Naming aside, please provide more detail as to why this is the correct KVM
> behavior.  This is quite subtle and relies on gory implementation details that a
> lot of KVM developers will be unaware of.

Ack.

> 
> Specifically, from an accessibility perspective, PUNCH_HOLE doesn't actually create
> a hole in the file.  The "hole" can still be read and written; the "expect '0'"
> checks are correct specifically because those are the semantics of PUNCH_HOLE.
> 
> In other words, it's not just that the accesses shouldn't fault, reads _must_
> return zeros and writes _must_ re-populate the page.

Moreover, the behavior from the guest POV should be the same as userspace
reading/writing on a hole (with PUNCH_HOLE). Will describe this as well.

> 
> Compare that with e.g. ftruncate() that makes the size of the file smaller, in
> which case an access should result in KVM exiting to userspace with -EFAULT.
> 
> > +	 */
> > +	TEST_ACCESS(guest_read64, no_af, CMD_HOLE_DATA),
> > +	TEST_ACCESS(guest_cas, no_af, CMD_HOLE_DATA),
> > +	TEST_ACCESS(guest_ld_preidx, no_af, CMD_HOLE_DATA),
> > +	TEST_ACCESS(guest_write64, no_af, CMD_HOLE_DATA),
> > +	TEST_ACCESS(guest_st_preidx, no_af, CMD_HOLE_DATA),
> > +	TEST_ACCESS(guest_at, no_af, CMD_HOLE_DATA),
> > +	TEST_ACCESS(guest_dc_zva, no_af, CMD_HOLE_DATA),
> > +
> > +	{ 0 }
> > +};
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
