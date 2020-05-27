Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70E1E3A3F
	for <lists+kvmarm@lfdr.de>; Wed, 27 May 2020 09:20:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E3E914B1EC;
	Wed, 27 May 2020 03:20:51 -0400 (EDT)
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
	with ESMTP id Q532vfS3EVHr; Wed, 27 May 2020 03:20:51 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B63B84B1C2;
	Wed, 27 May 2020 03:20:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D05D04B193
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 May 2020 03:20:49 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D-pn9yigfd0H for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 May 2020 03:20:48 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A9BFE4B17B
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 May 2020 03:20:48 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A6AF20C56;
 Wed, 27 May 2020 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590564047;
 bh=xe0XCZfpz88ojVoEgE66/wE6fHWWqAyThRQDs0+/Qqs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WABS5Dro923F6hOOT4JBJX+vEWtTfPyhmyPMpL17+pe7WBLFPyN1uqVWT8Yn2Efr9
 DBxfD2NPeacMwXgyDSaPXEiU3Hu3ZK2XxKea8S1z3IvQOKtyQtZm3BNal+JZ+UjWof
 n4fDU940Js3kYZ7JYZ7CjmuUcxWBu3JqG9D+mJQQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jdqMn-00Fcxl-OC; Wed, 27 May 2020 08:20:45 +0100
MIME-Version: 1.0
Date: Wed, 27 May 2020 08:20:45 +0100
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 3/9] kvm/arm64: Rename kvm_vcpu_get_hsr() to
 kvm_vcpu_get_esr()
In-Reply-To: <2e4dd03f-656a-c32b-5e87-ca28583999ef@redhat.com>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-4-gshan@redhat.com>
 <20200526104249.GB1363@C02TD0UTHF1T.local>
 <2e4dd03f-656a-c32b-5e87-ca28583999ef@redhat.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <359dad5546a428ea963781f2728e70bf@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gshan@redhat.com, mark.rutland@arm.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 james.morse@arm.com, suzuki.poulose@arm.com, drjones@redhat.com,
 eric.auger@redhat.com, aarcange@redhat.com, shan.gavin@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu,
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

On 2020-05-27 03:43, Gavin Shan wrote:
> Hi Mark,
> 
> On 5/26/20 8:42 PM, Mark Rutland wrote:
>> On Fri, May 08, 2020 at 01:29:13PM +1000, Gavin Shan wrote:
>>> Since kvm/arm32 was removed, this renames kvm_vcpu_get_hsr() to
>>> kvm_vcpu_get_esr() to it a bit more self-explaining because the
>>> functions returns ESR instead of HSR on aarch64. This shouldn't
>>> cause any functional changes.
>>> 
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> 
>> I think that this would be a nice cleanup on its own, and could be 
>> taken
>> independently of the rest of this series if it were rebased and sent 
>> as
>> a single patch.
>> 
> 
> Yeah, I'll see how PATCH[3,4,5] can be posted independently
> as part of the preparatory work, which is suggested by you
> in another reply.
> 
> By the way, I assume the cleanup patches are good enough to
> target 5.8.rc1/rc2 if you agree.

It's fine to base them on -rc1 or -rc2. They will not be merged
before 5.9 though.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
