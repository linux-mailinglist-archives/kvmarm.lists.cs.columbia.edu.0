Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFAA619D4F
	for <lists+kvmarm@lfdr.de>; Fri,  4 Nov 2022 17:31:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7FBD343479;
	Fri,  4 Nov 2022 12:31:35 -0400 (EDT)
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
	with ESMTP id p-o4DJQVG0rC; Fri,  4 Nov 2022 12:31:35 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 33532410E5;
	Fri,  4 Nov 2022 12:31:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5C71D40BD9
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 12:31:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5+EDdshPubKq for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Nov 2022 12:31:31 -0400 (EDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 245AE40B6C
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Nov 2022 12:31:31 -0400 (EDT)
Received: by mail-pg1-f170.google.com with SMTP id b62so4842726pgc.0
 for <kvmarm@lists.cs.columbia.edu>; Fri, 04 Nov 2022 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tykh0C7NQoqMsiv0FEJ8nDBTc1ar6j/4SljcpXaw+gg=;
 b=ZvfqWRbmiygXbQlvUXzlFPIy6pWgi3NnbKZ9axUfvTwSG1jmeczFdzfmEBk6JPul9u
 KtfoNDPD7+7L7ckLKxE85H3i30VZE1cLcwZqr+9Pmyt/Uvr0gsenysKMrttjRd1DNmYa
 taHLNc4BlGL4LuS+a5zOzje7JmI5lr7pLr83tPoJKPDxZ+8mRqo1TUsZIcKB3+pLirGc
 61VotfoTC994tXlc+pHq0IWsR3SGM7VfiO/hK89Ek0CoqTLSvnWOMLSW6BMMx8STYHyn
 tAWojTUjFC5IOfCMzJ25ZkS53CsxfaYW+If16SDvap+gn/hFvgnPNsAIXJ/ZXr/CVgup
 nXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tykh0C7NQoqMsiv0FEJ8nDBTc1ar6j/4SljcpXaw+gg=;
 b=sPu9PQOdaF8nfz95fOhVPBPQ0Ar65++j9++Oq3pa2gkwdmf2U1DAR+yvac6ZHunlx4
 wEzwZ4S2UfgE9cGB+TJYRmcxnpYzYXOZ/ga8V4tBUbjszmTnBcGfDhqnydhmjvry7KNP
 Ih04ZlEIFpmjcqy21r+i8HSzLQT4xsrPivmwnyYmIsDYwYmHBGlw8IUCrHmO+KmgyvTV
 0a87RB3JXzpJXJArs1UlWbvCv6jDaVdWuBtHaAMnnYZpB6pElvrpgOYf9Qu2fZuOvcRt
 hoyKHm/EycyC/7jAE/zYx+YtMBaIqpXFWgeCHXNDh3SF2zNpkex5yICVUJdZQRBbVidA
 SBEw==
X-Gm-Message-State: ACrzQf1x858KAmidN1GxPfIO7SZuMSRlEacdJNm7VsCzG05jHrctqBeh
 TUwDCrNSEZmF4Lgxp3IYoxE6UQ==
X-Google-Smtp-Source: AMsMyM4q4CNgN2lQ4PyaYyADoR+QimlVBokrxw9X6LS0+cBweFifUR+XVuuTHXr8UlnLM2zvHk12kA==
X-Received: by 2002:a05:6a00:248e:b0:56e:ad31:b976 with SMTP id
 c14-20020a056a00248e00b0056ead31b976mr1059125pfv.51.1667579490004; 
 Fri, 04 Nov 2022 09:31:30 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com.
 [34.168.104.7]) by smtp.gmail.com with ESMTPSA id
 y133-20020a62ce8b000000b00565cbad9616sm2954667pfg.6.2022.11.04.09.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Nov 2022 09:31:29 -0700 (PDT)
Date: Fri, 4 Nov 2022 16:31:25 +0000
From: Sean Christopherson <seanjc@google.com>
To: Yuan Yao <yuan.yao@linux.intel.com>
Subject: Re: [PATCH 08/44] KVM: x86: Move hardware setup/unsetup to init/exit
Message-ID: <Y2U+XT0Sm+a69CaH@google.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-9-seanjc@google.com>
 <20221104062223.7kcrbt66mlmqxk7f@yy-desk-7060>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221104062223.7kcrbt66mlmqxk7f@yy-desk-7060>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Yuan Yao <yuan.yao@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-riscv@lists.infradead.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Chao Gao <chao.gao@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
 Atish Patra <atishp@atishpatra.org>, kvmarm@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, linux-mips@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, kvm-riscv@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
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

On Fri, Nov 04, 2022, Yuan Yao wrote:
> On Wed, Nov 02, 2022 at 11:18:35PM +0000, Sean Christopherson wrote:
> > To avoid having to unwind various setup, e.g registration of several
> > notifiers, slot in the vendor hardware setup before the registration of
> > said notifiers and callbacks.  Introducing a functional change while
> > moving code is less than ideal, but the alternative is adding a pile of
> > unwinding code, which is much more error prone, e.g. several attempts to
> > move the setup code verbatim all introduced bugs.

...

> > @@ -9325,6 +9343,24 @@ int kvm_arch_init(void *opaque)
> >  		kvm_caps.supported_xcr0 = host_xcr0 & KVM_SUPPORTED_XCR0;
> >  	}
> >
> > +	rdmsrl_safe(MSR_EFER, &host_efer);
> > +
> > +	if (boot_cpu_has(X86_FEATURE_XSAVES))
> > +		rdmsrl(MSR_IA32_XSS, host_xss);
> > +
> > +	kvm_init_pmu_capability();
> > +
> > +	r = ops->hardware_setup();
> > +	if (r != 0)
> > +		goto out_mmu_exit;
> 
> The failure case of ops->hardware_setup() is unwound
> by kvm_arch_exit() before this patch, do we need to
> keep that old behavior ?

As called out in the changelog, the call to ops->hardware_setup() was deliberately
slotted in before the call to kvm_timer_init() so that kvm_arch_init() wouldn't
need to unwind more stuff if harware_setup() fails.

> > +	/*
> > +	 * Point of no return!  DO NOT add error paths below this point unless
> > +	 * absolutely necessary, as most operations from this point forward
> > +	 * require unwinding.
> > +	 */
> > +	kvm_ops_update(ops);
> > +
> >  	kvm_timer_init();
> >
> >  	if (pi_inject_timer == -1)
> > @@ -9336,8 +9372,32 @@ int kvm_arch_init(void *opaque)
> >  		set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
> >  #endif
> >
> > +	kvm_register_perf_callbacks(ops->handle_intel_pt_intr);
> > +
> > +	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
> > +		kvm_caps.supported_xss = 0;
> > +
> > +#define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
> > +	cr4_reserved_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_);
> > +#undef __kvm_cpu_cap_has
> > +
> > +	if (kvm_caps.has_tsc_control) {
> > +		/*
> > +		 * Make sure the user can only configure tsc_khz values that
> > +		 * fit into a signed integer.
> > +		 * A min value is not calculated because it will always
> > +		 * be 1 on all machines.
> > +		 */
> > +		u64 max = min(0x7fffffffULL,
> > +			      __scale_tsc(kvm_caps.max_tsc_scaling_ratio, tsc_khz));
> > +		kvm_caps.max_guest_tsc_khz = max;
> > +	}
> > +	kvm_caps.default_tsc_scaling_ratio = 1ULL << kvm_caps.tsc_scaling_ratio_frac_bits;
> > +	kvm_init_msr_list();
> >  	return 0;
> >
> > +out_mmu_exit:
> > +	kvm_mmu_vendor_module_exit();
> >  out_free_percpu:
> >  	free_percpu(user_return_msrs);
> >  out_free_x86_emulator_cache:
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
