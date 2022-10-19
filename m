Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A3D846039CA
	for <lists+kvmarm@lfdr.de>; Wed, 19 Oct 2022 08:31:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 16B6C4B8FF;
	Wed, 19 Oct 2022 02:31:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 required=6.1 tests=[BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdgkv3BR0bEB; Wed, 19 Oct 2022 02:31:10 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9E874B907;
	Wed, 19 Oct 2022 02:31:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DA60D4B796
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Oct 2022 17:32:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LEZqY3C1ufOg for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 Oct 2022 17:32:07 -0400 (EDT)
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AA82D4B0F4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 Oct 2022 17:32:07 -0400 (EDT)
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1okXiN-0001oB-9u; Mon, 17 Oct 2022 23:32:03 +0200
Message-ID: <3eecebca-a526-d10a-02d3-496ce919d577@maciej.szmigiero.name>
Date: Mon, 17 Oct 2022 23:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, pl-PL
To: Gavin Shan <gshan@redhat.com>
References: <20221014071914.227134-1-gshan@redhat.com>
 <20221014071914.227134-5-gshan@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 4/6] KVM: selftests: memslot_perf_test: Support variable
 guest page size
In-Reply-To: <20221014071914.227134-5-gshan@redhat.com>
X-Mailman-Approved-At: Wed, 19 Oct 2022 02:31:08 -0400
Cc: kvm@vger.kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 zhenyzha@redhat.com, shan.gavin@gmail.com, kvmarm@lists.linux.dev,
 pbonzini@redhat.com, shuah@kernel.org, kvmarm@lists.cs.columbia.edu,
 ajones@ventanamicro.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 14.10.2022 09:19, Gavin Shan wrote:
> The test case is obviously broken on aarch64 because non-4KB guest
> page size is supported. The guest page size on aarch64 could be 4KB,
> 16KB or 64KB.
> 
> This supports variable guest page size, mostly for aarch64.
> 
>    - The host determines the guest page size when virtual machine is
>      created. The value is also passed to guest through the synchronization
>      area.
> 
>    - The number of guest pages are unknown until the virtual machine
>      is to be created. So all the related macros are dropped. Instead,
>      their values are dynamically calculated based on the guest page
>      size.
> 
>    - The static checks on memory sizes and pages becomes dependent
>      on guest page size, which is unknown until the virtual machine
>      is about to be created. So all the static checks are converted
>      to dynamic checks, done in check_memory_sizes().
> 
>    - As the address passed to madvise() should be aligned to host page,
>      the size of page chunk is automatically selected, other than one
>      page.
> 
>    - All other changes included in this patch are almost mechanical
>      replacing '4096' with 'guest_page_size'.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   .../testing/selftests/kvm/memslot_perf_test.c | 191 +++++++++++-------
>   1 file changed, 115 insertions(+), 76 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
> index d5aa9148f96f..d587bd952ff9 100644
> --- a/tools/testing/selftests/kvm/memslot_perf_test.c
> +++ b/tools/testing/selftests/kvm/memslot_perf_test.c
> @@ -26,14 +26,11 @@
>   #include <processor.h>
>   
>   #define MEM_SIZE		((512U << 20) + 4096)
> -#define MEM_SIZE_PAGES		(MEM_SIZE / 4096)
>   #define MEM_GPA		0x10000000UL
>   #define MEM_AUX_GPA		MEM_GPA
>   #define MEM_SYNC_GPA		MEM_AUX_GPA
>   #define MEM_TEST_GPA		(MEM_AUX_GPA + 4096)
>   #define MEM_TEST_SIZE		(MEM_SIZE - 4096)
> -static_assert(MEM_SIZE % 4096 == 0, "invalid mem size");
> -static_assert(MEM_TEST_SIZE % 4096 == 0, "invalid mem test size");
>   
>   /*
>    * 32 MiB is max size that gets well over 100 iterations on 509 slots.
> @@ -42,29 +39,16 @@ static_assert(MEM_TEST_SIZE % 4096 == 0, "invalid mem test size");
>    * limited resolution).
>    */
>   #define MEM_SIZE_MAP		((32U << 20) + 4096)
> -#define MEM_SIZE_MAP_PAGES	(MEM_SIZE_MAP / 4096)
>   #define MEM_TEST_MAP_SIZE	(MEM_SIZE_MAP - 4096)
> -#define MEM_TEST_MAP_SIZE_PAGES (MEM_TEST_MAP_SIZE / 4096)
> -static_assert(MEM_SIZE_MAP % 4096 == 0, "invalid map test region size");
> -static_assert(MEM_TEST_MAP_SIZE % 4096 == 0, "invalid map test region size");
> -static_assert(MEM_TEST_MAP_SIZE_PAGES % 2 == 0, "invalid map test region size");
> -static_assert(MEM_TEST_MAP_SIZE_PAGES > 2, "invalid map test region size");
>   
>   /*
>    * 128 MiB is min size that fills 32k slots with at least one page in each
>    * while at the same time gets 100+ iterations in such test
> + *
> + * 2 MiB chunk size like a typical huge page
>    */
>   #define MEM_TEST_UNMAP_SIZE		(128U << 20)
> -#define MEM_TEST_UNMAP_SIZE_PAGES	(MEM_TEST_UNMAP_SIZE / 4096)
> -/* 2 MiB chunk size like a typical huge page */
> -#define MEM_TEST_UNMAP_CHUNK_PAGES	(2U << (20 - 12))
> -static_assert(MEM_TEST_UNMAP_SIZE <= MEM_TEST_SIZE,
> -	      "invalid unmap test region size");
> -static_assert(MEM_TEST_UNMAP_SIZE % 4096 == 0,
> -	      "invalid unmap test region size");
> -static_assert(MEM_TEST_UNMAP_SIZE_PAGES %
> -	      (2 * MEM_TEST_UNMAP_CHUNK_PAGES) == 0,
> -	      "invalid unmap test region size");
> +#define MEM_TEST_UNMAP_CHUNK_SIZE	(2U << 20)
>   
>   /*
>    * For the move active test the middle of the test area is placed on
> @@ -77,8 +61,7 @@ static_assert(MEM_TEST_UNMAP_SIZE_PAGES %
>    * for the total size of 25 pages.
>    * Hence, the maximum size here is 50 pages.
>    */
> -#define MEM_TEST_MOVE_SIZE_PAGES	(50)
> -#define MEM_TEST_MOVE_SIZE		(MEM_TEST_MOVE_SIZE_PAGES * 4096)
> +#define MEM_TEST_MOVE_SIZE		0x32000

The above number seems less readable than an explicit value of 50 pages.

In addition to that, it's 50 pages only with 4k page size, so at least
the comment above needs to be updated to reflect this fact.

>   #define MEM_TEST_MOVE_GPA_DEST		(MEM_GPA + MEM_SIZE)
>   static_assert(MEM_TEST_MOVE_SIZE <= MEM_TEST_SIZE,
>   	      "invalid move test region size");
(...)
> @@ -242,33 +229,34 @@ static struct vm_data *alloc_vm(void)
>   }
>   
>   static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
> -		       void *guest_code, uint64_t mempages,
> +		       void *guest_code, uint64_t mem_size,
>   		       struct timespec *slot_runtime)
>   {
> -	uint64_t rempages;
> +	uint64_t mempages, rempages;
>   	uint64_t guest_addr;
> -	uint32_t slot;
> +	uint32_t slot, guest_page_size;
>   	struct timespec tstart;
>   	struct sync_area *sync;
>   
> -	TEST_ASSERT(mempages > 1,
> -		    "Can't test without any memory");
> +	guest_page_size = vm_guest_mode_params[VM_MODE_DEFAULT].page_size;
> +	mempages = mem_size / guest_page_size;
> +
> +	data->vm = __vm_create_with_one_vcpu(&data->vcpu, mempages, guest_code);
> +	ucall_init(data->vm, NULL);
>

TEST_ASSERT(data->vm->page_size == guest_page_size, "Invalid VM page size")
here would catch the case if someone accidentally modifies
__vm_create_with_one_vcpu() to use other page size than specified for
VM_MODE_DEFAULT.

>   	data->npages = mempages;
> +	TEST_ASSERT(data->npages > 1, "Can't test without any memory");
>   	data->nslots = nslots;
> -	data->pages_per_slot = mempages / data->nslots;
> +	data->pages_per_slot = data->npages / data->nslots;
>   	if (!data->pages_per_slot) {
> -		*maxslots = mempages + 1;
> +		*maxslots = data->npages + 1;
>   		return false;
>   	}
>   
> -	rempages = mempages % data->nslots;
> +	rempages = data->npages % data->nslots;
>   	data->hva_slots = malloc(sizeof(*data->hva_slots) * data->nslots);
>   	TEST_ASSERT(data->hva_slots, "malloc() fail");
>   
> -	data->vm = __vm_create_with_one_vcpu(&data->vcpu, mempages, guest_code);
> -	ucall_init(data->vm, NULL);
> -
>   	pr_info_v("Adding slots 1..%i, each slot with %"PRIu64" pages + %"PRIu64" extra pages last\n",
>   		data->nslots, data->pages_per_slot, rempages);
>   
(...)
> @@ -856,6 +863,35 @@ static void help(char *name, struct test_args *targs)
>   		pr_info("%d: %s\n", ctr, tests[ctr].name);
>   }
>   
> +static bool check_memory_sizes(void)
> +{
> +	uint32_t guest_page_size = vm_guest_mode_params[VM_MODE_DEFAULT].page_size;
> +
> +	if (MEM_SIZE % guest_page_size ||
> +	    MEM_TEST_SIZE % guest_page_size) {
> +		pr_info("invalid MEM_SIZE or MEM_TEST_SIZE\n");
> +		return false;
> +	}
> +
> +	if (MEM_SIZE_MAP % guest_page_size		||
> +	    MEM_TEST_MAP_SIZE % guest_page_size		||
> +	    (MEM_TEST_MAP_SIZE / guest_page_size) <= 2	||
> +	    (MEM_TEST_MAP_SIZE / guest_page_size) % 2) {
> +		pr_info("invalid MEM_SIZE_MAP or MEM_TEST_MAP_SIZE\n");
> +		return false;
> +	}
> +
> +	if (MEM_TEST_UNMAP_SIZE > MEM_TEST_SIZE		||
> +	    MEM_TEST_UNMAP_SIZE % guest_page_size	||
> +	    (MEM_TEST_UNMAP_SIZE / guest_page_size) %
> +	    (MEM_TEST_UNMAP_CHUNK_SIZE / guest_page_size)) {

This should be (MEM_TEST_UNMAP_SIZE / guest_page_size) % (2 * MEM_TEST_UNMAP_CHUNK_SIZE / guest_page_size))
to match the old static_assert().

Thanks,
Maciej

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
