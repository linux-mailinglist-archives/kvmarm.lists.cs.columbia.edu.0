Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F0F196465C7
	for <lists+kvmarm@lfdr.de>; Thu,  8 Dec 2022 01:18:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 665404B89A;
	Wed,  7 Dec 2022 19:18:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.788
X-Spam-Level: 
X-Spam-Status: No, score=-1.788 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3uDx5jGXwEZU; Wed,  7 Dec 2022 19:18:15 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05A264B899;
	Wed,  7 Dec 2022 19:18:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F4E44B894
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Dec 2022 19:18:13 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vLgaP8BCqmDB for <kvmarm@lists.cs.columbia.edu>;
 Wed,  7 Dec 2022 19:18:12 -0500 (EST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 27BD94B87A
 for <kvmarm@lists.cs.columbia.edu>; Wed,  7 Dec 2022 19:18:12 -0500 (EST)
Received: by mail-pj1-f52.google.com with SMTP id b11so78364pjp.2
 for <kvmarm@lists.cs.columbia.edu>; Wed, 07 Dec 2022 16:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Do/Fb4RXRaxpoUe/20L4z3mrChb2/QmWaVwWrgAuquw=;
 b=n1bUs4Agkz6KF6RZdHKB5skrzZ92+pJenXEV9Kr8UrmBzPVi8IztmvxkNk+3Cf3Wkd
 ZMXL2qFkVdxhKt3YQT2BIUXSMbtkIibDICSp2vjJRRWG+d/RyGenYr4lFEm/F2PoCTZK
 2Dc9t53lbS5YsQkYlM6s92iETFmZX+V1/KkST/vzxRsTLSX1sAyfr+UM7rIE4DpbUzge
 DA63QqtGOKZd+tHCtOkISvSXCkUy5vMKjbnVNnOFpVhEO/7MVeykfrOj0GMQYqMM0KTj
 f31N88nUIpq3z4qXw6AkOXnf6AeAATOoYClGBQT21SgRgtPmcOCTVzJI4EJvv0AR0n8/
 ldqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Do/Fb4RXRaxpoUe/20L4z3mrChb2/QmWaVwWrgAuquw=;
 b=PWu5aCRHFmD4je/sZ2Hn1fLMeBt6i+xvKizu4wvKeCY5pA15VVnDMB3cTdibjGf4ds
 KGRQI4aIc17cyW2OxVTIHBIBdQFTLexU3pTynvJGTDXtnqFpK+fNCS7zFflofd675NJ0
 s8VwqAkv3j+UD93J3ARv2ncjQ1bN/dDBTiTInyGUSLFcejRiX2NJrX1BeLPlogfc33Dv
 qfjJMa+K17IWRo1xDguZmy23RGk9e4RQwL6bh4/OyxPdjqi3DmQXQV4plh7q0SAwa+om
 q5txrU+ecg+9AsvJSTbPqiyWvyK4WOvs65Zq5BXC1P01lQ2rQJduLU0tWi7oJ5Lno+0U
 PJtA==
X-Gm-Message-State: ANoB5pndk1cYwa88AZ2pmN8mnQsKHTi+oLMrB52CVhwzz/Xxg/+BtLq5
 Ur9CTrWzHQQlrG1zFMHyAK/+zA==
X-Google-Smtp-Source: AA0mqf4eo6zlPiZ4jUKwuO3uBpbbjvUkZki3Zx5Ncf0CCnw1E0xp60S868ANYGdyrzz24zWBVBpBiA==
X-Received: by 2002:a05:6a20:e60e:b0:9d:b8e6:d8e5 with SMTP id
 my14-20020a056a20e60e00b0009db8e6d8e5mr1557362pzb.2.1670458690934; 
 Wed, 07 Dec 2022 16:18:10 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com.
 [34.168.104.7]) by smtp.gmail.com with ESMTPSA id
 l12-20020a170902e2cc00b00176a6ba5969sm9370997plc.98.2022.12.07.16.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 16:18:10 -0800 (PST)
Date: Thu, 8 Dec 2022 00:18:07 +0000
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH 3/4] KVM: arm64: selftests: Align VA space allocator with
 TTBR0
Message-ID: <Y5EtP5z6rxSK1VUe@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-4-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221207214809.489070-4-oliver.upton@linux.dev>
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

On Wed, Dec 07, 2022, Oliver Upton wrote:
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 316de70db91d..5972a23b2765 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -541,3 +541,13 @@ void kvm_selftest_arch_init(void)
>  	 */
>  	guest_modes_append_default();
>  }
> +
> +void vm_vaddr_populate_bitmap(struct kvm_vm *vm)

Add "arch" so that it's obvious this can be overidden?  The "__weak" conveys that
for the implementation, but not for the call site.  E.g. vm_arch_vaddr_populate_bitmap().

Actually, IIUC, the issue is that the high half isn't mapped (probably the wrong
terminology).  I.e. the calculation for the low half stays the same, and the high
half just goes away.

> +{
> +	/*
> +	 * arm64 selftests use only TTBR0_EL1, meaning that the valid VA space
> +	 * is [0, 2^(64 - TCR_EL1.T0SZ)).
> +	 */
> +	sparsebit_set_num(vm->vpages_valid, 0,
> +			  (1ULL << vm->va_bits) >> vm->page_shift);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index e9607eb089be..c88c3ace16d2 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -186,6 +186,15 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>  _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>  	       "Missing new mode params?");
>  
> +__weak void vm_vaddr_populate_bitmap(struct kvm_vm *vm)
> +{
> +	sparsebit_set_num(vm->vpages_valid,
> +		0, (1ULL << (vm->va_bits - 1)) >> vm->page_shift);
> +	sparsebit_set_num(vm->vpages_valid,
> +		(~((1ULL << (vm->va_bits - 1)) - 1)) >> vm->page_shift,
> +		(1ULL << (vm->va_bits - 1)) >> vm->page_shift);

Any objection to fixing up the formatting?  Actually, we can do more than just
fix the indentation, e.g. the number of bits is identical, and documenting that
this does a high/low split would be helpful.

Together, what about?  The #ifdef is a bit gross, especially around "hi_start",
but it's less duplicate code.  And IMO, having things bundled in the same place
makes it a lot easier for newbies (to arm64 or kernel coding in general) to
understand what's going on and why arm64 is different.

---
 tools/testing/selftests/kvm/lib/kvm_util.c | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e9607eb089be..d6f2c17e3d40 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -186,6 +186,23 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
 
+static void vm_vaddr_populate_bitmap(struct kvm_vm *vm)
+{
+	/*
+	 * All architectures supports splitting the virtual address space into
+	 * a high and a low half.  Populate both halves, except for arm64 which
+	 * currently uses only TTBR0_EL1 (arbitrary selftests "logic"), i.e.
+	 * only has a valid low half.
+	 */
+	sparsebit_num_t nr_va_bits = (1ULL << (vm->va_bits - 1)) >> vm->page_shift;
+#ifndef __aarch64__
+	sparsebit_num_t hi_start = (~((1ULL << (vm->va_bits - 1)) - 1)) >> vm->page_shift
+
+	sparsebit_set_num(vm->vpages_valid, hi_start, nr_bits);
+#endif
+	sparsebit_set_num(vm->vpages_valid, 0, nr_va_bits);
+}
+
 struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 {
 	struct kvm_vm *vm;
@@ -274,11 +291,7 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 
 	/* Limit to VA-bit canonical virtual addresses. */
 	vm->vpages_valid = sparsebit_alloc();
-	sparsebit_set_num(vm->vpages_valid,
-		0, (1ULL << (vm->va_bits - 1)) >> vm->page_shift);
-	sparsebit_set_num(vm->vpages_valid,
-		(~((1ULL << (vm->va_bits - 1)) - 1)) >> vm->page_shift,
-		(1ULL << (vm->va_bits - 1)) >> vm->page_shift);
+	vm_vaddr_populate_bitmap(vm);
 
 	/* Limit physical addresses to PA-bits. */
 	vm->max_gfn = vm_compute_max_gfn(vm);

base-commit: 35aecc3289eebf193fd70a067ea448ae2f0bb9b9
-- 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
