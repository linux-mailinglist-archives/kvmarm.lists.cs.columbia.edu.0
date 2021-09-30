Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4794841D687
	for <lists+kvmarm@lfdr.de>; Thu, 30 Sep 2021 11:41:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA1EB4B0CB;
	Thu, 30 Sep 2021 05:41:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBkyIoUhEw71; Thu, 30 Sep 2021 05:41:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C0B224B0C0;
	Thu, 30 Sep 2021 05:41:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EBF6A4B091
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Sep 2021 05:41:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XbNQSe7wjuCp for <kvmarm@lists.cs.columbia.edu>;
 Thu, 30 Sep 2021 05:41:07 -0400 (EDT)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 31FA94B099
 for <kvmarm@lists.cs.columbia.edu>; Thu, 30 Sep 2021 05:41:07 -0400 (EDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HKpBK4pYVz8tXd;
 Thu, 30 Sep 2021 17:40:09 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 17:41:02 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 30 Sep 2021 17:41:01 +0800
Subject: Re: [PATCH v7 15/15] KVM: arm64: selftests: arch_timer: Support vCPU
 migration
To: Raghavendra Rao Ananta <rananta@google.com>
References: <20210914223114.435273-1-rananta@google.com>
 <20210914223114.435273-16-rananta@google.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <61419b8f-4da9-955e-b8e3-1d401d91ab1a@huawei.com>
Date: Thu, 30 Sep 2021 17:41:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210914223114.435273-16-rananta@google.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2021/9/15 6:31, Raghavendra Rao Ananta wrote:
>  static void test_run(struct kvm_vm *vm)
>  {
>  	int i, ret;
> +	pthread_t pt_vcpu_migration;
> +
> +	pthread_mutex_init(&vcpu_done_map_lock, NULL);
> +	vcpu_done_map = bitmap_alloc(test_args.nr_vcpus);

This one fails to build.

aarch64/arch_timer.c: In function 'test_run':
aarch64/arch_timer.c:321:18: warning: implicit declaration of function 
'bitmap_alloc'; did you mean 'bitmap_zalloc'? 
[-Wimplicit-function-declaration]
   vcpu_done_map = bitmap_alloc(test_args.nr_vcpus);
                   ^~~~~~~~~~~~
                   bitmap_zalloc
aarch64/arch_timer.c:321:16: warning: assignment makes pointer from 
integer without a cast [-Wint-conversion]
   vcpu_done_map = bitmap_alloc(test_args.nr_vcpus);
                 ^
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
