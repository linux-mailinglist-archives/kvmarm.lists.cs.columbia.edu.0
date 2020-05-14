Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 387AF1D3631
	for <lists+kvmarm@lfdr.de>; Thu, 14 May 2020 18:14:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A903A4B34E;
	Thu, 14 May 2020 12:14:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MrcNW5Aoxzhb; Thu, 14 May 2020 12:14:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA0F94B36D;
	Thu, 14 May 2020 12:14:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A13174B34F
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 May 2020 12:14:33 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gii6ripORc6r for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 May 2020 12:14:31 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CE3604B34E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 May 2020 12:14:31 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BA61FB;
 Thu, 14 May 2020 09:14:31 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44C223F7BB;
 Thu, 14 May 2020 09:14:30 -0700 (PDT)
Date: Thu, 14 May 2020 17:14:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: zhukeqian <zhukeqian1@huawei.com>
Subject: Re: [Question] Hardware management of stage2 page dirty state
Message-ID: <20200514161427.GD1907@gaia>
References: <0767678d-d580-eb02-c2f0-423b16526736@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0767678d-d580-eb02-c2f0-423b16526736@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Marc Zyngier <maz@kernel.org>, "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Keqian,

On Thu, May 14, 2020 at 05:16:52PM +0800, zhukeqian wrote:
> I have some questions after deep reading your patch
> https://patchwork.kernel.org/patch/8824261/ which enables hardware updates
> of the Access Flag for Stage 2 page tables.
> 
> I notice that at the bottom of commit message, you said the following words:
> "After some digging through the KVM code, I concluded that hardware DBM
> (dirty bit management) support is not feasible for Stage 2. A potential
> user would be dirty logging but this requires a different bitmap exposed
> to Qemu and, to avoid races, the stage 2 mappings need to be mapped
> read-only on clean, writable on fault. This assumption simplifies the
> hardware Stage 2 AF support."
> 
> I have three questions here.
> 
> 1. I do not understand the reason well about "not feasible". Does the main reason
>    for this is the "races" you referred?

IIRC, dirty logging works by having a bitmap populated by the host
kernel when the guest writes a page. Such write triggers a stage 2 fault
and the kernel populates the bitmap. With S2 DBM, you wouldn't get a
fault when the guest writes the page, so the host kernel would have to
periodically check which S2 entries became writable to update the qemu
bitmap.

I think the race I had in mind was that the bitmap still reports the
page as clean while the guest already updated it.

Looking at this again, it may not matter much as qemu can copy those
pages again when migrating and before control is handed over to the new
host.

> 2. What does the "races" refer to? Do you mean the races between [hardware S2 DBM]
>    and [dirty information collection that executed by KVM]?

Yes.

>    During VM live migration, Qemu will send dirty page iteratively and finally stop
>    VM when dirty pages is not too much. We may miss dirty pages during each iteration
>    before VM stop, but there are no races after VM stop, so we won't miss dirty pages
>    finally. It seems that "races" is not a convinced reason for "not feasible".

You are probably right. But you'd have to change the dirty tracking from
a fault mechanism to a polling one checking the S2 page tables
periodically. Or, can you check then only once after VM stop?

> 3. You said that disable hardware S2 DBM support can simplify the hardware S2 AF support.
>    Could you please explain the reason in detail?

I probably meant that it simplifies the patch rather than something
specific to the AF support. If you add DBM, you'd need to make sure that
making a pte read-only doesn't lose the dirty information (see
ptep_set_wrprotect(), not sure whether KVM uses the same macro).

-- 
Catalin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
