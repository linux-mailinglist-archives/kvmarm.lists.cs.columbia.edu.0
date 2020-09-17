Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC326D6ED
	for <lists+kvmarm@lfdr.de>; Thu, 17 Sep 2020 10:42:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BC82D4B825;
	Thu, 17 Sep 2020 04:42:14 -0400 (EDT)
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
	with ESMTP id 1krUQ+R+162z; Thu, 17 Sep 2020 04:42:14 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 810E74B80B;
	Thu, 17 Sep 2020 04:42:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BFE3B4B7F6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Sep 2020 04:42:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8mSenNojdywB for <kvmarm@lists.cs.columbia.edu>;
 Thu, 17 Sep 2020 04:42:10 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CD8484B7ED
 for <kvmarm@lists.cs.columbia.edu>; Thu, 17 Sep 2020 04:42:10 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A4D6320715;
 Thu, 17 Sep 2020 08:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600332129;
 bh=xvHmsYi72FfQp7h4dhc9TKL7dDuyhWbbpk0n+L/TqQc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mLQJkE7xWGtUGz4ww6BG2HNdY4SI+IylX+3ptQv2/i7icnEc9M3zuBRYI5LOZq/kx
 We/prQOF/s/elpkwpLclDNJtMMyRPPESBbcJlPRDmcHWbgfhzNXLjfOwYY3IxUf4HR
 lqcRQhnXUugIeGF8S7s1sr8nUra1X0yBRLipg2VQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kIpUV-00Ca1G-9P; Thu, 17 Sep 2020 09:42:07 +0100
MIME-Version: 1.0
Date: Thu, 17 Sep 2020 09:42:07 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 2/2] kvm/arm: Add mp_affinity for arm vcpu
In-Reply-To: <20200917080429.jimidzdtdskwhbdx@kamzik.brq.redhat.com>
References: <20200917023033.1337-1-fangying1@huawei.com>
 <20200917023033.1337-3-fangying1@huawei.com>
 <7a924b0fb27505a0d8b00389fe2f02df@kernel.org>
 <20200917080429.jimidzdtdskwhbdx@kamzik.brq.redhat.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <198c63d5e9e17ddb4c3848845891301c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: drjones@redhat.com, fangying1@huawei.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
 julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 zhang.zhanghailiang@huawei.com, alex.chen@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org, alex.chen@huawei.com,
 Ying Fang <fangying1@huawei.com>, kvmarm@lists.cs.columbia.edu
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

On 2020-09-17 09:04, Andrew Jones wrote:
> On Thu, Sep 17, 2020 at 08:47:42AM +0100, Marc Zyngier wrote:
>> On 2020-09-17 03:30, Ying Fang wrote:
>> > Allow userspace to set MPIDR using vcpu ioctl KVM_ARM_SET_MP_AFFINITY,
>> > so that we can support cpu topology for arm.
>> 
>> MPIDR has *nothing* to do with CPU topology in the ARM architecture.
>> I encourage you to have a look at the ARM ARM and find out how often
>> the word "topology" is used in conjunction with the MPIDR_EL1 
>> register.
>> 
> 
> Hi Marc,
> 
> I mostly agree. However, the CPU topology descriptions use MPIDR to
> identify PEs. If userspace wants to build topology descriptions then
> it either needs to
> 
> 1) build them after instantiating all KVM VCPUs in order to query KVM
>    for each MPIDR, or
> 2) have a way to ask KVM for an MPIDR of given VCPU ID in advance
>    (maybe just a scratch VCPU), or
> 3) have control over the MPIDRs so it can choose them when it likes,
>    use them for topology descriptions, and then instantiate KVM VCPUs
>    with them.
> 
> I think (3) is the most robust approach, and it has the least overhead.

I don't disagree with the goal, and not even with the choice of
implementation (though I have huge reservations about its quality).

But the key word here is *userspace*. Only userspace has a notion of
how MPIDR values map to the assumed topology. That's not something
that KVM does nor should interpret (aside from the GIC-induced Aff0
brain-damage). So talking of "topology" in a KVM kernel patch sends
the wrong message, and that's all this remark was about.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
