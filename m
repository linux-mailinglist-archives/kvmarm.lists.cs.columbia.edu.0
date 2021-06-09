Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7773A0F1F
	for <lists+kvmarm@lfdr.de>; Wed,  9 Jun 2021 10:56:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7D13940874;
	Wed,  9 Jun 2021 04:56:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LieSCwGxLghE; Wed,  9 Jun 2021 04:56:55 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A45540825;
	Wed,  9 Jun 2021 04:56:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 71683405D8
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 04:56:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8UMtZH9eSyaT for <kvmarm@lists.cs.columbia.edu>;
 Wed,  9 Jun 2021 04:56:52 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 32D564024F
 for <kvmarm@lists.cs.columbia.edu>; Wed,  9 Jun 2021 04:56:52 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DAD811FB;
 Wed,  9 Jun 2021 01:56:51 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AA293F719;
 Wed,  9 Jun 2021 01:56:48 -0700 (PDT)
Subject: Re: [PATCH v14 2/8] arm64: Handle MTE tags zeroing in
 __alloc_zeroed_user_highpage()
To: Catalin Marinas <catalin.marinas@arm.com>
References: <20210607110816.25762-1-steven.price@arm.com>
 <20210607110816.25762-3-steven.price@arm.com>
 <20210607170714.GA17957@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <7a3f14de-211b-94f9-6886-393d233193d5@arm.com>
Date: Wed, 9 Jun 2021 09:56:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210607170714.GA17957@arm.com>
Content-Language: en-GB
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Marc Zyngier <maz@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 07/06/2021 18:07, Catalin Marinas wrote:
> On Mon, Jun 07, 2021 at 12:08:10PM +0100, Steven Price wrote:
>> From: Catalin Marinas <catalin.marinas@arm.com>
>>
>> Currently, on an anonymous page fault, the kernel allocates a zeroed
>> page and maps it in user space. If the mapping is tagged (PROT_MTE),
>> set_pte_at() additionally clears the tags under a spinlock to avoid a
>> race on the page->flags. In order to optimise the lock, clear the page
>> tags on allocation in __alloc_zeroed_user_highpage() if the vma flags
>> have VM_MTE set.
>>
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> I think you can drop this patch now that Peter's series has been queued
> via the arm64 tree:
> 
> https://lore.kernel.org/r/20210602235230.3928842-4-pcc@google.com
> 

Thanks for the heads up - I hadn't seen that land. I'll drop this patch
from the next posting.

Steve
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
