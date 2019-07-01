Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 45BEC1B3CA
	for <lists+kvmarm@lfdr.de>; Mon, 13 May 2019 12:20:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 901A14A4E1;
	Mon, 13 May 2019 06:20:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gMb20Qv06HpD; Mon, 13 May 2019 06:20:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5985D4A4EA;
	Mon, 13 May 2019 06:20:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CB3804A4E1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 May 2019 06:20:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KofUVHZfwg+C for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 May 2019 06:20:39 -0400 (EDT)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0E1AA4A3A5
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 May 2019 06:20:39 -0400 (EDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B2A51795AEB80AF6238C;
 Mon, 13 May 2019 18:20:35 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 May 2019
 18:20:24 +0800
Subject: Re: [RFC PATCH V2] kvm: arm64: export memory error recovery
 capability to user space
To: Peter Maydell <peter.maydell@linaro.org>
References: <1557728917-49079-1-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA-S6Kh8yUqVZVA8gtDdRscgVaTfC4CwxngoS2ZPt6K9ww@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <da887bd0-75db-4ad8-cc7a-fa5df26c88fd@huawei.com>
Date: Mon, 13 May 2019 18:20:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-S6Kh8yUqVZVA8gtDdRscgVaTfC4CwxngoS2ZPt6K9ww@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 kvm-devel <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
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

On 2019/5/13 17:44, Peter Maydell wrote:
> On Mon, 13 May 2019 at 07:32, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>
>> When user space do memory recovery, it will check whether KVM and
>> guest support the error recovery, only when both of them support,
>> user space will do the error recovery. This patch exports this
>> capability of KVM to user space.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>> v1->v2:
>> 1. check whether host support memory failure instead of RAS capability
>>    https://patchwork.kernel.org/patch/10730827/
>>
>> v1:
>> 1. User space needs to check this capability of host is suggested by Peter[1],
>> this patch as RFC tag because user space patches are still under review,
>> so this kernel patch is firstly sent out for review.
>>
>> [1]: https://patchwork.codeaurora.org/patch/652261/
>> ---
> 
> I thought the conclusion of the thread on the v1 patch was that
> userspace doesn't need to specifically ask the host kernel if
> it has support for this -- if it does not, then the host kernel
> will just never deliver userspace any SIGBUS with MCEERR code,
> which is fine. Or am I still confused?

thanks Peter's quick reply.
yes, I think so, if it does not support,  then the host kernel
will just never deliver userspace any SIGBUS with MCEERR code.

so maybe we do not need this patch.

> 
> thanks
> -- PMM
> .
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
