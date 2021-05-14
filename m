Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 795C2380996
	for <lists+kvmarm@lfdr.de>; Fri, 14 May 2021 14:32:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BF9B94B960;
	Fri, 14 May 2021 08:32:54 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofwWgM2jIN9K; Fri, 14 May 2021 08:32:54 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A2DE44B972;
	Fri, 14 May 2021 08:32:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A7EEE4B960
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 May 2021 08:32:52 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CnF+3aPB8obq for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 May 2021 08:32:50 -0400 (EDT)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 9906E4B8B8
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 May 2021 08:32:50 -0400 (EDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FhSWk1LtjzPxXP;
 Fri, 14 May 2021 20:29:22 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 20:32:38 +0800
Subject: Re: [PATCH v2 0/2] KVM: arm64: Fixup PC updates on exit to userspace
To: Marc Zyngier <maz@kernel.org>
References: <20210514104042.1929168-1-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <1ce3b260-f17f-0e7a-00ec-8a2aa810bf3e@huawei.com>
Date: Fri, 14 May 2021 20:32:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210514104042.1929168-1-maz@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

Hi Marc,

On 2021/5/14 18:40, Marc Zyngier wrote:
> We recently moved anything related to PC updates into the guest entry
> code to help with the protected KVM effort. However, I missed a
> critical point: userspace needs to be able to observe state changes
> when the vcpu exits. Otherwise, live migration is a bit broken and
> vcpu reset can fail (as reported by Zenghui). Not good.
> 
> These two patches aim at fixing the above, and carry a Cc stable.
> 
> * From v1:
>   - Sanitized flag checking
>   - Added comment about relying on __kvm_adjust_pc() being preempt-safe

I had a try but failed to find the added comment ;-). Regardless,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Tested-by: Zenghui Yu <yuzenghui@huawei.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
