Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 641D1298EDF
	for <lists+kvmarm@lfdr.de>; Mon, 26 Oct 2020 15:08:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F090A4B389;
	Mon, 26 Oct 2020 10:08:42 -0400 (EDT)
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
	with ESMTP id n0eC34rIf6tC; Mon, 26 Oct 2020 10:08:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 966504B4E6;
	Mon, 26 Oct 2020 10:08:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AC724B396
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 10:08:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDpouJEgf6xr for <kvmarm@lists.cs.columbia.edu>;
 Mon, 26 Oct 2020 10:08:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7A7D14B389
 for <kvmarm@lists.cs.columbia.edu>; Mon, 26 Oct 2020 10:08:39 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3405F2242A;
 Mon, 26 Oct 2020 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603721318;
 bh=piPyVG4naoRlpa5Gf3UOt8KiGpTMaw7CwHneYKoEims=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=P4Dfr9oOop2NEpcLIejN6byw2vAQtq2F3IQ3NfTLPnTq5m2Rk5j+r4T/EJ8jUek+J
 eGJ9/CXQG7VRoEvBtjYDQ5AdPd9pPZFhMNOXyItxICFcdliZFFSXWv2HNeZfHW5bo1
 U1ZFlbClUSGIXji/cpUxk8ArIMPUIMCLzyo4NPnY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1kX3Aq-004LSu-3z; Mon, 26 Oct 2020 14:08:36 +0000
MIME-Version: 1.0
Date: Mon, 26 Oct 2020 14:08:35 +0000
From: Marc Zyngier <maz@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 01/11] KVM: arm64: Don't adjust PC on SError during SMC
 trap
In-Reply-To: <20201026135308.GC12454@C02TD0UTHF1T.local>
References: <20201026133450.73304-1-maz@kernel.org>
 <20201026133450.73304-2-maz@kernel.org>
 <20201026135308.GC12454@C02TD0UTHF1T.local>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b85f3ed6b97944055eda7f4bfeae8abc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, kernel-team@android.com,
 will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org
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

On 2020-10-26 13:53, Mark Rutland wrote:
> On Mon, Oct 26, 2020 at 01:34:40PM +0000, Marc Zyngier wrote:
>> On SMC trap, the prefered return address is set to that of the SMC
>> instruction itself. It is thus wrong to tyr and roll it back when
> 
> Typo: s/tyr/try/
> 
>> an SError occurs while trapping on SMC. It is still necessary on
>> HVC though, as HVC doesn't cause a trap, and sets ELR to returning
>> *after* the HVC.
>> 
>> It also became apparent that the is 16bit encoding for an AArch32
> 
> I guess s/that the is/that there is no/ ?

Something along these lines, yes! ;-)

> 
>> HVC instruction, meaning that the displacement is always 4 bytes,
>> no matter what the ISA is. Take this opportunity to simplify it.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Assuming that there is no 16-bit HVC:

It is actually impossible to have a 16bit encoding for HVC, as
it always convey a 16bit immediate, and you need some space
to encode the instruction itself!

> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
