Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3910DCDA
	for <lists+kvmarm@lfdr.de>; Sat, 30 Nov 2019 07:58:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A64AB4A52C;
	Sat, 30 Nov 2019 01:58:31 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nlQY7P+ZQGLv; Sat, 30 Nov 2019 01:58:31 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 8B89B4A576;
	Sat, 30 Nov 2019 01:58:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F25A44A524
 for <kvmarm@lists.cs.columbia.edu>; Sat, 30 Nov 2019 01:58:28 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVpUVf9r4I6o for <kvmarm@lists.cs.columbia.edu>;
 Sat, 30 Nov 2019 01:58:27 -0500 (EST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AA7A34A521
 for <kvmarm@lists.cs.columbia.edu>; Sat, 30 Nov 2019 01:58:27 -0500 (EST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 98767B9740C456E26BB8;
 Sat, 30 Nov 2019 14:58:24 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 14:58:17 +0800
Subject: Re: [PATCH] kvm/arm64: change gicv3_cpuif to static likely branch
To: Marc Zyngier <maz@kernel.org>
References: <20191130031443.41696-1-guoheyi@huawei.com>
 <86mucdzx45.wl-maz@kernel.org>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <496cb45d-c312-295c-18f2-633ec5acc976@huawei.com>
Date: Sat, 30 Nov 2019 14:58:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <86mucdzx45.wl-maz@kernel.org>
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
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



On 2019/11/30 14:39, Marc Zyngier wrote:
> On Sat, 30 Nov 2019 03:14:43 +0000,
> Heyi Guo <guoheyi@huawei.com> wrote:
>> Platforms running hypervisor nowadays are normally powerful servers
>> which at least support GICv3, so it should be better to switch
>> kvm_vgic_global_state.gicv3_cpuif to static likely branch, which can
>> reduce two "b" instructions to a single "nop" for GICv3 branches.
>>
>> We don't update arm32 specific code for they may still only have
>> GICv2.
> There is a number of disputable statements here.
>
> Out of the fairly large zoo of arm64 systems I have access to, 75% of
> them are based on GICv2, so they are still the overwhelming majority.
> Yes, they all run KVM (otherwise I would ignore them).
Really? I'm surprised to know that... Sorry I didn't see such GICv2 
platforms in my work, so I made the wrong assumption.
I don't expect much performance improvement for GICv3 platforms. The 
precondition for this patch is that few platforms running KVM are using 
GICv2. If it is not right, please just ignore it.

Thanks,
HG

>
> Furthermore, I would expect that "powerful servers" are perfectly
> capable to execute a couple of branches without breaking a sweat.
>
> Finally, you don't provide any number supporting that:
>
> - GICv3 systems see a performance improvement across the large variety
>    of CPU implementations
> - GICv2 systems don't see a performance regression
>
> Once you provide such numbers, I'll reevaluate my position. Until
> then, I'm not considering this kind of change.
>
> Thanks,
>
> 	M.
>


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
