Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 17E7E1C949E
	for <lists+kvmarm@lfdr.de>; Thu,  7 May 2020 17:16:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 986144B3E4;
	Thu,  7 May 2020 11:16:00 -0400 (EDT)
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
	with ESMTP id I3IM1pX8SR9I; Thu,  7 May 2020 11:16:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7364F4B3D8;
	Thu,  7 May 2020 11:15:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DD13F4B35C
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 11:15:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E8weyB68JlbY for <kvmarm@lists.cs.columbia.edu>;
 Thu,  7 May 2020 11:15:58 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E810B4B274
 for <kvmarm@lists.cs.columbia.edu>; Thu,  7 May 2020 11:15:57 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D392B207DD;
 Thu,  7 May 2020 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588864557;
 bh=ux/WK4BgpiCCy4diPu3bKfY8AWDQXyNVDGkRY8G5x9M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=zudqrwOEUY4DrnXjGQ98u/M9JwOEVc2mYKgd2qyD6usz0b0wVhGN/ItZFzVXLo0R7
 bP62RQIzzwzc3uL2VJdZi2SHW+rxNi7LR0aaVg4gaXWAOjCUwANHAFCk9luv2am+7G
 +BzQ4FAUUMp2mZIeSATcsMXvjbtawZA3Rrhf9u5k=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jWiFf-00AJoN-6T; Thu, 07 May 2020 16:15:55 +0100
MIME-Version: 1.0
Date: Thu, 07 May 2020 16:15:55 +0100
From: Marc Zyngier <maz@kernel.org>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH 05/15] arm64: kvm: Build hyp-entry.S separately for
 VHE/nVHE
In-Reply-To: <87imh72379.wl-maz@kernel.org>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-6-dbrazdil@google.com> <87imh72379.wl-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <df5bf1943851715130517c43fde8e5a9@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, suzuki.poulose@arm.com,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-05-07 16:07, Marc Zyngier wrote:
> On Thu, 30 Apr 2020 15:48:21 +0100,
> David Brazdil <dbrazdil@google.com> wrote:

[...]

>> hyp-entry.S contains implementation of KVM hyp vectors. This code is 
>> mostly
>> shared between VHE/nVHE, therefore compile it under both VHE and nVHE 
>> build
>> rules, with small differences hidden behind '#ifdef __HYPERVISOR__'. 
>> These are:
>>   * only nVHE should handle host HVCs, VHE will now panic,
> 
> That's not true. VHE does handle HVCs from the guest. If you make VHE
> panic on guest exit, I'll come after you! ;-)

Duh, I can't read. "host HVCs". You can relax. ;-)

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
