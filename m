Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA51ABED3
	for <lists+kvmarm@lfdr.de>; Thu, 16 Apr 2020 13:10:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AAAFE4B261;
	Thu, 16 Apr 2020 07:10:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@mg.codeaurora.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TqJMW2zfBfPs; Thu, 16 Apr 2020 07:10:24 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E1644B26B;
	Thu, 16 Apr 2020 07:10:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 425B24B157
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Apr 2020 04:39:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DuRIUgPMeJbb for <kvmarm@lists.cs.columbia.edu>;
 Thu, 16 Apr 2020 04:39:48 -0400 (EDT)
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 5BD574B12B
 for <kvmarm@lists.cs.columbia.edu>; Thu, 16 Apr 2020 04:39:46 -0400 (EDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587026388; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uYTomwNJ7JVKnSJj43lc2hrUMA3IdsRKM3uaYsQJc+A=;
 b=T0YIR0kcnPMqh8xH9nsMCUR3u5CDv4lJV2u9xSy0lw1N2gFvKUePhme7gxNQ0YfojkxJmj8h
 zO8rFEX58NgpOQBPw/6uysvxaKt/rotKglpgrtuVWwZQsZ7prcTxMkPFJTFEGHt0NCoQIVWn
 A/6gLeGDbl1uzMT3vXlfL5gtt/U=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiM2ZhNCIsICJrdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1IiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9819c3.7f7c1e9c5260-smtp-out-n02;
 Thu, 16 Apr 2020 08:39:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 28F91C433BA; Thu, 16 Apr 2020 08:39:31 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 94779C433F2;
 Thu, 16 Apr 2020 08:39:30 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 16 Apr 2020 14:09:30 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 0/8] Relax sanity checking for mismatched AArch32 EL1
In-Reply-To: <20200414213114.2378-1-will@kernel.org>
References: <20200414213114.2378-1-will@kernel.org>
Message-ID: <a86108a91975cacf94adc2a2101fba1b@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-Mailman-Approved-At: Thu, 16 Apr 2020 07:10:16 -0400
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com,
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

On 2020-04-15 03:01, Will Deacon wrote:
> Hi all,
> 
> For better or worse, there are SoCs in production where some, but not
> all of the CPUs, support AArch32 at EL1 and above. Right now, that
> results in "SANITY CHECK" warnings during boot and an unconditional
> kernel taint.
> 
> This patch series tries to do a bit better: the only time we care about
> AArch32 at EL1 is for KVM, so rather than throw our toys out of the
> pram, we can instead just disable support for 32-bit guests on these
> systems. In the unlikely scenario of a late CPU hotplug being the first
> time we notice that AArch32 is not available, then we fail the hotplug
> (right now we let the thing come online, which leads to hilarious
> results for any pre-existing 32-bit guests).
> 
> Feedback welcome,
> 
> Will
> 

Thanks Will, tested this series on QCOM SC7180 and SM8150 SoCs.

For the entire series,

Tested-by: saiprakash.ranjan@codeaurora.org

-Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
