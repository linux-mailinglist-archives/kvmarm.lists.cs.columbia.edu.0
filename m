Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6600854E100
	for <lists+kvmarm@lfdr.de>; Thu, 16 Jun 2022 14:45:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 855E24B2A1;
	Thu, 16 Jun 2022 08:45:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -0.768
X-Spam-Level: 
X-Spam-Status: No, score=-0.768 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, MISSING_HEADERS=1.021, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4dQSZkDVcyQA; Thu, 16 Jun 2022 08:45:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2D49649F0B;
	Thu, 16 Jun 2022 08:45:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B5C3C49EDF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jun 2022 08:45:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iYtNCR0AOQNQ for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Jun 2022 08:45:24 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B413049EB4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jun 2022 08:45:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655383524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKRFYUFm6s2ZLsyh6jnlf6RpT4X0fSKK6tEbzMh4v6Y=;
 b=S1iwTvh+E3kEGrAzfFuIDvWtHcpSRnw1+B4jIjVPMcerP23nAd4+j+P8a/Bf30oa8D742w
 MV+4i3CVchEbMAjVk2wC2bcai0DNckDAXTOVxI7qhO6GdB4vouVfKXhJgaDEaSh6MZLY6N
 NX3Sch8jhc5MZ56eHCPlsAevi82OTo8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-XnhlBNxyPUaWQGE0IHgA2g-1; Thu, 16 Jun 2022 08:45:23 -0400
X-MC-Unique: XnhlBNxyPUaWQGE0IHgA2g-1
Received: by mail-ed1-f72.google.com with SMTP id
 v7-20020a056402348700b004351fb80abaso1166727edc.14
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Jun 2022 05:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lKRFYUFm6s2ZLsyh6jnlf6RpT4X0fSKK6tEbzMh4v6Y=;
 b=rQXKop104iEbVsQTqpopH7Ox78gEK5Krf8F0fe/NOoJZpWgnTzC+zw62/ncGUgp461
 JrzlPGv32NPzL4Sy5Pbb3mZ3tz6Z6ZBPI2gZc1mjbFNgN9KMNRnK/W3Q9lDpTXXlWiia
 9UZOcneVp1RZKSDxUq2zYFT3Cq5bR9eP+YMM+MINbgank3jBR/M0oAsnlNBNLr1347kd
 jwmq5HWCmVqnIm/0wQGQxWmwv3rj80s+K+dwC1bPOtUDR7RyXguNZDwPvSizNchdeLP4
 n9RN/OfY+g7VsobyOfpFT+YeMbs/YheeMU/yfRy43dhZfV3fb3RPjEvQPK6Z1mXWgsR2
 r1rg==
X-Gm-Message-State: AJIora8juIDIoPzBH4nGXIt4di61aJam1/0dvv9mwavOPfRcBAcYgC/y
 1xm/JefF6DZUWTFhV6BKylfUcFePiOMjisBAdfYUz6DwsQNywsVfKSR7r6cz+M+Njq1++JMBRnj
 lP23/nJtf2enroh9SJZbN111n
X-Received: by 2002:a05:6402:2812:b0:434:dcb3:c85 with SMTP id
 h18-20020a056402281200b00434dcb30c85mr6331420ede.1.1655383522047; 
 Thu, 16 Jun 2022 05:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sdm1MnKXJee4OOc6aftxxNu+WGmn9wJQoZYvBfxu908NRbY/b74RPB3UqmQr3hg42Pgo62hw==
X-Received: by 2002:a05:6402:2812:b0:434:dcb3:c85 with SMTP id
 h18-20020a056402281200b00434dcb30c85mr6331376ede.1.1655383521635; 
 Thu, 16 Jun 2022 05:45:21 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a170906769700b00708a2ae7620sm752346ejm.67.2022.06.16.05.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jun 2022 05:45:21 -0700 (PDT)
Date: Thu, 16 Jun 2022 14:45:19 +0200
From: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 4/4] KVM: selftests: Fix filename reporting in guest
 asserts
Message-ID: <20220616124519.erxasor4b5t7zaks@gator>
References: <20220615193116.806312-1-coltonlewis@google.com>
 <20220615193116.806312-5-coltonlewis@google.com>
MIME-Version: 1.0
In-Reply-To: <20220615193116.806312-5-coltonlewis@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 2
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: thuth@redhat.com, kvm@vger.kernel.org, g@gator, maz@kernel.org,
 pbonzini@redhat.com, vkuznets@redhat.com, kvmarm@lists.cs.columbia.edu
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

On Wed, Jun 15, 2022 at 07:31:16PM +0000, Colton Lewis wrote:
> Fix filename reporting in guest asserts by ensuring the GUEST_ASSERT
> macro records __FILE__ and substituting REPORT_GUEST_ASSERT for many
> repetitive calls to TEST_FAIL.
> 
> Previously filename was reported by using __FILE__ directly in the
> selftest, wrongly assuming it would always be the same as where the
> assertion failed.y
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> Reported-by: Ricardo Koller <ricarkol@google.com>
> Fixes: 4e18bccc2e5544f0be28fc1c4e6be47a469d6c60
> ---
>  tools/testing/selftests/kvm/aarch64/arch_timer.c   | 12 ++++++++----
>  .../selftests/kvm/aarch64/debug-exceptions.c       |  4 +---
>  tools/testing/selftests/kvm/aarch64/vgic_irq.c     |  4 +---
>  tools/testing/selftests/kvm/include/ucall_common.h | 14 ++++++++------
>  tools/testing/selftests/kvm/memslot_perf_test.c    |  4 +---
>  tools/testing/selftests/kvm/steal_time.c           |  3 +--
>  .../selftests/kvm/system_counter_offset_test.c     |  3 +--
>  tools/testing/selftests/kvm/x86_64/amx_test.c      |  3 +--
>  tools/testing/selftests/kvm/x86_64/cpuid_test.c    |  3 +--
>  .../selftests/kvm/x86_64/cr4_cpuid_sync_test.c     |  2 +-
>  .../selftests/kvm/x86_64/emulator_error_test.c     |  3 +--
>  tools/testing/selftests/kvm/x86_64/evmcs_test.c    |  3 +--
>  tools/testing/selftests/kvm/x86_64/hyperv_clock.c  |  3 +--
>  .../testing/selftests/kvm/x86_64/hyperv_features.c |  6 ++----
>  .../testing/selftests/kvm/x86_64/hyperv_svm_test.c |  3 +--
>  .../testing/selftests/kvm/x86_64/kvm_clock_test.c  |  3 +--
>  tools/testing/selftests/kvm/x86_64/kvm_pv_test.c   |  3 +--
>  .../testing/selftests/kvm/x86_64/set_boot_cpu_id.c |  4 +---
>  tools/testing/selftests/kvm/x86_64/state_test.c    |  3 +--
>  .../selftests/kvm/x86_64/svm_int_ctl_test.c        |  2 +-
>  .../testing/selftests/kvm/x86_64/svm_vmcall_test.c |  2 +-
>  tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c |  4 +---
>  .../selftests/kvm/x86_64/userspace_io_test.c       |  4 +---
>  .../selftests/kvm/x86_64/userspace_msr_exit_test.c |  5 ++---
>  .../selftests/kvm/x86_64/vmx_apic_access_test.c    |  3 +--
>  .../kvm/x86_64/vmx_close_while_nested_test.c       |  2 +-
>  .../selftests/kvm/x86_64/vmx_dirty_log_test.c      |  3 +--
>  .../kvm/x86_64/vmx_invalid_nested_guest_state.c    |  2 +-
>  .../kvm/x86_64/vmx_nested_tsc_scaling_test.c       |  2 +-
>  .../kvm/x86_64/vmx_preemption_timer_test.c         |  3 +--
>  .../selftests/kvm/x86_64/vmx_tsc_adjust_test.c     |  2 +-
>  .../testing/selftests/kvm/x86_64/xen_shinfo_test.c |  2 +-
>  .../testing/selftests/kvm/x86_64/xen_vmcall_test.c |  2 +-
>  33 files changed, 49 insertions(+), 72 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index f68019be67c0..9d7bda70c20a 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -231,10 +231,14 @@ static void *test_vcpu_run(void *arg)
>  		break;
>  	case UCALL_ABORT:
>  		sync_global_from_guest(vm, *shared_data);
> -		TEST_FAIL("%s at %s:%ld\n\tvalues: %lu, %lu; %lu, vcpu: %u; stage: %u; iter: %u",
> -			(const char *)uc.args[0], __FILE__, uc.args[1],
> -			uc.args[2], uc.args[3], uc.args[4], vcpu_idx,
> -			shared_data->guest_stage, shared_data->nr_iter);
> +		REPORT_GUEST_ASSERT_N(uc,
> +				      "values: %lu, %lu; %lu, vcpu %u; stage; %u; iter: %u",
> +				      GUEST_ASSERT_ARG(uc, 0),
> +				      GUEST_ASSERT_ARG(uc, 1),
> +				      GUEST_ASSERT_ARG(uc, 2),
> +				      vcpu_idx,
> +				      shared_data->guest_stage,
> +				      shared_data->nr_iter);
>  		break;
>  	default:
>  		TEST_FAIL("Unexpected guest exit\n");
> diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> index b8072b40ccc8..2ee35cf9801e 100644
> --- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> +++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
> @@ -283,9 +283,7 @@ int main(int argc, char *argv[])
>  				stage, (ulong)uc.args[1]);
>  			break;
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld\n\tvalues: %#lx, %#lx",
> -				(const char *)uc.args[0],
> -				__FILE__, uc.args[1], uc.args[2], uc.args[3]);
> +			REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
>  			break;
>  		case UCALL_DONE:
>  			goto done;
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> index 046ba4fde648..17417220a083 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> @@ -782,9 +782,7 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
>  			run_guest_cmd(vcpu, gic_fd, &inject_args, &args);
>  			break;
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld\n\tvalues: %#lx, %#lx",
> -					(const char *)uc.args[0],
> -					__FILE__, uc.args[1], uc.args[2], uc.args[3]);
> +			REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
>  			break;
>  		case UCALL_DONE:
>  			goto done;
> diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
> index e8af3b4fef6d..e1cc72077eab 100644
> --- a/tools/testing/selftests/kvm/include/ucall_common.h
> +++ b/tools/testing/selftests/kvm/include/ucall_common.h
> @@ -41,12 +41,14 @@ enum guest_assert_builtin_args {
>  	GUEST_ASSERT_BUILTIN_NARGS
>  };
>  
> -#define __GUEST_ASSERT(_condition, _condstr, _nargs, _args...) do {    \
> -	if (!(_condition))                                              \
> -		ucall(UCALL_ABORT, 2 + _nargs,                          \
> -			"Failed guest assert: "                         \
> -			_condstr, __LINE__, _args);                     \
> -} while (0)
> +#define __GUEST_ASSERT(_condition, _condstr, _nargs, _args...) do {	\
> +		if (!(_condition))					\
> +			ucall(UCALL_ABORT, GUEST_ASSERT_BUILTIN_NARGS + _nargs,	\
> +			      "Failed guest assert: " _condstr,		\
> +			      __FILE__,					\
> +			      __LINE__,					\
> +			      ##_args);					\

We don't need another level of indentation nor the ## operator on _args.

> +	} while (0)
>  
>  #define GUEST_ASSERT(_condition) \
>  	__GUEST_ASSERT(_condition, #_condition, 0, 0)
> diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
> index 5f98489e4f4d..44995446d942 100644
> --- a/tools/testing/selftests/kvm/memslot_perf_test.c
> +++ b/tools/testing/selftests/kvm/memslot_perf_test.c
> @@ -162,9 +162,7 @@ static void *vcpu_worker(void *__data)
>  				goto done;
>  			break;
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld, val = %lu",
> -					(const char *)uc.args[0],
> -					__FILE__, uc.args[1], uc.args[2]);
> +			REPORT_GUEST_ASSERT_1(uc, "val = %lu");
>  			break;
>  		case UCALL_DONE:
>  			goto done;
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index d122f1e05cdd..9866a71463d7 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -234,8 +234,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
>  	case UCALL_DONE:
>  		break;
>  	case UCALL_ABORT:
> -		TEST_ASSERT(false, "%s at %s:%ld", (const char *)uc.args[0],
> -			    __FILE__, uc.args[1]);
> +		REPORT_GUEST_ASSERT(uc);
>  	default:
>  		TEST_ASSERT(false, "Unexpected exit: %s",
>  			    exit_reason_str(vcpu->run->exit_reason));
> diff --git a/tools/testing/selftests/kvm/system_counter_offset_test.c b/tools/testing/selftests/kvm/system_counter_offset_test.c
> index 862a8e93e070..1c274933912b 100644
> --- a/tools/testing/selftests/kvm/system_counter_offset_test.c
> +++ b/tools/testing/selftests/kvm/system_counter_offset_test.c
> @@ -83,8 +83,7 @@ static void handle_sync(struct ucall *uc, uint64_t start, uint64_t end)
>  
>  static void handle_abort(struct ucall *uc)
>  {
> -	TEST_FAIL("%s at %s:%ld", (const char *)uc->args[0],
> -		  __FILE__, uc->args[1]);
> +	REPORT_GUEST_ASSERT(*uc);
>  }
>  
>  static void enter_guest(struct kvm_vcpu *vcpu)
> diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> index dab4ca16a2df..b71763b11b78 100644
> --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> @@ -373,8 +373,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -				  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			switch (uc.args[1]) {
> diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> index 4aa784932597..3767a0cc694b 100644
> --- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> @@ -132,8 +132,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
>  	case UCALL_DONE:
>  		return;
>  	case UCALL_ABORT:
> -		TEST_ASSERT(false, "%s at %s:%ld\n\tvalues: %#lx, %#lx", (const char *)uc.args[0],
> -			    __FILE__, uc.args[1], uc.args[2], uc.args[3]);
> +		REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
>  	default:
>  		TEST_ASSERT(false, "Unexpected exit: %s",
>  			    exit_reason_str(vcpu->run->exit_reason));
> diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> index a80940ac420f..56d8ab92eed4 100644
> --- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
> @@ -94,7 +94,7 @@ int main(int argc, char *argv[])
>  			vcpu_sregs_set(vcpu, &sregs);
>  			break;
>  		case UCALL_ABORT:
> -			TEST_FAIL("Guest CR4 bit (OSXSAVE) unsynchronized with CPUID bit.");
> +			REPORT_GUEST_ASSERT(uc);

We lose the "Guest CR4..." message here.

>  			break;
>  		case UCALL_DONE:
>  			goto done;
> diff --git a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
> index bfff2d271c48..3aa3d17f230f 100644
> --- a/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/emulator_error_test.c
> @@ -92,8 +92,7 @@ static void process_exit_on_emulation_error(struct kvm_vcpu *vcpu)
>  
>  static void do_guest_assert(struct ucall *uc)
>  {
> -	TEST_FAIL("%s at %s:%ld", (const char *)uc->args[0], __FILE__,
> -		  uc->args[1]);
> +	REPORT_GUEST_ASSERT(*uc);
>  }
>  
>  static void check_for_guest_assert(struct kvm_vcpu *vcpu)
> diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> index 8dda527cc080..aacad86d90e1 100644
> --- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
> @@ -236,8 +236,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -		      		  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			break;
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> index f7a9e29ff0c7..d576bc8ce823 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> @@ -234,8 +234,7 @@ int main(void)
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -				  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			break;
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> index d5f37495ade8..0eca72333d66 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> @@ -483,8 +483,7 @@ static void guest_test_msrs_access(void)
>  				    uc.args[1]);
>  			break;
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -				  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			return;
>  		case UCALL_DONE:
>  			return;
> @@ -653,8 +652,7 @@ static void guest_test_hcalls_access(void)
>  				    uc.args[1]);
>  			break;
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -				  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			return;
>  		case UCALL_DONE:
>  			return;
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> index c5cd9835dbd6..b7dc243ab8d5 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> @@ -145,8 +145,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -				  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			break;
> diff --git a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
> index 138455575a11..813ce282cf56 100644
> --- a/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/kvm_clock_test.c
> @@ -71,8 +71,7 @@ static void handle_sync(struct ucall *uc, struct kvm_clock_data *start,
>  
>  static void handle_abort(struct ucall *uc)
>  {
> -	TEST_FAIL("%s at %s:%ld", (const char *)uc->args[0],
> -		  __FILE__, uc->args[1]);
> +	REPORT_GUEST_ASSERT(*uc);
>  }
>  
>  static void setup_clock(struct kvm_vm *vm, struct test_case *test_case)
> diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
> index 5901ccec7079..fc9bd71e08b0 100644
> --- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
> @@ -167,8 +167,7 @@ static void pr_hcall(struct ucall *uc)
>  
>  static void handle_abort(struct ucall *uc)
>  {
> -	TEST_FAIL("%s at %s:%ld", (const char *)uc->args[0],
> -		  __FILE__, uc->args[1]);
> +	REPORT_GUEST_ASSERT(*uc);
>  }
>  
>  static void enter_guest(struct kvm_vcpu *vcpu)
> diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> index 7ef713fdd0a5..b25d7556b638 100644
> --- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> +++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
> @@ -65,9 +65,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
>  					stage);
>  			break;
>  		case UCALL_ABORT:
> -			TEST_ASSERT(false, "%s at %s:%ld\n\tvalues: %#lx, %#lx",
> -						(const char *)uc.args[0], __FILE__,
> -						uc.args[1], uc.args[2], uc.args[3]);
> +			REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
>  		default:
>  			TEST_ASSERT(false, "Unexpected exit: %s",
>  				    exit_reason_str(vcpu->run->exit_reason));
> diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
> index 0bcd78cf7c79..11d036e25fd2 100644
> --- a/tools/testing/selftests/kvm/x86_64/state_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/state_test.c
> @@ -190,8 +190,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -			       	  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			break;
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> index 9c68a47b69e1..d978d1697f5a 100644
> --- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> @@ -113,7 +113,7 @@ int main(int argc, char *argv[])
>  
>  	switch (get_ucall(vcpu, &uc)) {
>  	case UCALL_ABORT:
> -		TEST_FAIL("%s", (const char *)uc.args[0]);
> +		REPORT_GUEST_ASSERT(uc);
>  		break;
>  		/* NOT REACHED */
>  	case UCALL_DONE:
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
> index e6d7191866a5..d53b1f7abb56 100644
> --- a/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c
> @@ -58,7 +58,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s", (const char *)uc.args[0]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			break;
> diff --git a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
> index 3165d3f7e065..22d366c697f7 100644
> --- a/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
> @@ -79,9 +79,7 @@ static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
>  	case UCALL_DONE:
>  		return;
>  	case UCALL_ABORT:
> -		TEST_ASSERT(false, "%s at %s:%ld\n" \
> -			    "\tvalues: %#lx, %#lx", (const char *)uc.args[0],
> -			    __FILE__, uc.args[1], uc.args[2], uc.args[3]);
> +		REPORT_GUEST_ASSERT_2(uc, "values: %#lx, %#lx");
>  	default:
>  		TEST_ASSERT(false, "Unexpected exit: %s",
>  			    exit_reason_str(vcpu->run->exit_reason));
> diff --git a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
> index 7538d57a41d5..7316521428f8 100644
> --- a/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/userspace_io_test.c
> @@ -98,9 +98,7 @@ int main(int argc, char *argv[])
>  	case UCALL_DONE:
>  		break;
>  	case UCALL_ABORT:
> -		TEST_FAIL("%s at %s:%ld : argN+1 = 0x%lx, argN+2 = 0x%lx",
> -			  (const char *)uc.args[0], __FILE__, uc.args[1],
> -			  uc.args[2], uc.args[3]);
> +		REPORT_GUEST_ASSERT_2(uc, "argN+1 = 0x%lx, argN+2 = 0x%lx");
>  	default:
>  		TEST_FAIL("Unknown ucall %lu", uc.cmd);
>  	}
> diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> index f84dc37426f5..a4f06370a245 100644
> --- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
> @@ -400,8 +400,7 @@ static void check_for_guest_assert(struct kvm_vcpu *vcpu)
>  
>  	if (vcpu->run->exit_reason == KVM_EXIT_IO &&
>  	    get_ucall(vcpu, &uc) == UCALL_ABORT) {
> -		TEST_FAIL("%s at %s:%ld",
> -			  (const char *)uc.args[0], __FILE__, uc.args[1]);
> +		REPORT_GUEST_ASSERT(uc);
>  	}
>  }
>  
> @@ -610,7 +609,7 @@ static int handle_ucall(struct kvm_vcpu *vcpu)
>  
>  	switch (get_ucall(vcpu, &uc)) {
>  	case UCALL_ABORT:
> -		TEST_FAIL("Guest assertion not met");
> +		REPORT_GUEST_ASSERT(uc);
>  		break;
>  	case UCALL_SYNC:
>  		vm_ioctl(vcpu->vm, KVM_X86_SET_MSR_FILTER, &no_filter_deny);
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
> index ccb05ef7234e..d3582cea1258 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_apic_access_test.c
> @@ -114,8 +114,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -				  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			apic_access_addr = uc.args[1];
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
> index 40c77bb706a1..e69e8963ed08 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
> @@ -74,7 +74,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s", (const char *)uc.args[0]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		default:
>  			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> index 215ffa0589d4..f378960299c0 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c
> @@ -123,8 +123,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -			       	  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			/*
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
> index 683f4f0a1616..8c854738f2cc 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_invalid_nested_guest_state.c
> @@ -98,7 +98,7 @@ int main(int argc, char *argv[])
>  	case UCALL_DONE:
>  		break;
>  	case UCALL_ABORT:
> -		TEST_FAIL("%s", (const char *)uc.args[0]);
> +		REPORT_GUEST_ASSERT(uc);
>  	default:
>  		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
>  	}
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> index ff4644038c55..6bfef77b87b7 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> @@ -194,7 +194,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s", (const char *) uc.args[0]);
> +			REPORT_GUEST_ASSERT(uc);
>  		case UCALL_SYNC:
>  			switch (uc.args[0]) {
>  			case USLEEP:
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> index 99e57b0cc2c9..0a8e989d4200 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c
> @@ -189,8 +189,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
> -				  __FILE__, uc.args[1]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			break;
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> index e32bfb102699..2e75eef926ca 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
> @@ -147,7 +147,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s", (const char *)uc.args[0]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			report(uc.args[1]);
> diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> index a4a78637c35a..8a5cb800f50e 100644
> --- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
> @@ -542,7 +542,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s", (const char *)uc.args[0]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC: {
>  			struct kvm_xen_vcpu_attr rst;
> diff --git a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> index 8b76cade9bcd..88914d48c65e 100644
> --- a/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/xen_vmcall_test.c
> @@ -129,7 +129,7 @@ int main(int argc, char *argv[])
>  
>  		switch (get_ucall(vcpu, &uc)) {
>  		case UCALL_ABORT:
> -			TEST_FAIL("%s", (const char *)uc.args[0]);
> +			REPORT_GUEST_ASSERT(uc);
>  			/* NOT REACHED */
>  		case UCALL_SYNC:
>  			break;
> -- 
> 2.36.1.476.g0c4daa206d-goog
>

Thanks,
drew 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
