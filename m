Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A63061E5
	for <lists+kvmarm@lfdr.de>; Wed, 27 Jan 2021 18:23:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2236C4B324;
	Wed, 27 Jan 2021 12:23:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VjNFyJKpKoB4; Wed, 27 Jan 2021 12:23:59 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D9F254B323;
	Wed, 27 Jan 2021 12:23:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D751B4B312
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jan 2021 12:23:55 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id safqXpvITHiQ for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Jan 2021 12:23:54 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A6F234B29C
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jan 2021 12:23:54 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62CD064DA0;
 Wed, 27 Jan 2021 17:23:53 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l4oXn-00AQmI-8F; Wed, 27 Jan 2021 17:23:51 +0000
MIME-Version: 1.0
Date: Wed, 27 Jan 2021 17:23:50 +0000
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v2 6/7] KVM: arm64: Upgrade PMU support to ARMv8.4
In-Reply-To: <cd3d33ff-6217-6a7f-3110-fe728d6c11be@arm.com>
References: <20210125122638.2947058-1-maz@kernel.org>
 <20210125122638.2947058-7-maz@kernel.org>
 <59700102-5340-b5ec-28e2-d95ee3e59c6b@arm.com>
 <1b594e7b1f47e372ea84f759507db0b9@kernel.org>
 <cd3d33ff-6217-6a7f-3110-fe728d6c11be@arm.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <54926337c1779a492f94f57ee63e5c69@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alexandru.elisei@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
 suzuki.poulose@arm.com, eric.auger@redhat.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-team@android.com, kvmarm@lists.cs.columbia.edu
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

On 2021-01-27 17:00, Alexandru Elisei wrote:
> Hi Marc,
> 
> On 1/27/21 2:35 PM, Marc Zyngier wrote:
>> Hi Alex,
>> 
>> On 2021-01-27 14:09, Alexandru Elisei wrote:
>>> Hi Marc,
>>> 
>>> On 1/25/21 12:26 PM, Marc Zyngier wrote:
>>>> Upgrading the PMU code from ARMv8.1 to ARMv8.4 turns out to be
>>>> pretty easy. All that is required is support for PMMIR_EL1, which
>>>> is read-only, and for which returning 0 is a valid option as long
>>>> as we don't advertise STALL_SLOT as an implemented event.
>>> 
>>> According to ARM DDI 0487F.b, page D7-2743:
>>> 
>>> "If ARMv8.4-PMU is implemented:
>>> - If STALL_SLOT is not implemented, it is IMPLEMENTATION DEFINED
>>> whether the PMMIR
>>> System registers are implemented.
>>> - If STALL_SLOT is implemented, then the PMMIR System registers are
>>> implemented."
>>> 
>>> I tried to come up with a reason why PMMIR is emulated instead of 
>>> being left
>>> undefined, but I couldn't figure it out. Would you mind adding a 
>>> comment or
>>> changing the commit message to explain that?
>> 
>> The main reason is that PMMIR gets new fields down the line,
>> and doing the bare minimum in term of implementation allows
>> us to gently ease into it.
> I think I understand what you are saying - add a bare minimum emulation 
> of the
> PMMIR register now so it's less work when we do decide to support the 
> STALL_SLOT
> event for a guest.
>> 
>> We could also go for the full PMMIR reporting on homogeneous
>> systems too, as a further improvement.
>> 
>> What do you think?
> 
> I don't have an opinion either way. But if you do decide to add full
> emulation for
> STALL_SLOT, I would like to help with reviewing the patches (I'm 
> curious to see
> how KVM will detect that it's running on a homogeneous system).

I'm not sure we can *detect* it. We'd need some more information
from the core arch code and firmware. To be honest, PMU emulation
is a joke on BL, so maybe we shouldn't really care and expose
what we have.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
