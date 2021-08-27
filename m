Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6629C3F94F4
	for <lists+kvmarm@lfdr.de>; Fri, 27 Aug 2021 09:18:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C38464B0F4;
	Fri, 27 Aug 2021 03:18:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FX01kAlhvacx; Fri, 27 Aug 2021 03:18:39 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9A4684B100;
	Fri, 27 Aug 2021 03:18:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3FE284B0EF
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 03:18:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGBRqCGEm98w for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Aug 2021 03:18:29 -0400 (EDT)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4937040CF9
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 03:18:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZQ3CU43IWogsKyG+uqc1TCqPH8QEEhdztK1oMhkx3lw=; b=UEWQ5QT1Y91/ArLjsjiq9W9wMI
 4duU1mRjJn7JeeiAF847EnVYvfwy4Rfpdir+x9o7riPAQa7etq+VNF8POzrhtbCqJR9z1sDHo+02+
 HbRjsvwxweLsyjOac0MdoWbdd7InTqsNF0dlSuTIm9XrvQy3b/4YvfSEiVegiut0LsQRQ6jPkb8bY
 IfuvY98Og8QSy5GUJ7lJvsT1gSp6DIN+Jh1ydVw5QcNhrxKH4onHt1u2fN6HncmwxCS76O+WauSkn
 5Gg/ot5B8Psq7tBf27BAosAhcGQs4x7CwCAan6H6s6t6hdJz/pw7lyH6HaF3gC9dwlVv0nm5ojf50
 S3+xyWHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJW5C-00EFBb-NY; Fri, 27 Aug 2021 07:15:47 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 915013001CD;
 Fri, 27 Aug 2021 09:15:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 708F32C597E4C; Fri, 27 Aug 2021 09:15:17 +0200 (CEST)
Date: Fri, 27 Aug 2021 09:15:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 05/15] perf: Track guest callbacks on a per-CPU basis
Message-ID: <YSiRBQQE7md7ZrNC@hirez.programming.kicks-ass.net>
References: <20210827005718.585190-1-seanjc@google.com>
 <20210827005718.585190-6-seanjc@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210827005718.585190-6-seanjc@google.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
 Vincent Chen <deanbo422@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 linux-csky@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Like Xu <like.xu.linux@gmail.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Artem Kashkanov <artem.kashkanov@intel.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>,
 Juergen Gross <jgross@suse.com>, Nick Hu <nickhu@andestech.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

On Thu, Aug 26, 2021 at 05:57:08PM -0700, Sean Christopherson wrote:
> Use a per-CPU pointer to track perf's guest callbacks so that KVM can set
> the callbacks more precisely and avoid a lurking NULL pointer dereference.

I'm completely failing to see how per-cpu helps anything here...

> On x86, KVM supports being built as a module and thus can be unloaded.
> And because the shared callbacks are referenced from IRQ/NMI context,
> unloading KVM can run concurrently with perf, and thus all of perf's
> checks for a NULL perf_guest_cbs are flawed as perf_guest_cbs could be
> nullified between the check and dereference.

No longer allowing KVM to be a module would be *AWESOME*. I detest how
much we have to export for KVM :/

Still, what stops KVM from doing a coherent unreg? Even the
static_call() proposed in the other patch, unreg can do
static_call_update() + synchronize_rcu() to ensure everybody sees the
updated pointer (would require a quick audit to see all users are with
preempt disabled, but I think your using per-cpu here already imposes
the same).


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
