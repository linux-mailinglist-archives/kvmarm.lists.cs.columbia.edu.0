Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2C6465D3
	for <lists+kvmarm@lfdr.de>; Thu,  8 Dec 2022 01:27:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B83D4B89E;
	Wed,  7 Dec 2022 19:27:12 -0500 (EST)
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
	with ESMTP id W9yoEYUlUMvd; Wed,  7 Dec 2022 19:27:11 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B20EB4B895;
	Wed,  7 Dec 2022 19:27:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C17B4B88D
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Dec 2022 19:27:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MWXSYmbdVRyP for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Dec 2022 19:27:07 -0500 (EST)
Received: from out-213.mta0.migadu.com (out-213.mta0.migadu.com
 [91.218.175.213])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D90FB4B881
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Dec 2022 19:27:07 -0500 (EST)
Date: Thu, 8 Dec 2022 00:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1670459226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8bdcc50wn8UsmiJI5n21HPc9V1IZkZNXUkx+5w7LeM=;
 b=LtxGLfgdz34RIqWijaQ+k2KPddTbVRBOnyMr/S2dcqR+op21TvVEcK8B4TysysD2vTkcPF
 FT17LaFAkwidPdPfNVkviHSMB5dnJRhtZG7UYRSq7lRDazE4GcDoNK0q+TP+8msYlFAq2L
 TRWNQfMlVL23nt6S/7a2W5rSHEhTt9c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 3/4] KVM: arm64: selftests: Align VA space allocator with
 TTBR0
Message-ID: <Y5EvVtAoDSHvIKie@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-4-oliver.upton@linux.dev>
 <Y5EtP5z6rxSK1VUe@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5EtP5z6rxSK1VUe@google.com>
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

On Thu, Dec 08, 2022 at 12:18:07AM +0000, Sean Christopherson wrote:

[...]

> Together, what about?  The #ifdef is a bit gross, especially around "hi_start",
> but it's less duplicate code.  And IMO, having things bundled in the same place
> makes it a lot easier for newbies (to arm64 or kernel coding in general) to
> understand what's going on and why arm64 is different.

I'd rather we not go this route. We really shouldn't make any attempt to
de-dupe something that is inherently architecture specific.

For example:

> +	/*
> +	 * All architectures supports splitting the virtual address space into
> +	 * a high and a low half.  Populate both halves, except for arm64 which
> +	 * currently uses only TTBR0_EL1 (arbitrary selftests "logic"), i.e.
> +	 * only has a valid low half.
> +	 */
> +	sparsebit_num_t nr_va_bits = (1ULL << (vm->va_bits - 1)) >> vm->page_shift;

This is still wrong for arm64. When we say the VA space is 48 bits, we
really do mean that TTBR0 is able to address a full 48 bits. So this
truncates the MSB for the addressing mode.

With the code living in the arm64 side of the shop, I can also tailor
the comment to directly match the architecture to provide breadcrumbs
tying it back to the Arm ARM.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
