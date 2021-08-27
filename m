Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8C33F9533
	for <lists+kvmarm@lfdr.de>; Fri, 27 Aug 2021 09:35:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F17374B08A;
	Fri, 27 Aug 2021 03:35:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@infradead.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fp1O09D8Sodu; Fri, 27 Aug 2021 03:35:26 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C72B84B0F2;
	Fri, 27 Aug 2021 03:35:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C81F74B093
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 03:35:21 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id itelsiWZdI-C for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Aug 2021 03:35:17 -0400 (EDT)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7729A4B08A
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Aug 2021 03:35:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=izDnqED+aJquV8WBbT3PBDJAf7VsEW4nw5GoC1n7INc=; b=UOw1aDagqxomBMB4/E9tMZZeGZ
 A/CYxlrxnk/GSFFTbkLbsgVxAuCRJ0uxvjo85Tp7zy3Yucv+ZpTHwn2CnmihrOCVC9Yk2QeIxRvll
 8MnpnhG7WUlGGdapVfBrt4tzxXst/XpS+6PVp1qeaC1d0oim3gjAqiP/J5cmTZJlCyx1iWNeP4Wlf
 Z5XcBWL/yaYx+cHADlH6fZPiBRXj4hqI2YfdR4gAT6GCyITtnmu8zkenZdgkEqz4Y+YyeesKIgXPY
 axH5wRDh5FK6agDysTznL69fRm4hurQ8dCd9r5S54VhnaYDGtyqnIDvt5i5hP/qBNuObffeCu3FEh
 v14rcs9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJWNp-00DRSP-E8; Fri, 27 Aug 2021 07:34:39 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFD57300DEF;
 Fri, 27 Aug 2021 09:34:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id B14D22C6670EA; Fri, 27 Aug 2021 09:34:35 +0200 (CEST)
Date: Fri, 27 Aug 2021 09:34:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 11/15] KVM: x86: Move Intel Processor Trace interrupt
 handler to vmx.c
Message-ID: <YSiVi+jxNpFLE4gn@hirez.programming.kicks-ass.net>
References: <20210827005718.585190-1-seanjc@google.com>
 <20210827005718.585190-12-seanjc@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210827005718.585190-12-seanjc@google.com>
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

On Thu, Aug 26, 2021 at 05:57:14PM -0700, Sean Christopherson wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 13c4f58a75e5..e0b1c9386926 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5498,6 +5498,7 @@ void kvm_set_intel_pt_intr_handler(void (*handler)(void))
>  {
>  	kvm_guest_cbs.handle_intel_pt_intr = handler;
>  }
> +EXPORT_SYMBOL_GPL(kvm_set_intel_pt_intr_handler);

This is another one of those broken exports.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
