Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3851013931F
	for <lists+kvmarm@lfdr.de>; Mon, 13 Jan 2020 15:07:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C20484AEE4;
	Mon, 13 Jan 2020 09:07:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6dBXO9P2Uywv; Mon, 13 Jan 2020 09:07:38 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B76624AEF6;
	Mon, 13 Jan 2020 09:07:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id E66304AEF1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 09:07:36 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cUF163u1ZCyy for <kvmarm@lists.cs.columbia.edu>;
 Mon, 13 Jan 2020 09:07:35 -0500 (EST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CA4BB4AEE4
 for <kvmarm@lists.cs.columbia.edu>; Mon, 13 Jan 2020 09:07:35 -0500 (EST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 612991045;
 Mon, 13 Jan 2020 06:07:35 -0800 (PST)
Received: from [10.1.196.63] (e123195-lin.cambridge.arm.com [10.1.196.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA933F68E;
 Mon, 13 Jan 2020 06:07:34 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH] arm: expand the timer tests
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com
References: <20200110160511.17821-1-alex.bennee@linaro.org>
 <8455cdf6-e5c3-bd84-5b85-33ffad581d0e@arm.com>
Message-ID: <7be15e14-78c7-788f-7a9c-08e80bdb5600@arm.com>
Date: Mon, 13 Jan 2020 14:07:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8455cdf6-e5c3-bd84-5b85-33ffad581d0e@arm.com>
Content-Language: en-US
Cc: linux-arm-kernel@lists.infradead.org, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On 1/13/20 1:48 PM, Alexandru Elisei wrote:
> [..]
>> +	isb();
>> +	report(!gic_timer_pending(info), "not pending before UINT64_MAX (irqs on)");
> This check can be improved. You want to check the timer CTL.ISTATUS here, not the
> gic. A device (in this case, the timer) can assert the interrupt, but the gic does
> not sample it immediately. Come to think of it, the entire timer test is wrong
> because of this.

I'll write a patch for it in v4 of my fixes series.

Thanks,
Alex


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
