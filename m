Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 73BAE41CAEB
	for <lists+kvmarm@lfdr.de>; Wed, 29 Sep 2021 19:13:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 047854A1B0;
	Wed, 29 Sep 2021 13:13:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AW6IE9pyQ1Ok; Wed, 29 Sep 2021 13:13:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F644407D1;
	Wed, 29 Sep 2021 13:13:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0B8F8402A9
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 13:13:07 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEk4g1hBuKpD for <kvmarm@lists.cs.columbia.edu>;
 Wed, 29 Sep 2021 13:13:05 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B16C400CF
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 13:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632935585;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGgx2cQEJ4Z8Aur9jNmrdzz9/ne5S0nhXyMQhKKuad8=;
 b=h1DQZd3Y/K8oc0YfMjxEIxdarwR73sT6KTlSS9a4L9IRis3JEqUrl+h/nl2+l/WPwuOvtT
 LPgBxu66el7xQpGjhNefylz0F99Uu0FoQuz4PyedWXY/305TTzJcW1kxQxdg4HoCRXuWXa
 mpVjMu8he6kh0GRaLGiNJKuAeetRcSM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-VT0JtWzLNhqpb4UiUOFpIQ-1; Wed, 29 Sep 2021 13:13:03 -0400
X-MC-Unique: VT0JtWzLNhqpb4UiUOFpIQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 n30-20020a05600c3b9e00b002fbbaada5d7so2993026wms.7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 29 Sep 2021 10:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=AGgx2cQEJ4Z8Aur9jNmrdzz9/ne5S0nhXyMQhKKuad8=;
 b=bjZxfN3aAXqiLGZzM+g4qFGpK1oTz8wJoMLLxAV7hZjCdWe0ZtbiTCs9PJYy53Fnss
 fQ+iZlez7p7ELw5tk7UJt+ze1z5CICLXmhhYMorFtFurn1w4EN0wvJwA4MaP2CFxo/am
 /i1iC6mz6JwnLsJrPYj7YtajgJlmoMPSVsQNOIv5dVFChIglOFx+pMvF8sNNxynJjEt2
 mXkT1PIxT0HFU6fAuJjpO5uqQbWJBo4JsOnzVrrXzst7OuYjl83In02jDwXykCaaN3O4
 ZGpsprFR4wDER1/QuKfiTw0OSizcLZx7psSDpG2OEPg/zqc+Kd8pqqvvvCUveWb0Hjzv
 nzxQ==
X-Gm-Message-State: AOAM532Egcu160tKepKaxXWFoYK9iXgL++RfNN9hGX8G1+t/ljgPB5AH
 Hrj46nvSYGxFREoILR2h1Ng/6CgGgPxXEKxLa1RsHgLCKq5Bfua4Sqp/p9Ku/fCHGYFZ5El5VET
 m8vRvFC6JSlt0Ryn+uEjKtesS
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr1217044wrz.29.1632935582274;
 Wed, 29 Sep 2021 10:13:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxrbjXnADLEyycJjMrh4AYE0gnuO1kyV2/JMQAAO2T8jr8Q3y3QRP/N2JRA4yXEf7F5PaMDQ==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr1216991wrz.29.1632935581970;
 Wed, 29 Sep 2021 10:13:01 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id t13sm461947wro.76.2021.09.29.10.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 10:13:01 -0700 (PDT)
Subject: Re: [PATCH v3 05/10] KVM: arm64: selftests: Make vgic_init gic
 version agnostic
To: Ricardo Koller <ricarkol@google.com>, kvm@vger.kernel.org,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, drjones@redhat.com,
 alexandru.elisei@arm.com
References: <20210928184803.2496885-1-ricarkol@google.com>
 <20210928184803.2496885-6-ricarkol@google.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <a629c99e-cb41-fb2d-d551-6397774ba765@redhat.com>
Date: Wed, 29 Sep 2021 19:12:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210928184803.2496885-6-ricarkol@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: pshier@google.com, Paolo Bonzini <pbonzini@redhat.com>, shuah@kernel.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: eric.auger@redhat.com
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



On 9/28/21 8:47 PM, Ricardo Koller wrote:
> As a preparation for the next commits which will add some tests for
> GICv2, make aarch64/vgic_init GIC version agnostic. Add a new generic
> run_tests function(gic_dev_type) that starts all applicable tests using
> GICv3 or GICv2. GICv2 tests are attempted if GICv3 is not available in
> the system. There are currently no GICv2 tests, but the test passes now
> in GICv2 systems.
>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  .../testing/selftests/kvm/aarch64/vgic_init.c | 156 +++++++++++-------
>  1 file changed, 95 insertions(+), 61 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> index 623f31a14326..896a29f2503d 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> @@ -22,6 +22,9 @@
>  
>  #define GICR_TYPER 0x8
>  
> +#define VGIC_DEV_IS_V2(_d) ((_d) == KVM_DEV_TYPE_ARM_VGIC_V2)
> +#define VGIC_DEV_IS_V3(_d) ((_d) == KVM_DEV_TYPE_ARM_VGIC_V3)
> +
>  struct vm_gic {
>  	struct kvm_vm *vm;
>  	int gic_fd;
> @@ -30,8 +33,8 @@ struct vm_gic {
>  static int max_ipa_bits;
>  
>  /* helper to access a redistributor register */
> -static int access_redist_reg(int gicv3_fd, int vcpu, int offset,
> -			     uint32_t *val, bool write)
> +static int access_v3_redist_reg(int gicv3_fd, int vcpu, int offset,
> +				uint32_t *val, bool write)
>  {
>  	uint64_t attr = REG_OFFSET(vcpu, offset);
>  
> @@ -58,7 +61,7 @@ static int run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
>  	return 0;
>  }
>  
> -static struct vm_gic vm_gic_create(void)
> +static struct vm_gic vm_gic_v3_create(void)
>  {
>  	struct vm_gic v;
>  
> @@ -80,7 +83,7 @@ static void vm_gic_destroy(struct vm_gic *v)
>   * device gets created, a legacy RDIST region is set at @0x0
>   * and a DIST region is set @0x60000
>   */
> -static void subtest_dist_rdist(struct vm_gic *v)
> +static void subtest_v3_dist_rdist(struct vm_gic *v)
>  {
>  	int ret;
>  	uint64_t addr;
> @@ -145,7 +148,7 @@ static void subtest_dist_rdist(struct vm_gic *v)
>  }
>  
>  /* Test the new REDIST region API */
> -static void subtest_redist_regions(struct vm_gic *v)
> +static void subtest_v3_redist_regions(struct vm_gic *v)
>  {
>  	uint64_t addr, expected_addr;
>  	int ret;
> @@ -249,7 +252,7 @@ static void subtest_redist_regions(struct vm_gic *v)
>   * VGIC KVM device is created and initialized before the secondary CPUs
>   * get created
>   */
> -static void test_vgic_then_vcpus(void)
> +static void test_v3_vgic_then_vcpus(uint32_t gic_dev_type)
>  {
>  	struct vm_gic v;
>  	int ret, i;
> @@ -257,7 +260,7 @@ static void test_vgic_then_vcpus(void)
>  	v.vm = vm_create_default(0, 0, guest_code);
>  	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
>  
> -	subtest_dist_rdist(&v);
> +	subtest_v3_dist_rdist(&v);
>  
>  	/* Add the rest of the VCPUs */
>  	for (i = 1; i < NR_VCPUS; ++i)
> @@ -270,14 +273,14 @@ static void test_vgic_then_vcpus(void)
>  }
>  
>  /* All the VCPUs are created before the VGIC KVM device gets initialized */
> -static void test_vcpus_then_vgic(void)
> +static void test_v3_vcpus_then_vgic(uint32_t gic_dev_type)
>  {
>  	struct vm_gic v;
>  	int ret;
>  
> -	v = vm_gic_create();
> +	v = vm_gic_v3_create();
>  
> -	subtest_dist_rdist(&v);
> +	subtest_v3_dist_rdist(&v);
>  
>  	ret = run_vcpu(v.vm, 3);
>  	TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
> @@ -285,15 +288,15 @@ static void test_vcpus_then_vgic(void)
>  	vm_gic_destroy(&v);
>  }
>  
> -static void test_new_redist_regions(void)
> +static void test_v3_new_redist_regions(void)
>  {
>  	void *dummy = NULL;
>  	struct vm_gic v;
>  	uint64_t addr;
>  	int ret;
>  
> -	v = vm_gic_create();
> -	subtest_redist_regions(&v);
> +	v = vm_gic_v3_create();
> +	subtest_v3_redist_regions(&v);
>  	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>  			  KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
>  
> @@ -303,8 +306,8 @@ static void test_new_redist_regions(void)
>  
>  	/* step2 */
>  
> -	v = vm_gic_create();
> -	subtest_redist_regions(&v);
> +	v = vm_gic_v3_create();
> +	subtest_v3_redist_regions(&v);
>  
>  	addr = REDIST_REGION_ATTR_ADDR(1, 0x280000, 0, 2);
>  	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
> @@ -317,8 +320,8 @@ static void test_new_redist_regions(void)
>  
>  	/* step 3 */
>  
> -	v = vm_gic_create();
> -	subtest_redist_regions(&v);
> +	v = vm_gic_v3_create();
> +	subtest_v3_redist_regions(&v);
>  
>  	_kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
>  			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, dummy, true);
> @@ -338,7 +341,7 @@ static void test_new_redist_regions(void)
>  	vm_gic_destroy(&v);
>  }
>  
> -static void test_typer_accesses(void)
> +static void test_v3_typer_accesses(void)
>  {
>  	struct vm_gic v;
>  	uint64_t addr;
> @@ -351,12 +354,12 @@ static void test_typer_accesses(void)
>  
>  	vm_vcpu_add_default(v.vm, 3, guest_code);
>  
> -	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
>  	TEST_ASSERT(ret && errno == EINVAL, "attempting to read GICR_TYPER of non created vcpu");
>  
>  	vm_vcpu_add_default(v.vm, 1, guest_code);
>  
> -	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
>  	TEST_ASSERT(ret && errno == EBUSY, "read GICR_TYPER before GIC initialized");
>  
>  	vm_vcpu_add_default(v.vm, 2, guest_code);
> @@ -365,7 +368,7 @@ static void test_typer_accesses(void)
>  			  KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
>  
>  	for (i = 0; i < NR_VCPUS ; i++) {
> -		ret = access_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
> +		ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
>  		TEST_ASSERT(!ret && !val, "read GICR_TYPER before rdist region setting");
>  	}
>  
> @@ -374,10 +377,10 @@ static void test_typer_accesses(void)
>  			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
>  
>  	/* The 2 first rdists should be put there (vcpu 0 and 3) */
> -	ret = access_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && !val, "read typer of rdist #0");
>  
> -	ret = access_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x310, "read typer of rdist #1");
>  
>  	addr = REDIST_REGION_ATTR_ADDR(10, 0x100000, 0, 1);
> @@ -385,11 +388,11 @@ static void test_typer_accesses(void)
>  				 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
>  	TEST_ASSERT(ret && errno == EINVAL, "collision with previous rdist region");
>  
> -	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x100,
>  		    "no redist region attached to vcpu #1 yet, last cannot be returned");
>  
> -	ret = access_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x200,
>  		    "no redist region attached to vcpu #2, last cannot be returned");
>  
> @@ -397,10 +400,10 @@ static void test_typer_accesses(void)
>  	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
>  			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
>  
> -	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x100, "read typer of rdist #1");
>  
> -	ret = access_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x210,
>  		    "read typer of rdist #1, last properly returned");
>  
> @@ -417,7 +420,7 @@ static void test_typer_accesses(void)
>   * rdist region #2 @0x200000 2 rdist capacity
>   *     rdists: 1, 2
>   */
> -static void test_last_bit_redist_regions(void)
> +static void test_v3_last_bit_redist_regions(void)
>  {
>  	uint32_t vcpuids[] = { 0, 3, 5, 4, 1, 2 };
>  	struct vm_gic v;
> @@ -444,29 +447,29 @@ static void test_last_bit_redist_regions(void)
>  	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
>  			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &addr, true);
>  
> -	ret = access_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x000, "read typer of rdist #0");
>  
> -	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x100, "read typer of rdist #1");
>  
> -	ret = access_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x200, "read typer of rdist #2");
>  
> -	ret = access_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x310, "read typer of rdist #3");
>  
> -	ret = access_redist_reg(v.gic_fd, 5, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 5, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x500, "read typer of rdist #5");
>  
> -	ret = access_redist_reg(v.gic_fd, 4, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 4, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x410, "read typer of rdist #4");
>  
>  	vm_gic_destroy(&v);
>  }
>  
>  /* Test last bit with legacy region */
> -static void test_last_bit_single_rdist(void)
> +static void test_v3_last_bit_single_rdist(void)
>  {
>  	uint32_t vcpuids[] = { 0, 3, 5, 4, 1, 2 };
>  	struct vm_gic v;
> @@ -485,28 +488,32 @@ static void test_last_bit_single_rdist(void)
>  	kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
>  			  KVM_VGIC_V3_ADDR_TYPE_REDIST, &addr, true);
>  
> -	ret = access_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x000, "read typer of rdist #0");
>  
> -	ret = access_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 3, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x300, "read typer of rdist #1");
>  
> -	ret = access_redist_reg(v.gic_fd, 5, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 5, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x500, "read typer of rdist #2");
>  
> -	ret = access_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 1, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x100, "read typer of rdist #3");
>  
> -	ret = access_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
> +	ret = access_v3_redist_reg(v.gic_fd, 2, GICR_TYPER, &val, false);
>  	TEST_ASSERT(!ret && val == 0x210, "read typer of rdist #3");
>  
>  	vm_gic_destroy(&v);
>  }
>  
> -void test_kvm_device(void)
> +/*
> + * Returns 0 if it's possible to create GIC device of a given type (V2 or V3).
> + */
> +int test_kvm_device(uint32_t gic_dev_type)
>  {
>  	struct vm_gic v;
>  	int ret, fd;
> +	uint32_t other;
>  
>  	v.vm = vm_create_default_with_vcpus(NR_VCPUS, 0, 0, guest_code, NULL);
>  
> @@ -514,38 +521,65 @@ void test_kvm_device(void)
>  	ret = _kvm_create_device(v.vm, 0, true, &fd);
>  	TEST_ASSERT(ret && errno == ENODEV, "unsupported device");
>  
> -	/* trial mode with VGIC_V3 device */
> -	ret = _kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, true, &fd);
> -	if (ret) {
> -		print_skip("GICv3 not supported");
> -		exit(KSFT_SKIP);
> -	}
> -	v.gic_fd = kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> +	/* trial mode */
> +	ret = _kvm_create_device(v.vm, gic_dev_type, true, &fd);
> +	if (ret)
> +		return ret;
> +	v.gic_fd = kvm_create_device(v.vm, gic_dev_type, false);
> +
> +	ret = _kvm_create_device(v.vm, gic_dev_type, false, &fd);
> +	TEST_ASSERT(ret && errno == EEXIST, "create GIC device twice");
>  
> -	ret = _kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, false, &fd);
> -	TEST_ASSERT(ret && errno == EEXIST, "create GICv3 device twice");
> +	kvm_create_device(v.vm, gic_dev_type, true);
>  
> -	kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
> +	/* try to create the other gic_dev_type */
> +	other = VGIC_DEV_IS_V2(gic_dev_type) ? KVM_DEV_TYPE_ARM_VGIC_V3
> +					     : KVM_DEV_TYPE_ARM_VGIC_V2;
>  
> -	if (!_kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V2, true, &fd)) {
> -		ret = _kvm_create_device(v.vm, KVM_DEV_TYPE_ARM_VGIC_V2, false, &fd);
> -		TEST_ASSERT(ret && errno == EINVAL, "create GICv2 while v3 exists");
> +	if (!_kvm_create_device(v.vm, other, true, &fd)) {
> +		ret = _kvm_create_device(v.vm, other, false, &fd);
> +		TEST_ASSERT(ret && errno == EINVAL,
> +				"create GIC device while other version exists");
>  	}
>  
>  	vm_gic_destroy(&v);
> +
> +	return 0;
> +}
> +
> +void run_tests(uint32_t gic_dev_type)
> +{
> +	if (VGIC_DEV_IS_V3(gic_dev_type)) {
> +		test_v3_vcpus_then_vgic(gic_dev_type);
> +		test_v3_vgic_then_vcpus(gic_dev_type);
> +		test_v3_new_redist_regions();
> +		test_v3_typer_accesses();
> +		test_v3_last_bit_redist_regions();
> +		test_v3_last_bit_single_rdist();
> +	}
>  }
>  
>  int main(int ac, char **av)
>  {
> +	int ret;
> +
>  	max_ipa_bits = kvm_check_cap(KVM_CAP_ARM_VM_IPA_SIZE);
>  
> -	test_kvm_device();
> -	test_vcpus_then_vgic();
> -	test_vgic_then_vcpus();
> -	test_new_redist_regions();
> -	test_typer_accesses();
> -	test_last_bit_redist_regions();
> -	test_last_bit_single_rdist();
> +	ret = test_kvm_device(KVM_DEV_TYPE_ARM_VGIC_V3);
> +	if (!ret) {
> +		pr_info("Running GIC_v3 tests.\n");
> +		run_tests(KVM_DEV_TYPE_ARM_VGIC_V3);
> +		return 0;
If the GICv3 supports compat with GICv2, I think you could be able to
run both tests consecutively. So maybe don't return?

Besides looks good
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> +	}
> +
> +	ret = test_kvm_device(KVM_DEV_TYPE_ARM_VGIC_V2);
> +	if (!ret) {
> +		pr_info("Running GIC_v2 tests.\n");
> +		run_tests(KVM_DEV_TYPE_ARM_VGIC_V2);
> +		return 0;
> +	}

>  
> +	print_skip("No GICv2 nor GICv3 support");
> +	exit(KSFT_SKIP);
>  	return 0;
>  }

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
