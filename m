Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 446F8211E2F
	for <lists+kvmarm@lfdr.de>; Thu,  2 Jul 2020 10:23:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D67134B5A6;
	Thu,  2 Jul 2020 04:23:00 -0400 (EDT)
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
	with ESMTP id LDVzLn7Z+QHG; Thu,  2 Jul 2020 04:23:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C1C654B5C3;
	Thu,  2 Jul 2020 04:22:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D43BA4B5AC
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 04:22:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jd0Xvr5LO0PN for <kvmarm@lists.cs.columbia.edu>;
 Thu,  2 Jul 2020 04:22:56 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BAF694B5AA
 for <kvmarm@lists.cs.columbia.edu>; Thu,  2 Jul 2020 04:22:56 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E9C320874;
 Thu,  2 Jul 2020 08:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593678175;
 bh=pbs0tL/KRHo9Or+8WKf0S/Y8rnUfyyi5aMuo4ndjDb0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Uk4KAbidTKiBkRHckpKADLipXJTOreeNHvPrKb0/67ZecOH6IgOJjzNDBtWfmaXOG
 KBUxXgWmt2fdxdnW+sjvGjf3tbkPUnCPmPBVE2tPjGoOcPG+gnL67tX8o8kLujvEde
 oi5fWrU2KfcDFL147o//XX8GD29gNVVwbL56CLYY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jquUg-008JXG-8g; Thu, 02 Jul 2020 09:22:54 +0100
MIME-Version: 1.0
Date: Thu, 02 Jul 2020 09:22:54 +0100
From: Marc Zyngier <maz@kernel.org>
To: Jingyi Wang <wangjingyi11@huawei.com>
Subject: Re: [kvm-unit-tests PATCH v2 3/8] arm64: microbench: gic: Add gicv4.1
 support for ipi latency test.
In-Reply-To: <20200702030132.20252-4-wangjingyi11@huawei.com>
References: <20200702030132.20252-1-wangjingyi11@huawei.com>
 <20200702030132.20252-4-wangjingyi11@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <fe9699e3ee2131fe800911aea1425af4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangjingyi11@huawei.com, drjones@redhat.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
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

On 2020-07-02 04:01, Jingyi Wang wrote:
> If gicv4.1(sgi hardware injection) supported, we test ipi injection
> via hw/sw way separately.

nit: active-less SGIs are not strictly a feature of GICv4.1 (you could
imagine a GIC emulation offering the same thing). Furthermore, GICv4.1
isn't as such visible to the guest itself (it only sees a GICv3).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
