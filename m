Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id C354024B03C
	for <lists+kvmarm@lfdr.de>; Thu, 20 Aug 2020 09:37:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D2B34B7A8;
	Thu, 20 Aug 2020 03:37:29 -0400 (EDT)
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
	with ESMTP id 6+hNj0OI3sqI; Thu, 20 Aug 2020 03:37:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 417934B7A5;
	Thu, 20 Aug 2020 03:37:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AE9A54B7A2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Aug 2020 03:37:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aTCkGdOa97Lw for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 Aug 2020 03:37:25 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id C1B864B797
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 Aug 2020 03:37:25 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 747D5207DE;
 Thu, 20 Aug 2020 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597909044;
 bh=argdKbSednZIqUaCnhWJ/yMeBGfc5QoU71Zy2RYOt84=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=zOnr852Ik4U8kZ3umPheqaGWulkIu3q6vL7syveggRIxY4TT9MZ7Lj+Uq2uTthkFM
 YvLxUxSaGDXiYXSPdAYZ9DQ3uhl4NFtUDu85czFql1mweGosF3IXY9yDzF6JtB6Hgh
 9UlGIXWwLD/inm2hMviSqGGMxx8syiCadwoo+c4I=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k8f8U-004RjE-Uw; Thu, 20 Aug 2020 08:37:23 +0100
MIME-Version: 1.0
Date: Thu, 20 Aug 2020 08:37:22 +0100
From: Marc Zyngier <maz@kernel.org>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH v2 1/2] KVM: arm64: Add PMU event filtering infrastructure
In-Reply-To: <0647b63c-ac27-8ec9-c9da-9a5e5163cb5d@amazon.com>
References: <20200309124837.19908-1-maz@kernel.org>
 <20200309124837.19908-2-maz@kernel.org>
 <70e712fc-6789-2384-c21c-d932b5e1a32f@redhat.com>
 <0027398587e8746a6a7459682330855f@kernel.org>
 <7c9e2e55-95c8-a212-e566-c48f5d3bc417@redhat.com>
 <470c88271ef8c4f92ecf990b7b86658e@kernel.org>
 <0647b63c-ac27-8ec9-c9da-9a5e5163cb5d@amazon.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <18b9ff6f9a65546f55dd2e7019d48986@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: graf@amazon.com, eric.auger@redhat.com, mark.rutland@arm.com,
 kvm@vger.kernel.org, suzuki.poulose@arm.com, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com,
 kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On 2020-08-19 00:24, Alexander Graf wrote:
> Hi Marc,

[...]

> I haven't seen a v3 follow-up after this. Do you happen to have that
> somewhere in a local branch and just need to send it out or would you
> prefer if I pick up v2 and address the comments?

I'll look into it.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
