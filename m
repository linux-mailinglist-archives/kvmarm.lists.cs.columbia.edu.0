Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B10A824D5AE
	for <lists+kvmarm@lfdr.de>; Fri, 21 Aug 2020 15:04:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 41E964C2BE;
	Fri, 21 Aug 2020 09:04:06 -0400 (EDT)
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
	with ESMTP id 6v4QWtl56Zia; Fri, 21 Aug 2020 09:04:06 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EC02E4C226;
	Fri, 21 Aug 2020 09:04:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1701C4B429
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Aug 2020 09:04:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZagLZFbJzVjd for <kvmarm@lists.cs.columbia.edu>;
 Fri, 21 Aug 2020 09:04:02 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id AF52E4B457
 for <kvmarm@lists.cs.columbia.edu>; Fri, 21 Aug 2020 09:04:02 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F875207BB;
 Fri, 21 Aug 2020 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598015041;
 bh=DeoU78c4cCMt4c0DHxrKqY/OoGbtGgM/fQoFevJ5aMk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=neW4qDo7Ci/DSqpkZHHrVNEafyyrQuQIkuO48DXFaDnBdYpYwAuK35iTl7G5iXM4q
 ixA+pWThuS2zwmTkMck0XVeE/LLnQRuzKEil8W3+dA8aK/AO1JpYMNVs5E/4vDjn5F
 S2KdxqBvkJ9bmUxfZ/F70sbUOnFCIP0ijtMxtA6Y=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k96i8-004rqt-7c; Fri, 21 Aug 2020 14:04:00 +0100
MIME-Version: 1.0
Date: Fri, 21 Aug 2020 14:04:00 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>, pbonzini@redhat.com
Subject: Re: [PATCH v2 0/6] KVM: arm64: pvtime: Fixes and a new cap
In-Reply-To: <20200819125026.fsbzvim74qp7sene@kamzik.brq.redhat.com>
References: <20200804170604.42662-1-drjones@redhat.com>
 <20200819125026.fsbzvim74qp7sene@kamzik.brq.redhat.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <c09b29a336cca62f9822c59fcacb207d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: drjones@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, steven.price@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, steven.price@arm.com
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

On 2020-08-19 13:50, Andrew Jones wrote:
> On Tue, Aug 04, 2020 at 07:05:58PM +0200, Andrew Jones wrote:
>> v2:
>>   - ARM_SMCCC_HV_PV_TIME_FEATURES now also returns 
>> SMCCC_RET_NOT_SUPPORTED
>>     when steal time is not supported
>>   - Added READ_ONCE() for the run_delay read
>>   - Reworked kvm_put/get_guest to not require type as a parameter
>>   - Added some more text to the documentation for KVM_CAP_STEAL_TIME
>>   - Enough changed that I didn't pick up Steven's r-b's
>> 
>> 
>> The first four patches in the series are fixes that come from testing
>> and reviewing pvtime code while writing the QEMU support[*]. The last
>> patch is only a convenience for userspace, and I wouldn't be 
>> heartbroken
>> if it wasn't deemed worth it. The QEMU patches are currently written
>> without the cap. However, if the cap is accepted, then I'll change the
>> QEMU code to use it.
>> 
>> Thanks,
>> drew
>> 
>> [*] 
>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg03856.html
>>     (a v2 of this series will also be posted shortly)
>> 
>> Andrew Jones (6):
>>   KVM: arm64: pvtime: steal-time is only supported when configured
>>   KVM: arm64: pvtime: Fix potential loss of stolen time
>>   KVM: arm64: Drop type input from kvm_put_guest
>>   KVM: arm64: pvtime: Fix stolen time accounting across migration
>>   KVM: Documentation: Minor fixups
>>   arm64/x86: KVM: Introduce steal-time cap
>> 
>>  Documentation/virt/kvm/api.rst    | 22 ++++++++++++++++++----
>>  arch/arm64/include/asm/kvm_host.h |  2 +-
>>  arch/arm64/kvm/arm.c              |  3 +++
>>  arch/arm64/kvm/pvtime.c           | 29 +++++++++++++----------------
>>  arch/x86/kvm/x86.c                |  3 +++
>>  include/linux/kvm_host.h          | 31 
>> ++++++++++++++++++++++++++-----
>>  include/uapi/linux/kvm.h          |  1 +
>>  7 files changed, 65 insertions(+), 26 deletions(-)
>> 
>> --
>> 2.25.4
>> 
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm@lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>> 
> 
> Hi Marc,
> 
> Gentle ping. I'd like to to switch the QEMU code to using the proposed
> KVM cap, if the cap is accepted.

I'm fine with it. To be honest, this series is mostly fixes, except
for that last patch.

Paolo, are you OK with me sending the whole thing as fixes, including
the UAPI patch? At least we'd have something consistent for 5.9.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
