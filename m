Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 062371DA903
	for <lists+kvmarm@lfdr.de>; Wed, 20 May 2020 06:18:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 76AA74B156;
	Wed, 20 May 2020 00:18:32 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YKaGGZ70kSEw; Wed, 20 May 2020 00:18:32 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E26F4B147;
	Wed, 20 May 2020 00:18:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B6D704B124
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 May 2020 00:18:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rTLZ+uqRZxI7 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 20 May 2020 00:18:28 -0400 (EDT)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3C2874B0A0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 20 May 2020 00:18:28 -0400 (EDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 24DE0BE1E417F974CF3B;
 Wed, 20 May 2020 12:17:18 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.58) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 20 May 2020
 12:17:10 +0800
Subject: Re: [kvm-unit-tests PATCH 6/6] arm64: microbench: Add vtimer latency
 test
To: Andrew Jones <drjones@redhat.com>
References: <20200517100900.30792-1-wangjingyi11@huawei.com>
 <20200517100900.30792-7-wangjingyi11@huawei.com>
 <20200518070507.pvs4iol34wc2zjkz@kamzik.brq.redhat.com>
From: Jingyi Wang <wangjingyi11@huawei.com>
Message-ID: <b54b95c3-3403-f625-a592-fd2eddb96f50@huawei.com>
Date: Wed, 20 May 2020 12:16:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200518070507.pvs4iol34wc2zjkz@kamzik.brq.redhat.com>
Content-Language: en-US
X-Originating-IP: [10.173.222.58]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu
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

On 5/18/2020 3:05 PM, Andrew Jones wrote:
> On Sun, May 17, 2020 at 06:09:00PM +0800, Jingyi Wang wrote:
>> Triggers PPIs by setting up a 10msec timer and test the latency.
>> For this test can be time consuming, we add time limit for loop_test
>> to make sure each test should be done in a certain time(5 sec here).
> 
> Having a time limit for the micro-bench tests might be a good idea, as
> the overall unit test timeout configured by unittests.cfg can't measure
> each individual micro-bench test separately, but it seems what we're
> really doing here is saying that we can't do 65536 10ms long vtimer-ppi
> tests, so let's do 500 instead -- however by using time to dictate the
> count.
> 
> I think I'd rather see NTIMES be changed to a micro-bench test parameter
> that defaults to 65536, but for the vtimer-ppi test it can be set to
> something much smaller.
> 
> Also, please create a separate patch for the loop_test()/ntimes changes.
> If you'd still like to do a per micro-bench test timeout as well, then
> please create a separate patch for that too.
> 
> Thanks,
> drew
> 

Thanks for your review, I will update that in the next version.

Thanks,
Jingyi

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
