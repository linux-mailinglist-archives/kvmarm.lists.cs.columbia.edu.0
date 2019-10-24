Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1499CE2FA3
	for <lists+kvmarm@lfdr.de>; Thu, 24 Oct 2019 12:59:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 89ECC4A873;
	Thu, 24 Oct 2019 06:59:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0O7qvyzgJWjw; Thu, 24 Oct 2019 06:59:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D99C4A847;
	Thu, 24 Oct 2019 06:59:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 93FCB4A783
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Oct 2019 06:59:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4w8Bqvk7uj1 for <kvmarm@lists.cs.columbia.edu>;
 Thu, 24 Oct 2019 06:59:01 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 768784A669
 for <kvmarm@lists.cs.columbia.edu>; Thu, 24 Oct 2019 06:59:01 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 050F6497;
 Thu, 24 Oct 2019 03:59:01 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FA893F71A;
 Thu, 24 Oct 2019 03:58:55 -0700 (PDT)
Subject: Re: [PATCH RFC 0/7] Support KVM being compiled as a kernel module on
 arm64
To: Shannon Zhao <shannon.zhao@linux.alibaba.com>
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
From: James Morse <james.morse@arm.com>
Message-ID: <8cbd81d6-4ab8-9d2a-5162-8782201cd13d@arm.com>
Date: Thu, 24 Oct 2019 11:58:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
Content-Language: en-GB
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Shannon,

On 24/10/2019 11:27, Shannon Zhao wrote:
> Curently KVM ARM64 doesn't support to compile as a kernel module. It's
> useful to compile KVM as a module.

> For example, it could reload kvm without rebooting host machine.

What problem does this solve?

KVM has some funny requirements that aren't normal for a module. On v8.0 hardware it must
have an idmap. Modules don't usually expect their code to be physically contiguous, but
KVM does. KVM influences they way some of the irqchip stuff is set up during early boot
(EOI mode ... not that I understand it).

(I think KVM-as-a-module on x86 is an artifact of how it was developed)


> This patchset support this feature while there are some limitations
> to be solved. But I just send it out as RFC to get more suggestion and
> comments.

> Curently it only supports for VHE system due to the hyp code section
> address variables like __hyp_text_start.

We still need to support !VHE systems, and we need to do it with a single image.


> Also it can't call
> kvm_update_va_mask when loading kvm module and kernel panic with below
> errors. So I make kern_hyp_va into a nop funtion.

Making this work for the single-Image on v8.0 is going to be a tremendous amount of work.
What is the payoff?


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
