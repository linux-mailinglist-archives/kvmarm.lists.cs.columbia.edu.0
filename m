Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EA8235FF544
	for <lists+kvmarm@lfdr.de>; Fri, 14 Oct 2022 23:23:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F0334966F;
	Fri, 14 Oct 2022 17:23:40 -0400 (EDT)
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
	with ESMTP id tQNaqHcI7O8v; Fri, 14 Oct 2022 17:23:40 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A2EAF4B5F4;
	Fri, 14 Oct 2022 17:23:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5193E40B91
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Oct 2022 17:23:37 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BS-IuZuYrNjC for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Oct 2022 17:23:36 -0400 (EDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C84604087B
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Oct 2022 17:23:35 -0400 (EDT)
Received: by mail-pl1-f181.google.com with SMTP id o21so3464292ple.5
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Oct 2022 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xCLcgM5p0Xi25bsK6RWh7QvQp7XU1CO69/w1Ar3c+II=;
 b=gmGiZE77o04w3Lo/ylaRSpsaJ6T0ylACDyfKIIQbAZfJj51AKsMwVt8b5o9OAJWtli
 xeXFhWam3d/geNCFfveD8OaOu0/uny3xfFLlm8HOVq+u3TlQhtZ6Gwn13Fs0xdsGHtet
 T8PknKGOZBLm8Y9bojwtyArKrCCV4obDDexbhMXkMz1fKY4EOEB70m1o6PnQcNfp1iXv
 ejURaySDblSheuAfo1aSFyStmfYzNbFZIIo0anrx7aisz0dZq8T4sFgLwBsXCrYIp7FP
 VtzarBoMc82CBTOOr+jGSyo171CJ+2BZBGMKPeCFYmoXUVatiHxa4jFlzod+LGMm2Euv
 n/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCLcgM5p0Xi25bsK6RWh7QvQp7XU1CO69/w1Ar3c+II=;
 b=FAsdHBktu/9qu3eIPFRsjf1xSM5XNmVsd1CWywq2NhUAzEURALSx0boY5iYF4HxlXF
 Hhgx99QPfEJElzR36SPcqNuJas9bz7pkheimJy6ywAAvLGWC7+wLvOICqJtM27lgSgXi
 P9zxQOi8ohbviYBGoAtE8qf4noRS5YVVLfkHqOM8Ot5QVBv1lHcwQ8CvovSnBgSqkUsz
 dWcQIT/PK72hR0y5l2ldiyHmY9gL18uCd2PTEwEwukyCd8WhYSXJJVOO9NPKAE3MZVJ8
 e4sEPtRCLtFe/On/LmG6pb6cEEsJrMdl6XSGhaaUW1HI4Kry3v886egg0g/KzO/+QJDh
 VCSA==
X-Gm-Message-State: ACrzQf0bQZGh5DRQ8gvsEX2xp/Pae2hr9XZxKDxr3DUKtMr3g6BxhQ8D
 mF/hrH9d7Zdk3S8mWkE2rATIQg==
X-Google-Smtp-Source: AMsMyM4T7f/zchI8yBfJsjb1QMLlCXvQLmbJzBWG/hENTAl0t/BseKUlwkTlh7t6m2TxyxfQCYJ0xQ==
X-Received: by 2002:a17:90a:ba90:b0:20d:3434:7f56 with SMTP id
 t16-20020a17090aba9000b0020d34347f56mr7960241pjr.105.1665782614370; 
 Fri, 14 Oct 2022 14:23:34 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com.
 [34.168.104.7]) by smtp.gmail.com with ESMTPSA id
 b10-20020a170902650a00b001752216ca51sm2161326plk.39.2022.10.14.14.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 14:23:34 -0700 (PDT)
Date: Fri, 14 Oct 2022 21:23:30 +0000
From: Sean Christopherson <seanjc@google.com>
To: Ricardo Koller <ricarkol@google.com>
Subject: Re: [PATCH v9 10/14] KVM: selftests: aarch64: Add
 aarch64/page_fault_test
Message-ID: <Y0nTUmsC7YGTQery@google.com>
References: <20221011010628.1734342-1-ricarkol@google.com>
 <20221011010628.1734342-11-ricarkol@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221011010628.1734342-11-ricarkol@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, bgardon@google.com,
 andrew.jones@linux.dev, kvmarm@lists.linux.dev, pbonzini@redhat.com,
 axelrasmussen@google.com, kvmarm@lists.cs.columbia.edu, dmatlack@google.com
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

On Tue, Oct 11, 2022, Ricardo Koller wrote:
> +/* Returns true to continue the test, and false if it should be skipped. */
> +static bool punch_hole_in_backing_store(struct kvm_vm *vm,
> +					struct userspace_mem_region *region)
> +{
> +	void *hva = (void *)region->region.userspace_addr;
> +	uint64_t paging_size = region->region.memory_size;
> +	int ret, fd = region->fd;
> +
> +	if (fd != -1) {
> +		ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				0, paging_size);
> +		TEST_ASSERT(ret == 0, "fallocate failed, errno: %d\n", errno);
> +	} else {
> +		ret = madvise(hva, paging_size, MADV_DONTNEED);
> +		TEST_ASSERT(ret == 0, "madvise failed, errno: %d\n", errno);
> +	}

Uber nit, no need to manually print the errno, TEST_ASSERT() does that automatically
and pretty prints the string too.  I know this because I keep forgetting myself :-).

> +/* Returns true to continue the test, and false if it should be skipped. */
> +static bool handle_cmd(struct kvm_vm *vm, int cmd)
> +{
> +	struct userspace_mem_region *data_region, *pt_region;
> +	bool continue_test = true;
> +
> +	data_region = vm_get_mem_region(vm, MEM_REGION_TEST_DATA);
> +	pt_region = vm_get_mem_region(vm, MEM_REGION_PT);
> +
> +	if (cmd == CMD_SKIP_TEST)
> +		continue_test = false;
> +
> +	if (cmd & CMD_HOLE_PT)
> +		continue_test = punch_hole_in_backing_store(vm, pt_region);
> +	if (cmd & CMD_HOLE_DATA)
> +		continue_test = punch_hole_in_backing_store(vm, data_region);
> +
> +	return continue_test;
> +}

...

> +static void setup_abort_handlers(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
> +		struct test_desc *test)

Align params.

static void setup_abort_handlers(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
				 struct test_desc *test)

> +static void for_each_test_and_guest_mode(
> +		void (*func)(enum vm_guest_mode m, void *a),

If you spin a new version, can you put together a patch or mini-series to add a
typedef for this function pointer?  Then this function doesn't need a funky wrap.
Or alternatively, as follow-up to avoid delaying this series even longer.

E.g.

static void for_each_test_and_guest_mode(guest_mode_test_t func,
					 enum vm_mem_backing_src_type src_type)

diff --git a/tools/testing/selftests/kvm/include/guest_modes.h b/tools/testing/selftests/kvm/include/guest_modes.h
index b691df33e64e..ee7c5c271eb2 100644
--- a/tools/testing/selftests/kvm/include/guest_modes.h
+++ b/tools/testing/selftests/kvm/include/guest_modes.h
@@ -15,7 +15,9 @@ extern struct guest_mode guest_modes[NUM_VM_MODES];
        guest_modes[mode] = (struct guest_mode){ supported, enabled }; \
 })
 
+typedef void (*guest_mode_test_t)(enum vm_guest_mode, void *);
+
 void guest_modes_append_default(void);
-void for_each_guest_mode(void (*func)(enum vm_guest_mode, void *), void *arg);
+void for_each_guest_mode(guest_mode_test_t func, void *arg);
 void guest_modes_help(void);
 void guest_modes_cmdline(const char *arg);



> +		enum vm_mem_backing_src_type src_type)
> +{
> +	struct test_desc *t;
> +
> +	for (t = &tests[0]; t->name; t++) {
> +		if (t->skip)
> +			continue;
> +
> +		struct test_params p = {
> +			.src_type = src_type,
> +			.test_desc = t,
> +		};
> +
> +		for_each_guest_mode(run_test, &p);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	enum vm_mem_backing_src_type src_type;
> +	int opt;
> +
> +	setbuf(stdout, NULL);
> +
> +	src_type = DEFAULT_VM_MEM_SRC;
> +
> +	while ((opt = getopt(argc, argv, "hm:s:")) != -1) {
> +		switch (opt) {
> +		case 'm':
> +			guest_modes_cmdline(optarg);
> +			break;
> +		case 's':
> +			src_type = parse_backing_src_type(optarg);
> +			break;
> +		case 'h':
> +		default:
> +			help(argv[0]);
> +			exit(0);
> +		}
> +	}
> +
> +	for_each_test_and_guest_mode(run_test, src_type);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
> index c1ddca8db225..5f977528e09c 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/processor.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
> @@ -105,11 +105,19 @@ enum {
>  #define ESR_EC_MASK		(ESR_EC_NUM - 1)
>  
>  #define ESR_EC_SVC64		0x15
> +#define ESR_EC_IABT		0x21
> +#define ESR_EC_DABT		0x25
>  #define ESR_EC_HW_BP_CURRENT	0x31
>  #define ESR_EC_SSTEP_CURRENT	0x33
>  #define ESR_EC_WP_CURRENT	0x35
>  #define ESR_EC_BRK_INS		0x3c
>  
> +/* Access flag */
> +#define PTE_AF			(1ULL << 10)
> +
> +/* Access flag update enable/disable */
> +#define TCR_EL1_HA		(1ULL << 39)
> +
>  void aarch64_get_supported_page_sizes(uint32_t ipa,
>  				      bool *ps4k, bool *ps16k, bool *ps64k);
>  
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
