Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F63806F2
	for <lists+kvmarm@lfdr.de>; Fri, 14 May 2021 12:12:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7F43D4B96E;
	Fri, 14 May 2021 06:12:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.201
X-Spam-Level: 
X-Spam-Status: No, score=-4.201 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l78D+YogXLgF; Fri, 14 May 2021 06:12:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 67C6E4B96D;
	Fri, 14 May 2021 06:12:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D47B44B957
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 May 2021 06:12:08 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gipK6GajlfTY for <kvmarm@lists.cs.columbia.edu>;
 Fri, 14 May 2021 06:12:08 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 055CC4B94D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 14 May 2021 06:12:08 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3E80561457;
 Fri, 14 May 2021 10:12:06 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1lhUnc-001Mll-6A; Fri, 14 May 2021 11:12:04 +0100
MIME-Version: 1.0
Date: Fri, 14 May 2021 11:12:03 +0100
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] KVM: arm64: Mark the host stage-2 memory pools static
In-Reply-To: <20210514100941.GA3795@willie-the-truck>
References: <20210514085640.3917886-1-qperret@google.com>
 <20210514085640.3917886-3-qperret@google.com>
 <20210514100941.GA3795@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <8036c2e2e6c87849072d4189f9d2319a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, qperret@google.com,
 kvmarm@lists.cs.columbia.edu, kbuild-all@lists.01.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kbuild-all@lists.01.org, kvmarm@lists.cs.columbia.edu
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

On 2021-05-14 11:09, Will Deacon wrote:
> On Fri, May 14, 2021 at 08:56:40AM +0000, Quentin Perret wrote:
>> The host stage-2 memory pools are not used outside of mem_protect.c,
>> mark them static.
>> 
>> Fixes: 1025c8c0c6ac ("KVM: arm64: Wrap the host with a stage 2")
>> Reported-by: Reported-by: kernel test robot <lkp@intel.com>
> 
> ^^^ nit, but this tag has gone wonky.

Well spotted. I'll fix it locally, though the SHA1 will change...

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
