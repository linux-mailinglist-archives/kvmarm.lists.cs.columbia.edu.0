Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9615FC79
	for <lists+kvmarm@lfdr.de>; Sat, 15 Feb 2020 04:42:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E9934A576;
	Fri, 14 Feb 2020 22:42:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtLXqKprtCMh; Fri, 14 Feb 2020 22:42:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2180F4AED9;
	Fri, 14 Feb 2020 22:42:03 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DAFC94AEC4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 22:42:01 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OXeZyG+f+U8m for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 Feb 2020 22:42:00 -0500 (EST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 586E24AE96
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 Feb 2020 22:42:00 -0500 (EST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7B2EBC6613FE84DAD0A9;
 Sat, 15 Feb 2020 11:41:55 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 15 Feb 2020
 11:41:47 +0800
Subject: Re: [PATCH kvm-unit-tests v3] arm64: timer: Speed up gic-timer-state
 check
To: Andrew Jones <drjones@redhat.com>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>
References: <20200213093257.23367-1-drjones@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <cb4b85c1-7b25-f930-f09d-3ef86bc33930@huawei.com>
Date: Sat, 15 Feb 2020 11:41:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200213093257.23367-1-drjones@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Cc: andre.przywara@arm.com
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

Hi Drew,

On 2020/2/13 17:32, Andrew Jones wrote:
> Let's bail out of the wait loop if we see the expected state
> to save over six seconds of run time. Make sure we wait a bit
> before reading the registers and double check again after,
> though, to somewhat mitigate the chance of seeing the expected
> state by accident.
> 
> We also take this opportunity to push more IRQ state code to
> the library.
> 
> Cc: Zenghui Yu <yuzenghui@huawei.com>

Please feel free to replace this with:

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Tested-by: Zenghui Yu <yuzenghui@huawei.com>

> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>


Thanks

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
