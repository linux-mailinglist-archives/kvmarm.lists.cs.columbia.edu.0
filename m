Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ADE553D123A
	for <lists+kvmarm@lfdr.de>; Wed, 21 Jul 2021 17:23:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3956C4B108;
	Wed, 21 Jul 2021 11:23:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XWHXbSflDB9; Wed, 21 Jul 2021 11:23:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 07E694B101;
	Wed, 21 Jul 2021 11:23:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7B5064B0CA
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Jul 2021 11:23:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wxm8kyxoKW6H for <kvmarm@lists.cs.columbia.edu>;
 Wed, 21 Jul 2021 11:23:25 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8657E4086F
 for <kvmarm@lists.cs.columbia.edu>; Wed, 21 Jul 2021 11:23:25 -0400 (EDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4F0760E0C;
 Wed, 21 Jul 2021 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626881002;
 bh=vw/HFFq3ue6OhFPtK7AmM0dhhlH17poo8NmNf3OwAe4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gmWQQW3v5zvmdC4TABkeAnsNhe9Xy5wySrMj8XF7F5XvrENYnNj7kNTViTQe9qUxP
 PwUTTYo6WAhFJ2TFh5MKKKRNF5zcDHB3mSLksdOTEp9dhVc7q5QNSjVLBU8azJYxsY
 Ql23Ok5xhdHi3hoZHlf//rFMlpZVyIstVS/4zC5PZxAWu1j0qKtbmhKDphxv0fZHeF
 RWQUqAJBFfYixZ8LmdFLHGj9rD84i15E/9WTimBZu2WEmVRnBphn7tU8V7SANXsmpG
 yKTT92NLrUExXCGOWkf+QDp0bAzc97wSfJ6XX+uDYByca7A8Gw/dyHRP/Y53nr1Ab+
 aIOZV5kwc05hg==
Date: Wed, 21 Jul 2021 16:23:17 +0100
From: Will Deacon <will@kernel.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 1/3] arch/arm64: Introduce a capability to tell
 whether 16-bit VMID is available
Message-ID: <20210721152316.GB11003@willie-the-truck>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210616155606.2806-2-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, catalin.marinas@arm.com, kvmarm@lists.cs.columbia.edu,
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

On Wed, Jun 16, 2021 at 04:56:04PM +0100, Shameer Kolothum wrote:
> From: Julien Grall <julien.grall@arm.com>
> 
> At the moment, the function kvm_get_vmid_bits() is looking up for the
> sanitized value of ID_AA64MMFR1_EL1 and extract the information
> regarding the number of VMID bits supported.
> 
> This is fine as the function is mainly used during VMID roll-over. New
> use in a follow-up patch will require the function to be called a every
> context switch so we want the function to be more efficient.
> 
> A new capability is introduced to tell whether 16-bit VMID is
> available.

I don't really buy this rationale. The VMID allocator introduced later on
caches this value in the static 'vmid_bits' variable, and that gets used
on vCPU enter via vmid_gen_match() in the kvm_arm_update_vmid() fastpath.

So I would prefer that we just expose an accessor for that than introduce
a static key and new cpufeature just for kvm_get_vttbr().

Will
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
