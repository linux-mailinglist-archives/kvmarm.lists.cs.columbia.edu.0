Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B16F7305E6B
	for <lists+kvmarm@lfdr.de>; Wed, 27 Jan 2021 15:35:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 447F74B290;
	Wed, 27 Jan 2021 09:35:32 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wowFXioePYWP; Wed, 27 Jan 2021 09:35:32 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2AC034B225;
	Wed, 27 Jan 2021 09:35:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C4F064B208
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jan 2021 09:35:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1GMa6lWoLUJW for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Jan 2021 09:35:27 -0500 (EST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1F4934B1DB
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Jan 2021 09:35:27 -0500 (EST)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D62F7207C4;
 Wed, 27 Jan 2021 14:35:25 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94)
 (envelope-from <maz@kernel.org>)
 id 1l4lul-00AOQ3-Dz; Wed, 27 Jan 2021 14:35:23 +0000
MIME-Version: 1.0
Date: Wed, 27 Jan 2021 14:35:23 +0000
From: Marc Zyngier <maz@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v2 6/7] KVM: arm64: Upgrade PMU support to ARMv8.4
In-Reply-To: <59700102-5340-b5ec-28e2-d95ee3e59c6b@arm.com>
References: <20210125122638.2947058-1-maz@kernel.org>
 <20210125122638.2947058-7-maz@kernel.org>
 <59700102-5340-b5ec-28e2-d95ee3e59c6b@arm.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <1b594e7b1f47e372ea84f759507db0b9@kernel.org>
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

Hi Alex,

On 2021-01-27 14:09, Alexandru Elisei wrote:
> Hi Marc,
> 
> On 1/25/21 12:26 PM, Marc Zyngier wrote:
>> Upgrading the PMU code from ARMv8.1 to ARMv8.4 turns out to be
>> pretty easy. All that is required is support for PMMIR_EL1, which
>> is read-only, and for which returning 0 is a valid option as long
>> as we don't advertise STALL_SLOT as an implemented event.
> 
> According to ARM DDI 0487F.b, page D7-2743:
> 
> "If ARMv8.4-PMU is implemented:
> - If STALL_SLOT is not implemented, it is IMPLEMENTATION DEFINED
> whether the PMMIR
> System registers are implemented.
> - If STALL_SLOT is implemented, then the PMMIR System registers are
> implemented."
> 
> I tried to come up with a reason why PMMIR is emulated instead of being 
> left
> undefined, but I couldn't figure it out. Would you mind adding a 
> comment or
> changing the commit message to explain that?

The main reason is that PMMIR gets new fields down the line,
and doing the bare minimum in term of implementation allows
us to gently ease into it.

We could also go for the full PMMIR reporting on homogeneous
systems too, as a further improvement.

What do you think?

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
