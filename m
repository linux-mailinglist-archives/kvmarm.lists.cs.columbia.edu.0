Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9726022A60D
	for <lists+kvmarm@lfdr.de>; Thu, 23 Jul 2020 05:30:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 062A84B2C2;
	Wed, 22 Jul 2020 23:30:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.502
X-Spam-Level: 
X-Spam-Status: No, score=-1.502 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	SPF_HELO_PASS=-0.001] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ONS+G-5bUQ6E; Wed, 22 Jul 2020 23:30:43 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0222D4B2B0;
	Wed, 22 Jul 2020 23:30:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 906904B2B1
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 23:30:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TuGVcnsRuD5K for <kvmarm@lists.cs.columbia.edu>;
 Wed, 22 Jul 2020 23:30:39 -0400 (EDT)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8CCD54B2A0
 for <kvmarm@lists.cs.columbia.edu>; Wed, 22 Jul 2020 23:30:39 -0400 (EDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5104EB7C2985CD5A5D6C;
 Thu, 23 Jul 2020 11:30:35 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Jul 2020 11:30:27 +0800
Subject: Re: [PATCH] KVM: arm64: Prevent vcpu_has_ptrauth from generating OOL
 functions
To: Nathan Chancellor <natechancellor@gmail.com>, Marc Zyngier <maz@kernel.org>
References: <20200722162231.3689767-1-maz@kernel.org>
 <20200723025142.GA361584@ubuntu-n2-xlarge-x86>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <b60f9cd1-adf1-b32a-e6cc-ca880506ff03@huawei.com>
Date: Thu, 23 Jul 2020 11:30:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200723025142.GA361584@ubuntu-n2-xlarge-x86>
Content-Language: en-US
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Nathan,

On 2020/7/23 10:51, Nathan Chancellor wrote:
> For the future, is there an easy way to tell which type of system I am
> using (nVHE or VHE)?

afaict the easiest way is looking at the kernel log and you will find
something like "{VHE,Hyp} mode initialized successfully". I can get the
following message on my *VHE* box:

  # cat /var/log/dmesg | grep kvm
[    4.896295] kvm [1]: IPA Size Limit: 48bits
[    4.896339] [...]
[    4.899407] kvm [1]: VHE mode initialized successfully
                         ^^^

Have a look at kvm_arch_init(). With VHE, the host kernel is running at
EL2 (aka Hyp mode).


Thanks,
Zenghui
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
