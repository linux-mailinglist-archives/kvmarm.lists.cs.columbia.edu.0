Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37237BD91
	for <lists+kvmarm@lfdr.de>; Wed, 12 May 2021 15:00:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05A474B4A3;
	Wed, 12 May 2021 09:00:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inl12QqULRWu; Wed, 12 May 2021 09:00:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AEDCE4B6C8;
	Wed, 12 May 2021 09:00:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3AA804B28E
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 May 2021 09:00:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Zbwgw1+ZH-c for <kvmarm@lists.cs.columbia.edu>;
 Wed, 12 May 2021 09:00:35 -0400 (EDT)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6C81A4B838
 for <kvmarm@lists.cs.columbia.edu>; Wed, 12 May 2021 09:00:11 -0400 (EDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgFF34cb2z1BLCm;
 Wed, 12 May 2021 20:57:27 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 20:59:59 +0800
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add exception handling support for
 aarch64
To: Auger Eric <eric.auger@redhat.com>
References: <20210430232408.2707420-1-ricarkol@google.com>
 <20210430232408.2707420-5-ricarkol@google.com> <87a6pcumyg.wl-maz@kernel.org>
 <YJBLFVoRmsehRJ1N@google.com>
 <20915a2f-d07c-2e61-3cce-ff385e98e796@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4f7f81f9-8da0-b4ef-49e2-7d87b5c23b15@huawei.com>
Date: Wed, 12 May 2021 20:59:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20915a2f-d07c-2e61-3cce-ff385e98e796@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>, pbonzini@redhat.com,
 kvmarm@lists.cs.columbia.edu
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

Hi Eric,

On 2021/5/6 20:30, Auger Eric wrote:
> running the test on 5.12 I get
> 
> ==== Test Assertion Failure ====
>   aarch64/debug-exceptions.c:232: false
>   pid=6477 tid=6477 errno=4 - Interrupted system call
>      1	0x000000000040147b: main at debug-exceptions.c:230
>      2	0x000003ff8aa60de3: ?? ??:0
>      3	0x0000000000401517: _start at :?
>   Failed guest assert: hw_bp_addr == PC(hw_bp) at
> aarch64/debug-exceptions.c:105
> 	values: 0, 0x401794

FYI I can also reproduce it on my VHE box. And Drew's suggestion [*]
seemed to work for me. Is the ISB a requirement of architecture?

[*] https://lore.kernel.org/kvm/20210503124925.wxdcyzharpyzeu4v@gator.home/


Thanks,
Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
