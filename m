Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 128471AB637
	for <lists+kvmarm@lfdr.de>; Thu, 16 Apr 2020 05:28:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 85F344B0F7;
	Wed, 15 Apr 2020 23:28:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KsB6u7XnL44O; Wed, 15 Apr 2020 23:28:17 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6F04D4B100;
	Wed, 15 Apr 2020 23:28:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2955A4B0F7
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 23:28:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WXSy8ujvcFnF for <kvmarm@lists.cs.columbia.edu>;
 Wed, 15 Apr 2020 23:28:13 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 544FD4A1FA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 15 Apr 2020 23:28:13 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0020A7D09D55C0CCF71F;
 Thu, 16 Apr 2020 11:28:09 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.230) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 16 Apr 2020 11:27:59 +0800
Subject: Re: [PATCH v2] KVM/arm64: Support enabling dirty log gradually in
 small chunks
To: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
References: <20200413122023.52583-1-zhukeqian1@huawei.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <e93e85b3-cdab-d293-6c68-c563fab46d94@huawei.com>
Date: Thu, 16 Apr 2020 11:27:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200413122023.52583-1-zhukeqian1@huawei.com>
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
Cc: Marc Zyngier <maz@kernel.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Jay Zhou <jianjay.zhou@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Will Deacon <will@kernel.org>
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

Hi Marc,

In RFC patch, I still write protect huge pages when DIRTY_LOG_INITIALLY_ALL_SET
is enabled by userspace. I find that both huge pages and normal pages can be
write protected during log clear. So this formal patch is pretty simple now.

Thanks,
Keqian

On 2020/4/13 20:20, Keqian Zhu wrote:
> There is already support of enabling dirty log graually in small chunks
> for x86 in commit 3c9bd4006bfc ("KVM: x86: enable dirty log gradually in
> small chunks"). This adds support for arm64.
> 
> x86 still writes protect all huge pages when DIRTY_LOG_INITIALLY_ALL_SET
> is eanbled. However, for arm64, both huge pages and normal pages can be
> write protected gradually by userspace.
> 
> Under the Huawei Kunpeng 920 2.6GHz platform, I did some tests on 128G
> Linux VMs with different page size. The memory pressure is 127G in each
> case. The time taken of memory_global_dirty_log_start in QEMU is listed
> below:
> 
> Page Size      Before    After Optimization
>   4K            650ms         1.8ms
>   2M             4ms          1.8ms
>   1G             2ms          1.8ms
> 
> Besides the time reduction, the biggest income is that we will minimize
> the performance side effect (because of dissloving huge pages and marking
> memslots dirty) on guest after enabling dirty log.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  Documentation/virt/kvm/api.rst    |  2 +-
>  arch/arm64/include/asm/kvm_host.h |  3 +++
>  virt/kvm/arm/mmu.c                | 12 ++++++++++--
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index efbbe570aa9b..0017f63fa44f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5777,7 +5777,7 @@ will be initialized to 1 when created.  This also improves performance because
>  dirty logging can be enabled gradually in small chunks on the first call
>  to KVM_CLEAR_DIRTY_LOG.  KVM_DIRTY_LOG_INITIALLY_SET depends on
>  KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (it is also only available on
> -x86 for now).
> +x86 and arm64 for now).
>  
>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 was previously available under the name
>  KVM_CAP_MANUAL_DIRTY_LOG_PROTECT, but the implementation had bugs that make
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 32c8a675e5a4..a723f84fab83 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -46,6 +46,9 @@
>  #define KVM_REQ_RECORD_STEAL	KVM_ARCH_REQ(3)
>  #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
>  
> +#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
> +				     KVM_DIRTY_LOG_INITIALLY_SET)
> +
>  DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
>  
>  extern unsigned int kvm_sve_max_vl;
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index e3b9ee268823..1077f653a611 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -2265,8 +2265,16 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  	 * allocated dirty_bitmap[], dirty pages will be be tracked while the
>  	 * memory slot is write protected.
>  	 */
> -	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES)
> -		kvm_mmu_wp_memory_region(kvm, mem->slot);
> +	if (change != KVM_MR_DELETE && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> +		/*
> +		 * If we're with initial-all-set, we don't need to write
> +		 * protect any pages because they're all reported as dirty.
> +		 * Huge pages and normal pages will be write protect gradually.
> +		 */
> +		if (!kvm_dirty_log_manual_protect_and_init_set(kvm)) {
> +			kvm_mmu_wp_memory_region(kvm, mem->slot);
> +		}
> +	}
>  }
>  
>  int kvm_arch_prepare_memory_region(struct kvm *kvm,
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
