Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B4260F5F
	for <lists+kvmarm@lfdr.de>; Tue,  8 Sep 2020 12:13:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 007024B578;
	Tue,  8 Sep 2020 06:13:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t+JEJQwpzKbS; Tue,  8 Sep 2020 06:13:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A0F1D4B570;
	Tue,  8 Sep 2020 06:13:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A9E14B55F
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 06:13:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pusAwMkVeJ3p for <kvmarm@lists.cs.columbia.edu>;
 Tue,  8 Sep 2020 06:13:06 -0400 (EDT)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6CED74B21B
 for <kvmarm@lists.cs.columbia.edu>; Tue,  8 Sep 2020 06:13:06 -0400 (EDT)
Received: by mail-wr1-f68.google.com with SMTP id t10so18530151wrv.1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 08 Sep 2020 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3cIm4aOIMgid18s5SFvqtTHUdmbOu4lOwzIV5nuummY=;
 b=AL4QqujbSCH2p9h5sM6hPzRpZjjpzUGna5FOfproYEyVASvzCInno7O8FHg6gwy2P4
 v6yuFzZFWTCc+iNGNatil/2LH02E9WuD74ZJBEkqwmTUyfnD4zyZGlAd+adCVIMNQmMq
 YvWHCBp3hfRxmbqfOxhhB04puOJWagOpXS/1kmn3yO6LRLY+0pQGxQDSkuBoldWmdaS8
 rw2SxwTBqCVL9u0KHlpmAqvOWSYtuBuOWKC7ZQWmTX9X0B4ZMWuN/pz7jy4l0HCo7eST
 Zek7Lm2MT37pG0V5cCrABW0/a1jNzncxCD4Y4GzbXz9xhsP/IBBtDPRzXd2flCJjstzY
 45QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3cIm4aOIMgid18s5SFvqtTHUdmbOu4lOwzIV5nuummY=;
 b=Zle6GX9FEu+hjvGXueZEo7VDVzC9sqN1WIn9dcryGnZOp0g/mZg6BLeJuLTTFvItpL
 0xq+4Usf3HWFJNBUYL2TtBxy7v1otJk5yKUx6ubxNODnv0fWpkN+2rr6nRVmsPBO0kLa
 DTeymzNic1smaMTCyGPOfUME2fgmTZ5PyqlFe50FE0rRPMxBh2DfVmKNJbgV5znqEYA6
 KM/uIMESpItlalvjZURbm8EfxHcmXLA/Jxr1K6QgXYtQssXUmWkjKS513vQrpsMfLh8p
 EEtHK0ZS3TaZ4TAAtc62dTQ3MgSMy1ppqOuisrsPgNFnduhhJuqQK1rh6dZ1DeT3tFZa
 emfw==
X-Gm-Message-State: AOAM531iuCBwPvFVcxc64X8sD3uUC2gZASlLiO0MtOFHc0bBjJ4VVHS+
 ZZApt9HOWj/sLtCratv5nCdTcA==
X-Google-Smtp-Source: ABdhPJweuPYI0fh/ItUUkJ4WQSRnC/AMg+WAaomsP/vQawqvEzwK+UrKDcEGabDOtqFFUV4z1e/GdA==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr11671863wrn.93.1599559985300; 
 Tue, 08 Sep 2020 03:13:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:4a0f:cfff:fe4a:6363])
 by smtp.gmail.com with ESMTPSA id u66sm31633631wmg.44.2020.09.08.03.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 03:13:04 -0700 (PDT)
Date: Tue, 8 Sep 2020 11:13:00 +0100
From: Andrew Scull <ascull@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 04/18] KVM: arm64: Restrict symbol aliasing to outside
 nVHE
Message-ID: <20200908101300.GA3268721@google.com>
References: <20200903135307.251331-1-ascull@google.com>
 <20200903135307.251331-5-ascull@google.com>
 <87zh61lvm9.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zh61lvm9.wl-maz@kernel.org>
Cc: kernel-team@android.com, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>,
 will@kernel.org, kvmarm@lists.cs.columbia.edu
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

On Mon, Sep 07, 2020 at 11:38:38AM +0100, Marc Zyngier wrote:
> Hi Andrew,
> 
> On Thu, 03 Sep 2020 14:52:53 +0100,
> Andrew Scull <ascull@google.com> wrote:
> > 
> > nVHE symbols are prefixed but this is sometimes hidden from the host by
> > aliasing the non-prefixed symbol to the prefixed version with a macro.
> > This runs into problems if nVHE tries to use the symbol as it becomes
> > doubly prefixed. Avoid this by omitting the aliasing macro for nVHE.
> > 
> > Cc: David Brazdil <dbrazdil@google.com>
> > Signed-off-by: Andrew Scull <ascull@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> > index 6f98fbd0ac81..6f9c4162a764 100644
> > --- a/arch/arm64/include/asm/kvm_asm.h
> > +++ b/arch/arm64/include/asm/kvm_asm.h
> > @@ -99,8 +99,11 @@ struct kvm_s2_mmu;
> >  
> >  DECLARE_KVM_NVHE_SYM(__kvm_hyp_init);
> >  DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
> > +
> > +#ifndef __KVM_NVHE_HYPERVISOR__
> >  #define __kvm_hyp_init		CHOOSE_NVHE_SYM(__kvm_hyp_init)
> >  #define __kvm_hyp_vector	CHOOSE_HYP_SYM(__kvm_hyp_vector)
> > +#endif
> 
> Hmmm. Why do we limit this to these two symbols instead of making it a
> property of the "CHOOSE_*" implementation?
> 
> The use of CHOOSE_HYP_SYM is already forbidden in the EL2 code (see
> how any symbol results in __nvhe_undefined_symbol being emitted). Does
> anything break if we have:
> 
> #define CHOOSE_NVHE_SYM(x)	x
> 
> when __KVM_NVHE_HYPERVISOR__ is defined?

I've specialized the CHOOSE_* macros along the lines you suggested for
each of the 3 relevant contexts: host, VHE and nVHE. If you think that's
overkill, the host and VHE cases can be merged.

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6f98fbd0ac81..a952859117b2 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -60,10 +60,24 @@
 	DECLARE_KVM_VHE_SYM(sym);		\
 	DECLARE_KVM_NVHE_SYM(sym)
 
+#if defined(__KVM_NVHE_HYPERVISOR__)
+
+#define CHOOSE_HYP_SYM(sym)	CHOOSE_NVHE_SYM(sym)
+#define CHOOSE_NVHE_SYM(sym)	sym
+/* The nVHE hypervisor shouldn't even try to access VHE symbols */
+extern void *__nvhe_undefined_symbol;
+#define CHOOSE_VHE_SYM(sym)	__nvhe_undefined_symbol
+
+#elif defined(__KVM_VHE_HYPERVISOR)
+
+#define CHOOSE_HYP_SYM(sym)	CHOOSE_VHE_SYM(sym)
 #define CHOOSE_VHE_SYM(sym)	sym
-#define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
+/* The VHE hypervisor shouldn't even try to access nVHE symbols */
+extern void *__vhe_undefined_symbol;
+#define CHOOSE_NVHE_SYM(sym)	__vhe_undefined_symbol
+
+#else
 
-#ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * BIG FAT WARNINGS:
  *
@@ -77,10 +91,9 @@
  */
 #define CHOOSE_HYP_SYM(sym)	(is_kernel_in_hyp_mode() ? CHOOSE_VHE_SYM(sym) \
 					   : CHOOSE_NVHE_SYM(sym))
-#else
-/* The nVHE hypervisor shouldn't even try to access anything */
-extern void *__nvhe_undefined_symbol;
-#define CHOOSE_HYP_SYM(sym)	__nvhe_undefined_symbol
+#define CHOOSE_VHE_SYM(sym)	sym
+#define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
+
 #endif
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
